# My Reusable Nix Development Environments (dev-shells)

This repository provides reproducible, declarative, and ephemeral development environments using Nix Flakes.

## Purpose

Instead of defining development environments from scratch in every project, this flake provides pre-configured, reusable shells for common languages and tasks. Projects can use this flake as an input to easily access these consistent environments.

## Available Shells

Currently defined shells (accessible via `devShells.<system>.<name>`):

- `python`: Standard Python 3 environment with common data science libraries (numpy, pandas, etc.) and pip.
- `c-cpp`: C/C++ environment with Clang, Conan, CMake, and Ninja.
- `latex`: A full TeX Live environment for LaTeX document preparation.
- *Many more to follow, contributions welcome :)*

## Usage Examples & Quickstart

### C++ Development

#### Quick Start
```bash
# Enter C++ development environment
nix develop github:dlond/dev-shells#c-cpp

# Create a new project
mkdir my-cpp-project && cd my-cpp-project
echo "use flake github:dlond/dev-shells#c-cpp" > .envrc && direnv allow

# Your tools are now available
clang++ --version
cmake --version
conan --version
```

#### Building a Project
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

#### Performance Optimization
```bash
# Profile your application
perf record ./my-app
perf report

# Memory debugging
valgrind --tool=memcheck ./my-app

# Static analysis
clang-tidy *.cpp -- -std=c++20
```

### Python Development

#### Quick Start
```bash
# Enter Python development environment
nix develop github:dlond/dev-shells#python

# Create a new project
mkdir my-python-project && cd my-python-project
echo "use flake github:dlond/dev-shells#python" > .envrc && direnv allow

# Your tools are now available
python --version
pip --version
jupyter --version
```

#### Data Science Workflow
```bash
# Start Jupyter notebook
jupyter lab

# Install additional packages
pip install --user package-name

# Run analysis scripts
python analysis.py
```

### LaTeX Development

#### Quick Start
```bash
# Enter LaTeX environment
nix develop github:dlond/dev-shells#latex

# Create a new document
mkdir my-paper && cd my-paper
echo "use flake github:dlond/dev-shells#latex" > .envrc && direnv allow

# Compile document
pdflatex document.tex
bibtex document
pdflatex document.tex
pdflatex document.tex
```

### Future VFX Plugin Development (Coming Soon)

When the VFX environment is available, you'll be able to:

#### Houdini HDK Plugin
```bash
# Enter VFX development environment
nix develop github:dlond/dev-shells#vfx

# Create Houdini plugin from template
cp -r templates/houdini-plugin my-houdini-sop
cd my-houdini-sop

# Build and install
mkdir build && cd build
cmake .. -DHOUDINI_VERSION=20.0
make install
```

#### Maya C++ Plugin
```bash
# Maya plugin development
cp -r templates/maya-plugin my-maya-deformer
cd my-maya-deformer

# Build with performance optimizations
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DMAYA_VERSION=2024
make -j$(nproc)
```

#### USD Plugin Development
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

### Integration with IDEs

#### VS Code Setup
```bash
# VS Code with Nix environment
nix develop github:dlond/dev-shells#c-cpp --command code .

# Configure .vscode/settings.json with proper paths
# All tools (clangd, cmake, debugger) will work automatically
```

#### CLion Setup
```bash
# Generate compile_commands.json for CLion
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON ..
ln -s build/compile_commands.json .

# Open project in CLion with environment
nix develop github:dlond/dev-shells#c-cpp --command clion .
```

## Usage: Setting Up a New Project

To use one of these shells in your own project, you can reference this flake as an input and then use the desired shell. Here's how:

### Step 1: Create a `flake.nix` for your project

In your project directory, create a `flake.nix` file:

```nix
{
  description = "My awesome project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    dev-shells.url = "github:dlond/dev-shells";
  };

  outputs = { self, nixpkgs, flake-utils, dev-shells }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShells = {
        # Use the Python shell from dev-shells
        default = dev-shells.devShells.${system}.python;
        
        # You can also create multiple shells or customize them
        cpp = dev-shells.devShells.${system}.c-cpp;
        docs = dev-shells.devShells.${system}.latex;
      };
    });
}
```

### Step 2: Set up direnv (optional but recommended)

Create a `.envrc` file in your project root:

```bash
use flake
```

Then run:

```bash
direnv allow
```

Now, whenever you `cd` into your project directory, the development environment will automatically be activated!

### Step 3: Enter the development shell

If you're not using direnv, you can manually enter the shell:

```bash
nix develop
```

Or use a specific shell:

```bash
nix develop .#cpp
```

## Updating Shells

If the `dev-shells` repository is updated (e.g., new tools added to the Python shell), you can update your project to use the latest version by running this command *inside your project directory*:

```shell
nix flake update dev-shells
```

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests to add new shells or improve existing ones.

### Adding a New Shell

1. Edit `flake.nix` to add your new shell definition
2. Update this README to document the new shell
3. Add usage examples for the new environment
4. Test the shell works as expected
5. Submit a pull request

## License

This project is licensed under the GPL-3.0 License - see the LICENSE file for details.