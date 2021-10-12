//
//  GPKGFeatureDao.h
//  geopackage-ios
//
//  Created by Brian Osborn on 5/21/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import "GPKGUserDao.h"
#import <sf_ios/sf_ios.h>
#import "GPKGGeometryColumns.h"
#import "GPKGFeatureRow.h"
#import "GPKGMetadataDb.h"

/**
 *  Feature DAO for reading feature user data tables
 */
@interface GPKGFeatureDao : GPKGUserDao

/**
 *  Geometry Columns
 */
@property (nonatomic, strong) GPKGGeometryColumns *geometryColumns;

/**
 *  Metadata db
 */
@property (nonatomic, strong)  GPKGMetadataDb *metadataDb;

/**
 *  Initialize
 *
 *  @param database        database connection
 *  @param table           feature table
 *  @param geometryColumns geometry columns
 *  @param metadataDb      metadata db
 *
 *  @return new feature dao
 */
-(instancetype) initWithDatabase: (GPKGConnection *) database andTable: (GPKGFeatureTable *) table andGeometryColumns: (GPKGGeometryColumns *) geometryColumns andMetadataDb: (GPKGMetadataDb *) metadataDb;

/**
 *  Get the feature table
 *
 *  @return feature table
 */
-(GPKGFeatureTable *) featureTable;

/**
 *  Get the feature row for the current result in the result set
 *
 *  @param results result set
 *
 *  @return feature row
 */
-(GPKGFeatureRow *) featureRow: (GPKGResultSet *) results;

/**
 *  Create a new feature row
 *
 *  @return feature row
 */
-(GPKGFeatureRow *) newRow;

/**
 *  Get the geometry column name
 *
 *  @return geometry column name
 */
-(NSString *) geometryColumnName;

/**
 *  Get the geometry type
 *
 *  @return geometry type
 */
-(enum SFGeometryType) geometryType;

/**
 * Get the Spatial Reference System
 *
 * @return srs
 */
-(GPKGSpatialReferenceSystem *) srs;

/**
 * Get the Spatial Reference System id
 *
 * @return srs id
 */
-(NSNumber *) srsId;

/**
 * Get the Id Column
 *
 * @return id column
 */
-(GPKGFeatureColumn *) idColumn;

/**
 * Get the Id Column name
 *
 * @return id column name
 */
-(NSString *) idColumnName;

/**
 * Get the Id and Geometry Column names
 *
 * @return column names
 */
-(NSArray<NSString *> *) idAndGeometryColumnNames;

@end
