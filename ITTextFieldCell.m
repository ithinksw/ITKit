#import "ITTextFieldCell.h"
#import <ApplicationServices/ApplicationServices.h>
#import <ITFoundation/ITFoundation.h>

@implementation ITTextFieldCell

- (id)initTextCell:(NSString *)string {
	if ((self = [super initTextCell:string])) {
		castsShadow = NO;
		shadowAzimuth = 90.0;
		shadowAmbient = 0.0;
		shadowHeight = 1.00;
		shadowRadius = 4.00;
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder])) {		
		castsShadow = NO;
		shadowAzimuth = 90.0;
		shadowAmbient = 0.0; // Unlike ITImageCell, even an alpha component of 1.0 is ligher than the old private API's results. There's not much we can do about it as we can't go "blacker" than black.
		shadowHeight = 1.00;
		shadowRadius = 4.00;
	}
	return self;
}

- (void)drawWithFrame:(NSRect)rect inView:(NSView *)controlView {
	NSShadow *shadow;
	
	if (castsShadow) {
		CGFloat height = ((2.0*tan((M_PI/360.0)*(shadowAzimuth-180.0)))*shadowHeight)/(1.0+pow(tan((M_PI/360.0)*(shadowAzimuth-180.0)),2.0));
		CGFloat width = sqrt(pow(shadowHeight, 2.0)-pow(height, 2.0));
		
		shadow = [[NSShadow alloc] init];
		[shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:(1.0 - shadowAmbient)]];
		[shadow setShadowOffset:NSMakeSize(width, height)];
		[shadow setShadowBlurRadius:shadowRadius];
		
		[NSGraphicsContext saveGraphicsState];
		[shadow set];
	}
	
	// Draw the string
	[super drawWithFrame:rect inView:controlView];
	
	if (castsShadow) { 
		// Restore the old context
		[NSGraphicsContext restoreGraphicsState];
		[shadow release];
	}
}

- (BOOL)castsShadow {
	return castsShadow;
}

- (void)setCastsShadow:(BOOL)newSetting {
	castsShadow = newSetting;
	[[self controlView] setNeedsDisplay:YES];
}

- (float)shadowElevation {
	return 45.0;
}

- (void)setShadowElevation:(float)newElevation {
	ITDebugLog(@"setShadowElevation: on ITTextFieldCell objects does nothing.");
}

- (float)shadowAzimuth {
	return shadowAzimuth;
}

- (void)setShadowAzimuth:(float)newAzimuth {
	shadowAzimuth = newAzimuth;
	[[self controlView] setNeedsDisplay:YES];
}

- (float)shadowAmbient {
	return shadowAmbient;
}

- (void)setShadowAmbient:(float)newAmbient {
	shadowAmbient = newAmbient;
	[[self controlView] setNeedsDisplay:YES];
}

- (float)shadowHeight {
	return shadowHeight;
}

- (void)setShadowHeight:(float)newHeight {
	shadowHeight = newHeight;
	[[self controlView] setNeedsDisplay:YES];
}

- (float)shadowRadius {
	return shadowRadius;
}

- (void)setShadowRadius:(float)newRadius {
	shadowRadius = newRadius;
	[[self controlView] setNeedsDisplay:YES];
}

- (float)shadowSaturation {
	return 1.0;
}

- (void)setShadowSaturation:(float)newSaturation {
	ITDebugLog(@"setShadowSaturation: on ITTextFieldCell objects does nothing.");
}

@end