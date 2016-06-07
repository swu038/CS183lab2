#include "semaphore.h"

void monkey(void* arg);
void dominant(void* arg);
struct Semaphore tree, dom;
int coconut_grabbed = 0;
int monkeys = 0;
int dmonk = 0;
struct{
	lock_t lock; 
}mutex; 

int main(){
  
  lock_acquire(&mutex.lock); 
  printf(1,"We created 3 dominant monkey, and four regular monkeys\n" ); 
  lock_release(&mutex.lock); 

  sem_init(&tree, 3);
  sem_init(&dom, 1);

  void* cid = thread_create(dominant, (void*)&dmonk);
  if(cid == 0) exit(); 
  void* nid = thread_create(monkey, (void*)&monkeys);
  if(nid == 0) exit();
  void* oid = thread_create(monkey, (void*)&monkeys);
  if(oid == 0) exit();
  void* bid = thread_create(dominant, (void*)&dmonk);
  if(bid == 0) exit();
  void* pid = thread_create(monkey, (void*)&monkeys);
  if(pid == 0) exit();
  void* qid = thread_create(monkey, (void*)&monkeys);
  if(qid == 0) exit();
  void* did = thread_create(dominant, (void*)&dmonk);
  if(did == 0) exit();
  wait();
  wait();
  wait();
  wait();
  wait();
  wait();
  wait();
  
  printf(1, "Coconuts: %d.\n", coconut_grabbed);
  exit();
  return 0;
}

void monkey(void* arg){
    
  monkeys++;
  printf(1, "Monkeys %d.\n", monkeys);
  if(dmonk ==  1){
    printf(1, "waiting\n");
    sem_acquire(&dom);
  }
 
  sem_acquire(&tree);
  sleep(20);  
  coconut_grabbed++;
  sem_signal(&tree);
  
  monkeys--;
  printf(1, "Monkeys out  %d.\n", monkeys);
  if(dmonk >= 0)
      sem_signal(&dom);

  texit();
}

void dominant(void* arg){

  printf(1, "Dominant Monkey.\n");
  sem_acquire(&dom);
  dmonk++;
  sem_acquire(&tree);
  monkeys++;
  coconut_grabbed++;
  monkeys--;
  dmonk--;
  sem_signal(&tree);
   sem_signal(&dom);
          
  texit();
}
