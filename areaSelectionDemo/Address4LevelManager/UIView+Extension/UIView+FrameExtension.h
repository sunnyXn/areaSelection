//
//  UIView+FrameExtension.h
//  GMBase
//
//  Created by Sunny on 17/7/6.
//  Copyright (c) 2017年 Sunny. All rights reserved.
//

#import <UIKit/UIKit.h>


static inline CGRect CGRectAddX(CGRect rect,CGFloat x)
{
    rect.origin.x=rect.origin.x+x;
    return rect;
}

static inline CGRect CGRectAddY(CGRect rect,CGFloat y)
{
    rect.origin.y=rect.origin.y+y;
    return rect;
}

static inline CGRect CGRectAddWidth(CGRect rect,CGFloat width)
{
    rect.size.width=rect.size.width+width;
    return rect;
}

static inline CGRect CGRectAddHeight(CGRect rect,CGFloat height)
{
    rect.size.height=rect.size.height+height;
    return rect;
}

static inline CGRect CGRectMakePlus(float x4,float x5,float y4,float y5,float width4,float width5,float height4,float height5)
{
    if ([UIScreen mainScreen].bounds.size.height>480) {
        return CGRectMake(x5, y5, width5, height5);
    }else{
        return CGRectMake(x4, y4, width4, height4);
    }
}

static inline CGRect CGRectMakePlusH(float x,float y,float width,float height4,float height5)
{
    return CGRectMakePlus(x, x, y, y, width, width, height4, height5);
}

static inline CGRect CGRectMakePlusW(float x,float y,float width4,float width5,float height)
{
    return CGRectMakePlus(x, x, y, y, width4, width5, height, height);
}

static inline CGRect CGRectMakePlusX(float x4,float x5,float y,float width,float height)
{
    return CGRectMakePlus(x4, x5, y, y, width, width, height, height);
}

static inline CGRect CGRectMakePlusY(float x,float y4,float y5,float width,float height)
{
    return CGRectMakePlus(x,x , y4, y5, width, width, height, height);
}

static inline CGRect CGRectMakePlusOrigin(float x4,float x5,float y4,float y5,float width,float height)
{
    return CGRectMakePlus(x4, x5, y4, y5, width, width, height, height);
}

static inline CGRect CGRectMakePlusSize(float x,float y,float width4,float width5,float height4,float height5)
{
    return CGRectMakePlus(x, x, y, y, width4, width5, height4, height5);
}

/**
 获取一个CGRect中指定大小的CGSize时候Center时所处的位置
 
 @param rect 要计算的原始大小
 @param size 要占位的大小
 */
static inline CGRect CGRectCenter(CGRect rect,CGSize size)
{
    return CGRectMake((rect.size.width-size.width)/2, (rect.size.height-size.height)/2, size.width, size.height);
}


@interface UIView (FrameExtension)


-(CGFloat)height;
-(void)setHeight:(CGFloat)height;
-(void)setHeight:(CGFloat)height Animated:(BOOL)animate;
-(void)addHeight:(CGFloat)height;


-(CGFloat)width;
-(void)setWidth:(CGFloat)width;
-(void)setWidth:(CGFloat)width Animated:(BOOL)animate;
-(void)addWidth:(CGFloat)width;

-(CGFloat)originX;
-(void)setOriginX:(CGFloat)x ;
-(void)setOriginX:(CGFloat)x Animated:(BOOL)animate;
-(void)addOriginX:(CGFloat)x;

-(CGFloat)originY;
-(void)setOriginY:(CGFloat)y;
-(void)setOriginY:(CGFloat)y Animated:(BOOL)animate;
-(void)addOriginY:(CGFloat)y;

-(CGSize)size;
-(void)setSize:(CGSize)size;
-(void)setSize:(CGSize)size Animated:(BOOL)animate;

-(CGPoint)origin;
-(void)setOrigin:(CGPoint)point;
-(void)setOrigin:(CGPoint)point Animated:(BOOL)animate;

