//
//  OCSignupView.m
//  OnCourse
//
//  Created by admin on 12/15/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCUtility.h"
#import "OCSignupView.h"
#import "UIButton+Style.h"
#import "OCCourseraCrawler.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kButtonBackToLoginHorizontal = @"H:|-15-[_buttonBack(==70)]-15-[_labelSignup]";
NSString *const kButtonBackToLoginVertical = @"V:|-25-[_buttonBack(==40)]-25-[_textFieldFullname]";

NSString *const kLabelSignupHorizontal = @"H:[_labelSignup]-0-|";
NSString *const kLabelSignupVertical = @"V:|-25-[_labelSignup]-25-[_textFieldFullname]";

NSString *const kTextFieldFullnameHorizontal = @"H:|-[_textFieldFullname]-|";
NSString *const kTextFieldFullnameVertical = @"V:[_textFieldFullname(==40)]";

NSString *const kTextFieldUsernameSignupHorizontal = @"H:|-[_textFieldUsername]-|";
NSString *const kTextFieldUsernameSignupVertical = @"V:[_textFieldFullname]-[_textFieldUsername(==40)]";

NSString *const kTextFieldPasswordSignupHorizontal = @"H:|-[_textFieldPassword]-|";
NSString *const kTextFieldPasswordSignupVertical = @"V:[_textFieldUsername]-[_textFieldPassword(==40)]";

NSString *const kButtonSignupSignupVertical = @"V:[_textFieldPassword]-20-[_buttonSignup]";

@interface OCSignupView()

@property (nonatomic, strong) UILabel *labelSignup;

@end

@implementation OCSignupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setNiceBackground];
        [self constructUIComponent];
        [self addConstraints:[self arrayContraints]];
        OCAppDelegate * app = [OCUtility appDelegate];
        app.courseCrawler.webviewCrawler.frame = CGRectMake(0, 300, 300, 200);
        [self addSubview:app.courseCrawler.webviewCrawler];

    }
    return self;
}

- (void)constructUIComponent
{
    [self buttonBackUI];
    [self labelSignupUI];
    self.textFieldFullname = [self textFieldWithPlaceholder:@"Full name"];
    self.textFieldUsername = [self textFieldWithPlaceholder:@"Email"];
    self.textFieldPassword = [self textFieldWithPlaceholder:@"Password"];
    [self.textFieldPassword setSecureTextEntry:YES];
    self.buttonSignup = [self buttonSignupUI];
    
    [self addUIComponentsToView:self];
}

- (void)actionGoToLoginView
{
    OCAppDelegate *appDelegate = [OCUtility appDelegate];
    [appDelegate.navigationController popViewControllerAnimated:YES];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background"]]];
}

- (void)buttonBackUI
{
    self.buttonBack = [UIButton buttonWithBackStyleAndTitle:@"Log In"];
    [self.buttonBack addTarget:self action:@selector(actionGoToLoginView) forControlEvents:UIControlEventTouchDown];
}

- (void)labelSignupUI
{
    self.labelSignup = [[UILabel alloc] init];
    self.labelSignup.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelSignup.backgroundColor = [UIColor clearColor];
    [self.labelSignup setFont:[UIFont fontWithName:@"Livory-Bold" size:25]];
    self.labelSignup.text = @"Sign Up";
}

- (UIButton *)buttonSignupUI
{
    UIButton *result = [UIButton buttonBigWithDarkBackgroundStyleAndTitle:@"Sign Up"];

    return result;
}

- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *result = [[UITextField alloc] init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.borderStyle = UITextBorderStyleRoundedRect;
    result.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    result.autocapitalizationType = UITextAutocapitalizationTypeNone;
    result.placeholder = placeholder;
    
    return result;
}

- (void)addUIComponentsToView:(UIView *)paramView
{
    [paramView addSubview:self.buttonBack];
    [paramView addSubview:self.labelSignup];
    [paramView addSubview:self.textFieldFullname];
    [paramView addSubview:self.textFieldUsername];
    [paramView addSubview:self.textFieldPassword];
    [paramView addSubview:self.buttonSignup];
}

- (NSArray *)buttonBackConstraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonBack, _labelSignup, _textFieldFullname);

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToLoginHorizontal options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonBackToLoginVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)labelSignupContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelSignup, _textFieldFullname);
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelSignupVertical options:0 metrics:nil views:viewsDictionary]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelSignupHorizontal options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)textFieldFullnameContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldFullname);
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldFullnameHorizontal options:0 metrics:nil views:viewsDictionary]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldFullnameVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)textFieldUsernameContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldUsername, _textFieldFullname);
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldUsernameSignupHorizontal options:0 metrics:nil views:viewsDictionary]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldUsernameSignupVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)textFieldPasswordContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldPassword, _textFieldUsername);
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldPasswordSignupHorizontal options:0 metrics:nil views:viewsDictionary]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldPasswordSignupVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)buttonSignupContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonSignup, _textFieldPassword);
    [result addObject:[NSLayoutConstraint constraintWithItem:self.buttonSignup attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonSignupSignupVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];

    [result addObjectsFromArray:[self buttonBackConstraints]];
    [result addObjectsFromArray:[self labelSignupContraints]];
    [result addObjectsFromArray:[self textFieldFullnameContraints]];
    [result addObjectsFromArray:[self textFieldUsernameContraints]];
    [result addObjectsFromArray:[self textFieldPasswordContraints]];
    [result addObjectsFromArray:[self buttonSignupContraints]];
    
    return [NSArray arrayWithArray:result];
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
