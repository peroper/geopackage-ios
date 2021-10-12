set -euo pipefail
 
xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
trap 'rm -f "$xcconfig"' INT TERM HUP EXIT
 
# For Xcode 12 make sure EXCLUDED_ARCHS is set to arm architectures otherwise
# the build will fail on lipo due to duplicate architectures.

echo 'BUILD_LIBRARY_FOR_DISTRIBUTION = YES' >> $xcconfig

export XCODE_XCCONFIG_FILE="$xcconfig"
carthage "$@"