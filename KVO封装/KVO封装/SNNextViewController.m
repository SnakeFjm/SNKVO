//
//  SNNextViewController.m
//  KVO封装
//
//  Created by Snake on 2019/4/23.
//  Copyright © 2019年 Snake. All rights reserved.
//

#import "SNNextViewController.h"

//#import "NSObject+SNKVO.h"

#import "NSObject+SNNewKVO.h"

#import "Person.h"


@interface SNNextViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation SNNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.view.backgroundColor = [UIColor lightGrayColor];
    //
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"Pop" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //
    Person *person1 = [[Person alloc] init];
    
    [self SNObserver:person1 keyPath:@"name" block:^{
        NSLog(@"good");
    }];
    
    person1.name = @"好好学习";

    
//    [person1 SNObserver:self keyPath:@"name" block:^{
//       //
//        NSLog(@"good");
//    }];
    
    //
//    self.person.name = @"好好学习";
}

- (void)buttonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (Person *)person {
    if (!_person) {
        _person = [[Person alloc] init];
    }
    return _person;
}

@end
