//
//  BEBookmarksWebViewController+LayoutWebAndBookmarks.h
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkedWebViewController.h"

@interface BEBookmarkedWebViewController (LayoutWebAndBookmarks)

- (void)setRevealingState:(BOOL)revealing animated:(BOOL)animated;

- (CGRect)rectForWebView:(BOOL)isRevealingBookmarks;
- (CGRect)rectForBookmarks:(BOOL)isRevealingBookmarks;

@end
