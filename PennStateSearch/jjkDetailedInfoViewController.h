//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 6
// Date: October 10, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"

@protocol InfoDelegate <NSObject>

-(NSIndexPath *)selectedRow;

@end

@interface jjkDetailedInfoViewController : UIViewController
@property (strong,nonatomic) Model *model;
@property (retain,nonatomic) id<InfoDelegate> delegate;
@end
