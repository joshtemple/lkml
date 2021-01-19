from typing import Tuple


def strip(s: str) -> Tuple[str, str, str]:
    """Modified str.strip() which returns the stripped whitespace."""
    start = 0
    end = -1
    nchars = len(s)

    while start < nchars and s[start].isspace():
        start += 1
    if start != nchars:  # Check for case where only whitespace
        while s[end].isspace():
            end -= 1

    lspace = "" if start == 0 else s[:start]
    rspace = "" if end == -1 else s[end + 1 :]

    return lspace, s[start : end + 1 or None], rspace
