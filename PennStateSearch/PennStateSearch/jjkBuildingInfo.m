//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import "jjkBuildingInfo.h"

@interface jjkBuildingInfo ()

@property (nonatomic, strong) NSString *building;
@property (nonatomic, strong) NSNumber *oppCode;
@property (nonatomic, strong) NSString *photoName;
@property (nonatomic, strong) UIImage *image;
@end

@implementation jjkBuildingInfo

-(id)initWithBuilding:(NSString*)building oppCode:(NSNumber*)oppCode photo:(NSString*)photoName
{
    self = [super init];
    if (self) {
        _building = building;
        _oppCode = oppCode;
        _photoName = photoName;
        NSString *buildingPhoto = [NSString stringWithFormat:@"buildlings/%@.png", photoName];
        _image = [UIImage imageNamed:buildingPhoto];
    }
    return self;
}

#pragma mark - NSCoding Protol

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _building = [aDecoder decodeObjectForKey:@"building"];
        _oppCode = [aDecoder decodeObjectForKey:@"oppCode"];
        _photoName = [aDecoder decodeObjectForKey:@"photoName"];
        _image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_building forKey:@"building"];
    [aCoder encodeObject:_oppCode forKey:@"oppCode"];
    [aCoder encodeObject:_photoName forKey:@"photoName"];
    [aCoder encodeObject:_image forKey:@"image"];
}
@end
