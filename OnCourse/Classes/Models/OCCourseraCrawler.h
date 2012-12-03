//
//  OCCourseraCrawler.h
//  OnCourse
//
//  Created by East Agile on 12/1/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCCrawlerAbstractState.h"

@interface OCCourseraCrawler : NSObject <OCCrawlerAbstractStateDelegate>

@property (nonatomic, strong) OCCrawlerAbstractState *state;
@property (nonatomic, strong) UIWebView *webviewCrawler;

- (void)changeState:(OCCrawlerAbstractState *)state;

@end
