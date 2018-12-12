//
//  TestTableViewCellViewController.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/22.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//


//利用masonry不需要计算cell的高度
#import "TestTableViewCellViewController.h"
#import "TestHeightTableViewCell.h"

@interface TestTableViewCellViewController ()<UITableViewDelegate, UITableViewDataSource> {
    UITableView * _tableView;
}

@end

@implementation TestTableViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview: [self tableView]];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark - tableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  [tableView dequeueReusableCellWithIdentifier:@"TestHeightTableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        _tableView.backgroundColor = UIColorFromRGB(0Xfcfcfc);
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.estimatedRowHeight = 150;//估算高度
//        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[TestHeightTableViewCell class] forCellReuseIdentifier:@"TestHeightTableViewCell"];
    }
    return _tableView;
}

@end
