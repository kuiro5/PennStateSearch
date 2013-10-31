//
//  jjkBuildingInfoViewController.h
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/28/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface jjkBuildingInfoViewController : UIViewController <UITextViewDelegate>
@property (nonatomic,strong) NSString *infoString;
@property (retain,nonatomic) UIImage *buildingPhoto;
@property (nonatomic,copy) CompletionBlock completionBlock;
-(void)updateTextView;
@end
