//
//  BEBookmarkHtmlInfo.h
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 21/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BEBookmarkHtmlTagData.h"

@interface BEBookmarkHtmlTagInfo : NSObject<BEBookmarkHtmlTagData>

@property (nonatomic, strong) CALayer *tagLayer;

- (CGRect)htmlTagRect;

- (id)initBookmarkHtmlInfoWithTagId:(NSString *)tagId;

@end