-(CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;

- (CGFloat)right;

- (CGFloat)bottom;
/**
 元素的右上角的点
 */
-(CGPoint)originTopRight;
/**
 元素的左下角的点
 */
-(CGPoint)originBottomLeft;
/**
 元素的右下角的点
 */
-(CGPoint)originBottomRight;


-(CGRect)rectForAddViewTop:(CGFloat)height;//返回在该view上面添加一个视图时的frame
-(CGRect)rectForAddViewTop:(CGFloat)height Offset:(CGFloat)offset;//返回在该view上面添加一个视图时的frame

-(CGRect)rectForAddViewBottom:(CGFloat)height;//返回在该view下面添加一个视图的时候的frame
-(CGRect)rectForAddViewBottom:(CGFloat)height Offset:(CGFloat)offset;//返回在该view下面添加一个视图的时候的frame
-(CGRect)rectForAddViewLeft:(CGFloat)width;//返回在该view左边添加一个视图的时候的frame
-(CGRect)rectForAddViewLeft:(CGFloat)width Offset:(CGFloat)offset;//返回在该view左边添加一个视图的时候的frame
-(CGRect)rectForAddViewRight:(CGFloat)width;//返回在该view右边添加一个视图的时候的frame
-(CGRect)rectForAddViewRight:(CGFloat)width Offset:(CGFloat)offset;//返回在该view右边添加一个视图的时候的frame

-(CGRect)rectForCenterofSize:(CGSize)size;//居中一个size


/// 设置圆角和边框的大小、颜色
- (void)setCornerRadius:(CGFloat)fltCornerRadius
            borderWidth:(CGFloat)fltBorderWidth
            borderColor:(UIColor *)colorBorder;

/**
 同viewWithTag:(int)tag
 
 此函数返回id类型，以不用强制转换类型
 */
-(id)viewWithTag2:(int)tag;

/*
 返回该类中所有指定类型的subview
 */
-(NSArray*)subviewsWithClass:(Class )cls;

#pragma mark -
- (void)roundWithCornerRadius:(CGFloat)radius;
- (void)roundToCircle;


+ (CGFloat)scaleAdaptWidth:(CGFloat)fltWidth;


@end

#pragma mark
#pragma mark 迁移GMBMacro_UiView_h中方法,因使用不多，故放在下边

//   带返回的uiview
/*
 作用 新建UIImageView
 参数：
 imageview ：返回的imageview
 x,y,width,height  位置宽高
 fatherview  父视图
 imagename  图片名字不带.png
 */

#define NEWIMAGEVIEW(imageview,x,y,width,height,fatherview,imagename)      [[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.image = IMG_File_Png(imagename);\
[fatherview addSubview:imageview];




/*
 作用 新建UIImageView
 参数：
 x,y,width,height  位置宽高
 fatherview  父视图
 imagename  图片名字不带.png
 */
#define NEWIMAGEVIEWNORETURN(x,y,width,height,fatherview,imagename)   {UIImageView * imageview  =[[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.image = IMG_File_Png(imagename);\
[fatherview addSubview:imageview];}

/*
 作用 新建UIImageView
 参数：
 x,y,width,height  位置宽高
 fatherview  父视图
 imagename  图片名字不带.png
 tags imageview的tag
 */

#define NEWIMAGEVIEWITHTAG(x,y,width,height,fatherview,imagename,tags)   {UIImageView * imageview  =[[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.tag =  tags;\
imageview.image = IMG_File_Png(imagename);\
[fatherview addSubview:imageview];}




/*
 作用 新建UILabel
 参数：
 x,y,width,height  位置宽高
 fatherview  父视图
 str  label文字
 textcolor  文字颜色
 textcolor
 */
#define NEWLABELNORETURN(x,y,width,height,fatherview,str,textcolor,fountsize,textalignment)   {UILabel * label =[[UILabel alloc]init];\
label.frame = CGRectMake(x,y,width , height);\
label.font = [UIFont systemFontOfSize:fountsize];\
label.text = str;\
label.textColor =textcolor;\
label.textAlignment =textalignment;\
label.backgroundColor = [UIColor clearColor];\
[fatherview addSubview:label];}



/*
 作用 新建UILabel
 参数：
 x,y,width,height  位置宽高
 fatherview  父视图
 str  label文字
 textcolor  文字颜色
 textcolor
 */
#define NEWLABEL(label,x,y,width,height,fatherview,str,textcolor,fountsize,textalignment)    [[UILabel alloc]init];\
label.frame = CGRectMake(x,y,width , height);\
label.text = str;\
label.textColor =textcolor;\
label.textAlignment =textalignment;\
label.backgroundColor = [UIColor clearColor];\
label.font = [UIFont systemFontOfSize:fountsize];\
[fatherview addSubview:label];



