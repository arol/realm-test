//
//  Club.m
//  RealmTest
//
//  Created by Lluís Gómez Hernando on 13/10/14.
//  Copyright (c) 2014 Lafosca. All rights reserved.
//

#import "Club.h"

@implementation Club

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

+ (NSString *)primaryKey {
    return NSStringFromSelector(@selector(name));
}

@end
