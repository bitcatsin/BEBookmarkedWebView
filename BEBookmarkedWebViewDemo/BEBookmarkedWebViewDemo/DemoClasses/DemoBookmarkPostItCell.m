//
//  DemoBookmarkPostItCell.m
//  BEBookmarkedWebViewDemo
//
//  Created by Bit Cat on 01/04/14.
//  Copyright (c) 2014 Bit Cats. All rights reserved.
//

#import "DemoBookmarkPostItCell.h"

@implementation DemoBookmarkPostItCell {
    UIImageView *_backgroundImageView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage *image = [UIImage imageNamed:@"post_it_yellow"];
        UIImage *tiledImg = [image resizableImageWithCapInsets:UIEdgeInsetsMake(32.f , 14.f , 5.f , 34.f) resizingMode:UIImageResizingModeStretch];

        _backgroundImageView = [[UIImageView alloc]initWithImage:tiledImg];
        [self.contentView addSubview:_backgroundImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _backgroundImageView.frame = self.contentView.bounds;
}

@end
