//
//  OCLoginView.m
//  OnCourse
//
//  Created by East Agile on 11/30/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCAppDelegate.h"
#import "OCSignupViewController.h"
#import "OCUtility.h"
#import "OCLoginView.h"
#import "MBProgressHUD.h"
#import "UIButton+Style.h"

#define WIDTH_IPHONE_5 568
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_5)

NSString *const kLabelAppnameVertical = @"V:|-25-[_labelAppname]-25-[_textFieldUsername]";

NSString *const kTextFieldUsernameHorizontal = @"H:|-[_textFieldUsername]-|";
NSString *const kTextFieldUsernameVertical = @"V:[_textFieldUsername(==40)]";

NSString *const kTextFieldPasswordHorizontal = @"H:|-[_textFieldPassword]-|";
NSString *const kTextFieldPasswordVertical = @"V:[_textFieldUsername]-[_textFieldPassword(==40)]";

NSString *const kButtonLoginVertical = @"V:[_textFieldPassword]-20-[_buttonLogin]";

NSString *const kLableOrVertical = @"V:[_buttonLogin]-20-[_labelOr]";

NSString *const kButtonSignupVertical = @"V:[_labelOr]-20-[_buttonSignup]";

@interface OCLoginView()

@property (nonatomic, strong) UILabel *labelAppname;
@property (nonatomic, strong) UILabel *labelOr;

@end

@implementation OCLoginView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self constructUIComponents];
        [self addConstraints:[self arrayContraints]];
        [self setNiceBackground];
    }
    return self;
}

- (void)constructUIComponents
{
    [self labelAppnameUI];
    self.textFieldUsername = [self textFieldWithPlaceholder:@"Your email"];
    self.textFieldPassword = [self textFieldWithPlaceholder:@"Your password"];
    [self.textFieldPassword setSecureTextEntry:YES];
    [self buttonLoginUI];
    [self labelOrUI];
    [self buttonSignupUI];
    
    [self addUIComponentsToView:self];
}

- (void)labelAppnameUI
{
    self.labelAppname = [[UILabel alloc] init];
    self.labelAppname.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelAppname.backgroundColor = [UIColor clearColor];
    [self.labelAppname setFont:[UIFont fontWithName:@"Livory-Bold" size:38]];
    self.labelAppname.text = @"OnCourse";
}

- (void)labelOrUI
{
    self.labelOr = [[UILabel alloc] init];
    self.labelOr.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelOr.backgroundColor = [UIColor clearColor];
    [self.labelOr setFont:[UIFont fontWithName:@"Livory" size:18]];
    self.labelOr.text = @"No Account Yet? Press Sign Up now.";
}

- (void)buttonLoginUI
{
    self.buttonLogin = [UIButton buttonBigWithDarkBackgroundStyleAndTitle:@"Sign In"];
    [self.buttonLogin setTitle:@"Sign In" forState:UIControlStateNormal];
}

- (void)buttonSignupUI
{
    self.buttonSignup = [UIButton buttonBigWithDarkBackgroundStyleAndTitle:@"Sign Up"];
    [self.buttonSignup addTarget:self action:@selector(buttonSignupAction) forControlEvents:UIControlEventTouchDown];
}

- (void)setNiceBackground
{
    if (IS_IPHONE_5)
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background-568h@2x.png"]]];
    else
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_background.png"]]];
    
}

- (void)buttonSignupAction
{
    [[[UIAlertView alloc] initWithTitle:@"Coming soon" message:@"This feature is in development." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
//    OCAppDelegate *appDelegate = [OCUtility appDelegate];
//    [appDelegate.navigationController pushViewController:[[OCSignupViewController alloc] init] animated: YES];
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
    [paramView addSubview:self.labelAppname];
    [paramView addSubview:self.textFieldUsername];
    [paramView addSubview:self.textFieldPassword];
    [paramView addSubview:self.buttonLogin];
    [paramView addSubview:self.labelOr];
    [paramView addSubview:self.buttonSignup];
}

- (NSArray *)labelAppnameContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelAppname, _textFieldUsername);

    [result addObject:[NSLayoutConstraint constraintWithItem:self.labelAppname attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLabelAppnameVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)textFieldUsernameContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldUsername);
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldUsernameHorizontal options:0 metrics:nil views:viewsDictionary]];

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldUsernameVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)textFieldPasswordContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_textFieldPassword, _textFieldUsername);
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldPasswordHorizontal options:0 metrics:nil views:viewsDictionary]];

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kTextFieldPasswordVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)buttonLoginContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonLogin, _textFieldPassword);
    [result addObject:[NSLayoutConstraint constraintWithItem:self.buttonLogin attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];

    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonLoginVertical options:0 metrics:nil views:viewsDictionary]];

    return [NSArray arrayWithArray:result];
}

- (NSArray *)labelOrContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_labelOr, _buttonLogin);
    
    [result addObject:[NSLayoutConstraint constraintWithItem:self.labelOr attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kLableOrVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)buttonSignupContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_buttonSignup, _labelOr);
    [result addObject:[NSLayoutConstraint constraintWithItem:self.buttonSignup attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    
    [result addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:kButtonSignupVertical options:0 metrics:nil views:viewsDictionary]];
    
    return [NSArray arrayWithArray:result];
}

- (NSArray *)arrayContraints
{
    NSMutableArray *result = [@[] mutableCopy];
    
    [result addObjectsFromArray:[self labelAppnameContraints]];
    [result addObjectsFromArray:[self textFieldUsernameContraints]];
    [result addObjectsFromArray:[self textFieldPasswordContraints]];
    [result addObjectsFromArray:[self buttonLoginContraints]];
    [result addObjectsFromArray:[self labelOrContraints]];
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
