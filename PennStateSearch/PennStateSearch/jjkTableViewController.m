//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import "jjkTableViewController.h"
#import "jjkDetailedInfoViewController.h"

#define numberOfSections 1

@interface jjkTableViewController () <InfoDelegate>
@property (weak, nonatomic) IBOutlet UITableView *resultsTableView;
@end

@implementation jjkTableViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
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
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self)
    {
        [[[self tabBarController] navigationItem] setTitle:@"Search Results"];
        
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
    return [self.model numberOfResults];
}

- (NSIndexPath *)selectedRow
{
    NSIndexPath *indexPath = [self.resultsTableView indexPathForSelectedRow];
    
    NSLog(@"clicked %d", indexPath.row);
    
    return indexPath;
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath          
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = [self.model nameAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model addressAtIndex:indexPath.row];
    
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InfoSegue"])
    {
        jjkDetailedInfoViewController *detailedInfoViewControler = segue.destinationViewController;
        detailedInfoViewControler.model = self.model;
    }
    
}


@end
