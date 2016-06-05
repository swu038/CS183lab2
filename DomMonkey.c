#include "semaphore.h"

void Reg_Monkey(void *arg); 
void Dom_Monkey(void *arg); 
struct Semaphore tree; 
int coconut_grabbed = 0; 
struct{
	lock_t lock
}mutex; 

int main() {

	sem_init(&tree,3);   

	

	exit(); 
	return 0;
}

void Reg_Monkey(void *arg) {
	sem_acquire(&tree); 
		
	texit(); 	
}
