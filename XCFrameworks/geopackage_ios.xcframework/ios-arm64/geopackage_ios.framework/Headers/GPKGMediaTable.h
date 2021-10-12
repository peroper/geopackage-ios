//
//  GPKGMediaTable.h
//  geopackage-ios
//
//  Created by Brian Osborn on 6/14/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPKGUserRelatedTable.h"
#import "GPKGRelationTypes.h"
#import "GPKGMediaTableMetadata.h"

/**
 *  Media Table constants
 */
extern NSString * const GPKG_RMT_COLUMN_DATA;
extern NSString * const GPKG_RMT_COLUMN_CONTENT_TYPE;

/**
 * Media Requirements Class User-Defined Related Data Table
 */
@interface GPKGMediaTable : GPKGUserRelatedTable

/**
 * User-Defined Media Table relation name
 *
 * @return relation type
 */
+(enum GPKGRelationType) relationType;

/**
 * Create a media table with the metadata
 *
 * @param metadata
 *            media table metadata
 * @return media table
 */
+(GPKGMediaTable *) createWithMetadata: (GPKGMediaTableMetadata *) metadata;

/**
 * Create the required table columns
 *
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumns;

/**
 * Create the required table columns
 *
 * @param autoincrement
 *            autoincrement id values
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithAutoincrement: (BOOL) autoincrement;

/**
 * Create the required table columns with the id column name
 *
 * @param idColumnName
 *            id column name
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIdColumnName: (NSString *) idColumnName;

/**
 * Create the required table columns with the id column name
 *
 * @param idColumnName
 *            id column name
 * @param autoincrement
 *            autoincrement id values
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIdColumnName: (NSString *) idColumnName andAutoincrement: (BOOL) autoincrement;

/**
 * Create the required table columns, starting at the provided index
 *
 * @param startingIndex
 *            starting index
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIndex: (int) startingIndex;

/**
 * Create the required table columns, starting at the provided index
 *
 * @param startingIndex
 *            starting index
 * @param autoincrement
 *            autoincrement id values
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIndex: (int) startingIndex andAutoincrement: (BOOL) autoincrement;

/**
 * Create the required table columns with id column name, starting at the provided index
 *
 * @param startingIndex
 *            starting index
 * @param idColumnName
 *            id column name
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIndex: (int) startingIndex andIdColumnName: (NSString *) idColumnName;

/**
 * Create the required table columns with id column name, starting at the
 * provided index
 *
 * @param startingIndex
 *            starting index
 * @param idColumnName
 *            id column name
 * @param autoincrement
 *            autoincrement id values
 * @return user custom columns
 */
+(NSArray<GPKGUserCustomColumn *> *) createRequiredColumnsWithIndex: (int) startingIndex andIdColumnName: (NSString *) idColumnName andAutoincrement: (BOOL) autoincrement;

/**
 * Create the primary key id column
 *
 * @param idColumnName
 *            id column name
 * @return id column
 */
+(GPKGUserCustomColumn *) createIdColumnWithName: (NSString *) idColumnName;

/**
 * Create the primary key id column
 *
 * @param idColumnName
 *            id column name
 * @param autoincrement
 *            autoincrement id values
 * @return id column
 */
+(GPKGUserCustomColumn *) createIdColumnWithName: (NSString *) idColumnName andAutoincrement: (BOOL) autoincrement;

/**
 * Create the primary key id column
 *
 * @param index
 *            column index
 * @param idColumnName
 *            id column name
 * @return id column
 */
+(GPKGUserCustomColumn *) createIdColumnWithIndex: (int) index andName: (NSString *) idColumnName;

/**
 * Create the primary key id column
 *
 * @param index
 *            column index
 * @param idColumnName
 *            id column name
 * @param autoincrement
 *            autoincrement id values
 * @return id column
 */
+(GPKGUserCustomColumn *) createIdColumnWithIndex: (int) index andName: (NSString *) idColumnName andAutoincrement: (BOOL) autoincrement;

/**
 * Create a data column
 *
 * @return data column
 */
+(GPKGUserCustomColumn *) createDataColumn;

/**
 * Create a data column
 *
 * @param index
 *            column index
 * @return data column
 */
+(GPKGUserCustomColumn *) createDataColumnWithIndex: (int) index;

/**
 * Create a content type column
 *
 * @return content type column
 */
+(GPKGUserCustomColumn *) createContentTypeColumn;

/**
 * Create a content type column
 *
 * @param index
 *            column index
 * @return content type column
 */
+(GPKGUserCustomColumn *) createContentTypeColumnWithIndex: (int) index;

/**
 * Get the number of required columns
 *
 * @return required columns count
 */
+(int) numRequiredColumns;

/**
 * Get the required columns
 *
 * @return required columns
 */
+(NSArray<NSString *> *) requiredColumns;

/**
 * Get the required columns
 *
 * @param idColumnName
 *            id column name
 * @return required columns
 */
+(NSArray<NSString *> *) requiredColumnsWithIdColumnName: (NSString *) idColumnName;

/**
 *  Initialize
 *
 *  @param tableName table name
 *  @param columns   list of columns
 *
 *  @return new media table
 */
-(instancetype) initWithTable: (NSString *) tableName andColumns: (NSArray *) columns;

/**
 *  Initialize
 *
 *  @param tableName table name
 *  @param columns   list of columns
 *  @param idColumnName  id column name
 *
 *  @return new media table
 */
-(instancetype) initWithTable: (NSString *) tableName andColumns: (NSArray *) columns andIdColumnName: (NSString *) idColumnName;

/**
 * Initialize
 *
 * @param table
 *            user custom table
 *
 *  @return new media table
 */
-(instancetype) initWithTable: (GPKGUserCustomTable *) table;

/**
 * Get the id column index
 *
 * @return id column index
 */
-(int) idColumnIndex;

/**
 * Get the id column
 *
 * @return id column
 */
-(GPKGUserCustomColumn *) idColumn;

/**
 * Get the data column index
 *
 * @return data column index
 */
-(int) dataColumnIndex;

/**
 * Get the data column
 *
 * @return data column
 */
-(GPKGUserCustomColumn *) dataColumn;

/**
 * Get the content type column index
 *
 * @return content type column index
 */
-(int) contentTypeColumnIndex;

/**
 * Get the content type column
 *
 * @return content type column
 */
-(GPKGUserCustomColumn *) contentTypeColumn;

@end
