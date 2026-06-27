#!/bin/bash

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
MAKE_UTILS="${REPO_ROOT}/make_utils"
MODULES="${REPO_ROOT}/modules"

DO_BUILD=0
DO_INSTALL=0
DO_TEST=0

status_line() { printf "%-80s\n" "--- $1 " | tr ' ' '-'; }
error_line()  { printf "%-80s\n" "!!! $1 " | tr ' ' '!'; }

for arg in "$@"
do
    case "$arg" in
        -build)
            DO_BUILD=1
            ;;
        -install)
            DO_INSTALL=1
            ;;
        -test)
            DO_TEST=1
            ;;
        *)
            error_line "unknown option: $arg"
            echo "usage: $0 [-build] [-install] [-test]"
            exit 1
            ;;
    esac
done

if [ $((DO_BUILD + DO_INSTALL + DO_TEST)) -eq 0 ]
then
    error_line "no option specified"
    echo "usage: $0 [-build] [-install] [-test]"
    exit 1
fi

MAKE_ARGS="MAKE_UTILS=${MAKE_UTILS} MODULES=${MODULES}"

if [ $DO_BUILD -eq 1 ]
then
    status_line "build"
    make -f "${REPO_ROOT}/Makefile" all ${MAKE_ARGS}
fi

if [ $DO_INSTALL -eq 1 ]
then
    status_line "install"
    make -f "${REPO_ROOT}/Makefile" all ${MAKE_ARGS}
fi

if [ $DO_TEST -eq 1 ]
then
    status_line "test"
    make -f "${REPO_ROOT}/Makefile" run_tests ${MAKE_ARGS}
fi
