//
//  ITWindowEffect.m
//  ITKit
//
//  Created by Matt L. Judy on Sat Mar 01 2003.
//  Copyright (c) 2003 NibFile.com. All rights reserved.
//

#import "ITWindowEffect.h"


@implementation ITWindowEffect


- (id)initWithWindow:(NSWindow *)window
{
    _window = window;
}

- (NSWindow *)window
{
    return _window;
}

- (void)setWindow:(NSWindow *)newWindow
{
    _window = newWindow;
}

- (void)performAppear
{
    NSLog("ITWindowEffect does not implement performAppear.");
}

- (void)performVanish
{
    NSLog("ITWindowEffect does not implement performVanish.");
}


@end
