//
//  PLOtherCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLOtherCharacterViewController.h"
#import "PLConstants.h"

@interface PLOtherCharacterViewController ()

@end

@implementation PLOtherCharacterViewController

#pragma mark - Actions

- (IBAction)giftTapped:(UIButton *)sender
{
    self.avatar.gift = (arc4random() % [PLConstants numGifts]) + 1;
    [self.avatar save];
}

- (NSDate *)currentTime
{
    NSDate *now = [NSDate date];
    
    //3 hours before now
    return [now dateByAddingTimeInterval:3*60*60];
}

- (NSString *)avatarLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"OtherNameKey"];
}

- (IBAction)goToOtherCharacterView :(UIStoryboardSegue*)segue {
    
}

@end
