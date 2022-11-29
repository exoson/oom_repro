# Combine the test data into only one bin + runfiles and propagate the runfiles to all the individual tests

def _oom_test(ctx):
    script = """\
#!/bin/bash
sleep 10s
"""
    ctx.actions.write(
        output = ctx.outputs.executable,
        content = script,
        is_executable = True,
    )
    if ctx.attr.binary:
        runfiles = ctx.attr.binary[DefaultInfo].default_runfiles
    else:
        runfiles = ctx.runfiles(files = ctx.files.data)
    return [
        DefaultInfo(
            executable = ctx.outputs.executable,
            runfiles = runfiles,
        ),
    ]

oom_test = rule(
    implementation = _oom_test,
    attrs = {
        "binary": attr.label(),
        "data": attr.label_list(),
    },
    test = True,
)

def _generate_data(ctx):
    outputs = []
    out_path = "out"
    files_to_generate = "100000"
    out_dir = ctx.actions.declare_directory(
        out_path,
    )
    outputs.append(out_dir)
    ctx.actions.run(
        outputs = outputs,
        executable = ctx.executable._data_gen,
        arguments = [out_dir.path, files_to_generate],
    )
    return [
        DefaultInfo(
            files = depset(outputs),
        )
    ]

generate_data = rule(
    implementation = _generate_data,
    attrs = {
        "_data_gen": attr.label(default = ":create_data", executable = True, cfg = "exec"),
    },
)
