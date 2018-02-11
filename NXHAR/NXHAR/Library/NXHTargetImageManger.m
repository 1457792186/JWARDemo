//
//  NXHTargetImageManger.m
//  NXHAR
//
//  Created by apple on 2018/2/9.
//  Copyright © 2018年 UgoMedia. All rights reserved.
//

#import "NXHTargetImageManger.h"

#define ARIMAGESPATH [NSString stringWithFormat:@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]]

static NXHTargetImageManger * imageManger = nil;

@implementation NXHTargetImageManger


+ (instancetype)shareManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageManger = [[NXHTargetImageManger alloc] init];
        imageManger.imagePath = ARIMAGESPATH;
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[ARIMAGESPATH stringByAppendingPathComponent:@"arImage"]]) {
            BOOL isSuccess = [[NSFileManager defaultManager] createFileAtPath:[ARIMAGESPATH stringByAppendingPathComponent:@"arImage"] contents:nil attributes:nil];
            NSLog(isSuccess?@"file创建成功":@"file创建失败");
        }
    });
    
    return imageManger;
}

//目前只支持JPG格式图片
- (void)setImages:(NSArray *)images{
    _images = images;
    if (images) {
        _imagesPath = [NSMutableArray array];
        for (int i = 0; i<images.count; i++) {
            NSString * imageName = [NSString stringWithFormat:@"%zi.jpg",i];
            NSString * arImagePath= [ARIMAGESPATH stringByAppendingPathComponent:@"arImage"];
            arImagePath = [arImagePath stringByAppendingPathComponent:imageName];

            UIImage * image = images[i];
            NSData * imageData = UIImageJPEGRepresentation(image, .0000005);
            
            BOOL isSuccess=[[NSFileManager defaultManager] createFileAtPath:arImagePath contents:nil attributes:nil];
            NSLog(isSuccess?@"image创建成功":@"image创建失败");
            
            isSuccess = [imageData writeToFile:arImagePath atomically:YES];
            NSLog(isSuccess?@"image写入创建成功":@"image写入创建失败");
            
            [_imagesPath addObject:imageName];
        }
    }
}


@end
