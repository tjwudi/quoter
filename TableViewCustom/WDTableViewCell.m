//
//  WDTableViewCell.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import "WDTableViewCell.h"
#import "WDPost.h"

@interface WDTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *celebrityAvatar;
@end

@implementation WDTableViewCell

# pragma mark - Initializer
- (void)awakeFromNib {
    // Initialization code
    
}


# pragma mark getter & setter
-(void)setPost:(WDPost *)post {
    _post = post;
    [self setupView];
}

# pragma view
-(void)setupView {
    self.quoteLabel.text = self.post.quote;
    [self.post downloadCelebrityAvatarWithCompletion:^(UIImage *image){
        self.celebrityAvatar.image = image;
    }];
}


@end
