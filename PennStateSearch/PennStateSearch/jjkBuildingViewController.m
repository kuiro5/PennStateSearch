//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import "jjkBuildingViewController.h"
#import "jjkBuildingPhotoViewController.h"
#import "jjkConstants.h"
#import "jjkOptionsViewController.h"
#import "jjkBuildingInfoViewController.h"
#import "DataManager.h"
#import "Building.h"
#import "DataSource.h"
#import "MyDataManager.h"

@interface jjkBuildingViewController () <BuildingDelegate>

@property (nonatomic,assign) BOOL showingBuildingsPhotos;
@property (nonatomic,strong) jjkBuildingInfoViewController *detailViewController;
@property (nonatomic,strong) DataSource *dataSource;
@property(strong,nonatomic)NSString *pictureName;

@end
 
@implementation jjkBuildingViewController 


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
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
    
    
    if(self.showingBuildingsPhotos)
    {
        cell.textLabel.text = building.name;
        NSString *tempString = [NSString stringWithFormat:@"%@", building.year_constructed];
     
        if(![tempString isEqualToString: @"0"])                     // display year_constructed if it exists
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
        
        if(![tempString isEqualToString: @"0"])                     // display year_constructed if it exists
        {
            cell.detailTextLabel.text = tempString;
        }
        else
        {
            cell.detailTextLabel.text = @"";
        }
       // if([self.pictureName length] == 0)
        //{
          //  cell.accessoryType = UITableViewCellAccessoryNone;
            //cell.userInteractionEnabled = NO;
        //}
        //else
        //{
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.userInteractionEnabled = YES;
            
        //}
    }
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


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
    
    
    if ([segue.identifier isEqualToString:@"InfoSegue"])
    {
        jjkBuildingInfoViewController *buildingInfoViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        __block Building *building = [self.dataSource objectAtIndexPath:indexPath];
        
        buildingInfoViewController.title = building.name;
        buildingInfoViewController.buildingPhoto = [[UIImage alloc] initWithData:building.photo];
        buildingInfoViewController.infoString = building.info;
        
            buildingInfoViewController.completionBlock = ^(id obj){
            NSString *newInfo = obj;
            building.info = newInfo;
            [[DataManager sharedInstance] saveContext];
        };
        
        
        //_dataSource.delegate = self;
        
    }
    else if([segue.identifier isEqualToString:@"OptionsSegue"])
    {
        jjkOptionsViewController *optionsViewController = segue.destinationViewController;
        optionsViewController.CompletionBlock = ^{[self dismissViewControllerAnimated:YES completion:NULL];};
    }
}

@end
