//
//  UIView+FrameExtension.h
//  GMBase
//
//  Created by Sunny on 17/7/6.
//  Copyright (c) 2017年 Sunny. All rights reserved.
//

#import "UIView+FrameExtension.h"
//#import "GMBTool.h"

@implementation UIView (FrameExtension)


-(CGFloat)height
{
    return self.frame.size.height;
}
-(void)setHeight:(CGFloat)height
{
    [self setHeight:height Animated:NO];
}
-(void)setHeight:(CGFloat)height Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size.height=height;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
}
-(void)addHeight:(CGFloat)height
{
    [self setHeight:[self height]+height ];
}


-(CGFloat)width
{
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width
{
    [self setWidth:width Animated:NO];
}
-(void)setWidth:(CGFloat)width Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size.width=width;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addWidth:(CGFloat)width
{
    [self setWidth:[self width]+width Animated:NO];
}

-(CGFloat)originX
{
    return self.frame.origin.x;
}
-(void)setOriginX:(CGFloat)x
{
    [self setOriginX:x Animated:NO];
}
-(void)setOriginX:(CGFloat)x Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin.x=x;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addOriginX:(CGFloat)x
{
    [self setOriginX:[self originX]+x];
}

-(CGFloat)originY
{
    return self.frame.origin.y;
}
-(void)setOriginY:(CGFloat)y
{
    [self setOriginY:y Animated:NO];
}
-(void)setOriginY:(CGFloat)y Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin.y=y;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
    
}
-(void)addOriginY:(CGFloat)y
{
    [self setOriginY:[self originY]+y];
}

-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)size
{
    [self setSize:size Animated:NO];
}
-(void)setSize:(CGSize)size Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.size=size;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
}

-(CGPoint)origin
{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)point
{
    [self setOrigin:point Animated:NO];
}
-(void)setOrigin:(CGPoint)point Animated:(BOOL)animate
{
    CGRect frame=self.frame;
    frame.origin=point;
    if (animate) {
        [UIView animateWithDuration:.3 animations:^{
            self.frame=frame;
        }];
    }else{
        self.frame=frame;
    }
}

-(CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGPoint)originTopRight
{
    return CGPointMake(self.origin.x+self.width, self.origin.y);
}

-(CGPoint)originBottomLeft
{
    return CGPointMake(self.originX, self.originY+self.height);
}

-(CGPoint)originBottomRight
{
    return CGPointMake(self.originX+self.width, self.originY+self.height);
}




-(CGRect)rectForAddViewTop:(CGFloat)height//返回在该view上面添加一个视图时的frame
{
    CGRect frame=self.frame;
    frame.size.height=height;
    frame.origin.y=frame.origin.y-height;
    
    return frame;
}
-(CGRect)rectForAddViewBottom:(CGFloat)height//返回在该view下面添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.origin.y=frame.origin.y+frame.size.height;
    frame.size.height=height;
    return frame;
}
-(CGRect)rectForAddViewLeft:(CGFloat)width//返回在该view左边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x-width;
    return frame;
}
-(CGRect)rectForAddViewRight:(CGFloat)width//返回在该view右边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x+width;
    return frame;
}

-(CGRect)rectForAddViewTop:(CGFloat)height Offset:(CGFloat)offset//返回在该view上面添加一个视图时的frame
{
    CGRect frame=self.frame;
    frame.size.height=height;
    frame.origin.y=frame.origin.y-height-offset;
    return frame;
    
}
-(CGRect)rectForAddViewBottom:(CGFloat)height Offset:(CGFloat)offset//返回在该view下面添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.origin.y=frame.origin.y+frame.size.height+offset;
    frame.size.height=height;
    return frame;
    
}
-(CGRect)rectForAddViewLeft:(CGFloat)width Offset:(CGFloat)offset//返回在该view左边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x-width-offset;
    return frame;
    
}
-(CGRect)rectForAddViewRight:(CGFloat)width Offset:(CGFloat)offset//返回在该view右边添加一个视图的时候的frame
{
    CGRect frame=self.frame;
    frame.size.width=width;
    frame.origin.x=frame.origin.x+width+offset;
    return frame;
}

-(CGRect)rectForCenterofSize:(CGSize)size
{
    CGRect rect;
    rect.size.width=size.width;
    rect.size.height=size.height;
    rect.origin.x=(self.width-size.width)/2.0;
    rect.origin.y=(self.height-size.height)/2.0;
    return rect;
}




-(NSArray*)subviewsWithClass:(Class )cls
{
    NSArray *array=[self subviews];
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([evaluatedObject isKindOfClass:cls]) {
            return YES;
        }
        return NO;
    }]];
}

-(id)viewWithTag2:(int)tag
{
    return [self viewWithTag:tag];
}


/// 设置边框和圆角
-(void)setCornerRadius:(CGFloat)fltCornerRadius
           borderWidth:(CGFloat)fltBorderWidth
           borderColor:(UIColor *)colorBorder
{
    self.layer.cornerRadius = fltCornerRadius;
    self.layer.borderColor = [colorBorder CGColor];
    /// 根据屏幕的分辨率倍数适配边框宽度
    self.layer.borderWidth = [[self class] scaleAdaptWidth:fltBorderWidth];
    self.clipsToBounds = YES;
}

#pragma mark - 

- (void)roundWithCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)roundToCircle
{
    [self roundWithCornerRadius:self.height / 2];
}


/*
 这个方法的原理：大致可以理解为一个点（尺寸）上的像素数就是[UIScreen mainScreen].scale，如果要显示的点数乘以这个
 像素密度得到的像素不是整数的话，那么每个点上所分布的像素会出现不均匀的情况，把传入的点除以像素密度，返回的点数在2倍3倍
 分辨率的设备上比实际传进来的要小，但是保证了点数乘以像素密度可以得到至少一个完整的像素
 */
+ (CGFloat)scaleAdaptWidth:(CGFloat)fltWidth
{
    /// 如果宽度为0，则直接返回
    if (fltWidth == 0)
    {
        return fltWidth;
    }
    
    /// 获取屏幕的像素密度，如iPhone6Plus，一个点上有3个像素，该值为3
    CGFloat fltScale = [UIScreen mainScreen].scale;
    /// 传入的参数最小值要求为1，如果小于1，则设为1，保证像素最小值为1
    if (fltWidth < 1.0)
    {
        fltWidth = 1.0;
    }
    /// 要显示的点除以屏幕密度，为要返回的点，比实际传进来的要小
    return (fltScale > 0 ? (fltWidth / fltScale) : fltWidth);
}


@end
