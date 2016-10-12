//
//  UIImage+Resize.m
//  Near
//
//  Created by gdy on 15/11/3.
//  Copyright © 2015年 QMM. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

-(UIImage*)cropImageWithSize:(CGSize)size{
    UIView *snapshotView = nil;
    UIImageView *imageView = nil;
    
    if ( !snapshotView )
    {
        snapshotView = [UIView new];
        snapshotView.frame = CGRectMake(0, 0, size.width, size.height);
        
        imageView = [UIImageView new];
        [snapshotView addSubview:imageView];
        imageView.clipsToBounds = YES;
        imageView.frame = snapshotView.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
//        CGPathAddRoundedRect(path, NULL, imageView.bounds, size.width/2, size.height/2);//圆角矩形
        CGPathAddRect(path, NULL, imageView.bounds);
        //        CGPathCloseSubpath(path);
        
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        shapelayer.frame = imageView.bounds;
        shapelayer.path = path;
        
        imageView.layer.mask = shapelayer;
        
        CGPathRelease(path);
    }
    
    imageView.image = self;
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    [snapshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copied;
}

//圆角图片
-(UIImage*)roundImageWithSize:(CGSize)size{
    UIView *snapshotView = nil;
    UIImageView *imageView = nil;
    
    if ( !snapshotView )
    {
        snapshotView = [UIView new];
        snapshotView.frame = CGRectMake(0, 0, size.width, size.height);
        
        imageView = [UIImageView new];
        [snapshotView addSubview:imageView];
        imageView.clipsToBounds = YES;
        imageView.frame = snapshotView.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGMutablePathRef path = CGPathCreateMutable();
        
        CGPathAddRoundedRect(path, NULL, imageView.bounds, size.width/2, size.height/2);//圆角矩形
        //        CGPathCloseSubpath(path);
        
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        shapelayer.frame = imageView.bounds;
        shapelayer.path = path;
        
        imageView.layer.mask = shapelayer;
        
        CGPathRelease(path);
    }
    
    imageView.image = self;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [snapshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copied;
}

-(UIImage*)ellipseImageWithSize:(CGSize)size{
    
    CGFloat shortS = size.width > size.height ? size.height:size.width;
    size = CGSizeMake(shortS, shortS);
    UIView *snapshotView = nil;
    UIImageView *imageView = nil;
    
    if ( !snapshotView )
    {
        snapshotView = [UIView new];
        snapshotView.frame = CGRectMake(0, 0, size.width, size.height);
        
        imageView = [UIImageView new];
        [snapshotView addSubview:imageView];
        imageView.clipsToBounds = YES;
        imageView.frame = snapshotView.bounds;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRoundedRect(path, NULL, imageView.bounds, size.width/2, size.height/2);//圆角矩形
        
        CAShapeLayer *shapelayer = [CAShapeLayer layer];
        shapelayer.frame = imageView.bounds;
        shapelayer.path = path;
        
        imageView.layer.mask = shapelayer;
        
        CGPathRelease(path);
    }
    
    imageView.image = self;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    [snapshotView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copied;
}

@end
