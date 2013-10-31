//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import <Foundation/Foundation.h>
#import "DataManagerDelegate.h"

@interface MyDataManager : NSObject <DataManagerDelegate>
-(void)addBuilding:(NSDictionary*)dictionary;
@end
