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
    [_signupView.buttonSignup addTarget:self action:@selector(actionSignup) forControlEvents:UIControlEventTouchDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionSignup
{
    NSString *fullname = self.signupView.textFieldFullname.text;
    NSString *username = self.signupView.textFieldUsername.text; // email format
    NSString *password = self.signupView.textFieldPassword.text;
    
    if (fullname != nil && username != nil && password != nil & fullname.length > 0 & username.length > 0 && password.length > 0) {
        if ([self validateEmail:username] == NO) {
            [[[UIAlertView alloc] initWithTitle:@"Sign up fail" message:@"The email is invalid. Please check it again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else if (password.length < 4) {
            [[[UIAlertView alloc] initWithTitle:@"Sign up fail" message:@"The password is weak. Please use a stronger password!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            // Fill valid information
            OCAppDelegate *appDelegate = [OCUtility appDelegate];
            self.crawlerSignupState = [[OCCrawlerSignupState alloc] initWithWebview:appDelegate.courseCrawler.webviewCrawler andFullname:fullname andUsername:username andPassword:password];
            self.crawlerSignupState.crawlerDelegate = appDelegate.courseCrawler;
            [appDelegate.courseCrawler changeState:self.crawlerSignupState];
        }
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Sign up fail" message:@"Please fill enough information!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
