//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import "jjkViewController.h"
#import "jjkTableViewController.h"
#import "Model.h"

@interface jjkViewController ()
-(IBAction)unwindSegue:(UIStoryboardSegue*)segue;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) Model *model;
- (IBAction)searchButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *psuIdTextField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

@implementation jjkViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _model = [[Model alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self)
    {
        self.firstNameTextField.text = @"";
        self.lastNameTextField.text = @"";
        self.psuIdTextField.text = @"";
        [[[self tabBarController] navigationItem] setTitle:@"PSU Search Directory"];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchSegue"])
    {
        jjkTableViewController *tableViewController = segue.destinationViewController;
       // tableViewController.delegate = self;
        tableViewController.model = self.model;
    }
    
}
-(IBAction)unwindSegue:(UIStoryboardSegue*)segue
{
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField*)textField
{
    NSInteger textFieldEdited = textField.tag;
    
    if(textFieldEdited == 0)
    {
        [self.model firstNameChanged:textField];
    }
    else if(textFieldEdited == 1)
    {
        [self.model lastNameChanged:textField];
    }
    else if(textFieldEdited == 2)
    {
        [self.model psuIdChanged:textField];
    }
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    
    if(self.lastNameTextField.text.length == 0 && self.psuIdTextField.text.length == 0)
    {
        self.searchButton.enabled = NO;
    }
    else
    {
        self.searchButton.enabled = YES;
    }
    
    
    
}

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    
    NSInteger textFieldTag = textField.tag;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0,  0.0, 216.0,  0.0);
    self.scrollView.contentInset = contentInsets;
    
    
    if(textFieldTag == 2)
    {
        [self.scrollView setContentOffset:CGPointMake(0.0, self.scrollView.frame.size.height/2) animated:YES];
    }
    
    
}

- (IBAction)searchButtonPressed:(id)sender
{
    
    [self.model ldapSearch];
}
@end
