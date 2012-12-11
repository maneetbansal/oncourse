//
//  OCWatchingVideo.m
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourse.h"
#import "OCWatchingVideo.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

@interface OCWatchingVideo()

@property (nonatomic, strong) UIWebView *webview;

@end

@implementation OCWatchingVideo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawVideoTitle];
        [self initWebview];
        [self setNiceBackground];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)drawVideoTitle
{
    self.videoTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, 100)];
    self.videoTitle.text = @"Video title";
    self.videoTitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.videoTitle.backgroundColor = [UIColor clearColor];
    [self.videoTitle setFont:[UIFont fontWithName:@"Livory" size:20]];
    
    [self addSubview:self.videoTitle];
}

- (void)initWebview
{
    self.webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.height - 50, 500)];
    self.webview.autoresizesSubviews = YES;
    self.webview.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:[NSURL URLWithString:self.videoLink]];
    [self.webview loadRequest:requestObject];
    [self addSubview:self.webview];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
    
}

- (void)reloadDataWebview
{
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:[NSURL URLWithString:self.videoLink]];
    NSString *embedHTML = @"\ <html><head>\ <style type=\"text/css\">\ body {\ background-color: transparent; color: white; }\ </style>\ </head><body style=\"margin:0\">\ <embed id=\"yt\" src=\"%@\" \ width=\"%0.0f\" height=\"%0.0f\"></embed>\ </body></html>";
//    [self.webview loadRequest:requestObject];
    NSString *html = [NSString stringWithFormat:embedHTML, self.videoLink, [[UIScreen mainScreen] bounds].size.height - 260, ([[UIScreen mainScreen] bounds].size.height - 260) /16 * 9];
    [self.webview loadHTMLString:html baseURL:nil];
}

@end
