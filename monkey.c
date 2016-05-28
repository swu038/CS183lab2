#include "semaphore.h" 

void monkey(void *arg);
struct Semaphore tree;  
int coconut_grabbed = 0; 

int main() {

	sem_init(&tree,3); 
	void* mid = thread_create(monkey,(void *)0); 
	if(mid == 0) exit(); 
	wait(); 
	
	printf(1,"coconuts grabbed: %d.\n",coconut_grabbed); 	

	exit();
	return 0; 
}

void monkey(void *arg) {
	sem_acquire(&tree);  
	coconut_grabbed++;
	sem_signal(&tree);
	
	texit(); 	
} 
