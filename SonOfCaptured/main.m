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
static size_t CHAR_COUNT = 62;

NSString* CreateUniqueFilename(NSInteger numChars)
{
	char buf[32];
	srand((unsigned int) time(NULL));
	for (int i = 0; i < numChars; i++)
		buf[i] = alNum[rand() % CHAR_COUNT];
	buf[numChars] = 0;
	strcat(buf, ".png");
	return [NSString stringWithCString:buf encoding:NSASCIIStringEncoding];
}

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	CGRect rect = CGRectMake(0, 0, 1440, 900);
	CGImageRef screenShot = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	if (!screenShot)
		return 1;
	CIImage* image = [CIImage imageWithCGImage:screenShot];
	NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
	if (!bitmapRep)
	{
		[bitmapRep release];
		CGImageRelease(screenShot);
		return 2;
	}
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

