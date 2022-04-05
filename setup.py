from pathlib import Path

from setuptools import find_packages, setup

__version__ = "1.3.0b5"

here = Path(__file__).parent.resolve()

# Get the long description from the README file
with (here / "README.md").open(encoding="utf-8") as file:
    long_description = file.read()

setup(
    name="lkml",
    version=__version__,
    description="A speedy LookML parser implemented in pure Python.",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/joshtemple/lkml",
    download_url="https://github.com/joshtemple/lkml/tarball/" + __version__,
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Programming Language :: Python :: 3.7",
        "Topic :: Software Development",
    ],
    keywords="lookml looker parser",
    license="MIT",
    entry_points={"console_scripts": ["lkml = lkml.__init__:cli"]},
    packages=find_packages(exclude=["docs", "tests*", "scripts"]),
    package_data={"lkml": ["py.typed"]},
    include_package_data=True,
    author="Josh Temple",
    tests_require=["black", "flake8", "isort", "mypy", "pytest", "pytest-cov"],
    author_email="",
    zip_safe=False,
)
