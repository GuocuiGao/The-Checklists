//
//  Checklist.h
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Checklist : NSObject <NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) NSString *iconName;

- (int)countUncheckedItems;

- (NSComparisonResult)compare:(Checklist *)another_checklist;

@end
