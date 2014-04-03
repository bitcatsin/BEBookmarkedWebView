//
//  UIWebView+BookmarksTags.m
//  BEBookmarksWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "UIWebView+BookmarksTags.h"

//maybe rename
#import "BEBookmarkHtmlTagInfo.h"

@implementation UIWebView (BookmarksTags)

- (NSArray *)bookmarksDataSourceArrayForTagsIds:(NSArray *)stringTagsIds withLayerCompletionBlock:(BookmarkTagLayerCompletionBlock)completionBlock{
    [self loadRectForTagScript];

    NSMutableArray *bookmarksArray = [[NSMutableArray alloc]init];
    for (NSString *tag in stringTagsIds) {
        BEBookmarkHtmlTagInfo *tagInfo = [self tagInfoForTag:tag withLayerCompletionBlock:completionBlock];
        if (tagInfo) {
            [bookmarksArray addObject:tagInfo];
        }
    }
    return bookmarksArray;
}

- (BEBookmarkHtmlTagInfo *)tagInfoForTag:(NSString *)tagId withLayerCompletionBlock:(BookmarkTagLayerCompletionBlock)completionBlock{

    CGRect rect =[self webViewRectForTagId:tagId];

    if (!CGRectEqualToRect(rect, CGRectZero)) {

        BEBookmarkHtmlTagInfo *htmlInfo = [[BEBookmarkHtmlTagInfo alloc]initBookmarkHtmlInfoWithTagId:tagId];

        CALayer *testLayer = [[CALayer alloc]init];
        testLayer.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2].CGColor;
        testLayer.frame = rect;

        if (completionBlock)
            completionBlock(testLayer, htmlInfo);

        htmlInfo.tagLayer = testLayer;

        return htmlInfo;
    }
    return nil;
}

- (CGRect)webViewRectForTagId:(NSString *)tagId {

    NSString *response = [self stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@%@%@",@"rectForTag(\"",tagId,@"\");"]];;
    NSLog(@"edge insets: %@",response);

    if ([response isEqualToString:@""]) {
        return CGRectZero;
    }
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[response dataUsingEncoding:NSUTF8StringEncoding] options:
                          NSJSONReadingMutableContainers error:&error];

    if ([self isOneOrMoreKeysNil:@[@"left",@"top",@"width",@"height"] considerDictionary:dict]) {
        return CGRectZero;
    }

    CGRect result = CGRectMake([[dict objectForKey:@"left"] floatValue],
                               [[dict objectForKey:@"top"] floatValue],
                               [[dict objectForKey:@"width"] floatValue],
                               [[dict objectForKey:@"height"] floatValue]);
    return result;
}

- (void)loadRectForTagScript {
    NSString *scriptSrc =
    @"function rectForTag(tagId) {\
    var element = document.getElementById(tagId);\
    var rect = element.getBoundingClientRect();\
    var elLeft, elTop, elRight, elBottom;\
    var scrollTop = document.documentElement.scrollTop ? document.documentElement.scrollTop : document.body.scrollTop;\
    var scrollLeft = document.documentElement.scrollLeft ? document.documentElement.scrollLeft : document.body.scrollLeft;\
    \
    var height = element.clientHeight;\
    if (!height){\
    height = 0;\
    }\
    \
    var width = element.clientWidth;\
    if (!width){\
    width = 0;\
    }\
    var scrollBottom = document.documentElement.scrollBottom ? document.documentElement.scrollBottom : document.body.scrollBottom;\
    elTop = rect.top + scrollTop;\
    elLeft = rect.left + scrollLeft;\
    return '{\"top\":'+elTop+',\"left\":'+elLeft+',\"width\":'+width+',\"height\":'+height+'}';\
    }";
    [self stringByEvaluatingJavaScriptFromString:scriptSrc];
}

- (BOOL)isOneOrMoreKeysNil:(NSArray *)keys considerDictionary:(NSDictionary *)dict {
    for (NSString * key in keys) {
        if (![dict objectForKey:key]) {
            return YES;
        }
    }
    return NO;
}

@end
