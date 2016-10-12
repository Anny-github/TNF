//
//  NERWebImageManager.h
//  Near
//
//  Created by Blues on 12/7/15.
//  Copyright © 2015 QMM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompleteBlock)(UIImage *image);

@interface NERWebImageManager : NSObject

+ (void)imageWithURLString:(NSString *)strURL completeBlock:(CompleteBlock)completeBlock;
+ (void)imageWithURLString:(NSString *)strURL cropSize:(CGSize)cropSize completeBlock:(CompleteBlock)completeBlock;
+ (void)avatarImgWithURLString:(NSString *)strURL cropSize:(CGSize)cropSize completeBlock:(CompleteBlock)completeBlock;

@end
