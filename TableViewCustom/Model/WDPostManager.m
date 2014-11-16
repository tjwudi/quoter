//
//  WDPostManager.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import "WDPostManager.h"
#import "WDPost.h"

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
    NSURL *requestUrl = [NSURL URLWithString:@"http://jsonstub.com/quotes"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"299a7573-3f67-41ac-9cb9-d46a2ae103f6" forHTTPHeaderField:@"JsonStub-User-Key"];
    [request setValue:@"7b5268ab-ef10-4023-aba7-84b81320e87c" forHTTPHeaderField:@"JsonStub-Project-Key"];
    [request setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSArray *postsJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray *posts = [[NSMutableArray alloc] init];
            for (NSDictionary *postJSON in postsJSON) {
                WDPost *post = [[WDPost alloc] initWithCelebrityAvatar:postJSON[@"celebrityAvatar"] quote:postJSON[@"quote"]];
                [posts addObject:post];
            }
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(posts);
                });
            }
        }];
        [task resume];
    });
}

@end
