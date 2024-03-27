#include "user_lib.h"
#include "util/string.h"
#include "util/types.h"

int main(int argc, char *argv[]) {
  int fd;
  char *str = argv[0];
  printu("%s\n", str);
  exit(0);
  return 0;
}
