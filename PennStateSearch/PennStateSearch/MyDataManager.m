//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import "MyDataManager.h"
#import "DataManager.h"
#import "Building.h"

@implementation MyDataManager

-(NSString*)xcDataModelName {
    return @"Buildings";
}


-(void)createDatabaseFor:(DataManager *)dataManager
{
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"buildings" ofType:@"plist"];
    NSArray *buildingArray = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSManagedObjectContext *managedObjectContext = dataManager.managedObjectContext;
    
    for (NSDictionary *dictionary in buildingArray)
    {
        Building *building = [NSEntityDescription insertNewObjectForEntityForName:@"Building" inManagedObjectContext:managedObjectContext];
        
        building.name = [dictionary objectForKey:@"name"];
        building.latitude = [dictionary objectForKey:@"latitude"];
        building.longitude = [dictionary objectForKey:@"longitude"];
        building.opp_bldg_code = [dictionary objectForKey:@"opp_bldg_code"];
        building.year_constructed = [dictionary objectForKey:@"year_constructed"];
        
        NSString *photo = [dictionary objectForKey:@"photo"];
        photo = [NSString stringWithFormat:@"%@", photo];
        
        if([photo length] != 0)
        {
            photo = [photo stringByAppendingString: @".jpg"];
        }
        
        building.photoName = photo;
        
        UIImage *buildingImage = [UIImage imageNamed: photo];
        building.photo = UIImagePNGRepresentation(buildingImage);
    }
    
    [dataManager saveContext];
}

@end
