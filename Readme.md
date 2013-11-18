RenderPluginManager
===================

Unity 4.3 introduced a new RenderPluginDelegate protocol which allows native plugins to connect to rendering events. 
However, there are a few problems with their implementation. In particular, neither of the provided delegates are actually 
registered. It's completely fine to set the delegate after Unity has already launched, but you won't have a reference to 
the rendering surface.

RenderPluginManager is a simple extension of the built in `RenderPluginArrayDelegate` implementation. It contains an array
of other delegates, and forwards events to them. The default implementation provides no interface for registering, no 
reference to the rendering surface, and is not automatically set as the delegate. 

This tool exists in an attempt to prevent the RenderPluginDelegate interface from becoming like PostProcessBuildPlayer. 
While there will be far fewer plugins using these delegates, it is still source for conflict. For users, debugging 
conflicting render plugins could be very difficult. Hopefully, other plugins will use this manager to register their 
delegates, and save some of the headache further down the road. 

Contributions and feedback are extremely welcome!

Lifecycle
---------

We use a [category][1] on UnityAppController to add a method to the app startup where we set the delegate. The choice to 
use applicationWillFinishLaunching was mostly arbitrary, but it is not implemented by default and will hopefully not 
conflict with other plugins. 

```objc
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"Injecting RenderPluginManager");
    self.renderDelegate = [RenderPluginManager sharedManager];
 
    return true;
}
```

Now the delegate is set before the engine initializes, so our method to get the rendering surface actually gets 
called:

```objc
- (void)mainDisplayInited:(struct UnityRenderingSurface*)surface {
    ...
}
```

RenderPluginManager keeps a reference to the surface and passes it back to new delegates when they register with it. 


Registration
------------

To register or unregister a delegate with the manager, use these methods:

```objc
-(struct UnityRenderingSurface*)registerDelegate:(id<RenderPluginDelegate>)delegate;
```
> Adds the new delegate to the array. It will start receiving events immediately. Returns a pointer to the rendering 
> surface. As noted in  the documentation, this reference should never change. 

```objc
-(void)unregisterDelegate:(id<RenderPluginDelegate>)delegate;
```
> Removes the specified delegate from the array. It will no longer receive events. 



We've also enabled a define to check if RenderPluginManager is available, just in case. You could use this to check 
whether you should register your delegate directly with UnityAppController or not:

```objc
#define __RENDER_PLUGIN_MANAGER__ 
```


### Example

```objc
void _registerPlugin() {
    pluginInstance = [[SamplePlugin alloc] init];
    pluginInstance.surface = [[RenderPluginManager sharedManager] registerDelegate:pluginInstance];
}
```

Or, if you want, you can also request the surface separately: 

```objc
void _registerPlugin() {
    pluginInstance = [[SamplePlugin alloc] init];
    [[RenderPluginManager sharedManager] registerDelegate:pluginInstance];
    pluginInstance.surface = [[RenderPluginManager sharedManager] getRenderingSurface];
}
```






[1]: https://developer.apple.com/library/ios/documentation/cocoa/conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html
