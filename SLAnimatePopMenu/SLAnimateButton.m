//
//  SLAnimateButton.m
//  SLAnimatePopMenu
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import "SLAnimateButton.h"

@implementation SLAnimateButton

/**
 *  自定义按钮的初始化方法
 *
 *  @param title 按钮文字
 *  @param image 按钮图片
 *  @param block 按钮的点击事件
 *
 */
+(id)initWithTitle:(NSString *)title image:(UIImage *)image selectedBlock:(SLAnimateMenuelectedBlock)block
{
    SLAnimateButton *button  = [SLAnimateButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    button.selectedBlock            = block;
    return button;
}

/**
 *  设置图像和文字的位置
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(0, 0, SLAnimateButtonImageHeight, SLAnimateButtonImageHeight);
    self.titleLabel.frame = CGRectMake(0, SLAnimateButtonImageHeight+5, SLAnimateButtonImageHeight, SLAnimateButtonTitleHeight);
}
@end
