//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 10
// Date: November 7, 2013
//

#import "Model.h"
#import "jjkBuildingInfo.h"
#import "RHLDAPSearch.h"
#import "DataManager.h"
#import "MyDataManager.h"
#import "Building.h"

static NSString * const filename = @"buildings";

@interface Model ()

@property(strong,nonatomic)RHLDAPSearch *psuSearch;
@property(strong, nonatomic) NSArray *results;
@property(strong, nonatomic) NSMutableArray *buildingsInformation;
@property(strong, nonatomic)NSArray *sortedBuildingsArray;
@property(strong, nonatomic)NSMutableArray *sortedBuildingWithPhotos;
@property(strong, nonatomic)NSMutableArray *temporaryBuildingArray;

@end

@implementation Model

+(id)sharedInstance
{
    static id singleton = nil;
    if (!singleton)
    {
        singleton = [[self alloc] init];
    }
    return singleton;
}

-(id) init
{
    self = [super init];
    if(self)
    {
        // initialization
        self.psuSearch = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
        self.sortedBuildingWithPhotos = [[NSMutableArray alloc] init];
        
            
        // coredata objects
        DataManager *dataManager = [DataManager sharedInstance];
        MyDataManager *myDataManager = [[MyDataManager alloc]init];
        dataManager.delegate = myDataManager;
            
        NSArray *sortedTempArray = [dataManager fetchManagedObjectsForEntity:@"Building" sortKeys:@[@"name"] predicate:nil];
            
        _buildingsInformation = [[NSMutableArray alloc] initWithArray:sortedTempArray];
    }
    return self;
}

-(NSString*)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(NSString *)filePath
{
    return [[self applicationDocumentsDirectory] stringByAppendingPathComponent:filename];
}

-(BOOL)fileExists
{
    NSString *path = [self filePath];
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}


-(NSString*)currentFirstName
{
    return self.firstName;
}

-(NSString*)currentLastName
{
    return self.lastName;
}

-(NSString*)currentPsuId
{
    return self.psuId;
}

-(void)clearResults
{
    self.firstName = @"";
    self.lastName = @"";
    self.psuId = @"";
}



-(void)firstNameChanged:(UITextField*)textField
{
    self.firstName = textField.text;
}

-(void)lastNameChanged:(UITextField*)textField
{
    self.lastName = textField.text;
}

-(void)psuIdChanged:(UITextField*)textField
{
    self.psuId = textField.text;
}

-(void)ldapSearch
{
    NSError *errorObject = [[NSError alloc]init];
    NSString *query = [NSString stringWithFormat:@"(&"];
    
    // create query string with non blank text fields
    if(self.firstName.length > 0)
    {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(givenName=%@*)", self.firstName]];
    }
    if(self.lastName.length > 0)
    {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(sn=%@)", self.lastName]];
    }
    if(self.psuId.length > 0)
    {
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(uid=%@)", self.psuId]];
    }
    
    query = [query stringByAppendingString:@")"];
    self.results =   [self.psuSearch searchWithQuery:query withinBase:@"dc=psu,dc=edu" usingScope:RH_LDAP_SCOPE_SUBTREE error:&errorObject];
}

-(NSInteger)numberOfResults
{
    return [self.results count];
}

-(NSArray*)searchResults
{
    return self.results;
}

-(NSString*)addressAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *entryAddress = [entryDictionary objectForKey:@"postalAddress"][0];
    NSArray *addressComponents = [entryAddress componentsSeparatedByString:@"$"];
    
    return [addressComponents componentsJoinedByString:@"\n"];
}

-(NSString*)nameAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *entryName = [entryDictionary objectForKey:@"cn"][0];
    
    return entryName;
}

-(NSString*)affiliationAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *affiliation = [entryDictionary objectForKey:@"eduPersonPrimaryAffiliation"][0];
    
    return affiliation;
}

-(NSString*)emailAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *email = [entryDictionary objectForKey:@"mail"][0];
    
    return email;
}

-(NSString*)mobileAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *mobile = [entryDictionary objectForKey:@"mobile"][0];
    
    return mobile;
}

