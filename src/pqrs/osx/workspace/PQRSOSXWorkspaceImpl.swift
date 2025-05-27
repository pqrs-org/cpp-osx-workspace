// (C) Copyright Takayama Fumihiko 2023.
// Distributed under the Boost Software License, Version 1.0.
// (See https://www.boost.org/LICENSE_1_0.txt)

import AppKit

func makeOpenConfiguration(from cConfig: UnsafePointer<pqrs_osx_workspace_open_configuration>)
  -> NSWorkspace.OpenConfiguration
{
  let config = NSWorkspace.OpenConfiguration()

  config.activates = cConfig.pointee.activates
  config.addsToRecentItems = cConfig.pointee.adds_to_recent_items
  config.allowsRunningApplicationSubstitution =
    cConfig.pointee.allows_running_application_substitution
  config.createsNewApplicationInstance = cConfig.pointee.creates_new_application_instance
  config.hides = cConfig.pointee.hides
  config.hidesOthers = cConfig.pointee.hides_others

  var arguments: [String] = []
  var current = cConfig.pointee.arguments
  while let arg = current?.pointee {
    arguments.append(String(cString: arg))
    current = current!.advanced(by: 1)
  }
  if !arguments.isEmpty {
    config.arguments = arguments
  }

  return config
}

@_cdecl("pqrs_osx_workspace_open_application_by_bundle_identifier")
func pqrs_osx_workspace_open_application_by_bundle_identifier(
  _ bundleIdentifierPtr: UnsafePointer<Int8>,
  _ openConfiguration: UnsafePointer<pqrs_osx_workspace_open_configuration>
) {
  let bundleIdentifier = String(cString: bundleIdentifierPtr)

  if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier) {
    NSWorkspace.shared.openApplication(
      at: url,
      configuration: makeOpenConfiguration(from: openConfiguration),
      completionHandler: nil
    )
  }
}

@_cdecl("pqrs_osx_workspace_open_application_by_file_path")
func pqrs_osx_workspace_open_application_by_file_path(
  _ filePathPtr: UnsafePointer<Int8>,
  _ openConfiguration: UnsafePointer<pqrs_osx_workspace_open_configuration>
) {
  let filePath = String(cString: filePathPtr)

  let url = URL(filePath: filePath, directoryHint: .checkFileSystem, relativeTo: nil)
  NSWorkspace.shared.openApplication(
    at: url,
    configuration: makeOpenConfiguration(from: openConfiguration),
    completionHandler: nil
  )
}

@_cdecl("pqrs_osx_workspace_find_application_url_by_bundle_identifier")
func pqrs_osx_workspace_find_application_url_by_bundle_identifier(
  _ bundleIdentifierPtr: UnsafePointer<Int8>,
  _ buffer: UnsafeMutablePointer<Int8>,
  _ bufferSize: Int32
) {
  let bundleIdentifier = String(cString: bundleIdentifierPtr)
  let urlString =
    NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier)?.absoluteString
    ?? ""

  _ = urlString.utf8CString.withUnsafeBufferPointer { ptr in
    strlcpy(buffer, ptr.baseAddress, Int(bufferSize))
  }
}

@_cdecl("pqrs_osx_workspace_application_running_by_bundle_identifier")
func pqrs_osx_workspace_application_running_by_bundle_identifier(
  _ bundleIdentifierPtr: UnsafePointer<Int8>
) -> Bool {
  let bundleIdentifier = String(cString: bundleIdentifierPtr)

  return !NSRunningApplication.runningApplications(withBundleIdentifier: bundleIdentifier).isEmpty
}

@_cdecl("pqrs_osx_workspace_application_running_by_file_path")
func pqrs_osx_workspace_application_running_by_file_path(
  _ filePathPtr: UnsafePointer<Int8>
) -> Bool {
  let filePath = String(cString: filePathPtr)

  let url = URL(filePath: filePath, directoryHint: .checkFileSystem, relativeTo: nil)
  return NSWorkspace.shared.runningApplications.contains {
    $0.bundleURL == url
  }
}
