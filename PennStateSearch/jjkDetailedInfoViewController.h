//
//  jjkDetailedInfoViewController.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/9/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
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
