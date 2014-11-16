//
//  WDPost.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WDPost.h"

@implementation WDPost

#pragma mark Initializers
-(instancetype)initWithCelebrityAvatar:(NSString *)celebrityAvatar quote:(NSString *)quote {
    self = [super init];
    if (self) {
        self.celebrityAvatar = celebrityAvatar;
        self.quote = quote;
    }
    return self;
}

#pragma Avatar
-(void) downloadCelebrityAvatarWithCompletion:(void(^)(UIImage*))completion {
    if (completion == nil) {
        return;
    }
    
    NSURL *url = [NSURL URLWithString:self.celebrityAvatar];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
            NSLog(@"%@", error);
            NSData *data = [NSData dataWithContentsOfURL:location];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        }];
        [task resume];
    });
    
}


@end
