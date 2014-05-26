//
//  PLMyCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLMyCharacterViewController.h"
#import "PLAvatarUpdateViewController.h"

@interface PLMyCharacterViewController ()

@end

@implementation PLMyCharacterViewController

- (NSDate *)currentTime
{
    return [NSDate date];
}

- (NSString *)avatarLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:@"YourNameKey"];
}

#pragma mark - Gestures

- (IBAction)tappedPhoneIcon:(UITapGestureRecognizer *)sender
{
    self.avatar.callAvailability = !self.avatar.callAvailability;
    [self.avatar save];
    [self updateUI];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"UpdateAvatar"]) {
        PLAvatarUpdateViewController *plauvc = (PLAvatarUpdateViewController *)segue.destinationViewController;
        plauvc.avatar = self.avatar;
    }
}

- (IBAction)avatarUpdated:(UIStoryboardSegue *)segue
{
}

@end
