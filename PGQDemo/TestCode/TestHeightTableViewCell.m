//
//  TestHeightTableViewCell.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/1/22.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TestHeightTableViewCell.h"

@implementation TestHeightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}

- (void)createView {
    UILabel * label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.text = @"1.OC你了解的锁有哪些？在你回答基础上进行二次提问；追问一：自旋和互斥对比？追问二：使用以上锁需要注意哪些？追问三：用C/OC/C++，任选其一，实现自旋或互斥？口述即可！2.内存泄漏可能会出现的几种原因，聊聊你的看法？追问一：非OC对象如何处理？追问二：地图类内存若泄漏，如何处理？追问三：若常用框架出现内存泄漏如何处理？3.容错处理你们一般是怎么做的？4.项目开始容错处理没做？如何防止拦截潜在的崩溃？";
    label.numberOfLines = 0;
    [self.contentView addSubview: label];
    [label sizeToFit];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}

@end
