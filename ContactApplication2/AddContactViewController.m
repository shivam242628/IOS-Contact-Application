//
//  AddContactViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "AddContactViewController.h"
#import "Contacts.h"
#import "ContactManager.h"

@interface AddContactViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)addContactButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *heading;

@end

@implementation AddContactViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapRecognizer];
    self.saveButton.layer.cornerRadius = 10;
    self.cancelButton.layer.cornerRadius = 10;
    self.firstNameTextField.text = self.contact.firstName;
    self.lastNameTextField.text = self.contact.lastName;
    self.contactNumberTextField.text = self.contact.contactNumber;
    self.emailIDTextField.text = self.contact.emailID;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark - Keyboard Notification Method
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height + 15, 0.0);
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.scrollView.contentInset = UIEdgeInsetsZero;
}



- (void)hideKeyboard{
    [self.view endEditing:YES];
}


- (IBAction)addContactButtonPressed:(id)sender
{
    if([self.editCheck isEqualToString:@"YES"]){
        if([self.firstNameTextField.text isEqualToString:@""] && [self.lastNameTextField.text isEqualToString:@""] && [self.contactNumberTextField.text isEqualToString:@""] && [self.emailIDTextField.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FAILED"
                                                            message:@"All fields cannot be empty"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            self.contact.firstName =self.firstNameTextField.text;
            self.contact.lastName =self.lastNameTextField.text;
            self.contact.emailID =self.emailIDTextField.text;
            self.contact.contactNumber =self.contactNumberTextField.text;
            [ContactManager editContact:self.contact];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Contact Edited"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        if( [self.contactNumberTextField.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"FAILED"
                                                            message:@"Contact Number cannot be empty"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else{
            Contacts *contact = [Contacts new];
            [contact setFirstName:[[self firstNameTextField]text]];
            [contact setLastName:[[self lastNameTextField]text]];
            [contact setContactNumber:[NSString stringWithFormat:@"%@",[[self contactNumberTextField]text]]];
            [contact setEmailID:[[self emailIDTextField]text]];
            [ContactManager addContactToList:contact];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Contact Added"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)cancelButtonPressed:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
