//
//  WebViewController.h
//  ipc
//
//  Created by SaRy on 8/24/11.
//  Copyright 2011 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController{
    UIWebView *webView;
    UITextView *addressBar;
    NSString *stringUrl;
}

@property (nonatomic, retain) NSString *stringUrl;

- (id)initWithStringURL:(NSString *)curl;

@end
