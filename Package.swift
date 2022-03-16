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
                "geopackage_ios",
                "tiff_ios",
                "sf_ios",
                "sf_proj_ios",
                "sf_geojson_ios",
                "ogc_api_features_json_ios",
                "sf_wkt_ios",
                "sf_wkb_ios",
                "crs_ios",
                "proj_ios"
            ],
            path: "geopackage-ios-wrapper"
        ),
        .binaryTarget(
            name: "geopackage_ios",
            path: "XCFrameworks/geopackage_ios.xcframework"
        ),
        .binaryTarget(
            name: "tiff_ios",
            path: "XCFrameworks/tiff_ios.xcframework"
        ),
        .binaryTarget(
            name: "sf_ios",
            path: "XCFrameworks/sf_ios.xcframework"
        ),
        .binaryTarget(
            name: "sf_proj_ios",
            path: "XCFrameworks/sf_proj_ios.xcframework"
        ),
        .binaryTarget(
            name: "sf_geojson_ios",
            path: "XCFrameworks/sf_geojson_ios.xcframework"
        ),
        .binaryTarget(
            name: "ogc_api_features_json_ios",
            path: "XCFrameworks/ogc_api_features_json_ios.xcframework"
        ),
        .binaryTarget(
            name: "sf_wkt_ios",
            path: "XCFrameworks/sf_wkt_ios.xcframework"
        ),
        .binaryTarget(
            name: "sf_wkb_ios",
            path: "XCFrameworks/sf_wkb_ios.xcframework"
        ),
        .binaryTarget(
            name: "crs_ios",
            path: "XCFrameworks/crs_ios.xcframework"
        ),
        .binaryTarget(
            name: "proj_ios",
            path: "XCFrameworks/proj_ios.xcframework"
        )
    ]
)
