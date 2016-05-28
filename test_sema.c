#include "semaphore.h" 

void test_func(void *arg);
void test_func2(void *arg); 
struct Semaphore s;
int var = 7;
int var1 = 8;

int main(){ 
 
	sem_init(&s,1);	
	void* tid = thread_create(test_func,(void *)&var);
	if(tid == 0) exit(); 
	wait(); 
	void* yid = thread_create(test_func2,(void *)&var1);  
	if(yid == 0) exit(); 
	wait();

	exit();  
	return 0; 
}

void test_func(void *arg) {
	int* num = (void*)arg;  

	sem_acquire(&s); 
	printf(1,"hi %d.\n",*num);		
	sem_signal(&s); 

	texit(); 
} 

void test_func2(void *arg) {
	int* num = (void*)arg;
	
	sem_acquire(&s);  
	printf(1,"hey %d.\n",*num); 
	sem_signal(&s); 

	texit(); 
} 
