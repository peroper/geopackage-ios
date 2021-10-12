//
//  GPKGStyleCache.h
//  geopackage-ios
//
//  Created by Brian Osborn on 2/18/19.
//  Copyright © 2019 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPKGFeatureStyleExtension.h"
#import "GPKGIconCache.h"
#import "GPKGMapPoint.h"
#import "GPKGPolyline.h"
#import "GPKGPolygon.h"

/**
 * Style utilities for populating points and shapes. Caches icons for a single GeoPackage
 */
@interface GPKGStyleCache : NSObject

/**
 * Initialize
 *
 * @param geoPackage GeoPackage
 */
-(instancetype) initWithGeoPackage: (GPKGGeoPackage *) geoPackage;

/**
 * Initialize
 *
 * @param geoPackage    GeoPackage
 * @param iconCacheSize number of icon images to cache
 */
-(instancetype) initWithGeoPackage: (GPKGGeoPackage *) geoPackage andIconCacheSize: (int) iconCacheSize;

/**
 * Initialize
 *
 * @param featureStyleExtension feature style extension
 */
-(instancetype) initWithExtension: (GPKGFeatureStyleExtension *) featureStyleExtension;

/**
 * Initialize
 *
 * @param featureStyleExtension feature style extension
 * @param iconCacheSize         number of icon bitmaps to cache
 */
-(instancetype) initWithExtension: (GPKGFeatureStyleExtension *) featureStyleExtension andIconCacheSize: (int) iconCacheSize;

/**
 * Clear the cache
 */
-(void) clear;

/**
 * Get the feature style extension
 *
 * @return feature style extension
 */
-(GPKGFeatureStyleExtension *) featureStyleExtension;

/**
 * Set the feature row style (icon or style) into the map point
 *
 * @param mapPoint      map point
 * @param featureRow    feature row
 * @return true if icon or style was set into the map point
 */
-(BOOL) setFeatureStyleWithMapPoint: (GPKGMapPoint *) mapPoint andFeature: (GPKGFeatureRow *) featureRow;

/**
 * Set the feature style (icon or style) into the marker options
 *
 * @param mapPoint      map point
 * @param featureStyle  feature style
 * @return true if icon or style was set into the marker options
 */
-(BOOL) setFeatureStyleWithMapPoint: (GPKGMapPoint *) mapPoint andFeatureStyle: (GPKGFeatureStyle *) featureStyle;

/**
 * Set the icon into the marker options
 *
 * @param mapPoint      map point
 * @param icon          icon row
 * @return true if icon was set into the marker options
 */
-(BOOL) setIconWithMapPoint: (GPKGMapPoint *) mapPoint andIcon: (GPKGIconRow *) icon;

/**
 * Create the icon bitmap
 *
 * @param icon icon row
 * @return icon bitmap
 */
-(UIImage *) createIconImageWithIcon: (GPKGIconRow *) icon;

/**
 * Set the style into the marker options
 *
 * @param mapPoint      map point
 * @param style         style row
 * @return true if style was set into the marker options
 */
-(BOOL) setStyleWithMapPoint: (GPKGMapPoint *) mapPoint andStyle: (GPKGStyleRow *) style;

/**
 * Set the feature row style into the polyline
 *
 * @param polyline   polyline
 * @param featureRow feature row
 * @return true if style was set into the polyline
 */
-(BOOL) setFeatureStyleWithPolyline: (GPKGPolyline *) polyline andFeature: (GPKGFeatureRow *) featureRow;

/**
 * Set the feature style into the polyline
 *
 * @param polyline     polyline
 * @param featureStyle feature style
 * @return true if style was set into the polyline
 */
-(BOOL) setFeatureStyleWithPolyline: (GPKGPolyline *) polyline andFeatureStyle: (GPKGFeatureStyle *) featureStyle;

/**
 * Set the style into the polyline
 *
 * @param polyline polyline
 * @param style    style row
 * @return true if style was set into the polyline
 */
-(BOOL) setStyleWithPolyline: (GPKGPolyline *) polyline andStyle: (GPKGStyleRow *) style;

/**
 * Set the feature row style into the polygon
 *
 * @param polygon    polygon
 * @param featureRow feature row
 * @return true if style was set into the polygon
 */
-(BOOL) setFeatureStyleWithPolygon: (GPKGPolygon *) polygon andFeature: (GPKGFeatureRow *) featureRow;

/**
 * Set the feature style into the polygon
 *
 * @param polygon      polygon
 * @param featureStyle feature style
 * @return true if style was set into the polygon
 */
-(BOOL) setFeatureStyleWithPolygon: (GPKGPolygon *) polygon andFeatureStyle: (GPKGFeatureStyle *) featureStyle;

/**
 * Set the style into the polygon
 *
 * @param polygon  polygon
 * @param style    style row
 * @return true if style was set into the polygon
 */
-(BOOL) setStyleWithPolygon: (GPKGPolygon *) polygon andStyle: (GPKGStyleRow *) style;

@end
