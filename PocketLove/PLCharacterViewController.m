//
//  PLCharacterViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLCharacterViewController.h"

@interface PLCharacterViewController ()

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation PLCharacterViewController

- (NSString *)formattedStringFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"hh:mm a"];
    return [formatter stringFromDate:date];
}

- (void)setTimeLabel:(UILabel *)timeLabel
{
    _timeLabel = timeLabel;
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = [self formattedStringFromDate:[self currentTime]];
    timeLabel.font = [UIFont fontWithName:@"pixelated" size:32];
    timeLabel.textColor = [UIColor whiteColor];
    [timeLabel sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:213/255.0 blue:255/255.0 alpha:1.0];
}

#pragma mark - Abstract methods

- (NSDate *)currentTime
{
    return nil;
}

@end
