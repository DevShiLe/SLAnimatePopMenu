//
//  SLHomeViewController.m
//  SLAnimatePopMenu
//
//  Created by Kevin on 15/7/12.
//  Copyright (c) 2015年 石乐. All rights reserved.
//

#import "SLHomeViewController.h"
#import "SLAnimateMenu.h"

@interface SLHomeViewController ()

@end

@implementation SLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    self.view.backgroundColor=[UIColor whiteColor];
    //设置按钮类型
    UIButton *secondButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置和大小
    CGRect sframe = CGRectMake(50, 300, 200, 50);
    //将frame的位置大小复制给Button
    secondButton.frame = sframe;
    //给Button添加标题
    [secondButton setTitle:@"动画" forState:UIControlStateNormal];
    ////设置按钮颜色
    [secondButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //添加点击事件
    [secondButton addTarget:self action:@selector(showMenu)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:secondButton];
}

//添加菜单
- (void)showMenu
{
    
    //创建一个SLAnimateMenu，并且添加按钮到该View上面
    
    SLAnimateMenu *animatemenu = [[SLAnimateMenu alloc] init];
    [animatemenu addAnimateItemWithTitle:@"Idea" image:[UIImage imageNamed:@"tabbar_compose_idea"] selectedBlock:^{
        NSLog(@"Idea selected");
    }];
    [animatemenu addAnimateItemWithTitle:@"LBS" image:[UIImage imageNamed:@"tabbar_compose_lbs"] selectedBlock:^{
         NSLog(@"LBS selected");
    }];
    [animatemenu addAnimateItemWithTitle:@"Music" image:[UIImage imageNamed:@"tabbar_compose_music"] selectedBlock:^{
         NSLog(@"Music selected");
    }];
    [animatemenu addAnimateItemWithTitle:@"Photo" image:[UIImage imageNamed:@"tabbar_compose_photo"] selectedBlock:^{
         NSLog(@"Photo selected");
    }];
    [animatemenu addAnimateItemWithTitle:@"Shooting" image:[UIImage imageNamed:@"tabbar_compose_shooting"] selectedBlock:^{
        NSLog(@"Shooting selected");
    }];
    [animatemenu addAnimateItemWithTitle:@"Review" image:[UIImage imageNamed:@"tabbar_compose_review"] selectedBlock:^{
        NSLog(@"Review selected");
    }];
    
    //SLAnimateMenu显示
    [animatemenu show];
}
@end
