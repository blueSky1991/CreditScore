//
//  DDCreditScoreView.m
//  CreditScore
//
//  Created by 张东东 on 16/6/29.
//  Copyright © 2016年 张东东. All rights reserved.
//

#import "DDCreditScoreView.h"
#import "UIColor+Extensions.h"


#define SCREEN_WIDTH       self.frame.size.width
#define SCREEN_HEIGHT     self.frame.size.height
#define  CENTER   CGPointMake(SCREEN_WIDTH *.5, SCREEN_HEIGHT *.4)

#define  ConversionRadian(degrees)    (( M_PI* degrees)/ 180)
#define  percentageToRadian(percentage)      (( M_PI* percentage)/ 240)



@interface DDCreditScoreView ()
/** 外圈  */
@property (nonatomic,strong)CAGradientLayer *gradientLayer;
/** 中圈  */
@property (nonatomic,strong)CAGradientLayer *centerGradientLayer;
/** 内圈  */
@property (nonatomic,strong)CAGradientLayer *insideGradientLayer;
/** 颜色数组 */
@property (nonatomic,strong)NSMutableArray *colors;
/** 背景颜色数组 */
@property (nonatomic,strong)NSMutableArray *bgColors;
/** 信用起始 */
@property (nonatomic,assign)double percentageStart;


@end

@implementation DDCreditScoreView

- (NSMutableArray *)colors{
    if (!_colors){
        _colors = [NSMutableArray array];
        NSArray *hexs = @[@0xffff0000,@0xffffff00, @0xff00ff00,@0xff00ffff,@0xff0000ff,@0xffff00ff];
        for (int i = 0; i < hexs.count; i++) {
            UIColor *hexColor = [UIColor colorWithHex:(long)hexs[i] alpha:.5];
            [_colors addObject:(__bridge id)hexColor.CGColor];
        }
    }
    return _colors;
}

-(NSMutableArray *)bgColors{
    if (!_bgColors){
        _bgColors = [NSMutableArray array];
        NSArray *hexs = @[@0xffff0000,@0xffffff00, @0xff00ff00,@0xff00ffff,@0xff0000ff,@0xffff00ff];
        for (int i = 0; i < hexs.count; i++) {
            UIColor *hexColor = [UIColor colorWithHex:(long)hexs[i] alpha:.5];
            [_bgColors addObject:hexColor];
        }
    }
    return _bgColors;
}

- (CAGradientLayer *)gradientLayer{
    if (!_gradientLayer) {
        int radius = 180;
        CAShapeLayer *arc = [CAShapeLayer layer];
        arc.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:radius startAngle:ConversionRadian(150)  endAngle:ConversionRadian(390) clockwise:1].CGPath;
        arc.position = CGPointMake((CGRectGetMidX(self.frame)-radius)*.2,
                                   CGRectGetMidY(self.frame)*.4-radius);
        arc.fillColor = [UIColor clearColor].CGColor;
        arc.strokeColor = [UIColor purpleColor].CGColor;
        arc.lineWidth = 15;
         [arc setLineDashPattern:[NSArray arrayWithObjects:@15,@1,nil]];
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.frame;
        _gradientLayer.colors = self.colors;
        _gradientLayer.startPoint = CGPointMake(0,0.5);
        _gradientLayer.endPoint = CGPointMake(1,0.5);
        _gradientLayer.mask = arc;
        
        }
    return _gradientLayer;
}

- (CAGradientLayer *)centerGradientLayer{
    if (!_centerGradientLayer) {
        CAShapeLayer *centerArc = [CAShapeLayer layer];
        centerArc.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:150 startAngle:ConversionRadian(150)  endAngle:ConversionRadian(390) clockwise:1].CGPath;
        centerArc.position = CGPointMake((CGRectGetMidX(self.frame)-150)*.1,
                                         CGRectGetMidY(self.frame)*.31-150);
        centerArc.fillColor = [UIColor clearColor].CGColor;
        centerArc.strokeColor = [UIColor blackColor].CGColor;
        centerArc.lineWidth = 4;
        _centerGradientLayer = [CAGradientLayer layer];
        _centerGradientLayer.frame = self.frame;
        _centerGradientLayer.colors = @[(__bridge id)[UIColor lightGrayColor].CGColor,(__bridge id)[UIColor lightGrayColor].CGColor];
        _centerGradientLayer.startPoint = CGPointMake(0,0.5);
        _centerGradientLayer.endPoint = CGPointMake(1,0.5);
        _centerGradientLayer.mask = centerArc;
    }
    return  _centerGradientLayer;
}

