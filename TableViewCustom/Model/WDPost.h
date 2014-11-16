//
//  WDPost.h
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface WDPost : NSObject
@property (nonatomic) NSString *celebrityAvatar;
@property (nonatomic) NSString *quote;

// designated initializer
-(instancetype)initWithCelebrityAvatar:(NSString*)celebrityAvatar quote:(NSString*)quote;
-(void) downloadCelebrityAvatarWithCompletion:(void(^)(UIImage *image))completion;
@end
