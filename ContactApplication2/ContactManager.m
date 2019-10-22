//
//  ContactManager.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 13/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "ContactManager.h"

@implementation ContactManager

+(void)editContact:(Contacts *)contact
{
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
    NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    contactArray = oldContactArray;
    [contactArray replaceObjectAtIndex:contact.index withObject:contact];
    NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
    [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"contactDB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)addToRecents:(Contacts *)contact
{
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSObject *object = [userdeafaults objectForKey:@"recentsDB"];
    NSDate * now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd-MMM-yy HH:mm a"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
    contact.lastCallDetails = newDateString;
    
    if(object == nil)
    {
        contactArray = [NSMutableArray arrayWithObjects:contact, nil];
        NSData *contactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
        [[NSUserDefaults standardUserDefaults] setObject:contactObject forKey:@"recentsDB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        NSData *contactObject = [userdeafaults objectForKey:@"recentsDB"];
        NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
        contactArray = oldContactArray;
        if(contactArray.count <= 9)
        {
           [contactArray insertObject:contact atIndex:0];
        }
        else
        {
            [contactArray removeLastObject];
            [contactArray insertObject:contact atIndex:0];
        }
        NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
        [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"recentsDB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}





+(void)addToFavourites:(NSInteger)index
{
    
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
    NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    contactArray = oldContactArray;
    Contacts *updatedContact = [contactArray objectAtIndex:index];
    updatedContact.favourite = @"YES";
    [contactArray replaceObjectAtIndex:index withObject:updatedContact];
    NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
    [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"contactDB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)removeFromFavourites:(NSInteger)index
{
    
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
    NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    contactArray = oldContactArray;
    Contacts *updatedContact = [contactArray objectAtIndex:index];
    updatedContact.favourite = @"NO";
    [contactArray replaceObjectAtIndex:index withObject:updatedContact];
    NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
    [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"contactDB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)deleteContact:(NSInteger)index
{
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
    NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    contactArray = oldContactArray;
    [contactArray removeObjectAtIndex:index];
    NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
    [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"contactDB"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+(void)addContactToList:(Contacts *)contact
{
    contact.favourite = @"NO";
    NSMutableArray *contactArray = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSObject *object = [userdeafaults objectForKey:@"contactDB"];
    if(object == nil)
    {
        contactArray = [NSMutableArray arrayWithObjects:contact, nil];
        NSData *contactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
        [[NSUserDefaults standardUserDefaults] setObject:contactObject forKey:@"contactDB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
        NSMutableArray *oldContactArray = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
        contactArray = oldContactArray;
        [contactArray addObject:contact];
        NSData *newContactObject = [NSKeyedArchiver archivedDataWithRootObject:contactArray];
        [[NSUserDefaults standardUserDefaults] setObject:newContactObject forKey:@"contactDB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
 }

@end
