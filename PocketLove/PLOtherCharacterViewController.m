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

- (NSString *)avatarName
{
    return @"You";
}

- (IBAction)goToOtherCharacterView :(UIStoryboardSegue*)segue {
    
}

@end
