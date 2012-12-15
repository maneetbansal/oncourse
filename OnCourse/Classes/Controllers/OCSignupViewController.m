//
//  OCSignupViewController.m
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCSignupView.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "OCCourseraCrawler.h"
#import "OCSignupViewController.h"
#import "OCCrawlerSignupState.h"

@interface OCSignupViewController ()

@property (nonatomic, strong) OCSignupView *signupView;
@property (nonatomic, strong) OCCrawlerSignupState *crawlerSignupState;

@end

@implementation OCSignupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _signupView = [[OCSignupView alloc] initWithFrame:self.view.frame];
    self.view = _signupView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
