//
//  ITChasingArrowsView.h
//  
//
//  Created by Doug Brown on Sat May 11 2002.
//  Copyright (c) 2002 iThink Software. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface ITChasingArrowsView : NSView {
    BOOL running, inForeground;
    int curIndex;
    NSTimer *timer;
    NSArray *images;
}
- (IBAction)stop:(id)sender;
- (IBAction)start:(id)sender;
@end
