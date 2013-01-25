//
//  OCWatchingVideo.h
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@class OCSubTitle;
@class Lecture;

@interface OCWatchingVideo : UIView

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

- (id)initWithLecture:(Lecture *)lecture;

@end