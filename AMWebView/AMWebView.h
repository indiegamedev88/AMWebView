//
//  AMWebView.h
//  AMWebView
//
//  Created by Minh Nguyen on 3/20/15.
//  Copyright (c) 2015 Double Nose. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AMWebViewButton) {
    AMWebViewBack = 0,
    AMWebViewNext,
    AMWebViewMenu,
    AMWebViewReload
};

@interface AMWebView : UIView

+ (instancetype)amWebView;

@end
