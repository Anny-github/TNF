//
//  UIImage+Resize.h
//  Near
//
//  Created by gdy on 15/11/3.
//  Copyright © 2015年 QMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

-(UIImage*)cropImageWithSize:(CGSize)size;

-(UIImage*)roundImageWithSize:(CGSize)size;

-(UIImage*)ellipseImageWithSize:(CGSize)size ;

@end
