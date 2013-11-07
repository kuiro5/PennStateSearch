//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
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
