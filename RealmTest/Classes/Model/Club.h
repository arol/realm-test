//
//  Club.h
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import <Realm/Realm.h>

#import "Player.h"

@class Player;

@interface Club : RLMObject

@property NSString          *name;
//@property RLMArray<Player>  *players;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Club>
RLM_ARRAY_TYPE(Club)
