//
//  PDTRUIWebViewController.h
//  PullDownToRefreshUIWebView
//
//  Created by Osamu Noguchi on 2/27/12.
//  Copyright (c) 2012 atrac613.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface PDTRUIWebViewController : UIViewController <EGORefreshTableHeaderDelegate, UIWebViewDelegate, UIScrollViewDelegate>{
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    IBOutlet UIWebView *webView;
    UIScrollView *webScroller;
    
    //  Reloading var should really be your tableviews datasource
    //  Putting it here for demo purposes 
    BOOL _reloading;
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) UIScrollView *webScroller;

@end
