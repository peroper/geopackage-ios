//
//  GPKGCreateTestCase.m
//  geopackage-ios
//
//  Created by Brian Osborn on 11/16/15.
//  Copyright © 2015 NGA. All rights reserved.
//

#import "GPKGCreateTestCase.h"
#import "GPKGGeoPackageTestUtils.h"

@implementation GPKGCreateTestCase

- (void)testCreateFeatureTableWithMetadata {
    
    [GPKGGeoPackageTestUtils testCreateFeatureTableWithMetadata:self.geoPackage];
    
}

- (void)testCreateFeatureTableWithMetadataIdColumn {
    
    [GPKGGeoPackageTestUtils testCreateFeatureTableWithMetadataIdColumn:self.geoPackage];
    
}

- (void)testCreateFeatureTableWithMetadataAdditionalColumns {
    
    [GPKGGeoPackageTestUtils testCreateFeatureTableWithMetadataAdditionalColumns:self.geoPackage];
    
}

- (void)testCreateFeatureTableWithMetadataIdColumnAdditionalColumns {
    
    [GPKGGeoPackageTestUtils testCreateFeatureTableWithMetadataIdColumnAdditionalColumns:self.geoPackage];
    
}

- (void)testDeleteTables {
    
    [GPKGGeoPackageTestUtils testDeleteTables:self.geoPackage];
    
}

- (void) testBounds {
    
    [GPKGGeoPackageTestUtils testBounds:self.geoPackage];
    
}

- (void) testVacuum {
    
    [GPKGGeoPackageTestUtils testVacuum:self.geoPackage];
    
}

- (void) testTableTypes {
    
    [GPKGGeoPackageTestUtils testTableTypes:self.geoPackage];
    
}

@end
