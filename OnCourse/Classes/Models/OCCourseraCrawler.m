//
//  OCCourseraCrawler.m
//  OnCourse
//
//  Created by East Agile on 12/1/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseraCrawler.h"

@interface OCCourseraCrawler()

@end

@implementation OCCourseraCrawler

- (id)init
{
    self = [super init];
    if (self) {
        self.webviewCrawler = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 300, 500)];
    }

    return self;
}

- (void)changeState:(OCCrawlerAbstractState *)state
{
    self.state = nil;
    self.state = state;
}

@end
