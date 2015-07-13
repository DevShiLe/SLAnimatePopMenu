//
//  SLAnimateMenu.m
//  SLAnimatePopMenu
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import "SLAnimateMenu.h"
#import "SLAnimateButton.h"
#import <POP.h>

@interface SLAnimateMenu()
/**
 *  定义一个存放按钮的可变数组
 */
@property (nonatomic,strong)  NSMutableArray *buttons;

/**
 *  定义一个背景的蒙版
 */
@property (nonatomic,strong)  UIImageView *backgroundView;

@end

@implementation SLAnimateMenu
/**
 *  存放按钮的可变数组的懒加载
 *
 */
-(NSMutableArray *)buttons
{
    if (!_buttons) {
        self.buttons=[[NSMutableArray alloc]init];
    }
    return _buttons;
}

/**
 *  背景的蒙版的懒加载
 */
-(UIImageView *)backgroundView
{
    if (!_backgroundView) {
        self.backgroundView=[[UIImageView alloc]init];
    }
    return _backgroundView;
}

/**
 *  按钮的具体的显示，通过计算算出了按钮的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (NSUInteger i = 0; i < self.buttons.count; i++) {
        SLAnimateButton *button = self.buttons[i];
        button.frame = [self frameForButtonAtIndex:i];
    }
    
}

/**
 *  SLAnimateMenu的初始化
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundView.backgroundColor = SLColor(231, 231, 231, 0.8);
        //背景的宽高自动伸缩
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:self.backgroundView];
        self.buttons = [[NSMutableArray alloc] initWithCapacity:6];
    }
    return self;
}

/**
 *  SLAnimateMenu菜单添加Button的方法
 *
 *  @param title 文字
 *  @param image 图片
 *  @param block 点击事件
 */
- (void)addAnimateItemWithTitle:(NSString*)title image:(UIImage*)image selectedBlock:(SLAnimateMenuelectedBlock)block
{
    SLAnimateButton *button = [SLAnimateButton initWithTitle:title image:image selectedBlock:block];
    [button addTarget:self action:@selector(buttonclick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [self.buttons addObject:button];
}

/**
 *  SLAnimateMenu显示
 */
-(void)show
{
    UIViewController *appRootViewController;
    UIWindow *window;
    window = [UIApplication sharedApplication].keyWindow;
    appRootViewController = window.rootViewController;
    UIViewController *topViewController = appRootViewController;
    while (topViewController.presentedViewController != nil)
    {
        topViewController = topViewController.presentedViewController;
    }
    if ([topViewController.view viewWithTag:SLAnimatemenuViewTag]) {
        [[topViewController.view viewWithTag:SLAnimatemenuViewTag] removeFromSuperview];
    }
    self.frame = topViewController.view.bounds;
    [topViewController.view addSubview:self];
    [self displayAnimation];
}

/**
 *  根据按钮的索引算出按钮的frame
 *
 *  @param index 按钮的索引
 *
 *  @return frame
 */
- (CGRect)frameForButtonAtIndex:(NSUInteger)index
{
    NSUInteger columnCount = SLAnimateMenuPercolumnCount;
    NSUInteger columnIndex =  index % columnCount;
    NSUInteger rowCount = self.buttons.count / columnCount + (self.buttons.count%columnCount>0?1:0);
    NSUInteger rowIndex = index / columnCount;
    CGFloat itemHeight = (SLAnimateButtonImageHeight + SLAnimateButtonTitleHeight) * rowCount + (rowCount > 1?(rowCount - 1) * SLAnimateButtonHorizontalMargin:0);
    CGFloat offsetY = (self.bounds.size.height - itemHeight) / 2.0;
    CGFloat verticalPadding = (self.bounds.size.width - SLAnimateButtonHorizontalMargin * 2 - SLAnimateButtonImageHeight * SLAnimateMenuPercolumnCount) / 2.0;
    CGFloat offsetX = SLAnimateButtonHorizontalMargin;
    offsetX += (SLAnimateButtonImageHeight+ verticalPadding) * columnIndex;
    offsetY += (SLAnimateButtonImageHeight + SLAnimateButtonTitleHeight + SLAnimateButtonVerticalPadding) * rowIndex;
    return CGRectMake(offsetX, offsetY, SLAnimateButtonImageHeight, (SLAnimateButtonImageHeight+SLAnimateButtonTitleHeight));
    
}

/**
 *  按钮显示时的动画
 */
- (void)displayAnimation
{
    for (NSUInteger index = 0; index < self.buttons.count; index++) {
        SLAnimateButton *button = self.buttons[index];
        CGRect toframe = [self frameForButtonAtIndex:index];
        CGRect fromframe = CGRectMake((self.frame.size.width-toframe.size.width)/2.0, self.frame.size.height, toframe.size.width, toframe.size.height);
        double delayInSeconds = index * SLAnimateMenuAnimationInterval;
        [self initailzerAnimationWithToPostion:toframe formPostion:fromframe atView:button beginTime:delayInSeconds];
        
    }

}

/**
 *  按钮消失时的动画
 */
- (void)dismissAnimation
{
    for (NSUInteger index = 0; index < self.buttons.count; index++) {
        SLAnimateButton *button = self.buttons[index];
        CGRect fromframe = [self frameForButtonAtIndex:index];
        CGRect toframe = CGRectMake((self.frame.size.width-fromframe.size.width)/2.0, self.frame.size.height, fromframe.size.width, fromframe.size.height);
        double delayInSeconds = index * SLAnimateMenuAnimationInterval;
        [self initailzerAnimationWithToPostion:toframe formPostion:fromframe atView:button beginTime:delayInSeconds];
        
    }
    
}

/**
 *  POP的动画方法
 *
 *  @param toRect    目标位置
 *  @param fromRect  起始位置
 *  @param view      动画的对象
 *  @param beginTime 动画的开始时间
 */
- (void)initailzerAnimationWithToPostion:(CGRect)toRect formPostion:(CGRect)fromRect atView:(UIView *)view beginTime:(CFTimeInterval)beginTime {
    POPSpringAnimation *springAnimation = [POPSpringAnimation animation];
    springAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewFrame];
    springAnimation.removedOnCompletion = YES;
    springAnimation.beginTime = beginTime + CACurrentMediaTime();
    CGFloat springBounciness = 10 - beginTime * 2;
    springAnimation.springBounciness = springBounciness;    // value between 0-20
    CGFloat springSpeed = 12 - beginTime * 2;
    springAnimation.springSpeed = springSpeed;     // value between 0-20
    springAnimation.toValue = [NSValue valueWithCGRect:toRect];
    springAnimation.fromValue = [NSValue valueWithCGRect:fromRect];
    [view pop_addAnimation:springAnimation forKey:@"POPSpringAnimationKey"];
}

/**
 *  按钮的消失方法
 */
- (void)dismiss:(id)sender
{
    [self dismissAnimation];
    double delayInSeconds = SLAnimateMenuAnimationTime  + SLAnimateMenuAnimationInterval * (self.buttons.count + 1);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self removeFromSuperview];
    });
}

/**
 *  按钮的点击事件
 *
 *  @param btn SLAnimateButton
 */
- (void)buttonclick:(SLAnimateButton*)btn
{
    [self dismiss:nil];
     btn.selectedBlock();
}
@end
