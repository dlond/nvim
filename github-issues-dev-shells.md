# GitHub Issues for dev-shells Repository

## Issue #1: Add Rust Development Environment
**Title:** Add Rust development shell with common tools and cross-compilation support

**Description:**
Create a comprehensive Rust development environment that includes:

### Core Tools
- Latest stable Rust toolchain with rustup
- Cargo subcommands: `cargo-watch`, `cargo-edit`, `cargo-audit`, `cargo-deny`
- Development tools: `rust-analyzer`, `rustfmt`, `clippy`
- Testing tools: `cargo-nextest`, `cargo-tarpaulin` (coverage)

### Cross-compilation Support
- Multiple target architectures (Linux, Windows, macOS, WebAssembly)
- Platform-specific dependencies and linkers
- Docker integration for containerized builds

### Additional Features
- Benchmarking tools: `criterion`, `cargo-bench`
- Documentation: `mdbook` for project documentation
- CI/CD helpers: `cargo-make` for task automation

**Acceptance Criteria:**
- [ ] Basic Rust development works out of the box
- [ ] Cross-compilation to major platforms
- [ ] All tools accessible via `nix develop`
- [ ] README with usage examples

---

## Issue #2: Add Web Application Development Stack
**Title:** Create full-stack web development environment

**Description:**
Comprehensive environment for modern web application development:

### Frontend Tools
- Node.js (latest LTS) with npm/yarn/pnpm
- TypeScript, ESLint, Prettier
- Framework CLIs: `create-react-app`, `@vue/cli`, `@angular/cli`
- Build tools: Vite, Webpack, Rollup
- Testing: Jest, Cypress, Playwright

### Backend Tools
- Multiple runtime options: Node.js, Python, Go, Rust
- Database tools: PostgreSQL, Redis clients
- API tools: `curl`, `httpie`, `postman-cli`
- Container tools: Docker, docker-compose

### DevOps Integration  
- Cloud CLIs: AWS CLI, gcloud, azure-cli
- Infrastructure: Terraform, Ansible
- Monitoring: Prometheus tools

**Acceptance Criteria:**
- [ ] Can scaffold and run full-stack applications
- [ ] Database connectivity works
- [ ] Container orchestration available
- [ ] CI/CD pipeline tools included

---

## Issue #3: Add Embedded Development Environment
**Title:** Embedded systems development shell with hardware toolchains

**Description:**
Environment for embedded and IoT development:

### Hardware Toolchains
- ARM GCC toolchain for Cortex-M/A series
- AVR toolchain for Arduino/ATmega
- ESP-IDF for ESP32/ESP8266
- PlatformIO for multi-platform development

### Development Tools
- OpenOCD, GDB for debugging
- Hardware simulation: QEMU for ARM
- Logic analyzer software: PulseView/sigrok
- Serial communication: minicom, screen

### Programming Languages
- C/C++ with embedded-specific libraries
- Rust for embedded (`cargo-embed`, `probe-run`)
- Python for automation and testing
- Assembly tools

**Acceptance Criteria:**
- [ ] Can build and flash firmware for major platforms
- [ ] Debugging tools work with hardware
- [ ] Cross-compilation for embedded targets
- [ ] Hardware communication protocols supported

---

## Issue #4: Add Machine Learning Development Environment  
**Title:** ML/AI development shell with GPU support and common frameworks

**Description:**
Complete environment for machine learning and AI development:

### Python ML Stack
- Python with data science essentials: pandas, numpy, scipy
- Visualization: matplotlib, seaborn, plotly
- Jupyter notebook/lab environment
- ML frameworks: scikit-learn, XGBoost, LightGBM

### Deep Learning Frameworks
- PyTorch with CUDA support
- TensorFlow/Keras with GPU acceleration  
- JAX for high-performance ML
- Hugging Face transformers

### Data Processing
- Big data tools: Apache Spark (PySpark)
- Database connectors: SQLAlchemy, PyMongo
- Cloud ML: boto3 for AWS, google-cloud for GCP
- Distributed computing: Dask, Ray

### Development Tools
- MLflow for experiment tracking
- Weights & Biases integration
- DVC for data version control
- Code quality: black, isort, mypy

**Acceptance Criteria:**
- [ ] GPU acceleration works (CUDA/ROCm)
- [ ] Can train and deploy models
- [ ] Jupyter environment fully functional
- [ ] Cloud integrations working

---

## Issue #5: Add Game Development Environment
**Title:** Game development shell with engines and graphics tools

**Description:**
Environment for indie game development:

### Game Engines & Frameworks
- Godot with GDScript and C# support
- Unity development tools (for Linux)
- Love2D for Lua-based games
- Bevy framework for Rust game development

### Graphics and Audio Tools  
- Image editing: GIMP, Krita
- 3D modeling: Blender 
- Texture tools: GMIC, ImageMagick
- Audio: Audacity, LMMS
- Pixel art: Aseprite alternative tools

