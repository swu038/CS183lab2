#include "types.h"
#include "user.h"
#include "queue.h"

struct Semaphore {
	lock_t lock; 
	int count; 
	struct queue q; 
};



void sem_acquire(struct Semaphore *s);

void sem_signal(struct Semaphore *s);

void sem_init(struct Semaphore *s, int size);
