
_missionary1:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
}mutex;  
int canCount = 0;
int missCount = 0;  
int numBoat = 0; 

int main() {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp

	lock_acquire(&mutex.lock); 
    1009:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1010:	e8 93 0b 00 00       	call   1ba8 <lock_acquire>
	printf(1,"Created 1 missionary, and 1 Cannibal. No boat will set off, infinite loop. \n"); 
    1015:	c7 44 24 04 d0 1e 00 	movl   $0x1ed0,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 90 07 00 00       	call   17b9 <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1030:	e8 92 0b 00 00       	call   1bc7 <lock_release>
	
	sem_init(&M, 0); 
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    1044:	e8 5c 0e 00 00       	call   1ea5 <sem_init>
	sem_init(&C, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 38 20 00 00 	movl   $0x2038,(%esp)
    1058:	e8 48 0e 00 00       	call   1ea5 <sem_init>

	void *mid = thread_create(MissionaryArrives,(void *)0);
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 b3 10 00 00 	movl   $0x10b3,(%esp)
    106c:	e8 71 0b 00 00       	call   1be2 <thread_create>
    1071:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid == 0) exit(); 
    1075:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 97 05 00 00       	call   1618 <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 ea 11 00 00 	movl   $0x11ea,(%esp)
    1090:	e8 4d 0b 00 00       	call   1be2 <thread_create>
    1095:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(cid == 0) exit(); 
    1099:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 73 05 00 00       	call   1618 <exit>

	while(wait() > 0); 
    10a5:	e8 76 05 00 00       	call   1620 <wait>
    10aa:	85 c0                	test   %eax,%eax
    10ac:	7f f7                	jg     10a5 <main+0xa5>

	exit(); 
    10ae:	e8 65 05 00 00       	call   1618 <exit>

000010b3 <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    10b3:	55                   	push   %ebp
    10b4:	89 e5                	mov    %esp,%ebp
    10b6:	83 ec 18             	sub    $0x18,%esp
	if(numMissionaries == 2) 
    10b9:	a1 14 20 00 00       	mov    0x2014,%eax
    10be:	83 f8 02             	cmp    $0x2,%eax
    10c1:	75 47                	jne    110a <MissionaryArrives+0x57>
	{
		lock_acquire(&mutex.lock);
    10c3:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    10ca:	e8 d9 0a 00 00       	call   1ba8 <lock_acquire>
		missCount++; //for num of miss in boat. 
    10cf:	a1 20 20 00 00       	mov    0x2020,%eax
    10d4:	83 c0 01             	add    $0x1,%eax
    10d7:	a3 20 20 00 00       	mov    %eax,0x2020
		lock_release(&mutex.lock);
    10dc:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    10e3:	e8 df 0a 00 00       	call   1bc7 <lock_release>
		sem_signal(&M); 
    10e8:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    10ef:	e8 5e 0d 00 00       	call   1e52 <sem_signal>
		sem_signal(&M); 
    10f4:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    10fb:	e8 52 0d 00 00       	call   1e52 <sem_signal>
		RowBoat();
    1100:	e8 12 02 00 00       	call   1317 <RowBoat>
    1105:	e9 db 00 00 00       	jmp    11e5 <MissionaryArrives+0x132>
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    110a:	a1 14 20 00 00       	mov    0x2014,%eax
    110f:	83 f8 01             	cmp    $0x1,%eax
    1112:	75 51                	jne    1165 <MissionaryArrives+0xb2>
    1114:	a1 18 20 00 00       	mov    0x2018,%eax
    1119:	83 f8 01             	cmp    $0x1,%eax
    111c:	75 47                	jne    1165 <MissionaryArrives+0xb2>
		lock_acquire(&mutex.lock);
    111e:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1125:	e8 7e 0a 00 00       	call   1ba8 <lock_acquire>
		missCount++; //for num of miss in boat. 
    112a:	a1 20 20 00 00       	mov    0x2020,%eax
    112f:	83 c0 01             	add    $0x1,%eax
    1132:	a3 20 20 00 00       	mov    %eax,0x2020
		lock_release(&mutex.lock);
    1137:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    113e:	e8 84 0a 00 00       	call   1bc7 <lock_release>
		sem_signal(&M); 
    1143:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    114a:	e8 03 0d 00 00       	call   1e52 <sem_signal>
		sem_signal(&C);
    114f:	c7 04 24 38 20 00 00 	movl   $0x2038,(%esp)
    1156:	e8 f7 0c 00 00       	call   1e52 <sem_signal>
		RowBoat(); 
    115b:	e8 b7 01 00 00       	call   1317 <RowBoat>
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&M); 
		RowBoat();
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1160:	e9 80 00 00 00       	jmp    11e5 <MissionaryArrives+0x132>
		sem_signal(&M); 
		sem_signal(&C);
		RowBoat(); 
	} 
	else {
		lock_acquire(&mutex.lock); 
    1165:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    116c:	e8 37 0a 00 00       	call   1ba8 <lock_acquire>
		numMissionaries++;
    1171:	a1 14 20 00 00       	mov    0x2014,%eax
    1176:	83 c0 01             	add    $0x1,%eax
    1179:	a3 14 20 00 00       	mov    %eax,0x2014
		missCount++;  //for num of miss in boat.
    117e:	a1 20 20 00 00       	mov    0x2020,%eax
    1183:	83 c0 01             	add    $0x1,%eax
    1186:	a3 20 20 00 00       	mov    %eax,0x2020
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
    118b:	a1 20 20 00 00       	mov    0x2020,%eax
    1190:	89 44 24 08          	mov    %eax,0x8(%esp)
    1194:	c7 44 24 04 20 1f 00 	movl   $0x1f20,0x4(%esp)
    119b:	00 
    119c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11a3:	e8 11 06 00 00       	call   17b9 <printf>
		lock_release(&mutex.lock);  
    11a8:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    11af:	e8 13 0a 00 00       	call   1bc7 <lock_release>
		sem_acquire(&M);
    11b4:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    11bb:	e8 34 0c 00 00       	call   1df4 <sem_acquire>
		lock_acquire(&mutex.lock);  
    11c0:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    11c7:	e8 dc 09 00 00       	call   1ba8 <lock_acquire>
		numMissionaries--; 
    11cc:	a1 14 20 00 00       	mov    0x2014,%eax
    11d1:	83 e8 01             	sub    $0x1,%eax
    11d4:	a3 14 20 00 00       	mov    %eax,0x2014
		lock_release(&mutex.lock);  
    11d9:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    11e0:	e8 e2 09 00 00       	call   1bc7 <lock_release>
	} 
	texit();  
    11e5:	e8 d6 04 00 00       	call   16c0 <texit>

