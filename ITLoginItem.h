/*
 *	ITKit
 *	ITLoginItem.h
 *
 *	Functions for adding applications to the user's list of applications that
 *		are automatically launched on login.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

//These functions check for a match with just the lastPathComponent, so it will handle people moving the app
extern void ITSetApplicationLaunchOnLogin(NSString *path, BOOL flag);
extern BOOL ITDoesApplicationLaunchOnLogin(NSString *path);