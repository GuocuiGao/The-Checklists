//
//  itemDetailViewController.h
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ChecklistItem;
@class ItemDetailViewController;

@protocol ItemDetailViewControllerDelegate <NSObject>

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller;

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item;

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEdittingItem:(ChecklistItem *)item;

@end

@interface ItemDetailViewController : UITableViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <ItemDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebbutton;
@property (nonatomic, strong) ChecklistItem *itemToEdit;

@property (weak, nonatomic) IBOutlet UISwitch *remindSwitch;
@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;



- (IBAction)done;

- (IBAction)cancel:(UIBarButtonItem *)sender;

@end
