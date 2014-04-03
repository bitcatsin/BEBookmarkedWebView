//
//  UIScrollView+GruppenScrolling.h
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 28/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (GruppenScrolling)

- (void)notizeMeToGrupperScrollingWithName:(NSString *)uniqueName;

- (void)notizeMeScrollingWithName:(NSString *)uniqueName;

@end
