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
    }
    return self;
}

- (id)initWithLectureData:(NSMutableArray *)lectureData
{
    self = [super init];
    if (self) {
        self.lectureListingView = [[OCLectureListingView alloc] initWithLectureData:lectureData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view = self.lectureListingView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
