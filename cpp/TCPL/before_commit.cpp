#include <filesystem>
#include <iostream>
#include <magic.h>
#include <string>

namespace fs = std::filesystem;

int main(int argc, char const *argv[]) {
  auto magic_cookie = magic_open(MAGIC_MIME);
  magic_load(magic_cookie, nullptr);

  fs::directory_iterator list(fs::current_path());

  for (auto &it : list) {
    if (fs::is_regular_file(it.path())) {
      std::string file_type_string(magic_file(magic_cookie, it.path().c_str()));
      std::string file_name(it.path().filename());
      std::cout << it.path().filename() << " " << file_type_string << std::endl;

      if (file_type_string.find("text") == std::string::npos &&
          file_name.find("before_commit") == std::string::npos) {
        fs::remove(it.path());
      }
    }
  }

  return 0;
}
