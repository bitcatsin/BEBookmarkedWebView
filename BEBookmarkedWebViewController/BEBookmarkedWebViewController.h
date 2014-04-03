//
//  BEBookmarkedWebViewController.h
//
//  BEBookmarkedWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.

#import <UIKit/UIKit.h>
#import "BEBookmarkWebView.h"
#import "BEBookmarksController.h"
#import "BEBookmarkLayout.h"

#import "BEBookmarkDataSource.h"

// todo: completion cell block, bookmarks cell delegate,
//  # properties - position, sizing, animation
//              - background view etc..
//  # actions public - reveal

@interface BEBookmarkedWebViewController : UIViewController<UIWebViewDelegate, UIGestureRecognizerDelegate> {

}

@property (nonatomic, strong) BEBookmarkDataSource *bookmarksDataSource;

@property (nonatomic, strong) NSString *bePresentedFilename;
@property (nonatomic, strong) NSArray *beBookmarksHTMLIds;

// Good ones

@property (nonatomic, assign) BOOL isRevealed;

@property (nonatomic, strong) BEBookmarkWebView *bookmarkWebView;
@property (nonatomic, strong, readonly) BEBookmarksController *bookmarksCollectionController;

// todo:
@property (nonatomic, strong) UIView *backgroundView;

- (void)setupWebAndBookmarksViews;
- (BEBookmarkLayout *)layoutForBookmarksCollectionViewController;

- (void)loadFromFile:(NSString *)filename;
@end
