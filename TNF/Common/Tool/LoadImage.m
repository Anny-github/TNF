//
//  LoadImage.m
//  WaterfallFlowDemo
//
//  Created by dongliwei on 16/4/20.
//  Copyright © 2016年 Lining. All rights reserved.
//

#import "LoadImage.h"
#import "UIImage+Resize.h"


@implementation LoadImage

+ (void)loadAnnotationImageWithURL:(NSString*)url imageView:(UIImageView*)imageView finish:(DownFinish)finish
{
    //将合成后的图片缓存起来
    NSString *annoImageURL = url;
    NSString *annoImageCacheURL = [annoImageURL stringByAppendingString:[NSString stringWithFormat:@"/%.2f/cache",imageView.frame.size.width]];

//    NSString *annoImageCacheURL = [annoImageURL stringByAppendingString:@"cache"];
    
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:annoImageCacheURL];
    if ( cacheImage )
    {
        imageView.image = cacheImage;
    }
    else
    {
        //LLLog(@"no cache");
        [imageView sd_setImageWithURL:[NSURL URLWithString:annoImageURL]
                     placeholderImage:nil
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (!error)
                                {
                                    UIImage *annoImage = [image ellipseImageWithSize:imageView.size];
                                    imageView.image = annoImage;
                                    
                                    [[SDImageCache sharedImageCache] storeImage:annoImage forKey:annoImageCacheURL];
                                    finish();
                                }
                            }];
    }
}
@end
