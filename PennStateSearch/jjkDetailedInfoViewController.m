//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import "jjkDetailedInfoViewController.h"

@interface jjkDetailedInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *affiliationLabel;
@property (weak, nonatomic) IBOutlet UILabel *majorLabel;
@property (weak, nonatomic) IBOutlet UILabel *campusLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) NSIndexPath *currentRow;
@end

@implementation jjkDetailedInfoViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _model = [[Model alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

-(void)initializeInfoAtIndex:(NSInteger)index
{    
    self.nameLabel.text = [self.model nameAtIndex:index];
    self.affiliationLabel.text = [self.model affiliationAtIndex:index];
    self.majorLabel.text = [self.model majorAtIndex:index];
    self.campusLabel.text = [self.model campusAtIndex:index];
    self.emailLabel.text = [self.model emailAtIndex:index];
    self.mobileLabel.text = [self.model mobileAtIndex:index];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.currentRow = [self.delegate selectedRow];
    NSInteger rowIndex = self.currentRow.row;
    
    [self initializeInfoAtIndex:rowIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