000011ea <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    11ea:	55                   	push   %ebp
    11eb:	89 e5                	mov    %esp,%ebp
    11ed:	83 ec 18             	sub    $0x18,%esp
	if(numCannibals == 2) 
    11f0:	a1 18 20 00 00       	mov    0x2018,%eax
    11f5:	83 f8 02             	cmp    $0x2,%eax
    11f8:	75 47                	jne    1241 <CannibalArrives+0x57>
	{
		lock_acquire(&mutex.lock); 
    11fa:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1201:	e8 a2 09 00 00       	call   1ba8 <lock_acquire>
		canCount++; //for num of can in boat.  
    1206:	a1 1c 20 00 00       	mov    0x201c,%eax
    120b:	83 c0 01             	add    $0x1,%eax
    120e:	a3 1c 20 00 00       	mov    %eax,0x201c
		lock_release(&mutex.lock);  
    1213:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    121a:	e8 a8 09 00 00       	call   1bc7 <lock_release>
		sem_signal(&C); 
    121f:	c7 04 24 38 20 00 00 	movl   $0x2038,(%esp)
    1226:	e8 27 0c 00 00       	call   1e52 <sem_signal>
		sem_signal(&C);
    122b:	c7 04 24 38 20 00 00 	movl   $0x2038,(%esp)
    1232:	e8 1b 0c 00 00       	call   1e52 <sem_signal>
		RowBoat();  		
    1237:	e8 db 00 00 00       	call   1317 <RowBoat>
    123c:	e9 d1 00 00 00       	jmp    1312 <CannibalArrives+0x128>
	}
	else if(numMissionaries == 2) {
    1241:	a1 14 20 00 00       	mov    0x2014,%eax
    1246:	83 f8 02             	cmp    $0x2,%eax
    1249:	75 47                	jne    1292 <CannibalArrives+0xa8>
		lock_acquire(&mutex.lock); 
    124b:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1252:	e8 51 09 00 00       	call   1ba8 <lock_acquire>
		canCount++; //for num of can in boat.  
    1257:	a1 1c 20 00 00       	mov    0x201c,%eax
    125c:	83 c0 01             	add    $0x1,%eax
    125f:	a3 1c 20 00 00       	mov    %eax,0x201c
		lock_release(&mutex.lock);  
    1264:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    126b:	e8 57 09 00 00       	call   1bc7 <lock_release>
		sem_signal(&M);
    1270:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    1277:	e8 d6 0b 00 00       	call   1e52 <sem_signal>
		sem_signal(&M); 
    127c:	c7 04 24 4c 20 00 00 	movl   $0x204c,(%esp)
    1283:	e8 ca 0b 00 00       	call   1e52 <sem_signal>
		RowBoat(); 
    1288:	e8 8a 00 00 00       	call   1317 <RowBoat>
    128d:	e9 80 00 00 00       	jmp    1312 <CannibalArrives+0x128>
	}
	else {
	lock_acquire(&mutex.lock);
    1292:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1299:	e8 0a 09 00 00       	call   1ba8 <lock_acquire>
	canCount++; //for num of can in boat. 
    129e:	a1 1c 20 00 00       	mov    0x201c,%eax
    12a3:	83 c0 01             	add    $0x1,%eax
    12a6:	a3 1c 20 00 00       	mov    %eax,0x201c
	printf(1, "Number of cannibals arrived: %d.\n",canCount);  
    12ab:	a1 1c 20 00 00       	mov    0x201c,%eax
    12b0:	89 44 24 08          	mov    %eax,0x8(%esp)
    12b4:	c7 44 24 04 48 1f 00 	movl   $0x1f48,0x4(%esp)
    12bb:	00 
    12bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12c3:	e8 f1 04 00 00       	call   17b9 <printf>
	numCannibals++; 
    12c8:	a1 18 20 00 00       	mov    0x2018,%eax
    12cd:	83 c0 01             	add    $0x1,%eax
    12d0:	a3 18 20 00 00       	mov    %eax,0x2018
	lock_release(&mutex.lock);
    12d5:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    12dc:	e8 e6 08 00 00       	call   1bc7 <lock_release>
	sem_acquire(&C); 
    12e1:	c7 04 24 38 20 00 00 	movl   $0x2038,(%esp)
    12e8:	e8 07 0b 00 00       	call   1df4 <sem_acquire>
	lock_acquire(&mutex.lock);  
    12ed:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    12f4:	e8 af 08 00 00       	call   1ba8 <lock_acquire>
	numCannibals--;
    12f9:	a1 18 20 00 00       	mov    0x2018,%eax
    12fe:	83 e8 01             	sub    $0x1,%eax
    1301:	a3 18 20 00 00       	mov    %eax,0x2018
	lock_release(&mutex.lock);
    1306:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    130d:	e8 b5 08 00 00       	call   1bc7 <lock_release>
	}
	texit(); 
    1312:	e8 a9 03 00 00       	call   16c0 <texit>

00001317 <RowBoat>:
} 	

void RowBoat() {
    1317:	55                   	push   %ebp
    1318:	89 e5                	mov    %esp,%ebp
    131a:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    131d:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    1324:	e8 7f 08 00 00       	call   1ba8 <lock_acquire>
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
    1329:	a1 1c 20 00 00       	mov    0x201c,%eax
    132e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1332:	c7 44 24 04 6c 1f 00 	movl   $0x1f6c,0x4(%esp)
    1339:	00 
    133a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1341:	e8 73 04 00 00       	call   17b9 <printf>
	printf(1,"Number of missionaries in boat: %d.\n",missCount); 
    1346:	a1 20 20 00 00       	mov    0x2020,%eax
    134b:	89 44 24 08          	mov    %eax,0x8(%esp)
    134f:	c7 44 24 04 90 1f 00 	movl   $0x1f90,0x4(%esp)
    1356:	00 
    1357:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    135e:	e8 56 04 00 00       	call   17b9 <printf>
	numBoat++;
    1363:	a1 24 20 00 00       	mov    0x2024,%eax
    1368:	83 c0 01             	add    $0x1,%eax
    136b:	a3 24 20 00 00       	mov    %eax,0x2024
	canCount = 0; 
    1370:	c7 05 1c 20 00 00 00 	movl   $0x0,0x201c
    1377:	00 00 00 
	missCount = 0; 
    137a:	c7 05 20 20 00 00 00 	movl   $0x0,0x2020
    1381:	00 00 00 
	printf(1,"Rowing boat: %d.\n",numBoat);
    1384:	a1 24 20 00 00       	mov    0x2024,%eax
    1389:	89 44 24 08          	mov    %eax,0x8(%esp)
    138d:	c7 44 24 04 b5 1f 00 	movl   $0x1fb5,0x4(%esp)
    1394:	00 
    1395:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    139c:	e8 18 04 00 00       	call   17b9 <printf>
	lock_release(&mutex.lock); 
    13a1:	c7 04 24 34 20 00 00 	movl   $0x2034,(%esp)
    13a8:	e8 1a 08 00 00       	call   1bc7 <lock_release>
	texit();  
    13ad:	e8 0e 03 00 00       	call   16c0 <texit>
    13b2:	90                   	nop
    13b3:	90                   	nop

000013b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    13b4:	55                   	push   %ebp
    13b5:	89 e5                	mov    %esp,%ebp
    13b7:	57                   	push   %edi
    13b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    13b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13bc:	8b 55 10             	mov    0x10(%ebp),%edx
    13bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    13c2:	89 cb                	mov    %ecx,%ebx
    13c4:	89 df                	mov    %ebx,%edi
    13c6:	89 d1                	mov    %edx,%ecx
    13c8:	fc                   	cld    
    13c9:	f3 aa                	rep stos %al,%es:(%edi)
    13cb:	89 ca                	mov    %ecx,%edx
    13cd:	89 fb                	mov    %edi,%ebx
    13cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
    13d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    13d5:	5b                   	pop    %ebx
    13d6:	5f                   	pop    %edi
    13d7:	5d                   	pop    %ebp
    13d8:	c3                   	ret    

000013d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    13d9:	55                   	push   %ebp
    13da:	89 e5                	mov    %esp,%ebp
    13dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    13df:	8b 45 08             	mov    0x8(%ebp),%eax
    13e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    13e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e8:	0f b6 10             	movzbl (%eax),%edx
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	88 10                	mov    %dl,(%eax)
    13f0:	8b 45 08             	mov    0x8(%ebp),%eax
    13f3:	0f b6 00             	movzbl (%eax),%eax
    13f6:	84 c0                	test   %al,%al
    13f8:	0f 95 c0             	setne  %al
    13fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13ff:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1403:	84 c0                	test   %al,%al
    1405:	75 de                	jne    13e5 <strcpy+0xc>
    ;
  return os;
    1407:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    140a:	c9                   	leave  
    140b:	c3                   	ret    

0000140c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    140c:	55                   	push   %ebp
    140d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    140f:	eb 08                	jmp    1419 <strcmp+0xd>
    p++, q++;
    1411:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1415:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
    141c:	0f b6 00             	movzbl (%eax),%eax
    141f:	84 c0                	test   %al,%al
    1421:	74 10                	je     1433 <strcmp+0x27>
    1423:	8b 45 08             	mov    0x8(%ebp),%eax
    1426:	0f b6 10             	movzbl (%eax),%edx
    1429:	8b 45 0c             	mov    0xc(%ebp),%eax
    142c:	0f b6 00             	movzbl (%eax),%eax
    142f:	38 c2                	cmp    %al,%dl
    1431:	74 de                	je     1411 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1433:	8b 45 08             	mov    0x8(%ebp),%eax
    1436:	0f b6 00             	movzbl (%eax),%eax
    1439:	0f b6 d0             	movzbl %al,%edx
    143c:	8b 45 0c             	mov    0xc(%ebp),%eax
    143f:	0f b6 00             	movzbl (%eax),%eax
    1442:	0f b6 c0             	movzbl %al,%eax
    1445:	89 d1                	mov    %edx,%ecx
    1447:	29 c1                	sub    %eax,%ecx
    1449:	89 c8                	mov    %ecx,%eax
}
    144b:	5d                   	pop    %ebp
    144c:	c3                   	ret    

