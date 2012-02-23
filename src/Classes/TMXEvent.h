//
//  TMXEvent.h
//  Sparrow
//
//  Created by Elliot Franford on 1/20/12.
//  Copyright (c) 2012 Abaondon Hope Games, LLC. All rights reserved.
//

#import "SPEvent.h"

@interface TMXEvent : SPEvent
{
    @private
    float mPlayerX;
    float mPlayerY;
}
@property (nonatomic, assign)float playerX;
@property (nonatomic, assign)float playerY;
@end
