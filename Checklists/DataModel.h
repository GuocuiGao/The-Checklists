//
//  DataModel.h
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (nonatomic,strong) NSMutableArray *lists;

+(NSInteger)nextChecklistItemId;

-(void)saveChecklists;
-(NSInteger)indexOfSelectedChecklist;
-(void)setIndexofSelectedChecklist:(NSInteger)index;
-(void)sortChecklists;

@end
