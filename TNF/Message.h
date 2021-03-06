//
//  Message.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    MessageTypeMe = 0, // 自己发的
    MessageTypeOther = 1 //别人发得
    
} MessageType;


typedef enum {
    
    Content = 0, // 文字
    ContentMP3 = 1 //MP3
    
} ContentType;


@interface Message : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *mp3;
@property (nonatomic, assign)MessageType type;
@property(nonatomic,assign) ContentType contentType;
@property (nonatomic, copy) NSDictionary *dict;

@end
