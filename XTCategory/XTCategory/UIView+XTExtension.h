//
//  UIButton+Border.h
//  MeiTuan
//
//  Created by 何凯楠 on 16/6/16.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (XTExtension)
#pragma mark - CreateImageOrPDF
///=============================================================================
/// @name CreateImage
///=============================================================================

/**
 截屏

 @return image
 */
- (UIImage *)xt_snapshotImage;;

- (UIImage *)xt_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates;

/**
 创建一个pdf

 @return nsdata
 */
- (NSData *)xt_snapshotPDF;

#pragma mark - Porperties
///=============================================================================
/// @name Porperties
///=============================================================================

/**
 返回当前view所在的viewController
 */
@property (nullable, nonatomic, readonly) UIViewController *xt_viewController;

/**
 返回屏幕上的可见alpha，考虑到superview和window
 */
@property (nonatomic, readonly) CGFloat xt_visibleAlpha;

@property (nonatomic) CGFloat xt_left;        // frame.origin.x.
@property (nonatomic) CGFloat xt_top;         // frame.origin.y
@property (nonatomic) CGFloat xt_right;       // frame.origin.x + frame.size.width
@property (nonatomic) CGFloat xt_bottom;      // frame.origin.y + frame.size.height
@property (nonatomic) CGFloat xt_width;       // frame.size.width.
@property (nonatomic) CGFloat xt_height;      // frame.size.height.
@property (nonatomic) CGFloat xt_centerX;     // center.x
@property (nonatomic) CGFloat xt_centerY;     // center.y
@property (nonatomic) CGPoint xt_origin;      // frame.origin.
@property (nonatomic) CGSize  xt_size;        // frame.size.


/**
 把一个在self上的坐标转换成一个在view或window上的坐标

 @param point self上的坐标
 @param view view或window
 @return 一个在view或window上的坐标
 */
- (CGPoint)xt_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view;
/**
 把一个在view或window上的坐标，转换成一个在self上的坐标

 @param point 一个在view或window上的坐标
 @param view view或window
 @return 一个在self上的坐标
 */
- (CGPoint)xt_convertPoint:(CGPoint)point fromViewOrWindow:(nullable UIView *)view;

/**
 把一个在self上的frame转换成一个在view或window上的frame

 @param rect 一个在self上的frame
 @param view view或window
 @return 在view或window上的frame
 */
- (CGRect)xt_convertRect:(CGRect)rect toViewOrWindow:(nullable UIView *)view;

/**
 把一个在view或window上的frame，转换成一个在self上的frame

 @param rect 一个在view或window上的frame
 @param view view或window
 @return 一个在self上的frame
 */
- (CGRect)xt_convertRect:(CGRect)rect fromViewOrWindow:(nullable UIView *)view;

#pragma mark - Border
///=============================================================================
/// @name Border
///=============================================================================

/**
 给view添加线条

 @param color 线条颜色
 @param borderWidth 线条宽度
 */
-(void)xt_addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth;
-(void)xt_addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth;
-(void)xt_addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth;
-(void)xt_addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth;

@end

NS_ASSUME_NONNULL_END
