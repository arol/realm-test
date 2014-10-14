//
//  PlayersViewController.m
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import "PlayersViewController.h"

#import "EditPlayerViewController.h"

#import "Player.h"
#import "Club.h"

#define kCellID @"Cell"

@interface PlayersViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property RLMArray *allPlayers;
@property RLMNotificationToken *token;

@end

@implementation PlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Players"];
    
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target:self
                                                                                  action:@selector(presentNewPlayer)];
    [self.navigationItem setRightBarButtonItem:addBarButton];
    
    [self.tableView setTableFooterView:[UIView new]];
    
    self.allPlayers = [[Player allObjects] arraySortedByProperty:@"name" ascending:YES];
    
    self.token = [[RLMRealm defaultRealm] addNotificationBlock:^(NSString *note, RLMRealm * realm) {
        self.allPlayers = [[Player allObjects] arraySortedByProperty:@"name" ascending:YES];
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)presentNewPlayer {
    EditPlayerViewController *editVC  = [[EditPlayerViewController alloc] initWithNibName:NSStringFromClass([EditPlayerViewController class]) bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:editVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allPlayers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellID];
    }

    Player *player = self.allPlayers[indexPath.row];
    
    [cell.textLabel setText:player.name];
    [cell.detailTextLabel setText:player.currentClub.name];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EditPlayerViewController *editVC  = [[EditPlayerViewController alloc] initWithNibName:NSStringFromClass([EditPlayerViewController class]) bundle:nil];
    [editVC setPlayer:self.allPlayers[indexPath.row]];
    [self.navigationController pushViewController:editVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        Player *deletedPlayer = self.allPlayers[indexPath.row];
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObject:deletedPlayer];
        }];
    }
}


@end
