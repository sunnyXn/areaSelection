//
//  SBAddress4LevelDataManager.h
//  Sunny
//
//  Created by Sunny on 2017/8/11.
//  Copyright © 2017年 Sunny All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBAddress4LevelDataManager : NSObject

/// 四级地址  数据管理类
AS_SINGLETON(SBAddress4LevelDataManager);

/// 获取省级地址list
- (NSArray *)queryProvinceList;
/// 获取城市信息list
- (NSArray *)queryCityList;
/// 获取地区信息list
- (NSArray *)queryCountyList;
/// 获取街道信息list
- (NSArray *)queryStreetList;

/// 获取某一级下的 对应id的所属地址
- (NSArray *)queryAddressListWithFromId:(NSInteger)aId level:(NSInteger)aLevel;

/// 获取某一省级id下的所有市级地址list
- (NSArray *)queryCityListWithProvinceId:(NSInteger)provinceId;

/// 获取某一市级id下的所有区级地址list
- (NSArray *)queryCountyListWithCityId:(NSInteger)cityId;

/// 获取某一区级id下的所有街道地址list
- (NSArray *)queryStreetListWithCountyId:(NSInteger)countyId;

@end
