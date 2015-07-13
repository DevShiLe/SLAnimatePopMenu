//
//  SLAnimateButton.h
//  SLAnimatePopMenu
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAnimateButton : UIButton
/**
 *  自定义按钮的初始化方法
 *
 *  @param title 按钮文字
 *  @param image 按钮图片
 *  @param block 按钮的点击事件
 *
 */
+ (id)initWithTitle:(NSString*)title image:(UIImage*)image selectedBlock:(SLAnimateMenuelectedBlock)block;

/**
 *  定义一个按钮的选中block
 */
@property(nonatomic,copy)SLAnimateMenuelectedBlock selectedBlock;

@end
