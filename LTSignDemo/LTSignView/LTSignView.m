//
//  LTSignView.m
//  LTSignDemo
//
//  Created by Luther on 2018/12/20.
//  Copyright © 2018 mrstock. All rights reserved.
//

#import "LTSignView.h"

@interface LTSignView ()
@property (nonatomic, strong) UIBezierPath *signPath;
@property (nonatomic, assign) CGPoint oldPoint;

/** 绘画区域 */
@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@end

@implementation LTSignView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.backgroundColor = [UIColor whiteColor];
    self.oldPoint = CGPointZero;
    self.isHaveSign = NO;
    self.lineWidth = 2;
    self.lineColor = [UIColor blackColor];
    self.minX = 0;
    self.minY = 0;
    self.maxX = 0;
    self.maxY = 0;
}
#pragma mark - 开始
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    [self.signPath moveToPoint:currentPoint];
    self.oldPoint = currentPoint;
}
#pragma mark - 移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    [self.signPath addQuadCurveToPoint:currentPoint controlPoint:self.oldPoint];
    self.oldPoint = currentPoint;
    //设置签名存在
    if (!self.isHaveSign) {
        self.isHaveSign = YES;
    }
    [self setNeedsDisplay];
}

#pragma mark - 清理画板
- (void)clear {
    [self.signPath removeAllPoints];
    self.isHaveSign = NO;
    self.oldPoint = CGPointZero;
    [self setNeedsDisplay];
}

#pragma mark - 获取签名的图片
- (void)saveTheSignatureImage:(void(^)(UIImage *image))imageBlock {
    if (self.isHaveSign) {
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size,NO, [UIScreen mainScreen].scale);
        //获取上下文
        CGContextRef ref = UIGraphicsGetCurrentContext();
        //截图
        [self.layer drawInContext:ref];
        //获取整个视图图片
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        imageBlock(image);
    }
}

- (void)drawRect:(CGRect)rect {
    self.signPath.lineWidth = self.lineWidth;
    [self.lineColor setStroke];
    [self.signPath stroke];
}

- (void)setLineWidth:(CGFloat)lineWidth {
    _lineWidth = lineWidth;
    [self setNeedsDisplay];
}

- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}

- (UIBezierPath *)signPath {
    if (!_signPath) {
        _signPath = [UIBezierPath bezierPath];
    }
    return _signPath;
}

@end
