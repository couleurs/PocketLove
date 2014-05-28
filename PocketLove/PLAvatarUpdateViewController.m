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
@property (nonatomic, strong) NSMutableArray *avatarOutfitImages;
@property (nonatomic, strong) NSIndexPath *moodSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath *outfitSelectedIndexPath;
@property (weak, nonatomic) IBOutlet UISwitch *callAvailabilitySwitch;
@property (weak, nonatomic) IBOutlet UICollectionView *moodCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *outfitCollectionView;

@end

@implementation PLAvatarUpdateViewController

- (void)setMoodCollectionView:(UICollectionView *)moodCollectionView
{
    _moodCollectionView = moodCollectionView;
    moodCollectionView.allowsSelection = YES;
    moodCollectionView.allowsMultipleSelection = NO;
}

- (void)setOutfitCollectionView:(UICollectionView *)outfitCollectionView
{
    _outfitCollectionView = outfitCollectionView;
    outfitCollectionView.allowsSelection = YES;
    outfitCollectionView.allowsMultipleSelection = NO;
}

- (NSMutableArray *)avatarMoodImages
{
    if (!_avatarMoodImages) {
        _avatarMoodImages = [[NSMutableArray alloc] init];
        for (NSString *mood in [PLConstants moodStrings]) {
            [_avatarMoodImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Emotion_%@", [self stringForGender:self.avatar.gender], mood]]];
        }
    }
    return _avatarMoodImages;
}

- (NSMutableArray *)avatarOutfitImages
{
    if (!_avatarOutfitImages) {
        _avatarOutfitImages = [[NSMutableArray alloc] init];
        for (NSString *outfit in [PLConstants outfitStrings]) {
            [_avatarOutfitImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@_Outfit_%@", [self stringForGender:self.avatar.gender], outfit]]];
        }
    }
    return _avatarOutfitImages;
}

- (NSString *)stringForGender:(NSUInteger)gender
{
    return (gender == 0) ? @"Boy" : @"Girl";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [PLConstants backgroundColor];
    
    //synchronize with avatar state
    self.callAvailabilitySwitch.on = self.avatar.isAvailableForCall;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.avatar.mood inSection:0];
    [self highlightCellAtIndexPath:indexPath collectionView:self.moodCollectionView];
    [self.moodCollectionView selectItemAtIndexPath:indexPath
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionLeft];
    
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:self.avatar.outfit inSection:0];
    [self highlightCellAtIndexPath:indexPath2 collectionView:self.outfitCollectionView];
    [self.outfitCollectionView selectItemAtIndexPath:indexPath2
                                          animated:YES
                                    scrollPosition:UICollectionViewScrollPositionLeft];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"DismissAvatarUpdate"]) {
        self.avatar.callAvailability = self.callAvailabilitySwitch.isOn;
        self.avatar.outfit = self.outfitSelectedIndexPath.row;
        self.avatar.mood = self.moodSelectedIndexPath.row;
        [self.avatar save];
    }
}

#pragma mark - UICollectionView protocols

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.moodCollectionView) {
        return [self.avatarMoodImages count];
    } else {
        return [self.avatarOutfitImages count];
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[ImageCollectionViewCell alloc] init];
    }
    
    if (collectionView == self.moodCollectionView) {
        cell.imageView.image = self.avatarMoodImages[indexPath.row];
    } else {
        cell.imageView.image = self.avatarOutfitImages[indexPath.row];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self highlightCellAtIndexPath:indexPath
                    collectionView:collectionView];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    cell.layer.borderWidth = 0.0f;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    // Will crash if return nil
    
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        NSString *reuseIdentifier = (collectionView == self.moodCollectionView) ? @"MoodHeader" : @"OutfitHeader";
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                              withReuseIdentifier:@"OutfitFooter" forIndexPath:indexPath];
    }
    return view;
}

#pragma mark - Privates

- (void)highlightCellAtIndexPath:(NSIndexPath *)indexPath
                  collectionView:(UICollectionView *)collectionView
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [self addBorderToView:cell];
    
    if (collectionView == self.moodCollectionView) {
        if (self.moodSelectedIndexPath) {
            [collectionView deselectItemAtIndexPath:self.moodSelectedIndexPath animated:YES];
        }
        self.moodSelectedIndexPath = indexPath;
    } else {
        if (self.outfitSelectedIndexPath) {
            [collectionView deselectItemAtIndexPath:self.outfitSelectedIndexPath animated:YES];
        }
        self.outfitSelectedIndexPath = indexPath;
    }
}

- (void)addBorderToView:(UIView *)view
{
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0f;
}



@end
