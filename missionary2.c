#include "semaphore.h"

void MissionaryArrives(void *arg); 
void CannibalArrives(void *arg);
void RowBoat(); 
int numMissionaries = 0; 
int numCannibals = 0; 
struct Semaphore M;
struct Semaphore C;    
struct{
	lock_t lock; 
}mutex;  
int canCount = 0;
int missCount = 0;  
int numBoat = 0; 

int main() {

	lock_acquire(&mutex.lock); 
	printf(1,"Created 1 missionary, and 2 Cannibal. No boat will set off since the cannibals cannot be with 1 missioanry, infinite loop. \n"); 
	lock_release(&mutex.lock); 
	
	sem_init(&M, 0); 
	sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
	if(mid == 0) exit(); 

	void *cid = thread_create(CannibalArrives,(void *)0); 
	if(cid == 0) exit(); 

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
	if(cid2 == 0) exit(); 

	while(wait() > 0); 

	exit(); 
	return 0;
}

void MissionaryArrives(void *arg) {
	if(numMissionaries == 2) 
	{
		lock_acquire(&mutex.lock);
		missCount++; //for num of miss in boat. 
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&M); 
		RowBoat();
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
		lock_acquire(&mutex.lock);
		missCount++; //for num of miss in boat. 
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&C);
		RowBoat(); 
	} 
	else {
		lock_acquire(&mutex.lock); 
		numMissionaries++;
		missCount++;  //for num of miss in boat.
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
		lock_release(&mutex.lock);  
		sem_acquire(&M);
		lock_acquire(&mutex.lock);  
		numMissionaries--; 
		lock_release(&mutex.lock);  
	} 
	texit();  
}

void CannibalArrives(void *arg) {
	if(numCannibals == 2) 
	{
		lock_acquire(&mutex.lock); 
		canCount++; //for num of can in boat. 
		printf(1,"Number of cannibals arrived: %d.\n",canCount);  
		lock_release(&mutex.lock);  
		sem_signal(&C); 
		sem_signal(&C);
		RowBoat();  		
	}
	else if(numMissionaries == 2) {
		lock_acquire(&mutex.lock); 
		canCount++; //for num of can in boat.  
		lock_release(&mutex.lock);  
		sem_signal(&M);
		sem_signal(&M); 
		RowBoat(); 
	}
	else {
	lock_acquire(&mutex.lock);
	canCount++; //for num of can in boat. 
	printf(1, "Number of cannibals arrived: %d.\n",canCount);  
	numCannibals++; 
	lock_release(&mutex.lock);
	sem_acquire(&C); 
	lock_acquire(&mutex.lock);  
	numCannibals--;
	lock_release(&mutex.lock);
	}
	texit(); 
} 	

void RowBoat() {
	lock_acquire(&mutex.lock); 
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
	printf(1,"Number of missionaries in boat: %d.\n",missCount); 
	numBoat++;
	canCount = 0; 
	missCount = 0; 
	printf(1,"Rowing boat: %d.\n",numBoat);
	lock_release(&mutex.lock); 
	texit();  
} 
