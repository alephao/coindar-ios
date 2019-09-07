load("@build_bazel_rules_swift//swift:swift.bzl", "swift_library")
load("@build_bazel_rules_apple//apple:ios.bzl", "ios_static_framework")

#
# SnapKit
#

swift_library(
    name = "SnapKit",
    srcs = glob(["SnapKit/Source/*.swift"]),
    module_name = "SnapKit",
    # visibility = ["//visibility:public"],
)

ios_static_framework(
    name = "AllDependenciesMiniOS10",
    bundle_name = "AllDependenciesMiniOS10",
    minimum_os_version = "10.0",
    deps = [":SnapKit"],
)