-(NSString*)campusAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *campus = [entryDictionary objectForKey:@"psCampus"][0];
    
    return campus;
}

-(NSString*)majorAtIndex:(NSInteger)index
{
    NSDictionary *entryDictionary = [self.results objectAtIndex:index];
    NSString *major = [entryDictionary objectForKey:@"psCurriculum"][0];
    
    return major;
}

-(NSInteger)numberOfBuildings
{
    return [self.buildingsInformation count];
}

-(NSInteger)numberOfBuildingsWithPhotos;
{
    return [self.sortedBuildingWithPhotos count];
}

-(NSArray*)sortArray
{

    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];

    NSArray *tempArray = [self.temporaryBuildingArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    return tempArray;
}


-(void)displayBuildings
{
    
    [self createBuildingsPhotoArray];

}

-(NSString*)buildingNameAtIndex:(NSInteger)index
{
    Building *building = [self.buildingsInformation objectAtIndex:index];
    NSString *buildingName = building.name;
    
    return buildingName;
}

-(NSString*)buildingPictureAtIndex:(NSInteger)index
{
    Building *building = [self.buildingsInformation objectAtIndex:index];
    NSString *photoName = building.photoName;
    
    return photoName;
}

-(NSString*)infoAtIndex:(NSInteger)index
{
    Building *building = [self.buildingsInformation objectAtIndex:index];
    NSString *info = building.info;
    
    return info;
}

-(UIImage*)imageAtIndex:(NSInteger)index
{
    Building *building = [self.buildingsInformation objectAtIndex:index];
    UIImage* image = [[UIImage alloc] initWithData:building.photo];
    
    return image;
}

-(UIImage*)photoImageAtIndex:(NSInteger)index
{
    Building *building = [self.sortedBuildingWithPhotos objectAtIndex:index];
    UIImage* image = [[UIImage alloc] initWithData:building.photo];
    
    return image;
}

-(NSString*)buildingOppCodeAtIndex:(NSInteger)index
{
    Building *building = [self.buildingsInformation objectAtIndex:index];
    NSNumber *buildingCode = building.opp_bldg_code;
    NSString *buildingCodeString = [NSString stringWithFormat:@"%@", buildingCode];

    
    return buildingCodeString;
}

-(void)createBuildingsPhotoArray
{
    
    for(int i = 0; i < [self.buildingsInformation count]; i++)
    {
        
        Building *building = [self.buildingsInformation objectAtIndex:i];
        NSString *tempPhotoName = building.photoName;
        
        if([tempPhotoName length] != 0)
        {
            [self.sortedBuildingWithPhotos addObject:building];
            
        }
    }
}

- (CLLocationCoordinate2D) buildlingCenterForIndex:(NSInteger)index {
    NSDictionary *dictionary = [self.buildingsInformation objectAtIndex:index];
    NSNumber * lat = [dictionary objectForKey:@"latitude"];
    NSNumber * lon = [dictionary objectForKey:@"longitude"];
    return CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
}

- (CLLocationCoordinate2D) photoBuildingCenterForIndex:(NSInteger)index {
    NSDictionary *dictionary = [self.sortedBuildingWithPhotos objectAtIndex:index];
    NSNumber * lat = [dictionary objectForKey:@"latitude"];
    NSNumber * lon = [dictionary objectForKey:@"longitude"];
    return CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
}

-(NSString*)photoBuildingNameAtIndex:(NSInteger)index
{
    Building *building = [self.sortedBuildingWithPhotos objectAtIndex:index];
    NSString *buildingName = building.name;
    
    return buildingName;
}

-(NSString*)photoBuildingPictureAtIndex:(NSInteger)index
{
    Building *building = [self.sortedBuildingWithPhotos objectAtIndex:index];
    NSString *photoName = building.name;
    
    return photoName;
}

-(NSString*)photoBuildingOppCodeAtIndex:(NSInteger)index
{
    Building *building  = [self.sortedBuildingWithPhotos objectAtIndex:index];
    NSNumber *buildingCode = building.opp_bldg_code;
    NSString *buildingCodeString = [NSString stringWithFormat:@"%@", buildingCode];
    
    
    return buildingCodeString;
}



@end
