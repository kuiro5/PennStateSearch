//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"



@interface jjkTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) Model *model;
@end
