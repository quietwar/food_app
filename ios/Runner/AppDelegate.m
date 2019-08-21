#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}



// - (BOOL)application:(UIApplication *)app
//             openURL:(NSURL *)url
//             options:(NSDictionary<NSString *, id> *)options {
//   return [[GIDSignIn sharedInstance] handleURL:url
//                              sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
//                                     annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
// }
@end