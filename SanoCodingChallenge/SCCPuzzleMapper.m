//
//  SCCPuzzleMapper.m
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import "SCCPuzzleMapper.h"

@implementation SCCPuzzleMapper

+(SCCCoordinate*)coordinateForSpaceCoordinate:(SCCCoordinate*)sCoord inGroupWithCoordinate:(SCCCoordinate*)gCoord {
    
    return [[SCCCoordinate alloc] initWithX:sCoord.x + (gCoord.x - 1) * 3 Y:sCoord.y + (gCoord.y -1) * 3];
    
}

+(NSInteger)groupIndexForAbsoluteCoordinate:(SCCCoordinate*)coord {
    
    return (coord.x - 1) / 3 + ((coord.y - 1) / 3) * 3;
    
}

+(NSInteger)spaceIndexForAbsoluteCoordinate:(SCCCoordinate*)coord {
    
    return (coord.x - 1) % 3 + ((coord.y - 1) % 3) * 3;
    
}

+(SCCSquare*)spaceAtAbsoluteCoordinate:(SCCCoordinate*)coord inPuzzle:(SCCPuzzle*)puzzle {
    
    return [[[puzzle.groups objectAtIndex:[SCCPuzzleMapper groupIndexForAbsoluteCoordinate:coord]] spaces] objectAtIndex:[SCCPuzzleMapper spaceIndexForAbsoluteCoordinate:coord]];
    
}

+(SCCCoordinate*)complimentaryCoordinate:(SCCCoordinate*)coordinate {
    
    if(coordinate.x == 5 && coordinate.y == 5) {
        return nil;
    }
    
    return [[SCCCoordinate alloc] initWithX:10 - coordinate.x Y:10 - coordinate.y];
    
}

@end
