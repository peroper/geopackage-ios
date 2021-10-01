//
//  GPKGFeatureOverlay.h
//  geopackage-ios
//
//  Created by Brian Osborn on 7/1/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <sf_ios/sf_ios.h>
#import "GPKGBoundingBox.h"
#import "GPKGFeatureTiles.h"
#import "GPKGBoundedOverlay.h"

/**
 *  Feature Tile Overlay which draws tiles from a feature table
 */
@interface GPKGFeatureOverlay : GPKGBoundedOverlay

/**
 *  Feature tiles
 */
@property (nonatomic, strong) GPKGFeatureTiles *featureTiles;

/**
 *  Initialize
 *
 *  @param featureTiles feature tiles
 *
 *  @return new feature overlay
 */
-(instancetype) initWithFeatureTiles: (GPKGFeatureTiles *) featureTiles;

/**
 *  Ignore drawing tiles if they exist in the tile tables represented by the tile daos
 *
 *  @param tileDaos tile daos
 */
-(void) ignoreTileDaos: (NSArray<GPKGTileDao *> *) tileDaos;

/**
 *  Ignore drawing tiles if they exist in the tile table represented by the tile dao
 *
 *  @param tileDao tile dao
 */
-(void) ignoreTileDao: (GPKGTileDao *) tileDao;

/**
 *  Clear all ignored tile tables
 */
-(void) clearIgnored;

@end
