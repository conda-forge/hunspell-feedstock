#!/usr/bin/env bash
set -euxo pipefail

# Add hunspell dictionary paths relative to PREFIX. We have to do this here so
# that $PREFIX gets expanded into the patch.
sed "s;\$CONDA_PREFIX;${PREFIX};"\
    < "${RECIPE_DIR}/0000-dictionary-search-path.patch" \
    | patch -p1

autoreconf -vfi

./configure \
    --prefix="${PREFIX}" \
    --with-readline \
    --with-ui

make "-j${CPU_COUNT}"

if [[ "${target_platform}" == "${build_platform}" ]]; then
    make check
fi

make install
