//
//  OCLectureListingsViewController.m
//  OnCourse
//
//  Created by East Agile on 12/11/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCLectureListingsViewController.h"
#import "OCLectureListingView.h"

@interface OCLectureListingsViewController ()

@property (nonatomic, strong) OCLectureListingView *lectureListingView;

@end

@implementation OCLectureListingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initLectureListingViewUI];
    }
    return self;
}

- (void)reloadData
{
    [self.lectureListingView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)initLectureListingViewUI
{
    self.lectureListingView = [OCLectureListingView new];
    self.view = self.lectureListingView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
