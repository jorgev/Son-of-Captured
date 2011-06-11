//
//  main.m
//  SonOfCaptured
//
//  Created by Jorge Velázquez on 6/11/11.
//  Copyright 2011 Codeography. All rights reserved.
//

#import <Cocoa/Cocoa.h>

int main (int argc, const char * argv[])
{
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	CGRect rect = CGRectMake(300, 300, 400, 400);
	CGImageRef screenShot = CGWindowListCreateImage(rect, kCGWindowListOptionOnScreenOnly, kCGNullWindowID, kCGWindowImageDefault);
	NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithCGImage:screenShot];
	NSData *data = [bitmapRep representationUsingType:NSPNGFileType properties: nil];
	[data writeToFile:@"image.png" atomically:NO];
	[bitmapRep release];
	CGImageRelease(screenShot);
	
	[pool drain];
    return 0;
}

