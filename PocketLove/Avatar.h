//
//  Avatar.h
//  PocketLove
//
//  Created by Johan Ismael on 5/6/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Avatar : NSObject

@property (nonatomic) NSUInteger mood; //0-6
@property (nonatomic, strong) NSString *name;
@property (nonatomic, getter = isAvailableForCall) BOOL callAvailability;

@end
