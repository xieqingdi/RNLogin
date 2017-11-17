//
//  HttpRequest.m
//  ProDevForIOS
//
//  Created by 曹亚民 on 16/2/19.
//  Copyright © 2016年 曹亚民. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

/*+ (HttpRequest *)sharedManager{
    static HttpRequest *sharedRequestInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedRequestInstance = [[self alloc] init];
    });
    return sharedRequestInstance;
}

-(void)sendUrlByUrlSession:(HTTP_METHOD )type Url:(NSString *)neturl Paramters:(NSDictionary *)parameters Success:(void(^)(NSData*))block Fail:(void(^)(NSString*))fail{
    if(neturl==nil){
        fail(@"url cannot be null");
    }
    AppDelegate *appDlg = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSParameterAssert([appDlg.conn isKindOfClass: [Reachability class]]);
    NetworkStatus status = [appDlg.conn currentReachabilityStatus];
    if (status == NotReachable) {
        fail(@"No Network");
        return;
    }
    NSURL *URL=[NSURL URLWithString:neturl];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
    if(request==nil){
        fail(@"Request is nil");
        return;
    }
    [KVNProgress show];
    [KVNProgress showWithStatus:@"加载中..."];
    if(type==GET){
        if(parameters){
            neturl=[neturl stringByAppendingFormat:@"%@%@",@"?",[self serializeParams:parameters]];
            URL=[NSURL URLWithString:neturl];
        }
        [request setHTTPMethod:@"GET"];
    }else if(type==POST){
        NSData *data=[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:data];
    }else{
    }
    NSURLSession *session=[NSURLSession sharedSession];
    _dataTask=[session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            fail([NSString stringWithFormat:@"%@",error]);
        }else{
            //NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            block(data);
        }
        [KVNProgress dismiss];
    }];
    [_dataTask resume];
}

- (NSString *)serializeParams:(NSDictionary *)params {
    NSMutableArray *pairs = NSMutableArray.array;
    for (NSString *key in params.keyEnumerator) {
        id value = params[key];
        if ([value isKindOfClass:[NSDictionary class]])
            for (NSString *subKey in value)
                [pairs addObject:[NSString stringWithFormat:@"%@[%@]=%@", key, subKey, [self escapeValueForURLParameter:[value objectForKey:subKey]]]];
        
        else if ([value isKindOfClass:[NSArray class]])
            for (NSString *subValue in value)
                [pairs addObject:[NSString stringWithFormat:@"%@[]=%@", key, [self escapeValueForURLParameter:subValue]]];
        else
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, [self escapeValueForURLParameter:value]]];
    }
    return [pairs componentsJoinedByString:@"&"];
}

- (NSString *)escapeValueForURLParameter:(NSString *)valueToEscape {
    return (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef) valueToEscape,
                                          NULL, (CFStringRef) @"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}*/

@end
