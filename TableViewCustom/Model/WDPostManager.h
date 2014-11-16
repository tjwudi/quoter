//
//  WDPostManager.h
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDPostManager : NSObject

+(instancetype) sharedManager;
-(void)downloadPostsWithCompletion:(void(^)(NSArray *posts))completion;

@end
