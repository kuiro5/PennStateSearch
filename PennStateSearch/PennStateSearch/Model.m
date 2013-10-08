//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 5
// Date: October 4, 2013
//

#import "Model.h"
#import "RHLDAPSearch.h"

@interface Model ()

@property(strong,nonatomic)RHLDAPSearch *psuSearch;
@property(strong, nonatomic) NSArray *results;
@property(strong, nonatomic)NSMutableArray *buildingsInformation;
@property(strong, nonatomic)NSArray *sortedBuildingsArray;


@end

@implementation Model

-(id) init
{
    self = [super init];
    if(self)
    {
        self.psuSearch = [[RHLDAPSearch alloc] initWithURL:@"ldap://ldap.psu.edu:389"];
    }
    return self; 
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
        query = [query stringByAppendingString:[NSString stringWithFormat:@"(givenName=%@)", self.firstName]];
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

-(NSInteger)numberOfBuildings
{
    return [self.buildingsInformation count];
}

-(NSMutableArray*)buildingsArray
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *buildingsFile = [bundle pathForResource:@"buildings" ofType:@".plist"];
    self.buildingsInformation = [[NSMutableArray alloc] initWithContentsOfFile:buildingsFile];
    
    return self.buildingsInformation;
}

-(NSArray*)sortArray:(NSMutableArray*)buildingsArray
{
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray * descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    NSArray * sortedArray = [buildingsArray sortedArrayUsingDescriptors:descriptors];
    
    return sortedArray;
}

-(void)displayBuildings
{
    NSMutableArray *buildingsArray = [self buildingsArray];
    
    
    
     self.sortedBuildingsArray = [self sortArray:buildingsArray];
    
    
}


-(NSString*)buildingNameAtIndex:(NSInteger)index
{
    NSDictionary *buildingDictionary = [self.sortedBuildingsArray objectAtIndex:index];
    NSString *buildingName = [buildingDictionary objectForKey:@"name"];
    
    return buildingName;
}

-(NSString*)buildingOppCodeAtIndex:(NSInteger)index
{
    NSDictionary *buildingDictionary = [self.sortedBuildingsArray objectAtIndex:index];
    NSNumber *buildingCode = [buildingDictionary objectForKey:@"opp_bldg_code"];
    NSString *buildingCodeString = [NSString stringWithFormat:@"%@", buildingCode];

    
    return buildingCodeString;
}



@end
