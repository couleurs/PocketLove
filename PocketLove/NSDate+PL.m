//
//  NSDate+PL.m
//  PocketLove
//
//  Created by Johan Ismael on 6/2/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "NSDate+PL.h"

@implementation NSDate (PL)

- (NSDate *)dateWithHour:(NSInteger)hour
                  minute:(NSInteger)minute
                  second:(NSInteger)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components: NSYearCalendarUnit|
                                    NSMonthCalendarUnit|
                                    NSDayCalendarUnit
                                               fromDate:self];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

@end
