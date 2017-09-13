//
//  SBAddress4LevelModel.h
//  Sunny
//
//  Created by Sunny on 2017/8/15.
//  Copyright © 2017年 Sunny. All rights reserved.
//
#import <Foundation/Foundation.h>

@class SBAddress4LevelModelProvince;
@class SBAddress4LevelModelCity;
@class SBAddress4LevelModelCounty;
@class SBAddress4LevelModelStreet;

/// 四级地址 model
@interface SBAddress4LevelModel : NSObject

@property (nonatomic , strong) SBAddress4LevelModelProvince * modelProvince;
@property (nonatomic , strong) SBAddress4LevelModelCity     * modelCity;
@property (nonatomic , strong) SBAddress4LevelModelCounty   * modelCounty;
@property (nonatomic , strong) SBAddress4LevelModelStreet   * modelStreet;


@property (nonatomic , strong) NSString * aName;
@property (nonatomic , assign) NSInteger  aId;

@property (nonatomic , assign) NSInteger  afromId;

@property (nonatomic , assign) BOOL isSelected;

@end


/// 省级model
@interface SBAddress4LevelModelProvince : SBAddress4LevelModel

///// 省id
//@property (nonatomic , assign) NSInteger    provinceId;
///// 省名
//@property (nonatomic , strong) NSString *   strProvinceName;

@end


/// 市级model
@interface SBAddress4LevelModelCity : SBAddress4LevelModel

///// 市id
//@property (nonatomic , assign) NSInteger    cityId;
///// 市名
//@property (nonatomic , strong) NSString *   strCityName;
/// 城市所在省级id
//@property (nonatomic , assign) NSInteger    cityAtProvinceId;

@end


/// 区级model
@interface SBAddress4LevelModelCounty : SBAddress4LevelModel

///// 区id
//@property (nonatomic , assign) NSInteger    countyId;
///// 区名
//@property (nonatomic , strong) NSString *   strCountyName;
/// 地区所在城市级id
//@property (nonatomic , assign) NSInteger    countyAtCityId;

@end


/// 街道model
@interface SBAddress4LevelModelStreet : SBAddress4LevelModel

///// 街道id
//@property (nonatomic , assign) NSInteger    streetId;
///// 街道名
//@property (nonatomic , strong) NSString *   strStreetName;
/// 街道所在城地区id
//@property (nonatomic , assign) NSInteger    streetAtCountyId;

@end

