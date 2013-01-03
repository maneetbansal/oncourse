//
//  OCStartScreenView.m
//  OnCourse
//
//  Created by Ngoc-Nhan Nguyen on 12/25/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCStartScreenView.h"
#import "OCLoginViewController.h"
#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "MBProgressHUD.h"
#import "OCCourseListingsViewController.h"
#import "OCCourseraCrawler.h"
#import "OCCrawlerLoginState.h"

#define WIDTH_IPHONE_5 640
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

@interface OCStartScreenView()

@property (nonatomic, strong) OCCrawlerLoginState *crawlerLoginState;
@property (strong, nonatomic) OCCourseraCrawler *courseCrawler;


@end

@implementation OCStartScreenView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setNiceScreen];
        [self waitingForLoginScreen];
    }
    return self;
}

- (void)setNiceScreen
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"startScreen@2x.png"]]];
    else
       [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"startScreen.png"]]];
}

- (void)waitingForLoginScreen
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.labelText = @"Signing In";
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self setnextViewController];
        [MBProgressHUD hideHUDForView:self animated:YES];
    });
}

- (void)setnextViewController
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    self.courseCrawler = [[OCCourseraCrawler alloc] init];
    OCLoginViewController *loginViewController = [[OCLoginViewController alloc] init];
    OCCourseListingsViewController *courseListingsViewController = [[OCCourseListingsViewController alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults stringForKey:@"isLogin"])
    {
        [appDelegate.navigationController pushViewController:courseListingsViewController animated:YES];
        NSString *email = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"email"]];
        NSString *password = [NSString stringWithFormat:@"%@", [userDefaults objectForKey:@"password"]];
        self.crawlerLoginState = [[OCCrawlerLoginState alloc] initWithWebview:self.courseCrawler.webviewCrawler andEmail:email andPassword:password];
        self.crawlerLoginState.crawlerDelegate = self.courseCrawler;
        [self.courseCrawler changeState:self.crawlerLoginState];
    }
    else
    {
        [appDelegate.navigationController pushViewController:loginViewController animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