/*
 作用 新建UILabel
 参数：
 x,y,width,height  位置宽高
 fatherview  父视图
 str  label文字
 textcolor  文字颜色
 tags
 */
#define NEWLABELWITHTAG(x,y,width,height,fatherview,str,textcolor,fountsize,textalignment,tags)   {UILabel * label =[[UILabel alloc]init];\
label.frame = CGRectMake(x,y,width , height);\
label.text = str;\
label.tag = tags;\
label.textColor =textcolor;\
label.textAlignment =textalignment;\
label.backgroundColor = [UIColor clearColor];\
label.font = [UIFont systemFontOfSize:fountsize];\
[fatherview addSubview:label];}


/*
 作用添加细线（一般用于两个cell之间的分界线）
 参数
 x,y,width,height  位置宽高
 fatherview  父视图
 
 */
#define NEWLINE(x,y,width,height,fatherview)   {UIImageView * imageview  =[[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.image = IMG_Name(@"line");\
[fatherview addSubview:imageview];}

/*
 作用添加细线（一般用于两个cell之间的分界线）
 参数
 x,y,width,height  位置宽高
 fatherview  父视图
 tags 线的tag
 */
#define NEWLINEWITHTAG(x,y,width,height,fatherview,tags)   {UIImageView * imageview  =[[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.tag = tags;\
imageview.image = IMG_Name(@"line");\
[fatherview addSubview:imageview];}




/**
 *  @Author tangbinqi, 14-11-18 16:11:27
 *
 *  @brief  虚线
 *
 *  @param x
 *  @param y
 *  @param width
 *  @param height
 *  @param fatherview
 *
 *  @return
 *
 *  @since v4.0.4
 */
#define NEW_XU_LINE(x,y,width,height,fatherview)   {UIImageView * imageview  =[[UIImageView alloc]init];\
imageview.frame = CGRectMake(x,y,width , height);\
imageview.image = IMG_File_Png(@"line_xuxian_chang");\
[fatherview addSubview:imageview];}



/*
 作用 新建UIButton
 参数：
 uibutton ：返回的uibutton
 x,y,width,height  位置宽高
 fatherview  父视图
 imagename  背景图片名字
 */

#define NEWBUTTON(button,buttontype,x,y,width,height,fatherview,target,bacimagename,tittle,tittlecolor,bacgroundcolor,buttontag) \
[UIButton buttonWithType:buttontype];\
button.frame =CGRectMake(x,y,width ,height);\
if (bacimagename) {\
[button setBackgroundImage:IMG_File_Png(bacimagename) forState:UIControlStateNormal];\
}\
if (target) {\
[button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];\
}\
[button setBackgroundColor:[UIColor whiteColor]];\
if (tittlecolor) {\
[button setTitleColor:tittlecolor forState:UIControlStateNormal];\
}\
button.tag = buttontag;\
if (bacgroundcolor) {\
[button setBackgroundColor:bacgroundcolor];\
}\
if (tittle) {\
[button setTitle:tittle forState:UIControlStateNormal];\
}\
[fatherview addSubview:button];\



/*
 作用 新建UIButton
 参数：
 uibutton ：返回的uibutton
 x,y,width,height  位置宽高
 fatherview  父视图
 imagename  背景图片名字
 */

#define NEWBUTTONNORETURN(buttontype,x,y,width,height,fatherview,target,bacimagename,tittle,tittlecolor,bacgroundcolor,buttontag)  {\
UIButton * button = [UIButton buttonWithType:buttontype];\
button.frame =CGRectMake(x,y,width ,height);\
if (bacimagename) {\
[button setImage:IMG_File_Png(bacimagename) forState:UIControlStateNormal];\
}\
if (target) {\
[button addTarget:self action:target forControlEvents:UIControlEventTouchUpInside];\
}\
if (tittlecolor) {\
[button setTitleColor:tittlecolor forState:UIControlStateNormal];\
}\
button.tag = buttontag;\
if (bacgroundcolor) {\
[button setBackgroundColor:bacgroundcolor];\
}\
else{\
[button setBackgroundColor:[UIColor clearColor]];\
}\
if (tittle) {\
[button setTitle:tittle forState:UIControlStateNormal];\
}\
[fatherview addSubview:button];\
}\

