//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import <UIKit/UIKit.h>
#import "DataSourceCellConfigurer.h"
#import "Model.h"

@interface jjkBuildingViewController : UITableViewController <DataSourceCellConfigurer>
@property (strong,nonatomic) Model *model;
@end
