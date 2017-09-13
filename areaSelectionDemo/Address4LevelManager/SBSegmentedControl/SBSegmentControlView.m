//
//  SBSegmentControlView.m
//  Sunny
//
//  Created by Sunny on 2017/7/28.
//  Copyright © 2017年 Sunny All rights reserved.
//

#import "SBSegmentControlView.h"

#define GMK_GMSegmentedControl_Tag (2017072800)

@interface SBSegmentControlView ()

@property (nonatomic , assign) NSInteger curIndex; // 当前选中的位置

@property (nonatomic , strong) UIView * vLine; // 底部滑条

@end


@implementation SBSegmentControlView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setArrTitles:(NSArray *)arrTitles
{
    if (GMK_Ary_Not_Valid(arrTitles))  return;
    
    GMK_Release(_arrTitles);  _arrTitles = arrTitles;
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [obj removeFromSuperview]; obj = nil;
     }];
    
    CGFloat btnWid = self.width/_arrTitles.count;
    
    // 添加按钮
    for (int i = 0; i < _arrTitles.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * btnWid, 0, btnWid, self.height);
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:_arrTitles[i] forState:UIControlStateNormal];
        [btn setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = self.font;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor = self.titleBackColor;
        btn.tag = GMK_GMSegmentedControl_Tag + i;
        
        [self addSubview:btn];
    }
    
    {
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - kScreenOneScale, self.width, kScreenOneScale)];
        v.backgroundColor = RGBAllColor(0xe6e6e6);
        [self addSubview:v];
        [self addSubview:self.vLine];
    }
}

- (UIColor *)titleNormalColor
{
    if (!_titleNormalColor)
    {
        _titleNormalColor = GMK_Color_333333;
    }
    return _titleNormalColor;
}


- (UIColor *)titleSelectedColor
{
    if (!_titleSelectedColor)
    {
        _titleSelectedColor = GMK_Color_Red_BiaoZhun;
        
    }
    return _titleSelectedColor;
}

- (UIColor *)titleBackColor
{
    if (!_titleBackColor)
    {
        _titleBackColor = GMK_Color_Main_BG_White;
        
    }
    return _titleBackColor;
}

- (UIFont *)font
{
    if (!_font)
    {
        _font = FONT_QuanJiao(15);
    }
    return _font;
}

- (UIView *)vLine
{
    CGFloat vH = 1.0;
    if (!_vLine)
    {
        _vLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - vH, self.width/self.arrTitles.count, vH)];
        _vLine.backgroundColor = self.titleSelectedColor;
    }
    return _vLine;
}


//选中某个按钮
- (void)selectBtnAtIndex:(NSInteger)index
{
    _curIndex = index;
    for (int i = 0; i < self.arrTitles.count; i++)
    {
        UIButton *btn = (UIButton *)[self viewWithTag:GMK_GMSegmentedControl_Tag + i];
        btn.selected = (i == index);
    }
    
    if (self.HasAnimation)
    {
        [UIView animateWithDuration:0.3f animations:^{
            self.vLine.originX = index *self.width/self.arrTitles.count;
        } completion:^(BOOL finished) {
            
        }];
    }
    else self.vLine.originX = index * self.width / self.arrTitles.count;
}

/// 按钮点击事件
- (void)btnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSInteger intIndex = btn.tag - GMK_GMSegmentedControl_Tag;
    
    if (intIndex < 0 || intIndex >= self.arrTitles.count || intIndex == _curIndex || GMK_Str_Not_Valid(btn.titleLabel.text))  return;
    
    [self selectBtnAtIndex:intIndex];
    
    
    if ([self.delegate respondsToSelector:@selector(segmentControl:didSelectAtIndex:)])
    {
        WEAKSELF
        [self.delegate segmentControl:weakSelf didSelectAtIndex:_curIndex];
    }
}

/// 当前选中位置
- (NSInteger)indexSelect
{
    return _curIndex;
}

@end
