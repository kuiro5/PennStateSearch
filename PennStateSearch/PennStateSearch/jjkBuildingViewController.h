//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import <UIKit/UIKit.h>
#import "DataSourceCellConfigurer.h"
#import "Model.h"

@interface jjkBuildingViewController : UITableViewController <DataSourceCellConfigurer>
@property (strong,nonatomic) Model *model;
@end
