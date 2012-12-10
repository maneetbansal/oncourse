//
//  OCWatchingVideoViewController.m
//  OnCourse
//
//  Created by admin on 12/10/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCWatchingVideoViewController.h"
#import "OCWatchingVideo.h"

@interface OCWatchingVideoViewController ()
@property (nonatomic, strong) OCWatchingVideo *watchingVideoView;

@end

@implementation OCWatchingVideoViewController

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
    self.watchingVideoView = [[OCWatchingVideo alloc] initWithFrame:self.view.frame];
    self.view = self.watchingVideoView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
