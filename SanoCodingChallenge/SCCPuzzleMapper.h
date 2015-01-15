//
//  SCCPuzzleMapper.h
//  SanoCodingChallenge
//
//  Created by sharif ahmed on 1/14/15.
//  Copyright (c) 2015 Feef. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCCPuzzle.h"

@interface SCCPuzzleMapper : NSObject

+(SCCCoordinate*)coordinateForSpaceCoordinate:(SCCCoordinate*)sCoord inGroupWithCoordinate:(SCCCoordinate*)gCoord;
+(NSInteger)groupIndexForAbsoluteCoordinate:(SCCCoordinate*)coord;
+(NSInteger)spaceIndexForAbsoluteCoordinate:(SCCCoordinate*)coord;
+(SCCSquare*)spaceAtAbsoluteCoordinate:(SCCCoordinate*)coord inPuzzle:(SCCPuzzle*)puzzle;
+(SCCCoordinate*)complimentaryCoordinate:(SCCCoordinate*)coordinate;

@end
