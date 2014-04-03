//
//  UIWebView+BookmarksTags.h
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//
//


#import <UIKit/UIKit.h>

#import "BEBookmarkHtmlTagInfo.h"

typedef void(^BookmarkTagLayerCompletionBlock)(CALayer *layer, BEBookmarkHtmlTagInfo *tagInfo);

@interface UIWebView (BookmarksTags)

- (NSArray *)bookmarksDataSourceArrayForTagsIds:(NSArray *)stringTagsIds withLayerCompletionBlock:(BookmarkTagLayerCompletionBlock) completionBlock;

- (CGRect)webViewRectForTagId:(NSString *)tagId;

@end
