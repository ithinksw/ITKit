/*
 *	ITKit
 *	ITKeyBroadcaster.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

__private_extern__ NSString *ITKeyBroadcasterKeyEvent; //keys: keyCombo as ITKeyCombo

@interface ITKeyBroadcaster : NSButton {

}

+ (long)cocoaModifiersAsCarbonModifiers:(long)cocoaModifiers;

@end