//
//  EditPlayerViewController.m
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import "EditPlayerViewController.h"



@interface EditPlayerViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *clubLabel;

@end

@implementation EditPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIBarButtonItem *saveBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    [self.navigationItem setRightBarButtonItem:saveBarButton];
    
    if (self.presentingViewController) {
        UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                         target:self
                                                                                         action:@selector(cancel)];
        [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.player) {
        [self.navigationItem setTitle:self.player.name];
        [self.nameLabel setText:self.player.name];
        [self.clubLabel setText:self.player.currentClub.name];
    } else {
        [self.navigationItem setTitle:@"New Player"];
    }
}

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    
    if ([self.clubLabel.text isEqualToString:@""] || [self.nameLabel.text isEqualToString:@""]) {
        return;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    Club *club = [[Club objectsWhere:@"name = %@", self.clubLabel.text] firstObject];
    if (!club) {
        club = [Club new];
        [club setName:self.clubLabel.text];
        [realm transactionWithBlock:^{
            [realm addObject:club];
        }];
    }
    
    if (!self.player //new player
        || ![self.player.name isEqualToString:self.nameLabel.text]) { //primary key change
        
        if (self.player) {
            [realm transactionWithBlock:^{
                [realm deleteObject:self.player];
            }];
        }
        
        self.player = [Player new];
        [self.player setName:self.nameLabel.text];
    }
    
    [realm transactionWithBlock:^{
        [self.player setCurrentClub:club];
        [realm addOrUpdateObject:self.player];
    }];
    
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
