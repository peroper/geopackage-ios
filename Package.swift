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
                "geopackage-ios-wrapper"
            ]
        )
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "geopackage-ios-wrapper",
            dependencies: [
                "geopackage-ios",
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
            path: "geopackage-ios-wrapper"
        ),
        .binaryTarget(
            name: "geopackage-ios",
            path: "XCFrameworks/geopackage_ios.xcframework"
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
