//
//  SBTableViewCell.m
//  GomeEShop
//
//  Created by Sunny on 16/7/19.
//  Copyright © 2016年 Gome. All rights reserved.
//

#import "SBTableViewCell.h"

@interface SBTableViewCell ()

@end

@implementation SBTableViewCell

+ (CGFloat)getCellHeight:(NSDictionary *)dic
{
    return [[self class] getCellHeight:dic Type:0];
}

+ (CGFloat)getCellHeight:(NSDictionary *)dic Type:(int)type
{
    return 0;
}

+ (CGFloat)getCellHeightModel:(id)model
{
    return [[self class] getCellHeightModel:model Type:0];
}

+ (CGFloat)getCellHeightModel:(id)model Type:(int)type
{
    return 0;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        /// MARK: ios7以下用contentview.backgroundColor才生效
        self.backgroundColor = GMK_Color_Main_BG_White;
        self.contentView.backgroundColor = GMK_Color_Main_BG_White;
    }
    return self;
}

- (void)setBlockT:(SBCellBlock)blockT
{
    _cellBlockT = nil;
    _cellBlockT = blockT;
}

- (void)setTableViewCellBlock:(SBTableViewCellBlock)cellBlock
{
    _cellBlock = nil;  _cellBlock = cellBlock;
}

- (void)setupCell:(NSDictionary *)dic
{
    [self setupCell:dic hei:[[self class] getCellHeight:dic]];
}

- (void)setupCell:(NSDictionary *)dic hei:(CGFloat)cellH
{
    if (GMK_Dic_Not_Valid(dic) || cellH == 0)
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
}

- (void)setupCellModel:(id)model
{
    [self setupCellModel:model hei:[[self class] getCellHeight:model]];
}

- (void)setupCellModel:(id)model hei:(CGFloat)cellH
{
    if (!model || cellH == 0)
    {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        return;
    }
}

#pragma  mark - view

- (void)removeSubViews
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)showViewline:(BOOL)isShow hei:(CGFloat)cellH
{
    UIView * viewLine = [self.contentView viewWithTag:kTagViewLine];
    if (!isShow && !viewLine) return;
    
    if (!viewLine)
    {
        CGFloat huiH = 1.0/[UIScreen mainScreen].scale;
        viewLine = [[UIView alloc] initWithFrame:CGRectMake( CELL_START_X , cellH - huiH, screenW - 10, huiH)];
        viewLine.backgroundColor = RGBAllColor(0xe6e6e6);
        viewLine.tag = kTagViewLine;
        [self.contentView addSubview:viewLine];
    }
    viewLine.hidden = !isShow;
}

- (void)showViewGapSpace:(BOOL)isShow hei:(CGFloat)cellH
{
    UIView * viewGap = [self.contentView viewWithTag:kTagViewGap];
    if (!isShow && !viewGap) return;
    
    if (!viewGap)
    {
        CGFloat huiH = 10;
        viewGap = [[UIView alloc] initWithFrame:CGRectMake( 0 , cellH - huiH, screenW, huiH)];
        viewGap.backgroundColor = GMK_Color_Main_BG;
        viewGap.tag = kTagViewGap;
        [self.contentView addSubview:viewGap];
    }
    viewGap.hidden = !isShow;
}

- (void)stopTimer
{
    
}

- (void)setCellType:(int)type
{
    
}

@end
