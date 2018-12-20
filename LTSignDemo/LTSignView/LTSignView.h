//
//  LTSignView.h
//  LTSignDemo
//
//  Created by Luther on 2018/12/20.
//  Copyright © 2018 mrstock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTSignView : UIView

/** 是否有签名 */
@property (nonatomic, assign) BOOL isHaveSign;
/** 签名线条的宽度 默认是2 */
@property (nonatomic, assign) CGFloat lineWidth;
/** 签名的颜色 默认是black */
@property (nonatomic, strong) UIColor *lineColor;

/** 清除签名 */
- (void)clear;
/** 获取签名的图片 */
- (void)saveTheSignatureImage:(void(^)(UIImage *image))imageBlock;

@end
