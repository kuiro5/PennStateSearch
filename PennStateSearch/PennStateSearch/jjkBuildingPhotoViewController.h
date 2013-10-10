//
//  jjkBuildingPhotoViewController.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/9/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@protocol BuildingDelegate <NSObject>

-(NSIndexPath *)buildingRowSelected;

@end

@interface jjkBuildingPhotoViewController : UIViewController<UIScrollViewDelegate>

@property (strong,nonatomic) Model *model;
@property (retain,nonatomic) id<BuildingDelegate> delegate;

@end
