//
//  ITMacResourceFile.h
//  ITKit
//
//  Created by Joseph Spiros on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>
#import "ITMacResource.h"

@interface ITMacResourceFile : NSObject {
    FSRef _fileReference;
    SInt16 _referenceNumber;
}
- (id)initWithContentsOfFile:(NSString *)path;
- (id)initWithContentsOfFile:(NSString *)path fork:(HFSUniStr255)namedFork;

- (ITMacResource *)resourceOfType:(ITMacResourceType)type withID:(NSNumber *)idNum;
- (ITMacResource *)resourceOfType:(ITMacResourceType)type withName:(NSString *)name;
@end