0000144d <strlen>:

uint
strlen(char *s)
{
    144d:	55                   	push   %ebp
    144e:	89 e5                	mov    %esp,%ebp
    1450:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1453:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    145a:	eb 04                	jmp    1460 <strlen+0x13>
    145c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1460:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1463:	03 45 08             	add    0x8(%ebp),%eax
    1466:	0f b6 00             	movzbl (%eax),%eax
    1469:	84 c0                	test   %al,%al
    146b:	75 ef                	jne    145c <strlen+0xf>
    ;
  return n;
    146d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1470:	c9                   	leave  
    1471:	c3                   	ret    

00001472 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1472:	55                   	push   %ebp
    1473:	89 e5                	mov    %esp,%ebp
    1475:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1478:	8b 45 10             	mov    0x10(%ebp),%eax
    147b:	89 44 24 08          	mov    %eax,0x8(%esp)
    147f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1482:	89 44 24 04          	mov    %eax,0x4(%esp)
    1486:	8b 45 08             	mov    0x8(%ebp),%eax
    1489:	89 04 24             	mov    %eax,(%esp)
    148c:	e8 23 ff ff ff       	call   13b4 <stosb>
  return dst;
    1491:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1494:	c9                   	leave  
    1495:	c3                   	ret    

00001496 <strchr>:

char*
strchr(const char *s, char c)
{
    1496:	55                   	push   %ebp
    1497:	89 e5                	mov    %esp,%ebp
    1499:	83 ec 04             	sub    $0x4,%esp
    149c:	8b 45 0c             	mov    0xc(%ebp),%eax
    149f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    14a2:	eb 14                	jmp    14b8 <strchr+0x22>
    if(*s == c)
    14a4:	8b 45 08             	mov    0x8(%ebp),%eax
    14a7:	0f b6 00             	movzbl (%eax),%eax
    14aa:	3a 45 fc             	cmp    -0x4(%ebp),%al
    14ad:	75 05                	jne    14b4 <strchr+0x1e>
      return (char*)s;
    14af:	8b 45 08             	mov    0x8(%ebp),%eax
    14b2:	eb 13                	jmp    14c7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    14b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14b8:	8b 45 08             	mov    0x8(%ebp),%eax
    14bb:	0f b6 00             	movzbl (%eax),%eax
    14be:	84 c0                	test   %al,%al
    14c0:	75 e2                	jne    14a4 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    14c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14c7:	c9                   	leave  
    14c8:	c3                   	ret    

000014c9 <gets>:

char*
gets(char *buf, int max)
{
    14c9:	55                   	push   %ebp
    14ca:	89 e5                	mov    %esp,%ebp
    14cc:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14d6:	eb 44                	jmp    151c <gets+0x53>
    cc = read(0, &c, 1);
    14d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14df:	00 
    14e0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    14e3:	89 44 24 04          	mov    %eax,0x4(%esp)
    14e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14ee:	e8 3d 01 00 00       	call   1630 <read>
    14f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    14f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14fa:	7e 2d                	jle    1529 <gets+0x60>
      break;
    buf[i++] = c;
    14fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14ff:	03 45 08             	add    0x8(%ebp),%eax
    1502:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1506:	88 10                	mov    %dl,(%eax)
    1508:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    150c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1510:	3c 0a                	cmp    $0xa,%al
    1512:	74 16                	je     152a <gets+0x61>
    1514:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1518:	3c 0d                	cmp    $0xd,%al
    151a:	74 0e                	je     152a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    151c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    151f:	83 c0 01             	add    $0x1,%eax
    1522:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1525:	7c b1                	jl     14d8 <gets+0xf>
    1527:	eb 01                	jmp    152a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1529:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    152a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    152d:	03 45 08             	add    0x8(%ebp),%eax
    1530:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1533:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1536:	c9                   	leave  
    1537:	c3                   	ret    

00001538 <stat>:

int
stat(char *n, struct stat *st)
{
    1538:	55                   	push   %ebp
    1539:	89 e5                	mov    %esp,%ebp
    153b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    153e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1545:	00 
    1546:	8b 45 08             	mov    0x8(%ebp),%eax
    1549:	89 04 24             	mov    %eax,(%esp)
    154c:	e8 07 01 00 00       	call   1658 <open>
    1551:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1554:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1558:	79 07                	jns    1561 <stat+0x29>
    return -1;
    155a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    155f:	eb 23                	jmp    1584 <stat+0x4c>
  r = fstat(fd, st);
    1561:	8b 45 0c             	mov    0xc(%ebp),%eax
    1564:	89 44 24 04          	mov    %eax,0x4(%esp)
    1568:	8b 45 f0             	mov    -0x10(%ebp),%eax
    156b:	89 04 24             	mov    %eax,(%esp)
    156e:	e8 fd 00 00 00       	call   1670 <fstat>
    1573:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1576:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1579:	89 04 24             	mov    %eax,(%esp)
    157c:	e8 bf 00 00 00       	call   1640 <close>
  return r;
    1581:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1584:	c9                   	leave  
    1585:	c3                   	ret    

00001586 <atoi>:

int
atoi(const char *s)
{
    1586:	55                   	push   %ebp
    1587:	89 e5                	mov    %esp,%ebp
    1589:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    158c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1593:	eb 24                	jmp    15b9 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1595:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1598:	89 d0                	mov    %edx,%eax
    159a:	c1 e0 02             	shl    $0x2,%eax
    159d:	01 d0                	add    %edx,%eax
    159f:	01 c0                	add    %eax,%eax
    15a1:	89 c2                	mov    %eax,%edx
    15a3:	8b 45 08             	mov    0x8(%ebp),%eax
    15a6:	0f b6 00             	movzbl (%eax),%eax
    15a9:	0f be c0             	movsbl %al,%eax
    15ac:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15af:	83 e8 30             	sub    $0x30,%eax
    15b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    15b9:	8b 45 08             	mov    0x8(%ebp),%eax
    15bc:	0f b6 00             	movzbl (%eax),%eax
    15bf:	3c 2f                	cmp    $0x2f,%al
    15c1:	7e 0a                	jle    15cd <atoi+0x47>
    15c3:	8b 45 08             	mov    0x8(%ebp),%eax
    15c6:	0f b6 00             	movzbl (%eax),%eax
    15c9:	3c 39                	cmp    $0x39,%al
    15cb:	7e c8                	jle    1595 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    15cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15d0:	c9                   	leave  
    15d1:	c3                   	ret    

000015d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    15d2:	55                   	push   %ebp
    15d3:	89 e5                	mov    %esp,%ebp
    15d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    15de:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    15e4:	eb 13                	jmp    15f9 <memmove+0x27>
    *dst++ = *src++;
    15e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15e9:	0f b6 10             	movzbl (%eax),%edx
    15ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15ef:	88 10                	mov    %dl,(%eax)
    15f1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    15f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    15f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15fd:	0f 9f c0             	setg   %al
    1600:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1604:	84 c0                	test   %al,%al
    1606:	75 de                	jne    15e6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1608:	8b 45 08             	mov    0x8(%ebp),%eax
}
    160b:	c9                   	leave  
    160c:	c3                   	ret    
    160d:	90                   	nop
    160e:	90                   	nop
    160f:	90                   	nop

00001610 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1610:	b8 01 00 00 00       	mov    $0x1,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <exit>:
SYSCALL(exit)
    1618:	b8 02 00 00 00       	mov    $0x2,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <wait>:
SYSCALL(wait)
    1620:	b8 03 00 00 00       	mov    $0x3,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <pipe>:
SYSCALL(pipe)
    1628:	b8 04 00 00 00       	mov    $0x4,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <read>:
SYSCALL(read)
    1630:	b8 05 00 00 00       	mov    $0x5,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <write>:
SYSCALL(write)
    1638:	b8 10 00 00 00       	mov    $0x10,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <close>:
SYSCALL(close)
    1640:	b8 15 00 00 00       	mov    $0x15,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    

00001648 <kill>:
SYSCALL(kill)
    1648:	b8 06 00 00 00       	mov    $0x6,%eax
    164d:	cd 40                	int    $0x40
    164f:	c3                   	ret    

00001650 <exec>:
SYSCALL(exec)
    1650:	b8 07 00 00 00       	mov    $0x7,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    

00001658 <open>:
SYSCALL(open)
    1658:	b8 0f 00 00 00       	mov    $0xf,%eax
    165d:	cd 40                	int    $0x40
    165f:	c3                   	ret    

00001660 <mknod>:
SYSCALL(mknod)
    1660:	b8 11 00 00 00       	mov    $0x11,%eax
    1665:	cd 40                	int    $0x40
    1667:	c3                   	ret    

00001668 <unlink>:
SYSCALL(unlink)
    1668:	b8 12 00 00 00       	mov    $0x12,%eax
    166d:	cd 40                	int    $0x40
    166f:	c3                   	ret    

00001670 <fstat>:
SYSCALL(fstat)
    1670:	b8 08 00 00 00       	mov    $0x8,%eax
    1675:	cd 40                	int    $0x40
    1677:	c3                   	ret    

00001678 <link>:
SYSCALL(link)
    1678:	b8 13 00 00 00       	mov    $0x13,%eax
    167d:	cd 40                	int    $0x40
    167f:	c3                   	ret    

00001680 <mkdir>:
SYSCALL(mkdir)
    1680:	b8 14 00 00 00       	mov    $0x14,%eax
    1685:	cd 40                	int    $0x40
    1687:	c3                   	ret    

00001688 <chdir>:
SYSCALL(chdir)
    1688:	b8 09 00 00 00       	mov    $0x9,%eax
    168d:	cd 40                	int    $0x40
    168f:	c3                   	ret    

00001690 <dup>:
SYSCALL(dup)
    1690:	b8 0a 00 00 00       	mov    $0xa,%eax
    1695:	cd 40                	int    $0x40
    1697:	c3                   	ret    

00001698 <getpid>:
SYSCALL(getpid)
    1698:	b8 0b 00 00 00       	mov    $0xb,%eax
    169d:	cd 40                	int    $0x40
    169f:	c3                   	ret    

000016a0 <sbrk>:
SYSCALL(sbrk)
    16a0:	b8 0c 00 00 00       	mov    $0xc,%eax
    16a5:	cd 40                	int    $0x40
    16a7:	c3                   	ret    

000016a8 <sleep>:
SYSCALL(sleep)
    16a8:	b8 0d 00 00 00       	mov    $0xd,%eax
    16ad:	cd 40                	int    $0x40
    16af:	c3                   	ret    

000016b0 <uptime>:
SYSCALL(uptime)
    16b0:	b8 0e 00 00 00       	mov    $0xe,%eax
    16b5:	cd 40                	int    $0x40
    16b7:	c3                   	ret    

000016b8 <clone>:
SYSCALL(clone)
    16b8:	b8 16 00 00 00       	mov    $0x16,%eax
    16bd:	cd 40                	int    $0x40
    16bf:	c3                   	ret    

000016c0 <texit>:
SYSCALL(texit)
    16c0:	b8 17 00 00 00       	mov    $0x17,%eax
    16c5:	cd 40                	int    $0x40
    16c7:	c3                   	ret    

000016c8 <tsleep>:
SYSCALL(tsleep)
    16c8:	b8 18 00 00 00       	mov    $0x18,%eax
    16cd:	cd 40                	int    $0x40
    16cf:	c3                   	ret    

000016d0 <twakeup>:
SYSCALL(twakeup)
    16d0:	b8 19 00 00 00       	mov    $0x19,%eax
    16d5:	cd 40                	int    $0x40
    16d7:	c3                   	ret    

000016d8 <thread_yield>:
SYSCALL(thread_yield) 
    16d8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    16dd:	cd 40                	int    $0x40
    16df:	c3                   	ret    

000016e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    16e0:	55                   	push   %ebp
    16e1:	89 e5                	mov    %esp,%ebp
    16e3:	83 ec 28             	sub    $0x28,%esp
    16e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    16ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16f3:	00 
    16f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    16f7:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fb:	8b 45 08             	mov    0x8(%ebp),%eax
    16fe:	89 04 24             	mov    %eax,(%esp)
    1701:	e8 32 ff ff ff       	call   1638 <write>
}
    1706:	c9                   	leave  
    1707:	c3                   	ret    

00001708 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1708:	55                   	push   %ebp
    1709:	89 e5                	mov    %esp,%ebp
    170b:	53                   	push   %ebx
    170c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    170f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1716:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    171a:	74 17                	je     1733 <printint+0x2b>
    171c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1720:	79 11                	jns    1733 <printint+0x2b>
    neg = 1;
    1722:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1729:	8b 45 0c             	mov    0xc(%ebp),%eax
    172c:	f7 d8                	neg    %eax
    172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1731:	eb 06                	jmp    1739 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1733:	8b 45 0c             	mov    0xc(%ebp),%eax
    1736:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1739:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1740:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1743:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1746:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1749:	ba 00 00 00 00       	mov    $0x0,%edx
    174e:	f7 f3                	div    %ebx
    1750:	89 d0                	mov    %edx,%eax
    1752:	0f b6 80 fc 1f 00 00 	movzbl 0x1ffc(%eax),%eax
    1759:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    175d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1761:	8b 45 10             	mov    0x10(%ebp),%eax
    1764:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1767:	8b 45 f4             	mov    -0xc(%ebp),%eax
    176a:	ba 00 00 00 00       	mov    $0x0,%edx
    176f:	f7 75 d4             	divl   -0x2c(%ebp)
    1772:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1775:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1779:	75 c5                	jne    1740 <printint+0x38>
  if(neg)
    177b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    177f:	74 28                	je     17a9 <printint+0xa1>
    buf[i++] = '-';
    1781:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1784:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1789:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    178d:	eb 1a                	jmp    17a9 <printint+0xa1>
    putc(fd, buf[i]);
    178f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1792:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1797:	0f be c0             	movsbl %al,%eax
    179a:	89 44 24 04          	mov    %eax,0x4(%esp)
    179e:	8b 45 08             	mov    0x8(%ebp),%eax
    17a1:	89 04 24             	mov    %eax,(%esp)
    17a4:	e8 37 ff ff ff       	call   16e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    17a9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    17ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17b1:	79 dc                	jns    178f <printint+0x87>
    putc(fd, buf[i]);
}
    17b3:	83 c4 44             	add    $0x44,%esp
    17b6:	5b                   	pop    %ebx
    17b7:	5d                   	pop    %ebp
    17b8:	c3                   	ret    

000017b9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    17b9:	55                   	push   %ebp
    17ba:	89 e5                	mov    %esp,%ebp
    17bc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    17bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    17c6:	8d 45 0c             	lea    0xc(%ebp),%eax
    17c9:	83 c0 04             	add    $0x4,%eax
    17cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    17cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17d6:	e9 7e 01 00 00       	jmp    1959 <printf+0x1a0>
    c = fmt[i] & 0xff;
    17db:	8b 55 0c             	mov    0xc(%ebp),%edx
    17de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    17e4:	0f b6 00             	movzbl (%eax),%eax
    17e7:	0f be c0             	movsbl %al,%eax
    17ea:	25 ff 00 00 00       	and    $0xff,%eax
    17ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    17f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17f6:	75 2c                	jne    1824 <printf+0x6b>
      if(c == '%'){
    17f8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    17fc:	75 0c                	jne    180a <printf+0x51>
        state = '%';
    17fe:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1805:	e9 4b 01 00 00       	jmp    1955 <printf+0x19c>
      } else {
        putc(fd, c);
    180a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    180d:	0f be c0             	movsbl %al,%eax
    1810:	89 44 24 04          	mov    %eax,0x4(%esp)
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	89 04 24             	mov    %eax,(%esp)
    181a:	e8 c1 fe ff ff       	call   16e0 <putc>
    181f:	e9 31 01 00 00       	jmp    1955 <printf+0x19c>
      }
    } else if(state == '%'){
    1824:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1828:	0f 85 27 01 00 00    	jne    1955 <printf+0x19c>
      if(c == 'd'){
    182e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1832:	75 2d                	jne    1861 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1834:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1837:	8b 00                	mov    (%eax),%eax
    1839:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1840:	00 
    1841:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1848:	00 
    1849:	89 44 24 04          	mov    %eax,0x4(%esp)
    184d:	8b 45 08             	mov    0x8(%ebp),%eax
    1850:	89 04 24             	mov    %eax,(%esp)
    1853:	e8 b0 fe ff ff       	call   1708 <printint>
        ap++;
    1858:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    185c:	e9 ed 00 00 00       	jmp    194e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1861:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1865:	74 06                	je     186d <printf+0xb4>
    1867:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    186b:	75 2d                	jne    189a <printf+0xe1>
        printint(fd, *ap, 16, 0);
    186d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1870:	8b 00                	mov    (%eax),%eax
    1872:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1879:	00 
    187a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1881:	00 
    1882:	89 44 24 04          	mov    %eax,0x4(%esp)
    1886:	8b 45 08             	mov    0x8(%ebp),%eax
    1889:	89 04 24             	mov    %eax,(%esp)
    188c:	e8 77 fe ff ff       	call   1708 <printint>
        ap++;
    1891:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1895:	e9 b4 00 00 00       	jmp    194e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    189a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    189e:	75 46                	jne    18e6 <printf+0x12d>
        s = (char*)*ap;
    18a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18a3:	8b 00                	mov    (%eax),%eax
    18a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    18a8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    18ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    18b0:	75 27                	jne    18d9 <printf+0x120>
          s = "(null)";
    18b2:	c7 45 e4 c7 1f 00 00 	movl   $0x1fc7,-0x1c(%ebp)
        while(*s != 0){
    18b9:	eb 1f                	jmp    18da <printf+0x121>
          putc(fd, *s);
    18bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18be:	0f b6 00             	movzbl (%eax),%eax
    18c1:	0f be c0             	movsbl %al,%eax
    18c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c8:	8b 45 08             	mov    0x8(%ebp),%eax
    18cb:	89 04 24             	mov    %eax,(%esp)
    18ce:	e8 0d fe ff ff       	call   16e0 <putc>
          s++;
    18d3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    18d7:	eb 01                	jmp    18da <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    18d9:	90                   	nop
    18da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18dd:	0f b6 00             	movzbl (%eax),%eax
    18e0:	84 c0                	test   %al,%al
    18e2:	75 d7                	jne    18bb <printf+0x102>
    18e4:	eb 68                	jmp    194e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18e6:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    18ea:	75 1d                	jne    1909 <printf+0x150>
        putc(fd, *ap);
    18ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ef:	8b 00                	mov    (%eax),%eax
    18f1:	0f be c0             	movsbl %al,%eax
    18f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    18f8:	8b 45 08             	mov    0x8(%ebp),%eax
    18fb:	89 04 24             	mov    %eax,(%esp)
    18fe:	e8 dd fd ff ff       	call   16e0 <putc>
        ap++;
    1903:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1907:	eb 45                	jmp    194e <printf+0x195>
      } else if(c == '%'){
    1909:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    190d:	75 17                	jne    1926 <printf+0x16d>
        putc(fd, c);
    190f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1912:	0f be c0             	movsbl %al,%eax
    1915:	89 44 24 04          	mov    %eax,0x4(%esp)
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
    191c:	89 04 24             	mov    %eax,(%esp)
    191f:	e8 bc fd ff ff       	call   16e0 <putc>
    1924:	eb 28                	jmp    194e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1926:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    192d:	00 
    192e:	8b 45 08             	mov    0x8(%ebp),%eax
    1931:	89 04 24             	mov    %eax,(%esp)
    1934:	e8 a7 fd ff ff       	call   16e0 <putc>
        putc(fd, c);
    1939:	8b 45 e8             	mov    -0x18(%ebp),%eax
    193c:	0f be c0             	movsbl %al,%eax
    193f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1943:	8b 45 08             	mov    0x8(%ebp),%eax
    1946:	89 04 24             	mov    %eax,(%esp)
    1949:	e8 92 fd ff ff       	call   16e0 <putc>
      }
      state = 0;
    194e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1955:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1959:	8b 55 0c             	mov    0xc(%ebp),%edx
    195c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    195f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1962:	0f b6 00             	movzbl (%eax),%eax
    1965:	84 c0                	test   %al,%al
    1967:	0f 85 6e fe ff ff    	jne    17db <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    196d:	c9                   	leave  
    196e:	c3                   	ret    
    196f:	90                   	nop

00001970 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1970:	55                   	push   %ebp
    1971:	89 e5                	mov    %esp,%ebp
    1973:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1976:	8b 45 08             	mov    0x8(%ebp),%eax
    1979:	83 e8 08             	sub    $0x8,%eax
    197c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    197f:	a1 30 20 00 00       	mov    0x2030,%eax
    1984:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1987:	eb 24                	jmp    19ad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1989:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198c:	8b 00                	mov    (%eax),%eax
    198e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1991:	77 12                	ja     19a5 <free+0x35>
    1993:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1996:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1999:	77 24                	ja     19bf <free+0x4f>
    199b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    199e:	8b 00                	mov    (%eax),%eax
    19a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19a3:	77 1a                	ja     19bf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a8:	8b 00                	mov    (%eax),%eax
    19aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19b3:	76 d4                	jbe    1989 <free+0x19>
    19b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b8:	8b 00                	mov    (%eax),%eax
    19ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19bd:	76 ca                	jbe    1989 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    19bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19c2:	8b 40 04             	mov    0x4(%eax),%eax
    19c5:	c1 e0 03             	shl    $0x3,%eax
    19c8:	89 c2                	mov    %eax,%edx
    19ca:	03 55 f8             	add    -0x8(%ebp),%edx
    19cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d0:	8b 00                	mov    (%eax),%eax
    19d2:	39 c2                	cmp    %eax,%edx
    19d4:	75 24                	jne    19fa <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    19d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19d9:	8b 50 04             	mov    0x4(%eax),%edx
    19dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19df:	8b 00                	mov    (%eax),%eax
    19e1:	8b 40 04             	mov    0x4(%eax),%eax
    19e4:	01 c2                	add    %eax,%edx
    19e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19e9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    19ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ef:	8b 00                	mov    (%eax),%eax
    19f1:	8b 10                	mov    (%eax),%edx
    19f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19f6:	89 10                	mov    %edx,(%eax)
    19f8:	eb 0a                	jmp    1a04 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    19fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19fd:	8b 10                	mov    (%eax),%edx
    19ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a02:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1a04:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a07:	8b 40 04             	mov    0x4(%eax),%eax
    1a0a:	c1 e0 03             	shl    $0x3,%eax
    1a0d:	03 45 fc             	add    -0x4(%ebp),%eax
    1a10:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a13:	75 20                	jne    1a35 <free+0xc5>
    p->s.size += bp->s.size;
    1a15:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a18:	8b 50 04             	mov    0x4(%eax),%edx
    1a1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a1e:	8b 40 04             	mov    0x4(%eax),%eax
    1a21:	01 c2                	add    %eax,%edx
    1a23:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a26:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1a29:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a2c:	8b 10                	mov    (%eax),%edx
    1a2e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a31:	89 10                	mov    %edx,(%eax)
    1a33:	eb 08                	jmp    1a3d <free+0xcd>
  } else
    p->s.ptr = bp;
    1a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a38:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a3b:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a40:	a3 30 20 00 00       	mov    %eax,0x2030
}
    1a45:	c9                   	leave  
    1a46:	c3                   	ret    

00001a47 <morecore>:

static Header*
morecore(uint nu)
{
    1a47:	55                   	push   %ebp
    1a48:	89 e5                	mov    %esp,%ebp
    1a4a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1a4d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1a54:	77 07                	ja     1a5d <morecore+0x16>
    nu = 4096;
    1a56:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a60:	c1 e0 03             	shl    $0x3,%eax
    1a63:	89 04 24             	mov    %eax,(%esp)
    1a66:	e8 35 fc ff ff       	call   16a0 <sbrk>
    1a6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1a6e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a72:	75 07                	jne    1a7b <morecore+0x34>
    return 0;
    1a74:	b8 00 00 00 00       	mov    $0x0,%eax
    1a79:	eb 22                	jmp    1a9d <morecore+0x56>
  hp = (Header*)p;
    1a7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a84:	8b 55 08             	mov    0x8(%ebp),%edx
    1a87:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8d:	83 c0 08             	add    $0x8,%eax
    1a90:	89 04 24             	mov    %eax,(%esp)
    1a93:	e8 d8 fe ff ff       	call   1970 <free>
  return freep;
    1a98:	a1 30 20 00 00       	mov    0x2030,%eax
}
    1a9d:	c9                   	leave  
    1a9e:	c3                   	ret    

00001a9f <malloc>:

void*
malloc(uint nbytes)
{
    1a9f:	55                   	push   %ebp
    1aa0:	89 e5                	mov    %esp,%ebp
    1aa2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1aa5:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa8:	83 c0 07             	add    $0x7,%eax
    1aab:	c1 e8 03             	shr    $0x3,%eax
    1aae:	83 c0 01             	add    $0x1,%eax
    1ab1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1ab4:	a1 30 20 00 00       	mov    0x2030,%eax
    1ab9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1abc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ac0:	75 23                	jne    1ae5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1ac2:	c7 45 f0 28 20 00 00 	movl   $0x2028,-0x10(%ebp)
    1ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1acc:	a3 30 20 00 00       	mov    %eax,0x2030
    1ad1:	a1 30 20 00 00       	mov    0x2030,%eax
    1ad6:	a3 28 20 00 00       	mov    %eax,0x2028
    base.s.size = 0;
    1adb:	c7 05 2c 20 00 00 00 	movl   $0x0,0x202c
    1ae2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ae5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ae8:	8b 00                	mov    (%eax),%eax
    1aea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1aed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1af0:	8b 40 04             	mov    0x4(%eax),%eax
    1af3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1af6:	72 4d                	jb     1b45 <malloc+0xa6>
      if(p->s.size == nunits)
    1af8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1afb:	8b 40 04             	mov    0x4(%eax),%eax
    1afe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1b01:	75 0c                	jne    1b0f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1b03:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b06:	8b 10                	mov    (%eax),%edx
    1b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b0b:	89 10                	mov    %edx,(%eax)
    1b0d:	eb 26                	jmp    1b35 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1b0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b12:	8b 40 04             	mov    0x4(%eax),%eax
    1b15:	89 c2                	mov    %eax,%edx
    1b17:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1b1a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b1d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b20:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b23:	8b 40 04             	mov    0x4(%eax),%eax
    1b26:	c1 e0 03             	shl    $0x3,%eax
    1b29:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b2f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b32:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b35:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b38:	a3 30 20 00 00       	mov    %eax,0x2030
      return (void*)(p + 1);
    1b3d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b40:	83 c0 08             	add    $0x8,%eax
    1b43:	eb 38                	jmp    1b7d <malloc+0xde>
    }
    if(p == freep)
    1b45:	a1 30 20 00 00       	mov    0x2030,%eax
    1b4a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1b4d:	75 1b                	jne    1b6a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b52:	89 04 24             	mov    %eax,(%esp)
    1b55:	e8 ed fe ff ff       	call   1a47 <morecore>
    1b5a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b5d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b61:	75 07                	jne    1b6a <malloc+0xcb>
        return 0;
    1b63:	b8 00 00 00 00       	mov    $0x0,%eax
    1b68:	eb 13                	jmp    1b7d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b6a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b70:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b73:	8b 00                	mov    (%eax),%eax
    1b75:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1b78:	e9 70 ff ff ff       	jmp    1aed <malloc+0x4e>
}
    1b7d:	c9                   	leave  
    1b7e:	c3                   	ret    
    1b7f:	90                   	nop

