//
//  ITMacResource.m
//  ITKit
//
//  Created by Joseph Spiros on Thu Dec 25 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ITMacResource.h"


@implementation ITMacResource

static NSMutableDictionary *_resourceTypeClasses = nil;

+ (void)_registerClass:(Class)class forType:(ITMacResourceType)type {
    if (!_resourceTypeClasses) {
        _resourceTypeClasses = [[NSMutableDictionary dictionary] retain];
    }
    [_resourceTypeClasses setObject:class forKey:[NSString stringWithCString:(char *)type]];
}

+ (Class)_classForType:(ITMacResourceType)type {
    Class _class = [_resourceTypeClasses objectForKey:[NSString stringWithCString:(char *)type]];
    return ((_class == nil) ? [ITMacResource class] : _class);
}

+ (id)_resourceWithHandle:(Handle)handle { // THIS *WILL* RETURN A MORE SPECIFIC INSTANCE USING THE REGISTRATION DATABASE IF SUCH A CLASS EXISTS
    return [[[self alloc] _initWithHandle:handle] autorelease];
}

- (id)_initWithHandle:(Handle)handle {
    if (self = [super init]) {
        _handle = handle;
    }
    return self;
}

- (Handle)_handle {
    return _handle;
}

- (NSData *)data {
    NSData *_data;
    HLock(_handle);
    _data = [NSData dataWithBytes:(*_handle) length:GetHandleSize(_handle)];
    HUnlock(_handle);
    return _data;
}

- (ITMacResourceType)type {
    short _id;
    ResType _type;
    Str255 _name;
    GetResInfo(_handle, &_id, &_type, _name);
    return (ITMacResourceType)_type;
}

- (NSNumber *)id {
    short _id;
    ResType _type;
    Str255 _name;
    GetResInfo(_handle, &_id, &_type, _name);
    return [NSNumber numberWithShort:_id];
}

- (NSString *)name {
    short _id;
    ResType _type;
    Str255 _name;
    GetResInfo(_handle, &_id, &_type, _name);
    return [(NSString*)CFStringCreateWithPascalString(NULL, 
_name, kCFStringEncodingMacRomanLatin1) autorelease];
}

- (Class)nativeRepresentationClass {
    return nil;
}

- (id)nativeRepresentation {
    return nil;
}

- (void)dealloc {
    ReleaseResource(_handle);
    [super dealloc];
}

@end
