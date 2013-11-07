//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import <Foundation/Foundation.h>

@interface jjkBuildingInfo : NSObject <NSCoding>
-(id)initWithBuilding:(NSString*)building oppCode:(NSNumber*)oppCode photo:(NSString*)photoName;
@property (nonatomic,readonly,strong) NSString *building;
@property (nonatomic,readonly,strong) NSString *info;
@property (nonatomic,readonly,strong) NSNumber *oppCode;
@property (nonatomic,readonly,strong) NSString *photoName;
@property (nonatomic,readonly,strong) UIImage *image;
@end
