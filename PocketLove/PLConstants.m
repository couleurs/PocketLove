//
//  PLConstants.m
//  PocketLove
//
//  Created by Johan Ismael on 5/7/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLConstants.h"

@implementation PLConstants

+ (UIColor *)backgroundColorLight
{
    return [UIColor colorWithRed:0 green:213/255.0 blue:255/255.0 alpha:1.0];
}

+ (UIColor *)backgroundColorDark
{
    return [UIColor colorWithRed:12/255.0 green:12/255.0 blue:74/255.0 alpha:1.0];
}

+ (NSArray *)moodStrings
{
    return @[@"Angry", @"Annoyed", @"Confused", @"Crying", @"Happy", @"Normal", @"Sad", @"Silly", @"Tired"];
}

+ (NSArray *)giftStrings
{
    return @[@"Balloon", @"Cactus", @"Cat", @"Crown", @"Lollipop"];
}

+ (NSArray *)outfitStrings
{
    return @[@"Home", @"Work", @"Sleep"];
}

+ (NSUInteger)numGifts
{
    return [[self giftStrings] count];
}

@end
