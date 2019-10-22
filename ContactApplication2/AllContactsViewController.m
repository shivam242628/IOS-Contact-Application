//
//  AllContactsViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "AllContactsViewController.h"
#import "Contacts.h"
#import "ContactDetailsViewController.h"
#import "ContactManager.h"

@interface AllContactsViewController ()<UITableViewDelegate,UITableViewDataSource>{
    Contacts *selectedContact;
}

@property (strong,nonatomic) NSMutableArray *contactList;
@property (strong, nonatomic) IBOutlet UITableView *contactTable;
@end

@implementation AllContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.contactTable.delegate = self;
    self.contactTable.dataSource = self;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"contactDB"];
    self.contactList = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    [self.contactTable reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell"];
    Contacts *contact = [Contacts new];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"contactCell"];
    }
    
    contact = [self.contactList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[contact firstName],[contact lastName]];
    cell.detailTextLabel.text = [contact contactNumber];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Contacts *contact = [Contacts new];
    contact = [self.contactList objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[contact contactNumber]]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    [ContactManager addToRecents:contact];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Contacts *contact = [Contacts new];
    contact = [self.contactList objectAtIndex:indexPath.row];
    selectedContact = contact;
    selectedContact.index = indexPath.row;
    [self performSegueWithIdentifier:@"showDetails" sender:nil];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showDetails"])
    {
        ContactDetailsViewController *VC = segue.destinationViewController;
        VC.contact = selectedContact;
    }
}

@end
