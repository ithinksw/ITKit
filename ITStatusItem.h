//
//  ITStatusItem.h
//  iThinkAppKit
//
//  Created by Joseph Spiros on Fri Dec 06 2002.
//  Copyright (c) 2002 iThink Software. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface ITStatusItem : NSStatusItem {
    NSStatusItem *statusItem;
}
- (NSStatusItem*) statusItem;
- (NSImage*) alternateImage;
- (void) setAlternateImage:(NSImage*)image;
@end
