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

@implementation OCWatchingVideo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadVideo];
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

- (void)loadVideo
{
    NSURL *url = [NSURL URLWithString:self.videoLink];
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:url];
    
    [self.webview loadRequest:requestObject];
    [self addSubview:self.webview];
}

@end
