//
//  ChecklistItem.h
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject <NSCoding>

@property (nonatomic,copy) NSString *text;
@property (nonatomic,assign) BOOL isChecked;

@property (nonatomic,copy) NSDate *dueDate;
@property (nonatomic,assign) BOOL shouldRemind;
@property (nonatomic,assign) NSInteger itemId;

-(void)toggleChecked;
-(void)scheduleNotification;

@end
