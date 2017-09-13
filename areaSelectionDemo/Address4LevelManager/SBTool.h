//
//  SBTool.h
//  areaSelectionDemo
//
//  Created by 中海智融 on 2017/9/6.
//  Copyright © 2017年 sunny. All rights reserved.
//

#ifndef SBTool_h
#define SBTool_h


#import "UIView+FrameExtension.h"


#define CELL_DEFAULT_HEIGHT (45)
// CELL的ROW的文字起始位置
#define CELL_START_X (15.f)



/// 通过RGBA设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC, 0.5);
#define RGBAAllColor(rgb, a) [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0  \
green:((float)((rgb & 0xFF00) >> 8))/255.0     \
blue:((float)(rgb & 0xFF))/255.0              \
alpha:(a)/1.0]

/// 通过RGB设置颜色，使用0x格式，如：RGBAAllColor(0xAABBCC);
#define RGBAllColor(rgb) RGBAAllColor(rgb, 1.0)




#if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON

#undef	AS_SINGLETON
#define AS_SINGLETON( ... ) \
- (instancetype)sharedInstance; \
+ (instancetype)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#undef	DEF_SINGLETON
#define DEF_SINGLETON( ... ) \
- (instancetype)sharedInstance \
{ \
return [[self class] sharedInstance]; \
} \
+ (instancetype)sharedInstance \
{ \
static dispatch_once_t once; \
static id __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
return __singleton__; \
}

#else	// #if __has_feature(objc_instancetype)

#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
- (__class *)sharedInstance; \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
- (__class *)sharedInstance \
{ \
return [__class sharedInstance]; \
} \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
return __singleton__; \
}

#endif	// #if __has_feature(objc_instancetype)


// 判断obj是否为className类型
#define GMK_Object_Is_Class(obj,className) [obj isKindOfClass:[className class]]

/// 是否为NSString类型（单独处理NSMutableString）
#define GMK_Str_Class(str) [str isKindOfClass:[NSString class]]
#define GMK_mStr_Class(mstr) [mstr isKindOfClass:[NSMutableString class]]

/// 是否有效，不为空，且是NSString类型，且count值大于0（单独处理NSMutableString）
#define GMK_Str_Is_Valid(str) ((str) && (GMK_Str_Class(str)) && ([str length] > 0))
#define GMK_mStr_Is_Valid(mstr) ((mstr) && (GMK_mStr_Class(mstr)) && ([mstr length] > 0))

/// 是否无效，或为空，或不是NSString类型，或count值小于等于0（单独处理NSMutableString）
#define GMK_Str_Not_Valid(str) ((!str) || (!GMK_Str_Class(str)) || ([str length] <= 0))
#define GMK_mStr_Not_Valid(mstr) ((!mstr) || (!GMK_mStr_Class(mstr)) || ([mstr length] <= 0))

/// 格式化字符串
#define GMK_Str_Format(...) [NSString stringWithFormat:__VA_ARGS__]

/// nil保护，当为nil时，返回@""，避免一些Crash
#define GMK_Str_Protect(str) ((str) && (![str isKindOfClass:[NSNull class]]) ? (str) : (@""))



/// 是否NSArray类型（单独处理NSMutableArray）
#define GMK_Ary_Class(ary)   GMK_Object_Is_Class(ary, NSArray)
#define GMK_mAry_Class(mary) GMK_Object_Is_Class(mary,NSMutableArray)

/// 是否有效，不为空，且是NSArray类型，且count值大于0（单独处理NSMutableArray）
#define GMK_Ary_Is_Valid(ary) ((ary) && (GMK_Ary_Class(ary)) && ([ary count] > 0))
#define GMK_mAry_Is_Valid(mary) ((mary) && (GMK_mAry_Class(mary)) && ([mary count] > 0))

/// 是否无效，或为空，或不是NSArray类型，或count值小于等于0（单独处理NSMutableArray）
#define GMK_Ary_Not_Valid(ary) ((!ary) || (!GMK_Ary_Class(ary)) || ([ary count] <= 0))
#define GMK_mAry_Not_Valid(mary) ((!mary) || !(GMK_mAry_Class(mary)) || ([mary count] <= 0))

/// 是否NSDictionary类型（单独处理NSMutableDictionary）
#define GMK_Dic_Class(dic) [dic isKindOfClass:[NSDictionary class]]
#define GMK_mDic_Class(mdic) [mdic isKindOfClass:[NSMutableDictionary class]]

/// 是否有效，不为空，且是NSDictionary类型，且count值大于0（单独处理NSMutableDictionary）
#define GMK_Dic_Is_Valid(dic) ((dic) && (GMK_Dic_Class(dic)) && ([dic count] > 0))
#define GMK_mDic_Is_Valid(mdic) ((mdic) && (GMK_mDic_Class(mdic)) && (mdic.count > 0))

/// 是否无效，或为空，或不是NSDictionary类型，或count值小于等于0（单独处理NSMutableDictionary）
#define GMK_Dic_Not_Valid(dic) ((!dic) || (!GMK_Dic_Class(dic)) || ([dic count] <= 0))
#define GMK_mDic_Not_Valid(mdic) ((!mdic) || (!GMK_mDic_Class(mdic)) || (mdic.count <= 0))


#define GMK_AllocObj(cls)   [[cls alloc] init]

// releaseObj
#define GMK_Release(obj)          if(obj) { obj = nil;}
#define GMK_Release_View(v)       if(v) {[v removeFromSuperview]; v = nil;}


/** Weak--Strong**/
#define WeakSelf(weakSelf)                __weak __typeof(&*self)weakSelf = self;
#define WEAKSELF   WeakSelf(weakSelf)
//  weak--Obj
#define GMK_Weak_Obj(obj)         __weak typeof(obj) weak##obj = obj;

// instanceObj
#define GMK_Instance(obj , cls)   if(!obj) obj = [cls new];
#define GMK_Instance_GetObj(_obj , cls)  {GMK_Instance(_obj,cls); return _obj;}
#define GMK_Instance_Cell(cls ,identi) [[cls alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identi];


#define GMK_Color_Main_BG_White [UIColor whiteColor]
/// 主要背景色，所有页面，包括空页面，背景颜色
#define GMK_Color_Main_BG RGBAllColor(0xF2F2F2)

#define GMK_Color_Red_BiaoZhun RGBAllColor(0xff5c5c)
#define GMK_Color_333333 RGBAllColor(0x333333)
#define GMK_Color_666666 RGBAllColor(0x666666)
#define GMK_Color_999999 RGBAllColor(0x999999)


#define FONT_QuanJiao(fontSize) [UIFont systemFontOfSize:(fontSize)]

#define IMG_Name(name) [UIImage imageNamed:name]


#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#define kScreenOneScale (1.0 / [UIScreen mainScreen].scale)

#define kScreenWidth screenW
#define kScreenHeight screenH

// X、Y最大值
#define kMaxX(frame)  CGRectGetMaxX(frame)
#define kMaxY(frame)  CGRectGetMaxY(frame)


#define GMK_StringFromClass(cls)  NSStringFromClass([cls class])


#endif /* SBTool_h */
