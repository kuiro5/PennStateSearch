//
//  Building+Name.m
//  PennStateSearch
//
//  Created by Joshua Kuiros on 10/23/13.
//  Copyright (c) 2013 Joshua Kuiros. All rights reserved.
//

#import "Building+Name.h"

@implementation Building (Name)

-(NSString*)firstLetterOfName
{
    NSString *letter = [self.name substringToIndex:1];
    return letter;
}

@end
