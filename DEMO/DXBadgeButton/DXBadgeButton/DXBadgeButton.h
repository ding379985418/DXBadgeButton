//
//  DXBadgeButton.h
//  DXBadgeButton
//
//  Created by simon on 16/6/21.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DXBadgeButton : UIView
///badgeButton的宽度 
@property (nonatomic, assign) CGFloat badgeWidth;
///badge字符串
@property (nonatomic, copy) NSString *badgeString;
///badge颜色 默认为红色
@property (nonatomic, strong) UIColor *badgeColor;
///badge字体 
@property (nonatomic, strong) UIFont *badgeFont;
///badge字体颜色 默认为白色
@property (nonatomic, strong) UIColor *badgeTextColor;
///badgeButton是否隐藏
@property (nonatomic, assign,readonly) BOOL isHidden;
///badgeButton最小的半径,越小拉伸得越尖 默认为2
@property (nonatomic, assign) CGFloat badgeMinRadius;
///badgeButton拉伸长度比率,越小拉伸的距离越长 默认为0.2
@property (nonatomic, assign) CGFloat badgeDistaceRatio;
///bageButton切圆比率,0.5为圆,0为方形
@property (nonatomic, assign) CGFloat cornerRadiusRation;
///是否 爆炸效果
@property (nonatomic, assign) BOOL isShowBomAnimation;
///是否 弹簧效果
@property (nonatomic, assign) BOOL isShowSpringAnimation;

///点击button的回调
@property (nonatomic, copy) void (^badgeButtonDidClick)(DXBadgeButton *badgeButton);
///删除badgeString的回调
@property (nonatomic, copy) void (^badgeButtonDidDisappear)(DXBadgeButton *badgeButton);


///隐藏badgeBtton
- (void)hiddenBadgeButton:(BOOL)hidden;
@end
