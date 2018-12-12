//
//  TranVC2Controller.m
//  PGQDemo
//
//  Created by Lois_pan on 2018/7/3.
//  Copyright © 2018年 Lois_pan. All rights reserved.
//

#import "TranVC2Controller.h"
#import "GQTransition.h"

@interface TranVC2Controller ()

@end

@implementation TranVC2Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    UIButton * button = [[UIButton alloc] init];
    
    button.backgroundColor = [UIColor blueColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: button];
}

- (void)backButtonClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}




@end
