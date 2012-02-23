//
//  TMXEvent.h
//  Sparrow
//
//  Created by Elliot Franford on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
