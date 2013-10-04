//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"

@protocol TableDelegate <NSObject>
-(void)dismissMe;
@end


@interface jjkTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) id<TableDelegate> delegate;
@property (strong,nonatomic) Model *model;
@end
