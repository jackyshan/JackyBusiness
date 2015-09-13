//
//  NSData+GZip.h
//  U6Comm
//
//  Created by hower on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSData(GZip)

+ (id) compressedDataWithData: (NSData*) data;
+ (id) dataUncompressGZipData: (NSData*) gzipData;

@end
