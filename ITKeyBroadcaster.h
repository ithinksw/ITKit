/*
 *	ITKit
 *  ITHotKeyBroadcaster
 *
 *  Original Author : Quentin Carnicelli <...>
 *   Responsibility : Kent Sutherland <kent.sutherland@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <AppKit/AppKit.h>


@interface ITKeyBroadcaster : NSButton
{
}

+ (long)cocoaModifiersAsCarbonModifiers: (long)cocoaModifiers;


@end


__private_extern__ NSString* ITKeyBroadcasterKeyEvent; //keys: keyCombo as ITKeyCombo