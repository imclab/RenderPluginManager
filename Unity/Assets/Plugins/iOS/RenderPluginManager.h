//
//  RenderPluginManager.h
//  RenderPluginManager
//
//  Created by Christopher Baltzer on 11/18/2013.
//

#import <Foundation/Foundation.h>
#import "PluginBase/RenderPluginDelegate.h"

// let other plugins know we exist
#define __RENDER_PLUGIN_MANAGER__ 


@interface RenderPluginManager : RenderPluginArrayDelegate

+(RenderPluginManager*)sharedManager;

-(struct UnityRenderingSurface*)getRenderingSurface;

-(struct UnityRenderingSurface*)registerDelegate:(id<RenderPluginDelegate>)delegate;
-(void)unregisterDelegate:(id<RenderPluginDelegate>)delegate;



@end
