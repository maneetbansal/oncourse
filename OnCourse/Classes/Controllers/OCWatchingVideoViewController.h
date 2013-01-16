//
//  OCWatchingVideoViewController.h
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Lecture;

@interface OCWatchingVideoViewController : UIViewController<UIWebViewDelegate>

@property (nonatomic, strong) NSString *videoTitle;

- (id)initWithLecture:(Lecture *)lecture;

@end
