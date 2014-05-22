//
//  PLGameMenuViewController.m
//  PocketLove
//
//  Created by Nicole Zhu on 5/7/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLGameMenuViewController.h"

@interface PLGameMenuViewController ()

@end

@implementation PLGameMenuViewController

- (void)awakeFromNib
{
    [[UILabel appearanceWhenContainedIn:[self class], nil] setFont:[UIFont fontWithName:@"pixelated" size:16.0]];
    [[UILabel appearanceWhenContainedIn:[self class], nil] setTextColor:[UIColor blackColor]];
    [[UILabel appearanceWhenContainedIn:[self class], nil] setTextAlignment:NSTextAlignmentCenter];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
