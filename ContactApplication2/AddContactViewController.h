//
//  AddContactViewController.h
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts.h"

#define kNSUSERDEFAULTSCONTACT @"nsuserdefaultscontact"

@interface AddContactViewController : UIViewController

@property (strong,nonatomic) Contacts *contact;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailIDTextField;
@property (weak,nonatomic) NSString *editCheck;
@end
