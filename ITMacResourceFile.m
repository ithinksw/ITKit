//
//  ITMacResourceFile.m
//  ITKit
//
//  Created by Joseph Spiros on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ITMacResourceFile.h"


@implementation ITMacResourceFile

- (id)initWithContentsOfFile:(NSString *)path {
    HFSUniStr255 dataForkName;
    FSGetDataForkName(&dataForkName);
    return [self initWithContentsOfFile:path fork:dataForkName];
}

- (id)initWithContentsOfFile:(NSString *)path fork:(HFSUniStr255)namedFork {
    if (self = [super init]) {
        if (FSPathMakeRef([path fileSystemRepresentation],&_fileReference,NULL) == noErr) {
            FSOpenResourceFile(&_fileReference, namedFork.length, namedFork.unicode, fsRdPerm, &_referenceNumber);
        } else {
            // Raise Exception!
        }
    }
    return self;
}

- (ITMacResource *)resourceOfType:(ITMacResourceType)type withID:(NSNumber *)idNum {
    return [[ITMacResource _classForType:type] _resourceWithHandle:GetResource((ResType)type,[idNum shortValue])];
}

- (ITMacResource *)resourceOfType:(ITMacResourceType)type withName:(NSString *)name {
    Str255 _buffer;
    StringPtr _ptr = CFStringGetPascalStringPtr((CFStringRef)name, kCFStringEncodingMacRomanLatin1);
    if (_ptr == NULL) {
        if (CFStringGetPascalString((CFStringRef)name, _buffer, 256, kCFStringEncodingMacRomanLatin1)) {
            _ptr = _buffer;
        } else {
            // Raise exception!
        }
    }
    return [[ITMacResource _classForType:type] _resourceWithHandle:GetNamedResource((ResType)type,_ptr)];
}

- (void)dealloc {
    CloseResFile(_referenceNumber);
    [super dealloc];
}

@end
