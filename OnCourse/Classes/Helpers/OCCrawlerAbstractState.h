//
//  OCCrawlerAbstractState.h
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCCrawlerAbstractState;

@protocol OCCrawlerAbstractStateDelegate <NSObject>

- (void)changeState:(OCCrawlerAbstractState *)state;

@end

@interface OCCrawlerAbstractState : NSObject

@property (nonatomic, strong) UIWebView *webviewCrawler;
@property (nonatomic, strong) OCCrawlerAbstractState *crawlerAbstractState;
@property (nonatomic, assign) id<OCCrawlerAbstractStateDelegate> crawlerDelegate;

- (void)loadRequest:(NSString *)requestURL;
- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password;

@end
