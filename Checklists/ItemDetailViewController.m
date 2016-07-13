//
//  itemDetailViewController.m
//  Checklists
//
//  Created by Shuyan Guo on 4/26/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "ChecklistItem.h"

@interface ItemDetailViewController () {
    
    NSDate *_dueDate;
    BOOL _datePickerVisible;
}

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_itemToEdit!=nil){
        _textField.text = _itemToEdit.text;
        _donebbutton.enabled = YES;
        self.title = @"Edit Item";
        
        _remindSwitch.on = _itemToEdit.shouldRemind;
        _dueDate = _itemToEdit.dueDate;
        
    }else {
        _remindSwitch.on = NO;
        _dueDate = [NSDate date];
    }
    
    [self updateDueDateLabel];
}

-(void)updateDueDateLabel{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    _dueDateLabel.text = [formatter stringFromDate:_dueDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section == 1 && _datePickerVisible) {
        return 3;
    }

    return [super tableView:tableView numberOfRowsInSection:section];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==1 && indexPath.row ==2){
        return 217;
    }
    
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 1 && indexPath.row == 1){
        return indexPath;
    } else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.textField resignFirstResponder];
    
    if(indexPath.section==1 && indexPath.row==1){
        if(!_datePickerVisible){
            [self showDatePicker];
        }else {
            [self hideDatePicker];
        }
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self hideDatePicker];
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    
    [self.delegate itemDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    if(_itemToEdit==nil){
        ChecklistItem *item = [[ChecklistItem alloc] init];
        item.text = self.textField.text;
        item.isChecked = NO;
        item.shouldRemind = _remindSwitch.on;
        item.dueDate = _dueDate;
        
        [item scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishAddingItem:item];
        
    }else{
        _itemToEdit.text = self.textField.text;
        _itemToEdit.shouldRemind = _remindSwitch.on;
        _itemToEdit.dueDate = _dueDate;
        
        [_itemToEdit scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishEdittingItem:_itemToEdit];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *new_text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    _donebbutton.enabled = (new_text.length > 0);
    
    return YES;
}

-(void)showDatePicker{
    _datePickerVisible = YES;
    
    NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
    
    NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
    cell.detailTextLabel.textColor = [UIColor blueColor];
    
    [self.tableView beginUpdates];
    
    [self.tableView insertRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
    
    [self.tableView endUpdates];
    
    UITableViewCell *datePickerCell = [self.tableView cellForRowAtIndexPath:indexPathDatePicker];
    UIDatePicker *datePicker = (UIDatePicker *)[datePickerCell viewWithTag:100];
    [datePicker setDate:_dueDate animated:NO];
}


-(void)hideDatePicker{
    if(_datePickerVisible){
        _datePickerVisible = NO;
        
        NSIndexPath *indexPathDateRow = [NSIndexPath indexPathForRow:1 inSection:1];
        
        NSIndexPath *indexPathDatePicker = [NSIndexPath indexPathForRow:2 inSection:1];
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPathDateRow];
        
        cell.detailTextLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        [self.tableView beginUpdates];
        [self.tableView reloadRowsAtIndexPaths:@[indexPathDateRow] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView deleteRowsAtIndexPaths:@[indexPathDatePicker] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if(indexPath.section ==1 && indexPath.row == 2){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DatePickerCell"];
        
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DatePickerCell"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, 216)];
            datePicker.tag = 100;
            [cell.contentView addSubview:datePicker];
            
            [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        }
        return cell;
    } else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section ==1 && indexPath.row ==2){
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        
        return [super tableView:tableView indentationLevelForRowAtIndexPath:newIndexPath];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

-(void)dateChanged:(UIDatePicker *)datePicker{
    _dueDate = datePicker.date;
    [self updateDueDateLabel];
}



@end
