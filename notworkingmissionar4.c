#include "semaphore.h"

void MissionaryArrives() {PersonArrives(&numMissionaries);} 
void CannibalArrives() {PersonArrives(&numCannibals);} 
void PersonArrives(int *numPeople); 
void RowBoat(); 
int numMissionaries = 0; 
int numCannibals = 0; 
struct Semaphore B; 
struct{
	lock_t lock; 
}mutex;  
int canCount = 0;
int missCount = 0;  
int numBoat = 0; 
bool success;

int main() {

	lock_acquire(&mutex.lock); 
	printf(1,"Created 6 missionary, and 4 Cannibal. No boat will set off since the cannibals cannot be with 1 missioanry, infinite loop. \n"); 
	lock_release(&mutex.lock); 
	
	sem_init(&B, 0); 

	void *mid = thread_create(PersonArrives,(int *numMissionaries)0);
	if(mid == 0) exit(); 

	void *mid2 = thread_create(PersonArrives,(int *numMissionaries)0);
	if(mid2 == 0) exit();

	void *cid = thread_create(PersonArrives,(int *numCannibals)0); 
	if(cid == 0) exit(); 	

	while(wait() > 0); 

	exit(); 
	return 0;
}

void PersonArrives(int *numPeople) {
	for(;;) {
		lock_acquire(&mutex.lock);		 			
		*numPeople++;
		lock_release(&mutex.lock); 
		if((numMissionaries + numCannibals) < 3) 
		{
			sem_acquire(&B); 
		}
		else if(!(numMissionaries ==1) && (numCannibals == 2)) 
		{
			RowBoat();
		}
		else
		{
			success = false;
		} 
		sem_signal(&B);
		sem_signal(&B); 
		if(success)
		{	
			texit();
		} 			
	} 
}

void RowBoat() {
	lock_acquire(&mutex.lock); 
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
	printf(1,"Number of missionaries in boat: %d.\n",missCount);
	printf(1,"m: %d.\n",numMissionaries);  
	numBoat++; 
	printf(1,"Rowing boat: %d.\n",numBoat);
	lock_release(&mutex.lock); 
	texit();  
} 
