
#include "semaphore.h"

void monkey(void* arg);
void dominant(void* arg);
struct Semaphore tree, D;
int coconut_grabbed = 0;
int monkeys = 0;
int dom = 0; 
int numMonkeys = 0;  //# of monkeys on tree. 
int dom_Monkey = 0;
struct{
	lock_t lock;
}mutex; 
int boolean = 0; 

int main(){

  sem_init(&tree, 3);
  sem_init(&D, 0);

  void* mid = thread_create(monkey, (void*)0);
  if(mid == 0) exit();

  void* did2 = thread_create(dominant,(void*)0); 
  if(did2 == 0) exit(); 

  void* mid2 = thread_create(monkey, (void*)0);
  if(mid2 == 0) exit();
  
  void* mid3 = thread_create(monkey, (void*)0);
  if(mid3 == 0) exit();
  
  void* mid4 = thread_create(monkey, (void*)0);
  if(mid4 == 0) exit();
 
  void* did = thread_create(dominant, (void*)0);
  if(did == 0) exit();

  while(wait() > 0); 

  printf(1, "Coconuts: %d.\n", coconut_grabbed);
  exit();
  return 0;
}

void monkey(void* arg){
  if(dom != 0 && numMonkeys == 2) 
  {
	lock_acquire(&mutex.lock); 
	boolean = 1; 
	lock_release(&mutex.lock);
	sem_acquire(&D); 
  }
  lock_acquire(&mutex.lock); 
  monkeys++;
  numMonkeys++; 
  printf(1,"A monkey is climbing. Number of monkeys on tree: %d.\n",numMonkeys);  
  lock_release(&mutex.lock); 

  sem_acquire(&tree);
  lock_acquire(&mutex.lock);
  sleep(20);  
  coconut_grabbed++;
  lock_release(&mutex.lock); 
  sem_signal(&tree);  

  lock_acquire(&mutex.lock); 
  numMonkeys--;
  monkeys--;
  printf(1,"A monkey has left. Number of monkeys on tree: %d.\n",numMonkeys);  
  lock_release(&mutex.lock);  
    
  texit();
}

void dominant(void* arg){
  lock_acquire(&mutex.lock); 
  dom++;
  numMonkeys++;
  printf(1, "A dominant monkey is climbing. Number of monkeys on tree: %d.\n",numMonkeys);  
  lock_release(&mutex.lock); 
 
  sem_acquire(&tree); 
  lock_acquire(&mutex.lock);  
  coconut_grabbed++; 
  lock_release(&mutex.lock); 
  sem_signal(&tree); 

  lock_acquire(&mutex.lock); 
  dom--; 
  numMonkeys--; 
  lock_release(&mutex.lock);
  
  if( boolean == 1)
  { 
	lock_acquire(&mutex.lock);
	boolean = 0;
	lock_release(&mutex.lock);  
  	sem_signal(&D);   
  } 
 
  texit();
}