00001b80 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b80:	55                   	push   %ebp
    1b81:	89 e5                	mov    %esp,%ebp
    1b83:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b86:	8b 55 08             	mov    0x8(%ebp),%edx
    1b89:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b8c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b8f:	f0 87 02             	lock xchg %eax,(%edx)
    1b92:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b95:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b98:	c9                   	leave  
    1b99:	c3                   	ret    

00001b9a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b9a:	55                   	push   %ebp
    1b9b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1ba6:	5d                   	pop    %ebp
    1ba7:	c3                   	ret    

00001ba8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1ba8:	55                   	push   %ebp
    1ba9:	89 e5                	mov    %esp,%ebp
    1bab:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1bae:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1bb8:	00 
    1bb9:	89 04 24             	mov    %eax,(%esp)
    1bbc:	e8 bf ff ff ff       	call   1b80 <xchg>
    1bc1:	85 c0                	test   %eax,%eax
    1bc3:	75 e9                	jne    1bae <lock_acquire+0x6>
}
    1bc5:	c9                   	leave  
    1bc6:	c3                   	ret    

00001bc7 <lock_release>:
void lock_release(lock_t *lock){
    1bc7:	55                   	push   %ebp
    1bc8:	89 e5                	mov    %esp,%ebp
    1bca:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1bcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1bd7:	00 
    1bd8:	89 04 24             	mov    %eax,(%esp)
    1bdb:	e8 a0 ff ff ff       	call   1b80 <xchg>
}
    1be0:	c9                   	leave  
    1be1:	c3                   	ret    

