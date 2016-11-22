//
//  ViewController.m
//  Main
//
//  Created by ST on 16/11/22.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - --- 1.init 生命周期 ---

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---
- (IBAction)click:(UIButton *)sender
{
    NSURL *url = [NSURL URLWithString:@"Son://username=st&age=18&id=888888"];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        NSLog(@"%s %d", __FUNCTION__, success);
    }];
}
#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--
@end
