//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 7
// Date: October 17, 2013
//

#import "jjkBuildingViewController.h"
#import "jjkBuildingPhotoViewController.h"
#import "jjkConstants.h"
#import "jjkOptionsViewController.h"
#import "Building.h"
#import "DataSource.h"
#import "MyDataManager.h"

#define numberOfSections 1

@interface jjkBuildingViewController () <BuildingDelegate>

//@property (weak, nonatomic) IBOutlet UITableView *buildingTableView;
@property (nonatomic,assign) BOOL showingBuildingsPhotos;
@property (nonatomic,strong) DataSource *dataSource;
@property(strong,nonatomic)NSString *pictureName;

@end
 
@implementation jjkBuildingViewController 

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //_model = [[Model alloc] init];
        MyDataManager *myDataManger = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:myDataManger];
        
        _dataSource.delegate = self;

    }
    return self;
}




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pictureName = @"";

    
    self.tableView.dataSource = self.dataSource;
    
    [self.model displayBuildings];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:buildingsWithPhotos];
    self.showingBuildingsPhotos = [boolNumber boolValue];
    
    
    if(self.showingBuildingsPhotos)
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"photo != nil"];
        [self.dataSource updateWithPredicate:predicate];
        
    }
    else if(!self.showingBuildingsPhotos)
    {
        [self.dataSource updateWithPredicate:nil]; 
    }
    
  
    [self.tableView reloadData];
}


#pragma mark - Data Source Cell Configurer

-(NSString*)cellIdentifierForObject:(id)object
{
    return @"BuildingCell";
}

-(void)configureCell:(UITableViewCell *)cell withObject:(id)object
{
    Building *building = object;
    
    NSLog(@"configure cell");
    
    
    if(self.showingBuildingsPhotos)
    {

        
        
        cell.textLabel.text = building.name;
        NSString *tempString = [NSString stringWithFormat:@"%@", building.year_constructed];
        if(![tempString isEqualToString: @"0"])
        {
            cell.detailTextLabel.text = tempString;
        }
        else
        {
            cell.detailTextLabel.text = @"";
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.userInteractionEnabled = YES;
        
        
    }
    else if(!self.showingBuildingsPhotos)
    {
        
        self.pictureName = building.photoName;
        cell.textLabel.text = building.name;
        
        NSString *tempString = [NSString stringWithFormat:@"%@", building.year_constructed];
        
        if(![tempString isEqualToString: @"0"])
        {
            cell.detailTextLabel.text = tempString;
        }
        else
        {
            cell.detailTextLabel.text = @"";
        }
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

    
    
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}


//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    if(self)
//    {
//     //   [[[self tabBarController] navigationItem] setTitle:@"PSU Buildlings"];
//     //   [self.buildingTableView deselectRowAtIndexPath:[self.buildingTableView indexPathForSelectedRow] animated:YES];
//        
//    }
//}
//
//
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//}
//

//-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
//{
//    return numberOfSections;
//}
//
//
//-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if(self.showingBuildingsPhotos)
//    {
//        return [self.model numberOfBuildingsWithPhotos];
//    }
//    else
//    {
//        return [self.model numberOfBuildings];
//    }
//}
//
//-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//
//    UITableViewCell *cell = nil;
//    static NSString *CellIdentifier = @"BuildingCell";
//    
//    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if(cell == nil)
//    {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//        
//    }
//    
//    
//    if(self.showingBuildingsPhotos)
//    {
//        
//            cell.textLabel.text = [self.model photoBuildingNameAtIndex:indexPath.row];
//            cell.detailTextLabel.text = [self.model photoBuildingOppCodeAtIndex:indexPath.row];
//            
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.userInteractionEnabled = YES;
//            
//        
//    }
//    else if(!self.showingBuildingsPhotos)
//    {
//        
//        self.pictureName = [self.model buildingPictureAtIndex:indexPath.row];
//        cell.textLabel.text = [self.model buildingNameAtIndex:indexPath.row];
//        cell.detailTextLabel.text = [self.model buildingOppCodeAtIndex:indexPath.row];
//        
//        if([self.pictureName length] == 0)
//        {
//            cell.accessoryType = UITableViewCellAccessoryNone;
//            cell.userInteractionEnabled = NO;
//        }
//        else
//        {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            cell.userInteractionEnabled = YES;
//            
//        }
//    }
//    return cell;
//}

- (NSIndexPath *)buildingRowSelected
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"BuildingSegue"])
    {
        jjkBuildingPhotoViewController *buildingInfoViewController = segue.destinationViewController;
//        buildingInfoViewController.model = self.model;
//          buildingInfoViewController.delegate = self;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Building *building = [self.dataSource objectAtIndexPath:indexPath];
        
        buildingInfoViewController.title = building.name;
        buildingInfoViewController.buildingPhoto = [[UIImage alloc] initWithData:building.photo];
        _dataSource.delegate = self; 
        
    }
    else if([segue.identifier isEqualToString:@"OptionsSegue"])
    {
        jjkOptionsViewController *optionsViewController = segue.destinationViewController;
        optionsViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
    
}

@end
