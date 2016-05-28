#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
	lock_acquire(&s->lock); 
	if( s->count-- < 0) 
	{
		add_q(&s->q, getpid()); 
		lock_release(&s->lock); 
		tsleep(); 
	} 
	lock_release(&s->lock); 
}

void sem_signal(struct Semaphore *s)
{ 
	lock_acquire(&s->lock); 
	if( s->count++ <= 0) 
	{
		int tid = pop_q(&s->q); 
		twakeup(tid); 
	}
	lock_release(&s->lock); 
} 

void sem_init(struct Semaphore *s, int size){
	lock_init(&s->lock);
	s->count = size; 
	init_q(&s->q);
}
