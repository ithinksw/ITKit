//
//  ITStatusItem.m
//  iThinkAppKit
//
//  Created by Joseph Spiros on Fri Dec 06 2002.
//  Copyright (c) 2002 iThink Software. All rights reserved.
//

#import "ITStatusItem.h"


@implementation ITStatusItem

- (id)initWithStatusBar:(NSStatusBar*)statusBar withLength:(float)length {
    statusItem = [statusBar statusItemWithLength:length];
}

- (NSStatusItem*) statusItem {
    return statusItem;
}

- (NSImage*) alternateImage {
    return [[statusItem _button] alternateImage];
}

- (void) setAlternateImage:(NSImage*)image {
    if ([[[[statusItem _button] cell] super] type] != 0) {
        [[[statusItem _button] cell] setType:0];
    }
    [[statusItem _button] setAlternateImage:image];
}

@end
