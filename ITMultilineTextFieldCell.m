//
//  ITMultilineTextFieldCell.m
//  ITKit
//
//  Created by Joseph Spiros on Fri Mar 05 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "ITMultilineTextFieldCell.h"


@implementation ITMultilineTextFieldCell

- (void)drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    /*
        Okay, here's the different possibilities for the objectValue of this cell, and how they're displayed:
        
            NSArray of NSStrings - Draw first line with System Font, following lines with Small System Font
            NSArray of NSAttributedStrings - Draw as given
            NSArray of both - Draw each line as above!
        
        The number of lines is determined by the contents of the array...
    */
    
    NSColor *defaultColor;
    NSMutableParagraphStyle *paragraphStyle = [[[NSParagraphStyle defaultParagraphStyle] mutableCopy] autorelease];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    NSPoint cellPoint = cellFrame.origin;
    NSSize cellSize = cellFrame.size;
    
    NSRect secondaryLineRect;
    
    if ([self isHighlighted] && ([self highlightColorWithFrame:cellFrame inView:controlView]!=[NSColor secondarySelectedControlColor])) {
        defaultColor = [NSColor whiteColor];
    } else {
        defaultColor = [NSColor blackColor];
    }
    
    // Process the first line...
    {
        NSDictionary *firstLineAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont boldSystemFontOfSize:[NSFont systemFontSize]], NSFontAttributeName, defaultColor, NSForegroundColorAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
        
        NSRect firstLineRect = NSMakeRect(cellPoint.x+5, cellPoint.y+1, cellSize.width-5, cellSize.height);
        
        id firstString = [[self objectValue] objectAtIndex:0];
        NSMutableAttributedString *firstAttrString;
        
        if ([firstString isKindOfClass:[NSAttributedString class]]) {
            firstAttrString = [[[NSMutableAttributedString alloc] initWithAttributedString:firstString] autorelease];
            [firstAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,[firstAttrString length])];
            if ([defaultColor isEqual:[NSColor whiteColor]]) {
            [firstAttrString addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0,[firstAttrString length])];
            }
        } else if ([firstString isKindOfClass:[NSString class]]) {
            firstAttrString = [[[NSMutableAttributedString alloc] initWithString:firstString attributes:firstLineAttributes] autorelease];
        } else {
            firstAttrString = [[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Object (%@) is not a string", firstString] attributes:firstLineAttributes] autorelease];
        }
        
        [controlView lockFocus];
        
        [firstAttrString drawInRect:firstLineRect];
        
        [controlView unlockFocus];
        
        secondaryLineRect = NSMakeRect(cellPoint.x+5, (cellPoint.y+1+[firstAttrString size].height), cellSize.width-5, cellSize.height);
    }
    
    // Process the secondary lines
    {
        NSDictionary *secondaryLineAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[NSFont systemFontOfSize:[NSFont smallSystemFontSize]], NSFontAttributeName, defaultColor, NSForegroundColorAttributeName, paragraphStyle, NSParagraphStyleAttributeName, nil];
        
        NSMutableArray *tMArray = [NSMutableArray arrayWithArray:[self objectValue]];
        [tMArray removeObjectAtIndex:0]; // Remove the first line string... already handled that above!
        
        NSEnumerator *enumerator = [tMArray objectEnumerator];
        id secondaryString;
        
        while (secondaryString = [enumerator nextObject]) {
            
            NSMutableAttributedString *secondaryAttrString;
            
            if ([secondaryString isKindOfClass:[NSAttributedString class]]) {
                secondaryAttrString = [[[NSMutableAttributedString alloc] initWithAttributedString:secondaryString] autorelease];
                [secondaryAttrString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,[secondaryAttrString length])];
                if ([defaultColor isEqual:[NSColor whiteColor]]) {
                [secondaryAttrString addAttribute:NSForegroundColorAttributeName value:defaultColor range:NSMakeRange(0,[secondaryAttrString length])];
                }
            } else if ([secondaryString isKindOfClass:[NSString class]]) {
                secondaryAttrString = [[[NSMutableAttributedString alloc] initWithString:secondaryString attributes:secondaryLineAttributes] autorelease];
            } else {
                secondaryAttrString = [[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Object (%@) is not a string", secondaryString] attributes:secondaryLineAttributes] autorelease];
            }
            
            [controlView lockFocus];
            
            [secondaryAttrString drawInRect:secondaryLineRect];
            
            [controlView unlockFocus];
            
            secondaryLineRect.origin.y = secondaryLineRect.origin.y+[secondaryAttrString size].height; // modify the rect for the next loop, based on the size and location of the most recently processed line.
        
        }
    }
}

@end
