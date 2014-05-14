//
//  PLOtherCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLOtherCharacterViewController.h"

@interface PLOtherCharacterViewController ()

@end

@implementation PLOtherCharacterViewController

- (NSDate *)currentTime
{
    NSDate *now = [NSDate date];
    
    //3 hours before now
    return [now dateByAddingTimeInterval:3*60*60];
}

- (NSString *)avatarLogin
{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    return [userDefaults objectForKey:@"OtherNameKey"];
    return @"Kasey";
}

- (IBAction)goToOtherCharacterView :(UIStoryboardSegue*)segue {
    
}

@end
