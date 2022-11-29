load("//:defs.bzl", "generate_data")

py_binary(
    name = "create_data",
    srcs = ["create_data.py"],
)

generate_data(
    name = "data",
    visibility = ["//visibility:public"],
)
