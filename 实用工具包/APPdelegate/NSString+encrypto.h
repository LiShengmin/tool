//
//  NSString+encrypto.h
//  实用工具包
//
//  Created by Ghoul on 16/1/14.
//  Copyright © 2016年 Ghoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (encrypto)

- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;

+ (NSString *) hmacSha1:(NSString*)key text:(NSString*)text;
- (NSString *)hmacsha1:(NSString *)data secret:(NSString *)key;

@end
