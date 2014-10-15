//
//  AppDelegate.m
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import "AppDelegate.h"

#import "PlayersViewController.h"

#import "Player.h"
#import "Club.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    PlayersViewController *playersViewController = [[PlayersViewController alloc] initWithNibName:NSStringFromClass([PlayersViewController class]) bundle:nil];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:playersViewController];
    
    self.window.rootViewController = navigationController;

    [self.window makeKeyAndVisible];
    
    [self performMigrations];
    
    return YES;
}

- (void)performMigrations {
    RLMMigrationBlock migrationBlock = ^NSUInteger(RLMMigration *migration,
                                                   NSUInteger oldSchemaVersion) {

        return 2;
    };
    
    // Apply the migration block above to the default Realm
    [RLMRealm migrateDefaultRealmWithBlock:migrationBlock];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


+ (void)createPlayers {
    
    Player *messi = [Player new];
    [messi setName:@"Lionel Andrés Messi Cuccitini"];
    Club *fcb = [Club new];
    [fcb setName:@"FCB"];
    [messi setCurrentClub:fcb];

    Player *cristiano = [Player new];
    [cristiano setName:@"Cristiano Ronaldo"];
    Club *rm = [Club new];
    [rm setName:@"RM"];
    [cristiano setCurrentClub:rm];
    
    NSDictionary *iniestaJSON = @{
                                  @"name": @"Iniesta",
                                  @"currentClub": @{@"name": @"FCB"}
                                  };
    Player *iniesta = [[Player alloc] initWithObject:iniestaJSON];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObjectsFromArray:@[messi, cristiano]];
        [Player createInDefaultRealmWithObject:iniestaJSON];
    }];
}


@end
