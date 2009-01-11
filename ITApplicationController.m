#import "ITApplicationController.h"
#import "ITCategory-NSApplication.h"

@implementation ITApplicationController

- (id)init {
	if (self = [super init]) {
		if ([[NSUserDefaults standardUserDefaults] boolForKey:@"ITDebugMode"]) {
			SetITDebugMode(YES);
		}
		
		_plugins = nil;
		
		_dockMenu = [[NSMenu alloc] initWithTitle:[[NSApplication sharedApplication] applicationName]];
		
		_debugMenu = [[NSMenu alloc] initWithTitle:@"Debug"];
		_debugMenuItem = [[NSMenuItem alloc] initWithTitle:@"Debug" action:nil keyEquivalent:@""];
		[_debugMenuItem setSubmenu:_debugMenu];
		_dockDebugMenuItem = [[NSMenuItem alloc] initWithTitle:@"Debug" action:nil keyEquivalent:@""];
		[_dockDebugMenuItem setSubmenu:_debugMenu];
	}
	return self;
}

- (void)reloadPlugins {
	if (_plugins) {
		[_plugins release];
	}
	
	_plugins = [[NSMutableArray alloc] init];
	
	NSArray *pluginPaths = [NSBundle pathsForResourcesOfType:@"plugin" inDirectory:[[NSBundle mainBundle] builtInPlugInsPath]];
	NSEnumerator *pluginPathEnumerator = [pluginPaths objectEnumerator];
	id pluginPath;
	
	while (pluginPath = [pluginPathEnumerator nextObject]) {
		NSBundle *plugin = [NSBundle bundleWithPath:pluginPath];
		if ([plugin load]) {
			Class pluginClass = [plugin principalClass];
			id pluginInstance;
			if ([pluginClass instancesRespondToSelector:@selector(initWithApplicationController:)]) {
				pluginInstance = [(id <ITApplicationControllerGenericPlugin>)[pluginClass alloc] initWithApplicationController:self];
			} else {
				pluginInstance = [[pluginClass alloc] init];
			}
			if (pluginInstance) {
				[_plugins addObject:[pluginInstance autorelease]]; // autoreleasing so that when we reload plugins, and the _plugins array is released, the accompanying previously-loaded plugins die with it.
			}
		}
	}
}

- (NSArray *)plugins {
	return _plugins;
}

- (NSMenu *)dockMenu {
	return _dockMenu;
}

- (NSMenu *)debugMenu {
	return _debugMenu;
}

- (void)enableDebugMenu {
	NSMenu *mainMenu = [[NSApplication sharedApplication] mainMenu];
	int helpIndex = [mainMenu indexOfItemWithTitle:@"Help"];
	if (helpIndex != -1) {
		[mainMenu insertItem:_debugMenuItem atIndex:helpIndex];
	} else {
		[mainMenu addItem:_debugMenuItem];
	}
	
	[_dockMenu insertItem:_dockDebugMenuItem atIndex:0];
	if ([_dockMenu numberOfItems] > 1) {
		[_dockMenu insertItem:[NSMenuItem separatorItem] atIndex:1];
	}
}

- (void)disableDebugMenu {
	[[[NSApplication sharedApplication] mainMenu] removeItem:_debugMenuItem];
	[_dockMenu removeItem:_dockDebugMenuItem];
	if ([_dockMenu numberOfItems] > 1) {
		NSMenuItem *sep = [_dockMenu itemAtIndex:0];
		if ([sep isSeparatorItem]) {
			[_dockMenu removeItem:sep];
		}
	}
}

- (void)dealloc {
	[_dockDebugMenuItem release];
	[_debugMenuItem release];
	[_debugMenu release];
	[_dockMenu release];
	[super dealloc];
}

- (NSMenu *)applicationDockMenu:(NSApplication *)sender {
	return _dockMenu;
}

@end
