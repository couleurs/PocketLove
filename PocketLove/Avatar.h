//
//  Avatar.h
//  PocketLove
//
//  Created by Johan Ismael on 5/6/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Avatar : NSObject

@property (nonatomic) NSString *login;
@property (nonatomic) NSUInteger mood; //0-6
@property (nonatomic) NSUInteger gender; //0 for boy, 1 for girl
@property (nonatomic, getter = isAvailableForCall) BOOL callAvailability;
@property (nonatomic, getter = isAtWork) BOOL atWork;

- (void)save; //send data to Firebase

@end
