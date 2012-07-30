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
	
    // capture a screenshot using the selected area
	CGRect rect = CGRectMake(0, 0, 2880, 1800);
	CGImageRef screenShot = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	if (!screenShot)
		return 1;
    
    // convert it to a bitmap image so we can manipulate it
	NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
	if (!bitmapRep)
	{
		[bitmapRep release];
		CGImageRelease(screenShot);
		return 2;
	}
    
    // get the actual bytes so we can write it to a file, using png format
	NSData* data = [bitmapRep representationUsingType:NSPNGFileType properties:nil];
    
    // clean up
	[bitmapRep release];
	CGImageRelease(screenShot);
    
    // create a path for the file
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSURL* url = [fileManager URLForDirectory:NSDesktopDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
	NSString* uniqueName = CreateUniqueFilename(5);
	url = [url URLByAppendingPathComponent:uniqueName];
    
    // write the file
	[data writeToURL:url atomically:NO];
	
	[pool drain];
    return 0;
}

