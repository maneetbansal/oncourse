//
//  OCCourseListingsViewController.m
//  OnCourse
//
//  Created by East Agile on 11/29/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCCourseListingsViewController.h"
#import "OCCourseListingView.h"

@interface OCCourseListingsViewController ()

@property (nonatomic, strong) OCCourseListingView *courseListingView;

@end

@implementation OCCourseListingsViewController

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
    self.courseListingView = [[OCCourseListingView alloc] initWithFrame:self.view.frame];
    self.view = self.courseListingView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateCourseListing:(NSMutableArray *)courses
{
    self.courseListingView.listAllCourse = courses;
    [self.courseListingView reloadData];
}

@end
