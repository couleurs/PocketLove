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
                              @"atWork": @(self.atWork),
                              @"availableForCall": @(self.isAvailableForCall)}];
}

- (void)avatarValueChanged:(FDataSnapshot *)snapshot
{
    NSNumber *mood = snapshot.value[@"mood"];
    NSNumber *gender = snapshot.value[@"gender"];
    NSNumber *atWork = snapshot.value[@"atWork"];
    NSNumber *availableForCall = snapshot.value[@"availableForCall"];
    self.mood = [mood integerValue];
    self.gender = [gender integerValue];
    self.atWork = [atWork boolValue];
    self.callAvailability = [availableForCall boolValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoodChanged"
                                                        object:nil];
}

@end
