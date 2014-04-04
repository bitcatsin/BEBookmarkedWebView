//
//  BEBookmarkLayout.h
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 26/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BEBookmarkLayout;

@protocol BEBookmarkLayoutDelegate <UICollectionViewDelegate>

- (CGFloat)beBookmarkLayoutContentHeight:(BEBookmarkLayout *) collectionViewLayout;

@end

@interface BEBookmarkLayout : UICollectionViewLayout

@property (nonatomic, strong) id<BEBookmarkLayoutDelegate>bookmarkRootDelegate;

@end
