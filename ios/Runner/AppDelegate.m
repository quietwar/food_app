#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    // Override point for customization after application launch.
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)applicationWillResignActive:(UIApplication *)application{
    [self.window resignKeyWindow];
    self.window.hidden = true;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [self.window makeKeyAndVisible];
    self.window.hidden = false;
}

@end
