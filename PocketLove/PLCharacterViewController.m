//
//  PLCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//
#import <AudioToolbox/AudioToolbox.h>
#import "PLCharacterViewController.h"
#import "PLConstants.h"

@interface PLCharacterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *callAvailabilityImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarBodyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarHeadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarGiftImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

@implementation PLCharacterViewController

- (Avatar *)avatar
{
    if (!_avatar) {
        _avatar = [[Avatar alloc] init];
        _avatar.login = [self avatarLogin];
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
    [self initializeAvatar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [PLConstants backgroundColor];
    [self setAvatarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initializeAvatar)
                                                 name:@"LoginReady"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"MoodChanged"
                                               object:nil];
    
}

- (void)initializeAvatar
{
    NSString *avatarLogin = [self avatarLogin];
    
    if (avatarLogin)
        self.avatar.login = avatarLogin;
}

- (void)updateUI
{
    [self setAvatarHidden:NO];
    
    //labels
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.timeLabel sizeToFit];
    self.nicknameLabel.text = self.avatar.login;
    [self.nicknameLabel sizeToFit];
    
    //avatar
    self.avatarHeadImageView.image = [self headImageForMood:self.avatar.mood];
    self.avatarBodyImageView.image = [self bodyImage];
    self.avatarGiftImageView.image = [self giftImage];
    self.callAvailabilityImageView.image = [self imageForCallAvailability:self.avatar.isAvailableForCall];
}

#pragma mark - Actions

- (IBAction)hugTapped:(UIButton *)sender {
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(hugOver:)
                                   userInfo:nil
                                    repeats:NO];
}

/*actual hug button?*/
- (IBAction)hug:(id)sender {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    self.avatarHeadImageView.image = [UIImage imageNamed:@"Action_Hug"];
    self.avatarBodyImageView.hidden = YES;
    self.avatarGiftImageView.hidden = YES;

    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(over:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)hugOver:(NSTimer *)timer
{
}

- (void)over:(NSTimer *)timer
{
    self.avatarHeadImageView.image = [self headImageForMood:self.avatar.mood];
    self.avatarBodyImageView.hidden = NO;
    self.avatarGiftImageView.hidden = NO;
}


- (IBAction)PokeAlert:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Poke Johan?"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
#pragma mark - Abstract methods

- (NSDate *)currentTime
{
    return nil;
}

- (NSString *)avatarLogin
{
    return @"";
}

#pragma mark - Privates

- (UIImage *)giftImage
{
    if (!self.avatar.gift)
        return nil;
    
    NSArray *giftStrings =[PLConstants giftStrings];
    NSString *imageName = [NSString stringWithFormat:@"Gift_%@", giftStrings[self.avatar.gift - 1]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)headImageForMood:(NSUInteger)mood
{
    NSArray *moodStrings =[PLConstants moodStrings];
    NSString *imageName = [NSString stringWithFormat:@"%@_Head_%@", [self stringForGender:self.avatar.gender], moodStrings[mood]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)bodyImage
{
    NSString *imageName = [NSString stringWithFormat:@"%@_Body_%@", [self stringForGender:self.avatar.gender], self.avatar.isAtWork ? @"Work" : @"Home"];
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

- (void)setAvatarHidden:(BOOL)hidden
{
    self.avatarBodyImageView.hidden = hidden;
    self.avatarHeadImageView.hidden = hidden;
    self.avatarGiftImageView.hidden = hidden;
    
    if (!hidden)
        [self.spinner stopAnimating];
}

@end
