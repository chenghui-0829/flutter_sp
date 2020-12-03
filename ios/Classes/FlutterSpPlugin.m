#import "FlutterSpPlugin.h"
#import "BoUserModel.h"

@implementation FlutterSpPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"io.flutter.plugins/flutter_sp"
            binaryMessenger:[registrar messenger]];
  FlutterSpPlugin* instance = [[FlutterSpPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"get_uid" isEqualToString:call.method]) {
      [self getUid:result];
  } else if ([@"set_uid" isEqualToString:call.method]) {
      [self clearUid:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getUid:(FlutterResult)result {
    BoUserModel *user = [self getCacheUser];
    NSString *uid = @"";
    if (user != nil) {
        uid = user.uid;
    }
    result(uid);
}

- (void)clearUid:(FlutterResult)result {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:[self getCacheFilePath] error:nil];
}

- (NSString *)getCacheFilePath {
    NSString *docDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *dataPath = [docDirectory stringByAppendingString:@"/Data"];
    return [dataPath stringByAppendingPathComponent:@"kLoginUserInfo"];
}

- (BoUserModel *)getCacheUser {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:[self getCacheFilePath]]) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getCacheFilePath]];
}

@end