### Programming Languages
- C++ with game-specific libraries (SDL, SFML, OpenGL)
- C# with Mono for cross-platform development
- Rust with gamedev crates
- Lua for scripting

### Asset Pipeline
- Build systems for asset processing
- Version control for binary assets (Git LFS)
- Performance profiling tools
- Platform-specific build tools

**Acceptance Criteria:**
- [ ] Can create and run games with major engines
- [ ] Asset creation tools available
- [ ] Cross-platform building works
- [ ] Performance profiling functional

---

## Issue #6: Add Cross-Compilation Environment
**Title:** Universal cross-compilation shell for multiple targets

**Description:**
Specialized environment for building software across platforms:

### Target Platforms
- Linux: x86_64, ARM64, ARM32, RISC-V
- Windows: x86_64, ARM64 (via mingw-w64)
- macOS: x86_64, ARM64 (Apple Silicon)
- WebAssembly: WASI, Emscripten
- Embedded: ARM Cortex-M, AVR, ESP32

### Language Support
- C/C++ with platform-specific toolchains
- Rust with target installations
- Go with cross-compilation flags
- Zig with universal cross-compilation

### Build Systems
- CMake with toolchain files
- Meson with cross-compilation files  
- Bazel with platform configurations
- Make with target-specific rules

### Testing & Deployment
- QEMU for target emulation
- Container builds for Linux targets
- Code signing tools for distribution
- Package managers for each platform

**Acceptance Criteria:**
- [ ] Can build for all major platforms from Linux
- [ ] Automated testing on target platforms
- [ ] Package generation for distribution
- [ ] Documentation for adding new targets

---

## Issue #7: Add Database Development Environment
**Title:** Database administration and development shell

**Description:**
Environment for database development and administration:

### Database Systems
- PostgreSQL with extensions (PostGIS, TimescaleDB)
- MySQL/MariaDB 
- SQLite with browser tools
- Redis for caching and data structures
- MongoDB for document storage

### Development Tools
- Database IDEs: DBeaver, pgAdmin alternatives
- CLI tools: psql, mysql, redis-cli, mongosh
- Schema migration tools: Flyway, Liquibase
- ORM testing environments

### Data Tools
- ETL frameworks: Apache Airflow
- Data visualization: Grafana, Metabase
- Backup and restore utilities
- Performance monitoring tools

### Programming Language Support
- Python with database connectors
- Node.js with ORMs (Sequelize, Prisma)
- Go with database/sql implementations
- SQL formatter and linter tools

**Acceptance Criteria:**
- [ ] Multiple database systems available
- [ ] Migration tools functional
- [ ] Performance monitoring works
- [ ] Backup/restore procedures documented

---

## Issue #8: Add VFX Platform Compliant Development Environment
**Title:** VFX Platform compliant development shell for Unreal, Houdini, USD, and Maya with multi-platform binary building

**Description:**
Professional VFX development environment following VFX Platform specifications (latest/CY2025) for industry compatibility, optimized for performance-first contribution to major tools:

### VFX Platform Compliance (CY2025)
- **Python**: VFX Platform specified version with performance patches
- **Qt**: VFX Platform specified version (PySide6/Qt6)
- **C++ Compiler**: VFX Platform approved versions (GCC/Clang with ABI compatibility)
- **Operating Systems**: RHEL/CentOS equivalents + Windows 10/11 + macOS
- **Glibc**: VFX Platform specified minimum version for Linux compatibility

### Core VFX Libraries (Performance-Optimized Builds)
- **OpenEXR**: Latest VFX Platform version with SIMD optimizations
- **OpenImageIO**: Built with all codec support and threading optimizations
- **OpenColorIO (OCIO)**: GPU-accelerated transforms where possible
- **OpenVDB**: With Intel TBB and Blosc compression
- **USD (Universal Scene Description)**: All optional components enabled
- **Alembic**: Optimized for large dataset streaming
- **MaterialX**: Latest specification implementation
- **OpenTimelineIO (OTIO)**: With all adapter plugins

### Target Application SDKs
- **Houdini HDK**: Latest version with C++ API priority
- **Maya DevKit**: C++ API with Python bindings when needed
- **Unreal Engine 5**: Source build with performance optimizations
- **Nuke NDK**: For compositing plugin development
- **RenderMan SDK**: Latest PRMan integration tools

### Performance-First Compilation Stack
- **Compiler Optimizations**: -O3, LTO, PGO where applicable
- **SIMD**: AVX2/AVX-512 optimizations for math-heavy operations
- **Multi-threading**: Intel TBB, OpenMP for parallel algorithms
- **Memory Allocators**: jemalloc/tcmalloc for performance
- **GPU Acceleration**: CUDA 12.x, OpenCL, Metal (macOS)

