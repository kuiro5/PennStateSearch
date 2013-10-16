//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 6
// Date: October 10, 2013
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
    if (self) {
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
    
    NSLog(@"bool value %@", boolNumber);
    
//}

//- (void)viewDidLoad
//{
  //  [super viewDidLoad];
    
    NSIndexPath *rowIndex = [self.delegate buildingRowSelected];;
    NSInteger row = rowIndex.row;
    NSString *photoName;
    
    
    if(self.showingBuildingsPhotos)
    {
        
        photoName = [self.model photoBuildingPictureAtIndex:row];
    }
    else
    {
        
        photoName = [self.model buildingPictureAtIndex:row];
    }
    

    
    photoName = [photoName stringByAppendingString: @".jpg"];
    
    
    UIImage *image = [UIImage imageNamed:photoName];
    _imageView = [[UIImageView alloc] initWithImage:image];
    
    
    [self.photoScrollView addSubview:self.imageView];
    
    
    self.photoScrollView.contentSize = image.size;
    
    self.photoScrollView.minimumZoomScale = self.view.bounds.size.width/ image.size.width;
    
    if(self.zoomablePhotos)
    {
        self.photoScrollView.maximumZoomScale = maxScale;
        
    }
    else
    {
        self.photoScrollView.maximumZoomScale = self.view.bounds.size.width/ image.size.width;
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
