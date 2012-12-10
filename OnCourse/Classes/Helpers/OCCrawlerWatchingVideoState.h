//
//  OCCrawlerWatchingVideoState.h
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"
#import <Foundation/Foundation.h>

@interface OCCrawlerWatchingVideoState : OCCrawlerAbstractState <UIWebViewDelegate>

@property (nonatomic, strong) NSString *videoLink;

- (id)initWithWebview:(UIWebView *) webview andVideoLink:(NSString *)videoLink;

@end
