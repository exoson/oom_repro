load("//:defs.bzl", "oom_test")

py_binary(
    name = "oom_bin",
    srcs = ["oom_bin.py"],
    data = ["//:data"],
)

[
    oom_test(
        name = "test_no_oom" + str(i),
        binary = ":oom_bin",
    ) for i in range(1000)
]
