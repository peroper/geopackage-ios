//
//  GPKGUserCustomRow.h
//  geopackage-ios
//
//  Created by Brian Osborn on 6/19/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "GPKGUserRow.h"
#import "GPKGUserCustomTable.h"

/**
 * User Custom Row containing the values from a single results row
 */
@interface GPKGUserCustomRow : GPKGUserRow

/**
 *  Initialize
 *
 *  @param table       user custom table
 *  @param columns   columns
 *  @param values      values
 *
 *  @return new user custom row
 */
-(instancetype) initWithUserCustomTable: (GPKGUserCustomTable *) table andColumns: (GPKGUserCustomColumns *) columns andValues: (NSMutableArray *) values;

/**
 *  Initialize
 *
 *  @param table user custom table
 *
 *  @return new user custom row
 */
-(instancetype) initWithUserCustomTable: (GPKGUserCustomTable *) table;

/**
 * Copy Initialize
 *
 * @param userCustomRow
 *            user custom row to copy
 *
 *  @return new user custom row
 */
-(instancetype) initWithUserCustomRow: (GPKGUserCustomRow *) userCustomRow;

/**
 *  Get the user custom table
 *
 *  @return user custom table
 */
-(GPKGUserCustomTable *) userCustomTable;

/**
 *  Get the user custom columns
 *
 *  @return user custom columns
 */
-(GPKGUserCustomColumns *) userCustomColumns;

@end
