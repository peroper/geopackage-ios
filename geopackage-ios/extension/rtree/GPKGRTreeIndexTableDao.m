//
//  GPKGRTreeIndexTableDao.m
//  geopackage-ios
//
//  Created by Brian Osborn on 9/12/18.
//  Copyright © 2018 NGA. All rights reserved.
//

#import "GPKGRTreeIndexTableDao.h"
#import "GPKGSqlUtils.h"
#import "GPKGRTreeIndexExtension.h"

@interface GPKGRTreeIndexTableDao()

@property (nonatomic, strong) GPKGRTreeIndexExtension *rTree;
@property (nonatomic, strong) GPKGFeatureDao *featureDao;

@end

@implementation GPKGRTreeIndexTableDao

-(instancetype) initWithExtension: (GPKGRTreeIndexExtension *) rTree andDao: (GPKGUserCustomDao *) dao andFeatureDao: (GPKGFeatureDao *) featureDao{
    self = [super initWithDao:dao andTable:[dao userCustomTable]];
    if(self != nil){
        self.rTree = rTree;
        self.featureDao = featureDao;
        self.projection = featureDao.projection;
        self.tolerance = .00000000000001;
    }
    return self;
}

-(BOOL) has{
    return [self.rTree hasWithFeatureTable:[self.featureDao featureTable]];
}

-(GPKGExtensions *) create{
    GPKGExtensions *extension = nil;
    if(![self has]){
        extension = [self.rTree createWithFeatureTable:[self.featureDao featureTable]];
        if(self.progress != nil){
            [self.progress addProgress:[self count]];
        }
    }
    return extension;
}

-(void) delete{
    [self.rTree deleteWithFeatureTable:[self.featureDao featureTable]];
}

-(GPKGRTreeIndexExtension *) rTreeIndexExtension{
    return _rTree;
}

-(GPKGFeatureDao *) featureDao{
    return _featureDao;
}

-(GPKGRTreeIndexTableRow *) row: (GPKGResultSet *) resultSet{
    return [self rowFromUserCustomRow:(GPKGUserCustomRow *)[super row:resultSet]];
}

-(GPKGRTreeIndexTableRow *) rowFromUserCustomRow: (GPKGUserCustomRow *) row{
    return [[GPKGRTreeIndexTableRow alloc] initWithUserCustomRow:row];
}

-(GPKGFeatureRow *) featureRowFromRTreeRow: (GPKGRTreeIndexTableRow *) row{
    return (GPKGFeatureRow *)[self.featureDao queryForIdObject:[row id]];
}

-(GPKGFeatureRow *) featureRow: (GPKGResultSet *) resultSet{
    GPKGRTreeIndexTableRow *row = [self row:resultSet];
    return [self featureRowFromRTreeRow:row];
}

-(GPKGFeatureRow *) featureRowFromUserCustomRow: (GPKGUserCustomRow *) row{
    return [self featureRowFromRTreeRow:[self rowFromUserCustomRow:row]];
}

-(GPKGResultSet *) rawQuery: (NSString *) query andArgs: (NSArray *) args{
    [self validateRTree];
    return [super rawQuery:query andArgs:args];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns{
    [self validateRTree];
    return [super queryWithColumns:columns];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [super queryWithColumns:columns andWhere:where andWhereArgs:whereArgs];
}

-(int) countWhere: (NSString *) where andWhereArgs: (NSArray *) args{
    [self validateRTree];
    return [super countWhere:where andWhereArgs:args];
}

-(GPKGResultSet *) queryFeatures{
    [self validateRTree];
    return [self.featureDao queryInWithNestedSQL:[self queryIdsSQL]];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQL]];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns{
    [self validateRTree];
    return [self.featureDao queryInWithColumns:columns andNestedSQL:[self queryIdsSQL]];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQL]];
}

-(int) countFeatures{
    [self validateRTree];
    return [self.featureDao countInWithNestedSQL:[self queryIdsSQL]];
}

-(int) countFeaturesWithColumn: (NSString *) column{
    [self validateRTree];
    return [self.featureDao countInWithColumn:column andNestedSQL:[self queryIdsSQL]];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column{
    [self validateRTree];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQL]];
}

-(GPKGResultSet *) queryFeaturesWithFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao queryInWithNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao queryInWithColumns:columns andNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(int) countFeaturesWithFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao countInWithNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(int) countFeaturesWithColumn: (NSString *) column andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao countInWithColumn:column andNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQL] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andWhere:where andWhereArgs:nil];
}

-(int) countFeaturesWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:nil andWhere:where];
}

