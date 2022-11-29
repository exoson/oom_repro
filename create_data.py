import sys

_, path, file_count = sys.argv

for i in range(int(file_count)):
    with open(f"{path}/data{i}", "w") as f:
        pass