00001be2 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1be2:	55                   	push   %ebp
    1be3:	89 e5                	mov    %esp,%ebp
    1be5:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1be8:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1bef:	e8 ab fe ff ff       	call   1a9f <malloc>
    1bf4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1bf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1bfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c00:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c05:	85 c0                	test   %eax,%eax
    1c07:	74 15                	je     1c1e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1c09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c0c:	89 c2                	mov    %eax,%edx
    1c0e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1c14:	b8 00 10 00 00       	mov    $0x1000,%eax
    1c19:	29 d0                	sub    %edx,%eax
    1c1b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1c1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c22:	75 1b                	jne    1c3f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1c24:	c7 44 24 04 ce 1f 00 	movl   $0x1fce,0x4(%esp)
    1c2b:	00 
    1c2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c33:	e8 81 fb ff ff       	call   17b9 <printf>
        return 0;
    1c38:	b8 00 00 00 00       	mov    $0x0,%eax
    1c3d:	eb 6f                	jmp    1cae <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1c3f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c42:	8b 55 08             	mov    0x8(%ebp),%edx
    1c45:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c48:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1c4c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1c50:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1c57:	00 
    1c58:	89 04 24             	mov    %eax,(%esp)
    1c5b:	e8 58 fa ff ff       	call   16b8 <clone>
    1c60:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1c63:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c67:	79 1b                	jns    1c84 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1c69:	c7 44 24 04 dc 1f 00 	movl   $0x1fdc,0x4(%esp)
    1c70:	00 
    1c71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c78:	e8 3c fb ff ff       	call   17b9 <printf>
        return 0;
    1c7d:	b8 00 00 00 00       	mov    $0x0,%eax
    1c82:	eb 2a                	jmp    1cae <thread_create+0xcc>
    }
    if(tid > 0){
    1c84:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c88:	7e 05                	jle    1c8f <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c8d:	eb 1f                	jmp    1cae <thread_create+0xcc>
    }
    if(tid == 0){
    1c8f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c93:	75 14                	jne    1ca9 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1c95:	c7 44 24 04 e9 1f 00 	movl   $0x1fe9,0x4(%esp)
    1c9c:	00 
    1c9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ca4:	e8 10 fb ff ff       	call   17b9 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ca9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1cae:	c9                   	leave  
    1caf:	c3                   	ret    

00001cb0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1cb0:	55                   	push   %ebp
    1cb1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1cb3:	a1 10 20 00 00       	mov    0x2010,%eax
    1cb8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1cbe:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1cc3:	a3 10 20 00 00       	mov    %eax,0x2010
    return (int)(rands % max);
    1cc8:	a1 10 20 00 00       	mov    0x2010,%eax
    1ccd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cd0:	ba 00 00 00 00       	mov    $0x0,%edx
    1cd5:	f7 f1                	div    %ecx
    1cd7:	89 d0                	mov    %edx,%eax
}
    1cd9:	5d                   	pop    %ebp
    1cda:	c3                   	ret    
    1cdb:	90                   	nop

