//
//  jjkOptionsViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/15/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkOptionsViewController.h"
#import "jjkConstants.h"

@interface jjkOptionsViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *buildingPhotoOnlySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *buildingZoomSwitch;
- (IBAction)dismissPressed:(id)sender;

@end

@implementation jjkOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    NSNumber *boolZoom = [preferences objectForKey:buildingsZoom];
    NSNumber *boolPhotos = [preferences objectForKey:buildingsWithPhotos];
    
    self.buildingPhotoOnlySwitch.on = [boolPhotos boolValue];
    self.buildingZoomSwitch.on = [boolZoom boolValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissPressed:(id)sender
{
    NSUserDefaults *preferences = [NSUserDefaults standardUserDefaults];
    [preferences setBool:self.buildingZoomSwitch.isOn forKey:buildingsZoom];
    [preferences setBool:self.buildingPhotoOnlySwitch.isOn forKey:buildingsWithPhotos];
    [preferences synchronize];
    
    self.CompletionBlock();
        
    
}
@end
