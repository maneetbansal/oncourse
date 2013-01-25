//
//  OCSubTitle.h
//  SubTitle
//
//  Created by East Agile on 1/3/13.
//  Copyright (c) 2013 OnApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>

@class Lecture;

@interface IndividualSubtitle : NSObject <NSCoding,NSCopying>
@property (assign) CMTime startTime;
@property (assign) CMTime endTime;
@property (copy) NSString *EngSubtitle;
@property (copy) NSString *ChiSubtitle;
@end

@interface OCSubTitle : NSObject <NSCoding>

@property (retain) NSMutableArray *subtitleItems;

- (NSUInteger)indexOfProperSubtitleWithGivenCMTime:(CMTime)time;
- (id)initWithLecture:(Lecture *)lecture;

@end
