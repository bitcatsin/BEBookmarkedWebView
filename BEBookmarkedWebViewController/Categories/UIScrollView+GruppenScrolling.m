//
//  UIScrollView+GruppenScrolling.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 28/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "UIScrollView+GruppenScrolling.h"

@implementation UIScrollView (GruppenScrolling)

- (void)notizeMeScrollingWithName:(NSString *)uniqueName {
    NSMutableDictionary *scrollViews = [UIScrollView gruppenScrollingArray];

    CGPoint refPoint = self.contentOffset;

    NSEnumerator *enumerator = [scrollViews objectEnumerator];
    UIScrollView *testSC;

    while (testSC = [enumerator nextObject]) {

        if (![testSC isEqual:self]) {
            
            if (!testSC.isDragging && !testSC.isTracking && !testSC.isDecelerating) {
                [testSC setContentOffset:CGPointMake(0.f , refPoint.y) animated:NO];
            }
        }
    }

}

- (void)notizeMeToGrupperScrollingWithName:(NSString *)uniqueName {

    [self setGruppenScrollViewWithName:uniqueName];
}

- (void)setGruppenScrollViewWithName:(NSString *)name {
    NSMutableDictionary *dict = [UIScrollView gruppenScrollingArray];
    [dict setObject:self forKey:name];
}

+ (NSMutableDictionary *)gruppenScrollingArray {
    static NSMutableDictionary *instance;
    if (!instance) {
        instance = [[NSMutableDictionary alloc]init];
    }
    return instance;
}

@end
