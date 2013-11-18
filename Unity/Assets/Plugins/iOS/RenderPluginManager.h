//
//  RenderPluginManager.h
//  RenderPluginManager
//
//  Created by Christopher Baltzer on 11/18/2013.
//  Copyright (c) 2013 Scarlet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PluginBase/RenderPluginDelegate.h"

@interface RenderPluginManager : RenderPluginArrayDelegate

+(RenderPluginManager*)sharedManager;

-(struct UnityRenderingSurface*)registerDelegate:(id<RenderPluginDelegate>)delegate;
-(void)unregisterDelegate:(id<RenderPluginDelegate>)delegate;



@end
