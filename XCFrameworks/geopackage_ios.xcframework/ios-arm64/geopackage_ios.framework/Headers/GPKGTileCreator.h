//
//  GPKGTileCreator.h
//  geopackage-ios
//
//  Created by Brian Osborn on 5/26/16.
//  Copyright © 2016 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPKGTileDao.h"
#import "GPKGGeoPackageTile.h"
#import "GPKGTileScaling.h"

@interface GPKGTileCreator : NSObject

/**
 *  Tile Scaling options
 */
@property (nonatomic, strong) GPKGTileScaling *scaling;

/**
 *  Initializer, specified tile size and projection
 *
 *  @param tileDao           tile dao
 *  @param width             requested width
 *  @param height            requested height
 *  @param requestProjection requested projection
 *
 *  @return new instance
 */
-(instancetype) initWithTileDao: (GPKGTileDao *) tileDao andWidth: (NSNumber *) width andHeight: (NSNumber *) height andProjection: (PROJProjection *) requestProjection;

/**
 *  Initializer, tile tables tile size and projection
 *
 *  @param tileDao tile dao
 *
 *  @return new instance
 */
-(instancetype) initWithTileDao: (GPKGTileDao *) tileDao;

/**
 *  Initializer, tile tables projection with specified tile size
 *
 *  @param tileDao           tile dao
 *  @param width             requested width
 *  @param height            requested height
 *
 *  @return new instance
 */
-(instancetype) initWithTileDao: (GPKGTileDao *) tileDao andWidth: (NSNumber *) width andHeight: (NSNumber *) height;

/**
 *  Initializer, tile tables tile size and requested projection
 *
 *  @param tileDao           tile dao
 *  @param requestProjection requested projection
 *
 *  @return new instance
 */
-(instancetype) initWithTileDao: (GPKGTileDao *) tileDao andProjection: (PROJProjection *) requestProjection;

/**
 *  Get the tile DAO
 *
 *  @return tile DAO
 */
-(GPKGTileDao *) tileDao;

/**
 *  Get the tile width
 *
 *  @return tile width
 */
-(NSNumber *) width;

/**
 *  Get the tile height
 *
 *  @return tile height
 */
-(NSNumber *) height;

/**
 *  Get the tile matrix set
 *
 *  @return tile matrix set
 */
-(GPKGTileMatrixSet *) tileMatrixSet;

/**
 *  Get the requested projection
 *
 *  @return request projection
 */
-(PROJProjection *) requestProjection;

/**
 *  Get the tiles projection
 *
 *  @return tiles projection
 */
-(PROJProjection *) tilesProjection;

/**
 *  Get the tile set bounding box
 *
 *  @return tile set bounding box
 */
-(GPKGBoundingBox *) tileSetBoundingBox;

/**
 *  Determine if the requested and tile projections are the same
 *
 *  @return true if the same projection
 */
-(BOOL) sameProjection;
/**
 * Is the request and tile projection the same unit
 *
 * @return true if the same
 */
-(BOOL) sameUnit;

/**
 *  Check if the tile table contains a tile for the request bounding box
 *
 *  @param requestBoundingBox request bounding box in the request projection
 *
 *  @return true if a tile exists
 */
-(BOOL) hasTileWithBoundingBox: (GPKGBoundingBox *) requestBoundingBox;

/**
 *  Get the tile from the request bounding box in the request projection
 *
 *  @param requestBoundingBox request bounding box in the request projection
 *
 *  @return tile
 */
-(GPKGGeoPackageTile *) tileWithBoundingBox: (GPKGBoundingBox *) requestBoundingBox;

/**
 *  Get the tile from the request bounding box in the request projection, only from the zoom level
 *
 *  @param requestBoundingBox request bounding box in the request projection
 *  @param zoomLevel zoom level
 *
 *  @return tile
 */
-(GPKGGeoPackageTile *) tileWithBoundingBox: (GPKGBoundingBox *) requestBoundingBox andZoom: (int) zoomLevel;

@end
