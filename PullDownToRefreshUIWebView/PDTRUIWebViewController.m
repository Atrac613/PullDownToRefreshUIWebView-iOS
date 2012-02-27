//
//  PDTRUIWebViewController.m
//  PullDownToRefreshUIWebView
//
//  Created by Osamu Noguchi on 2/27/12.
//  Copyright (c) 2012 atrac613.io. All rights reserved.
//

#import "PDTRUIWebViewController.h"

@implementation PDTRUIWebViewController

@synthesize webView;
@synthesize webScroller;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_refreshHeaderView == nil) {
        webScroller = (UIScrollView *)[[webView subviews] objectAtIndex:0];
        [webScroller setDelegate:self];
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - webScroller.bounds.size.height, self.view.frame.size.width, webScroller.bounds.size.height)];
        view.delegate = self;
        [webScroller addSubview:view];
        _refreshHeaderView = view;
    }
    
    //  update the last update date
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [webView reload];
    //[self reloadTableViewDataSource];
    //[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

#pragma mark -
#pragma mark UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)wv {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.webScroller];   
}

@end
