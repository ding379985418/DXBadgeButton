//
//  DXBadgeButton.m
//  DXBadgeButton
//
//  Created by simon on 16/6/21.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXBadgeButton.h"
#define KDefaultWidth 20
#define KDefaultColor [UIColor redColor]
#define KDefaultRatio 0.2
#define KDefaultLimite 2
#define KdefaultDamping 5
@interface DXBadgeButton ()
///父视图
@property(nonatomic, strong) UIView *containerView;
///前BadgeView视图
@property(nonatomic, strong) UIView *frontView;
///后BadgeView视图
@property(nonatomic, strong) UIView *backView;
/// badgeLabel
@property(nonatomic, strong) UILabel *badgeLabel;

@end

@implementation DXBadgeButton{
    CGFloat r1;
    CGFloat r2;
    CGPoint orgialPoint;
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    CGPoint pointD;
    CGPoint pointO;
    CGPoint pointP;
    CGFloat x1;
    CGFloat x2;
    CGFloat y1;
    CGFloat y2;
    CGFloat sin;
    CGFloat cos;
    CAShapeLayer *shapeLayer;
    UIColor *fillColor;
    CGFloat miniRad;
    CGFloat ratio;
    CGPoint pointG;
    CGFloat cornerRadi;
    UIView *_overView;
}


- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    self.badgeWidth = frame.size.width;
    orgialPoint = CGPointMake(frame.size.width * 0.5, frame.size.height * 0.5);
    [self setUp];

    return  self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

#pragma mark - 初始化方法
- (void)setUp {
    self.isShowBomAnimation = YES;
    self.isShowSpringAnimation = YES;
  cornerRadi = 0.5;
  ratio = KDefaultRatio;
  miniRad = KDefaultLimite;
  shapeLayer = [CAShapeLayer layer];
  CGFloat width = self.badgeWidth ? self.badgeWidth : KDefaultWidth;
  self.frontView = [[UIView alloc] init];
  self.frontView.clipsToBounds = YES;
  self.frontView.bounds = CGRectMake(0, 0, width, width);
  self.frontView.center = orgialPoint;
  self.frontView.layer.cornerRadius = self.frontView.frame.size.width * cornerRadi;
  self.frontView.backgroundColor = KDefaultColor;
  [self addSubview:self.frontView];
    
  self.backView = [UIView new];
  self.backView.hidden = YES;
  self.backView.clipsToBounds = YES;
  self.backView.frame = CGRectMake(0, 0, width, width);
  self.backView.center = orgialPoint;
  self.backView.layer.cornerRadius = self.backView.frame.size.width * 0.5;
  self.backView.backgroundColor = KDefaultColor;
  [self addSubview:self.backView];

    self.badgeLabel = [UILabel new];
    self.badgeLabel.textAlignment = NSTextAlignmentCenter;
    self.badgeLabel.textColor = [UIColor whiteColor];
    self.badgeLabel.frame = self.frontView.bounds;
    self.badgeLabel.font = [UIFont systemFontOfSize:10];
    [self.frontView addSubview:self.badgeLabel];
    [self bringSubviewToFront:self.frontView];
    
    self.backgroundColor = [UIColor clearColor];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureAction:)];
    [self.frontView addGestureRecognizer:pan];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.frontView addGestureRecognizer:tap];
}
#pragma mark -点击手势
- (void)handleTapGesture:(UIGestureRecognizer *)sender{

//    NSLog(@"tap");
    if (self.badgeButtonDidClick) {
        self.badgeButtonDidClick(self);
    }
}



