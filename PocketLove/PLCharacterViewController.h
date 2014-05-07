//
//  PLCharacterViewController.h
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Avatar.h"

@interface PLCharacterViewController : UIViewController

@property (strong, nonatomic) Avatar *avatar;

//abstract methods
- (NSDate *)currentTime;

@end
