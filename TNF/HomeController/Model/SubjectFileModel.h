//
//  SubjectFileModel.h
//  TNF
//
//  Created by dongliwei on 16/4/22.
//  Copyright © 2016年 刘翔. All rights reserved.
/**
 *  题目素材
 id 素材ID
 title素材标题
 thumb素材图片
 
 */

#import <JSONModel/JSONModel.h>

@interface SubjectFileModel : JSONModel

@property(nonatomic,copy)NSString *ID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *thumb;

@end
