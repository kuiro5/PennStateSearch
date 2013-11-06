//
//  jjkMapViewController.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 11/5/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface jjkMapViewController : UIViewController<MKMapViewDelegate>

@property CLLocationCoordinate2D mapCenter;
- (void) updateMapView;
@end
