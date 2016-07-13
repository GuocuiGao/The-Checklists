//
//  Checklist.m
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

-(id)init
{
    if(self = [super init]) {
        _items = [[NSMutableArray alloc] initWithCapacity:10];
        _iconName = @"No Icon";
    }
    return self;
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"Name"];
        _items = [aDecoder decodeObjectForKey:@"Items"];
        _iconName = [aDecoder decodeObjectForKey:@"iconName"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"Name"];
    [aCoder encodeObject:_items forKey:@"Items"];
    [aCoder encodeObject:_name forKey:@"iconName"];
}

-(int)countUncheckedItems {
    int count = 0;
    
    for(ChecklistItem *item in _items){
        
        if(!item.isChecked) count++;
    }
    return count;
}

- (NSComparisonResult)compare:(Checklist *)another_checklist {
    return [_name localizedStandardCompare:another_checklist.name];
}

@end
