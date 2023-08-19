[![Build Status](https://github.com/pqrs-org/cpp-osx-workspace/workflows/CI/badge.svg)](https://github.com/pqrs-org/cpp-osx-workspace/actions)
[![License](https://img.shields.io/badge/license-Boost%20Software%20License-blue.svg)](https://github.com/pqrs-org/cpp-osx-workspace/blob/main/LICENSE.md)

# cpp-osx-workspace

Utilities of `NSWorkspace`.

## Install

### Using package manager

You can install `include/pqrs` by using [cget](https://github.com/pfultz2/cget).

```shell
cget install pqrs-org/cget-recipes
cget install pqrs-org/cpp-osx-workspace
```

And then configure your project as follows:

- Add `cget/src/pqrs/osx/workspace/PQRSOSXWorkspaceImpl.swift`
- Add `cget/include/pqrs/osx/workspace/impl/Bridging-Header.h` as Bridging Header.

### Manual install

Copy `include/pqrs` directory into your include directory.

And then configure your project as follows:

- Add `src/pqrs/osx/workspace/PQRSOSXWorkspaceImpl.swift`
- Add `include/pqrs/osx/workspace/impl/Bridging-Header.h` as Bridging Header.