#pragma mark -拖拽手势
- (void)panGestureAction:(UIGestureRecognizer *)sender{
//    NSLog(@"%@",sender);
    CGPoint touchPoint = [sender locationInView:self];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            [self beganDrag];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self dragMovingWitTouchPoint:touchPoint];
            break;
            
        case UIGestureRecognizerStateEnded :
            [self dragFinishWithTouchPoint:touchPoint];
            break;
        case UIGestureRecognizerStateFailed:
              [self dragFinishWithTouchPoint:touchPoint];
            break;
        case UIGestureRecognizerStateCancelled:
              [self dragFinishWithTouchPoint:touchPoint];
            break;
            
        default:
            break;
    }
  
}
#pragma mark -开始拖拽
- (void)beganDrag{
    self.backView.hidden = NO;
    fillColor = self.badgeColor?self.badgeColor:KDefaultColor;
    [self.frontView.layer removeAllAnimations];
    [self convertToOverView];
}
#pragma mark -正在拖拽
- (void)dragMovingWitTouchPoint:(CGPoint)touchPoint{
    if (r1 < miniRad) {
        fillColor = [UIColor clearColor];
        self.backView.hidden = YES;
        [shapeLayer removeFromSuperlayer];
        
    }else{
        self.backView.hidden = NO;
        fillColor = self.badgeColor?self.badgeColor:KDefaultColor;
    }
    
    self.frontView.center = touchPoint;
    x1 = orgialPoint.x;
    y1 = orgialPoint.y;
    x2 = touchPoint.x;
    y2 = touchPoint.y;
    CGFloat distance = sqrtf((x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2));
    
    if (distance == 0) {
        sin = 0;
        cos = 1;
    }else{
        sin = (x2 - x1)/distance;
        cos = (y2 - y1)/distance;
    }
    r2 = self.frontView.frame.size.width * 0.5;
    r1 = r2 - distance * ratio;
    pointA = CGPointMake(x1 - r1*cos, y1+r1*sin);
    pointB = CGPointMake(x1 + r1*cos , y1 - r1*sin);
    pointC = CGPointMake(x2 + r2*cos, y2 - r2 *sin);
    pointD = CGPointMake(x2 -r2 *cos, y2 + r2*sin);
    pointP = CGPointMake(pointB.x + distance *0.5 *sin, pointB.y + distance *0.5 *cos);
    pointO = CGPointMake(pointA.x + distance *0.5 *sin, pointA.y + distance *0.5 *cos);
    pointG = CGPointMake(x1 + KdefaultDamping*sin, y1 + KdefaultDamping*cos);
    
    self.backView.bounds = CGRectMake(0, 0, r1 *2, r1 *2);
    self.backView.layer.cornerRadius = r1 ;
    
    [self  drawRect];
}
#pragma mark -完成拖拽
- (void)dragFinishWithTouchPoint:(CGPoint)touchPoint{
    self.frontView.center = orgialPoint;
    
    if (r1 > miniRad) {
     
        if (self.isShowSpringAnimation) {
            [self displaySpringAnimation];
        }
    }
    if (r1 < miniRad) {
        self.frontView.hidden = YES;
        self.badgeLabel.text = @"";
        if (self.isShowBomAnimation) {
             [self displayBomAnimationWithPoint:touchPoint];
        }
        
        if (self.badgeButtonDidDisappear) {
            self.badgeButtonDidDisappear(self);
        }
    }
    self.backView.bounds = CGRectMake(0, 0, self.frontView.frame.size.width, self.frontView.frame.size.width);
    self.backView.layer.cornerRadius = self.frontView.frame.size.width *0.5;
    [shapeLayer removeFromSuperlayer];
    self.backView.hidden = YES;
     [self convertToOrigalContainerView];
    
    
}
#pragma mark -迁移到置顶视图坐标系
- (void)convertToOverView{
    if(!self.overView.superview){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.overView];
                break;
            }
        }
    } else {
        [self.overView.superview bringSubviewToFront:self.overView];
    }
    _containerView = self.superview;
    self.center = [_containerView convertPoint:self.center toView:self.overView];
    
    if ([_containerView isKindOfClass:[UITableViewCell class]]
        && self == ((UITableViewCell* )_containerView).accessoryView) {
        ((UITableViewCell* )_containerView).accessoryView = nil;
    }
    
    [self.overView addSubview:self];
}
#pragma mark -迁移到原来的坐标系
- (void)convertToOrigalContainerView {
    self.center = [_overView convertPoint:self.center toView:_containerView];
    
   [_containerView addSubview:self];
    
    [_overView removeFromSuperview];
    _overView = nil;
}