### Multi-Platform Binary Building
- **Linux**: RHEL 8/9, Ubuntu LTS (primary development platform)
- **Windows**: Cross-compilation via MinGW-w64 + MSVC compatibility
- **macOS**: Cross-compilation for Intel + Apple Silicon (Universal binaries)
- **Container Builds**: Docker environments for consistent builds
- **Distribution**: AppImage, .deb, .rpm, .msi, .pkg packaging

### High-Performance Build System
- **CMake**: Latest with CUDA, Metal, and cross-platform presets
- **Ninja**: Fast incremental builds with distributed compilation
- **ccache/sccache**: Aggressive compilation caching
- **Conan**: C++ package management with binary caching
- **Build Automation**: GitHub Actions + self-hosted runners for native builds

### Debugging & Profiling (Performance-Critical)
- **Intel VTune**: CPU profiling and hotspot analysis  
- **NVIDIA Nsight**: GPU profiling for CUDA kernels
- **Valgrind**: Memory debugging with custom suppressions
- **AddressSanitizer**: Fast memory error detection
- **Tracy Profiler**: Real-time performance profiling
- **Perf**: Linux system-level performance analysis

### Development Tools
- **CLion/VS Code**: With VFX-specific extensions and debuggers
- **Clang-format**: VFX industry standard formatting
- **Clang-tidy**: Static analysis with performance lints
- **Doxygen**: API documentation with VFX examples
- **Git LFS**: Large binary asset management

**Performance-First Philosophy:**
- Prioritize C++ over Python for all core development
- Include profiling and benchmarking tools by default  
- Optimize compilation times with distributed building
- Memory-efficient workflows for large datasets
- GPU-accelerated tools where applicable

**Acceptance Criteria:**
- [ ] **VFX Platform Compliance**: All libraries match current VFX Platform specification versions
- [ ] **Multi-Platform Builds**: Successfully build binaries for Linux, Windows, and macOS
- [ ] **Performance Benchmarks**: Include automated performance testing for all core libraries
- [ ] **Application Integration**: Can build plugins for Houdini, Maya, Unreal, and Nuke
- [ ] **USD Pipeline**: Full USD ecosystem builds with MaterialX and Hydra renderers
- [ ] **Memory Performance**: jemalloc/tcmalloc integration shows measurable improvements
- [ ] **GPU Acceleration**: CUDA, OpenCL, and Metal acceleration verified on respective platforms
- [ ] **Build Speed**: Sub-5-minute incremental builds for typical plugin development
- [ ] **Distribution Ready**: Generate installation packages for all target platforms
- [ ] **ABI Compatibility**: Binary compatibility across VFX Platform compliant applications

**Nix Flakes Integration (Consistent with dev-shells architecture):**
- **flake.nix**: Define VFX development shell with all dependencies pinned to VFX Platform versions
- **flake.lock**: Lock file ensuring reproducible builds across machines and time
- **.envrc**: direnv integration for automatic environment activation when entering directory
- **Ephemeral Environment**: No system pollution - everything contained in Nix store
- **Declarative**: All dependencies and versions explicitly declared, no hidden system requirements
- **Reproducible**: Identical environment on any machine with Nix installed

**Example Structure:**
```
vfx-dev/
├── flake.nix              # VFX Platform compliant environment definition
├── flake.lock             # Pinned dependency versions
├── .envrc                 # direnv: "use flake"
├── templates/
│   ├── houdini-plugin/    # HDK plugin template
│   ├── maya-plugin/       # Maya C++ API template
│   ├── usd-plugin/        # USD schema/plugin template
│   └── unreal-plugin/     # UE5 plugin template
└── benchmarks/
    ├── memory-profile.cpp # Memory allocation benchmarks
    ├── simd-perf.cpp      # SIMD optimization tests
    └── gpu-compute.cu     # CUDA performance tests
```

**Implementation Notes:**
- **VFX Reference Platform**: Pin all dependency versions to current VFX Platform specification
- **Nix Overlays**: Create custom overlays for performance-optimized VFX library builds
- **Performance Metrics**: Establish baseline benchmarks before optimizations
- **Cross-Compilation**: Use Nix cross-compilation features for multi-platform builds
- **Binary Distribution**: Leverage Nix binary cache for fast environment setup
- **Plugin Templates**: Provide high-performance plugin scaffolding with Nix build integration
- **Continuous Benchmarking**: Automated performance regression detection in CI/CD
- **Memory Profiling**: Include heap profiling and allocation tracking by default
- **SIMD Optimization**: Leverage platform-specific vector instructions via Nix compiler flags
- **Static Linking Strategy**: Use Nix to manage complex dependency graphs and linking
- **Industry Testing**: Validate against real-world VFX studio workflows and datasets
- **direnv Integration**: Seamless activation when entering project directories