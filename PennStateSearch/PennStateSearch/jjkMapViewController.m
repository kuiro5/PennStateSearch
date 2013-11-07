//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import "jjkMapViewController.h"
#import "jjkBuildingPhotoViewController.h"

@interface jjkMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation jjkMapViewController

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
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapCenter, 800, 800);
    [self.mapView setRegion:region];
    
    
    MKPointAnnotation * building = [[MKPointAnnotation alloc] init];
    [building setCoordinate:self.mapCenter];
    [building setTitle:self.buildingName];
    [building setSubtitle:[NSString stringWithFormat:@"%f, %f", self.mapCenter.latitude, self.mapCenter.longitude]];
    [self.mapView addAnnotation:building];
}



- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
   
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc]
                                  initWithAnnotation:annotation
                                  reuseIdentifier:@"currentloc"];
    
    CGImageRef cgref = [self.buildingPhoto CGImage];
    CIImage *cim = [self.buildingPhoto CIImage];
    
    if (!(cim == nil && cgref == NULL))
    {
        annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }

    
    
    
    annView.animatesDrop=NO;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    return annView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"PhotoSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"PhotoSegue"])
    {
        jjkBuildingPhotoViewController *photoViewController = segue.destinationViewController;
        photoViewController.buildingPhoto = self.buildingPhoto;
        photoViewController.completionBlock = ^(id obj){
            [self dismissViewControllerAnimated:YES completion:NULL];
        };
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTitle: self.buildingName];
    
    [self updateMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
