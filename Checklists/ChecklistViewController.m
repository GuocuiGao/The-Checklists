//
//  ChecklistViewController.m
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "ChecklistViewController.h"
#import "Checklist.h"

@interface ChecklistViewController ()

@end

@implementation ChecklistViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.checklist.name;
    
//    NSLog(@"%@",[self documentsDirectory]);
//    NSLog(@"%@",[self dataFilePath]);
//    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _checklist.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = _checklist.items[indexPath.row];
    
    [self configureCheckMarkForCell:cell withChecklistItem:item];
    [self configureTextForCell:cell withChecklistItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = _checklist.items[indexPath.row];
    [item toggleChecked];
    
    [self configureCheckMarkForCell:cell withChecklistItem:item];
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

-(void)configureCheckMarkForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item {
    
    UILabel *label = [cell viewWithTag:1001];
    
    if(item.isChecked) {
        label.text = @"✅";
    }else{
        label.text = @"";
    }
}

-(void)configureTextForCell:(UITableViewCell *)cell withChecklistItem:(ChecklistItem *)item {
    
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = [NSString stringWithFormat:@"%@", item.text];
    UILabel *dueDateLabel = (UILabel *)[cell viewWithTag:1002];
    dueDateLabel.text = [NSString stringWithFormat:@"%@",item.dueDate];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_checklist.items removeObjectAtIndex:indexPath.row];
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)addItem:(ChecklistItem *)item {
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:_checklist.items.count inSection:0];
    
    [_checklist.items addObject:item];
    
    [self.tableView insertRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationAutomatic];
}
-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item{
    
    [self addItem:item];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEdittingItem:(ChecklistItem *)item {

     NSIndexPath *path = [NSIndexPath indexPathForRow:[_checklist.items indexOfObject:item] inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:path];
    [self configureTextForCell:cell withChecklistItem:item];
    
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"AddItem"]){
        UINavigationController *navigation = segue.destinationViewController;
        
        ItemDetailViewController *controller = (ItemDetailViewController *)navigation.topViewController;
        
        controller.delegate = self;
        
    }else if([segue.identifier isEqualToString:@"EditItem"]){
        UINavigationController *navigation = segue.destinationViewController;
        
        ItemDetailViewController *controller = (ItemDetailViewController *)navigation.topViewController;
        
        controller.delegate = self;
        
        NSIndexPath *path = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = _checklist.items[path.row];
    }
}

@end
