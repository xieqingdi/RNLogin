//
//  NetRequest.m
//  ProDevForIOS
//
//  Created by 曹亚民 on 16/3/1.
//  Copyright © 2016年 曹亚民. All rights reserved.
//

#import "NetRequest.h"
#import "AppDelegate.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "KVNProgress.h"
@implementation NetRequest
+ (void) NetRequestDownloadWithRequestURL: (NSString *) requestURLString
                            WithParameter: (NSDictionary *) parameter
                     WithReturnValeuBlock: (ReturnValueBlock) block
                       WithErrorCodeBlock: (ErrorCodeBlock) errorBlock{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    //manager.securityPolicy.allowInvalidCertificates = YES;
    //[manager.securityPolicy setValidatesDomainName:NO];
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSParameterAssert([appDlg.conn isKindOfClass: [Reachability class]]);
    NetworkStatus status = [appDlg.conn currentReachabilityStatus];
    if (status == NotReachable) {
        [KVNProgress dismiss];
        return;
    }
    NSURL *url=[NSURL URLWithString:requestURLString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [KVNProgress show];
    NSURLSessionDownloadTask *task=[manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [KVNProgress showProgress:downloadProgress.fractionCompleted];
        });
    } destination: ^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
         return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    }
    completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
              [KVNProgress dismiss];
              block(response.suggestedFilename);
    }];
    [task resume];
    
}
@end
