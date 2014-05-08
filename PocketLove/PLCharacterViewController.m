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

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *callAvailabilityImageView;

@end

@implementation PLCharacterViewController

- (Avatar *)avatar
{
    if (!_avatar) {
        _avatar = [[Avatar alloc] init];
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
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.timeLabel sizeToFit];
    
    //avatar
    self.avatarImageView.image = [self imageForMood:self.avatar.mood];
    self.callAvailabilityImageView.image = [self imageForCallAvailability:self.avatar.isAvailableForCall];
}

#pragma mark - Actions

- (IBAction)hugTapped:(UIButton *)sender {
    self.avatarImageView.image = [UIImage imageNamed:@"Action_Hug"];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(hugOver:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)hugOver:(NSTimer *)timer
{
    self.avatarImageView.image = [self imageForMood:self.avatar.mood];
}

#pragma mark - Abstract methods

- (NSDate *)currentTime
{
    return nil;
}

- (NSUInteger)avatarGender
{
    return 0;
}

#pragma mark - Privates

- (UIImage *)imageForMood:(NSUInteger)mood
{
    NSArray *moodStrings =[PLConstants moodStrings];
    NSString *imageName = [NSString stringWithFormat:@"%@_%@_%@", [self stringForGender:[self avatarGender]], [self stringForWorkStatus:self.avatar.isAtWork], moodStrings[mood]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)imageForCallAvailability:(BOOL)availability
{
    NSString *imageName = availability ? @"Icon_Green_Phone" : @"Icon_Red_Phone";
    return [UIImage imageNamed:imageName];
}

- (NSString *)stringForWorkStatus:(BOOL)atWork
{
    return atWork ? @"Work" : @"Home";
}

- (NSString *)stringForGender:(NSUInteger)gender
{
    return (gender == 0) ? @"Boy" : @"Girl";
}

@end