00001cdc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1cdc:	55                   	push   %ebp
    1cdd:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1cdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ce8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ceb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1cf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1cfc:	5d                   	pop    %ebp
    1cfd:	c3                   	ret    

00001cfe <add_q>:

void add_q(struct queue *q, int v){
    1cfe:	55                   	push   %ebp
    1cff:	89 e5                	mov    %esp,%ebp
    1d01:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1d04:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d0b:	e8 8f fd ff ff       	call   1a9f <malloc>
    1d10:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d16:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d20:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d23:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d25:	8b 45 08             	mov    0x8(%ebp),%eax
    1d28:	8b 40 04             	mov    0x4(%eax),%eax
    1d2b:	85 c0                	test   %eax,%eax
    1d2d:	75 0b                	jne    1d3a <add_q+0x3c>
        q->head = n;
    1d2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d32:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d35:	89 50 04             	mov    %edx,0x4(%eax)
    1d38:	eb 0c                	jmp    1d46 <add_q+0x48>
    }else{
        q->tail->next = n;
    1d3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3d:	8b 40 08             	mov    0x8(%eax),%eax
    1d40:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d43:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1d46:	8b 45 08             	mov    0x8(%ebp),%eax
    1d49:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d4c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1d4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d52:	8b 00                	mov    (%eax),%eax
    1d54:	8d 50 01             	lea    0x1(%eax),%edx
    1d57:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5a:	89 10                	mov    %edx,(%eax)
}
    1d5c:	c9                   	leave  
    1d5d:	c3                   	ret    

