//
//  OCWatchingVideo.m
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCWatchingVideo.h"
#import "UIButton+Style.h"
#import "OCLectureListingsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "OCSubTitle.h"
#import "Lecture+CoreData.h"
#import "OCWatchingVideoViewController.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kButtonBackToLecturesHorizontal = @"H:|-15-[_buttonBack(==75)]-15-[_labelTopWatching]";
NSString *const kButtonBackToLecturesVertical = @"V:|-15-[_buttonBack(==40)]-10-[moviePlayerView]";

NSString *const kLabelTopWatchingVertical = @"V:|-15-[_labelTopWatching]-10-[moviePlayerView]";
NSString *const kLabelTopWatchingHorizontal = @"H:[_labelTopWatching]-0-|";

NSString *const kMoviePlayerHorizontal = @"H:|-0-[moviePlayerView]-0-|";
NSString *const kMoviePlayerVertical = @"V:[moviePlayerView]-0-|";

NSString *const kLabelSubtitleVertical = @"V:[_labelSubtitle(==50)]-30-|";
NSString *const kLabelSubtitleHorizontal = @"H:|-5-[_labelSubtitle]-5-|";

@interface OCWatchingVideo()

@property (nonatomic, strong) UILabel *labelTopWatching;
@property (nonatomic, strong) UIButton *buttonBack;
@property (nonatomic, strong) UILabel *labelSubtitle;
@property (nonatomic, strong) OCSubTitle *subtitle;
@property (nonatomic, strong) Lecture *lecture;

@end

@implementation OCWatchingVideo

- (id)initWithLecture:(Lecture *)lecture
{
    self = [super init];
    if (self) {
        self.lecture = lecture;
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
        [self setNiceBackground];
        [self initSubtitleData];
    }
    return self;
}

- (void)initSubtitleData
{
    if (self.lecture.subtitleLink) {
        self.subtitle = [[OCSubTitle alloc] initWithLecture:self.lecture];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerPlaybackStateChanged:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    }
    else
        [self.labelSubtitle performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:7];
}

- (void)constructUIComponents
{
    [self buttonBackUI];
    [self labelTopWatchingUI];
    [self moviePlayerUI];
    [self labelSubtitleUI];
}

- (void)labelTopWatchingUI
{
    self.labelTopWatching = [[UILabel alloc] init];
    self.labelTopWatching.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTopWatching.backgroundColor = [UIColor clearColor];
    [self.labelTopWatching setFont:[UIFont fontWithName:@"Livory-Bold" size:16]];
    self.labelTopWatching.text = @"Your Video";
    [self addSubview:self.labelTopWatching];
}

- (void)labelSubtitleUI
{
    self.labelSubtitle = [[UILabel alloc] init];
    self.labelSubtitle.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSubtitle.backgroundColor = [UIColor clearColor];
    [self.labelSubtitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    self.labelSubtitle.text = @"Subtitle for this video not available";
    self.labelSubtitle.textColor = [UIColor whiteColor];
    self.labelSubtitle.numberOfLines = 3;
    self.labelSubtitle.textAlignment = NSTextAlignmentCenter;
    [self.moviePlayer.view addSubview:self.labelSubtitle];
}

- (void)moviePlayerUI
{
    self.moviePlayer = [[MPMoviePlayerController alloc] init];
    self.moviePlayer.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
//    self.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    self.moviePlayer.shouldAutoplay = YES;
    self.moviePlayer.repeatMode = NO;
    [self.moviePlayer setFullscreen:YES animated:YES];
    self.moviePlayer.view.backgroundColor = [UIColor clearColor];
    [self addSubview:[self.moviePlayer view]];
}

- (void)buttonBackUI
{
    self.buttonBack = [UIButton buttonWithBackStyleAndTitle:@""];
    [self.buttonBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.buttonBack];
}

- (void)actionBack
{
    [self stopVideo];
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    OCWatchingVideoViewController *watchingViewController = (OCWatchingVideoViewController *)appDelegate.navigationController.topViewController;
    [watchingViewController cancelRemoveWatchingView];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
    
}

- (void)stopVideo
{
    [self.moviePlayer pause];
    [self.moviePlayer stop];
}

- (NSArray *)buttonBackConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    UIView *moviePlayerView = self.moviePlayer.view;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonBack, _labelTopWatching, moviePlayerView);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToLecturesHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToLecturesVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)labelTopWatchingConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    UIView *moviePlayerView = self.moviePlayer.view;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelTopWatching, moviePlayerView);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelTopWatchingHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelTopWatchingVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
    
}

