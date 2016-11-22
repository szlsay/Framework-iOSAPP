//
//  SonSDK.h
//  Son
//
//  Created by ST on 16/11/22.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SonSDK : NSObject
+ (instancetype)sharedInstance;
- (BOOL)openURL:(NSURL*)url;
@end
