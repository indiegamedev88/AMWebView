//
//  AMWebView.m
//  AMWebView
//
//  Created by Minh Nguyen on 3/20/15.
//  Copyright (c) 2015 Double Nose. All rights reserved.
//

#import "AMWebView.h"

@interface AMWebView()<UITextFieldDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityLoading;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation AMWebView

+ (instancetype)amWebView{
    return [[[NSBundle mainBundle] loadNibNamed:@"AMWebView" owner:nil options:nil] firstObject];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self prepareLayout];
    }
    
    return self;
}

#pragma mark - Setup 
- (void)prepareLayout{
    self.activityLoading.layer.borderWidth = 1;
}

#pragma mark - Button Event
- (IBAction)tapOnButton:(UIButton*)sender{
    
    AMWebViewButton tag = sender.tag;
    
    switch (tag) {
        case AMWebViewBack:
            [self.webView goBack];
            break;
        case AMWebViewNext:
            [self.webView goForward];
            break;
        case AMWebViewMenu:
            break;
        case AMWebViewReload:
            [self.webView reload];
            break;
        default:
            break;
    }
}

- (BOOL)validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (NSString *)urlencode:(NSString*)input{
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[input UTF8String];
    int sourceLen = (int)strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.placeholder = @"";
    textField.textAlignment = NSTextAlignmentLeft;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSString *searchText = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (searchText.length == 0) {
        textField.placeholder = @"🔍Search";
        textField.textAlignment = NSTextAlignmentCenter;
    } else{
        if (![self validateUrl:searchText]) {
            searchText = [NSString stringWithFormat:@"http://google.com/search?q=%@", [self urlencode:searchText]];
        }
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:searchText]]];
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityLoading startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityLoading stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self.activityLoading stopAnimating];
}

@end
