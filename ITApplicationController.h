/*
 *	ITKit
 *	ITApplicationController.h
 *
 *	Copyright (c) 2008 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITFoundation/ITFoundation.h>

@class ITApplicationController;

@protocol ITApplicationControllerGenericPlugin <NSObject>
- (id)initWithApplicationController:(ITApplicationController *)applicationController;
@end

@interface ITApplicationController : ITSharedController {
	NSMutableArray *_plugins;
	
	NSMenu *_dockMenu;
	NSMenu *_debugMenu;
	NSMenuItem *_debugMenuItem;
	NSMenuItem *_dockDebugMenuItem;
}

- (void)reloadPlugins;
- (NSArray *)plugins;

- (NSMenu *)dockMenu;
- (NSMenu *)debugMenu;
- (void)enableDebugMenu;
- (void)disableDebugMenu;

@end
