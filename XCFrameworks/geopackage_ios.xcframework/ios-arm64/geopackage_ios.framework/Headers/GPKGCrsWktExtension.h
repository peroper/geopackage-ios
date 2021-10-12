//
//  GPKGCrsWktExtension.h
//  geopackage-ios
//
//  Created by Brian Osborn on 5/3/16.
//  Copyright © 2016 NGA. All rights reserved.
//

#import "GPKGBaseExtension.h"
#import "GPKGGeoPackage.h"

extern NSString * const GPKG_CRS_WKT_EXTENSION_NAME;

/**
 *  OGC Well known text representation of Coordinate Reference Systems extension
 *
 *  http://www.geopackage.org/spec/#extension_crs_wkt
 */
@interface GPKGCrsWktExtension : GPKGBaseExtension

/**
 *  Extension name
 */
@property (nonatomic, strong) NSString *extensionName;

/**
 *  Extension definition URL
 */
@property (nonatomic, strong) NSString *definition;

/**
 *  Extension name
 */
@property (nonatomic, strong) NSString *columnName;

/**
 *  Extension definition URL
 */
@property (nonatomic, strong) NSString *columnDef;

/**
 *  Initialize
 *
 *  @param geoPackage GeoPackage
 *
 *  @return new instance
 */
-(instancetype) initWithGeoPackage: (GPKGGeoPackage *) geoPackage;

/**
 *  Get or create the extension
 *
 *  @return extension
 */
-(GPKGExtensions *) extensionCreate;

/**
 *  Determine if the GeoPackage has the extension
 *
 *  @return true if has extension
 */
-(BOOL) has;

/**
 *  Update the extension definition
 *
 *  @param srsId      srs id
 *  @param definition definition
 */
-(void) updateDefinitionWithSrsId:(NSNumber *) srsId andDefinition:(NSString *) definition;

/**
 *  Get the extension definition
 *
 *  @param srsId srs id
 *
 *  @return definition
 */
-(NSString *) definitionWithSrsId:(NSNumber *) srsId;

/**
 * Remove the extension. Leaves the column and values.
 */
-(void) removeExtension;

@end
