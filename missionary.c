#include "semaphore.h"

void MissionaryArrives(void *arg); 
void CannibalArrives(void *arg);
void RowBoat(); 
int numMissionaries = 0; 
int numCannibals = 0; 
//struct Semaphore M;
//struct Semaphore C;    
struct{
	lock_t lock; 
}mutex;    
int numBoat = 0; 

int main() {

	lock_acquire(&mutex.lock); 
	printf(1,"Created 1 missionary, and 2 Cannibal. There should be no boat rides since we can't have 2 cannibals with 1 missioanry. \n"); 
	lock_release(&mutex.lock); 
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

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
	lock_acquire(&mutex.lock); 
	if(numMissionaries == 2) 
	{
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
		//sem_signal(&M); 
		//sem_signal(&M);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
		printf(1,"Number of cannibals on boat: %d.\n",0);  
		//lock_release(&mutex.lock);
 
		RowBoat();

		//lock_acquire(&mutex.lock);	 
		numMissionaries = numMissionaries - 3;
		
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
		//sem_signal(&M); 
		//sem_signal(&C);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
		printf(1,"Number of cannibals on boat: %d.\n",1); 
		//lock_release(&mutex.lock); 

		RowBoat();

		//lock_acquire(&mutex.lock);  
		numMissionaries = numMissionaries - 2; 
		numCannibals--; 
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");
		//lock_release(&mutex.lock); 
		//texit(); 
			 
	} 
	else {
		//lock_acquire(&mutex.lock); 
		numMissionaries++;
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
		//lock_release(&mutex.lock); 
		//texit();   
	}
	lock_release(&mutex.lock);
	texit(); 
}

void CannibalArrives(void *arg) {
	lock_acquire(&mutex.lock); 
	if(numCannibals == 2) 
	{
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
 		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
		printf(1, "Number of missionaries on boat: %d.\n",0);  
		//lock_release(&mutex.lock);  
		//sem_signal(&C); 
		//sem_signal(&C);
		RowBoat(); 
 	
		//lock_acquire(&mutex.lock); 
		numCannibals = numCannibals -3;  

		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock); 
		//texit();	
	}
	else if(numMissionaries == 2) {
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
		printf(1, "Number of missionaries on boat: %d.\n",2);  
		//lock_release(&mutex.lock);  
		//sem_signal(&M);
		//sem_signal(&M); 
		RowBoat();

		//lock_acquire(&mutex.lock); 
		numCannibals--; 
		numMissionaries = numMissionaries -2; 
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries); 
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock); 
		//texit(); 
	}
	else {
		//lock_acquire(&mutex.lock); 
		numCannibals++; 
		printf(1, "Number of cannibals arrived: %d.\n",numCannibals);  
		//lock_release(&mutex.lock);
		//texit();  
	}
	lock_release(&mutex.lock); 
	texit(); 
} 

void RowBoat() {
	//lock_acquire(&mutex.lock); 
	//printf(1,"Number of cannibals in boat: %d.\n",numCannibals); 
	//printf(1,"Number of missionaries in boat: %d.\n",numMissionaries); 
	numBoat++; 
	printf(1,"Rowing boat: %d.\n",numBoat);
	//lock_release(&mutex.lock); 
	  
} 
