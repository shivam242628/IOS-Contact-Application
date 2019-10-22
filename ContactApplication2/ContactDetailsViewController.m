//
//  ContactDetailsViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 13/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "ContactDetailsViewController.h"
#import "Contacts.h"
#import "ContactManager.h"
#import <QuartzCore/QuartzCore.h>

@interface ContactDetailsViewController ()


@property (strong, nonatomic) IBOutlet UIImageView *userImage;
@property (strong, nonatomic) IBOutlet UILabel *contactNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UISwitch *favouriteSwitch;
- (IBAction)favouriteSwitchClicked:(id)sender;
- (IBAction)editButtonClicked:(id)sender;
- (IBAction)deleteButtonClicked:(id)sender;

@end

@implementation ContactDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImage.layer.cornerRadius = 50;
    self.editButton.layer.cornerRadius = 10;
    self.deleteButton.layer.cornerRadius = 10;
    if([self.contact.favourite isEqualToString:@"YES"])
    {
        [self.favouriteSwitch setOn:YES animated:YES];
    }
    
    
    self.contactNameLabel.text = [NSString stringWithFormat:@"%@ %@",self.contact.firstName,self.contact.lastName];
    self.contactNumberLabel.text = [NSString stringWithFormat:@"Contact Number: %@",self.contact.contactNumber];
    self.emailLabel.text = [NSString stringWithFormat:@"Email ID: %@",self.contact.emailID];
    
}


- (IBAction)favouriteSwitchClicked:(id)sender
{
    if(self.favouriteSwitch.on)
    {
        [ContactManager addToFavourites:self.contact.index];
    }
    else
    {
        [ContactManager removeFromFavourites:self.contact.index];
    }
}

- (IBAction)editButtonClicked:(id)sender {
    
    [self performSegueWithIdentifier:@"editContact" sender:nil];
}

- (IBAction)deleteButtonClicked:(id)sender
{
    [ContactManager deleteContact:self.contact.index];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                    message:@"Contact Deleted"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"editContact"])
    {
        AddContactViewController *VC = segue.destinationViewController;
        VC.contact = self.contact;
        VC.editCheck = @"YES";
    }
}
@end
