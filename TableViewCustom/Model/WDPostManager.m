//
//  WDPostManager.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import "WDPostManager.h"
#import "WDPost.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

static WDPostManager *sharedManagerSingleton;

@implementation WDPostManager

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedManagerSingleton) {
            sharedManagerSingleton = [[WDPostManager alloc] init];
        }
    });
    return sharedManagerSingleton;
}

// todo: use plist to store default http headers
-(void)downloadPostsWithCompletion:(void(^)(NSArray *posts))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"299a7573-3f67-41ac-9cb9-d46a2ae103f6" forHTTPHeaderField:@"JsonStub-User-Key"];
    [manager.requestSerializer setValue:@"7b5268ab-ef10-4023-aba7-84b81320e87c" forHTTPHeaderField:@"JsonStub-Project-Key"];
    [manager GET:@"http://jsonstub.com/quotes" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        NSMutableArray *posts = [NSMutableArray array];
        for (NSDictionary *postJSON in responseObject) {
            WDPost *post = [[WDPost alloc] initWithCelebrityAvatar:postJSON[@"celebrityAvatar"] quote:postJSON[@"quote"]];
            [posts addObject:post];
        }
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(posts);
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to pull list.");
    }];
    

    
}

@end
