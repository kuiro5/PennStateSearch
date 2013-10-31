//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 9
// Date: October 31, 2013
//

#import <UIKit/UIKit.h>

@interface jjkBuildingInfoViewController : UIViewController <UITextViewDelegate>
@property (nonatomic,strong) NSString *infoString;
@property (retain,nonatomic) UIImage *buildingPhoto;
@property (nonatomic,copy) CompletionBlock completionBlock;
-(void)updateTextView;
@end