-(CAGradientLayer *)insideGradientLayer{
    if (!_insideGradientLayer) {
        CAShapeLayer *insideArc = [CAShapeLayer layer];
        insideArc.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:125 startAngle:ConversionRadian(150)  endAngle:ConversionRadian(390) clockwise:1].CGPath;
        insideArc.position = CGPointMake((CGRectGetMidX(self.frame)-125)*.08,
                                         CGRectGetMidY(self.frame)*.231-125);
        insideArc.fillColor = [UIColor clearColor].CGColor;
        insideArc.strokeColor = [UIColor lightGrayColor].CGColor;
         [insideArc setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:2],[NSNumber numberWithInt:2],nil]];
        _insideGradientLayer = [CAGradientLayer layer];
        _insideGradientLayer.frame = self.frame;
        _insideGradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor,(__bridge id)[UIColor blackColor].CGColor];
        _insideGradientLayer.startPoint = CGPointMake(0,0.5);
        _insideGradientLayer.endPoint = CGPointMake(1,0.5);
        _insideGradientLayer.mask = insideArc;
    }

    return _insideGradientLayer;
}


- (void)drawRect:(CGRect)rect{
    
    NSString *descText ;
    if (self.percentageStart>=150&&self.percentageStart<350) {
        descText = @"很差";

        self.backgroundColor = self.bgColors[5];
    }else if (self.percentageStart>=350&&self.percentageStart<550){
        descText = @"较差";

        self.backgroundColor = self.bgColors[4];
    }else if (self.percentageStart>=550&&self.percentageStart<600){
        descText = @"中等";

        self.backgroundColor = self.bgColors[3];
    }else if (self.percentageStart>=600&&self.percentageStart<650){
        descText = @"良好";

        self.backgroundColor = self.bgColors[2];
    }else if (self.percentageStart>=650&&self.percentageStart<700){
        descText = @"优秀";

        self.backgroundColor = self.bgColors[1];
    }else if (self.percentageStart>=700&&self.percentageStart<950){
        descText = @"极好";

        self.backgroundColor = self.bgColors[0];
    }
    [descText drawAtPoint:CGPointMake(self.frame.size.width*0.44, self.frame.size.height*0.23) withAttributes:@{ NSFontAttributeName:[UIFont boldSystemFontOfSize:30.0],
                                                                                                                 NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
    [self.layer addSublayer:self.gradientLayer];
    [self.layer addSublayer:self.centerGradientLayer];
    [self.layer addSublayer:self.insideGradientLayer];
    
    CAShapeLayer *centerArc = [CAShapeLayer layer];
    centerArc.path = [UIBezierPath bezierPathWithArcCenter:CENTER radius:150 startAngle:ConversionRadian(150)  endAngle:ConversionRadian(self.percentage) clockwise:1].CGPath;
    centerArc.position = CGPointMake((CGRectGetMidX(self.frame)-150)*.1,
                                     CGRectGetMidY(self.frame)*.31-150);
    centerArc.fillColor = [UIColor clearColor].CGColor;
    centerArc.strokeColor = [UIColor greenColor].CGColor;
    centerArc.lineWidth = 4;
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 5.0;
    drawAnimation.repeatCount         = 1.0;
    drawAnimation.removedOnCompletion = NO;
    drawAnimation.fromValue = [NSNumber numberWithInt:0];
    drawAnimation.toValue = [NSNumber numberWithInt:10];
        drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        [centerArc addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    CAGradientLayer *changeLayer = [CAGradientLayer layer];
    changeLayer.frame = self.frame;
    changeLayer.colors = self.colors;
    changeLayer.startPoint = CGPointMake(0,0.5);
    changeLayer.endPoint = CGPointMake(1,0.5);
    changeLayer.mask = centerArc;
    [self.layer addSublayer:changeLayer];
    NSString *text = [NSString stringWithFormat:@"%.0f",self.percentageStart];
    [text drawAtPoint:CGPointMake(self.frame.size.width*0.35, self.frame.size.height*0.28) withAttributes:@{          NSFontAttributeName:[UIFont boldSystemFontOfSize:80.0],
                                                        NSForegroundColorAttributeName:[UIColor blackColor]}];
    


    
    
    
}

-(void)setPercentage:(double)percentage{
    
    if (_percentage != percentage) {
        if (percentage>=0&&percentage<=100) {
            self.percentageStart =percentage/100*800+150;
             _percentage = percentage/100*240+150;
        }
        [ self setNeedsDisplay];
    }
}


@end
