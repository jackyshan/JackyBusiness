//
//  NSData+GZip.m
//  U6Comm
//
//  Created by hower on 8/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSData+GZip.h"
#import <zlib.h>
static const NSUInteger ChunkSize = 16384;

@implementation NSData(GZip)


+ (id) dataUncompressGZipData: (NSData*) gzipData
{
    return gzipData;
    z_stream strm;
    
    // Initialize input
    strm.next_in = (Bytef *)[gzipData bytes];
    NSUInteger left = [gzipData length];        // input left to decompress
    if (left == 0)
        return nil;                         // incomplete gzip stream
    
    // Create starting space for output (guess double the input size, will grow
    // if needed -- in an extreme case, could end up needing more than 1000
    // times the input size)
    NSUInteger space = left << 1;
    if (space < left)
        space = NSUIntegerMax;
    NSMutableData *decompressed = [NSMutableData dataWithLength: space];
    space = [decompressed length];
    
    // Initialize output
    strm.next_out = (Bytef *)[decompressed mutableBytes];
    NSUInteger have = 0;                    // output generated so far
    
    // Set up for gzip decoding
    strm.avail_in = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    int status = inflateInit2(&strm, (15+16));
    if (status != Z_OK)
        return nil;                         // out of memory
    
    // Decompress all of self
    do {
        // Allow for concatenated gzip streams (per RFC 1952)
        if (status == Z_STREAM_END)
            (void)inflateReset(&strm);
        
        // Provide input for inflate
        if (strm.avail_in == 0) {
            strm.avail_in = left > UINT_MAX ? UINT_MAX : (unsigned)left;
            left -= strm.avail_in;
        }
        
        // Decompress the available input
        do {
            // Allocate more output space if none left
            if (space == have) {
                // Double space, handle overflow
                space <<= 1;
                if (space < have) {
                    space = NSUIntegerMax;
                    if (space == have) {
                        // space was already maxed out!
                        (void)inflateEnd(&strm);
                        return nil;         // output exceeds integer size
                    }
                }
                
                // Increase space
                [decompressed setLength: space];
                space = [decompressed length];
                
                // Update output pointer (might have moved)
                strm.next_out = (Bytef *)[decompressed mutableBytes] + have;
            }
            
            // Provide output space for inflate
            strm.avail_out = space - have > UINT_MAX ? UINT_MAX :
            (unsigned)(space - have);
            have += strm.avail_out;
            
            // Inflate and update the decompressed size
            status = inflate (&strm, Z_SYNC_FLUSH);
            have -= strm.avail_out;
            
            // Bail out if any errors
            if (status != Z_OK && status != Z_BUF_ERROR &&
                status != Z_STREAM_END) {
                (void)inflateEnd(&strm);
                return nil;                 // invalid gzip stream
            }
            
            // Repeat until all output is generated from provided input (note
            // that even if strm.avail_in is zero, there may still be pending
            // output -- we're not done until the output buffer isn't filled)
        } while (strm.avail_out == 0);
        
        // Continue until all input consumed
    } while (left || strm.avail_in);
    
    // Free the memory allocated by inflateInit2()
    (void)inflateEnd(&strm);
    
    // Verify that the input is a valid gzip stream
    // 此处注释了，
//    if (status != Z_STREAM_END)
//        return nil;                         // incomplete gzip stream
    
    // Set the actual length and return the decompressed data
    [decompressed setLength: have];
    return decompressed;
}



+ (NSData *)gzippedDataWithCompressionLevel:(float)level data:(NSData*) data
{
    if ([data length])
    {
        z_stream stream;
        stream.zalloc = Z_NULL;
        stream.zfree = Z_NULL;
        stream.opaque = Z_NULL;
        stream.avail_in = (uint)[data length];
        stream.next_in = (Bytef *)[data bytes];
        stream.total_out = 0;
        stream.avail_out = 0;
        
        int compression = (level < 0.0f)? Z_DEFAULT_COMPRESSION: (int)(roundf(level * 9));
        if (deflateInit2(&stream, compression, Z_DEFLATED, 31, 8, Z_DEFAULT_STRATEGY) == Z_OK)
        {
            NSMutableData *data = [NSMutableData dataWithLength:ChunkSize];
            while (stream.avail_out == 0)
            {
                if (stream.total_out >= [data length])
                {
                    data.length += ChunkSize;
                }
                stream.next_out = (uint8_t *)[data mutableBytes] + stream.total_out;
                stream.avail_out = (uInt)([data length] - stream.total_out);
                deflate(&stream, Z_FINISH);
            }
            deflateEnd(&stream);
            data.length = stream.total_out;
            return data;
        }
    }
    return nil;
}

+ (id) compressedDataWithData: (NSData*) data
{
    return data;
    return [self gzippedDataWithCompressionLevel:-1.0f data:data];
}


@end
