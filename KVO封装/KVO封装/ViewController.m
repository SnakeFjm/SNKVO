//
//  ViewController.m
//  KVO封装
//
//  Created by Snake on 2019/4/23.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "ViewController.h"

#import "SNNextViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor redColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //
    SNNextViewController *vc = [[SNNextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
