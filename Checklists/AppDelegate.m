//
//  AppDelegate.m
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"


@interface AppDelegate (){
    DataModel *_dataModel;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _dataModel = [[DataModel alloc] init];
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    
    AllListsViewController *controller = navigationController.viewControllers[0];
    
    controller.dataModel = _dataModel;
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = date;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.alertBody = @"I am a local notification!";
    localNotification.soundName =
    UILocalNotificationDefaultSoundName;
    localNotification.alertAction = @"View Checklist";
    localNotification.category = @"CheckListReminderCategory";
    [application registerUserNotificationSettings:[UIUserNotificationSettings
                                                   settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|
                                                   UIUserNotificationTypeSound categories:nil]];
    [[UIApplication sharedApplication]
     scheduleLocalNotification:localNotification];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

-(void)saveData
{
    [_dataModel saveChecklists];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveData];
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

@end
