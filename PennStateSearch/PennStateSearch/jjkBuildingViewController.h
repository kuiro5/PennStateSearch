//
//  jjkBuildingViewController.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/7/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface jjkBuildingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong,nonatomic) Model *model;
@end
