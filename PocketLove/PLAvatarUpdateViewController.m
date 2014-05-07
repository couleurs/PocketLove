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

@end

@implementation PLAvatarUpdateViewController

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
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 3.0f;
    
    if (self.selectedIndexPath) {
        [collectionView deselectItemAtIndexPath:self.selectedIndexPath animated:YES];
    }
    
    self.avatar.mood = indexPath.row;
    self.selectedIndexPath = indexPath;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.layer.borderColor = [UIColor clearColor].CGColor;
    cell.layer.borderWidth = 0.0f;
}

- (void)addBorderToView:(UIView *)view
{
    view.layer.borderColor = [UIColor whiteColor].CGColor;
    view.layer.borderWidth = 3.0f;
}



@end
