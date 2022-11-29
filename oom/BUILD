load("//:defs.bzl", "oom_test")

[
    oom_test(
        name = "test_oom" + str(i),
        data = ["//:data"],
    ) for i in range(1000)
]
