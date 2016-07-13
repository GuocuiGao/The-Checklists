//
//  AllListsViewController.h
//  Checklists
//
//  Created by Shuyan Guo on 4/27/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

@class DataModel;

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic,strong) DataModel *dataModel;


@end
