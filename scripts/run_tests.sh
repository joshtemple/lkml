#!/usr/bin/env bash

set -euo pipefail

if [[ "$*" == *--format-code* ]]
then
    BLACK_ACTION="--quiet"
    ISORT_ACTION="-y"
else
    BLACK_ACTION="--check"
    ISORT_ACTION="--check-only"
fi

echo "Running mypy..."
mypy lkml

echo "Running pytest..."
pytest tests

echo "Running black..."
black ${BLACK_ACTION} .

echo "Running isort..."
isort -rc ${ISORT_ACTION} lkml scripts

echo "Running flake8..."
flake8 lkml scripts

echo "Running bandit..."
bandit -rq .

echo "Running PyDocStyle..."
pydocstyle lkml --match='(?!__init__)(?!test_).*\.py'
