//
//  ITKeyBroadcaster.h
//
//  Created by Quentin Carnicelli on Sun Aug 03 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

#import <AppKit/AppKit.h>


@interface ITKeyBroadcaster : NSButton
{
}

+ (long)cocoaModifiersAsCarbonModifiers: (long)cocoaModifiers;

@end

__private_extern__ NSString* ITKeyBroadcasterKeyEvent; //keys: keyCombo as ITKeyCombo