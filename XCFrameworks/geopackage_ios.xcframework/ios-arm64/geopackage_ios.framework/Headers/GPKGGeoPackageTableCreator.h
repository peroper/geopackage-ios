//
//  GPKGGeoPackageTableCreator.h
//  geopackage-ios
//
//  Created by Brian Osborn on 6/25/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "GPKGTableCreator.h"

/**
 *  Executes database scripts to create GeoPackage tables
 */
@interface GPKGGeoPackageTableCreator : GPKGTableCreator

/**
 *  Initialize
 *
 *  @param db database connection
 *
 *  @return new GeoPackage table creator
 */
-(instancetype) initWithDatabase: (GPKGConnection *) db;

/**
 *  Create Spatial Reference System table
 *
 *  @return tables created
 */
-(int) createSpatialReferenceSystem;

/**
 *  Create Contents table
 *
 *  @return tables created
 */
-(int) createContents;

/**
 *  Create Geometry Columns table
 *
 *  @return tables created
 */
-(int) createGeometryColumns;

/**
 *  Creat Tile Matrix Set table
 *
 *  @return tables created
 */
-(int) createTileMatrixSet;

/**
 *  Create Tile Matrix table
 *
 *  @return tables created
 */
-(int) createTileMatrix;

/**
 *  Create Extensions table
 *
 *  @return tables created
 */
-(int) createExtensions;

/**
 *  Create Data Columns table
 *
 *  @return tables created
 */
-(int) createDataColumns;

/**
 *  Create Data Column Constraints table
 *
 *  @return tables created
 */
-(int) createDataColumnConstraints;

/**
 *  Create Metadata table
 *
 *  @return tables created
 */
-(int) createMetadata;

/**
 *  Create Metadata Reference table
 *
 *  @return tables created
 */
-(int) createMetadataReference;

/**
 * Create the Tiled Gridded Coverage Data Coverage extension table
 *
 * @return executed statements
 */
-(int) createGriddedCoverage;

/**
 * Create the Tiled Gridded Coverage Data Tile extension table
 *
 * @return executed statements
 */
-(int) createGriddedTile;

/**
 * Create the Extended Relations table
 *
 * @return executed statements
 */
-(int) createExtendedRelations;

/**
 * Create an extension table
 *
 * @return executed statements
 */
-(int) createExtensionTable: (NSString *) tableName;

/**
 *  Create the user table
 *
 *  @param table user table
 */
-(void) createUserTable: (GPKGUserTable *) table;

/**
 *  Create the minimum required GeoPackage tables
 */
-(void) createRequired;

/**
 *  Drop the table if it exists
 *
 *  @param table table name
 */
-(void) dropTable: (NSString *) table;

/**
 *  Drop the view if it exists
 *
 *  @param view view name
 */
-(void) dropView: (NSString *) view;

@end
