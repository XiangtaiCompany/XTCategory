//
//  UIButton+Border.m
//  MeiTuan
//
//  Created by 何凯楠 on 16/6/16.
//  Copyright © 2016年 HeXiaoBa. All rights reserved.
//

#import "UIView+XTExtension.h"

@implementation UIView (XTExtension)

#pragma mark - CreateImage
///=============================================================================
/// @name CreateImage
///=============================================================================
- (UIImage *)xt_snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (UIImage *)xt_snapshotImageAfterScreenUpdates:(BOOL)afterUpdates {
    if (![self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        return [self xt_snapshotImage];
    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:afterUpdates];
    UIImage *snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snap;
}

- (NSData *)xt_snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData* data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self.layer renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

#pragma mark - Porperties
///=============================================================================
/// @name Porperties
///=============================================================================
- (UIViewController *)xt_viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (CGFloat)xt_visibleAlpha {
    if ([self isKindOfClass:[UIWindow class]]) {
        if (self.hidden) return 0;
        return self.alpha;
    }
    if (!self.window) return 0;
    CGFloat alpha = 1;
    UIView *v = self;
    while (v) {
        if (v.hidden) {
            alpha = 0;
            break;
        }
        alpha *= v.alpha;
        v = v.superview;
    }
    return alpha;
}

- (CGFloat)xt_left {
    return self.frame.origin.x;
}

- (void)setXt_left:(CGFloat)xt_left {
    CGRect frame = self.frame;
    frame.origin.x = xt_left;
    self.frame = frame;
}

- (CGFloat)xt_top {
    return self.frame.origin.y;
}

- (void)setXt_top:(CGFloat)xt_top {
    CGRect frame = self.frame;
    frame.origin.y = xt_top;
    self.frame = frame;
}

- (CGFloat)xt_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setXt_right:(CGFloat)xt_right {
    CGRect frame = self.frame;
    frame.origin.x = xt_right - self.frame.size.width;
    self.frame = frame;
}

- (CGFloat)xt_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setXt_bottom:(CGFloat)xt_bottom {
    CGRect frame = self.frame;
    frame.origin.y = xt_bottom - self.frame.size.height;
    self.frame = frame;
}

- (CGFloat)xt_width {
    return self.frame.size.width;
}

- (void)setXt_width:(CGFloat)xt_width {
    CGRect frame = self.frame;
    frame.size.width = xt_width;
    self.frame = frame;
}

- (CGFloat)xt_height {
    return self.frame.size.height;
}

- (void)setXt_height:(CGFloat)xt_height {
    CGRect frame = self.frame;
    frame.size.height = xt_height;
    self.frame = frame;
}

- (CGFloat)xt_centerX {
    return self.center.x;
}

- (void)setXt_centerX:(CGFloat)xt_centerX {
    CGPoint center = self.center;
    center.x = xt_centerX;
    self.center = center;
}

- (CGFloat)xt_centerY {
    return self.center.y;
}

- (void)setXt_centerY:(CGFloat)xt_centerY {
    CGPoint center = self.center;
    center.y = xt_centerY;
    self.center = center;
}

- (CGPoint)xt_origin {
    return self.frame.origin;
}

- (void)setXt_origin:(CGPoint)xt_origin {
    CGRect frame = self.frame;
    frame.origin = xt_origin;
    self.frame = frame;
}

- (CGSize)xt_size {
    return self.frame.size;
}

- (void)setXt_size:(CGSize)xt_size {
    CGRect frame = self.frame;
    frame.size = xt_size;
    self.frame = frame;
}


- (CGPoint)xt_convertPoint:(CGPoint)point toViewOrWindow:(nullable UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point toWindow:nil];
        } else {
            return [self convertPoint:point toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point toView:view];
    point = [self convertPoint:point toView:from];
    point = [to convertPoint:point fromWindow:from];
    point = [view convertPoint:point fromView:to];
    return point;
}

- (CGPoint)xt_convertPoint:(CGPoint)point fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertPoint:point fromWindow:nil];
        } else {
            return [self convertPoint:point fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertPoint:point fromView:view];
    point = [from convertPoint:point fromView:view];
    point = [to convertPoint:point fromWindow:from];
    point = [self convertPoint:point fromView:to];
    return point;
}

- (CGRect)xt_convertRect:(CGRect)rect toViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect toWindow:nil];
        } else {
            return [self convertRect:rect toView:nil];
        }
    }
    
    UIWindow *from = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    UIWindow *to = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    if (!from || !to) return [self convertRect:rect toView:view];
    if (from == to) return [self convertRect:rect toView:view];
    rect = [self convertRect:rect toView:from];
    rect = [to convertRect:rect fromWindow:from];
    rect = [view convertRect:rect fromView:to];
    return rect;
}

- (CGRect)xt_convertRect:(CGRect)rect fromViewOrWindow:(UIView *)view {
    if (!view) {
        if ([self isKindOfClass:[UIWindow class]]) {
            return [((UIWindow *)self) convertRect:rect fromWindow:nil];
        } else {
            return [self convertRect:rect fromView:nil];
        }
    }
    
    UIWindow *from = [view isKindOfClass:[UIWindow class]] ? (id)view : view.window;
    UIWindow *to = [self isKindOfClass:[UIWindow class]] ? (id)self : self.window;
    if ((!from || !to) || (from == to)) return [self convertRect:rect fromView:view];
    rect = [from convertRect:rect fromView:view];
    rect = [to convertRect:rect fromWindow:from];
    rect = [self convertRect:rect fromView:to];
    return rect;
}


#pragma mark - Border
///=============================================================================
/// @name Border
///=============================================================================
-(void)xt_addTopBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

-(void)xt_addBottomBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}

-(void)xt_addLeftBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

-(void)xt_addRightBorderWithColor:(UIColor *)color width:(CGFloat)borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}
@end
