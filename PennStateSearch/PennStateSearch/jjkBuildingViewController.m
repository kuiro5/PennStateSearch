//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 6
// Date: October 10, 2013
//

#import "jjkBuildingViewController.h"
#import "jjkBuildingPhotoViewController.h"
#import "jjkConstants.h"
#import "jjkOptionsViewController.h"
#define numberOfSections 1

@interface jjkBuildingViewController () <BuildingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *buildingTableView;
@property (nonatomic,assign) BOOL showingBuildingsPhotos;

@property(strong,nonatomic)NSString *pictureName;

@end
 
@implementation jjkBuildingViewController 

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _model = [[Model alloc] init];
    }
    return self;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pictureName = @"";

    [self.model displayBuildings];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:buildingsWithPhotos];
    self.showingBuildingsPhotos = [boolNumber boolValue];
  
    
    
    [self.buildingTableView reloadData];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self)
    {
        [[[self tabBarController] navigationItem] setTitle:@"PSU Buildlings"];
        [self.buildingTableView deselectRowAtIndexPath:[self.buildingTableView indexPathForSelectedRow] animated:YES];
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return numberOfSections;
}


-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.showingBuildingsPhotos)
    {
        return [self.model numberOfBuildingsWithPhotos];
    }
    else
    {
        return [self.model numberOfBuildings];
    }
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{

    UITableViewCell *cell = nil;
    static NSString *CellIdentifier = @"BuildingCell";

    
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    if(self.showingBuildingsPhotos)
    {
        
            cell.textLabel.text = [self.model photoBuildingNameAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.model photoBuildingOppCodeAtIndex:indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
            
        
    }
    else if(!self.showingBuildingsPhotos)
    {
        
        self.pictureName = [self.model buildingPictureAtIndex:indexPath.row];
        cell.textLabel.text = [self.model buildingNameAtIndex:indexPath.row];
        cell.detailTextLabel.text = [self.model buildingOppCodeAtIndex:indexPath.row];
        
        if([self.pictureName length] == 0)
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = NO;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
            
        }
    }
    return cell;
}

- (NSIndexPath *)buildingRowSelected
{
    NSIndexPath *indexPath = [self.buildingTableView indexPathForSelectedRow];
    
    return indexPath;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"BuildingSegue"])
    {
        jjkBuildingPhotoViewController *buildingInfoViewController = segue.destinationViewController;
        buildingInfoViewController.model = self.model;
        buildingInfoViewController.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"OptionsSegue"])
    {
        jjkOptionsViewController *optionsViewController = segue.destinationViewController;
        optionsViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
    
}








@end
