//
//  OCSubTitle.m
//  SubTitle
//
//  Created by East Agile on 1/3/13.
//  Copyright (c) 2013 OnApp. All rights reserved.
//

#import "OCSubTitle.h"
#import "Lecture.h"

@interface OCSubTitle()

@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSRegularExpression *regex;

@end

@implementation OCSubTitle

- (id)initWithLecture:(Lecture *)lecture;
{
    self = [super init];
    if (self) {
        if (!lecture.subtitle)
            lecture.subtitle = [NSString stringWithContentsOfURL:[NSURL URLWithString:lecture.subtitleLink] encoding:NSUTF8StringEncoding error:nil];
        self.subtitle = lecture.subtitle;
        self.subtitleItems = [@[] mutableCopy];
        NSArray *contextLine=[self.subtitle componentsSeparatedByString:@"\n"];

        for (int i=0; i<[contextLine count]; i++)
        {
            NSRange firstCharRange=NSMakeRange(0, 1);
            NSString *lineIndex=[contextLine objectAtIndex:i];
            if ([lineIndex length])  //to skip over blank lines
            {
                if ([[lineIndex substringWithRange:firstCharRange] intValue]>=1 &&
                    [[lineIndex substringWithRange:firstCharRange] intValue]<=9) // the index line
                {
                    NSString *lineTime=[contextLine objectAtIndex:i+1];
                    if ([[lineTime substringWithRange:firstCharRange] isEqualToString:@"0"]) //the time line
                    {
                        IndividualSubtitle *subtitle=[IndividualSubtitle new];
                        NSString *lineEng1=[contextLine objectAtIndex:i+2];
                        NSString *lineEng2=[contextLine objectAtIndex:i+3];
                        
                        subtitle.startTime=[self makeCMTimeStart:lineTime];
                        subtitle.endTime=[self makeCMTimeEnd:lineTime];
                        subtitle.ChiSubtitle=[NSString stringWithString:lineEng1];
                        if ([lineEng2 length]) {
                            subtitle.EngSubtitle=[NSString stringWithString:lineEng2];
                        }else{
                            subtitle.EngSubtitle=@" ";
                        }
                        [self.subtitleItems addObject:subtitle];
                    }
                    else
                    {
                        //如果字幕索引下不是时间轴，则出错
                        NSLog(@"subtitle package wrong");
                    }
                }
            }
        }
    }
    return self;
}

#pragma mark - choose proper subtitle by given CMTime

- (NSUInteger)indexOfProperSubtitleWithGivenCMTime:(CMTime)time{
    __block double timeInSeconds=CMTimeGetSeconds(time);
    NSUInteger theIndex=[self.subtitleItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        if (timeInSeconds>=CMTimeGetSeconds([obj startTime]) && timeInSeconds<=CMTimeGetSeconds([obj endTime])) {
            return YES;
        }else{
            return NO;
        }
    }];
    if (theIndex==NSNotFound) {
        return 0;
    }else{
        return theIndex;
    }
}

#pragma mark -

- (void)saveSubtitleWithTime:(CMTime)time inPath:(NSString *)path{

    NSUInteger index=[self indexOfProperSubtitleWithGivenCMTime:time];

    IndividualSubtitle *currentSubtitle=[self.subtitleItems objectAtIndex:index];

    NSMutableData *data=[[NSMutableData alloc]init];
    NSKeyedArchiver *archiver=[[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [archiver encodeObject:currentSubtitle forKey:@"subtitle"];
    [archiver finishEncoding];

    [data writeToFile:path atomically:YES];

}

#pragma mark - make CMTime from String

- (CMTime)makeCMTimeStart:(NSString *)timeline{
    NSString *startTimeStr=[timeline substringWithRange:NSMakeRange(0, 12)];
    CMTime timeStart=[self makeCMTimeFromSperatedTimeString:startTimeStr];
    return timeStart;
}

- (CMTime)makeCMTimeEnd:(NSString *)timeline{
    NSString *endTimeStr=[timeline substringWithRange:NSMakeRange(17, 12)];
    CMTime timeEnd=[self makeCMTimeFromSperatedTimeString:endTimeStr];
    return timeEnd;
}

- (CMTime)makeCMTimeFromSperatedTimeString:(NSString *)separatedTimeStr{
    NSRange hourRange=NSMakeRange(0, 2);
    NSRange minRange=NSMakeRange(3, 2);
    NSRange secRange=NSMakeRange(6, 2);
    NSRange fraRange=NSMakeRange(9, 3);

    int hour=[[separatedTimeStr substringWithRange:hourRange] intValue];
    int min=[[separatedTimeStr substringWithRange:minRange] intValue];
    int sec=[[separatedTimeStr substringWithRange:secRange] intValue];
    int fra=[[separatedTimeStr substringWithRange:fraRange] intValue];

    double timeInSeconds=(fra+sec*1000+min*60*1000+hour*60*60*1000)/1000.00*600.00;
    CMTime time=CMTimeMake(timeInSeconds, 600);
    return time;
}



#pragma mark - NSCoding & NSCopying

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.subtitleItems forKey:@"subtitleItems"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.subtitleItems=[aDecoder decodeObjectForKey:@"subtitleItems"];
    }
    return self;
}

@end

#pragma mark -


@implementation IndividualSubtitle
@synthesize startTime, endTime;
@synthesize EngSubtitle, ChiSubtitle;



- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeCMTime:startTime forKey:@"startTime"];
    [aCoder encodeCMTime:endTime forKey:@"endTime"];
    [aCoder encodeObject:EngSubtitle forKey:@"EngSubtitle"];
    [aCoder encodeObject:ChiSubtitle forKey:@"ChiSubtitle"];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        startTime=[aDecoder decodeCMTimeForKey:@"startTime"];
        endTime=[aDecoder decodeCMTimeForKey:@"endTime"];
        EngSubtitle=[aDecoder decodeObjectForKey:@"EngSubtitle"];
        ChiSubtitle=[aDecoder decodeObjectForKey:@"ChiSubtitle"];

    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone{
    IndividualSubtitle *copy=[[[self class] allocWithZone:zone]init];
    copy.startTime=self.startTime;
    copy.endTime=self.endTime;
    copy.EngSubtitle=[self.EngSubtitle copyWithZone:zone];
    copy.ChiSubtitle=[self.ChiSubtitle copyWithZone:zone];
    return copy;
}

@end
