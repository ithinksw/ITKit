//
//  ITChasingArrowsView.m
//  
//
//  Created by Doug Brown on Sat May 11 2002.
//  Copyright (c) 2002 iThink Software. All rights reserved.
//

#import "ITChasingArrowsView.h"


@implementation ITChasingArrowsView

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];

    running = NO;

    images = [[decoder decodeObject] retain];

    curIndex = 0;
    timer = nil;
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [super encodeWithCoder:coder];
    
    [coder encodeObject:images];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSBundle *bund = [NSBundle bundleForClass:[self class]];
        running = NO;
        images = [[NSArray alloc] initWithObjects:
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow1.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow2.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow3.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow4.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow5.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow6.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow7.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow8.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow9.tiff"]] autorelease],
            [[[NSImage alloc] initWithContentsOfFile:[bund pathForImageResource:@"ITChasingArrow10.tiff"]] autorelease],
            nil];
        
        curIndex = 0;
        timer = nil;
    }
    return self;
}

- (void)dealloc
{
    if (timer)
    {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    [images release];
    
    [super dealloc];
}
- (void)drawRect:(NSRect)rect {

    if (running)
    {
        NSImage *curImage = [images objectAtIndex:curIndex];
        float amt;
        if (inForeground)
        {
            amt = 1.0;
        }
        else
        {
            amt = 0.5;
        }
        [curImage compositeToPoint:NSMakePoint(0,0) operation:NSCompositeSourceOver fraction:amt];
    }
    else
    {
        // draw nothing.
    }
}

- (IBAction)stop:(id)sender
{
    running = NO;

    if (timer)
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc removeObserver:self];
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    
    [self setNeedsDisplay:YES];
}
    
- (IBAction)start:(id)sender
{
    if (!timer)
    {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(appWentToBackground:) name:NSApplicationWillResignActiveNotification object:nil];
        [nc addObserver:self selector:@selector(appWentToForeground:) name:NSApplicationWillBecomeActiveNotification object:nil];
        [nc addObserver:self selector:@selector(windowWentToBackground:) name:NSWindowDidResignMainNotification object:nil];
        [nc addObserver:self selector:@selector(windowWentToForeground:) name:NSWindowDidBecomeMainNotification object:nil];
        inForeground = ([NSApp isActive] && [[self window] isMainWindow]);
        curIndex = 0;
        running = YES;
        timer = [[NSTimer scheduledTimerWithTimeInterval:0.05
                                                  target:self
                                                selector:@selector(showNewImage:)
                                                userInfo:nil
                                                 repeats:YES] retain];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSEventTrackingRunLoopMode];
    }
}

- (void)showNewImage:(NSTimer *)t
{
    [self setNeedsDisplay:YES];

    if (curIndex == 9)
    {
        curIndex = 0;
    }
    else
    {
        curIndex++;
    }
}

- (void)appWentToBackground:(NSNotification *)note
{
    inForeground = NO;
}

- (void)appWentToForeground:(NSNotification *)note
{
    inForeground = YES;
}

- (void)windowWentToBackground:(NSNotification *)note
{
    NSWindow *window = [note object];
    if (window == [self window])
    {
        inForeground = NO;
    }
}

- (void)windowWentToForeground:(NSNotification *)note
{
    NSWindow *window = [note object];
    if (window == [self window])
    {
        inForeground = YES;
    }
}

@end
