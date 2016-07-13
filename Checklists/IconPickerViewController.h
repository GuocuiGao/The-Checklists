//
//  IconPickerViewController.h
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName;

@end

@interface IconPickerViewController : UITableViewController

@property (nonatomic,weak) id<IconPickerViewControllerDelegate> delegate;



@end