#pragma mark -爆炸动画
- (void)displayBomAnimationWithPoint:(CGPoint )point{
    UIImageView *bomView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frontView.frame.size.width,self.frontView.frame.size.width)];
    bomView.center = point;
    [self addSubview:bomView];
    NSMutableArray *bomArry = [NSMutableArray array];
    for (int i =0; i < 4; i++) {
        NSString *imgName = [NSString stringWithFormat:@"DXBadgeButton.bundle/bomb%d",i];
        UIImage *img  = [UIImage imageNamed:imgName];
        [bomArry addObject:img];
    }
    bomView.animationImages = bomArry;
    bomView.animationDuration = 0.5;
    bomView.animationRepeatCount = 1;
    [bomView startAnimating];
}
#pragma mark -弹簧动画
- (void)displaySpringAnimation{
   
    
    CASpringAnimation *springAnimationX = [CASpringAnimation animationWithKeyPath:@"position.x"];
    springAnimationX.duration = springAnimationX.settlingDuration;
    springAnimationX.stiffness = 1000;
    springAnimationX.damping = 5;
    springAnimationX.mass = 0.5;
    springAnimationX.initialVelocity = 70;
    springAnimationX.fromValue = @(pointG.x);
    springAnimationX.toValue = @(orgialPoint.x);
    springAnimationX.repeatCount = 1;
    [self.frontView.layer addAnimation:springAnimationX forKey:nil];
    
    CASpringAnimation *springAnimationY = [CASpringAnimation animationWithKeyPath:@"position.y"];
    springAnimationY.duration = springAnimationY.settlingDuration;
    springAnimationY.mass = 0.5;
    springAnimationY.initialVelocity = 70;
    springAnimationY.fromValue = @(pointG.y);
    springAnimationY.toValue = @(orgialPoint.y);
    springAnimationY.damping = 5;
    springAnimationY.stiffness = 1000;
    springAnimationY.repeatCount = 1;
    [self.frontView.layer addAnimation:springAnimationY forKey:nil];
}
#pragma mark -shapeLayer
- (void)drawRect{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:pointA];
    [path addQuadCurveToPoint:pointD controlPoint:pointO];
    [path addLineToPoint:pointC];
    [path addQuadCurveToPoint:pointB controlPoint:pointP];
    [path moveToPoint:pointA];
    if (self.backView.hidden == NO) {
    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = fillColor.CGColor;
    [self.layer insertSublayer:shapeLayer below:self.frontView.layer];
  }
}
#pragma mark -隐藏bageButton
- (void)hiddenBadgeButton:(BOOL)hidden{
    self.frontView.hidden = hidden;
    self.backView.hidden = YES;
}
- (BOOL)isHidden{
    return self.frontView.hidden;
}
#pragma mark -懒加载 置顶视图
- (UIView *)overView {
    if(!_overView) {
        _overView = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overView.backgroundColor = [UIColor clearColor];
    }
    return _overView;
}
#pragma mark -setter方法
- (void)setBadgeWidth:(CGFloat)badgeWidth {
    _badgeWidth = badgeWidth;
    self.bounds = CGRectMake(0, 0, badgeWidth, badgeWidth);
    self.frontView.bounds = self.bounds;
    self.backView.bounds = self.bounds;
    self.frontView.layer.cornerRadius = badgeWidth * cornerRadi;
    self.backView.layer.cornerRadius = badgeWidth * 0.5;
    self.badgeLabel.frame = self.frontView.bounds;
    if (badgeWidth <= 10) {
        self.badgeFont = [UIFont systemFontOfSize:5];
    }
}
- (void)setBadgeString:(NSString *)badgeString{
    _badgeString = badgeString;
    self.badgeLabel.text = badgeString;
    self.frontView.hidden = NO;
    self.backView.hidden = YES;
    //    [self.badgeLabel sizeToFit];
}
- (void)setBadgeColor:(UIColor *)badgeColor {
    _badgeColor = badgeColor;
    self.frontView.backgroundColor = badgeColor;
    self.backView.backgroundColor = badgeColor;
}

- (void)setBadgeFont:(UIFont *)badgeFont{
    _badgeFont = badgeFont;
    self.badgeLabel.font = badgeFont;
}
- (void)setBadgeTextColor:(UIColor *)badgeTextColor{
    _badgeTextColor = badgeTextColor;
    self.badgeLabel.textColor = badgeTextColor;
}
- (void)setBadgeMinRadius:(CGFloat)badgeMinRadius{
    _badgeMinRadius = badgeMinRadius;
    miniRad = badgeMinRadius < self.frontView.frame.size.width * 0.5?badgeMinRadius:KDefaultLimite;
}
- (void)setBadgeDistaceRatio:(CGFloat)badgeDistaceRatio{
    _badgeDistaceRatio = badgeDistaceRatio;
    ratio = badgeDistaceRatio;
}
- (void)setCornerRadiusRation:(CGFloat)cornerRadiusRation{
    _cornerRadiusRation = cornerRadiusRation;
    cornerRadi = cornerRadiusRation;
    self.frontView.layer.cornerRadius = self.frontView.frame.size.width * cornerRadiusRation;
    
}

@end
