
//
//  SBAddress4LevelTableViewCell.m
//  Sunny
//
//  Created by Sunny on 2017/8/16.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import "SBAddress4LevelTableViewCell.h"
#import "SBAddress4LevelModel.h"

@implementation SBAddress4LevelTableViewCell

- (void)setupCellModel:(id)model hei:(CGFloat)cellH
{
    if (!model || ![model isKindOfClass:[SBAddress4LevelModel class]] || cellH <= 0)  return;
    
    self.textLabel.text = [model aName];
    self.textLabel.textColor = [model isSelected] ? GMK_Color_Red_BiaoZhun : GMK_Color_333333;
    
    [self showViewline:YES hei:cellH];
}

@end
