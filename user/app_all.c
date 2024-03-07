#include "user_lib.h"
#include "util/string.h"
#include "util/types.h"

int main(int argc, char *argv[]) {
  
  char *buf = naive_malloc();
  while(1) {
    scanu(buf);
    printu("%s\n", buf);
  }
  
  naive_free(buf);
  exit(0);
  return 0;
}
