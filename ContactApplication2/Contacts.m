//
//  Contacts.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 13/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "Contacts.h"

@implementation Contacts

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self != nil)
    {
        self.firstName = [aDecoder decodeObjectForKey:@"FirstName"];
        self.lastName = [aDecoder decodeObjectForKey:@"LastName"];
        self.contactNumber = [aDecoder decodeObjectForKey:@"ContactNumber"];
        self.emailID = [aDecoder decodeObjectForKey:@"EmailID"];
        self.favourite = [aDecoder decodeObjectForKey:@"Favourites"];
        self.lastCallDetails = [aDecoder decodeObjectForKey:@"LastCallDetails"];
    }
    return self; 
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.firstName forKey:@"FirstName"];
    [aCoder encodeObject:self.lastName forKey:@"LastName"];
    [aCoder encodeObject:self.contactNumber forKey:@"ContactNumber"];
    [aCoder encodeObject:self.emailID forKey:@"EmailID"];
    [aCoder encodeObject:self.favourite forKey:@"Favourites"];
    [aCoder encodeObject:self.lastCallDetails forKey:@"LastCallDetails"];
}








@end
