//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import "jjkBuildingInfoViewController.h"
#import "jjkBuildingPhotoViewController.h"

@interface jjkBuildingInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoButton;


@end

@implementation jjkBuildingInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) updateMapView
{
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.textView.text = self.infoString;
    self.textView.delegate = self;
    
    CGImageRef cgref = [self.buildingPhoto CGImage];
    CIImage *cim = [self.buildingPhoto CIImage];
    
    if (cim == nil && cgref == NULL)
    {
        self.photoButton.enabled = NO;
    }
    else
    {
        self.photoButton.enabled = YES;
    }
    
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem, self.navigationItem.rightBarButtonItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)keyboardWasShown:(NSNotification*)notification {
    NSDictionary *info = notification.userInfo;
    CGRect frame = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGSize keyboardSize = frame.size;
    self.textView.frame = CGRectMake(0.0, 0.0, self.textView.bounds.size.width, self.textView.frame.size.height - keyboardSize.height);
}

-(void)keyboardWillBeHidden:(NSNotification*)notification {
    
    self.textView.frame = CGRectMake(0.0, 0.0, self.textView.bounds.size.width, self.view.bounds.size.height);
}

-(void)updateTextView {
    self.textView.text = self.infoString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (!self.editing) {
        [self.textView resignFirstResponder];
    } else {
        [self.textView becomeFirstResponder];
    }
}

#pragma mark - TextView Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView {
    if (!self.editing) {
        [self setEditing:YES animated:YES];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView {
    self.completionBlock(self.textView.text);
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"Text: %@", text);
    return YES;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BuildingSegue"])
    {  // iPhone
        jjkBuildingPhotoViewController *photoViewController = segue.destinationViewController;
        photoViewController.buildingPhoto = self.buildingPhoto;
        
        photoViewController.completionBlock = ^(id obj){
            [self dismissViewControllerAnimated:YES completion:NULL];
        };
        
    }     
}

@end
