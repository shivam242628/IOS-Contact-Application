//
//  RecentViewController.m
//  ContactApplication2
//
//  Created by Shivam Srivastava on 12/06/18.
//  Copyright © 2018 Shivam Srivastava. All rights reserved.
//

#import "RecentViewController.h"
#import "Contacts.h"

@interface RecentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) IBOutlet UICollectionView *recentsCollection;
@property (strong,nonatomic) NSMutableArray *recentsList;
@end



@implementation RecentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)viewWillAppear:(BOOL)animated
{
    self.recentsList = [[NSMutableArray alloc]init];
    NSUserDefaults *userdeafaults = [NSUserDefaults standardUserDefaults];
    NSData *contactObject = [userdeafaults objectForKey:@"recentsDB"];
    self.recentsList = [NSKeyedUnarchiver unarchiveObjectWithData:contactObject];
    self.recentsCollection.dataSource = self;
    self.recentsCollection.delegate = self;
    [self.recentsCollection reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.recentsList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Contacts *contact = [Contacts new];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc]init];
    }
    cell.layer.cornerRadius = 60;
    contact = [self.recentsList objectAtIndex:indexPath.row];
    UILabel *number = (UILabel *)[cell viewWithTag:1];
    number.text = [NSString stringWithFormat:@"%@",[contact contactNumber]];
    UILabel *lastCallDetails = (UILabel *)[cell viewWithTag:2];
    lastCallDetails.text = [NSString stringWithFormat:@"%@",[contact lastCallDetails]];
    return cell;
    
}


@end
