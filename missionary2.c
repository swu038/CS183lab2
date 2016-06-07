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
	printf(1,"Created 10 missionary, and 5 Cannibal. There should only be 5 boat rides with none left over. \n"); 
	lock_release(&mutex.lock); 
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
	if(mid == 0) exit(); 

	void *mid2 = thread_create(MissionaryArrives,(void *)0);
	if(mid2 == 0) exit(); 

	void *mid3 = thread_create(MissionaryArrives,(void *)0);
	if(mid3 == 0) exit(); 

	void *mid4 = thread_create(MissionaryArrives,(void *)0);
	if(mid4 == 0) exit(); 

	void *mid5 = thread_create(MissionaryArrives,(void *)0);
	if(mid5 == 0) exit(); 

	void *mid6 = thread_create(MissionaryArrives,(void *)0);
	if(mid6 == 0) exit();

 	void *mid7 = thread_create(MissionaryArrives,(void *)0);
	if(mid7 == 0) exit(); 

	void *mid8 = thread_create(MissionaryArrives,(void *)0);
	if(mid8 == 0) exit(); 

	void *mid9 = thread_create(MissionaryArrives,(void *)0);
	if(mid9 == 0) exit(); 

	void *mid10 = thread_create(MissionaryArrives,(void *)0);
	if(mid10 == 0) exit(); 

	void *cid = thread_create(CannibalArrives,(void *)0); 
	if(cid == 0) exit(); 

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
	if(cid2 == 0) exit(); 

	void *cid3 = thread_create(CannibalArrives,(void *)0); 
	if(cid3 == 0) exit(); 

	void *cid4 = thread_create(CannibalArrives,(void *)0); 
	if(cid4 == 0) exit();

	void *cid5 = thread_create(CannibalArrives,(void *)0);  
	if(cid5 == 0) exit(); 

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
