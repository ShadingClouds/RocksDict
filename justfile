clean:
    cargo clean

# for macos
develop:
    # conda deactivate
    sed -i.bak 's/^#  define _LIBCPP_INTRODUCED_IN_LLVM_21 1$/#  define _LIBCPP_INTRODUCED_IN_LLVM_21 0/' ${HOMEBREW_PREFIX}/opt/llvm@21/include/c++/v1/__configuration/availability.h
    LIBCLANG_PATH=${HOMEBREW_PREFIX}/opt/llvm@21/lib \
    CC=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang \
    CXX=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang++ \
    AR=${HOMEBREW_PREFIX}/opt/llvm@21/bin/llvm-ar \
    CFLAGS="-flto=thin -O3 --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" \
    CXXFLAGS="-flto=thin -O3 --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" \
    RUSTFLAGS="-Clinker-plugin-lto -Clinker=$PWD/macos-linker.sh -Clink-arg=-fuse-ld=${HOMEBREW_PREFIX}/opt/lld@21/bin/ld64.lld" \
    maturin develop --release --verbose

# for macos
build:
    # conda deactiva
    sed -i.bak 's/^#  define _LIBCPP_INTRODUCED_IN_LLVM_21 1$/#  define _LIBCPP_INTRODUCED_IN_LLVM_21 0/' ${HOMEBREW_PREFIX}/opt/llvm@21/include/c++/v1/__configuration/availability.h
    LIBCLANG_PATH=${HOMEBREW_PREFIX}/opt/llvm@21/lib \
    CC=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang \
    CXX=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang++ \
    AR=${HOMEBREW_PREFIX}/opt/llvm@21/bin/llvm-ar \
    CFLAGS="-flto=thin -O3 --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" \
    CXXFLAGS="-flto=thin -O3 --sysroot=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk" \
    RUSTFLAGS="-Clinker-plugin-lto -Clinker=$PWD/macos-linker.sh -Clink-arg=-fuse-ld=${HOMEBREW_PREFIX}/opt/lld@21/bin/ld64.lld" \
    maturin build --release --verbose

bin:
    sed -i.bak 's/^#  define _LIBCPP_INTRODUCED_IN_LLVM_21 1$/#  define _LIBCPP_INTRODUCED_IN_LLVM_21 0/' ${HOMEBREW_PREFIX}/opt/llvm@21/include/c++/v1/__configuration/availability.h
    LIBCLANG_PATH=${HOMEBREW_PREFIX}/opt/llvm@21/lib \
    CC=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang \
    CXX=${HOMEBREW_PREFIX}/opt/llvm@21/bin/clang++ \
    AR=${HOMEBREW_PREFIX}/opt/llvm@21/bin/llvm-ar \
    CFLAGS="-flto=thin -O3 --config-system-dir=${HOMEBREW_PREFIX}/etc/clang" \
    CXXFLAGS="-flto=thin -O3 --config-system-dir=${HOMEBREW_PREFIX}/etc/clang" \
    RUSTFLAGS="-Clinker-plugin-lto -Clinker=$PWD/macos-linker.sh -Clink-arg=-fuse-ld=${HOMEBREW_PREFIX}/opt/lld@21/bin/ld64.lld" \
    cargo build --release --bin create_cf_db
