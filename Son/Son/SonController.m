//
//  SonController.m
//  Son
//
//  Created by ST on 16/11/22.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "SonController.h"

@interface SonController ()

@end

@implementation SonController

#pragma mark - --- 1.init 生命周期 ---

- (instancetype)init
{
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"SonBundle" withExtension:@"bundle"]];
    self = [UIStoryboard storyboardWithName:@"Main" bundle:bundle].instantiateInitialViewController;
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSInteger number = 1 ; number <= 5; number++) {
        UIImage *image = [self imageNamed:[NSString stringWithFormat:@"p%@.jpg", @(number).stringValue]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame: CGRectMake(0, 50 * number + 100, 100, 50)];
        imageView.image = image;
        [self.view addSubview:imageView];
    }
    
    for (NSInteger number = 1 ; number <= 5; number++) {
        UIImage *image = [self imageNamed:[NSString stringWithFormat:@"bizhi%@", @(number).stringValue]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame: CGRectMake(100, 50 * number + 100, 100, 50)];
        imageView.image = image;
        [self.view addSubview:imageView];
    }
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(200, 100, 200, 40)];
    [button setTitle:@"I am a button" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor magentaColor]];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (UIImage *)imageNamed:(NSString *)name {
    NSURL* url = [NSBundle.mainBundle resourceURL];
    url = [url URLByAppendingPathComponent:@"SonBundle"];
    url = [url URLByAppendingPathExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:url];
    return [UIImage imageNamed:name
                      inBundle:bundle
 compatibleWithTraitCollection:UIScreen.mainScreen.traitCollection];
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

- (void)clickButton
{
    NSLog(@"%s %@", __FUNCTION__, self);
}

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
