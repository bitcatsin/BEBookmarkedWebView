//
//  BEBookmarkWebView.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 28/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkWebView.h"

#import "UIScrollView+GruppenScrolling.h"

static NSString *kWebViewId = @"GSRootWebView";

@implementation BEBookmarkWebView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self.scrollView notizeMeToGrupperScrollingWithName:kWebViewId];
    }
    return self;
}

// Overrided from superclass - for simultaneous scrolling

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [super scrollViewDidScroll:scrollView];

    [self.scrollView notizeMeScrollingWithName:kWebViewId];
}

@end
