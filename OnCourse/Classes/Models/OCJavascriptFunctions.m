//
//  OCJavascriptFunctions.m
//  OnCourse
//
//  Created by East Agile on 12/2/12.
//  Copyright (c) 2012 phatle. All rights reserved.
//

#import "OCJavascriptFunctions.h"

@implementation OCJavascriptFunctions

+ (NSString *)jsLogin
{
    return @"function OCLogin() { document.getElementsByClassName('btn btn-success coursera-signin-button')[0].click(); } OCLogin();";
}

+ (NSString *)jsFillElement:(NSString *)element withContent:(NSString *)content
{
    return [NSString stringWithFormat:@"function OCFillElement(){ document.getElementById('%@').value = '%@' } OCFillElement();",element, content];
}

+ (NSString *)jsCallObjectiveCFunction
{
    return @"function callObjectiveCFunction(functionName, args) { var iframe = document.createElement('IFRAME'); iframe.setAttribute('src', 'js-frame:' + functionName + ':' + encodeURIComponent(JSON.stringify(args))); document.documentElement.appendChild(iframe); iframe.parentNode.removeChild(iframe); iframe = null; }";
}

+ (NSString *)checkLogined
{
    return @"var intervalId = setInterval(function() { var courses = document.getElementsByClassName('coursera-course-listing-box coursera-course-listing-box-wide coursera-account-course-listing-box'); if (courses.length > 0) { callObjectiveCFunction('login_successfully','nothing'); clearInterval(intervalId); } else {  } }, 1000);";
}

+ (NSString *)checkPageLoaded
{
    return @"var pageLoadIntervalId = setInterval(function() { if (jQuery.active == 0) { callObjectiveCFunction('pageLoaded','nothing'); clearInterval(pageLoadIntervalId); } else {  } }, 1000);";
    
}

@end
