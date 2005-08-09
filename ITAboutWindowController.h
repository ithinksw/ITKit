/*
 *	ITKit
 *	ITAboutWindowController.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITAboutWindowController : NSObject
{
	IBOutlet NSImageView *_appIcon;
	IBOutlet NSTextField *_appName;
	IBOutlet NSTextField *_companySite;
	IBOutlet NSTextField *_copyright;
	IBOutlet NSWindow *_window;
}
+ (ITAboutWindowController *)sharedController;

- (void)setupAboutWindow;
- (void)showAboutWindow;
- (BOOL)isVisible;
@end