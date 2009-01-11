/*
 *	ITKit
 *	ITKeyBroadcaster.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

__private_extern__ NSString *ITKeyBroadcasterKeyEvent; //keys: keyCombo as ITKeyCombo

@interface ITKeyBroadcaster : NSButton {

}

+ (long)cocoaModifiersAsCarbonModifiers:(long)cocoaModifiers;

@end