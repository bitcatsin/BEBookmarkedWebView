//
//  BEBookmarkedWebViewController.m
//
//  BEBookmarkedWebViewController
//
//  Created by Bit Cats on 29/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarkedWebViewController.h"

// Shared data source
#import "BEBookmarkDataSource.h"

// Layout
#import "BEBookmarkLayout.h"

// Categories
#import "BEBookmarkedWebViewController+LayoutWebAndBookmarks.h"
#import "UIWebView+BookmarksTags.h"
#import "UIScrollView+GruppenScrolling.h"

static NSString *kDemoCellId = @"DefaultCellId";

@interface BEBookmarkedWebViewController ()<BEBookmarkLayoutDelegate> {
    
}

@end

@implementation BEBookmarkedWebViewController {

}

- (id)init {
    self = [super init];
    _bookmarksDataSource = [[BEBookmarkDataSource alloc]initWithDataArray:[NSArray array]];
    _isRevealed = NO;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupWebAndBookmarksViews];

    if (_bePresentedFilename) {
        [self loadFromFile:_bePresentedFilename];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];

    _bookmarksCollectionController.view.frame = [self rectForBookmarks:_isRevealed];
    _bookmarkWebView.frame = [self rectForWebView:_isRevealed];
}

- (void)setupWebAndBookmarksViews {
    [self setupBookmarkWebView];
    // Bookmark Collection Controller

    [self setupBookmarksCollection];
}

- (void)setupBookmarkWebView {
    _bookmarkWebView = [[BEBookmarkWebView alloc]initWithFrame:[self rectForWebView:NO]];
    _bookmarkWebView.delegate = self;

    UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnWebContent:)];
    tapGestureRecognizer.delegate = self;
    [_bookmarkWebView addGestureRecognizer:tapGestureRecognizer];

    UIGestureRecognizer *touchGestureRecognizer = [[UIGestureRecognizer alloc]initWithTarget:self action:@selector(touchScrollWebContent:)];
    touchGestureRecognizer.delegate = self;
    [_bookmarkWebView.scrollView addGestureRecognizer:touchGestureRecognizer];

    [self.view addSubview:_bookmarkWebView];
}

- (BEBookmarkLayout *)layoutForBookmarksCollectionViewController {
    BEBookmarkLayout *bookmarkLayout = [[BEBookmarkLayout alloc]init];
    bookmarkLayout.bookmarkRootDelegate = self;
    return bookmarkLayout;
}



- (void)setupBookmarksCollection {

    BEBookmarkLayout *bookmarkLayout = [self layoutForBookmarksCollectionViewController];

    _bookmarksCollectionController = [[BEBookmarksController alloc]initWithCollectionViewLayout:bookmarkLayout];
    _bookmarksCollectionController.collectionClass = _bookmarksDataSource.bookmarksCollectionClass;
    _bookmarksCollectionController.collectionClassId = _bookmarksDataSource.bookmarksCollectionClassId;

    _bookmarksCollectionController.collectionView.dataSource = _bookmarksDataSource;

    [self addChildViewController:_bookmarksCollectionController];
    [_bookmarksCollectionController didMoveToParentViewController:self];

    _bookmarksCollectionController.view.frame = [self rectForBookmarks:NO];
    [self.view addSubview:_bookmarksCollectionController.view];
}


- (void)loadFromFile:(NSString *)filename {
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:filename ofType:@"html"];

    if (indexPath) {
        [_bookmarkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
    } else {
        NSLog(@"Err- not found file with name  - %@",filename);
        [_bookmarkWebView loadHTMLString:[NSString stringWithFormat:@"<html><body><h1> - %@ - <br/>not found file... </h1></body></html>",filename]
                                 baseURL:nil];
    }
}

#pragma mark - Actions

- (void)tapOnWebContent:(UIGestureRecognizer *)recognizer {
    BOOL wantsToReveal = NO;
    CGPoint relativePoint = [recognizer locationInView:recognizer.view];
    //    CGRect relativeRect =
    CALayer *testLayer = [recognizer.view.layer hitTest:relativePoint];

    NSArray *tagsInfoCollection = _bookmarksDataSource.bookmarksInfoData;

    for (BEBookmarkHtmlTagInfo *info in tagsInfoCollection ) {
        if (info.tagLayer == testLayer) {
            NSLog(@"YES.");
            wantsToReveal = YES;
            break;
        }
    }

    if (wantsToReveal != _isRevealed) {
        [self setRevealingState:wantsToReveal animated:YES];
        _isRevealed = wantsToReveal;
    }
}

- (void)touchScrollWebContent:(UIGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Began...");
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        NSLog(@"ended...");
    }
}

#pragma mark - Bookmark Delegate

- (CGFloat)beBookmarkLayoutContentHeight:(BEBookmarkLayout *)collectionViewLayout {
    CGSize contentSize = _bookmarkWebView.scrollView.contentSize;
//    return [_bookmarkWebView webViewHtmlPageHeightWithJSMethod:NO];
    return contentSize.height;
}

#pragma mark - UIWebView Gesture recognizer  - tap

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - UIWebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // create actualized bookmarkInfo
    NSArray *newBookmarksArray =  [webView bookmarksDataSourceArrayForTagsIds:_beBookmarksHTMLIds
                                                     withLayerCompletionBlock:^(CALayer *layer, BEBookmarkHtmlTagInfo *tagInfo){
                                                         layer.backgroundColor = [UIColor colorWithRed:1.f green:1.f blue:0.f alpha:0.3].CGColor;
                                                        }];
    [_bookmarksDataSource setBookmarksInfoData:newBookmarksArray];
    [self addWebViewLayersFromDataSource];
    [_bookmarksCollectionController.collectionView reloadData];

}

#pragma mark - Rotation support

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    //todo: invisible html bookmarks holders
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    for (BEBookmarkHtmlTagInfo *info in _bookmarksDataSource.bookmarksInfoData) {
        info.tagLayer.frame = [_bookmarkWebView webViewRectForTagId:info.tagId];
    }
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView notizeMeScrollingWithName:@"Bookmarks"];
}

#pragma mark - Private

- (void)addWebViewLayersFromDataSource {
    for (BEBookmarkHtmlTagInfo *info in _bookmarksDataSource.bookmarksInfoData) {
        if (info) {
            [_bookmarkWebView.scrollView.layer addSublayer:info.tagLayer];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Class)beBookmarksCollectionCellClass {
    if (_bookmarksDataSource.bookmarksCollectionClass) {
        return _bookmarksDataSource.bookmarksCollectionClass;
    }
    return [UICollectionViewCell class];
}

- (NSString *)beBookmarksCollectionClassId {
    if (_bookmarksDataSource.bookmarksCollectionClassId) {
        return _bookmarksDataSource.bookmarksCollectionClassId;
    }
    return @"SampleBookmarkedCellId";
}

@end
