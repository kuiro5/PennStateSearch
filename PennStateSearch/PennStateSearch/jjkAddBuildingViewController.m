//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import "jjkAddBuildingViewController.h"

@interface jjkAddBuildingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *buildingNameTextField;
- (IBAction)saveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *yearConstructedTextField;

@end

@implementation jjkAddBuildingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}



- (IBAction)saveButtonPressed:(id)sender
{
    NSDictionary *dictionary = @{@"name":self.buildingNameTextField.text, @"year_constructed":self.yearConstructedTextField.text};
    
    if([self.buildingNameTextField.text isEqualToString:@""] || ![[self.buildingNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                          message:@"You must enter a building name before saving!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
        
        self.buildingNameTextField.text = @"";
    }
    else
    {
        self.completionBlock(dictionary);
    }
}

- (IBAction)cancelButtonPressed:(id)sender
{
    self.completionBlock(nil);
}
@end
