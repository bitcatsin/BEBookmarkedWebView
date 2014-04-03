//
//  BEBookmarkLayout.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 26/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkLayout.h"
#import "BEBookmarkHtmlTagInfo.h"


#import "BEBookmarkDataSource.h"


const CGFloat kBEBookmarkStandardHeight = 66.f;

@implementation BEBookmarkLayout

#pragma mark - Overrided as Jobs Docs assumes

- (CGSize)collectionViewContentSize {

    CGFloat contentWidth = 0.f;
    CGFloat contentHeight = 0.f;

    // Width - just as bounds
    contentWidth = self.collectionView.bounds.size.width;

    // Height - as delegate said
    contentHeight = [self collectionViewContentHeight];

    return CGSizeMake(contentWidth, contentHeight);
}

- (CGFloat)collectionViewContentHeight {
    if (_bookmarkRootDelegate && [_bookmarkRootDelegate respondsToSelector:@selector(beBookmarkLayoutContentHeight:)]) {
        return [_bookmarkRootDelegate beBookmarkLayoutContentHeight:self];
    }
    return 1000.f;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    CGRect oldBounds = self.collectionView.bounds;
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
//        NSLog(@"Invalidation layout for bounds change");
        return YES;
    }
//    NSLog(@"NOT invalidation layout for bounds change");
    return NO;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];

    // Cells
    // We call a custom helper method -indexPathsOfItemsInRect: here
    // which computes the index paths of the cells that should be included
    // in rect.
    NSArray *visibleIndexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in visibleIndexPaths) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [layoutAttributes addObject:attributes];
    }
//
//    // Supplementary views
//    NSArray *dayHeaderViewIndexPaths = [self indexPathsOfDayHeaderViewsInRect:rect];
//    for (NSIndexPath *indexPath in dayHeaderViewIndexPaths) {
//        UICollectionViewLayoutAttributes *attributes =
//        [self layoutAttributesForSupplementaryViewOfKind:@"DayHeaderView"
//                                             atIndexPath:indexPath];
//        [layoutAttributes addObject:attributes];
//    }
//    NSArray *hourHeaderViewIndexPaths =
//    [self indexPathsOfHourHeaderViewsInRect:rect];
//    for (NSIndexPath *indexPath in hourHeaderViewIndexPaths) {
//        UICollectionViewLayoutAttributes *attributes =
//        [self layoutAttributesForSupplementaryViewOfKind:@"HourHeaderView"
//                                             atIndexPath:indexPath];
//        [layoutAttributes addObject:attributes];
//    }

    return layoutAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {

    BEBookmarkDataSource *infoSource = self.collectionView.dataSource;
    BEBookmarkHtmlTagInfo *tagInfo = [infoSource bookmarkAtIndexPath:indexPath];

    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];;

    if (tagInfo) {
        attrs.frame = [self bookmarkRectForTagRect:tagInfo.tagLayer.frame withIndexPath:indexPath];
    }
    return attrs;
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect {

    NSMutableArray *resultArray = [NSMutableArray array];

    BEBookmarkDataSource *infoSource = self.collectionView.dataSource;
    if ([infoSource isKindOfClass:[BEBookmarkDataSource class]]) {


    NSArray *bookmarksData = infoSource.bookmarksInfoData;

    CGFloat startYPos = CGRectGetMinY(rect) - kBEBookmarkStandardHeight;
    CGFloat stopYPos = CGRectGetMaxY(rect);
    NSInteger index = 0.f;

    for (BEBookmarkHtmlTagInfo * bookmarkInfo in bookmarksData) {

        CGFloat tagPositionY = CGRectGetMinY([bookmarkInfo htmlTagRect]);
        if (tagPositionY >= startYPos && tagPositionY < stopYPos) {

                NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:index inSection:0.f];
                [resultArray addObject:newIndexPath];
        }

        index ++;
    }
    }
    return resultArray;
}

- (CGRect)bookmarkRectForTagRect:(CGRect)htmlTagFrame withIndexPath:(NSIndexPath *)indexPath {
    CGRect resultRect = CGRectMake([self bookmarkXForIndexPath:indexPath], [self bookmarkYForIndexPath:indexPath],
                                   [self bookmarkWidthForIndexPath:indexPath], [self bookmarkHeightForIndexPath:indexPath]);
    return resultRect;
}

- (CGFloat)bookmarkWidthForIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth(self.collectionView.bounds);
}


- (CGFloat)bookmarkHeightForIndexPath:(NSIndexPath *)indexPath {
    // todo: customization height
    return kBEBookmarkStandardHeight;
}

- (CGFloat)bookmarkYForIndexPath:(NSIndexPath *)indexPath {

    BEBookmarkDataSource *dataSource = (BEBookmarkDataSource *)self.collectionView.dataSource;
    BEBookmarkHtmlTagInfo *bookmarkInfo = [dataSource bookmarkAtIndexPath:indexPath];

    if (bookmarkInfo.tagLayer) {
        return CGRectGetMinY(bookmarkInfo.tagLayer.frame);
    }
    return 0.f;
}

- (CGFloat)bookmarkXForIndexPath:(NSIndexPath *)indexPath {
    return 0.f;
}

#pragma mark - Bookmark Layout Delegate



@end
