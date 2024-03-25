/*
 * This app starts a very simple shell and executes some simple commands.
 * The commands are stored in the hostfs_root/shellrc
 * The shell loads the file and executes the command line by line.                 
 */
#include "user_lib.h"
#include "string.h"
#include "util/types.h"

int main(int argc, char *argv[]) {
  char *input = better_malloc(1024);
  char *cwd = better_malloc(1024);
  char *command = better_malloc(1024);
  char *param = better_malloc(1024);
  while (1)
  {
    read_cwd(cwd);
    printu("%s> ", cwd);
    memset(input, 0, 1024);
    scanu(input);
    input[strlen(input) - 1] = '\0'; // omit the \n
    int sep = 0;
    while(sep < strlen(input) && input[sep] != ' ') {
      command[sep] = input[sep];
      sep++;
    }
    command[sep] = '\0';
    if(sep + 1 < strlen(input)) {
      strcpy(param, input + sep + 1);
    } else {
      strcpy(param, "");
    }

    if(0 == strcmp(command, "cd")) { // syscalls
      change_cwd(param);
    } else { // apps
      int pid = fork();
      if(pid == 0) {
        int ret = exec(command, param);
        if (ret == -1)
        printu("exec failed!\n");
      }
      else
      {
        wait(pid);
      }
    }

    
  }
  exit(0);
  return 0;
}
