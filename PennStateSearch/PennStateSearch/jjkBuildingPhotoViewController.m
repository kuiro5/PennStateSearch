//
//  jjkBuildingPhotoViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/9/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkBuildingPhotoViewController.h"

@interface jjkBuildingPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (strong,nonatomic) UIImageView *imageView;
@end

@implementation jjkBuildingPhotoViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _model = [[Model alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSIndexPath *rowIndex = [self.delegate buildingRowSelected];
    NSInteger row = rowIndex.row;
    
    NSString *photoName = [self.model buildingPictureAtIndex:row];
    
    photoName = [photoName stringByAppendingString: @".jpg"];
    
    UIImage *image = [UIImage imageNamed:photoName];
    _imageView = [[UIImageView alloc] initWithImage:image];
    
    
    [self.photoScrollView addSubview:self.imageView];
    
    
    self.photoScrollView.contentSize = image.size;
    
    self.photoScrollView.maximumZoomScale = 2.0;
    self.photoScrollView.minimumZoomScale = .5;
    //(self.photoScrollView.bounds.size.width)/(image.size.width);
    
    NSLog(@"%f", self.photoScrollView.minimumZoomScale);
    
    self.photoScrollView.bounces = YES;
    self.photoScrollView.bouncesZoom = NO;
    
  
    self.photoScrollView.delegate = self;
    
    // I forgot to add this line in class.  Delegate must be set before doing this.
    [self.photoScrollView zoomToRect:self.imageView.bounds animated:YES];
    
}

#pragma mark - ScrollView Delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

@end
