//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import "jjkBuildingPhotoViewController.h"
#import "jjkConstants.h"

#define maxScale 2.0
#define minScale 0.5

@interface jjkBuildingPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (strong,nonatomic) UIImageView *imageView;
@property (nonatomic,assign) BOOL showingBuildingsPhotos;
@property (nonatomic,assign) BOOL zoomablePhotos;
@end

@implementation jjkBuildingPhotoViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _model = [[Model alloc] init];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolNumber = [preferences objectForKey:buildingsWithPhotos];
    self.showingBuildingsPhotos = [boolNumber boolValue];
    boolNumber = [preferences objectForKey:buildingsZoom];
    self.zoomablePhotos = [boolNumber boolValue];
    
    _imageView = [[UIImageView alloc] initWithImage:self.buildingPhoto];    
    
    [self.photoScrollView addSubview:self.imageView];
    
    
    self.photoScrollView.contentSize = self.buildingPhoto.size;
    
    self.photoScrollView.minimumZoomScale = self.view.bounds.size.width/ self.buildingPhoto.size.width;
    
    if(self.zoomablePhotos)
    {
        self.photoScrollView.maximumZoomScale = maxScale;
        
    }
    else
    {
        self.photoScrollView.maximumZoomScale = self.view.bounds.size.width/ self.buildingPhoto.size.width;
    }
    
    
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
