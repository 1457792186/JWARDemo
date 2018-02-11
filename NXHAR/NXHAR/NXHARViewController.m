//
//  NXHARViewController.m
//  NXHAR
//
//  Created by apple on 2018/2/9.
//  Copyright © 2018年 UgoMedia. All rights reserved.
//

#import "NXHARViewController.h"
#import "OpenGLView.h"
#import "AppDelegate.h"

@interface NXHARViewController ()

@property(nonatomic, strong) OpenGLView *glView;

@end

@implementation NXHARViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.glView = [[OpenGLView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.glView];
    
    [self.glView setOrientation:self.interfaceOrientation];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAR) name:@"arSuccess" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showARFail) name:@"arFail" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((AppDelegate *)[[UIApplication sharedApplication]delegate]).active=YES;
    [self.glView start];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    ((AppDelegate *)[[UIApplication sharedApplication]delegate]).active=NO;
    [self.glView stop];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.glView resize:self.view.bounds orientation:self.interfaceOrientation];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.glView setOrientation:toInterfaceOrientation];
}

- (void)showAR{
    [self showHUDWithStr:@"扫描成功233"];
    
    
}

- (void)showARFail{
//    [self showHUDWithStr:@"扫描失败"];
}

//提示警告
- (void)showHUDWithStr:(NSString *)showHud{
    if (showHud == nil || [showHud isEqualToString:@""]) {
        return;
    }
    
    UIWindow * window =[[UIApplication sharedApplication].windows lastObject];
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    
    UILabel *label = [[UILabel alloc] init];
    
    CGRect labelRect = [showHud boundingRectWithSize:CGSizeMake(290, 9000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName, nil] context:nil];
    
    label.frame = CGRectMake(10, 5, labelRect.size.width, labelRect.size.height);
    label.text = showHud;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - labelRect.size.width - 20)/2, [UIScreen mainScreen].bounds.size.height - 100, labelRect.size.width+20, labelRect.size.height+10);
    [UIView animateWithDuration:0.05 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end
