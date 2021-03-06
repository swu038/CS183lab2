#include "semaphore.h" 

struct Semaphore h; 
struct Semaphore o;
void oReady(void *arg); 
void hReady(void *arg); 
int water_molecule = 0; 
int hydrogen = 0; 
int oxygen = 0; 
struct {
	lock_t lock; 
}mutex;  

int main() {
	lock_acquire(&mutex.lock); 	
	printf(1,"Hydrogen count should be 0, and oxygen count should be 1, therefore water should be 0, or infinite loop. \n"); 
	lock_release(&mutex.lock); 	

	sem_init(&h, 0);
	sem_init(&o, 0);
	
	void *oid = thread_create(oReady,(void *)0); 
	if(oid == 0) exit(); 
 
	while(wait() > 0);

	exit(); 
	return 0;
}

void oReady(void *arg) {
	lock_acquire(&mutex.lock); 
	oxygen++; 
	printf(1,"created one oxygen. Oxygen count: %d.\n",oxygen);  
	lock_release(&mutex.lock);
	sem_acquire(&h); 
	sem_acquire(&h);
	sem_signal(&o);
	sem_signal(&o); 
	lock_acquire(&mutex.lock);
	water_molecule++;
 	printf(1,"created water molecule: %d.\n",water_molecule); 	
	lock_release(&mutex.lock); 	 

	texit(); 	
}

void hReady(void *arg) { 
	lock_acquire(&mutex.lock); 
	hydrogen++; 
	printf(1,"created one hydrogen. Hydrogen count: %d.\n",hydrogen); 	
	lock_release(&mutex.lock); 
	sem_signal(&h);
	sem_acquire(&o);	

	texit();  
}  
