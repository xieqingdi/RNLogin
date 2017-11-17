//
//  RegisterViewController.m
//  rnlogin
//
//  Created by luolili on 2017/11/16.
//  Copyright © 2017年 Facebook. All rights reserved.
//
// react-native bundle --entry-file index.ios.js --bundle-output index.ios.bundle --platform ios --dev false --assets-dest ./

#import "RegisterViewController.h"
#import "SSZipArchive.h"
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"登录";
    [self download];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)download{
  WS(weakself)
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  NSString* unzipfrom = [documentpath stringByAppendingFormat:@"%@%@",@"/",@"rnlogin_jsbundle.zip"];
  [[NSFileManager defaultManager] removeItemAtPath:unzipfrom error:nil];
  [NetRequest NetRequestDownloadWithRequestURL:@"https://wx.lishidiangu.com/uploads/rnlogin_jsbundle.zip" WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
    NSLog(@"returnValue:%@",returnValue);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString* unzipfrom = [documentpath stringByAppendingFormat:@"%@%@",@"/",returnValue];
    
    NSRange range = [returnValue rangeOfString:@"."];
    NSString * result = [returnValue substringToIndex:range.location];
    NSString* unzipto = [documentpath stringByAppendingFormat:@"%@%@",@"/",result];
    
    NSString* jsbundle=[unzipto stringByAppendingFormat:@"%@%@",@"/",@"index.ios.bundle"];
    [[NSFileManager defaultManager] removeItemAtPath:jsbundle error:nil];
    
    NSLog(@"unzipfrom %@",unzipfrom);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
      [SSZipArchive unzipFileAtPath:unzipfrom toDestination:unzipto progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
        NSLog(@"unzipFileAtPath %@", entry);
      } completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
        if(succeeded){
          dispatch_async(dispatch_get_main_queue(),^{
            [weakself initReactModule:result];
          });
        }
      }];
      
    });
    
  } WithErrorCodeBlock:^(id errorCode) {
    
  }];
}
-(void)initReactModule:(NSString*)filename{
  NSLog(@"initReactModule %@", filename);
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  NSString* unzipto = [documentpath stringByAppendingFormat:@"%@%@",@"/",filename];
  
  NSBundle *bundle=[NSBundle bundleWithPath:unzipto];
  NSURL *jsCodeLocation= [bundle URLForResource:@"index.ios" withExtension:@"bundle"];
  NSLog(@"resourcePath %@", [bundle resourcePath]);
  RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                         moduleName:@"rnlogin"
                                  initialProperties:nil
                                      launchOptions:nil];
//  self.view=rootView;
  [self.view addSubview:rootView];
  rootView.frame=self.view.frame;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
