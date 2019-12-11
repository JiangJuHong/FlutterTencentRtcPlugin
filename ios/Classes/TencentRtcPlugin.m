#import "TencentRtcPlugin.h"
#if __has_include(<tencent_rtc_plugin/tencent_rtc_plugin-Swift.h>)
#import <tencent_rtc_plugin/tencent_rtc_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tencent_rtc_plugin-Swift.h"
#endif

@implementation TencentRtcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTencentRtcPlugin registerWithRegistrar:registrar];
}
@end
