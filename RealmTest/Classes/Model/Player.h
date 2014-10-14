//
//  Player.h
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import <Realm/Realm.h>

#import "Club.h"

@class Club;

@interface Player : RLMObject

@property NSString          *name;
@property Club              *currentClub;
//@property RLMArray<Club>    *clubs;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Player>
RLM_ARRAY_TYPE(Player)
