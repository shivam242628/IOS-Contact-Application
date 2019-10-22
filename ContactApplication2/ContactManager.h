//
//  ContactManager.h
//  ContactApplication2
//
//  Created by Shivam Srivastava on 13/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contacts.h"
#import "AddContactViewController.h"

@interface ContactManager : NSObject

+(void)addToFavourites:(NSInteger)index;
+(void)removeFromFavourites:(NSInteger)index;
+(void)addContactToList:(Contacts *)contact;
+(void)deleteContact:(NSInteger)index;
+(void)addToRecents:(Contacts *)contact;
+(void)editContact:(Contacts *)contact;

@end
