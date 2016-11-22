//
//  SonSDK.m
//  Son
//
//  Created by ST on 16/11/22.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "SonSDK.h"

@interface SonSDK()

@end

@implementation SonSDK
#pragma mark - --- 1.init 生命周期 ---

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---

- (BOOL)openURL:(NSURL *)url
{
    // 1.scheme建议设置为app的名称
    NSString *scheme = @"Son";
    
    if ([url.scheme isEqualToString:scheme]) {
        // 1.数据处理
        NSLog(@"%s %@", __FUNCTION__, [self queryComponents:url]);
        
        // 2.界面跳转处理
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([rootVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navVC = (UINavigationController *)rootVC;
            [navVC pushViewController:[UIViewController new] animated:YES];
        }else {
        
        }
        return YES;
    }else {
        return NO;
    }
}

- (NSDictionary*)queryComponents:(NSURL *)url {
    NSArray *array = [url.host componentsSeparatedByString: @"&"];
    NSMutableDictionary *dictionary = @{}.mutableCopy;
    
    for (NSString *str in array) {
        NSArray *array = [str componentsSeparatedByString: @"="];
        if (array.count < 2) {
            continue;
        }
        NSString* key = [array[0] stringByRemovingPercentEncoding];
        NSString* value = [array[1] stringByRemovingPercentEncoding];
        dictionary[key] = value;
    }
    return dictionary;
}
#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
