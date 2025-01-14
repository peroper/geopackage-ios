//
//  GPKGPropertyConstants.h
//  geopackage-ios
//
//  Created by Brian Osborn on 6/11/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  GeoPackage property constants
 */
extern NSString * const GPKG_PROP_DIVIDER;
extern NSString * const GPKG_PROP_DIR_GEOPACKAGE;
extern NSString * const GPKG_PROP_DIR_DATABASE;
extern NSString * const GPKG_PROP_DIR_METADATA;
extern NSString * const GPKG_PROP_DIR_METADATA_FILE_DB;
extern NSString * const GPKG_PROP_SRS_WGS_84;
extern NSString * const GPKG_PROP_SRS_UNDEFINED_CARTESIAN;
extern NSString * const GPKG_PROP_SRS_UNDEFINED_GEOGRAPHIC;
extern NSString * const GPKG_PROP_SRS_WEB_MERCATOR;
extern NSString * const GPKG_PROP_SRS_WGS_84_3D;
extern NSString * const GPKG_PROP_SRS_SRS_NAME;
extern NSString * const GPKG_PROP_SRS_SRS_ID;
extern NSString * const GPKG_PROP_SRS_ORGANIZATION;
extern NSString * const GPKG_PROP_SRS_ORGANIZATION_COORDSYS_ID;
extern NSString * const GPKG_PROP_SRS_DEFINITION;
extern NSString * const GPKG_PROP_SRS_DESCRIPTION;
extern NSString * const GPKG_PROP_SRS_DEFINITION_12_063;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_Z;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_X;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_Y;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_MIN_LAT;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_MAX_LAT;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_MIN_LON;
extern NSString * const GPKG_PROP_TILE_GENERATOR_VARIABLE_MAX_LON;
extern NSString * const GPKG_PROP_FEATURE_TILES;
extern NSString * const GPKG_PROP_FEATURE_TILES_COMPRESS_FORMAT;
extern NSString * const GPKG_PROP_FEATURE_POINT_RADIUS;
extern NSString * const GPKG_PROP_FEATURE_LINE_STROKE_WIDTH;
extern NSString * const GPKG_PROP_FEATURE_POLYGON_STROKE_WIDTH;
extern NSString * const GPKG_PROP_FEATURE_POLYGON_FILL;
extern NSString * const GPKG_PROP_DATETIME_FORMATS;
extern NSString * const GPKG_PROP_FEATURE_OVERLAY_QUERY;
extern NSString * const GPKG_PROP_FEATURE_QUERY_SCREEN_CLICK_PERCENTAGE;
extern NSString * const GPKG_PROP_FEATURE_QUERY_MAX_FEATURES_INFO;
extern NSString * const GPKG_PROP_FEATURE_QUERY_FEATURES_INFO;
extern NSString * const GPKG_PROP_FEATURE_QUERY_MAX_POINT_DETAILED_INFO;
extern NSString * const GPKG_PROP_FEATURE_QUERY_MAX_FEATURE_DETAILED_INFO;
extern NSString * const GPKG_PROP_FEATURE_QUERY_DETAILED_INFO_PRINT_POINTS;
extern NSString * const GPKG_PROP_FEATURE_QUERY_DETAILED_INFO_PRINT_FEATURES;
extern NSString * const GPKG_PROP_CONTENTS_DATA_TYPE;
extern NSString * const GPKG_PROP_FEATURE_GENERATOR;
extern NSString * const GPKG_PROP_FEATURE_GENERATOR_DOWNLOAD_ATTEMPTS;
extern NSString * const GPKG_PROP_MAX_ZOOM_LEVEL;
extern NSString * const GPKG_PROP_CONNECTION_POOL;
extern NSString * const GPKG_PROP_CONNECTION_POOL_OPEN_CONNECTIONS_PER_POOL;
extern NSString * const GPKG_PROP_CONNECTION_POOL_CHECK_CONNECTIONS;
extern NSString * const GPKG_PROP_CONNECTION_POOL_CHECK_CONNECTIONS_FREQUENCY;
extern NSString * const GPKG_PROP_CONNECTION_POOL_CHECK_CONNECTIONS_WARNING_TIME;
extern NSString * const GPKG_PROP_CONNECTION_POOL_MAINTAIN_STACK_TRACES;
extern NSString * const GPKG_PROP_MANAGER_VALIDATION;
extern NSString * const GPKG_PROP_MANAGER_VALIDATION_IMPORT_HEADER;
extern NSString * const GPKG_PROP_MANAGER_VALIDATION_IMPORT_INTEGRITY;
extern NSString * const GPKG_PROP_MANAGER_VALIDATION_OPEN_HEADER;
extern NSString * const GPKG_PROP_MANAGER_VALIDATION_OPEN_INTEGRITY;
extern NSString * const GPKG_PROP_COLORS_RED;
extern NSString * const GPKG_PROP_COLORS_GREEN;
extern NSString * const GPKG_PROP_COLORS_BLUE;
extern NSString * const GPKG_PROP_COLORS_ALPHA;
extern NSString * const GPKG_PROP_COLORS_WHITE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TEXT_FONT;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TEXT_FONT_SIZE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TEXT_COLOR;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_DRAW_CIRCLE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_CIRCLE_COLOR;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_CIRCLE_STROKE_WIDTH;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_FILL_CIRCLE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_CIRCLE_FILL_COLOR;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_DRAW_TILE_BORDER;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TILE_BORDER_COLOR;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TILE_BORDER_STROKE_WIDTH;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_FILL_TILE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_TILE_FILL_COLOR;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_CIRCLE_PADDING_PERCENTAGE;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_DRAW_UNINDEXED_TILES;
extern NSString * const GPKG_PROP_NUMBER_FEATURE_TILES_UNINDEXED_TEXT;

@interface GPKGPropertyConstants : NSObject

@end
