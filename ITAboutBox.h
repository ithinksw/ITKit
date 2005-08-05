//
//  ITAboutBox.h
//  ITKit
//
//  Created by Kent Sutherland on 8/4/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class ITURLTextField;

@interface ITAboutBox : NSObject
{
	IBOutlet NSImageView *_appIcon;
	IBOutlet NSTextField *_appName;
	IBOutlet NSTextField *_companySite;
	IBOutlet NSTextField *_copyright;
	IBOutlet NSWindow *_window;
}
+ (ITAboutBox *)sharedController;

- (void)setupAboutBox;
- (void)showAboutBox;
- (BOOL)isVisible;
@end
