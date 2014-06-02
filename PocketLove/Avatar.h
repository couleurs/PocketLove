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
@property (nonatomic) NSString *phoneNumber;
@property (nonatomic) NSString *currentThought;
@property (nonatomic) NSUInteger mood; //0-6
@property (nonatomic) NSUInteger outfit; //0-2
@property (nonatomic) NSUInteger gender; //0 for boy, 1 for girl
@property (nonatomic) NSUInteger gift; //0-6, 0 for no gift
@property (nonatomic) NSUInteger hugRecieved; //0 for no hug, 1 for hug
@property (nonatomic) NSUInteger giftRecieved; //0 for no gift, 1 for gift
@property (nonatomic, getter = isAvailableForCall) BOOL callAvailability;

- (void)save; //send data to Firebase

@end
