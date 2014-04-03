//
//  BEBookmarkedWebViewController+LayoutWebAndBookmarks.m
//
//  BEBookmarkedWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkedWebViewController+LayoutWebAndBookmarks.h"
#import "BEBookmarkLayout.h"
#import "BEBookmarksController.h"

static CGFloat kBEStandardBookmarksWidth = 200.f;

@implementation BEBookmarkedWebViewController (LayoutWebAndBookmarks)

- (void)setRevealingState:(BOOL)revealing animated:(BOOL)animated {

    CGRect newSidedRect = [self rectForBookmarks:revealing];
    CGRect newRootRect = [self rectForWebView:revealing];

    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            // root frame and sided frame
            self.bookmarkWebView.frame = newRootRect;

            if (self.bookmarksCollectionController) {
                self.bookmarksCollectionController.view.frame = newSidedRect;
            }

        }];
    } else {
        self.bookmarkWebView.frame = newRootRect;

        if (self.bookmarksCollectionController) {
            self.bookmarksCollectionController.view.frame = newSidedRect;
        }
    }
}

- (CGRect)rectForBookmarks:(BOOL)isRevealingBookmarks {

    CGRect rect = self.view.bounds;
    CGRect resultRect;
    CGFloat xPos;

    if (!isRevealingBookmarks) {
        xPos = CGRectGetMaxX(rect) - 2;
    } else {
        xPos = CGRectGetMaxX(rect) - kBEStandardBookmarksWidth;
    }
    resultRect = CGRectMake(xPos, 0.f, kBEStandardBookmarksWidth, CGRectGetHeight(rect));

    return resultRect;
}

- (CGRect)rectForWebView:(BOOL)isRevealingBookmarks {
    
    CGRect rect = self.view.bounds;
    CGRect resultRect;
    CGFloat xPos;

    if (!isRevealingBookmarks) {
        xPos = 0.f;
    } else {
        xPos = - kBEStandardBookmarksWidth;
    }
    resultRect = CGRectMake(xPos, 0.f, CGRectGetWidth(rect), CGRectGetHeight(rect));

    return resultRect;
}

@end
