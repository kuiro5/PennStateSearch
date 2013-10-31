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
#import "jjkAddBuildingViewController.h"

@interface jjkBuildingViewController () <BuildingDelegate>
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchBar;

@property (nonatomic,assign) BOOL showingBuildingsPhotos;
@property (nonatomic,strong) jjkBuildingInfoViewController *detailViewController;
@property (nonatomic,strong) DataSource *dataSource;
@property(strong,nonatomic)NSString *pictureName;
@property (nonatomic,strong) MyDataManager *myDataManager;

//search Bar info for Search Display Controller
@property (nonatomic,strong) NSString *searchString;
@property NSInteger searchOption;
@end
 
@implementation jjkBuildingViewController 


-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
   // NSLog(@"InitWithCoder");
    if (self)
    {
        _myDataManager = [[MyDataManager alloc] init];
        _dataSource = [[DataSource alloc] initForEntity:@"Building" sortKeys:@[@"name"] predicate:nil sectionNameKeyPath:@"firstLetterOfName" dataManagerDelegate:_myDataManager];
        
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
    //NSLog(@"ViewDidLoad");
    
    self.pictureName = @"";
    self.tableView.dataSource = self.dataSource;
    //self.dataSource.tableView = self.tableView;
    
    self.navigationItem.rightBarButtonItems = @[self.navigationItem.rightBarButtonItem, self.editButtonItem];
    
    // The following 3 lines of code support the Search Display Controller
    // the Search Display Controller will use the same data source
    self.searchDisplayController.searchResultsDataSource = self.dataSource;
    
    // set the scope buttons
    self.searchDisplayController.searchBar.scopeButtonTitles = @[@"All", @"One Word", @"Two Words"];
    
    // hide search bar
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    [self.model displayBuildings];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //NSLog(@"ViewWillAppear");
    //self.dataSource.tableView = self.tableView;
    [self.tableView reloadData];
    
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
    return YES;
}

#pragma mark - editing
-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    [self.tableView reloadData];
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
    else if ([segue.identifier isEqualToString:@"AddBuildingSegue"])
    {
        jjkAddBuildingViewController *addBuildingViewController = segue.destinationViewController;
        addBuildingViewController.completionBlock = ^(id obj) {
        [self dismissViewControllerAnimated:YES completion:NULL];
        if (obj) {
            
            
            NSDictionary *dictionary = obj;
            [self.myDataManager addBuilding:dictionary];
            //[self.tableView reloadData];
            //self.dataSource.tableView = self.tableView;
        }
    };
}

}

#pragma mark - Search Display Controller Delegate Methods
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    // remember the current search string and filter the search results
    self.searchString = searchString;
    [self filterSearch];
    
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // remember the current search option and filter the search results
    self.searchOption = searchOption;
    [self filterSearch];
    return YES;
}

// construct the appropriate predicate based on the search string and search option (scope)
// then update data source using predicate
-(void)filterSearch {
    
    NSString *searchPredicateString;
    if (self.searchString.length>0) {
        searchPredicateString = [NSString stringWithFormat:@"name contains '%@'", self.searchString];
    } else {
        searchPredicateString = @"name contains ''";
    }
    
    NSString *search;
    switch (self.searchOption) {
        case 0:
            search = searchPredicateString;
            break;
        case 1:
            search = [NSString stringWithFormat:@"%@ && !(name contains ' ')", searchPredicateString];
            break;
        default:
            search = [NSString stringWithFormat:@"%@ && (name contains ' ')", searchPredicateString];
            break;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:search];
    [self.dataSource updateWithPredicate:predicate];
    
}

// when we begin searching we switch tableViews
-(void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller {
    self.dataSource.tableView = controller.searchResultsTableView;
}

// when we end searching we switch tableViews back to default
-(void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller {
    self.dataSource.tableView = self.tableView;
}

#pragma mark - Search Bar Delegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.dataSource updateWithPredicate:nil];
    [self.tableView reloadData];
}

@end
