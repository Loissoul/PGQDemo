//
//  TableViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/9/19.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TableViewController.h"
#import "TestDeleteCell.h"

@interface TableViewController () <MGSwipeTableCellDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TestDeleteCell class] forCellReuseIdentifier:@"TestDeleteCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestDeleteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestDeleteCell" forIndexPath:indexPath];
    cell.textLabel.text = @"哈哈哈哈1";
    cell.delegate = self;
    cell.allowsMultipleSwipe = YES;

    cell.rightButtons = [self createRightButtons];
//    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;

    return cell;
}

//- (NSArray*)swipeTableCell:(MGSwipeTableCell*) cell swipeButtonsForDirection:(MGSwipeDirection)direction
//             swipeSettings:(MGSwipeSettings*) swipeSettings expansionSettings:(MGSwipeExpansionSettings*) expansionSettings;
//{
//    
//    if (direction == MGSwipeDirectionRightToLeft) {
//        expansionSettings.buttonIndex = -1;
////        expansionSettings.fillOnTrigger = YES;
//        return [self createRightButtons];
//    }
//    return nil;
//}

- (BOOL)swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion {

    
    if (direction == MGSwipeDirectionRightToLeft && index == 0) {
        //delete button
//        NSIndexPath * path = [self.tableView indexPathForCell:cell];
//        [tests removeObjectAtIndex:path.row];
//        [_tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationLeft];
        return NO; //Don't autohide to improve delete expansion animation
    }
    if (direction == MGSwipeDirectionRightToLeft && index == 1) {
        NSLog(@"点击确定");
        return NO; //Don't autohide to improve delete expansion animation
    }

    return YES;
}

- (NSArray *)createRightButtons {
    NSMutableArray * result = [NSMutableArray array];
    NSString * images[2] = {@"course-a-delete", @"course-a-private"};
    UIColor * colors[2] = {[UIColor redColor], [UIColor lightGrayColor]};
    for (int i = 0; i < 2; ++i)  {
        
        MGSwipeButton * button = [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed: images[i]] backgroundColor:colors[i] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
            BOOL autoHide = i != 0;
            return autoHide; //Don't autohide in delete button to improve delete expansion animation
        }];
        [result addObject:button];
    }
    return result;
}

@end
