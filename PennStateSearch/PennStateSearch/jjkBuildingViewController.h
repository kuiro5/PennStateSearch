//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import <UIKit/UIKit.h>
#import "DataSourceCellConfigurer.h"
#import "Model.h"

@interface jjkBuildingViewController : UITableViewController <DataSourceCellConfigurer>
@property (strong,nonatomic) Model *model;
@end
