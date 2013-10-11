//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 6
// Date: October 10, 2013
//

#import "jjkBuildingPhotoViewController.h"

#define maxScale 2.0
#define minScale 0.5

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
    
    NSIndexPath *rowIndex = [self.delegate buildingRowSelected];
    NSInteger row = rowIndex.row;
    
    NSString *photoName = [self.model buildingPictureAtIndex:row];
    
    photoName = [photoName stringByAppendingString: @".jpg"];
    
    UIImage *image = [UIImage imageNamed:photoName];
    _imageView = [[UIImageView alloc] initWithImage:image];
    
    
    [self.photoScrollView addSubview:self.imageView];
    
    
    self.photoScrollView.contentSize = image.size;
    
    self.photoScrollView.maximumZoomScale = maxScale;
    self.photoScrollView.minimumZoomScale = minScale;
    
    self.photoScrollView.bounces = YES;
    self.photoScrollView.bouncesZoom = NO;
    
  
    self.photoScrollView.delegate = self;
    
    [self.photoScrollView zoomToRect:self.imageView.bounds animated:YES];
    
}

#pragma mark - ScrollView Delegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
