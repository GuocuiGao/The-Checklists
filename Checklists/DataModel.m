//
//  DataModel.m
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

+(NSInteger)nextChecklistItemId{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger itemId = [userDefaults integerForKey:@"ChecklistItemId"];
    
    [userDefaults setInteger:itemId+1 forKey:@"ChecklistItemId"];
    
    [userDefaults synchronize];
    
    return itemId;
}

-(NSString *)documentDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths firstObject];
    return documentsDirectory;
}

-(NSString *)dataFilePath
{
    return [[self documentDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

-(void)saveChecklists
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:_lists forKey:@"Checklists"];
    [archiver finishEncoding];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
}

-(void)loadChecklists
{
    NSString *path = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        _lists = [unarchiver decodeObjectForKey:@"Checklists"];
        [unarchiver finishDecoding];
        
    }else{
        _lists = [[NSMutableArray alloc] initWithCapacity:10];
    }
}

-(void)registerDefaults{
    NSDictionary *dictionary = @{
                                 @"ChecklistIndex": @-1,
                                 @"FirstTime":@YES,
                                 @"ChecklistItemId":@0
                                 };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

-(void)handleFirstTime {
    
    BOOL firsttime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    
    if(firsttime){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = @"List";
        
        [_lists addObject:checklist];
        [self setIndexofSelectedChecklist:0];
        
    }
}

-(id)init {
    if(self = [super init]){
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

-(NSInteger)indexOfSelectedChecklist {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}
-(void)setIndexofSelectedChecklist:(NSInteger)index {
    
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

-(void)sortChecklists {
    [_lists sortedArrayUsingSelector:@selector(compare:)];
}

@end