00001d5e <empty_q>:

int empty_q(struct queue *q){
    1d5e:	55                   	push   %ebp
    1d5f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1d61:	8b 45 08             	mov    0x8(%ebp),%eax
    1d64:	8b 00                	mov    (%eax),%eax
    1d66:	85 c0                	test   %eax,%eax
    1d68:	75 07                	jne    1d71 <empty_q+0x13>
        return 1;
    1d6a:	b8 01 00 00 00       	mov    $0x1,%eax
    1d6f:	eb 05                	jmp    1d76 <empty_q+0x18>
    else
        return 0;
    1d71:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d76:	5d                   	pop    %ebp
    1d77:	c3                   	ret    

00001d78 <pop_q>:
int pop_q(struct queue *q){
    1d78:	55                   	push   %ebp
    1d79:	89 e5                	mov    %esp,%ebp
    1d7b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d81:	89 04 24             	mov    %eax,(%esp)
    1d84:	e8 d5 ff ff ff       	call   1d5e <empty_q>
    1d89:	85 c0                	test   %eax,%eax
    1d8b:	75 5d                	jne    1dea <pop_q+0x72>
       val = q->head->value; 
    1d8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d90:	8b 40 04             	mov    0x4(%eax),%eax
    1d93:	8b 00                	mov    (%eax),%eax
    1d95:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1d98:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9b:	8b 40 04             	mov    0x4(%eax),%eax
    1d9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1da1:	8b 45 08             	mov    0x8(%ebp),%eax
    1da4:	8b 40 04             	mov    0x4(%eax),%eax
    1da7:	8b 50 04             	mov    0x4(%eax),%edx
    1daa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dad:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1db0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db3:	89 04 24             	mov    %eax,(%esp)
    1db6:	e8 b5 fb ff ff       	call   1970 <free>
       q->size--;
    1dbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbe:	8b 00                	mov    (%eax),%eax
    1dc0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1dc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1dc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcb:	8b 00                	mov    (%eax),%eax
    1dcd:	85 c0                	test   %eax,%eax
    1dcf:	75 14                	jne    1de5 <pop_q+0x6d>
            q->head = 0;
    1dd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1ddb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dde:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1de8:	eb 05                	jmp    1def <pop_q+0x77>
    }
    return -1;
    1dea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1def:	c9                   	leave  
    1df0:	c3                   	ret    
    1df1:	90                   	nop
    1df2:	90                   	nop
    1df3:	90                   	nop

00001df4 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1df4:	55                   	push   %ebp
    1df5:	89 e5                	mov    %esp,%ebp
    1df7:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1dfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfd:	89 04 24             	mov    %eax,(%esp)
    1e00:	e8 a3 fd ff ff       	call   1ba8 <lock_acquire>
	s->count--; 
    1e05:	8b 45 08             	mov    0x8(%ebp),%eax
    1e08:	8b 40 04             	mov    0x4(%eax),%eax
    1e0b:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e11:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1e14:	8b 45 08             	mov    0x8(%ebp),%eax
    1e17:	8b 40 04             	mov    0x4(%eax),%eax
    1e1a:	85 c0                	test   %eax,%eax
    1e1c:	79 27                	jns    1e45 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1e1e:	e8 75 f8 ff ff       	call   1698 <getpid>
    1e23:	8b 55 08             	mov    0x8(%ebp),%edx
    1e26:	83 c2 08             	add    $0x8,%edx
    1e29:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e2d:	89 14 24             	mov    %edx,(%esp)
    1e30:	e8 c9 fe ff ff       	call   1cfe <add_q>
		lock_release(&s->lock); 
    1e35:	8b 45 08             	mov    0x8(%ebp),%eax
    1e38:	89 04 24             	mov    %eax,(%esp)
    1e3b:	e8 87 fd ff ff       	call   1bc7 <lock_release>
		tsleep(); 
    1e40:	e8 83 f8 ff ff       	call   16c8 <tsleep>
	} 
	lock_release(&s->lock); 
    1e45:	8b 45 08             	mov    0x8(%ebp),%eax
    1e48:	89 04 24             	mov    %eax,(%esp)
    1e4b:	e8 77 fd ff ff       	call   1bc7 <lock_release>
}
    1e50:	c9                   	leave  
    1e51:	c3                   	ret    

