//
//  main.m
//  SonOfCaptured
//
//  Created by Jorge Velázquez on 6/11/11.
//  Copyright 2011 Codeography. All rights reserved.
//

#include <stdlib.h>
#import <Cocoa/Cocoa.h>

static char alNum[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

NSString* CreateUniqueFilename(NSInteger numChars)
{
	char buf[32];
	srand((unsigned int) time(NULL));
	for (int i = 0; i < numChars; i++)
		buf[i] = alNum[rand() % strlen(alNum)];
	buf[numChars] = 0;
	strcat(buf, ".png");
	return [NSString stringWithCString:buf encoding:NSASCIIStringEncoding];
}

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	CGRect rect = CGRectMake(300, 300, 400, 400);
	CGImageRef screenShot = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
	NSData *data = [bitmapRep representationUsingType:NSPNGFileType properties:nil];
	NSString* tempFile = NSTemporaryDirectory();
	NSString* uniqueName = CreateUniqueFilename(5);
	tempFile = [tempFile stringByAppendingString:uniqueName];
	[data writeToFile:tempFile atomically:NO];
	[bitmapRep release];
	CGImageRelease(screenShot);
	NSLog(@"Image saved to %@", tempFile);
	
	[pool drain];
    return 0;
}

