//
//  Contacts.h
//  ContactApplication2
//
//  Created by Shivam Srivastava on 13/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Contacts : NSObject<NSCoding>
{
    
}
@property NSInteger index;
@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *contactNumber;
@property (strong,nonatomic) NSString *emailID;
@property (strong,nonatomic) NSString *favourite;
@property (strong,nonatomic) NSString *lastCallDetails;









@end

