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

+ (NSString *)jsCheckCheckbox:(NSString *)checkboxId
{
    return [NSString stringWithFormat:@"function OCCheckCheckbox(){ document.getElementById('%@').checked = true; } OCCheckCheckbox();",checkboxId];
}

+ (NSString *)jsClickButton:(NSString *)buttonClassName
{
    return [NSString stringWithFormat:@"var pageLoadIntervalId = setInterval(function() { var bts = document.getElementsByClassName('%@'); if (bts[0] != 0) { clearInterval(pageLoadIntervalId); bts[0].click();} else {  } }, 1000);",buttonClassName];
}

+ (NSString *)jsSimulateKeyupEvent:(NSString *)elementId
{
    return [NSString stringWithFormat:@"jQuery('#%@').keyup();", elementId ];
}

+ (NSString *)jsCallObjectiveCFunction
{
    return @"function callObjectiveCFunction(functionName, args) { var iframe = document.createElement('IFRAME'); iframe.setAttribute('src', 'js-frame:' + functionName + ':' + encodeURIComponent(JSON.stringify(args))); document.documentElement.appendChild(iframe); iframe.parentNode.removeChild(iframe); iframe = null; }";
}

+ (NSString *)checkLogined
{
    return @"var intervalId = setInterval(function() { var courses = document.getElementsByClassName('coursera-course-listing-box coursera-course-listing-box-wide coursera-account-course-listing-box'); var signinFail = document.getElementById('signin-fail'); if (courses.length > 0) { callObjectiveCFunction('login_successfully','nothing'); clearInterval(intervalId); } else if (signinFail) { callObjectiveCFunction('login_fail','nothing'); clearInterval(intervalId); } }, 1000);";
}

+ (NSString *)checkPageLoaded
{
    return @"var pageLoadIntervalId = setInterval(function() { if (jQuery.active == 0) { clearInterval(pageLoadIntervalId); callObjectiveCFunction('pageLoaded','nothing');} else {  } }, 1000);";
    
}

+ (NSString *)checkCourseLoaded
{
    return @"var number = 0; var pageLoadIntervalId = setInterval(function() { if (jQuery.active == 0) { number +=1; if(number >=2) {callObjectiveCFunction('pageLoaded','nothing'); clearInterval(pageLoadIntervalId);} } else {  } }, 1000);";
}

+ (NSString *)jsCheckAuthenticationCourseNeeded
{
    return @"function OCCheckAuthenticationCourseNeeded(){ if (document.getElementById('agreehonorcode')) return true; else return false; } OCCheckAuthenticationCourseNeeded();";
}

+ (NSString *)jsAuthenticateCourse
{
    return @"function OCAuthenticateCourse(){ return document.getElementById('agreehonorcode').href; } OCAuthenticateCourse();";
}

+ (NSString *)jsFetchLectureLinks
{
    return @"function OCFetchLectureLinks() { var lecture_listing = []; var listSection = document.getElementsByClassName('course-item-list-header'); var listItem = document.getElementsByClassName('course-item-list-section-list'); for (var i = 0; i < listSection.length; ++i) { var aSection = new Object(); var sectionName = listSection[i].getElementsByTagName('h3')[0].innerText; var items = listItem[i].getElementsByClassName('lecture-link'); var listLectureInSection = []; for (var j = 0; j < items.length; ++j) { var aLecture = new Object(); aLecture.lecture_link = items[j].href; aLecture.lecture_title = items[j].text; listLectureInSection.push(aLecture); } aSection.section_name = sectionName; aSection.lecture = listLectureInSection; lecture_listing.push(aSection); } var rs = new Object(); rs.lectures = lecture_listing; return JSON.stringify(rs); } OCFetchLectureLinks(); ";
}

+ (NSString *)jsPlayLectureVideo
{
    return @"var checkDirectLinkIntervalId = setInterval(function() { iframe = document.getElementsByTagName('iframe')[0]; var innerDoc = iframe.contentDocument || iframe.contentWindow.document; var directLink = innerDoc.getElementById('QL_video_element_first').src; if (directLink) { clearInterval(checkDirectLinkIntervalId); callObjectiveCFunction('haveDirectLink', directLink);} else {  } }, 1000);";
}

+ (NSString *)jsGetDirectLink
{
    return @"function OCGetDirectLink(){ iframe = document.getElementsByTagName('iframe')[0]; var innerDoc = iframe.contentDocument || iframe.contentWindow.document; return innerDoc.getElementById('QL_video_element_first').src; } OCGetDirectLink();";
}

+ (NSString *)jsCheckSignUpSuccessfully
{
    return @"var pageLoadIntervalId = setInterval(function() { if (document.getElementsByClassName('coursera-header-account-name').length != 0) { callObjectiveCFunction('signup_successfully','nothing'); clearInterval(pageLoadIntervalId); } else {  } }, 1000);";
    
}

+ (NSString *)jsFetchAllCourses
{
    return @"function OCFetchAllCourses() { var coursera_listing = []; var coursera_listing_box = document.getElementsByClassName('coursera-course-listing-box coursera-course-listing-box-wide coursera-account-course-listing-box'); for (var i = 0; i< coursera_listing_box.length; ++i) { aCourse = new Object(); var aBox = coursera_listing_box[i]; var coursera_image = aBox.getElementsByClassName('coursera-course-listing-icon')[0].src; var coursera_name = aBox.getElementsByClassName('coursera-course-listing-name')[0].getElementsByTagName('a')[0].innerText; var coursera_link = aBox.getElementsByClassName('coursera-course-listing-name')[0].getElementsByTagName('a')[0].href; var coursera_meta_info = aBox.getElementsByTagName('span')[0].innerText; var coursera_meta_status = aBox.getElementsByClassName('coursera-course-listing-meta')[0].getElementsByTagName('a')[0].getAttribute('disabled') ? 'disable' : 'available'; var progress_bar = aBox.getElementsByClassName('progress-bar'); var coursera_progress = progress_bar.length > 0 ? progress_bar[0].style.width.slice(0, -1) : -1; aCourse.course_image = coursera_image; aCourse.course_name = coursera_name; aCourse.course_link = coursera_link; aCourse.course_meta_info = coursera_meta_info; aCourse.course_status = coursera_meta_status; aCourse.course_progress = coursera_progress; coursera_listing.push(aCourse); } return JSON.stringify(coursera_listing); } OCFetchAllCourses(); ";
}

@end
