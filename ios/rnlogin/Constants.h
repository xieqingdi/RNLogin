//
//  Constants.h
//  rnlogin
//
//  Created by luolili on 2017/11/16.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^ErrorCodeBlock) (id errorCode);
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#endif /* Constants_h */
