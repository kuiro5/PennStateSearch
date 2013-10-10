//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

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

-(NSMutableArray*)buildingsArray;
-(NSInteger)numberOfBuildings;

-(void)displayBuildings;
-(NSArray*)sortArray:(NSMutableArray*)buildingsArray;

-(NSString*)buildingOppCodeAtIndex:(NSInteger)index;
-(NSString*)buildingNameAtIndex:(NSInteger)index;

-(NSString*)affiliationAtIndex:(NSInteger)index;
-(NSString*)emailAtIndex:(NSInteger)index;
-(NSString*)mobileAtIndex:(NSInteger)index;
-(NSString*)campusAtIndex:(NSInteger)index;
-(NSString*)majorAtIndex:(NSInteger)index;

-(NSString*)buildingPictureAtIndex:(NSInteger)index;

-(void)clearResults;

@end


