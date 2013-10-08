//
//  jjkBuildingViewController.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/7/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "jjkBuildingViewController.h"
#define numberOfSections 1

@interface jjkBuildingViewController ()

@end

@implementation jjkBuildingViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    [self.model displayBuildings];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return numberOfSections;
}


-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.model numberOfBuildings];
}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    static NSString *CellIdentifier = @"BuildingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    cell.textLabel.text = [self.model buildingNameAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.model buildingOppCodeAtIndex:indexPath.row];
    
    
    return cell;
    
}








@end
