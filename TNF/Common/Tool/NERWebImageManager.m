//
//  NERWebImageManager.m
//  Near
//
//  Created by Blues on 12/7/15.
//  Copyright © 2015 QMM. All rights reserved.
//

#import "NERWebImageManager.h"
#import "UIImage+Resize.h"

@implementation NERWebImageManager

+ (void)downloadImageWithURLString:(NSString *)strURL completeBlock:(CompleteBlock)completeBlock {
    NSURL *imgURL = [NSURL URLWithString:strURL];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadImageWithURL:imgURL
                          options:SDWebImageHighPriority
                         progress:nil
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                            if (error != nil) {
                                completeBlock(nil);
                            }
                            else {
                                completeBlock(image);
                            }
                        }];
}

+ (void)imageWithURLString:(NSString *)strURL completeBlock:(CompleteBlock)completeBlock {
    NSString *strCacheKey = [strURL stringByAppendingString:@"cache"];
    UIImage *cacheImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:strCacheKey];
    if (cacheImg != nil) {
        completeBlock(cacheImg);
    }
    else {
        [self downloadImageWithURLString:strURL completeBlock:^(UIImage *image) {
            if (image != nil) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:strCacheKey];
            }
            completeBlock(image);
        }];
    }
}

+ (void)imageWithURLString:(NSString *)strURL cropSize:(CGSize)cropSize completeBlock:(CompleteBlock)completeBlock {
    NSString *strCacheKey = [strURL stringByAppendingString:@"cache"];
    UIImage *cacheImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:strCacheKey];
    if (cacheImg != nil) {

        if (ceil(cacheImg.size.width) == ceil(cropSize.width) && ceil(cacheImg.size.height) == ceil(cropSize.height)) {
            completeBlock(cacheImg);
        }
        else if (cacheImg.size.width >= cropSize.width && cacheImg.size.height >= cropSize.height) {
            cacheImg = [cacheImg ellipseImageWithSize:cropSize];
            [[SDImageCache sharedImageCache] storeImage:cacheImg forKey:strCacheKey];
            completeBlock(cacheImg);
        }
        else {
            [self downloadImageWithURLString:strURL completeBlock:^(UIImage *image) {
                if (image != nil) {
                    image = [image ellipseImageWithSize:cropSize];
                    [[SDImageCache sharedImageCache] storeImage:image forKey:strCacheKey];
                }
                completeBlock(cacheImg);
            }];
        }
    }
    else {
        [self downloadImageWithURLString:strURL completeBlock:^(UIImage *image) {
            if (image != nil) {
                image = [image ellipseImageWithSize:cropSize];
                [[SDImageCache sharedImageCache] storeImage:image forKey:strCacheKey];
            }
            completeBlock(image);
        }];
    }
}

+ (void)avatarImgWithURLString:(NSString *)strURL cropSize:(CGSize)cropSize completeBlock:(CompleteBlock)completeBlock {
    NSString *strCacheKey = [strURL stringByAppendingString:@"cache"];
    UIImage *cacheImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:strCacheKey];
    if (cacheImg != nil) {
        if (cacheImg.size.width == cropSize.width && cacheImg.size.height == cropSize.height) {
            completeBlock(cacheImg);
        }
        else if (cacheImg.size.width >= cropSize.width && cacheImg.size.height >= cropSize.height) {
            cacheImg = [cacheImg ellipseImageWithSize:cropSize];
            completeBlock(cacheImg);
        }
        else {
            [self downloadImageWithURLString:strURL completeBlock:^(UIImage *image) {
                if (image != nil) {
                    image = [image ellipseImageWithSize:cropSize];
                    [[SDImageCache sharedImageCache] storeImage:image forKey:strCacheKey];
                }
                completeBlock(cacheImg);
            }];
        }
    }
    else {
        [self downloadImageWithURLString:strURL completeBlock:^(UIImage *image) {
            if (image != nil) {
                image = [image ellipseImageWithSize:cropSize];
                [[SDImageCache sharedImageCache] storeImage:image forKey:strCacheKey];
            }
            completeBlock(image);
        }];
    }
}

@end
