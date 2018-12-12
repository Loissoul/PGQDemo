//
//  RootViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2017/12/25.
//  Copyright © 2017年 Lois_pan. All rights reserved.
//

#import "RootViewController.h"
#import "GQTabBarViewController.h"

#import "TestCodeViewController.h"
#import "TestTableViewCellViewController.h"
#import "TestPlayViewController.h"
#import "TranVC1Controller.h"
#import "GCDViewController.h"
#import "TimerProxyViewController.h"
#import "TableViewController.h"

#import "PGQDemo-Swift.h"

@interface RootViewController ()

@property (nonatomic, strong) NSArray *dataArr;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _dataArr = @[@"1.Thread Demo(GCD)", @"2.自定义VC转场动画", @"3.KVO底层原理实现", @"4.Category和Extension结构体", @"5.NSTimer的循环引用解决，NSPoxy的消息转发机制", @"6.算法", @"7.tableViewCell delete"];
    
    self.tableView.tableFooterView = [[UIView alloc] init];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    NSLog(@"%ld",row);
    
    if(row == 0){
        GCDViewController *gcdVC = [[GCDViewController alloc] init];
        [self .navigationController pushViewController:gcdVC animated:YES];
    } else if (row == 1){
        [self.navigationController pushViewController:[TranVC1Controller new] animated:YES];
    } else if (row == 4){
        [self.navigationController pushViewController:[TimerProxyViewController new] animated:YES];
    } else if (row == 5) {
        [self.navigationController pushViewController:[AlgorithmSwiftViewController new] animated:YES];

    } else if (row == 6) {
        [self.navigationController pushViewController:[TableViewController new] animated:YES];

    }
}


- (void)test {
    for (int i = 2; i < 10; i++) {
        i *= 2;
        NSLog(@"%i\n", i);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
}

- (void)testButtonClick {
//    [self.navigationController pushViewController:[TestCodeViewController new] animated:YES];
    
    [self.navigationController pushViewController:[TestTableViewCellViewController new] animated:YES];

}

- (void)buttonClick {
    
    [self.navigationController pushViewController:[TranVC1Controller new] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
