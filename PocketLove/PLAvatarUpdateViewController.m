//
//  PLAvatarUpdateViewController.m
//  PocketLove
//
//  Created by Johan Ismael on 5/4/14.
//  Copyright (c) 2014 Johan Ismael. All rights reserved.
//

#import "PLAvatarUpdateViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ImageCollectionViewCell.h"
#import "PLConstants.h"

@interface PLAvatarUpdateViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *avatarMoodImages;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (weak, nonatomic) IBOutlet UISwitch *callAvailabilitySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *atWorkSwitch;
@property (weak, nonatomic) IBOutlet UICollectionView *moodCollectionView;

@end

@implementation PLAvatarUpdateViewController

- (void)setMoodCollectionView:(UICollectionView *)moodCollectionView
{
    _moodCollectionView = moodCollectionView;
    moodCollectionView.allowsSelection = YES;
    moodCollectionView.allowsMultipleSelection = NO;
}

- (NSMutableArray *)avatarMoodImages
{
    if (!_avatarMoodImages) {
        _avatarMoodImages = [[NSMutableArray alloc] init];
        for (NSString *mood in [PLConstants moodStrings]) {
            [_avatarMoodImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Boy_Emotion_%@", mood]]];
        }
    }
    return _avatarMoodImages;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [PLConstants backgroundColor];
    
    //synchronize with avatar state
    self.callAvailabilitySwitch.on = self.avatar.isAvailableForCall;
    self.atWorkSwitch.on = self.avatar.isAtWork;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.avatar.mood inSection:0];
    [self highlightCellAtIndexPath:indexPath];
    [self.moodCollectionView selectItemAtIndexPath:indexPath
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionLeft];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DismissAvatarUpdate"]) {
        self.avatar.callAvailability = self.callAvailabilitySwitch.isOn;
        self.avatar.atWork = self.atWorkSwitch.isOn;
        self.avatar.mood = self.selectedIndexPath.row;
    }
}

#pragma mark - UICollectionView protocols

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.avatarMoodImages count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ImageCollectionViewCell alloc] init];
    }
    
    cell.imageView.image = self.avatarMoodImages[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self highlightCellAtIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    cell.layer.borderWidth = 0.0f;
}

#pragma mark - Privates

- (void)highlightCellAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.moodCollectionView cellForItemAtIndexPath:indexPath];
    [self addBorderToView:cell];
    
    if (self.selectedIndexPath) {
        [self.moodCollectionView deselectItemAtIndexPath:self.selectedIndexPath animated:YES];
    }
    
    self.selectedIndexPath = indexPath;
}

- (void)addBorderToView:(UIView *)view
{
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0f;
}



@end
