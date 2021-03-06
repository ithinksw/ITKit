/*
 *	ITKitShowcase
 *	Controller.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITKit/ITKit.h>

@interface Controller : NSObject {
    IBOutlet NSWindow *window;
    
    // ITStatusItem Support
    ITStatusItem      *statusItem;
    IBOutlet NSMenu   *statusItemMenu;
    IBOutlet NSButton *showStatusItemCheckBox;
    IBOutlet NSButton *showImageCheckBox;
    IBOutlet NSButton *useInvertedCheckBox;
    IBOutlet NSButton *showTitleCheckBox;
    
    // ITButton Support
    IBOutlet ITButton *button;
    
    // ITTabView Support
    IBOutlet ITTabView *tabView;

    // ITBevelView support
    IBOutlet ITBevelView *bevelView;

    // ITTextField Support
    IBOutlet ITTextField *testTextField;

    // ITTransientStatusWindow Support
    IBOutlet NSPopUpButton      *entryEffectPopup;
    IBOutlet NSPopUpButton      *exitEffectPopup;
    ITIconAndTextStatusWindow   *statusWindow;
    IBOutlet NSTextView         *swSampleTextView;
    IBOutlet NSPopUpButton      *swVanishModePopup;
    IBOutlet NSPopUpButton      *swBackgroundTypePopup;
    IBOutlet NSPopUpButton      *swDefinedPositionPopup;
    IBOutlet NSTextField        *swVanishDelay;
    IBOutlet NSTextField        *swShadowSaturation;
    IBOutlet NSSlider           *swEntrySpeedSlider;
    IBOutlet NSSlider           *swExitSpeedSlider;
    
    // ITMultilineTextFieldCell Support
    IBOutlet NSTableView        *tableView;
}

// ITStatusItem Support
- (IBAction)toggleStatusItem:(id)sender;
- (IBAction)toggleImage:(id)sender;
- (IBAction)toggleInvertedImage:(id)sender;
- (IBAction)toggleTitle:(id)sender;

// ITTextField Support
- (IBAction)toggleCastsShadow:(id)sender;

// ITTransientStatusWindow Support
- (void)populateEffectPopups;
- (IBAction)buildStatusWindow:(id)sender;
- (IBAction)toggleStatusWindow:(id)sender;
- (IBAction)changeWindowSetting:(id)sender;

// ITTabView support
- (IBAction)toggleTabDragging:(id)sender;
- (IBAction)toggleCommandDragging:(id)sender;
- (IBAction)toggleControlDragging:(id)sender;
- (IBAction)toggleOptionDragging:(id)sender;
- (IBAction)toggleShiftDragging:(id)sender;

// ITBevelView support
- (IBAction)changeBevelViewSetting:(id)sender;

@end
