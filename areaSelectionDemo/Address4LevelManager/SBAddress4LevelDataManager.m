//
//  SBAddress4LevelDataManager.m
//  Sunny
//
//  Created by Sunny on 2017/8/11.
//  Copyright © 2017年 Sunny. All rights reserved.
//

#import "SBAddress4LevelDataManager.h"
#import "FMDB.h"
#import "SBAddress4LevelModel.h"


#define GMK_AddressTableName_Province       @"Province"
#define GMK_AddressTableName_City           @"City"
#define GMK_AddressTableName_County         @"County"
#define GMK_AddressTableName_Street         @"Street"

#define GMK_AddressLineName_Id              @"id"
#define GMK_AddressLineName_Name            @"name"
#define GMK_AddressLineName_ProvinceId      @"province_id"
#define GMK_AddressLineName_CityId          @"city_id"
#define GMK_AddressLineName_CountyId        @"county_id"


@interface SBAddress4LevelDataManager ()

@property (nonatomic , strong) FMDatabaseQueue * dbQueue;

@property (nonatomic , strong) NSString * dbPath;

@end

@implementation SBAddress4LevelDataManager

DEF_SINGLETON(SBAddress4LevelDataManager);

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma  mark -  get LazyLoad
- (NSString *)dbPath
{
    if (!_dbPath)
    {
        _dbPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"db"];
        NSLog(@"dbPath : %@",_dbPath);
    }
    return _dbPath;
}

- (FMDatabaseQueue *)dbQueue
{
    if (!_dbQueue)
    {
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _dbQueue;
}


- (NSString *)queryTableSqlString:(NSString *)tableName
{
    return [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
}

- (NSString *)queryTableSqlString:(NSString *)tableName whereLine:(NSString *)strLine atId:(NSInteger)strId
{
    return [NSString stringWithFormat:@"%@ WHERE %@ = %ld",[self queryTableSqlString:tableName] , strLine, strId];
}


//查询
- (void)executeQuery:(NSString *)sql queryBlock:(void(^)(FMResultSet *set))queryBlock{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db setShouldCacheStatements:YES];
        FMResultSet *set = [db executeQuery:sql];
        if (queryBlock) {
            queryBlock(set);
            [set close];
        }
    }];
}

/// 获取省级地址list
- (NSArray *)queryProvinceList
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_Province] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelProvince * item = GMK_AllocObj(SBAddress4LevelModelProvince);
            item.aId    = [set intForColumn:GMK_AddressLineName_Id];
            item.aName  = [set stringForColumn:GMK_AddressLineName_Name];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取城市信息list
- (NSArray *)queryCityList
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_City] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelCity * item = GMK_AllocObj(SBAddress4LevelModelCity);
            item.aId    = [set intForColumn:GMK_AddressLineName_Id];
            item.aName  = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId = [set intForColumn:GMK_AddressLineName_ProvinceId];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取地区信息list
- (NSArray *)queryCountyList
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_County] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelCounty * item = GMK_AllocObj(SBAddress4LevelModelCounty);
            item.aId      = [set intForColumn:GMK_AddressLineName_Id];
            item.aName    = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId  = [set intForColumn:GMK_AddressLineName_CityId];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取街道信息list
- (NSArray *)queryStreetList
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_Street] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelStreet * item = GMK_AllocObj(SBAddress4LevelModelStreet);
            item.aId      = [set intForColumn:GMK_AddressLineName_Id];
            item.aName    = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId  = [set intForColumn:GMK_AddressLineName_CountyId];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取某一省级id下的所有市级地址list
- (NSArray *)queryCityListWithProvinceId:(NSInteger)provinceId
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_City whereLine:GMK_AddressLineName_ProvinceId atId:provinceId] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelCity * item = GMK_AllocObj(SBAddress4LevelModelCity);
            item.aId      = [set intForColumn:GMK_AddressLineName_Id];
            item.aName    = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId  = [set intForColumn:GMK_AddressLineName_ProvinceId];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取某一市级id下的所有区级地址list
- (NSArray *)queryCountyListWithCityId:(NSInteger)cityId
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_County whereLine:GMK_AddressLineName_CityId atId:cityId] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelCounty * item = GMK_AllocObj(SBAddress4LevelModelCounty);
            item.aId      = [set intForColumn:GMK_AddressLineName_Id];
            item.aName    = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId = [set intForColumn:GMK_AddressLineName_CityId];
            
            [list addObject:item];
        }
    }];
    return list;
}

/// 获取某一区级id下的所有街道地址list
- (NSArray *)queryStreetListWithCountyId:(NSInteger)countyId
{
    __block NSMutableArray *list = [NSMutableArray array];
    [self executeQuery:[self queryTableSqlString:GMK_AddressTableName_Street whereLine:GMK_AddressLineName_CountyId atId:countyId] queryBlock:^(FMResultSet *set) {
        while ([set next])
        {
            SBAddress4LevelModelStreet * item = GMK_AllocObj(SBAddress4LevelModelStreet);
            item.aId      = [set intForColumn:GMK_AddressLineName_Id];
            item.aName    = [set stringForColumn:GMK_AddressLineName_Name];
            item.afromId = [set intForColumn:GMK_AddressLineName_CountyId];
            
            [list addObject:item];
        }
    }];
    return list;
}

- (NSArray *)queryAddressListWithFromId:(NSInteger)aId level:(NSInteger)aLevel
{
    NSArray * arrList = nil;
    switch (aLevel)
    {
        case 0:
            arrList = [self queryCityListWithProvinceId:aId];
            break;
        case 1:
            arrList = [self queryCountyListWithCityId:aId];
            break;
        case 2:
            arrList = [self queryStreetListWithCountyId:aId];
            break;
        default:
            break;
    }
    return arrList;
}


@end
