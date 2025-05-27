#include <iostream>
#include <pqrs/osx/workspace.hpp>
#include <unistd.h>

int main(void) {
  std::cout << "Finder: "
            << pqrs::osx::workspace::find_application_url_by_bundle_identifier("com.apple.Finder") << std::endl;

  std::cout << "Safari: "
            << pqrs::osx::workspace::find_application_url_by_bundle_identifier("com.apple.Safari") << std::endl;

  std::cout << "Karabiner-Elements: "
            << pqrs::osx::workspace::find_application_url_by_bundle_identifier("org.pqrs.Karabiner-Elements.Settings") << std::endl;

  std::cout << "NotFound: "
            << pqrs::osx::workspace::find_application_url_by_bundle_identifier("org.pqrs.NotFound") << std::endl;

  pqrs::osx::workspace::open_application_by_bundle_identifier("com.apple.Safari",
                                                              pqrs::osx::workspace::open_configuration{
                                                                  .activates = false,
                                                              });
  pqrs::osx::workspace::open_application_by_file_path("/System/Applications/Utilities/Activity Monitor.app");

  // pqrs::osx::workspace::open_application_by_file_path(
  //     "/Library/Application Support/org.pqrs/Karabiner-Elements/Karabiner-Updater.app",
  //     pqrs::osx::workspace::open_configuration{
  //         .arguments = {"checkForUpdatesWithBetaVersion"},
  //     });

  std::cout << pqrs::osx::workspace::application_running_by_bundle_identifier("com.apple.Safari") << std::endl;
  std::cout << pqrs::osx::workspace::application_running_by_file_path("/System/Applications/Utilities/Activity Monitor.app") << std::endl;

  // Wait open_application_*
  sleep(1);

  return 0;
}
