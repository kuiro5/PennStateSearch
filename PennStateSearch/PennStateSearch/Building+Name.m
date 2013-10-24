//
// Name:    Joshua Kuiros
// Section: CMPSC 475
// Program: Assignment 8
// Date: October 24, 2013
//

#import "Building+Name.h"

@implementation Building (Name)

-(NSString*)firstLetterOfName
{
    NSString *letter = [self.name substringToIndex:1];
    return letter;
}

@end
