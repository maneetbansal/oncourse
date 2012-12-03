//
//  OCLoginViewController.m
//  OnCourse
//
//  Created by East Agile on 11/30/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCLoginViewController.h"
#import "OCLoginView.h"
#import "OCUtility.h"
#import "OCAppDelegate.h"
#import "OCCourseraCrawler.h"
#import "OCCrawlerLoginState.h"

@interface OCLoginViewController ()

@property (nonatomic, strong) OCLoginView *loginView;
@property (nonatomic, strong) OCCrawlerLoginState *crawlerLoginState;

@end

@implementation OCLoginViewController

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
    _loginView = [[OCLoginView alloc] initWithFrame:self.view.frame];
    self.view = _loginView;
    [_loginView.buttonLogin addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)actionLogin:(UIButton *)sender
{
    NSString *username = self.loginView.textFieldUsername.text;
    NSString *password = self.loginView.textFieldPassword.text;
    if (username != nil && password != nil && username.length > 0 && password.length > 0) {
        OCAppDelegate *appDelegate = [OCUtility appDelegate];
//        [self.view addSubview:appDelegate.courseCrawler.webviewCrawler];
        self.crawlerLoginState = [[OCCrawlerLoginState alloc] initWithWebview:appDelegate.courseCrawler.webviewCrawler andEmail:username andPassword:password];
        self.crawlerLoginState.crawlerDelegate = appDelegate.courseCrawler;
        [appDelegate.courseCrawler changeState:self.crawlerLoginState];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Login Fail" message:@"Please fill the email and password" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }
}

@end
