//
//  BirdNode.h
//  spritybird
//
//  Created by Alexis Creuzot on 16/02/2014.
//  Copyright (c) 2014 Alexis Creuzot. All rights reserved.
//  Modified for CS247 by team baguette
//

@interface BirdNode : SKSpriteNode
- (void) update:(NSUInteger) currentTime;
- (void) startPlaying;
- (void) bounce;
@end
