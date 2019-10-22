//
//  LoginViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UIView *overlayView;
- (IBAction)loginButtonClicked:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginButton.layer.cornerRadius = 10;
    self.loginButton.layer.masksToBounds = YES;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tapRecognizer];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSObject *object = [userdeafaults objectForKey:@"loginDB"];
    if(object == nil)
    {
        self.overlayView.hidden = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    else{
        self.overlayView.hidden = NO;
        [self performSegueWithIdentifier:@"loggedIn" sender:self];
    }
    
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

- (IBAction)unwindToContainerVC:(UIStoryboardSegue *)segue {
    
}

- (void)hideKeyboard{
    [self.view endEditing:YES];
}








- (IBAction)loginButtonClicked:(id)sender
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *message;
    if([self.emailTextField.text isEqualToString:@"shivam@lsq.com"] && [self.passWordTextField.text isEqualToString:@"password"])
    {
        NSData *contactObject = [NSKeyedArchiver archivedDataWithRootObject:@"userLoggedIn"];
        [[NSUserDefaults standardUserDefaults] setObject:contactObject forKey:@"loginDB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self performSegueWithIdentifier:@"login" sender:self];
    }
    else
    {
        NSPredicate *myTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if([self.emailTextField.text isEqualToString:@""] || [self.passWordTextField.text isEqualToString:@""])
        {
            message = @"Fields cannot be empty.";
        }
        else
        if (![myTest evaluateWithObject: self.emailTextField.text]){
            message = @"Email ID is not in correct format";
        }
        else{
            message = @"Wrong Credentials";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

@end
