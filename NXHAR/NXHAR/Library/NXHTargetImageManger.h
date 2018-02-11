//
//  NXHTargetImageManger.h
//  NXHAR
//
//  Created by apple on 2018/2/9.
//  Copyright © 2018年 UgoMedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NXHTargetImageManger : NSObject

@property (nonatomic,strong)NSArray * images;
@property (nonatomic,strong,readonly)NSMutableArray * imagesPath;
@property (nonatomic,copy)NSString * imagePath;

+ (instancetype)shareManger;

@end
