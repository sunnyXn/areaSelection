//
//  SBTableViewCell.h
//  GomeEShop
//
//  Created by Sunny on 16/7/19.
//  Copyright © 2016年 Gome. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kTagViewLine  (99807)
#define kTagViewGap   (99808)

/// 默认block 带返回值 ID 类型
typedef void (^SBCellBlock)(id t);
/// 默认block
typedef void(^SBTableViewCellBlock)(void);

/// tableviewcell 基类  所有cell 继承此类
@interface SBTableViewCell : UITableViewCell

@property (nonatomic , copy , readonly) SBCellBlock cellBlockT;
@property (nonatomic , copy , readonly) SBTableViewCellBlock cellBlock;

@property (nonatomic , strong) UIButton * cellActionButton;

/// cell 基类 子类重写 getCellHeight  默认背景色 白色 默认高度0
+ (CGFloat)getCellHeightModel:(id)model;
+ (CGFloat)getCellHeightModel:(id)model Type:(int)type;
+ (CGFloat)getCellHeight:(NSDictionary *)dic;
+ (CGFloat)getCellHeight:(NSDictionary *)dic Type:(int)type;

- (void)setupCell:(NSDictionary *)dic;
- (void)setupCell:(NSDictionary *)dic hei:(CGFloat)cellH;

- (void)setupCellModel:(id)model;
- (void)setupCellModel:(id)model hei:(CGFloat)cellH;

// 是否显示灰色间隔线；
- (void)showViewline:(BOOL)isShow hei:(CGFloat)cellH;
// 是否显示灰色间隔区间
- (void)showViewGapSpace:(BOOL)isShow hei:(CGFloat)cellH;
// 移除所有subviews
- (void)removeSubViews;

- (void)setBlockT:(SBCellBlock)blockT;
- (void)setTableViewCellBlock:(SBTableViewCellBlock)cellBlock;

- (void)stopTimer;

- (void)setCellType:(int)type;

@end
