//
//  SLAnimateMenu.h
//  SLAnimatePopMenu
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLAnimateMenu : UIView

/**
 *  SLAnimateMenu菜单添加Button的方法
 *
 *  @param title 文字
 *  @param image 图片
 *  @param block 点击事件
 */
- (void)addAnimateItemWithTitle:(NSString*)title image:(UIImage*)image selectedBlock:(SLAnimateMenuelectedBlock)block;

/**
 *  SLAnimateMenu显示
 */
- (void)show;

@end
