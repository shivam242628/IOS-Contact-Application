//
//  FavouritesViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "FavouritesViewController.h"
#import "Contacts.h"
#import "ContactManager.h"

@interface FavouritesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
}
@property (strong, nonatomic) IBOutlet UITableView *favouritesTable;
@property NSMutableArray *contactList;
@property NSMutableArray *favouritesList;

@end

@implementation FavouritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favouritesTable.delegate = self;
    self.favouritesTable.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.favouritesList = [NSMutableArray new];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *favouriteObject = [userdeafaults objectForKey:@"contactDB"];
    self.contactList = [NSKeyedUnarchiver unarchiveObjectWithData:favouriteObject];
    for(int i=0;i<self.contactList.count;i++)
    {
        Contacts *contact = [self.contactList objectAtIndex:i];
        if([contact.favourite isEqualToString:@"YES"])
        {
            [self.favouritesList addObject:contact];
        }
    }
    [self.favouritesTable reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.favouritesList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favouriteCell"];
    Contacts *contact = [Contacts new];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"favouriteCell"];
    }
    
    contact = [self.favouritesList objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[contact firstName],[contact lastName]];
    cell.detailTextLabel.text = [contact contactNumber];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Contacts *contact = [Contacts new];
    contact = [self.favouritesList objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",[contact contactNumber]]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    [ContactManager addToRecents:contact];
}
@end
