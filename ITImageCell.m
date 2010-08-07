#import "ITImageCell.h"
#import <ApplicationServices/ApplicationServices.h>
#import <ITFoundation/ITFoundation.h>

@implementation ITImageCell

- (id)initImageCell:(NSImage *)image {
	if ((self = [super initImageCell:image])) {
		_scalesSmoothly = YES;
		castsShadow = NO;
		shadowAzimuth = 90.0;
		shadowAmbient = 0.15;
		shadowHeight = 1.00;
		shadowRadius = 4.00;
	}
	return self;
}

- (id)init {
	if ((self = [super init])) {
		_scalesSmoothly = YES;
		castsShadow = NO;
		shadowAzimuth = 90.0;
		shadowAmbient = 0.15; // In my tests, an alpha component of 0.85 perfectly duplicates the old private API's results, resulting in identical shadows. Therefore, the ambient can remain 0.15.
		shadowHeight = 1.00;
		shadowRadius = 4.00;
	}
	return self;
}

- (void)drawWithFrame:(NSRect)rect inView:(NSView *)controlView {
	NSShadow *shadow;
	
	if (_scalesSmoothly || castsShadow) {
		[NSGraphicsContext saveGraphicsState];
	}
	
	if (_scalesSmoothly) {
		[[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
		[[NSGraphicsContext currentContext] setShouldAntialias:YES];
	}
	
	if (castsShadow) {
		CGFloat height = ((2.0*tan((M_PI/360.0)*(shadowAzimuth-180.0)))*shadowHeight)/(1.0+pow(tan((M_PI/360.0)*(shadowAzimuth-180.0)),2.0));
		CGFloat width = sqrt(pow(shadowHeight, 2.0)-pow(height, 2.0));
		
		shadow = [[NSShadow alloc] init];
		[shadow setShadowColor:[[NSColor blackColor] colorWithAlphaComponent:(1.0 - shadowAmbient)]]; 
		[shadow setShadowOffset:NSMakeSize(width, height)];
		[shadow setShadowBlurRadius:shadowRadius];
		
		[shadow set];
	}
	
	[super drawWithFrame:rect inView:controlView];
	
	if (_scalesSmoothly || castsShadow) {
		[NSGraphicsContext restoreGraphicsState];
	}
	
	if (castsShadow) {
		[shadow release];
	}
}

- (BOOL)scalesSmoothly {
	return _scalesSmoothly;
}

- (void)setScalesSmoothly:(BOOL)flag {
	_scalesSmoothly = flag;
	[[self controlView] setNeedsDisplay:YES];
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
	ITDebugLog(@"setShadowElevation: on ITImageCell objects does nothing.");
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
	ITDebugLog(@"setShadowSaturation: on ITImageCell objects does nothing.");
}

@end