//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import "jjkOptionsViewController.h"
#import "jjkConstants.h"

@interface jjkOptionsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *buildingPhotoOnlySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *buildingZoomSwitch;
- (IBAction)dismissPressed:(id)sender;

@end

@implementation jjkOptionsViewController

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
    
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolZoom = [preferences objectForKey:buildingsZoom];
    NSNumber *boolPhotos = [preferences objectForKey:buildingsWithPhotos];
    
    self.buildingPhotoOnlySwitch.on = [boolPhotos boolValue];
    self.buildingZoomSwitch.on = [boolZoom boolValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)dismissPressed:(id)sender
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:self.buildingZoomSwitch.isOn forKey:buildingsZoom];
    [preferences setBool:self.buildingPhotoOnlySwitch.isOn forKey:buildingsWithPhotos];
    [preferences synchronize];
    
    self.CompletionBlock();
}
@end
