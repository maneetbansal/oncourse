//
//  OCWatchingVideo.m
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCCourse.h"
#import "OCWatchingVideo.h"
#import "UIButton+Style.h"
#import "OCLectureListingsViewController.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kButtonBackToLecturesHorizontal = @"H:|-15-[_buttonBack(==75)]-15-[_labelTopWatching]";
NSString *const kButtonBackToLecturesVertical = @"V:|-15-[_buttonBack(==40)]-10-[moviePlayerView]";

NSString *const kLabelTopWatchingVertical = @"V:|-15-[_labelTopWatching]-10-[moviePlayerView]";
NSString *const kLabelTopWatchingHorizontal = @"H:[_labelTopWatching]-0-|";

NSString *const kMoviePlayerHorizontal = @"H:|-0-[moviePlayerView]-0-|";
NSString *const kMoviePlayerVertical = @"V:[moviePlayerView]-0-|";

@interface OCWatchingVideo()

@property (nonatomic, strong) UILabel *labelTopWatching;
@property (nonatomic, strong) UIButton *buttonBack;

@end

@implementation OCWatchingVideo

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
        [self setNiceBackground];
    }
    return self;
}

- (void)constructUIComponents
{
    [self buttonBackUI];
    [self labelTopWatchingUI];
    [self moviePlayerUI];
}

- (void)labelTopWatchingUI
{
    self.labelTopWatching = [[UILabel alloc] init];
    self.labelTopWatching.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelTopWatching.backgroundColor = [UIColor clearColor];
    [self.labelTopWatching setFont:[UIFont fontWithName:@"Livory-Bold" size:16]];
    self.labelTopWatching.text = @"Your course";
    [self addSubview:self.labelTopWatching];
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
    self.buttonBack = [UIButton buttonWithBackStyleAndTitle:@"Lectures"];
    [self.buttonBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchDown];
    [self addSubview:self.buttonBack];
}

- (void)actionBack
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
    
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

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];

    [result addObjectsFromArray:[self buttonBackConstraints]];
    [result addObjectsFromArray:[self labelTopWatchingConstraints]];
    [result addObjectsFromArray:[self moviePlayerConstraints]];
    
    return [NSArray arrayWithArray:result];
}

@end
