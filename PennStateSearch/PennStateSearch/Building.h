//
//  Building.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/21/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
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
@property (nonatomic, retain) NSData * photo;

@end
