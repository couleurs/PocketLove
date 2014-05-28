//
//  Avatar.m
//  PocketLove
//
//  Created by Johan Ismael on 5/6/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "Avatar.h"
#import <Firebase/Firebase.h>

@interface Avatar()

@property (strong, nonatomic) Firebase *firebase;

@end

@implementation Avatar

- (void)setLogin:(NSString *)login
{
    _login = login;
    NSString *urlString = [NSString stringWithFormat:@"https://torid-fire-3779.firebaseio.com/users/%@/", _login];
    _firebase = [[Firebase alloc] initWithUrl:urlString];
    [_firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        [self avatarValueChanged:snapshot];
    }];
}

- (void)save
{
    [self.firebase setValue:@{@"mood": @(self.mood),
                              @"gender": @(self.gender),
                              @"outfit": @(self.outfit),
                              @"availableForCall": @(self.isAvailableForCall),
                              @"gift": @(self.gift),
                              @"phoneNumber": self.phoneNumber,
                              @"currentThought": self.currentThought}];
}

- (void)avatarValueChanged:(FDataSnapshot *)snapshot
{
    NSNumber *mood = snapshot.value[@"mood"];
    NSNumber *gender = snapshot.value[@"gender"];
    NSNumber *outfit = snapshot.value[@"outfit"];
    NSNumber *availableForCall = snapshot.value[@"availableForCall"];
    NSNumber *gift = snapshot.value[@"gift"];
    self.mood = [mood integerValue];
    self.gender = [gender integerValue];
    self.gift = [gift integerValue];
    self.outfit = [outfit integerValue];
    self.callAvailability = [availableForCall boolValue];
    self.phoneNumber = snapshot.value[@"phoneNumber"];
    self.currentThought = snapshot.value[@"currentThought"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AvatarUpdate"
                                                        object:nil];
}

@end
