//
//  PLCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLCharacterViewController.h"

@interface PLCharacterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PLCharacterViewController

- (Avatar *)avatar
{
    if (!_avatar) {
        _avatar = [[Avatar alloc] init];
        _avatar.name = @"Kasey";
        _avatar.mood = 0;
    }
    return _avatar;
}

- (NSString *)formattedStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"hh:mm a"];
    return [formatter stringFromDate:date];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:213/255.0 blue:255/255.0 alpha:1.0];
    [self updateUI];
}

- (void)updateUI
{
    self.nameLabel.text = self.avatar.name;
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.nameLabel sizeToFit];
    [self.timeLabel sizeToFit];
}

#pragma mark - Abstract methods

- (NSDate *)currentTime
{
    return nil;
}

@end