00001e52 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1e52:	55                   	push   %ebp
    1e53:	89 e5                	mov    %esp,%ebp
    1e55:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1e58:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5b:	89 04 24             	mov    %eax,(%esp)
    1e5e:	e8 45 fd ff ff       	call   1ba8 <lock_acquire>
	s->count++; 
    1e63:	8b 45 08             	mov    0x8(%ebp),%eax
    1e66:	8b 40 04             	mov    0x4(%eax),%eax
    1e69:	8d 50 01             	lea    0x1(%eax),%edx
    1e6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6f:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1e72:	8b 45 08             	mov    0x8(%ebp),%eax
    1e75:	8b 40 04             	mov    0x4(%eax),%eax
    1e78:	85 c0                	test   %eax,%eax
    1e7a:	7f 1c                	jg     1e98 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1e7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7f:	83 c0 08             	add    $0x8,%eax
    1e82:	89 04 24             	mov    %eax,(%esp)
    1e85:	e8 ee fe ff ff       	call   1d78 <pop_q>
    1e8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e90:	89 04 24             	mov    %eax,(%esp)
    1e93:	e8 38 f8 ff ff       	call   16d0 <twakeup>
	}
	lock_release(&s->lock); 
    1e98:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9b:	89 04 24             	mov    %eax,(%esp)
    1e9e:	e8 24 fd ff ff       	call   1bc7 <lock_release>
} 
    1ea3:	c9                   	leave  
    1ea4:	c3                   	ret    

00001ea5 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1ea5:	55                   	push   %ebp
    1ea6:	89 e5                	mov    %esp,%ebp
    1ea8:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1eab:	8b 45 08             	mov    0x8(%ebp),%eax
    1eae:	89 04 24             	mov    %eax,(%esp)
    1eb1:	e8 e4 fc ff ff       	call   1b9a <lock_init>
	s->count = size; 
    1eb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ebc:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1ebf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec2:	83 c0 08             	add    $0x8,%eax
    1ec5:	89 04 24             	mov    %eax,(%esp)
    1ec8:	e8 0f fe ff ff       	call   1cdc <init_q>
}
    1ecd:	c9                   	leave  
    1ece:	c3                   	ret    
