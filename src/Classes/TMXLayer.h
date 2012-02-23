//
//  TMXLayer.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sparrow.h"
/*
 <layer>
 
 name: The name of the layer.
 x: The x coordinate of the layer in tiles. Defaults to 0 and can no longer be changed in Tiled Qt.
 y: The y coordinate of the layer in tiles. Defaults to 0 and can no longer be changed in Tiled Qt.
 width: The width of the layer in tiles. Traditionally required, but as of Tiled Qt always the same as the map width.
 height: The height of the layer in tiles. Traditionally required, but as of Tiled Qt always the same as the map height.
 opacity: The opacity of the layer as a value from 0 to 1. Defaults to 1.
 visible: Whether the layer is shown (1) or hidden (0). Defaults to 1.
 Can contain: properties, data
 */
@interface TMXLayer : NSObject
    {
    @private
        NSString* mName;
        NSInteger mX;
        NSInteger mY;
        NSInteger mWidth;
        NSInteger mHeight;
        float mOpacity;
        Boolean mVisible;
        NSMutableDictionary* mProperties;        
        NSMutableArray* mTableData;
        NSMutableData* mNSData;
        NSArray* mMapData;
        TMXData* mData;
        NSAutoreleasePool *pool;
    }

    - (id)init;
    - (id)createTiles;
    - (id)createFromCSV;

    @property (nonatomic, assign) NSString* name;
    @property (nonatomic, assign) NSInteger x;
    @property (nonatomic, assign) NSInteger y;
    @property (nonatomic, assign) NSInteger width;
    @property (nonatomic, assign) NSInteger height;
    @property (nonatomic, assign) float opacity;
    @property (nonatomic, assign) Boolean visible;
    @property (nonatomic, assign) NSMutableDictionary* properties;
    @property (nonatomic, assign) NSMutableArray* tableData;
    @property (nonatomic, assign) TMXData* data;
    @property (nonatomic, assign) NSMutableData* nsdata;
    @property (nonatomic, assign) NSArray* mapData;

@end
