//
//  LoadImage.h
//  WaterfallFlowDemo
//
//  Created by dongliwei on 16/4/20.
//  Copyright © 2016年 Lining. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

typedef void(^DownFinish)();

@interface LoadImage : NSObject
+ (void)loadAnnotationImageWithURL:(NSString*)url imageView:(UIImageView*)imageView finish:(DownFinish)finish;
@end
