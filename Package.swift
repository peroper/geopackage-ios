// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "geopackage-ios",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "geopackage-ios",
            targets: [
                "geopackage-ios"
            ]
        )
    ],
    dependencies: [
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "geopackage-ios",
            dependencies: [
                "tiff-ios",
                "simple-features-ios",
                "simple-features-projections-ios",
                "simple-features-geojson-ios",
                "ogc-api-features-json-ios",
                "simple-features-wkt-ios",
                "simple-features-wkb-ios",
                "coordinate-reference-systems-ios",
                "projections-ios"
            ],
            path: "geopackage-ios",
            exclude: [
                "Info.plist",
                "extension/geopackage.tables.gpkg.plist",
                "extension/nga/geopackage.tables.nga.plist",
                "db/metadata/geopackage.tables.metadata.plist",
                "geopackage.plist",
                "extension/rtree/geopackage.rtree_sql.plist",
                "geopackage-ios-Prefix.pch",
                "geopackage.tables.plist"
            ]
        ),
        .binaryTarget(
            name: "tiff-ios",
            path: "XCFrameworks/tiff_ios.xcframework"
        ),
        .binaryTarget(
            name: "simple-features-ios",
            path: "XCFrameworks/sf_ios.xcframework"
        ),
        .binaryTarget(
            name: "simple-features-projections-ios",
            path: "XCFrameworks/sf_proj_ios.xcframework"
        ),
        .binaryTarget(
            name: "simple-features-geojson-ios",
            path: "XCFrameworks/sf_geojson_ios.xcframework"
        ),
        .binaryTarget(
            name: "ogc-api-features-json-ios",
            path: "XCFrameworks/ogc_api_features_json_ios.xcframework"
        ),
        .binaryTarget(
            name: "simple-features-wkt-ios",
            path: "XCFrameworks/sf_wkt_ios.xcframework"
        ),
        .binaryTarget(
            name: "simple-features-wkb-ios",
            path: "XCFrameworks/sf_wkb_ios.xcframework"
        ),
        .binaryTarget(
            name: "coordinate-reference-systems-ios",
            path: "XCFrameworks/crs_ios.xcframework"
        ),
        .binaryTarget(
            name: "projections-ios",
            path: "XCFrameworks/proj_ios.xcframework"
        )
    ]
)
