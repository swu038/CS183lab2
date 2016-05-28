#include "semaphore.h" 

struct Semaphore h; 
struct Semaphore o;
void oReady(void *arg); 
void hReady(void *arg); 
int water_molecule = 0; 
struct {
	lock_t lock; 
}mutex;  

int main() {

	sem_init(&h, 1);
	sem_init(&o, 1); 

	void *oid = thread_create(oReady,(void *)0); 
	if(oid == 0) exit(); 
	wait(); 
	void *hid = thread_create(hReady,(void *)0); 
	if(hid == 0) exit();  
	wait(); 

	printf(1,"created water molecule: %d.\n",water_molecule); 
	printf(1, "count of o: %d.\n",h.count);
	exit(); 
	return 0;
}

void oReady(void *arg) {
	sem_acquire(&h); 
	sem_acquire(&h); 
	sem_signal(&o);
	sem_signal(&o); 
	lock_acquire(&mutex.lock);
	water_molecule++; 
	lock_release(&mutex.lock); 	 

	texit(); 	
}

void hReady(void *arg) { 
	sem_signal(&h);
	sem_acquire(&o); 

	texit();  
}  
