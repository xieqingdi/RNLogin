//
//  NetRequest.h
//  ProDevForIOS
//
//  Created by 曹亚民 on 16/3/1.
//  Copyright © 2016年 曹亚民. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetRequest : NSObject
#pragma DOWNLOAD请求
+ (void) NetRequestDownloadWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                WithReturnValeuBlock: (ReturnValueBlock) block
                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock;

@end
