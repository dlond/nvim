# Usage Examples & Quickstart

## C++ Development

### Quick Start
```bash
# Enter C++ development environment
nix develop .#cpp

# Create a new project
mkdir my-cpp-project && cd my-cpp-project
echo "use flake" > .envrc && direnv allow

# Your tools are now available
clang++ --version
cmake --version
conan --version
```

### Building a Project
```bash
# Modern CMake workflow
mkdir build && cd build
cmake .. -GNinja -DCMAKE_BUILD_TYPE=Release
ninja

# With Conan package management
conan install .. --build=missing
cmake .. -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake
ninja
```

### Performance Optimization
```bash
# Profile your application
perf record ./my-app
perf report

# Memory debugging
valgrind --tool=memcheck ./my-app

# Static analysis
clang-tidy *.cpp -- -std=c++20
```

## VFX Plugin Development

### Houdini HDK Plugin
```bash
# Enter VFX development environment
nix develop .#vfx

# Create Houdini plugin from template
cp -r templates/houdini-plugin my-houdini-sop
cd my-houdini-sop

# Build and install
mkdir build && cd build
cmake .. -DHOUDINI_VERSION=20.0
make install

# Test in Houdini
houdini test.hip
```

### Maya C++ Plugin
```bash
# Maya plugin development
cp -r templates/maya-plugin my-maya-deformer
cd my-maya-deformer

# Configure build environment
export MAYA_VERSION=2024
export MAYA_LOCATION=/usr/autodesk/maya2024

# Build with performance optimizations
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DMAYA_VERSION=$MAYA_VERSION
make -j$(nproc)

# Load in Maya
maya -command "loadPlugin \"./my-maya-deformer.so\""
```

### USD Plugin Development
```bash
# USD schema or plugin
cp -r templates/usd-plugin my-usd-schema
cd my-usd-schema

# Build USD plugin
mkdir build && cd build
cmake .. -DUSD_ROOT=$USD_INSTALL_ROOT -DTBB_ROOT=$TBB_ROOT
make install

# Test USD pipeline
usdview my-asset.usd
```

### Unreal Engine Plugin
```bash
# UE5 plugin development
cp -r templates/unreal-plugin MyUnrealPlugin
cd MyUnrealPlugin

# Generate project files
$UE5_ROOT/Engine/Build/BatchFiles/Linux/GenerateProjectFiles.sh MyProject.uproject

# Build with UnrealBuildTool
$UE5_ROOT/Engine/Binaries/DotNET/UnrealBuildTool/UnrealBuildTool MyProject Linux Development
```

## Performance Benchmarking

### Memory Performance Testing
```bash
# Run memory benchmarks
cd benchmarks
g++ -O3 -march=native memory-profile.cpp -ljemalloc -o memory-test
./memory-test

# Compare allocators
LD_PRELOAD=libjemalloc.so ./memory-test    # jemalloc
LD_PRELOAD=libtcmalloc.so ./memory-test    # tcmalloc
./memory-test                              # system malloc
```

### SIMD Optimization Testing
```bash
# Test SIMD performance
g++ -O3 -march=native -mavx2 simd-perf.cpp -o simd-test
./simd-test

# Profile with Intel VTune
vtune -collect hotspots ./simd-test
```

### GPU Computing
```bash
# CUDA development
nvcc -O3 -arch=sm_80 gpu-compute.cu -o gpu-test
./gpu-test

# Profile GPU kernels
nsys profile ./gpu-test
ncu ./gpu-test
```

## Cross-Platform Building

### Multi-Platform Binaries
```bash
# Linux (native)
nix develop .#vfx
mkdir build-linux && cd build-linux
cmake .. -DCMAKE_BUILD_TYPE=Release
make package

# Windows cross-compilation
nix develop .#vfx-windows
mkdir build-windows && cd build-windows
cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/mingw-toolchain.cmake
make package

# macOS Universal binary
nix develop .#vfx-macos
mkdir build-macos && cd build-macos
cmake .. -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64"
make package
```

### Distribution Packaging
```bash
# Linux packages
make package        # .tar.gz
cpack -G DEB       # .deb package
cpack -G RPM       # .rpm package
cpack -G AppImage  # AppImage

# Windows installer
cpack -G NSIS      # .exe installer

# macOS bundle
cpack -G Bundle    # .app bundle
cpack -G DragNDrop # .dmg installer
```

## Integration with IDEs

### CLion Setup
```bash
# Generate compile_commands.json for CLion
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
ln -s build/compile_commands.json .

# Open project in CLion with environment
nix develop .#vfx --command clion .
```

### VS Code Setup
```bash
# VS Code with Nix environment
nix develop .#vfx --command code .

# Configure .vscode/settings.json with proper paths
# All tools (clangd, cmake, debugger) will work automatically
```

## Troubleshooting

### Common Issues
```bash
# Check VFX Platform compliance
python -c "import sys; print(f'Python: {sys.version}')"
pkg-config --modversion Qt6Core
ldd --version  # Check glibc version

# Verify GPU acceleration
nvidia-smi     # NVIDIA GPU
rocm-smi      # AMD GPU
```

### Environment Debugging
```bash
# List all available packages
nix develop .#vfx --command env | grep -E "(PATH|LD_LIBRARY_PATH|PKG_CONFIG_PATH)"

# Check library linkage
ldd ./my-plugin.so

# Verify compiler flags
echo | gcc -E -dM - | grep -E "(AVX|SSE)"
```

## Advanced Workflows

### Performance Regression Testing
```bash
# Set up continuous benchmarking
./benchmarks/run-performance-suite.sh baseline
# ... make changes ...
./benchmarks/run-performance-suite.sh current
./benchmarks/compare-results.py baseline current
```

### Multi-Application Plugin Suite
```bash
# Build plugins for multiple applications
make houdini-plugin
make maya-plugin  
make nuke-plugin
make unreal-plugin

# Test integration pipeline
./test-pipeline.sh all-plugins
```