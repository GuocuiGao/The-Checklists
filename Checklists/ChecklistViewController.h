//
//  ChecklistsViewController.h
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChecklistItem.h"
#import "ItemDetailViewController.h"

@class Checklist;

@interface ChecklistViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property(nonatomic,strong) Checklist *checklist;

- (void)addItem:(ChecklistItem *)item;

@end
