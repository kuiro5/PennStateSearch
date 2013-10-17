//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 7
// Date: October 17, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface jjkTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) Model *model;
@end
