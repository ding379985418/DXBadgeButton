//
//  DXTest.m
//  DXBadgeButton
//
//  Created by simon on 16/6/23.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "DXTest.h"

@implementation DXTest{
    UIView *_circleView;
    
}
- (void)didMoveToSuperview{
  NSLog(@"-----");
}


//- (instancetype)initWithFrame:(CGRect)frame{
//   self = [super initWithFrame:frame];
//    _circleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//    _circleView.clipsToBounds = YES;
//    _circleView.layer.cornerRadius = 20;
//    _circleView.backgroundColor = [UIColor redColor];
//    [self addSubview:_circleView];
//       return self;
//}


//- (void)layoutSubviews{
//    [super layoutSubviews];
//    UIView *dianView = [[UIView alloc]init];
//    dianView.bounds = CGRectMake(0, 0, 20, 20);
//    dianView.backgroundColor = [UIColor yellowColor];
//    dianView.clipsToBounds = YES;
//    dianView.layer.cornerRadius = 10;
//    dianView.center = [self convertPoint:_circleView.center toView:self.superview];
//    [self.superview addSubview:dianView];
//    [self.superview bringSubviewToFront:dianView];
//    NSLog(@"_circleView:%@,-dianView:%@",NSStringFromCGPoint(_circleView.center),NSStringFromCGPoint(dianView.center));
//}

@end
