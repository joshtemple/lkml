import time
from pathlib import Path
from statistics import mean, stdev

import lkml

times = []

directory = Path(__file__).parents[1] / "tests/resources/github"
for i, path in enumerate(directory.glob("*.lkml")):
    with path.open("r") as file:
        try:
            start = time.process_time()
            lkml.load(file)
            end = time.process_time()
        except SyntaxError:
            continue
        else:
            execution_time = end - start
            times.append(execution_time)

avg_time = mean(times)
standard_deviation = stdev(times)

print(
    f"Average process execution time: {avg_time * 100:.1f} "
    f"+/- {standard_deviation * 100:.1f} ms"
)
