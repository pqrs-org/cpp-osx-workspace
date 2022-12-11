#include <boost/ut.hpp>
#include <pqrs/osx/workspace.hpp>

int main(void) {
  using namespace boost::ut;
  using namespace boost::ut::literals;
  using namespace std::literals::string_literals;

  "find_application_url_by_bundle_identifier"_test = [] {
    expect(pqrs::osx::workspace::find_application_url_by_bundle_identifier("com.apple.Finder") == "file:///System/Library/CoreServices/Finder.app/"s);
    expect(pqrs::osx::workspace::find_application_url_by_bundle_identifier("org.pqrs.NotFound") == ""s);
  };

  return 0;
}
