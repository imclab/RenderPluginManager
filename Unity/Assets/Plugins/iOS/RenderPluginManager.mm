//
//  RenderPluginManager.m
//  RenderPluginManager
//
//  Created by Christopher Baltzer on 11/18/2013.
//

#import "RenderPluginManager.h"

@implementation RenderPluginManager



#pragma mark - Setup

+(RenderPluginManager*)sharedManager {
    
    __strong static RenderPluginManager *sharedManager = nil;
    
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedManager = [[RenderPluginManager alloc] init];
    });
    
    return sharedManager;
}


-(id)init {
    
    if (self = [super init]) {
        // Assume we actually want an array, since we're using this
        self.delegateArray = [NSArray array];
    }
    
    return self;
}


-(struct UnityRenderingSurface*)getRenderingSurface {
    return mainDisplaySurface;
}


#pragma mark - Registration

-(struct UnityRenderingSurface*)registerDelegate:(id<RenderPluginDelegate>)delegate {
    
    NSLog(@"RenderPluginManager: Registering delegate: %@", NSStringFromClass([delegate class]));
    
    if ([[delegate class] conformsToProtocol:@protocol(RenderPluginDelegate)]) {
        self.delegateArray = [self.delegateArray arrayByAddingObject:delegate];
    } else {
        NSLog(@"Delegate does not conform to protocol!");
    }
    
    return mainDisplaySurface;
}


-(void)unregisterDelegate:(id<RenderPluginDelegate>)delegate {
    
    NSLog(@"RenderPluginManager: Unregistering delegate: %@", NSStringFromClass([delegate class]));
    
    NSMutableArray *t = [NSMutableArray arrayWithArray:self.delegateArray];
    [t removeObject:delegate];
    
    self.delegateArray = [NSArray arrayWithArray:t];
}



@end
