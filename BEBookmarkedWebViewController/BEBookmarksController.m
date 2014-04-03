//
//  BEBookmarksController.m
//  BEBookmarkedWebViewController
//
//  Created by Bit Cats on 26/03/14.
//  Copyright (c) 2014 bitcats.in. All rights reserved.
//

#import "BEBookmarksController.h"
#import "BEBookmarkLayout.h"
#import "BEBookmarkCell.h"
#import "BEBookmarkDataSource.h"

#import "UIScrollView+GruppenScrolling.h"

static NSString *kGSCollectionId = @"GSCollectionBookmarksId";

@interface BEBookmarksController () {

    BOOL _isValidLayout;
}

@end

@implementation BEBookmarksController

- (id)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithCollectionViewLayout:layout];

    _isValidLayout = [layout isKindOfClass:[BEBookmarkLayout class]];
    NSAssert(_isValidLayout, @"Warn - Layout not BEBookmarkLayout ");
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
	// register collectionViewCells via delegate
//    BEBookmarkDataSource *dataSource = (BEBookmarkDataSource *)self.collectionView.dataSource;

    NSString *cellId = self.collectionClassId;
    Class cellClass= self.collectionClass;

    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:cellId];

    [self.collectionView notizeMeToGrupperScrollingWithName:kGSCollectionId];

}


#pragma mark - Collection View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView notizeMeScrollingWithName:kGSCollectionId];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