- (NSArray *)moviePlayerConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    UIView *moviePlayerView = self.moviePlayer.view;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(moviePlayerView);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kMoviePlayerHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kMoviePlayerVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];

}

- (NSArray *)labelSubtitleConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelSubtitle);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelSubtitleHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelSubtitleVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];

}

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];

    [result addObjectsFromArray:[self buttonBackConstraints]];
    [result addObjectsFromArray:[self labelTopWatchingConstraints]];
    [result addObjectsFromArray:[self moviePlayerConstraints]];
    [result addObjectsFromArray:[self labelSubtitleConstraints]];
    
    return [NSArray arrayWithArray:result];
}

- (void)moviePlayerPlaybackStateChanged:(NSNotification *)info
{
    NSLog(@"movie player play back state changed");
    NSLog(@"%i", self.moviePlayer.playbackState);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(displaySubTitle:) object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.moviePlayer.playbackState == MPMoviePlaybackStatePlaying) {
        NSLog(@"playing");
        NSLog(@"%d", abs([self.moviePlayer currentPlaybackTime]));
        if (abs([self.moviePlayer currentPlaybackTime]) < 1)
        {
            NSString *line1 = [[self.subtitle.subtitleItems objectAtIndex:0] ChiSubtitle];
            NSString *line2 = [[self.subtitle.subtitleItems objectAtIndex:0] EngSubtitle];
            [self setLabelAttributedSubtitle:line1 withSencondLine:line2];
            NSUInteger distance = CMTimeGetSeconds([[self.subtitle.subtitleItems objectAtIndex:1] startTime]);
            [self performSelector:@selector(displaySubTitle:) withObject:[NSNumber numberWithInteger:0] afterDelay:distance];
        }
        else
        {
            CMTime time = CMTimeMake((float)[self.moviePlayer currentPlaybackTime] *600, 600);
            NSUInteger idx = [self.subtitle indexOfProperSubtitleWithGivenCMTime:time];
            NSUInteger nextIndex = idx + 1;
            NSString *line1 = [[self.subtitle.subtitleItems objectAtIndex:idx] ChiSubtitle];
            NSString *line2 = [[self.subtitle.subtitleItems objectAtIndex:idx] EngSubtitle];
            [self setLabelAttributedSubtitle:line1 withSencondLine:line2];

            NSUInteger distance = CMTimeGetSeconds([[self.subtitle.subtitleItems objectAtIndex:nextIndex] startTime]) - CMTimeGetSeconds(time);
            [self performSelector:@selector(displaySubTitle:) withObject:[NSNumber numberWithInteger:idx] afterDelay:distance];
        }
    }
}

- (void)displaySubTitle:(NSNumber *)currentIndex
{
    NSUInteger nextIndex = [currentIndex integerValue] + 1;
    if (nextIndex < self.subtitle.subtitleItems.count) {
        NSLog(@"%i", nextIndex);
        NSString *line1 = [[self.subtitle.subtitleItems objectAtIndex:nextIndex] ChiSubtitle];
        NSString *line2 = [[self.subtitle.subtitleItems objectAtIndex:nextIndex] EngSubtitle];
        [self setLabelAttributedSubtitle:line1 withSencondLine:line2];
        CMTime time = CMTimeMake((float)[self.moviePlayer currentPlaybackTime] *600, 600);
        if (nextIndex != self.subtitle.subtitleItems.count - 1) {
            NSUInteger distance = CMTimeGetSeconds([[self.subtitle.subtitleItems objectAtIndex:nextIndex+1] startTime]) - CMTimeGetSeconds(time);
            [self performSelector:@selector(displaySubTitle:) withObject:[NSNumber numberWithInteger:nextIndex] afterDelay:distance];
        }
    }
}

- (void)setLabelAttributedSubtitle:(NSString *)line1 withSencondLine:(NSString *)line2
{
    NSString *sub = [line1 stringByAppendingFormat:@"\n%@", line2];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:sub];
    [attString addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, line1.length)];
    [attString addAttribute:NSBackgroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(line1.length + 1, line2.length-1)];
    self.labelSubtitle.attributedText = attString;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
}


@end
