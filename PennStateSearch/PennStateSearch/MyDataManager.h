//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import <Foundation/Foundation.h>
#import "DataManagerDelegate.h"

@interface MyDataManager : NSObject <DataManagerDelegate>
-(void)addBuilding:(NSDictionary*)dictionary;
@end
