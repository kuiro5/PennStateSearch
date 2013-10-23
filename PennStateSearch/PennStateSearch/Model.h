//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 7
// Date: October 17, 2013
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

+(id)sharedInstance;

@property(strong,nonatomic)NSString* firstName;
@property(strong,nonatomic)NSString* lastName;
@property(strong,nonatomic)NSString* psuId;

-(NSString*)currentFirstName;
-(NSString*)currentLastName;
-(NSString*)currentPsuId;

-(void)firstNameChanged:(UITextField*)textField;
-(void)lastNameChanged:(UITextField*)textField;
-(void)psuIdChanged:(UITextField*)textField;

-(void)ldapSearch;

-(NSInteger)numberOfResults;
-(NSArray*)searchResults;
-(NSString *)nameAtIndex:(NSInteger)index;
-(NSString*)addressAtIndex:(NSInteger)index;

-(NSInteger)numberOfBuildings;
-(NSInteger)numberOfBuildingsWithPhotos;;

-(void)displayBuildings;
-(NSArray*)sortArray;

-(NSString*)buildingOppCodeAtIndex:(NSInteger)index;
-(NSString*)buildingNameAtIndex:(NSInteger)index;

-(NSString*)affiliationAtIndex:(NSInteger)index;
-(NSString*)emailAtIndex:(NSInteger)index;
-(NSString*)mobileAtIndex:(NSInteger)index;
-(NSString*)campusAtIndex:(NSInteger)index;
-(NSString*)majorAtIndex:(NSInteger)index;

-(NSString*)buildingPictureAtIndex:(NSInteger)index;

-(void)clearResults;

-(void)createBuildingsPhotoArray;

-(NSString*)photoBuildingNameAtIndex:(NSInteger)index;
-(NSString*)photoBuildingPictureAtIndex:(NSInteger)index;
-(NSString*)photoBuildingOppCodeAtIndex:(NSInteger)index;

-(UIImage*)photoImageAtIndex:(NSInteger)index;
-(UIImage*)imageAtIndex:(NSInteger)index;

@end


