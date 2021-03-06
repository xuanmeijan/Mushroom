//
//  BaseViewController.h
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/13.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewModel.h"

@interface BaseViewController : UIViewController

/// BaseVC的基础ViewModel
@property (nonatomic, strong, readonly) BaseViewModel *viewModel;

/**
 唯一初始化方法
 
 @param viewModel 传入ViewModel
 @return 实例化控制器对象
 */
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel;


- (void)initView;
- (void)initData;
- (void)initBinding;

- (void)back;
@end
