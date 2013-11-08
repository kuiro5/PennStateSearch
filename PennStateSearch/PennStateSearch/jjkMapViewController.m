//
//  jjkMapViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 11/5/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkMapViewController.h"
#import "jjkBuildingPhotoViewController.h"

@interface jjkMapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong, nonatomic) CLGeocoder *geocoder;

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
    
    //[self.mapView removeAnnotations:[self.mapView annotations]];
    
    MKPointAnnotation * building = [[MKPointAnnotation alloc] init];
    [building setCoordinate:self.mapCenter];
    [building setTitle:self.buildingName];
    [building setSubtitle:[NSString stringWithFormat:@"%f, %f", self.mapCenter.latitude, self.mapCenter.longitude]];
    [self.mapView addAnnotation:building];
}


- (void) geocodeInfo {
    CLGeocoder * geocoder1 = [[CLGeocoder alloc] init];
  //  CLGeocoder * geocoder2 = [[CLGeocoder alloc] init];
    
    NSMutableDictionary * stateAddressDict = [[NSMutableDictionary alloc] init];
    [stateAddressDict setValue:self.title
                        forKey:[NSString stringWithFormat:@"%@", kABPersonAddressStateKey]];
    
    [geocoder1 geocodeAddressDictionary:stateAddressDict
                      completionHandler:^(NSArray * placemarks, NSError * error) {
                          if (placemarks) {
                              CLPlacemark * place = (CLPlacemark *)[placemarks objectAtIndex:0];
                              [self setMapCenter:place.location.coordinate];
                              [self updateMapView];
                              
                          }
                      }];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
   
    MKPinAnnotationView *annView=[[MKPinAnnotationView alloc]
                                  initWithAnnotation:annotation
                                  reuseIdentifier:@"currentloc"];
    
//    
//    UIButton *myDetailButton = [UIButton
//                                buttonWithType:UIButtonTypeDetailDisclosure];
//    myDetailButton.frame = CGRectMake(0, 0, 23, 23);
//    myDetailButton.contentVerticalAlignment =
//    UIControlContentVerticalAlignmentCenter;
//    myDetailButton.contentHorizontalAlignment =
//    UIControlContentHorizontalAlignmentCenter;
//    
//    [myDetailButton addTarget:self
//                       action:nil
//             forControlEvents:UIControlEventTouchUpInside];
    
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
   // NSLog(@"accessory button tapped for annotation %@", view.annotation);
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
