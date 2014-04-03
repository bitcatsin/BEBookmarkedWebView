//
//  BEBookmarkDataSource.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 26/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkDataSource.h"

@interface BEBookmarkDataSource()

@property (strong, nonatomic) NSMutableArray *bookmarks;

@end

@implementation BEBookmarkDataSource

- (id)initWithDataArray:(NSArray *)dataArray {
    self = [super init];

    _bookmarks = [NSMutableArray arrayWithArray:dataArray];

    return self;
}

- (BEBookmarkHtmlTagInfo *)bookmarkAtIndexPath:(NSIndexPath *)indexPath {
    return [_bookmarks objectAtIndex:indexPath.row];
}

#pragma mark Collection View Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bookmarks.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.bookmarksCollectionClassId forIndexPath:indexPath];

    BEBookmarkHtmlTagInfo *tagInfo = [self bookmarkAtIndexPath:indexPath];
    if (_configureBookmarkCellBlock) {
        _configureBookmarkCellBlock(cell, indexPath, tagInfo);
    } else {
        
    }
    
    return cell;
}


- (NSArray *)bookmarksInfoData {
    return _bookmarks;
}

- (void)setBookmarksInfoData:(NSArray *)bookmarksInfoData {
    _bookmarks = bookmarksInfoData;
}

- (NSString *)bookmarksCollectionClassId {
    if (_bookmarksCollectionClassId) {
        return _bookmarksCollectionClassId;
    }
    return @"SampleClassID";
}

- (Class)bookmarksCollectionClass {
    if (_bookmarksCollectionClass)
        return _bookmarksCollectionClass;
    return [UICollectionViewCell class];
}

@end
