//
//  TMXObjectGroup.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 name: The name of the object group.
 color: The color used to display the objects in this group.
 x: The x coordinate of the object group in tiles. Defaults to 0 and can no longer be changed in Tiled Qt.
 y: The y coordinate of the object group in tiles. Defaults to 0 and can no longer be changed in Tiled Qt.
 width: The width of the object group in tiles. Meaningless.
 height: The height of the object group in tiles. Meaningless.
 opacity: The opacity of the layer as a value from 0 to 1. Defaults to 1.
 visible: Whether the layer is shown (1) or hidden (0). Defaults to 1.
 The object group is in fact a map layer, and is hence called "object layer" in Tiled Qt.
 
 Can contain: properties, object
 */
@interface TMXObjectGroup : NSObject
{
    @private
    NSString* mName;
    NSString* mColor;
    NSInteger mX;
    NSInteger mY;
    NSInteger mWidth;
    NSInteger mHeight;
    float mOpacity;
    Boolean mVisible;
    NSMutableDictionary* mObjects;
    NSMutableDictionary* mProperties;   
}

@property (nonatomic, assign) NSString* name;
@property (nonatomic, assign) NSString* color;
@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) float opacity;
@property (nonatomic, assign) Boolean visible;
@property (nonatomic, assign) NSMutableDictionary* objects;
@property (nonatomic, assign) NSMutableDictionary* properties;

- (id)init;
@end
