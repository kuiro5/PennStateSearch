//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import <UIKit/UIKit.h>
#import "Model.h"

@protocol BuildingDelegate <NSObject>

-(NSIndexPath *)buildingRowSelected;

@end

@interface jjkBuildingPhotoViewController : UIViewController<UIScrollViewDelegate>

@property (strong,nonatomic) Model *model;
@property (retain,nonatomic) id<BuildingDelegate> delegate;
@property (retain,nonatomic) UIImage *buildingPhoto;
@property (nonatomic,copy) CompletionBlock completionBlock;

@end
