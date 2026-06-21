#include <boost/ut.hpp>
#include <pqrs/osx/workspace.hpp>
#include <string_view>

int main() {
  using namespace boost::ut;
  using namespace boost::ut::literals;
  using namespace std::literals::string_literals;

  "open_configuration"_test = [] {
    {
      const pqrs::osx::workspace::open_configuration configuration;
      const auto c = configuration.c_struct();

      expect(c.activates);
      expect(c.adds_to_recent_items);
      expect(c.allows_running_application_substitution);
      expect(!c.creates_new_application_instance);
      expect(!c.hides);
      expect(!c.hides_others);
      expect(c.arguments[0] == nullptr);
    }

    {
      const pqrs::osx::workspace::open_configuration configuration{
          .activates = false,
          .arguments = {"--foo", "bar"},
      };
      const auto c = configuration.c_struct();

      expect(!c.activates);
      expect(std::string_view(c.arguments[0]) == "--foo");
      expect(std::string_view(c.arguments[1]) == "bar");
      expect(c.arguments[2] == nullptr);
    }
  };

  "find_application_url_by_bundle_identifier"_test = [] {
    expect(pqrs::osx::workspace::find_application_url_by_bundle_identifier("com.apple.Finder") == "file:///System/Library/CoreServices/Finder.app/"s);
    expect(pqrs::osx::workspace::find_application_url_by_bundle_identifier("org.pqrs.NotFound") == ""s);
  };

  return 0;
}
