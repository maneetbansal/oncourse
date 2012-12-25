//
//  OCStartScreenViewController.m
//  OnCourse
//
//  Created by Ngoc-Nhan Nguyen on 12/25/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCStartScreenViewController.h"
#import "OCStartScreenView.h"

@interface OCStartScreenViewController ()

@property (nonatomic, strong) OCStartScreenView *startScreenView;

@end

@implementation OCStartScreenViewController

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
    _startScreenView = [[OCStartScreenView alloc] init];
    self.view = _startScreenView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
