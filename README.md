# BEBookmarkedWebView

## Bookmark content on UIWebView with custom sticked UICollectionViewController

Uses HTML tags ids to mark on UIWebView (via layers on scroll view), creates collection view cells, sticked to UIWebView content on the same height as HTML tag, revealing bookmark side on marked tags (layers) tap.

The example code will load file sample.html from bundle resources, create semi transparent yellow layer on html divs with ids 't1' - 't5' (if found). 
Next, when layer is tapped, it reveals right-sided bookmark section (subclass of UICollectionViewController). Bookmark section content height and web view content height are equal, and x-position of UICollectionViewCells is equal to uiwebview. Collection view and web are scrolling simultaneously.

```objc
BEBookmarkedWebViewController *rootController = [[BEBookmarkedWebViewController alloc]init];
    rootController.bePresentedFilename = @"sample";
    rootController.beBookmarksHTMLIds = @[@"t1", @"t2", @"t3",@"t4",@"t5"];

    rootController.bookmarksDataSource.bookmarksCollectionClassId = @"PostItCell";
    rootController.bookmarksDataSource.bookmarksCollectionClass = [DemoBookmarkPostItCell class];

    rootController.bookmarksDataSource.configureBookmarkCellBlock = ^void (UICollectionViewCell *cell, NSIndexPath *indexPath, BEBookmarkHtmlTagInfo *bookmarkData){
        DemoBookmarkPostItCell *postItCell = (DemoBookmarkPostItCell *)cell;
        
        // todo:
    };
[self.window setRootViewController:rootController];
```
