//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 6
// Date: October 10, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface jjkTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) Model *model;
@end
