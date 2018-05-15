//
//  ViewController.m
//  UserLocalNotificationDemo
//
//  Created by fengxin on 2018/5/15.
//  Copyright © 2018年 fengxin. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController
- (IBAction)videoLocalNotificationClickHandle:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"这是title";
    content.body = @"这是body";
    content.sound = [UNNotificationSound defaultSound];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"赵薇-烟雨蒙蒙" ofType:@"mp3"];
    NSError *error = nil;
    UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"atta1" URL:[NSURL fileURLWithPath:path] options:nil error:&error];
    if (error) {
        NSLog(@"attachment error :%@",error);
    }
    if (attachment) {
        content.attachments = @[attachment];
    }
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:NO]];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
}

- (IBAction)imageLocalNotificationClickHandle:(id)sender {
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"这是title";
    content.body = @"这是body";
    content.sound = [UNNotificationSound defaultSound];
   
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"]];
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"attachId" URL:url options:nil error:nil];
    if (attach)
    {
        content.attachments = @[attach];
    }
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:NO]];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
}
- (IBAction)gifLocalNotificationClickHandle:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"这是title";
    content.body = @"这是body";
    content.sound = [UNNotificationSound defaultSound];
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"gif"]];
    UNNotificationAttachment *attach = [UNNotificationAttachment attachmentWithIdentifier:@"attachId" URL:url options:nil error:nil];
    if (attach)
    {
        content.attachments = @[attach];
    }
    
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"requestId" content:content trigger:[UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:NO]];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}


- (IBAction)firstLocalNotificationClickHandle:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"时间戳定时推送";
    content.subtitle = @"subtitle";
    content.body = @"这个是body";
    content.sound = [UNNotificationSound soundNamed:@"test.caf"];
    /*重点开始*/
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    /*重点结束*/
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"TimeInterval" content:content trigger:trigger];
    
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加时间戳定时推送 : %@", error ? [NSString stringWithFormat:@"error : %@", error] : @"success");
    }];
}
- (IBAction)secondLocalNotificationClickHandle:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"周期性推送";
    content.subtitle = @"subTitle";
    content.body = @"这个是body";
    content.sound = [UNNotificationSound defaultSound];
    NSDateComponents *components =[[NSDateComponents alloc]init];
    components.weekday = 3;  //周2
    components.hour = 20; //14点
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:YES];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Calendar" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter ]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加周期性定时推送 %@",error?[NSString stringWithFormat:@"error :%@",error]: @"success");
    }];
}

- (IBAction)thirdLocalNotificationHandle:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"指定位置推送";
    content.subtitle = @"subtitle";
    content.body = @"这个是body";
    content.sound = [UNNotificationSound defaultSound];
    //：30.5387187661,104.0759325027
    CLLocationCoordinate2D cen = CLLocationCoordinate2DMake(30.5387187661, 104.0759325027);
    CLRegion *region = [[CLCircularRegion alloc]initWithCenter:cen radius:100 identifier:@"center"];
    region.notifyOnExit = YES;
    region.notifyOnEntry = NO;
    UNLocationNotificationTrigger *trigger = [UNLocationNotificationTrigger triggerWithRegion:region repeats:YES];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"Location" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加指定位置推送 %@",error?[NSString stringWithFormat:@"%@",error]:@"success");
    }];
}

- (IBAction)categoryLocalNotificationClickHandle:(id)sender {
    
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"推送";
    content.subtitle = @"category样式1";
    content.body = @"这个是body";
    content.sound = [UNNotificationSound defaultSound];
    /*重点开始*/
    content.categoryIdentifier = @"category1";
    /*重点结束*/
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"category1Identifier" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加推送： %@",error ? [NSString stringWithFormat:@"error%@",error ]:@"success");
    }];
    
}

- (IBAction)secondCategoryLocalNotificationClickHandle:(id)sender {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
    content.title = @"推送";
    content.subtitle = @"category样式2";
    content.body = @"这个是body";
    content.sound = [UNNotificationSound defaultSound];
    /*重点开始*/
    content.categoryIdentifier = @"category2";
    /*重点结束*/
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"category2Identifier" content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter]addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        NSLog(@"添加推送： %@",error ? [NSString stringWithFormat:@"error%@",error ]:@"success");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
