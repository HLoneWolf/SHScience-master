//
//  PathView.m
//  ShScience
//
//  Created by qiya on 16/2/1第6周.
//  Copyright © 2016年 qiya. All rights reserved.
//

#import "PathView.h"
#import "QyUtils.h"

@implementation PathView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //An opaque type that represents a Quartz 2D drawing environment.
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    //CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(800.0,450.0)];
    //[path addLineToPoint:CGPointMake(450, 200)];
    //[path addLineToPoint:CGPointMake(350.0, 900)];
    [path addQuadCurveToPoint:CGPointMake(800, 900) controlPoint:CGPointMake(900, 600)];
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.bounds;
    pathLayer.path = path.CGPath;
    //pathLayer.strokeColor = [[UIColor redColor] CGColor];
    pathLayer.strokeColor = [RGB(39, 127, 195) CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 3.0f;
    pathLayer.lineJoin = kCALineJoinBevel;
    //pathLayer.lineDashPattern = @[@8, @8];//虚线

    
    [self.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
    
//    CGContextSetRGBFillColor (context,  1, 0, 0, 1.0);//设置填充颜色
//    UIFont  *font = [UIFont boldSystemFontOfSize:15.0];//设置
//    [@"画圆：" drawInRect:CGRectMake(10, 20, 80, 20) withFont:font];
//    [@"画线及孤线：" drawInRect:CGRectMake(10, 80, 100, 20) withFont:font];
//    [@"画矩形：" drawInRect:CGRectMake(10, 120, 80, 20) withFont:font];
//    [@"画扇形和椭圆：" drawInRect:CGRectMake(10, 160, 110, 20) withFont:font];
//    [@"画三角形：" drawInRect:CGRectMake(10, 220, 80, 20) withFont:font];
//    [@"画圆角矩形：" drawInRect:CGRectMake(10, 260, 100, 20) withFont:font];
//    [@"画贝塞尔曲线：" drawInRect:CGRectMake(10, 300, 100, 20) withFont:font];
//    [@"图片：" drawInRect:CGRectMake(10, 340, 80, 20) withFont:font];
//    
//    /*画圆*/
//    //边框圆
//    CGContextSetRGBStrokeColor(context,1,1,1,1.0);//画笔线的颜色
//    CGContextSetLineWidth(context, 1.0);//线的宽度
//    //void CGContextAddArc(CGContextRef c,CGFloat x, CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle, int clockwise)1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
//    // x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为 结束的弧度，clockwise 0为顺时针，1为逆时针。
//    CGContextAddArc(context, 100, 20, 15, 0, 2*PI, 0); //添加一个圆
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径
//    
//    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
//    CGFloat colors[] =
//    {
//        1,1,1, 1.00,
//        1,1,0, 1.00,
//        1,0,0, 1.00,
//        1,0,1, 1.00,
//        0,1,1, 1.00,
//        0,1,0, 1.00,
//        0,0,1, 1.00,
//        0,0,0, 1.00,
//    };
//    CGGradientRef gradient = CGGradientCreateWithColorComponents
//    (rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));//形成梯形，渐变的效果
//    CGColorSpaceRelease(rgb);
//    //再写一个看看效果
//    CGContextSaveGState(context);
//    CGContextMoveToPoint(context, 260, 90);
//    CGContextAddLineToPoint(context, 280, 90);
//    CGContextAddLineToPoint(context, 280, 100);
//    CGContextAddLineToPoint(context, 260, 100);
//    CGContextClip(context);//裁剪路径
//    //说白了，开始坐标和结束坐标是控制渐变的方向和形状
//    CGContextDrawLinearGradient(context, gradient,CGPointMake
//                                (260, 90) ,CGPointMake(260, 100),
//                                kCGGradientDrawsAfterEndLocation);
//    CGContextRestoreGState(context);// 恢复到之前的context

}


@end
