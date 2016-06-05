#include "semaphore.h" 

void monkey(void *arg);
struct Semaphore tree;  
int coconut_grabbed = 0; 
struct{
	lock_t lock;
}mutex; 

int main() {

	sem_init(&tree,3);

	void* mid = thread_create(monkey,(void *)0); 
	if(mid == 0) exit(); 

	void* mid2 = thread_create(monkey,(void*)0); 
	if(mid2 == 0) exit() ;

	void* mid3 = thread_create(monkey,(void*)0); 
	if(mid3 == 0) exit(); 

	void* mid4 = thread_create(monkey,(void*)0); 
	if(mid4 == 0) exit(); 

	while(wait() > 0);  
	
	exit();
	return 0; 
}

void monkey(void *arg) {
	sem_acquire(&tree); 
	lock_acquire(&mutex.lock);  
	coconut_grabbed++; 
	printf(1,"coconuts grabbed: %d.\n",coconut_grabbed); 	
	lock_release(&mutex.lock); 
	sem_signal(&tree);
	
	texit(); 	
} 
