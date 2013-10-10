//
//  jjkBuildingViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/7/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkBuildingViewController.h"
#import "jjkBuildingPhotoViewController.h"
#define numberOfSections 1

@interface jjkBuildingViewController () <BuildingDelegate>
@property (weak, nonatomic) IBOutlet UITableView *buildingTableView;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self)
    {
        [[[self tabBarController] navigationItem] setTitle:@"PSU Buildling Directory"];
        
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
    return [self.model numberOfBuildings];
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"BuildingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [self.model buildingNameAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model buildingOppCodeAtIndex:indexPath.row];
    self.pictureName = [self.model buildingPictureAtIndex:indexPath.row];
    
   
    
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
    
    
    return cell;
    
}

- (NSIndexPath *)buildingRowSelected
{
    NSIndexPath *indexPath = [self.buildingTableView indexPathForSelectedRow];
    
    NSLog(@"clicked %d", indexPath.row);
    
    return indexPath;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BuildingSegue"])
    {
        jjkBuildingPhotoViewController *buildingInfoViewController = segue.destinationViewController;
        buildingInfoViewController.model = self.model;
        buildingInfoViewController.delegate = self;
    }
    
}








@end
