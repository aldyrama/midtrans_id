#import "MidtransIdPlugin.h"
#if __has_include(<midtrans_id/midtrans_id-Swift.h>)
#import <midtrans_id/midtrans_id-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "midtrans_id-Swift.h"
#endif

@implementation MidtransIdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMidtransIdPlugin registerWithRegistrar:registrar];
}
@end
