//
//  AppDelegate.m
//  TouchTest
//
//  Created by 刘杰 on 2017/1/25.
//  Copyright © 2017年 LJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 当第一次打开APP时，应当通过「UIApplicationLaunchOptionsShortcutItemKey」key值来获取UIApplicationShortcutItem，当存在此对象时，应当返回「NO」,这样程序就不会调用「application performActionForShortcutItem:」方法；
    // 当不是首次打开APP，则返回YES
    NSLog(@"%@",launchOptions[@"UIApplicationLaunchOptionsShortcutItemKey"]);
    // 添加Home Screen Icon 3D Touch Item
    [self loadHomeScreenTouch];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loadHomeScreenTouch {
    // 设置Home Screen Icon
    UIApplicationShortcutItem *firstItem = [[UIApplicationShortcutItem alloc] initWithType:@"shortCutItem.second" localizedTitle:@"查看图片详情"];
    // userInfo字典可以存放APP版本信息，根据版本来适配Home Screen QuickAction
    UIApplicationShortcutItem *secondItem = [[UIApplicationShortcutItem alloc] initWithType:@"shortCutItem.third" localizedTitle:@"第三个" localizedSubtitle:@"副标题3" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
    UIMutableApplicationShortcutItem *thirdItem = [[UIMutableApplicationShortcutItem alloc] initWithType:@"shortCutItem.forth" localizedTitle:@"第四个"];
    thirdItem.localizedSubtitle = @"副标题4";
    thirdItem.icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare];
    [UIApplication sharedApplication].shortcutItems = @[firstItem, secondItem, thirdItem];
}


// 3D Touch 回调
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:@"shortCutItem.first"]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击了静态QuickAction" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self.window.rootViewController presentViewController:alertVC animated:YES completion:^{
            
        }];
    }
    if ([shortcutItem.type isEqualToString:@"shortCutItem.second"]) {
        DetailViewController *detailVC = [[DetailViewController alloc] init];
        [self.window.rootViewController showViewController:detailVC sender:nil];
    }
    if ([shortcutItem.type isEqualToString:@"shortCutItem.third"]) {
        NSArray *arr = @[@"第一个展示"];
        UIActivityViewController *firstVC = [[UIActivityViewController alloc] initWithActivityItems:arr applicationActivities:nil];
        [self.window.rootViewController presentViewController:firstVC animated:YES completion:^{

        }];
    }
    if ([shortcutItem.type isEqualToString:@"shortCutItem.forth"]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你知道这是第几个不？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self.window.rootViewController presentViewController:alertVC animated:YES completion:^{
            
        }];
    }
    completionHandler(shortcutItem);
    
}




@end
