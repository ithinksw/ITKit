//
//  ITSplashView.m
//  SplashScreen
//
//  Created by Kent Sutherland on 11/22/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import "ITSplashView.h"

@implementation ITSplashView

- (id)initWithFrame:(NSRect)frame
{
    if ( (self = [super initWithFrame:frame]) ) {
    }
    return self;
}

- (void)dealloc
{
	[_image release];
	[_progress release];
	[_text release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect
{
	[_image compositeToPoint:NSZeroPoint operation:NSCompositeSourceOver];
}

- (BOOL)isOpaque
{
	return NO;
}

- (void)stopAnimation
{
	[_progress stopAnimation:nil];
}

- (NSProgressIndicator *)progressIndicator
{
	return _progress;
}

- (NSImage *)image
{
	return _image;
}

- (NSString *)string
{
	return [_text stringValue];
}

- (void)setImage:(NSImage *)image
{
	[_image autorelease];
	_image = [image retain];
}

- (void)setString:(NSString *)text
{
	[_text setStringValue:text];
}

- (void)loadControlsFromPath:(NSString *)path
{
	[_progress removeFromSuperview];
	[_progress release];
	[_text removeFromSuperview];
	[_text release];
	//Reset the controls
	NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:path];
	int height = [[settings objectForKey:@"ProgressIndicator.thickness"] intValue];
	NSControlSize size;
	switch (height) {
		/*case NSProgressIndicatorPreferredSmallThickness:
			size = NSMiniControlSize;
		break;*/
		case NSProgressIndicatorPreferredAquaThickness:
			size = NSSmallControlSize;
		break;
		case NSProgressIndicatorPreferredThickness:
		default:
			size = NSRegularControlSize;
		break;
	}
	if ([[settings objectForKey:@"ProgressIndicator.style"] intValue] == 0) {
		//We have a normal bar
		_progress = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect([[settings objectForKey:@"ProgressIndicator.x"] intValue], [[settings objectForKey:@"ProgressIndicator.y"] intValue], [[settings objectForKey:@"ProgressIndicator.size"] intValue], height)];
		[_progress setStyle:NSProgressIndicatorBarStyle];
		[_progress setControlSize:size];
		[_progress setIndeterminate:NO];
		[_progress setMaxValue:100.0];
		[_progress setMinValue:0.0];
	} else {
		//We have a spinner thinger
		_progress = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect([[settings objectForKey:@"ProgressIndicator.x"] intValue], [[settings objectForKey:@"ProgressIndicator.y"] intValue], [[settings objectForKey:@"ProgressIndicator.size"] intValue], [[settings objectForKey:@"ProgressIndicator.size"] intValue])];
		[_progress setStyle:NSProgressIndicatorSpinningStyle];
		[_progress setControlSize:size];
	}
	[self addSubview:_progress];
	[_progress startAnimation:nil];
	
	_text = [[NSTextField alloc] initWithFrame:NSMakeRect([[settings objectForKey:@"StatusText.x"] intValue], [[settings objectForKey:@"StatusText.y"] intValue], [[settings objectForKey:@"StatusText.width"] intValue], 22)];
	[_text setEditable:NO];
	[_text setSelectable:NO];
	[_text setBezeled:NO];
	[_text setDrawsBackground:NO];
	[self addSubview:_text];
	
	[settings release];
}

@end
