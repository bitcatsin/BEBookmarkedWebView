//
//  BEBookmarkHtmlInfo.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 21/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkHtmlTagInfo.h"

@implementation BEBookmarkHtmlTagInfo
@synthesize tagId = _tagId;

- (id)initBookmarkHtmlInfoWithTagId:(NSString *)tagId {
    self = [super init];

    _tagId = tagId;
    
    return self;
}



- (CGRect)htmlTagRect {
    if (_tagLayer) {
        return _tagLayer.frame;
    }
    return CGRectZero;
}


@end