# ex: ts=4 sw=4 et filetype=sh

export OLLVM_NDK_CONTAINER_DIR="${HOME}/projects/alcatel-pay/docker-llvm"
export OLLVM_BUILD_TYPES=( release debug )
export OLLVM_BUILD_TYPE_DEFAULT=${OLLVM_BUILD_TYPES[0]}
export OLLVM_VERBOSE=0

function ollvm-sanity-check() {
    ollvm_ndk_path=${1:-$OLLVM_NDK}
    if [ ! -d ${ollvm_ndk_path} ] || [ ! -x "${ollvm_ndk_path}/ndk-build" ]; then
        echo "Invalid OLLVM_NDK '$ollvm_ndk_path'"
        return 1
    fi
    return 0
}

function ndk-build() {
    ollvm-sanity-check || return 1
    (( OLLVM_VERBOSE )) && echo -e "\n### Running O-LLVM ndk-build '${OLLVM_NDKBUILD}'\n"
    $OLLVM_NDKBUILD $@
}

function ollvm-clang() {
    ollvm-sanity-check || return 1
    (( OLLVM_VERBOSE )) && echo -e "\n### Running O-LLVM clang '${OLLVM_CLANG}'\n"
    $OLLVM_CLANG $@
}

function ollvm-switch() {
    build_type=${1:-$OLLVM_BUILD_TYPE_DEFAULT}
    local ollvm_ndk_path="${OLLVM_NDK_CONTAINER_DIR}/android-ndk-r14b-ollvm3.6.1-${build_type}"
    ollvm-sanity-check $ollvm_ndk_path || return 1

    export OLLVM_NDK=$ollvm_ndk_path
    export OLLVM_NDKBUILD="${OLLVM_NDK}/ndk-build"
    export OLLVM_CLANG="${OLLVM_NDK}/toolchains/ollvm3.6.1/prebuilt/linux-x86_64/bin/clang"
    echo -e "\n### Switched to O-LLVM NDK '${ollvm_ndk_path}'\n"
}

if type complete &>/dev/null; then
    complete -W "${OLLVM_BUILD_TYPES[*]}" ollvm-switch
elif type compctl &>/dev/null; then
    compctl -k "(${OLLVM_BUILD_TYPES[*]})" ollvm-switch
fi
