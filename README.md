[![Build Status](https://github.com/pqrs-org/cpp-osx-workspace/workflows/CI/badge.svg)](https://github.com/pqrs-org/cpp-osx-workspace/actions)
[![License](https://img.shields.io/badge/license-Boost%20Software%20License-blue.svg)](https://github.com/pqrs-org/cpp-osx-workspace/blob/main/LICENSE.md)

# cpp-osx-workspace

Utilities of `NSWorkspace`.

## Install

Copy `include/pqrs` and `vendor/vendor/include` directories into your include directory.

And then configure your project as follows:

- Add `src/pqrs/osx/workspace/PQRSOSXWorkspaceImpl.swift`
- Add `include/pqrs/osx/workspace/impl/Bridging-Header.h` as Bridging Header.
