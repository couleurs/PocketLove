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
#import "NSDate+PL.h"

@interface PLCharacterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *callAvailabilityImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarBodyImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarHeadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarGiftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarGiftNotificationImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UITextField *thoughtTextField;

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
    [super viewWillAppear:animated];
    [self initializeAvatar];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateUI)
                                                 name:@"AvatarUpdate"
                                               object:nil];
    
    self.view.backgroundColor = [self backgroundColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLabels];
    
    [self setAvatarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(initializeAvatar)
                                                 name:@"LoginReady"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AvatarUpdate"
                                                  object:nil];
}

- (void)initializeAvatar
{
    NSString *avatarLogin = [self avatarLogin];
    
    if (avatarLogin) {
        self.avatar.login = avatarLogin;
    }
}

- (void)updateUI
{
    [self setAvatarHidden:NO];
    
    //labels
    self.timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    [self.timeLabel sizeToFit];
    self.nicknameLabel.text = self.avatar.login;
    [self.nicknameLabel sizeToFit];
    
    //thought
    if (!self.thoughtTextField.isEditing) {
        self.thoughtTextField.text = self.avatar.currentThought;
    }
    
    //avatar
    self.avatarHeadImageView.image = [self headImageForMood:self.avatar.mood];
    self.avatarBodyImageView.image = [self bodyImage:self.avatar.outfit];
    self.avatarGiftImageView.image = [self giftImage];
    self.callAvailabilityImageView.image = [self imageForCallAvailability:self.avatar.isAvailableForCall];
    
    if (self.avatar.hugRecieved == 1) {
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
    
    if (self.avatar.giftRecieved == 1) {
        AudioServicesPlaySystemSound(1004);
        self.avatarGiftNotificationImageView.hidden = NO;
        
        [NSTimer scheduledTimerWithTimeInterval:3.0
                                         target:self
                                       selector:@selector(giftOver:)
                                       userInfo:nil
                                        repeats:NO];
    }
    
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
    self.avatar.hugRecieved = 0;
    [self.avatar save];
}

- (void)giftOver:(NSTimer *)timer {
    self.avatarGiftNotificationImageView.hidden = YES;
    self.avatar.giftRecieved = 0;
    [self.avatar save];
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

- (UIImage *)bodyImage:(NSUInteger)outfit
{
    NSArray *outfitStrings =[PLConstants outfitStrings];
    NSString *imageName = [NSString stringWithFormat:@"%@_Body_%@", [self stringForGender:self.avatar.gender], outfitStrings[outfit]];
    return [UIImage imageNamed:imageName];
}

- (UIImage *)imageForCallAvailability:(BOOL)availability
{
    NSString *imageName = availability ? @"Icon_Green_Phone" : @"Icon_Red_Phone";
    return [UIImage imageNamed:imageName];
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

- (void)setupLabels
{
    [self.nicknameLabel setFont:[UIFont fontWithName:@"pixelated" size:32.0]];
    [self.timeLabel setFont:[UIFont fontWithName:@"pixelated" size:32.0]];
    [self.weatherLabel setFont:[UIFont fontWithName:@"pixelated" size:26.0]];
    [self.thoughtTextField setFont:[UIFont fontWithName:@"pixelated" size:16.0]];
    
    [self.nicknameLabel setTextColor:[UIColor whiteColor]];
    [self.timeLabel setTextColor:[UIColor whiteColor]];
    [self.weatherLabel setTextColor:[UIColor whiteColor]];
    [self.thoughtTextField setTextColor:[UIColor blackColor]];
}

#define LIGHTEST_HOUR 12
#define DARKEST_HOUR 2

- (UIColor *)backgroundColor
{
    //Gets lighter at 6am, darker at 6p
    NSDate *currentTime = [self currentTime];
    
    NSDate *morningTime = [currentTime dateWithHour:DARKEST_HOUR
                                             minute:0
                                             second:0];
    
    NSDate *eveningTime = [currentTime dateWithHour:LIGHTEST_HOUR
                                             minute:0
                                             second:0];
    
    UIColor *bgColor;
    
    CGFloat lightRed, lightGreen, lightBlue;
    CGFloat darkRed, darkGreen, darkBlue;
    UIColor *lightColor = [PLConstants backgroundColorLight];
    UIColor *darkColor = [PLConstants backgroundColorDark];
    
    [lightColor getRed:&lightRed green:&lightGreen blue:&lightBlue alpha:NULL];
    [darkColor getRed:&darkRed green:&darkGreen blue:&darkBlue alpha:NULL];
    
    NSDateComponents *todayComps = [[NSCalendar currentCalendar] components:NSHourCalendarUnit
                                                                   fromDate:currentTime];
    
    //before 6p
    if ([currentTime compare:eveningTime] == NSOrderedAscending) {
        
        float t = (float)(todayComps.hour - DARKEST_HOUR) / (float)(LIGHTEST_HOUR - DARKEST_HOUR);
        
        bgColor = [UIColor colorWithRed:(1-t) * darkRed + t * lightRed
                                  green:(1-t) * darkGreen + t * lightGreen
                                   blue:(1-t) * darkBlue + t * lightBlue
                                  alpha:1.0];

    }
    
    //after
    else {
        float t = (float)(todayComps.hour - LIGHTEST_HOUR) / (float)(LIGHTEST_HOUR - DARKEST_HOUR);
        
        bgColor = [UIColor colorWithRed:(1-t) * lightRed + t * darkRed
                                  green:(1-t) * lightGreen + t * darkGreen
                                   blue:(1-t) * lightBlue + t * darkBlue
                                  alpha:1.0];
    }
    
    return bgColor;
}


@end
