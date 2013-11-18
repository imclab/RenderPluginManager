//
//  SamplePlugin.h
//  RenderPluginManager
//
//  Created by Christopher Baltzer on 11/18/2013.
//

#import <Foundation/Foundation.h>
#import "RenderPluginManager.h"

void _registerPlugin();
void _unregisterPlugin();

@interface SamplePlugin : NSObject<RenderPluginDelegate>

@property (nonatomic, assign) struct UnityRenderingSurface *surface;


@end
