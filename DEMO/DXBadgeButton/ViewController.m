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
    self.view.backgroundColor = [UIColor grayColor];
    
    self.badgeButton = [[DXBadgeButton alloc]initWithFrame:CGRectMake(160, 360, 60, 20)];
    self.badgeButton.badgeString = @"新";
    self.badgeButton.isShowSpringAnimation = self.isShowSpring.on;
    self.badgeButton.isShowBomAnimation = self.isShowBom.on;
    [self.view addSubview:self.badgeButton];
    [self.badgeButton setBadgeButtonDidDisappear:^(DXBadgeButton * badge) {
        [badge performSelector:@selector(setBadgeString:) withObject:@"新" afterDelay:4];
      
    }];
    
    [self setUp];
}
- (IBAction)bomSwitchChange:(UISwitch *)sender {

    self.badgeButton.isShowBomAnimation = sender.on;

    
}
- (IBAction)springSwitchChange:(UISwitch *)sender {
        self.badgeButton.isShowSpringAnimation = sender.on;
}



- (void)setUp{
    self.view.backgroundColor = [UIColor grayColor];
    _badge = [[DXBadgeButton alloc] initWithFrame:CGRectMake(90, 3, 20, 20)];
    [self.tabBarController.tabBar addSubview:_badge];
    _badge.badgeString = @"10";
    _badge.badgeDistaceRatio = 0.15;
    _badge.badgeMinRadius = 1;
    _badge.cornerRadiusRation = 0.2;
    __weak __typeof(&*self)weakSelf = self;
    [_badge setBadgeButtonDidClick:^(DXBadgeButton *badgeButton) {
        //        badgeButton.badgeString = [NSString stringWithFormat:@"%ld",[badgeButton.badgeString integerValue] +1];
        [badgeButton hiddenBadgeButton:YES];
        weakSelf.timer = nil;
        _time = 0;
        [weakSelf.timer fire];
    }];
    
    [_badge setBadgeButtonDidDisappear:^(DXBadgeButton *badgeButton) {
        weakSelf.timer = nil;
        _time = 0;
        [weakSelf.timer fire];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.badge hiddenBadgeButton:YES];
    _time = 0;
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
