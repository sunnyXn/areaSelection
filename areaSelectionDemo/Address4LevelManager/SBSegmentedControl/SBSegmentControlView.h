//
//  SBSegmentControlView.h
//  Sunny
//
//  Created by Sunny on 2017/7/28.
//  Copyright © 2017年 Sunny All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBSegmentControlDelegate;


@interface SBSegmentControlView : UIView

@property (nonatomic , weak) id<SBSegmentControlDelegate> delegate;

/// 标题数组
@property (nonatomic , strong) NSArray * arrTitles;
/// 设置不同状态下标题颜色 默认正常GMK_Color_333333，选中红色
@property (nonatomic , strong) UIColor * titleNormalColor;
/// 默认选中颜色  默认 红色
@property (nonatomic , strong) UIColor * titleSelectedColor;
/// 按钮背景颜色 默认 白色
@property (nonatomic , strong) UIColor * titleBackColor;

@property (nonatomic , strong) UIFont  * font;

/// 是否包含动画
@property (nonatomic , assign) BOOL HasAnimation;

/// 选中位置
- (void)selectBtnAtIndex:(NSInteger)index;
/// 当前选中位置
- (NSInteger)indexSelect;

@end


@protocol SBSegmentControlDelegate <NSObject>

@required

- (void)segmentControl:(SBSegmentControlView *)seg didSelectAtIndex:(NSInteger)index;

@end
