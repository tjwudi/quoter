//
//  WDCardView.m
//  TableViewCustom
//
//  Created by Wu Di on 11/16/14.
//  Copyright (c) 2014 Alibaba Group. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "WDCardView.h"

@interface WDCardView()
@property (nonatomic) IBInspectable NSInteger lineWidth;
@property (nonatomic) IBInspectable CGFloat borderRadius;
@end

@implementation WDCardView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

-(void)awakeFromNib {
    
}

- (void)drawRect:(CGRect)rect {

    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect myFrame = self.bounds;
    CGContextSetLineWidth(context, _lineWidth);
    [[UIColor redColor] set];
    UIRectFrame(myFrame);
}


#pragma mark - setter

-(void)setBorderRadius:(CGFloat)borderRadius {
    _borderRadius = borderRadius;
    [self setupView];
}


#pragma mark - view
-(void)setupView {
    self.layer.cornerRadius = self.borderRadius;
    [self setNeedsDisplay];
}

@end
