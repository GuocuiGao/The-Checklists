//
//  ChecklistItem.m
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "ChecklistItem.h"
#import "DataModel.h"
@import UIKit;

@implementation ChecklistItem

-(id)init{
    if(self = [super init]){
        self.itemId = [DataModel nextChecklistItemId];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _text = [aDecoder decodeObjectForKey:@"Text"];
        _isChecked = [aDecoder decodeBoolForKey:@"isChecked"];
        
        _dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        _shouldRemind = [aDecoder decodeBoolForKey:@"ShouldRemind"];
        _itemId = [aDecoder decodeIntegerForKey:@"ItemId"];
        
    }
    return self;
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_text forKey:@"Text"];
    [aCoder encodeBool:_isChecked forKey:@"isChecked"];
    
    [aCoder encodeObject:_dueDate forKey:@"DueDate"];
    [aCoder encodeBool:_shouldRemind forKey:@"ShouldRemind"];
    [aCoder encodeInteger:_itemId forKey:@"ItemID"];
    
}
-(void)toggleChecked {
    
    _isChecked = !_isChecked;
    
}
- (void)scheduleNotification
{
     
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        NSLog(@"Found an existing notification %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
    if (self.shouldRemind && [self.dueDate compare:[NSDate date]] != NSOrderedAscending) {
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.text;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = @{ @"ItemID" : @(self.itemId) };
        localNotification.alertAction = @"View";
        localNotification.category = @"CheckListReminderCategory";
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
                                                       settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|
                                                       UIUserNotificationTypeSound categories:nil]];
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSLog(@"Scheduled notification %@ for itemId %d", localNotification, (int)self.itemId);
    }
}

- (UILocalNotification *)notificationForThisItem
{
    NSArray *allNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotifications) {
        NSNumber *number = [notification.userInfo objectForKey:@"ItemID"];
        if (number != nil && [number integerValue] == self.itemId) {
            return notification;
        }
    }
    return nil;
}

- (void)dealloc
{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        NSLog(@"Removing existing notification %@", existingNotification);
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
}

@end