-(int) countFeaturesWithColumn: (NSString *) column andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:column andWhere:where];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:distinct andColumn:column andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao queryInWithNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao queryInWithColumns:columns andNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao countInWithNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithColumn: (NSString *) column andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao countInWithColumn:column andNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQL] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGBoundingBox *) boundingBox{
    
    GPKGBoundingBox *boundingBox = nil;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(%@), MIN(%@), MAX(%@), MAX(%@) FROM %@", GPKG_RTREE_INDEX_EXTENSION_COLUMN_MIN_X, GPKG_RTREE_INDEX_EXTENSION_COLUMN_MIN_Y, GPKG_RTREE_INDEX_EXTENSION_COLUMN_MAX_X,GPKG_RTREE_INDEX_EXTENSION_COLUMN_MAX_Y, [GPKGSqlUtils quoteWrapName:self.tableName]];
    NSArray *dataTypes = [NSArray arrayWithObjects:[[NSNumber alloc] initWithInt:GPKG_DT_DOUBLE], [[NSNumber alloc] initWithInt:GPKG_DT_DOUBLE], [[NSNumber alloc] initWithInt:GPKG_DT_DOUBLE], [[NSNumber alloc] initWithInt:GPKG_DT_DOUBLE], nil];
    
     NSArray<NSNumber *> *results = (NSArray<NSNumber *> *) [self querySingleRowResultsWithSql:sql andArgs:nil andDataTypes:dataTypes];
    
    if(results != nil && results.count > 0){
    
        double minLongitude = [[results objectAtIndex:0] doubleValue];
        double minLatitude = [[results objectAtIndex:1] doubleValue];
        double maxLongitude = [[results objectAtIndex:2] doubleValue];
        double maxLatitude = [[results objectAtIndex:3] doubleValue];

        boundingBox = [[GPKGBoundingBox alloc] initWithMinLongitudeDouble:minLongitude andMinLatitudeDouble:minLatitude andMaxLongitudeDouble:maxLongitude andMaxLatitudeDouble:maxLatitude];
     
    }
    return boundingBox;
}

-(GPKGBoundingBox *) boundingBoxInProjection: (PROJProjection *) projection{
    GPKGBoundingBox *boundingBox = [self boundingBox];
    if (boundingBox != nil && projection != nil) {
        SFPGeometryTransform *transform = [SFPGeometryTransform transformFromProjection:self.projection andToProjection:projection];
        if(![transform isSameProjection]){
            boundingBox = [boundingBox transform:transform];
        }
    }
    return boundingBox;
}

-(GPKGResultSet *) queryWithBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryWithDistinct:NO andBoundingBox:boundingBox];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryWithDistinct:distinct andEnvelope:[boundingBox buildEnvelope]];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryWithDistinct:NO andColumns:columns andBoundingBox:boundingBox];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryWithDistinct:distinct andColumns:columns andEnvelope:[boundingBox buildEnvelope]];
}

-(int) countWithBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countWithDistinct:NO andColumn:nil andBoundingBox:boundingBox];
}

-(int) countWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countWithDistinct:NO andColumn:column andBoundingBox:boundingBox];
}

-(int) countWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countWithDistinct:distinct andColumn:column andEnvelope:[boundingBox buildEnvelope]];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryFeaturesWithDistinct:distinct andEnvelope:[boundingBox buildEnvelope]];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andEnvelope:[boundingBox buildEnvelope]];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox{
    return [self countFeaturesWithDistinct:distinct andColumn:column andEnvelope:[boundingBox buildEnvelope]];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:distinct andEnvelope:[boundingBox buildEnvelope] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andEnvelope:[boundingBox buildEnvelope] andFieldValues:fieldValues];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox andFieldValues:fieldValues];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox andFieldValues:fieldValues];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:distinct andColumn:column andEnvelope:[boundingBox buildEnvelope] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andBoundingBox:boundingBox andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andBoundingBox:boundingBox andWhere:where andWhereArgs:nil];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox andWhere:where];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox andWhere:where];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:distinct andColumn:column andBoundingBox:boundingBox andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:distinct andEnvelope:[boundingBox buildEnvelope] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andEnvelope:[boundingBox buildEnvelope] andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:distinct andColumn:column andEnvelope:[boundingBox buildEnvelope] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self queryWithDistinct:NO andBoundingBox:boundingBox inProjection:projection];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryWithDistinct:distinct andBoundingBox:featureBoundingBox];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self queryWithDistinct:NO andColumns:columns andBoundingBox:boundingBox inProjection:projection];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryWithDistinct:distinct andColumns:columns andBoundingBox:featureBoundingBox];
}

