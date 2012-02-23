//
//  TMXData.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import "TMXData.h"
#import "NSData+Base64.h"
#include <zlib.h>
/*
 <data>
 
 encoding: The encoding used to encode the tile layer data. When used, it can be "base64" and "csv" at the moment.
 compression: The compression used to compress the tile layer data. Tiled Qt supports "gzip" and "zlib".
 When no encoding or compression is given, the tiles are stored as individual XML tile elements. Next to that, the easiest format to parse is the "csv" (comma separated values) format.
 
 The base64-encoded and optionally compressed layer data is somewhat more complicated to parse. First you need to base64-decode it, then you may need to decompress it. Now you have an array of bytes, which should be interpreted as an array of unsigned 32-bit integers using little-endian byte ordering.
 
 Whatever format you choose for your layer data, you will always end up with so called "global tile IDs" (gids). They are global, since they may refer to a tile from any of the tilesets used by the map. In order to find out from which tileset the tile is you need to find the tileset with the highest firstgid that is still lower or equal than the gid. The tilesets are always stored with increasing firstgids.
 
 When you use the tile flipping feature added in Tiled Qt 0.7.0, the highest two bits of the gid store the flipped state. Bit 32 is used for storing whether the tile is horizontally flipped and bit 31 is used for the vertically flipped tiles. And since Tiled Qt 0.8.0, bit 30 means whether the tile is flipped (anti) diagonally, enabling tile rotation. These bits have to be read and cleared before you can find out which tileset a tile belongs to.
 

 */

@implementation TMXData
@synthesize data = mData;
@synthesize encoding = mEncoding;
@synthesize compression = mCompression;

/*
 SString *encodedGzippedString = @"GgAAAB+LCAAAAAAABADtvQdgHEmWJSYvbcp7f0r1StfgdKEIgGATJNiQQBDswYjN5pLsHWlHIymrKoHKZVZlXWYWQMztnbz33nvvvffee++997o7nU4n99//P1xmZAFs9s5K2smeIYCqyB8/fnwfPyK+uE6X2SJPiyZ93eaX+TI9Lcuiatvx/wOwYc0HGgAAAA==";
 NSData *decodedGzippedData = [NSData dataFromBase64String:encodedGzippedString];
 NSData* unGzippedJsonData = [ASIHTTPRequest uncompressZippedData:decodedGzippedData];   
 NSString* unGzippedJsonString = [[NSString alloc] initWithData:unGzippedJsonData encoding:NSASCIIStringEncoding];       
 NSLog(@"Result: %@", unGzippedJsonString);
 */

-(id) init
{
    return self;
}

-(NSString*) getData{
    
    //NSData* decompressed = [self decompress];
    //NSLog(@"%@",decompressed.bytes);
    //return decompressed;
    NSData *decodedData = [NSData dataFromBase64String:mData];
    NSString* decodedString = [[[NSString alloc] initWithData:decodedData encoding:NSASCIIStringEncoding]autorelease];       
    return decodedString;
}

-(id) decode
{
    if([mEncoding isEqualToString:@"base64"])
    {
        
    }
    return nil;   
}
-(NSData*) decompress
{
        if ([mData length] == 0) return nil;
        
        unsigned full_length = [mData length];
        unsigned half_length = [mData length] / 2;
        
        NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
        BOOL done = NO;
        int status;
        
        z_stream strm;
        strm.next_in = (Bytef *)[mData dataUsingEncoding:NSUTF8StringEncoding];
        strm.avail_in = [mData length];
        strm.total_out = 0;
        strm.zalloc = Z_NULL;
        strm.zfree = Z_NULL;
        
        if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
        while (!done)
        {
            // Make sure we have enough room and reset the lengths.
            if (strm.total_out >= [decompressed length])
                [decompressed increaseLengthBy: half_length];
            strm.next_out = [decompressed mutableBytes] + strm.total_out;
            strm.avail_out = [decompressed length] - strm.total_out;
            
            // Inflate another chunk.
            status = inflate (&strm, Z_SYNC_FLUSH);
            if (status == Z_STREAM_END) done = YES;
            else if (status != Z_OK) break;
        }
        if (inflateEnd (&strm) != Z_OK) return nil;
        
        // Set real length.
        if (done)
        {
            [decompressed setLength: strm.total_out];
            return [NSData dataWithData: decompressed];
        }
        else return nil;
}

@end
