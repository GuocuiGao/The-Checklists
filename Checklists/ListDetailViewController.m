//
//  ListDetailViewControllerTableViewController.m
//  Checklists
//
//  Created by Shuyan Guo on 4/28/16.
//  Copyright © 2016 GG. All rights reserved.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController () {
    NSString *_iconName;
}

@end

@implementation ListDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        _iconName = @"Folder";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(_checklistToEdit != nil){
        self.title = @"Edit Checklist";
        _textField.text = _checklistToEdit.name;
        _doneButton.enabled = YES;
        _iconName = _checklistToEdit.iconName;
    }
    self.iconImageView.image = [UIImage imageNamed:@"_iconName"];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 1){
        return indexPath;
    }
    return nil;
}

-(IBAction)cancel{
    [self.delegate listDetailViewControllerDidCancel:self];
}

-(IBAction)done {
    if(_checklistToEdit != nil){
        _checklistToEdit.name = _textField.text;
        _checklistToEdit.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishEdittingChecklist:_checklistToEdit];
        
    }else{
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = _textField.text;
        checklist.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    }
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_textField becomeFirstResponder];
}



-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *new_text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    _doneButton.enabled = (new_text.length > 0);
    
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"PickIcon"]){
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

-(void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName {
    _iconName = iconName;
    
    self.iconImageView.image = [UIImage imageNamed:_iconName];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
