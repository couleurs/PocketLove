//
//  PLRootViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLRootViewController.h"
#import "PLOtherCharacterViewController.h"
#import "PLMyCharacterViewController.h"
#import "PLLoginViewController.h"

@interface PLRootViewController ()

@end

@implementation PLRootViewController

- (void)setupPageViewController
{
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    UIViewController *startingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PLOtherCharacterViewController"];
    NSArray *viewControllers = @[startingVC];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];
    
    // Add the page view controller's gesture recognizers to the book view controller's view so that the gestures are started more easily.
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:213/255.0 blue:255/255.0 alpha:1.0];

    [self setupPageViewController];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:@"LoggedIn"]) {
        PLLoginViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"PLLoginViewController"];
        [self presentViewController:lvc animated:YES completion:NULL];
    }
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[PLMyCharacterViewController class]]) {
        return [viewController.storyboard instantiateViewControllerWithIdentifier:@"PLOtherCharacterViewController"];
    } else return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[PLOtherCharacterViewController class]]) {
        return [viewController.storyboard instantiateViewControllerWithIdentifier:@"PLMyCharacterViewController"];
    } else return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

#pragma mark - Segues

- (IBAction)loginControllerDismissed:(UIStoryboardSegue *)segue
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    PLLoginViewController *lvc = segue.sourceViewController;
    
    //What if text fields are empty?
    [userDefaults setValue:lvc.yourNameTextField.text forKey:@"YourNameKey"];
    [userDefaults setValue:lvc.otherNameTextField.text forKey:@"OtherNameKey"];
    [userDefaults setValue:@(YES) forKey:@"LoggedIn"];
    [userDefaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginReady"
                                                        object:nil];
}

@end
