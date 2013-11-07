//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface jjkMapViewController : UIViewController<MKMapViewDelegate>

@property CLLocationCoordinate2D mapCenter;
@property (strong, nonatomic) NSString *buildingName;
@property (strong, nonatomic) UIImage *buildingPhoto;
@property (nonatomic,copy) CompletionBlock completionBlock;
- (void) updateMapView;
@end
