//
//  UnityAppController+RPM.m
//  Unity-iPhone
//
//  Created by Christopher Baltzer on 11/18/2013.
//
//

#import "UnityAppController+RPM.h"


@implementation UnityAppController (RPM)

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"Injecting RenderPluginManager");
    self.renderDelegate = [RenderPluginManager sharedManager];
    
    return true;
}

@end
