//
//  jjkMapViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 11/5/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkMapViewController.h"

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
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapCenter, 750000, 750000);
    [self.mapView setRegion:region];
    
    [self.mapView removeAnnotations:[self.mapView annotations]];
    
    MKPointAnnotation * building = [[MKPointAnnotation alloc] init];
    [building setCoordinate:self.mapCenter];
    //[capital setTitle:self.capitalName];
    //[capital setSubtitle:[NSString stringWithFormat:@"%f, %f", self.capCenter.latitude, self.capCenter.longitude]];
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




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self updateMapView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
