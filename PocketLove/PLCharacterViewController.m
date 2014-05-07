//
//  PLCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLCharacterViewController.h"
#import "PLConstants.h"

@interface PLCharacterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *callAvailabilityImageView;

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

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [PLConstants backgroundColor];
}

- (void)updateUI
{
    //labels
    self.nameLabel.text = self.avatar.name;
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.nameLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
    //avatar
    self.avatarImageView.image = [self imageForMood:self.avatar.mood];
    self.callAvailabilityImageView.image = [self imageForCallAvailability:self.avatar.isAvailableForCall];
}

#pragma mark - Abstract methods

- (NSDate *)currentTime
{
    return nil;
}

#pragma mark - Privates

- (UIImage *)imageForMood:(NSUInteger)mood
{
    NSArray *moodStrings =[PLConstants moodStrings];
    NSString *imageName = [NSString stringWithFormat:@"Boy_Home_%@", moodStrings[mood]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)imageForCallAvailability:(BOOL)availability
{
    NSString *imageName = availability ? @"Icon_Green_Phone" : @"Icon_Red_Phone";
    return [UIImage imageNamed:imageName];
}

@end
