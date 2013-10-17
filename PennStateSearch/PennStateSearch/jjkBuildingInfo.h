//
//  jjkBuildingInfo.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/16/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface jjkBuildingInfo : NSObject <NSCoding>
-(id)initWithBuilding:(NSString*)building oppCode:(NSNumber*)oppCode photo:(NSString*)photoName;
@property (nonatomic,readonly,strong) NSString *building;
@property (nonatomic,readonly,strong) NSNumber *oppCode;
@property (nonatomic,readonly,strong) NSString *photoName;
@property (nonatomic,readonly,strong) UIImage *image;
@end
