#import "ITTextFieldCell.h"
#import <ApplicationServices/ApplicationServices.h>
#import "ITCoreGraphicsHacks.h"


/*************************************************************************/
#pragma mark -
#pragma mark IMPLEMENTATION
/*************************************************************************/

@implementation ITTextFieldCell

/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

- (id)initTextCell:(NSString *)string
{
    if ( ( self = [super initTextCell:string] ) ) {
        castsShadow      = NO;
        shadowElevation  = 45.0;
        shadowAzimuth    = 90.0;
        shadowAmbient    = 0.15;
        shadowHeight     = 1.00;
        shadowRadius     = 4.00;
        shadowSaturation = 1.0;
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ( ( self = [super initWithCoder:coder] ) ) {        
        castsShadow      = NO;
        shadowElevation  = 45.0;
        shadowAzimuth    = 90.0;
        shadowAmbient    = 0.15;
        shadowHeight     = 1.00;
        shadowRadius     = 4.00;
        shadowSaturation = 1.0;
    }
    
    return self;
}


/*************************************************************************/
#pragma mark -
#pragma mark DRAWING METHODS
/*************************************************************************/

- (void)drawWithFrame:(NSRect)rect inView:(NSView *)controlView
{
    CGSGenericObj        style = nil;
    CGShadowStyle        shadow;

    if ( castsShadow ) { 
//      Create the shadow style to use for drawing the string
        shadow.version    = 0;
        shadow.elevation  = shadowElevation;
        shadow.azimuth    = shadowAzimuth;
        shadow.ambient    = shadowAmbient;
        shadow.height     = shadowHeight;
        shadow.radius     = shadowRadius;
        shadow.saturation = shadowSaturation;
        style = CGStyleCreateShadow(&shadow);
        
        // Set the context for drawing the string
        [NSGraphicsContext saveGraphicsState];
        CGContextSetStyle([[NSGraphicsContext currentContext] graphicsPort], style);
    }
    
    // Draw the string
    [super drawWithFrame:rect inView:controlView];
    

    if ( castsShadow ) { 
        // Restore the old context
        [NSGraphicsContext restoreGraphicsState];
        CGStyleRelease(style);
    }
}



/*************************************************************************/
#pragma mark -
#pragma mark ACCESSOR METHODS
/*************************************************************************/

- (BOOL)castsShadow;
{
    return castsShadow;
}

- (void)setCastsShadow:(BOOL)newSetting;
{
    castsShadow = newSetting;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowElevation;
{
    return shadowElevation;
}

- (void)setShadowElevation:(float)newElevation;
{
    shadowElevation = newElevation;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowAzimuth;
{
    return shadowAzimuth;
}

- (void)setShadowAzimuth:(float)newAzimuth;
{
    shadowAzimuth = newAzimuth;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowAmbient;
{
    return shadowAmbient;
}

- (void)setShadowAmbient:(float)newAmbient;
{
    shadowAmbient = newAmbient;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowHeight;
{
    return shadowHeight;
}

- (void)setShadowHeight:(float)newHeight;
{
    shadowHeight = newHeight;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowRadius;
{
    return shadowRadius;
}

- (void)setShadowRadius:(float)newRadius;
{
    shadowRadius = newRadius;
    [[self controlView] setNeedsDisplay:YES];
}

- (float)shadowSaturation;
{
    return shadowSaturation;
}

- (void)setShadowSaturation:(float)newSaturation;
{
    shadowSaturation = newSaturation;
    [[self controlView] setNeedsDisplay:YES];
}


@end
