# DXBadgeButton 模仿QQ消息badge
## 效果图
![image][image-1]   
## 使用方法
### 第一种:
	self.badgeButton = [DXBadgeButton alloc]initWithFrame:CGRectMake(100, 360, 35, 35) diClickBadge:^(DXBadgeButton *badgeButton) {
	//        点击后的回调
	    } didDisappear:^(DXBadgeButton *badgeButton) {
	//        隐藏后的回调
	    };
	self.badgeButton.badgeString = @"新";
	[self.view addSubview:self.badgeButton];
### 第二种:
	DXBadgeButton *badge3 = [[DXBadgeButton alloc] initWithFrame:CGRectMake(230, 360, 40, 40)];
	[self.view addSubview:badge3];
## 接口API和属性
	///badge字符串
	@property (nonatomic, copy) NSString *badgeString;
	///badge颜色 默认为红色
	@property (nonatomic, strong) UIColor *badgeColor;
	///badge字体 
	@property (nonatomic, strong) UIFont *badgeFont;
	///badge字体颜色 默认为白色
	@property (nonatomic, strong) UIColor *badgeTextColor;
	///弹簧效果幅度，值越大，幅度越大，默认为20
	@property (nonatomic, assign) CGFloat springRange;
	///badgeButton最小的半径,越小拉伸得越尖 默认为4
	@property (nonatomic, assign) CGFloat badgeMinRadius;
	///badgeButton拉伸长度比率,越小拉伸的距离越长 默认为0.2
	@property (nonatomic, assign) CGFloat badgeDistaceRatio;
	///bageButton切圆比率,当width == height 时 ：0.5为圆,0为方形
	@property (nonatomic, assign) CGFloat cornerRadiusRation;
	///是否 爆炸效果
	@property (nonatomic, assign) BOOL isShowBomAnimation;
	///是否 弹簧效果
	@property (nonatomic, assign) BOOL isShowSpringAnimation;
	///badgeButton是否隐藏
	@property (nonatomic, assign,readonly) BOOL isHidden;
	///点击button的回调
	@property (nonatomic, copy) BadgeDidClickBlock didClickBlock;
	///删除badgeString的回调
	@property (nonatomic, copy) BadgeDidDisappearBlock didDisappearBlock;
	
	///隐藏badgeBtton
	- (void)hiddenBadgeButton:(BOOL)hidden;
	/**
	 *  初始化方法
	 *
	 *  @param frame
	 *  @param didClickBlock     点击后的回到block
	 *  @param didDisappearBlock bage隐藏后的block
	 */
	- (instancetype)initWithFrame:(CGRect)frame
	                 diClickBadge:(BadgeDidClickBlock)didClickBlock
	                 didDisappear:(BadgeDidDisappearBlock)didDisappearBlock;

[image-1]:	https://github.com/ding379985418/DXBadgeButton/blob/master/DXBadgeAnimation.gif