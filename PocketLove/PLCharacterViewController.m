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
}

- (void)updateUI
{
    //labels
    self.nameLabel.text = self.avatar.name;
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.nameLabel sizeToFit];
    [self.timeLabel sizeToFit];
    
    //image
    self.avatarImageView.image = [self imageForMood:self.avatar.mood];
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
    

@end
