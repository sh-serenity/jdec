#define _GNU_SOURCE
#include <errno.h>
#include <linux/sched.h>
#include <linux/types.h>
#include <linux/wait.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <wait.h>
#include <time.h>


int cunt_setup(pid_t pid);
int fuck(char *dik);

char *readfile(char *filename) {
  FILE *f;
  f = fopen(filename, "rb");
  fseek(f, 0, SEEK_END);
  long fsize = ftell(f);
  fseek(f, 0, SEEK_SET);

  char *string = (char *)calloc(fsize + 1, sizeof(char));
  fread(string, fsize, 1, f);
  fclose(f);

  string[fsize] = 0;
  return string;
}

static int pivot_root(const char *new_root, const char *put_old) {
  return syscall(SYS_pivot_root, new_root, put_old);
}

int is_file(const char *path) {
  struct stat path_stat;
  stat(path, &path_stat);
  return S_ISREG(path_stat.st_mode);
}


static int offspring(void *arg) {
  int status;
  char *bufp = (char *)arg;
  const char *put_old = "/oldrootfs";
  char path[512];
  printf(bufp);
  if (mount(bufp, bufp, NULL, MS_BIND, NULL) == -1)
    perror("mount-MS_BIND");
  snprintf(path, sizeof(path), "%s/%s", bufp, put_old);
  printf(path);
  if (mkdir(path, 0777) == -1)
    perror("mkdir");
  char *dest = malloc(128);
  sprintf(dest,"%s/dev",bufp);
  mount("/dev",dest,"tmpfs", MS_BIND | MS_NOSUID | MS_STRICTATIME,NULL);
  
  if (pivot_root(bufp, path) == -1)
    perror("pivot_root");
  
  if (mount("proc", "/proc", "proc",0, NULL) <0)
    printf("error proc mount: %s\n",strerror(errno));
  mount("t", "/sys", "sysfs", 0, NULL);

  if(umount2(put_old,MNT_FORCE))
    printf("umount failed");
  if (rmdir(put_old) == -1)
    printf("rmdir");

  char *argh[] = {"/bin/bash", "/start.sh", NULL};
  execv("/bin/bash", argh);

  wait(NULL);
  
  free(dest);
  return 0;
}

#define STACK_SIZE (1024 * 1024)

int main(int argc, char **argv) {
  int ret;
  int status;
  struct stat *buf;
  char *id = (char*) malloc(4);
  srand(time(0));
  unsigned int i;
  
  void *bufp = malloc(256);
  char *p = malloc(256);
  sprintf(bufp, "/guests/%s", argv[1]);
  printf("%s\n", bufp);

   
  char *start = readfile(argv[2]);
  sprintf(p, "%s/start.sh", bufp);
  FILE *fp = fopen(p, "wb");
  fwrite(start, sizeof(char), strlen(start), fp);
  fclose(fp);
  system("mount --make-rprivate  /");
  char *stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
                     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
  if (stack == MAP_FAILED)
    perror("mmap");
  fuck(argv[3]);
  pid_t pid = clone(offspring, stack + STACK_SIZE, SIGCHLD | CLONE_NEWNS | CLONE_NEWPID | CLONE_NEWUTS | CLONE_NEWNET,
            bufp);
  if(pid<0)
	fprintf(stderr, "clone failed %s\n", strerror(errno));
  cunt_setup(pid);

  if (wait(NULL) == -1)
    perror("wait");

  free(start);
  exit(EXIT_SUCCESS);
}


int fuck(char *dik)
{
    char *set_dik = malloc(64);
    char *set_dik_up = malloc(64);;
    char *add_dik_to_bridge = malloc(64);
    printf("dik is %s\n",dik);
    sprintf(set_dik,"ip link add %s type veth peer name dik1",dik);
    system(set_dik);
    sprintf(set_dik_up,"ip link set %s up",dik);
    system(set_dik_up);
    sprintf(add_dik_to_bridge,"brctl addif br0 %s",dik);
    system(add_dik_to_bridge);
    return 0;
}

int cunt_setup(pid_t pid)
{
    char *cunt;
    sprintf(cunt,"ip link set dik1 netns %d",pid);
    system(cunt);
    return 0;
}
