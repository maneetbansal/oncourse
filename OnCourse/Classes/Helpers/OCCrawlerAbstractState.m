//
//  OCCrawlerAbstractState.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCrawlerAbstractState.h"

@implementation OCCrawlerAbstractState

- (void)loadRequest:(NSString *)requestURL
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    [self.webviewCrawler loadRequest:request];
}

@end
