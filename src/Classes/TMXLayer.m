//
//  TMXLayer.m
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import "TMXLayer.h"

@implementation TMXLayer

    @synthesize width = mWidth;
    @synthesize height = mHeight;
    @synthesize x = mX;
    @synthesize y = mY;
    @synthesize name = mName;
    @synthesize properties = mProperties;
    @synthesize data = mData;
    @synthesize visible = mVisible;
    @synthesize opacity = mOpacity;
    @synthesize nsdata = mNSData;
    @synthesize tableData = mTableData;

    @synthesize mapData = mMapData;

    - (id)init
    {
        self = [super init];
        pool = [[NSAutoreleasePool alloc] init];
        mNSData = [[NSMutableData alloc] init];
        return self;
    }
    
    -(id) createTiles
    {
        [self createFromCSV];
        return self;
    }


- (id)createFromCSV{
	mData.data = [mData.data stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
	NSArray *rows = [[[NSArray alloc]initWithArray:[mData.data componentsSeparatedByString:@"\n"]]autorelease];
	int mapHeight = [rows count];
	int mapWidth = [[[rows objectAtIndex:0] componentsSeparatedByString:@","] count];
	
	int amount = ((mapWidth) * (mapHeight)) + mapWidth;
	[mNSData setLength:amount*sizeof(int)];

    mTableData = [[NSMutableArray alloc] initWithCapacity:rows.count];
    for(int x = 0; x < rows.count; x++){
        NSArray *colData  = [[[NSArray alloc]initWithArray:[[rows objectAtIndex:x] componentsSeparatedByString:@","]]autorelease];
        NSMutableArray* colIntData = [[[NSMutableArray alloc] initWithCapacity:colData.count]autorelease];
        for(int y = 0; y < colData.count; y++)
        {
            TMXTile* tile = [[[TMXTile alloc] initWithXYGid:[[colData objectAtIndex:y]intValue] x:x y:y]autorelease];
            [colIntData insertObject:tile atIndex:y];
        }
        [mTableData insertObject:colIntData atIndex:x];
    }
    return self;
}

- (void) dealloc
{
    [pool release];
}
@end
