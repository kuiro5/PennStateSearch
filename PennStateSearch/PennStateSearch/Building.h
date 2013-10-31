//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Building : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSNumber * opp_bldg_code;
@property (nonatomic, retain) NSNumber * year_constructed;
@property (nonatomic, retain) NSString * photoName;
@property (nonatomic, retain) NSString * info;
@property (nonatomic, retain) NSData * photo;

@end
