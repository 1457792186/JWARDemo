//
//  NXHHomeViewController.m
//  NXHAR
//
//  Created by apple on 2018/2/9.
//  Copyright © 2018年 UgoMedia. All rights reserved.
//

#import "NXHHomeViewController.h"
#import "TZImagePickerController.h"
#import "NXHTargetImageManger.h"
#import "NXHARViewController.h"

@interface NXHHomeViewController ()<TZImagePickerControllerDelegate>

@end

@implementation NXHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选图";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIImageView * bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:bgImageView];
    
    //    选择检测图片
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVC.allowPickingVideo = NO;
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray * photos , NSArray * assets,BOOL isSelectOriginalPhoto){
        if (photos && photos.count>0) {
            bgImageView.image = [photos firstObject];
            
            [NXHTargetImageManger shareManger].images = photos;
            NXHARViewController * arView = [[NXHARViewController alloc]init];
            [self.navigationController pushViewController:arView animated:YES];
        }
    }];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

@end
