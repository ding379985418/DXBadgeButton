//
//  ViewController.m
//  DXBadgeButton
//
//  Created by simon on 16/6/21.
//  Copyright © 2016年 DINGXU. All rights reserved.
//

#import "ViewController.h"
#import "DXBadgeButton.h"
#import "DXTest.h"

@interface ViewController ()
@property (nonatomic, strong)  DXBadgeButton *badge;
@property (nonatomic, strong)  DXBadgeButton *badgeButton;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger time;

@property (weak, nonatomic) IBOutlet UISwitch *isShowSpring;
@property (weak, nonatomic) IBOutlet UISwitch *isShowBom;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DXBadgeButtonDemo";
    self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.00];

//    第一种创建方法
    self.badgeButton = [[DXBadgeButton alloc]initWithFrame:CGRectMake(100, 360, 35, 35) diClickBadge:nil didDisappear:^(DXBadgeButton *badgeButton) {
    
     [badgeButton performSelector:@selector(setBadgeString:) withObject:@"新" afterDelay:4];
    }];
    self.badgeButton.badgeString = @"新";
    self.badgeButton.badgeFont = [UIFont boldSystemFontOfSize:18];
    self.badgeButton.isShowSpringAnimation = self.isShowSpring.on;
    self.badgeButton.isShowBomAnimation = self.isShowBom.on;
    [self.view addSubview:self.badgeButton];

    
   DXBadgeButton *badge2 = [[DXBadgeButton alloc]initWithFrame:CGRectMake(160, 360, 35, 20) diClickBadge:nil didDisappear:^(DXBadgeButton *badgeButton) {
        [badgeButton performSelector:@selector(setBadgeString:) withObject:@"99+" afterDelay:4];
    }];
    badge2.isShowSpringAnimation = self.isShowSpring.on;
    badge2.isShowBomAnimation = self.isShowBom.on;
    badge2.badgeString = @"99+";
    badge2.badgeMinRadius = 5;
    badge2.badgeDistaceRatio = 0.1;
    badge2.badgeColor = [UIColor colorWithRed:0.310 green:0.694 blue:0.902 alpha:1.00];
    badge2.isShowSpringAnimation = self.isShowSpring.on;
    badge2.isShowBomAnimation = self.isShowBom.on;
    [self.view addSubview:badge2];
    
  DXBadgeButton *badge3 = [[DXBadgeButton alloc] initWithFrame:CGRectMake(230, 360, 40, 40)];
    badge3.badgeString = @"99+";
    badge3.badgeTextColor= [UIColor colorWithRed:0.310 green:0.694 blue:0.902 alpha:1.00];
    badge3.badgeFont = [UIFont boldSystemFontOfSize:17];
    badge3.cornerRadiusRation = 0.2;
    badge3.badgeColor = [UIColor colorWithRed:0.992 green:0.784 blue:0.314 alpha:1.00];
    badge3.isShowSpringAnimation = self.isShowSpring.on;
    badge3.isShowBomAnimation = self.isShowBom.on;
    badge3.didDisappearBlock =^(DXBadgeButton *badgeButton) {
       [badgeButton performSelector:@selector(setBadgeString:) withObject:@"99+" afterDelay:4];
    };
    [self.view addSubview:badge3];
    
    [self setUp];
}
- (IBAction)bomSwitchChange:(UISwitch *)sender {

    self.badgeButton.isShowBomAnimation = sender.on;

    
}
- (IBAction)springSwitchChange:(UISwitch *)sender {
        self.badgeButton.isShowSpringAnimation = sender.on;
}



- (void)setUp{

//    第二种创建方法
    _badge = [[DXBadgeButton alloc] initWithFrame:CGRectMake(110, 3, 30, 20)];
    [self.tabBarController.tabBar addSubview:_badge];
    _badge.badgeString = @"10";
    _badge.badgeColor = [UIColor colorWithRed:0.275 green:0.812 blue:0.533 alpha:1.00];
    _badge.badgeDistaceRatio = 0.15;
    _badge.badgeMinRadius = 1;
    _badge.cornerRadiusRation = 0.3;
    __weak __typeof(&*self)weakSelf = self;
    _badge.didClickBlock =^(DXBadgeButton *badgeButton) {

        [badgeButton hiddenBadgeButton:YES];
        weakSelf.timer = nil;
        _time = 0;
        [weakSelf.timer fire];
    };
    _badge.didDisappearBlock =^(DXBadgeButton *badgeButton) {
        weakSelf.timer = nil;
        _time = 0;
        [weakSelf.timer fire];
    };
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.badge hiddenBadgeButton:YES];
    _time = 0;
    _timer = nil;
    [self.timer fire];
}
- (void)handleTimer{
    self.time ++;
    if (self.time ==5) {
        self.badge.badgeString = @"10";
        self.time = 0;
        [self.timer invalidate];
    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (NSTimer *)timer{
    if (!_timer) {
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
    return _timer;
}

@end
