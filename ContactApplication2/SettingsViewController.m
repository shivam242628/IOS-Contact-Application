//
//  SettingsViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "SettingsViewController.h"
#import "LoginViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
- (IBAction)logoutButtonClicked:(id)sender;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userImage.layer.cornerRadius = 65;
    self.userImage.layer.masksToBounds = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)logoutButtonClicked:(id)sender
{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self performSegueWithIdentifier:@"unwindToLogin" sender:nil];
}
@end
