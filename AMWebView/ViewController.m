//
//  ViewController.m
//  AMWebView
//
//  Created by Minh Nguyen on 3/20/15.
//  Copyright (c) 2015 Double Nose. All rights reserved.
//

#import "AMWebView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    AMWebView *webView = [AMWebView amWebView];
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:webView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:@{@"webView":webView}]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-25-[webView]|" options:0 metrics:nil views:@{@"webView":webView}]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