-(int) countWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self countWithDistinct:NO andColumn:nil andBoundingBox:boundingBox inProjection:projection];
}

-(int) countWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self countWithDistinct:NO andColumn:column andBoundingBox:boundingBox inProjection:projection];
}

-(int) countWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self countWithDistinct:distinct andColumn:column andBoundingBox:featureBoundingBox];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox inProjection:projection];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andBoundingBox:featureBoundingBox];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox inProjection:projection];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andBoundingBox:featureBoundingBox];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox inProjection:projection];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox inProjection:projection];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self countFeaturesWithDistinct:distinct andColumn:column andBoundingBox:featureBoundingBox];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox inProjection:projection andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andBoundingBox:featureBoundingBox andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox inProjection:projection andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andBoundingBox:featureBoundingBox andFieldValues:fieldValues];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox inProjection:projection andFieldValues:fieldValues];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox inProjection:projection andFieldValues:fieldValues];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andFieldValues: (GPKGColumnValues *) fieldValues{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self countFeaturesWithDistinct:distinct andColumn:column andBoundingBox:featureBoundingBox andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox inProjection:projection andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox inProjection:projection andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:nil];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox inProjection:projection andWhere:where];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox inProjection:projection andWhere:where];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:distinct andColumn:column andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andBoundingBox:featureBoundingBox andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andBoundingBox:featureBoundingBox andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:nil andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:column andBoundingBox:boundingBox inProjection:projection andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andBoundingBox: (GPKGBoundingBox *) boundingBox inProjection: (PROJProjection *) projection andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    GPKGBoundingBox *featureBoundingBox = [self boundingBox:boundingBox inProjection:projection];
    return [self countFeaturesWithDistinct:distinct andColumn:column andBoundingBox:featureBoundingBox andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryWithDistinct:NO andEnvelope:envelope];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryWithDistinct:distinct andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryWithDistinct:NO andColumns:columns andEnvelope:envelope];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryWithDistinct:distinct andColumns:columns andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(int) countWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countWithDistinct:NO andColumn:nil andEnvelope:envelope];
}

-(int) countWithColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countWithDistinct:NO andColumn:column andEnvelope:envelope];
}

-(int) countWithDistinct: (BOOL) distinct andColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countWithDistinct:distinct andColumn:column andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(GPKGResultSet *) queryFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryFeaturesWithDistinct:NO andEnvelope:envelope];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryFeaturesWithDistinct:distinct andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andEnvelope:envelope];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(int) countFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countFeaturesWithDistinct:NO andColumn:nil andEnvelope:envelope];
}

-(int) countFeaturesWithColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countFeaturesWithDistinct:NO andColumn:column andEnvelope:envelope];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope{
    return [self countFeaturesWithDistinct:distinct andColumn:column andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue]];
}

-(GPKGResultSet *) queryFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andEnvelope:envelope andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:distinct andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andEnvelope:envelope andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andFieldValues:fieldValues];
}

-(int) countFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:nil andEnvelope:envelope andFieldValues:fieldValues];
}

-(int) countFeaturesWithColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:column andEnvelope:envelope andFieldValues:fieldValues];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:distinct andColumn:column andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andEnvelope:envelope andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andEnvelope:envelope andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andEnvelope:envelope andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andEnvelope:envelope andWhere:where andWhereArgs:nil];
}

-(int) countFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:nil andEnvelope:envelope andWhere:where];
}

-(int) countFeaturesWithColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:column andEnvelope:envelope andWhere:where];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:distinct andColumn:column andEnvelope:envelope andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andEnvelope:envelope andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:distinct andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andEnvelope:envelope andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:nil andEnvelope:envelope andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:column andEnvelope:envelope andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andEnvelope: (SFGeometryEnvelope *) envelope andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:distinct andColumn:column andMinX:[envelope.minX doubleValue] andMinY:[envelope.minY doubleValue] andMaxX:[envelope.maxX doubleValue] andMaxY:[envelope.maxY doubleValue] andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self queryWithDistinct:NO andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self queryWithDistinct:distinct andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryWithColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self queryWithDistinct:NO andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(GPKGResultSet *) queryWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self queryWithDistinct:distinct andColumns:columns andWhere:where andWhereArgs:whereArgs];
}

-(int) countWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self countWithDistinct:NO andColumn:nil andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(int) countWithColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self countWithDistinct:NO andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(int) countWithDistinct: (BOOL) distinct andColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self countWithDistinct:distinct andColumn:column andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self queryFeaturesWithDistinct:NO andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs];
}

