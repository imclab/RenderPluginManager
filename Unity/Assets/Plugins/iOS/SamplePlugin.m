//
//  SamplePlugin.m
//  RenderPluginManager
//
//  Created by Christopher Baltzer on 11/18/2013.
//

#import "SamplePlugin.h"
#import "GlesHelper.h"

static SamplePlugin *pluginInstance;

void _registerPlugin() {
    pluginInstance = [[SamplePlugin alloc] init];
    pluginInstance.surface = [[RenderPluginManager sharedManager] registerDelegate:pluginInstance];
}

void _unregisterPlugin() {
    [[RenderPluginManager sharedManager] unregisterDelegate:pluginInstance];
    [pluginInstance release];
    pluginInstance = nil;
}


@implementation SamplePlugin

-(void)mainDisplayInited:(struct UnityRenderingSurface *)surface {
    NSLog(@"%s \n- %@", __PRETTY_FUNCTION__, @"This never gets called because it only happens at startup..");
}

-(void)onFrameResolved {
    NSLog(@"%@ %s - Target FB: %d", @"SamplePlugin", __PRETTY_FUNCTION__, self.surface->targetFB);
}

@end
