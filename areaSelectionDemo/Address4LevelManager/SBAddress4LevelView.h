//
//  SBAddress4LevelView.h
//  Sunny
//
//  Created by Sunny on 2017/8/11.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SBAddress4LevelModel.h"

typedef void(^GMK_Address4LevelBlock)(id t);

typedef NS_ENUM(NSInteger, GMK_Address4LevelType) {
    GMK_Address4LevelTypeDefault = 0,   // 默认四级区域全部展示
    GMK_Address4LevelTypeThree,         // 三级区域
    GMK_Address4LevelTypeTwo,           // 二级区域
};


/// 四级区域 view
@interface SBAddress4LevelView : UIView


@property (nonatomic , assign) GMK_Address4LevelType addressType;

@property (nonatomic , copy , readonly) GMK_Address4LevelBlock closeBlock;

- (void)setCloseBlock:(GMK_Address4LevelBlock)blockT;

- (void)showAddressWithModel:(SBAddress4LevelModel *)model;

@end