-(int) countFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self countFeaturesWithDistinct:NO andColumn:nil andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(int) countFeaturesWithColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    return [self countFeaturesWithDistinct:NO andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andFieldValues:fieldValues];
}
-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs andFieldValues:fieldValues];
}

-(int) countFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:nil andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andFieldValues:fieldValues];
}

-(int) countFeaturesWithColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    return [self countFeaturesWithDistinct:NO andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andFieldValues:fieldValues];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andFieldValues: (GPKGColumnValues *) fieldValues{
    [self validateRTree];
    NSString *where = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQLWhere:where] andNestedArgs:whereArgs andFieldValues:fieldValues];
}

-(GPKGResultSet *) queryFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self queryFeaturesWithDistinct:distinct andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:nil];
}

-(int) countFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:nil andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where];
}

-(int) countFeaturesWithColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:NO andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where{
    return [self countFeaturesWithDistinct:distinct andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:nil];
}

-(GPKGResultSet *) queryFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    NSString *whereBounds = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereBoundsArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andNestedSQL:[self queryIdsSQLWhere:whereBounds] andNestedArgs:whereBoundsArgs andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self queryFeaturesWithDistinct:NO andColumns:columns andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:whereArgs];
}

-(GPKGResultSet *) queryFeaturesWithDistinct: (BOOL) distinct andColumns: (NSArray<NSString *> *) columns andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    NSString *whereBounds = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereBoundsArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao queryInWithDistinct:distinct andColumns:columns andNestedSQL:[self queryIdsSQLWhere:whereBounds] andNestedArgs:whereBoundsArgs andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:nil andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    return [self countFeaturesWithDistinct:NO andColumn:column andMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY andWhere:where andWhereArgs:whereArgs];
}

-(int) countFeaturesWithDistinct: (BOOL) distinct andColumn: (NSString *) column andMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY andWhere: (NSString *) where andWhereArgs: (NSArray *) whereArgs{
    [self validateRTree];
    NSString *whereBounds = [self buildWhereWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    NSArray *whereBoundsArgs = [self buildWhereArgsWithMinX:minX andMinY:minY andMaxX:maxX andMaxY:maxY];
    return [self.featureDao countInWithDistinct:distinct andColumn:column andNestedSQL:[self queryIdsSQLWhere:whereBounds] andNestedArgs:whereBoundsArgs andWhere:where andWhereArgs:whereArgs];
}

/**
 * Validate that the RTree extension exists for the table and column
 */
-(void) validateRTree{
    if (![self has]) {
        [NSException raise:@"RTree Extension" format:@"RTree Extension not found for feature table: %@", self.featureDao.tableName];
    }
}

/**
 * Build a where clause from the bounds for overlapping ranges
 *
 * @param minX min x
 * @param minY min y
 * @param maxX max x
 * @param maxY max y
 * @return where clause
 */
-(NSString *) buildWhereWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{

    NSMutableString *where = [NSMutableString string];
    [where appendString:[self buildWhereWithField:GPKG_RTREE_INDEX_EXTENSION_COLUMN_MIN_X andValue:[NSNumber numberWithDouble:maxX] andOperation:@"<="]];
    [where appendString:@" AND "];
    [where appendString:[self buildWhereWithField:GPKG_RTREE_INDEX_EXTENSION_COLUMN_MIN_Y andValue:[NSNumber numberWithDouble:maxY] andOperation:@"<="]];
    [where appendString:@" AND "];
    [where appendString:[self buildWhereWithField:GPKG_RTREE_INDEX_EXTENSION_COLUMN_MAX_X andValue:[NSNumber numberWithDouble:minX] andOperation:@">="]];
    [where appendString:@" AND "];
    [where appendString:[self buildWhereWithField:GPKG_RTREE_INDEX_EXTENSION_COLUMN_MAX_Y andValue:[NSNumber numberWithDouble:minY] andOperation:@">="]];
    
    return where;
}

/**
 * Build where arguments from the bounds to match the order in
 * {@link #buildWhereArgs(double, double, double, double)}
 *
 * @param minX min x
 * @param minY min y
 * @param maxX max x
 * @param maxY max y
 * @return where clause args
 */
-(NSArray *) buildWhereArgsWithMinX: (double) minX andMinY: (double) minY andMaxX: (double) maxX andMaxY: (double) maxY{
    
    minX -= self.tolerance;
    maxX += self.tolerance;
    minY -= self.tolerance;
    maxY += self.tolerance;
    
    return [self buildWhereArgsWithValueArray:[NSArray arrayWithObjects:[NSNumber numberWithDouble:maxX], [NSNumber numberWithDouble:maxY], [NSNumber numberWithDouble:minX], [NSNumber numberWithDouble:minY], nil]];
}

@end
