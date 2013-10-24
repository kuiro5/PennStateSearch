//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import <Foundation/Foundation.h>

@interface jjkBuildingInfo : NSObject <NSCoding>
-(id)initWithBuilding:(NSString*)building oppCode:(NSNumber*)oppCode photo:(NSString*)photoName;
@property (nonatomic,readonly,strong) NSString *building;
@property (nonatomic,readonly,strong) NSNumber *oppCode;
@property (nonatomic,readonly,strong) NSString *photoName;
@property (nonatomic,readonly,strong) UIImage *image;
@end
