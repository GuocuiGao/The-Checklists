//
//  ListDetailViewControllerTableViewController.h
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Checklist;

@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;

-(void)listDetailViewController:(ListDetailViewController *)controller didFinishEdittingChecklist:(Checklist *)checklist;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate,IconPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@property (nonatomic,weak) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic,weak) id<ListDetailViewControllerDelegate> delegate;

@property (nonatomic,strong) Checklist *checklistToEdit;



-(IBAction)done;
-(IBAction)cancel;


@end
