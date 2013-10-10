//
//  jjkDetailedInfoViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/9/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
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
    if (self) {
        _model = [[Model alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	// Do any additional setup after loading the view.
    
    self.currentRow = [self.delegate selectedRow];
    NSInteger rowIndex = self.currentRow.row;
    
    
    
    
    [self initializeInfoAtIndex:rowIndex];
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
