//
//  GPKGUserTableReader.h
//  geopackage-ios
//
//  Created by Brian Osborn on 5/27/15.
//  Copyright (c) 2015 NGA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPKGUserTable.h"
#import "GPKGConnection.h"

/**
 *  Reads the metadata from an existing user table
 */
@interface GPKGUserTableReader : NSObject

/**
 *  Table name
 */
@property (nonatomic, strong) NSString *tableName;

/**
 *  Initialize
 *
 *  @param tableName table name
 *
 *  @return new table reader
 */
-(instancetype) initWithTable: (NSString *) tableName;

/**
 *  Read the table
 *
 *  @param db db connection
 *
 *  @return user table
 */
-(GPKGUserTable *) readTableWithConnection: (GPKGConnection *) db;

@end
