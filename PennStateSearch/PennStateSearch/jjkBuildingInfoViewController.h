//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import <UIKit/UIKit.h>
//#import <MapKit/MapKit.h>
//#import <CoreLocation/CoreLocation.h>
//#import <AddressBook/AddressBook.h>

@interface jjkBuildingInfoViewController : UIViewController <UITextViewDelegate>
@property (nonatomic,strong) NSString *infoString;
@property (retain,nonatomic) UIImage *buildingPhoto;
@property (nonatomic,copy) CompletionBlock completionBlock;
-(void)updateTextView;
//@property CLLocationCoordinate2D mapCenter;
//- (void) updateMapView;

@end
