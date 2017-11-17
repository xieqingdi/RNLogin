# RNLogin
A reactive native login demo for iOS , which shows how to dynamic update js bundle from server.

# Requirement
To run the project, you need to install node, React Native, React-Native-cli etc. Please refer to the site of React Native.

# Install node_modules
Run npm install in your command console
``` javascript
npm install
```

# Generate JSBundle
Run the following React-Native-cli command in your command console

``` javascript
react-native bundle --entry-file index.ios.js --bundle-output index.ios.bundle --platform ios --dev false --assets-dest ./
```

It would output an file(index.ios.bundle) and a folder(asset), zip them into a file -- rnlogin_jsbundle.zip for example. And then upload it to your server

# Run it on Xcode with your device
Open rnlogin.xcworkspace in the iOS folder with XCode, modify the remote jsbundle url in RegisterViewController.m and run it. If everything runs successfully, you should get it:

![screenshot](https://github.com/xieqingdi/RNLogin/blob/master/1.png)

# Key Points
It would take 3 steps to finish showing in device.
* Download jsbundle
```object-c
[[NSFileManager defaultManager] removeItemAtPath:unzipfrom error:nil];
  [NetRequest NetRequestDownloadWithRequestURL:@"https://wx.lishidiangu.com/uploads/rnlogin_jsbundle.zip" WithParameter:nil WithReturnValeuBlock:^(id returnValue) {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    NSString* unzipfrom = [documentpath stringByAppendingFormat:@"%@%@",@"/",returnValue];
    
    NSRange range = [returnValue rangeOfString:@"."];
    NSString * result = [returnValue substringToIndex:range.location];
    NSString* unzipto = [documentpath stringByAppendingFormat:@"%@%@",@"/",result];
    
    NSString* jsbundle=[unzipto stringByAppendingFormat:@"%@%@",@"/",@"index.ios.bundle"];
    [[NSFileManager defaultManager] removeItemAtPath:jsbundle error:nil];
    
  } WithErrorCodeBlock:^(id errorCode) {
    
  }];
```
* unzip the downloaded jsbundle to the sandbox
```object-c
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
```
* Create a RCTRootView with the jsbundle and add it to the ViewController
```object-c
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
```
