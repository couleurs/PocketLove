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

//method subclass should be able to call
- (void)updateUI;

//abstract methods
- (NSDate *)currentTime;
- (NSString *)avatarLogin;

@end
