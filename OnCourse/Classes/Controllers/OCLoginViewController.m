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
    if (username != nil && password != nil && username.length > 0 && password.length > 0)
    {
        if ([self validateEmail:username] == NO) {
           [[[UIAlertView alloc] initWithTitle:@"Login fail" message:@"Your email is invalid. Please check it again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
        }
        else
        {
            OCAppDelegate *appDelegate = [OCUtility appDelegate];
            //        [self.view addSubview:appDelegate.courseCrawler.webviewCrawler];
            self.crawlerLoginState = [[OCCrawlerLoginState alloc] initWithWebview:appDelegate.courseCrawler.webviewCrawler andEmail:username andPassword:password];
            self.crawlerLoginState.crawlerDelegate = appDelegate.courseCrawler;
            [appDelegate.courseCrawler changeState:self.crawlerLoginState];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Login fail" message:@"Please fill the email and password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

- (BOOL)validateEmail:(NSString *)email
{
    BOOL stricterFilter = YES;
    NSString *stricterFiltrString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\[A-Za-z]{2,6}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFiltrString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
