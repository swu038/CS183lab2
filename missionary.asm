
_missionary:     file format elf32-i386


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
    1009:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1010:	e8 77 0b 00 00       	call   1b8c <lock_acquire>
	printf(1,"Created 2 missionaries, and 1 Cannibal. Only 1 boat will set off. \n"); 
    1015:	c7 44 24 04 b4 1e 00 	movl   $0x1eb4,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 74 07 00 00       	call   179d <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1030:	e8 76 0b 00 00       	call   1bab <lock_release>
	
	sem_init(&M, 0); 
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    1044:	e8 40 0e 00 00       	call   1e89 <sem_init>
	sem_init(&C, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 c4 1f 00 00 	movl   $0x1fc4,(%esp)
    1058:	e8 2c 0e 00 00       	call   1e89 <sem_init>

	void *mid = thread_create(MissionaryArrives,(void *)0);
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 d7 10 00 00 	movl   $0x10d7,(%esp)
    106c:	e8 55 0b 00 00       	call   1bc6 <thread_create>
    1071:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(mid == 0) exit(); 
    1075:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 7b 05 00 00       	call   15fc <exit>

	void *mid2 = thread_create(MissionaryArrives,(void *)0); 
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 d7 10 00 00 	movl   $0x10d7,(%esp)
    1090:	e8 31 0b 00 00       	call   1bc6 <thread_create>
    1095:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid2 == 0) exit(); 
    1099:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 57 05 00 00       	call   15fc <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    10a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 ee 11 00 00 	movl   $0x11ee,(%esp)
    10b4:	e8 0d 0b 00 00       	call   1bc6 <thread_create>
    10b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(cid == 0) exit(); 
    10bd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 33 05 00 00       	call   15fc <exit>

	while(wait() > 0); 
    10c9:	e8 36 05 00 00       	call   1604 <wait>
    10ce:	85 c0                	test   %eax,%eax
    10d0:	7f f7                	jg     10c9 <main+0xc9>

	exit(); 
    10d2:	e8 25 05 00 00       	call   15fc <exit>

000010d7 <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    10d7:	55                   	push   %ebp
    10d8:	89 e5                	mov    %esp,%ebp
    10da:	83 ec 18             	sub    $0x18,%esp
	if(numMissionaries == 2) 
    10dd:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    10e2:	83 f8 02             	cmp    $0x2,%eax
    10e5:	75 47                	jne    112e <MissionaryArrives+0x57>
	{
		lock_acquire(&mutex.lock);
    10e7:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    10ee:	e8 99 0a 00 00       	call   1b8c <lock_acquire>
		missCount++; //for num of miss in boat. 
    10f3:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    10f8:	83 c0 01             	add    $0x1,%eax
    10fb:	a3 ac 1f 00 00       	mov    %eax,0x1fac
		lock_release(&mutex.lock);
    1100:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1107:	e8 9f 0a 00 00       	call   1bab <lock_release>
		sem_signal(&M); 
    110c:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    1113:	e8 1e 0d 00 00       	call   1e36 <sem_signal>
		sem_signal(&M); 
    1118:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    111f:	e8 12 0d 00 00       	call   1e36 <sem_signal>
		RowBoat();
    1124:	e8 d2 01 00 00       	call   12fb <RowBoat>
    1129:	e9 bb 00 00 00       	jmp    11e9 <MissionaryArrives+0x112>
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    112e:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    1133:	83 f8 01             	cmp    $0x1,%eax
    1136:	75 4e                	jne    1186 <MissionaryArrives+0xaf>
    1138:	a1 a4 1f 00 00       	mov    0x1fa4,%eax
    113d:	83 f8 01             	cmp    $0x1,%eax
    1140:	75 44                	jne    1186 <MissionaryArrives+0xaf>
		lock_acquire(&mutex.lock);
    1142:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1149:	e8 3e 0a 00 00       	call   1b8c <lock_acquire>
		missCount++; //for num of miss in boat. 
    114e:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    1153:	83 c0 01             	add    $0x1,%eax
    1156:	a3 ac 1f 00 00       	mov    %eax,0x1fac
		lock_release(&mutex.lock);
    115b:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1162:	e8 44 0a 00 00       	call   1bab <lock_release>
		sem_signal(&M); 
    1167:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    116e:	e8 c3 0c 00 00       	call   1e36 <sem_signal>
		sem_signal(&C);
    1173:	c7 04 24 c4 1f 00 00 	movl   $0x1fc4,(%esp)
    117a:	e8 b7 0c 00 00       	call   1e36 <sem_signal>
		RowBoat(); 
    117f:	e8 77 01 00 00       	call   12fb <RowBoat>
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&M); 
		RowBoat();
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1184:	eb 63                	jmp    11e9 <MissionaryArrives+0x112>
		sem_signal(&M); 
		sem_signal(&C);
		RowBoat(); 
	} 
	else {
		lock_acquire(&mutex.lock); 
    1186:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    118d:	e8 fa 09 00 00       	call   1b8c <lock_acquire>
		numMissionaries++;
    1192:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	a3 a0 1f 00 00       	mov    %eax,0x1fa0
		missCount++;  //for num of miss in boat. 
    119f:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    11a4:	83 c0 01             	add    $0x1,%eax
    11a7:	a3 ac 1f 00 00       	mov    %eax,0x1fac
		lock_release(&mutex.lock);  
    11ac:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    11b3:	e8 f3 09 00 00       	call   1bab <lock_release>
		sem_acquire(&M);
    11b8:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    11bf:	e8 14 0c 00 00       	call   1dd8 <sem_acquire>
		lock_acquire(&mutex.lock);  
    11c4:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    11cb:	e8 bc 09 00 00       	call   1b8c <lock_acquire>
		numMissionaries--; 
    11d0:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    11d5:	83 e8 01             	sub    $0x1,%eax
    11d8:	a3 a0 1f 00 00       	mov    %eax,0x1fa0
		lock_release(&mutex.lock);  
    11dd:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    11e4:	e8 c2 09 00 00       	call   1bab <lock_release>
	} 
	texit();  
    11e9:	e8 b6 04 00 00       	call   16a4 <texit>

000011ee <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    11ee:	55                   	push   %ebp
    11ef:	89 e5                	mov    %esp,%ebp
    11f1:	83 ec 18             	sub    $0x18,%esp
	if(numCannibals == 2) 
    11f4:	a1 a4 1f 00 00       	mov    0x1fa4,%eax
    11f9:	83 f8 02             	cmp    $0x2,%eax
    11fc:	75 47                	jne    1245 <CannibalArrives+0x57>
	{
		lock_acquire(&mutex.lock); 
    11fe:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1205:	e8 82 09 00 00       	call   1b8c <lock_acquire>
		canCount++; //for num of can in boat.  
    120a:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    120f:	83 c0 01             	add    $0x1,%eax
    1212:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
		lock_release(&mutex.lock);  
    1217:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    121e:	e8 88 09 00 00       	call   1bab <lock_release>
		sem_signal(&C); 
    1223:	c7 04 24 c4 1f 00 00 	movl   $0x1fc4,(%esp)
    122a:	e8 07 0c 00 00       	call   1e36 <sem_signal>
		sem_signal(&C);
    122f:	c7 04 24 c4 1f 00 00 	movl   $0x1fc4,(%esp)
    1236:	e8 fb 0b 00 00       	call   1e36 <sem_signal>
		RowBoat();  		
    123b:	e8 bb 00 00 00       	call   12fb <RowBoat>
    1240:	e9 b1 00 00 00       	jmp    12f6 <CannibalArrives+0x108>
	}
	else if(numMissionaries == 2) {
    1245:	a1 a0 1f 00 00       	mov    0x1fa0,%eax
    124a:	83 f8 02             	cmp    $0x2,%eax
    124d:	75 44                	jne    1293 <CannibalArrives+0xa5>
		lock_acquire(&mutex.lock); 
    124f:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1256:	e8 31 09 00 00       	call   1b8c <lock_acquire>
		canCount++; //for num of can in boat.  
    125b:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    1260:	83 c0 01             	add    $0x1,%eax
    1263:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
		lock_release(&mutex.lock);  
    1268:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    126f:	e8 37 09 00 00       	call   1bab <lock_release>
		sem_signal(&M);
    1274:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    127b:	e8 b6 0b 00 00       	call   1e36 <sem_signal>
		sem_signal(&M); 
    1280:	c7 04 24 d8 1f 00 00 	movl   $0x1fd8,(%esp)
    1287:	e8 aa 0b 00 00       	call   1e36 <sem_signal>
		RowBoat(); 
    128c:	e8 6a 00 00 00       	call   12fb <RowBoat>
    1291:	eb 63                	jmp    12f6 <CannibalArrives+0x108>
	}
	else {
	lock_acquire(&mutex.lock);
    1293:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    129a:	e8 ed 08 00 00       	call   1b8c <lock_acquire>
	canCount++; //for num of can in boat.  
    129f:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    12a4:	83 c0 01             	add    $0x1,%eax
    12a7:	a3 a8 1f 00 00       	mov    %eax,0x1fa8
	numCannibals++; 
    12ac:	a1 a4 1f 00 00       	mov    0x1fa4,%eax
    12b1:	83 c0 01             	add    $0x1,%eax
    12b4:	a3 a4 1f 00 00       	mov    %eax,0x1fa4
	lock_release(&mutex.lock);
    12b9:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    12c0:	e8 e6 08 00 00       	call   1bab <lock_release>
	sem_acquire(&C); 
    12c5:	c7 04 24 c4 1f 00 00 	movl   $0x1fc4,(%esp)
    12cc:	e8 07 0b 00 00       	call   1dd8 <sem_acquire>
	lock_acquire(&mutex.lock);  
    12d1:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    12d8:	e8 af 08 00 00       	call   1b8c <lock_acquire>
	numCannibals--;
    12dd:	a1 a4 1f 00 00       	mov    0x1fa4,%eax
    12e2:	83 e8 01             	sub    $0x1,%eax
    12e5:	a3 a4 1f 00 00       	mov    %eax,0x1fa4
	lock_release(&mutex.lock);
    12ea:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    12f1:	e8 b5 08 00 00       	call   1bab <lock_release>
	}
	texit(); 
    12f6:	e8 a9 03 00 00       	call   16a4 <texit>

000012fb <RowBoat>:
} 	

void RowBoat() {
    12fb:	55                   	push   %ebp
    12fc:	89 e5                	mov    %esp,%ebp
    12fe:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1301:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    1308:	e8 7f 08 00 00       	call   1b8c <lock_acquire>
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
    130d:	a1 a8 1f 00 00       	mov    0x1fa8,%eax
    1312:	89 44 24 08          	mov    %eax,0x8(%esp)
    1316:	c7 44 24 04 f8 1e 00 	movl   $0x1ef8,0x4(%esp)
    131d:	00 
    131e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1325:	e8 73 04 00 00       	call   179d <printf>
	printf(1,"Number of missionaries in boat: %d.\n",missCount); 
    132a:	a1 ac 1f 00 00       	mov    0x1fac,%eax
    132f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1333:	c7 44 24 04 1c 1f 00 	movl   $0x1f1c,0x4(%esp)
    133a:	00 
    133b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1342:	e8 56 04 00 00       	call   179d <printf>
	numBoat++;
    1347:	a1 b0 1f 00 00       	mov    0x1fb0,%eax
    134c:	83 c0 01             	add    $0x1,%eax
    134f:	a3 b0 1f 00 00       	mov    %eax,0x1fb0
	canCount = 0; 
    1354:	c7 05 a8 1f 00 00 00 	movl   $0x0,0x1fa8
    135b:	00 00 00 
	missCount = 0; 
    135e:	c7 05 ac 1f 00 00 00 	movl   $0x0,0x1fac
    1365:	00 00 00 
	printf(1,"Rowing boat: %d.\n",numBoat);
    1368:	a1 b0 1f 00 00       	mov    0x1fb0,%eax
    136d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1371:	c7 44 24 04 41 1f 00 	movl   $0x1f41,0x4(%esp)
    1378:	00 
    1379:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1380:	e8 18 04 00 00       	call   179d <printf>
	lock_release(&mutex.lock); 
    1385:	c7 04 24 c0 1f 00 00 	movl   $0x1fc0,(%esp)
    138c:	e8 1a 08 00 00       	call   1bab <lock_release>
	texit();  
    1391:	e8 0e 03 00 00       	call   16a4 <texit>
    1396:	90                   	nop
    1397:	90                   	nop

00001398 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1398:	55                   	push   %ebp
    1399:	89 e5                	mov    %esp,%ebp
    139b:	57                   	push   %edi
    139c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    139d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13a0:	8b 55 10             	mov    0x10(%ebp),%edx
    13a3:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a6:	89 cb                	mov    %ecx,%ebx
    13a8:	89 df                	mov    %ebx,%edi
    13aa:	89 d1                	mov    %edx,%ecx
    13ac:	fc                   	cld    
    13ad:	f3 aa                	rep stos %al,%es:(%edi)
    13af:	89 ca                	mov    %ecx,%edx
    13b1:	89 fb                	mov    %edi,%ebx
    13b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
    13b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    13b9:	5b                   	pop    %ebx
    13ba:	5f                   	pop    %edi
    13bb:	5d                   	pop    %ebp
    13bc:	c3                   	ret    

000013bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    13bd:	55                   	push   %ebp
    13be:	89 e5                	mov    %esp,%ebp
    13c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    13c9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13cc:	0f b6 10             	movzbl (%eax),%edx
    13cf:	8b 45 08             	mov    0x8(%ebp),%eax
    13d2:	88 10                	mov    %dl,(%eax)
    13d4:	8b 45 08             	mov    0x8(%ebp),%eax
    13d7:	0f b6 00             	movzbl (%eax),%eax
    13da:	84 c0                	test   %al,%al
    13dc:	0f 95 c0             	setne  %al
    13df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13e3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    13e7:	84 c0                	test   %al,%al
    13e9:	75 de                	jne    13c9 <strcpy+0xc>
    ;
  return os;
    13eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13ee:	c9                   	leave  
    13ef:	c3                   	ret    

000013f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    13f0:	55                   	push   %ebp
    13f1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    13f3:	eb 08                	jmp    13fd <strcmp+0xd>
    p++, q++;
    13f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13f9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    13fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1400:	0f b6 00             	movzbl (%eax),%eax
    1403:	84 c0                	test   %al,%al
    1405:	74 10                	je     1417 <strcmp+0x27>
    1407:	8b 45 08             	mov    0x8(%ebp),%eax
    140a:	0f b6 10             	movzbl (%eax),%edx
    140d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1410:	0f b6 00             	movzbl (%eax),%eax
    1413:	38 c2                	cmp    %al,%dl
    1415:	74 de                	je     13f5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1417:	8b 45 08             	mov    0x8(%ebp),%eax
    141a:	0f b6 00             	movzbl (%eax),%eax
    141d:	0f b6 d0             	movzbl %al,%edx
    1420:	8b 45 0c             	mov    0xc(%ebp),%eax
    1423:	0f b6 00             	movzbl (%eax),%eax
    1426:	0f b6 c0             	movzbl %al,%eax
    1429:	89 d1                	mov    %edx,%ecx
    142b:	29 c1                	sub    %eax,%ecx
    142d:	89 c8                	mov    %ecx,%eax
}
    142f:	5d                   	pop    %ebp
    1430:	c3                   	ret    

00001431 <strlen>:

uint
strlen(char *s)
{
    1431:	55                   	push   %ebp
    1432:	89 e5                	mov    %esp,%ebp
    1434:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1437:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    143e:	eb 04                	jmp    1444 <strlen+0x13>
    1440:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1444:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1447:	03 45 08             	add    0x8(%ebp),%eax
    144a:	0f b6 00             	movzbl (%eax),%eax
    144d:	84 c0                	test   %al,%al
    144f:	75 ef                	jne    1440 <strlen+0xf>
    ;
  return n;
    1451:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1454:	c9                   	leave  
    1455:	c3                   	ret    

00001456 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1456:	55                   	push   %ebp
    1457:	89 e5                	mov    %esp,%ebp
    1459:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    145c:	8b 45 10             	mov    0x10(%ebp),%eax
    145f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1463:	8b 45 0c             	mov    0xc(%ebp),%eax
    1466:	89 44 24 04          	mov    %eax,0x4(%esp)
    146a:	8b 45 08             	mov    0x8(%ebp),%eax
    146d:	89 04 24             	mov    %eax,(%esp)
    1470:	e8 23 ff ff ff       	call   1398 <stosb>
  return dst;
    1475:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1478:	c9                   	leave  
    1479:	c3                   	ret    

0000147a <strchr>:

char*
strchr(const char *s, char c)
{
    147a:	55                   	push   %ebp
    147b:	89 e5                	mov    %esp,%ebp
    147d:	83 ec 04             	sub    $0x4,%esp
    1480:	8b 45 0c             	mov    0xc(%ebp),%eax
    1483:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1486:	eb 14                	jmp    149c <strchr+0x22>
    if(*s == c)
    1488:	8b 45 08             	mov    0x8(%ebp),%eax
    148b:	0f b6 00             	movzbl (%eax),%eax
    148e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1491:	75 05                	jne    1498 <strchr+0x1e>
      return (char*)s;
    1493:	8b 45 08             	mov    0x8(%ebp),%eax
    1496:	eb 13                	jmp    14ab <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1498:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	0f b6 00             	movzbl (%eax),%eax
    14a2:	84 c0                	test   %al,%al
    14a4:	75 e2                	jne    1488 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    14a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14ab:	c9                   	leave  
    14ac:	c3                   	ret    

000014ad <gets>:

char*
gets(char *buf, int max)
{
    14ad:	55                   	push   %ebp
    14ae:	89 e5                	mov    %esp,%ebp
    14b0:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14ba:	eb 44                	jmp    1500 <gets+0x53>
    cc = read(0, &c, 1);
    14bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14c3:	00 
    14c4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    14c7:	89 44 24 04          	mov    %eax,0x4(%esp)
    14cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14d2:	e8 3d 01 00 00       	call   1614 <read>
    14d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    14da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14de:	7e 2d                	jle    150d <gets+0x60>
      break;
    buf[i++] = c;
    14e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14e3:	03 45 08             	add    0x8(%ebp),%eax
    14e6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    14ea:	88 10                	mov    %dl,(%eax)
    14ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    14f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14f4:	3c 0a                	cmp    $0xa,%al
    14f6:	74 16                	je     150e <gets+0x61>
    14f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    14fc:	3c 0d                	cmp    $0xd,%al
    14fe:	74 0e                	je     150e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1500:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1503:	83 c0 01             	add    $0x1,%eax
    1506:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1509:	7c b1                	jl     14bc <gets+0xf>
    150b:	eb 01                	jmp    150e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    150d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    150e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1511:	03 45 08             	add    0x8(%ebp),%eax
    1514:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1517:	8b 45 08             	mov    0x8(%ebp),%eax
}
    151a:	c9                   	leave  
    151b:	c3                   	ret    

0000151c <stat>:

int
stat(char *n, struct stat *st)
{
    151c:	55                   	push   %ebp
    151d:	89 e5                	mov    %esp,%ebp
    151f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1522:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1529:	00 
    152a:	8b 45 08             	mov    0x8(%ebp),%eax
    152d:	89 04 24             	mov    %eax,(%esp)
    1530:	e8 07 01 00 00       	call   163c <open>
    1535:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1538:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    153c:	79 07                	jns    1545 <stat+0x29>
    return -1;
    153e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1543:	eb 23                	jmp    1568 <stat+0x4c>
  r = fstat(fd, st);
    1545:	8b 45 0c             	mov    0xc(%ebp),%eax
    1548:	89 44 24 04          	mov    %eax,0x4(%esp)
    154c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    154f:	89 04 24             	mov    %eax,(%esp)
    1552:	e8 fd 00 00 00       	call   1654 <fstat>
    1557:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    155a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    155d:	89 04 24             	mov    %eax,(%esp)
    1560:	e8 bf 00 00 00       	call   1624 <close>
  return r;
    1565:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1568:	c9                   	leave  
    1569:	c3                   	ret    

0000156a <atoi>:

int
atoi(const char *s)
{
    156a:	55                   	push   %ebp
    156b:	89 e5                	mov    %esp,%ebp
    156d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1570:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1577:	eb 24                	jmp    159d <atoi+0x33>
    n = n*10 + *s++ - '0';
    1579:	8b 55 fc             	mov    -0x4(%ebp),%edx
    157c:	89 d0                	mov    %edx,%eax
    157e:	c1 e0 02             	shl    $0x2,%eax
    1581:	01 d0                	add    %edx,%eax
    1583:	01 c0                	add    %eax,%eax
    1585:	89 c2                	mov    %eax,%edx
    1587:	8b 45 08             	mov    0x8(%ebp),%eax
    158a:	0f b6 00             	movzbl (%eax),%eax
    158d:	0f be c0             	movsbl %al,%eax
    1590:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1593:	83 e8 30             	sub    $0x30,%eax
    1596:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1599:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    159d:	8b 45 08             	mov    0x8(%ebp),%eax
    15a0:	0f b6 00             	movzbl (%eax),%eax
    15a3:	3c 2f                	cmp    $0x2f,%al
    15a5:	7e 0a                	jle    15b1 <atoi+0x47>
    15a7:	8b 45 08             	mov    0x8(%ebp),%eax
    15aa:	0f b6 00             	movzbl (%eax),%eax
    15ad:	3c 39                	cmp    $0x39,%al
    15af:	7e c8                	jle    1579 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    15b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15b4:	c9                   	leave  
    15b5:	c3                   	ret    

000015b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    15b6:	55                   	push   %ebp
    15b7:	89 e5                	mov    %esp,%ebp
    15b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    15bc:	8b 45 08             	mov    0x8(%ebp),%eax
    15bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    15c2:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    15c8:	eb 13                	jmp    15dd <memmove+0x27>
    *dst++ = *src++;
    15ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15cd:	0f b6 10             	movzbl (%eax),%edx
    15d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15d3:	88 10                	mov    %dl,(%eax)
    15d5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    15d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    15dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15e1:	0f 9f c0             	setg   %al
    15e4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    15e8:	84 c0                	test   %al,%al
    15ea:	75 de                	jne    15ca <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    15ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15ef:	c9                   	leave  
    15f0:	c3                   	ret    
    15f1:	90                   	nop
    15f2:	90                   	nop
    15f3:	90                   	nop

000015f4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    15f4:	b8 01 00 00 00       	mov    $0x1,%eax
    15f9:	cd 40                	int    $0x40
    15fb:	c3                   	ret    

000015fc <exit>:
SYSCALL(exit)
    15fc:	b8 02 00 00 00       	mov    $0x2,%eax
    1601:	cd 40                	int    $0x40
    1603:	c3                   	ret    

00001604 <wait>:
SYSCALL(wait)
    1604:	b8 03 00 00 00       	mov    $0x3,%eax
    1609:	cd 40                	int    $0x40
    160b:	c3                   	ret    

0000160c <pipe>:
SYSCALL(pipe)
    160c:	b8 04 00 00 00       	mov    $0x4,%eax
    1611:	cd 40                	int    $0x40
    1613:	c3                   	ret    

00001614 <read>:
SYSCALL(read)
    1614:	b8 05 00 00 00       	mov    $0x5,%eax
    1619:	cd 40                	int    $0x40
    161b:	c3                   	ret    

0000161c <write>:
SYSCALL(write)
    161c:	b8 10 00 00 00       	mov    $0x10,%eax
    1621:	cd 40                	int    $0x40
    1623:	c3                   	ret    

00001624 <close>:
SYSCALL(close)
    1624:	b8 15 00 00 00       	mov    $0x15,%eax
    1629:	cd 40                	int    $0x40
    162b:	c3                   	ret    

0000162c <kill>:
SYSCALL(kill)
    162c:	b8 06 00 00 00       	mov    $0x6,%eax
    1631:	cd 40                	int    $0x40
    1633:	c3                   	ret    

00001634 <exec>:
SYSCALL(exec)
    1634:	b8 07 00 00 00       	mov    $0x7,%eax
    1639:	cd 40                	int    $0x40
    163b:	c3                   	ret    

0000163c <open>:
SYSCALL(open)
    163c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1641:	cd 40                	int    $0x40
    1643:	c3                   	ret    

00001644 <mknod>:
SYSCALL(mknod)
    1644:	b8 11 00 00 00       	mov    $0x11,%eax
    1649:	cd 40                	int    $0x40
    164b:	c3                   	ret    

0000164c <unlink>:
SYSCALL(unlink)
    164c:	b8 12 00 00 00       	mov    $0x12,%eax
    1651:	cd 40                	int    $0x40
    1653:	c3                   	ret    

00001654 <fstat>:
SYSCALL(fstat)
    1654:	b8 08 00 00 00       	mov    $0x8,%eax
    1659:	cd 40                	int    $0x40
    165b:	c3                   	ret    

0000165c <link>:
SYSCALL(link)
    165c:	b8 13 00 00 00       	mov    $0x13,%eax
    1661:	cd 40                	int    $0x40
    1663:	c3                   	ret    

00001664 <mkdir>:
SYSCALL(mkdir)
    1664:	b8 14 00 00 00       	mov    $0x14,%eax
    1669:	cd 40                	int    $0x40
    166b:	c3                   	ret    

0000166c <chdir>:
SYSCALL(chdir)
    166c:	b8 09 00 00 00       	mov    $0x9,%eax
    1671:	cd 40                	int    $0x40
    1673:	c3                   	ret    

00001674 <dup>:
SYSCALL(dup)
    1674:	b8 0a 00 00 00       	mov    $0xa,%eax
    1679:	cd 40                	int    $0x40
    167b:	c3                   	ret    

0000167c <getpid>:
SYSCALL(getpid)
    167c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1681:	cd 40                	int    $0x40
    1683:	c3                   	ret    

00001684 <sbrk>:
SYSCALL(sbrk)
    1684:	b8 0c 00 00 00       	mov    $0xc,%eax
    1689:	cd 40                	int    $0x40
    168b:	c3                   	ret    

0000168c <sleep>:
SYSCALL(sleep)
    168c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1691:	cd 40                	int    $0x40
    1693:	c3                   	ret    

00001694 <uptime>:
SYSCALL(uptime)
    1694:	b8 0e 00 00 00       	mov    $0xe,%eax
    1699:	cd 40                	int    $0x40
    169b:	c3                   	ret    

0000169c <clone>:
SYSCALL(clone)
    169c:	b8 16 00 00 00       	mov    $0x16,%eax
    16a1:	cd 40                	int    $0x40
    16a3:	c3                   	ret    

000016a4 <texit>:
SYSCALL(texit)
    16a4:	b8 17 00 00 00       	mov    $0x17,%eax
    16a9:	cd 40                	int    $0x40
    16ab:	c3                   	ret    

000016ac <tsleep>:
SYSCALL(tsleep)
    16ac:	b8 18 00 00 00       	mov    $0x18,%eax
    16b1:	cd 40                	int    $0x40
    16b3:	c3                   	ret    

000016b4 <twakeup>:
SYSCALL(twakeup)
    16b4:	b8 19 00 00 00       	mov    $0x19,%eax
    16b9:	cd 40                	int    $0x40
    16bb:	c3                   	ret    

000016bc <thread_yield>:
SYSCALL(thread_yield) 
    16bc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    16c1:	cd 40                	int    $0x40
    16c3:	c3                   	ret    

000016c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    16c4:	55                   	push   %ebp
    16c5:	89 e5                	mov    %esp,%ebp
    16c7:	83 ec 28             	sub    $0x28,%esp
    16ca:	8b 45 0c             	mov    0xc(%ebp),%eax
    16cd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    16d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16d7:	00 
    16d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    16db:	89 44 24 04          	mov    %eax,0x4(%esp)
    16df:	8b 45 08             	mov    0x8(%ebp),%eax
    16e2:	89 04 24             	mov    %eax,(%esp)
    16e5:	e8 32 ff ff ff       	call   161c <write>
}
    16ea:	c9                   	leave  
    16eb:	c3                   	ret    

000016ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    16ec:	55                   	push   %ebp
    16ed:	89 e5                	mov    %esp,%ebp
    16ef:	53                   	push   %ebx
    16f0:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    16f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    16fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    16fe:	74 17                	je     1717 <printint+0x2b>
    1700:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1704:	79 11                	jns    1717 <printint+0x2b>
    neg = 1;
    1706:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    170d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1710:	f7 d8                	neg    %eax
    1712:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1715:	eb 06                	jmp    171d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1717:	8b 45 0c             	mov    0xc(%ebp),%eax
    171a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    171d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1724:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1727:	8b 5d 10             	mov    0x10(%ebp),%ebx
    172a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    172d:	ba 00 00 00 00       	mov    $0x0,%edx
    1732:	f7 f3                	div    %ebx
    1734:	89 d0                	mov    %edx,%eax
    1736:	0f b6 80 88 1f 00 00 	movzbl 0x1f88(%eax),%eax
    173d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1741:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1745:	8b 45 10             	mov    0x10(%ebp),%eax
    1748:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    174b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    174e:	ba 00 00 00 00       	mov    $0x0,%edx
    1753:	f7 75 d4             	divl   -0x2c(%ebp)
    1756:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1759:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    175d:	75 c5                	jne    1724 <printint+0x38>
  if(neg)
    175f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1763:	74 28                	je     178d <printint+0xa1>
    buf[i++] = '-';
    1765:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1768:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    176d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1771:	eb 1a                	jmp    178d <printint+0xa1>
    putc(fd, buf[i]);
    1773:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1776:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    177b:	0f be c0             	movsbl %al,%eax
    177e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1782:	8b 45 08             	mov    0x8(%ebp),%eax
    1785:	89 04 24             	mov    %eax,(%esp)
    1788:	e8 37 ff ff ff       	call   16c4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    178d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1791:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1795:	79 dc                	jns    1773 <printint+0x87>
    putc(fd, buf[i]);
}
    1797:	83 c4 44             	add    $0x44,%esp
    179a:	5b                   	pop    %ebx
    179b:	5d                   	pop    %ebp
    179c:	c3                   	ret    

0000179d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    179d:	55                   	push   %ebp
    179e:	89 e5                	mov    %esp,%ebp
    17a0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    17a3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    17aa:	8d 45 0c             	lea    0xc(%ebp),%eax
    17ad:	83 c0 04             	add    $0x4,%eax
    17b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    17b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17ba:	e9 7e 01 00 00       	jmp    193d <printf+0x1a0>
    c = fmt[i] & 0xff;
    17bf:	8b 55 0c             	mov    0xc(%ebp),%edx
    17c2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c5:	8d 04 02             	lea    (%edx,%eax,1),%eax
    17c8:	0f b6 00             	movzbl (%eax),%eax
    17cb:	0f be c0             	movsbl %al,%eax
    17ce:	25 ff 00 00 00       	and    $0xff,%eax
    17d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    17d6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17da:	75 2c                	jne    1808 <printf+0x6b>
      if(c == '%'){
    17dc:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    17e0:	75 0c                	jne    17ee <printf+0x51>
        state = '%';
    17e2:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    17e9:	e9 4b 01 00 00       	jmp    1939 <printf+0x19c>
      } else {
        putc(fd, c);
    17ee:	8b 45 e8             	mov    -0x18(%ebp),%eax
    17f1:	0f be c0             	movsbl %al,%eax
    17f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    17f8:	8b 45 08             	mov    0x8(%ebp),%eax
    17fb:	89 04 24             	mov    %eax,(%esp)
    17fe:	e8 c1 fe ff ff       	call   16c4 <putc>
    1803:	e9 31 01 00 00       	jmp    1939 <printf+0x19c>
      }
    } else if(state == '%'){
    1808:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    180c:	0f 85 27 01 00 00    	jne    1939 <printf+0x19c>
      if(c == 'd'){
    1812:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1816:	75 2d                	jne    1845 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1818:	8b 45 f4             	mov    -0xc(%ebp),%eax
    181b:	8b 00                	mov    (%eax),%eax
    181d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1824:	00 
    1825:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    182c:	00 
    182d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1831:	8b 45 08             	mov    0x8(%ebp),%eax
    1834:	89 04 24             	mov    %eax,(%esp)
    1837:	e8 b0 fe ff ff       	call   16ec <printint>
        ap++;
    183c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1840:	e9 ed 00 00 00       	jmp    1932 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1845:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1849:	74 06                	je     1851 <printf+0xb4>
    184b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    184f:	75 2d                	jne    187e <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1851:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1854:	8b 00                	mov    (%eax),%eax
    1856:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    185d:	00 
    185e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1865:	00 
    1866:	89 44 24 04          	mov    %eax,0x4(%esp)
    186a:	8b 45 08             	mov    0x8(%ebp),%eax
    186d:	89 04 24             	mov    %eax,(%esp)
    1870:	e8 77 fe ff ff       	call   16ec <printint>
        ap++;
    1875:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1879:	e9 b4 00 00 00       	jmp    1932 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    187e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1882:	75 46                	jne    18ca <printf+0x12d>
        s = (char*)*ap;
    1884:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1887:	8b 00                	mov    (%eax),%eax
    1889:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    188c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1890:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1894:	75 27                	jne    18bd <printf+0x120>
          s = "(null)";
    1896:	c7 45 e4 53 1f 00 00 	movl   $0x1f53,-0x1c(%ebp)
        while(*s != 0){
    189d:	eb 1f                	jmp    18be <printf+0x121>
          putc(fd, *s);
    189f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18a2:	0f b6 00             	movzbl (%eax),%eax
    18a5:	0f be c0             	movsbl %al,%eax
    18a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    18ac:	8b 45 08             	mov    0x8(%ebp),%eax
    18af:	89 04 24             	mov    %eax,(%esp)
    18b2:	e8 0d fe ff ff       	call   16c4 <putc>
          s++;
    18b7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    18bb:	eb 01                	jmp    18be <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    18bd:	90                   	nop
    18be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18c1:	0f b6 00             	movzbl (%eax),%eax
    18c4:	84 c0                	test   %al,%al
    18c6:	75 d7                	jne    189f <printf+0x102>
    18c8:	eb 68                	jmp    1932 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18ca:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    18ce:	75 1d                	jne    18ed <printf+0x150>
        putc(fd, *ap);
    18d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d3:	8b 00                	mov    (%eax),%eax
    18d5:	0f be c0             	movsbl %al,%eax
    18d8:	89 44 24 04          	mov    %eax,0x4(%esp)
    18dc:	8b 45 08             	mov    0x8(%ebp),%eax
    18df:	89 04 24             	mov    %eax,(%esp)
    18e2:	e8 dd fd ff ff       	call   16c4 <putc>
        ap++;
    18e7:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    18eb:	eb 45                	jmp    1932 <printf+0x195>
      } else if(c == '%'){
    18ed:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    18f1:	75 17                	jne    190a <printf+0x16d>
        putc(fd, c);
    18f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    18f6:	0f be c0             	movsbl %al,%eax
    18f9:	89 44 24 04          	mov    %eax,0x4(%esp)
    18fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1900:	89 04 24             	mov    %eax,(%esp)
    1903:	e8 bc fd ff ff       	call   16c4 <putc>
    1908:	eb 28                	jmp    1932 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    190a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1911:	00 
    1912:	8b 45 08             	mov    0x8(%ebp),%eax
    1915:	89 04 24             	mov    %eax,(%esp)
    1918:	e8 a7 fd ff ff       	call   16c4 <putc>
        putc(fd, c);
    191d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1920:	0f be c0             	movsbl %al,%eax
    1923:	89 44 24 04          	mov    %eax,0x4(%esp)
    1927:	8b 45 08             	mov    0x8(%ebp),%eax
    192a:	89 04 24             	mov    %eax,(%esp)
    192d:	e8 92 fd ff ff       	call   16c4 <putc>
      }
      state = 0;
    1932:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1939:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    193d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1940:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1943:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1946:	0f b6 00             	movzbl (%eax),%eax
    1949:	84 c0                	test   %al,%al
    194b:	0f 85 6e fe ff ff    	jne    17bf <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1951:	c9                   	leave  
    1952:	c3                   	ret    
    1953:	90                   	nop

00001954 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1954:	55                   	push   %ebp
    1955:	89 e5                	mov    %esp,%ebp
    1957:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    195a:	8b 45 08             	mov    0x8(%ebp),%eax
    195d:	83 e8 08             	sub    $0x8,%eax
    1960:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1963:	a1 bc 1f 00 00       	mov    0x1fbc,%eax
    1968:	89 45 fc             	mov    %eax,-0x4(%ebp)
    196b:	eb 24                	jmp    1991 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    196d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1970:	8b 00                	mov    (%eax),%eax
    1972:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1975:	77 12                	ja     1989 <free+0x35>
    1977:	8b 45 f8             	mov    -0x8(%ebp),%eax
    197a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    197d:	77 24                	ja     19a3 <free+0x4f>
    197f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1982:	8b 00                	mov    (%eax),%eax
    1984:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1987:	77 1a                	ja     19a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1989:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198c:	8b 00                	mov    (%eax),%eax
    198e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1991:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1994:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1997:	76 d4                	jbe    196d <free+0x19>
    1999:	8b 45 fc             	mov    -0x4(%ebp),%eax
    199c:	8b 00                	mov    (%eax),%eax
    199e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19a1:	76 ca                	jbe    196d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    19a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a6:	8b 40 04             	mov    0x4(%eax),%eax
    19a9:	c1 e0 03             	shl    $0x3,%eax
    19ac:	89 c2                	mov    %eax,%edx
    19ae:	03 55 f8             	add    -0x8(%ebp),%edx
    19b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b4:	8b 00                	mov    (%eax),%eax
    19b6:	39 c2                	cmp    %eax,%edx
    19b8:	75 24                	jne    19de <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    19ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19bd:	8b 50 04             	mov    0x4(%eax),%edx
    19c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c3:	8b 00                	mov    (%eax),%eax
    19c5:	8b 40 04             	mov    0x4(%eax),%eax
    19c8:	01 c2                	add    %eax,%edx
    19ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19cd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    19d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d3:	8b 00                	mov    (%eax),%eax
    19d5:	8b 10                	mov    (%eax),%edx
    19d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19da:	89 10                	mov    %edx,(%eax)
    19dc:	eb 0a                	jmp    19e8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    19de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e1:	8b 10                	mov    (%eax),%edx
    19e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19e6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    19e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19eb:	8b 40 04             	mov    0x4(%eax),%eax
    19ee:	c1 e0 03             	shl    $0x3,%eax
    19f1:	03 45 fc             	add    -0x4(%ebp),%eax
    19f4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19f7:	75 20                	jne    1a19 <free+0xc5>
    p->s.size += bp->s.size;
    19f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19fc:	8b 50 04             	mov    0x4(%eax),%edx
    19ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a02:	8b 40 04             	mov    0x4(%eax),%eax
    1a05:	01 c2                	add    %eax,%edx
    1a07:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a0a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1a0d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a10:	8b 10                	mov    (%eax),%edx
    1a12:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a15:	89 10                	mov    %edx,(%eax)
    1a17:	eb 08                	jmp    1a21 <free+0xcd>
  } else
    p->s.ptr = bp;
    1a19:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a1c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a1f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a21:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a24:	a3 bc 1f 00 00       	mov    %eax,0x1fbc
}
    1a29:	c9                   	leave  
    1a2a:	c3                   	ret    

00001a2b <morecore>:

static Header*
morecore(uint nu)
{
    1a2b:	55                   	push   %ebp
    1a2c:	89 e5                	mov    %esp,%ebp
    1a2e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1a31:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1a38:	77 07                	ja     1a41 <morecore+0x16>
    nu = 4096;
    1a3a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1a41:	8b 45 08             	mov    0x8(%ebp),%eax
    1a44:	c1 e0 03             	shl    $0x3,%eax
    1a47:	89 04 24             	mov    %eax,(%esp)
    1a4a:	e8 35 fc ff ff       	call   1684 <sbrk>
    1a4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1a52:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a56:	75 07                	jne    1a5f <morecore+0x34>
    return 0;
    1a58:	b8 00 00 00 00       	mov    $0x0,%eax
    1a5d:	eb 22                	jmp    1a81 <morecore+0x56>
  hp = (Header*)p;
    1a5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1a65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a68:	8b 55 08             	mov    0x8(%ebp),%edx
    1a6b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a71:	83 c0 08             	add    $0x8,%eax
    1a74:	89 04 24             	mov    %eax,(%esp)
    1a77:	e8 d8 fe ff ff       	call   1954 <free>
  return freep;
    1a7c:	a1 bc 1f 00 00       	mov    0x1fbc,%eax
}
    1a81:	c9                   	leave  
    1a82:	c3                   	ret    

00001a83 <malloc>:

void*
malloc(uint nbytes)
{
    1a83:	55                   	push   %ebp
    1a84:	89 e5                	mov    %esp,%ebp
    1a86:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a89:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8c:	83 c0 07             	add    $0x7,%eax
    1a8f:	c1 e8 03             	shr    $0x3,%eax
    1a92:	83 c0 01             	add    $0x1,%eax
    1a95:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1a98:	a1 bc 1f 00 00       	mov    0x1fbc,%eax
    1a9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1aa0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1aa4:	75 23                	jne    1ac9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1aa6:	c7 45 f0 b4 1f 00 00 	movl   $0x1fb4,-0x10(%ebp)
    1aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ab0:	a3 bc 1f 00 00       	mov    %eax,0x1fbc
    1ab5:	a1 bc 1f 00 00       	mov    0x1fbc,%eax
    1aba:	a3 b4 1f 00 00       	mov    %eax,0x1fb4
    base.s.size = 0;
    1abf:	c7 05 b8 1f 00 00 00 	movl   $0x0,0x1fb8
    1ac6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ac9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1acc:	8b 00                	mov    (%eax),%eax
    1ace:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1ad1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ad4:	8b 40 04             	mov    0x4(%eax),%eax
    1ad7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1ada:	72 4d                	jb     1b29 <malloc+0xa6>
      if(p->s.size == nunits)
    1adc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1adf:	8b 40 04             	mov    0x4(%eax),%eax
    1ae2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1ae5:	75 0c                	jne    1af3 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1ae7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aea:	8b 10                	mov    (%eax),%edx
    1aec:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1aef:	89 10                	mov    %edx,(%eax)
    1af1:	eb 26                	jmp    1b19 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1af3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1af6:	8b 40 04             	mov    0x4(%eax),%eax
    1af9:	89 c2                	mov    %eax,%edx
    1afb:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1afe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b01:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b04:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b07:	8b 40 04             	mov    0x4(%eax),%eax
    1b0a:	c1 e0 03             	shl    $0x3,%eax
    1b0d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1b10:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b13:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b16:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b19:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b1c:	a3 bc 1f 00 00       	mov    %eax,0x1fbc
      return (void*)(p + 1);
    1b21:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b24:	83 c0 08             	add    $0x8,%eax
    1b27:	eb 38                	jmp    1b61 <malloc+0xde>
    }
    if(p == freep)
    1b29:	a1 bc 1f 00 00       	mov    0x1fbc,%eax
    1b2e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1b31:	75 1b                	jne    1b4e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b36:	89 04 24             	mov    %eax,(%esp)
    1b39:	e8 ed fe ff ff       	call   1a2b <morecore>
    1b3e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b41:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b45:	75 07                	jne    1b4e <malloc+0xcb>
        return 0;
    1b47:	b8 00 00 00 00       	mov    $0x0,%eax
    1b4c:	eb 13                	jmp    1b61 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b4e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b51:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b54:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b57:	8b 00                	mov    (%eax),%eax
    1b59:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1b5c:	e9 70 ff ff ff       	jmp    1ad1 <malloc+0x4e>
}
    1b61:	c9                   	leave  
    1b62:	c3                   	ret    
    1b63:	90                   	nop

00001b64 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b64:	55                   	push   %ebp
    1b65:	89 e5                	mov    %esp,%ebp
    1b67:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b6a:	8b 55 08             	mov    0x8(%ebp),%edx
    1b6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b70:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b73:	f0 87 02             	lock xchg %eax,(%edx)
    1b76:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b79:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b7c:	c9                   	leave  
    1b7d:	c3                   	ret    

00001b7e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b7e:	55                   	push   %ebp
    1b7f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b81:	8b 45 08             	mov    0x8(%ebp),%eax
    1b84:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1b8a:	5d                   	pop    %ebp
    1b8b:	c3                   	ret    

00001b8c <lock_acquire>:
void lock_acquire(lock_t *lock){
    1b8c:	55                   	push   %ebp
    1b8d:	89 e5                	mov    %esp,%ebp
    1b8f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1b92:	8b 45 08             	mov    0x8(%ebp),%eax
    1b95:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b9c:	00 
    1b9d:	89 04 24             	mov    %eax,(%esp)
    1ba0:	e8 bf ff ff ff       	call   1b64 <xchg>
    1ba5:	85 c0                	test   %eax,%eax
    1ba7:	75 e9                	jne    1b92 <lock_acquire+0x6>
}
    1ba9:	c9                   	leave  
    1baa:	c3                   	ret    

00001bab <lock_release>:
void lock_release(lock_t *lock){
    1bab:	55                   	push   %ebp
    1bac:	89 e5                	mov    %esp,%ebp
    1bae:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1bb1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1bbb:	00 
    1bbc:	89 04 24             	mov    %eax,(%esp)
    1bbf:	e8 a0 ff ff ff       	call   1b64 <xchg>
}
    1bc4:	c9                   	leave  
    1bc5:	c3                   	ret    

00001bc6 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1bc6:	55                   	push   %ebp
    1bc7:	89 e5                	mov    %esp,%ebp
    1bc9:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1bcc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1bd3:	e8 ab fe ff ff       	call   1a83 <malloc>
    1bd8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1bdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1be1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be4:	25 ff 0f 00 00       	and    $0xfff,%eax
    1be9:	85 c0                	test   %eax,%eax
    1beb:	74 15                	je     1c02 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf0:	89 c2                	mov    %eax,%edx
    1bf2:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1bf8:	b8 00 10 00 00       	mov    $0x1000,%eax
    1bfd:	29 d0                	sub    %edx,%eax
    1bff:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1c02:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c06:	75 1b                	jne    1c23 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1c08:	c7 44 24 04 5a 1f 00 	movl   $0x1f5a,0x4(%esp)
    1c0f:	00 
    1c10:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c17:	e8 81 fb ff ff       	call   179d <printf>
        return 0;
    1c1c:	b8 00 00 00 00       	mov    $0x0,%eax
    1c21:	eb 6f                	jmp    1c92 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1c23:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c26:	8b 55 08             	mov    0x8(%ebp),%edx
    1c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c2c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1c30:	89 54 24 08          	mov    %edx,0x8(%esp)
    1c34:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1c3b:	00 
    1c3c:	89 04 24             	mov    %eax,(%esp)
    1c3f:	e8 58 fa ff ff       	call   169c <clone>
    1c44:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1c47:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c4b:	79 1b                	jns    1c68 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1c4d:	c7 44 24 04 68 1f 00 	movl   $0x1f68,0x4(%esp)
    1c54:	00 
    1c55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c5c:	e8 3c fb ff ff       	call   179d <printf>
        return 0;
    1c61:	b8 00 00 00 00       	mov    $0x0,%eax
    1c66:	eb 2a                	jmp    1c92 <thread_create+0xcc>
    }
    if(tid > 0){
    1c68:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c6c:	7e 05                	jle    1c73 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1c6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c71:	eb 1f                	jmp    1c92 <thread_create+0xcc>
    }
    if(tid == 0){
    1c73:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c77:	75 14                	jne    1c8d <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1c79:	c7 44 24 04 75 1f 00 	movl   $0x1f75,0x4(%esp)
    1c80:	00 
    1c81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c88:	e8 10 fb ff ff       	call   179d <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1c8d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1c92:	c9                   	leave  
    1c93:	c3                   	ret    

00001c94 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1c94:	55                   	push   %ebp
    1c95:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1c97:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    1c9c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1ca2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ca7:	a3 9c 1f 00 00       	mov    %eax,0x1f9c
    return (int)(rands % max);
    1cac:	a1 9c 1f 00 00       	mov    0x1f9c,%eax
    1cb1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cb4:	ba 00 00 00 00       	mov    $0x0,%edx
    1cb9:	f7 f1                	div    %ecx
    1cbb:	89 d0                	mov    %edx,%eax
}
    1cbd:	5d                   	pop    %ebp
    1cbe:	c3                   	ret    
    1cbf:	90                   	nop

00001cc0 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1cc0:	55                   	push   %ebp
    1cc1:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1cc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ccc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1cd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1ce0:	5d                   	pop    %ebp
    1ce1:	c3                   	ret    

00001ce2 <add_q>:

void add_q(struct queue *q, int v){
    1ce2:	55                   	push   %ebp
    1ce3:	89 e5                	mov    %esp,%ebp
    1ce5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1ce8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1cef:	e8 8f fd ff ff       	call   1a83 <malloc>
    1cf4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1cf7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cfa:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d01:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d04:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d07:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d09:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0c:	8b 40 04             	mov    0x4(%eax),%eax
    1d0f:	85 c0                	test   %eax,%eax
    1d11:	75 0b                	jne    1d1e <add_q+0x3c>
        q->head = n;
    1d13:	8b 45 08             	mov    0x8(%ebp),%eax
    1d16:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d19:	89 50 04             	mov    %edx,0x4(%eax)
    1d1c:	eb 0c                	jmp    1d2a <add_q+0x48>
    }else{
        q->tail->next = n;
    1d1e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d21:	8b 40 08             	mov    0x8(%eax),%eax
    1d24:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d27:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1d2a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d30:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1d33:	8b 45 08             	mov    0x8(%ebp),%eax
    1d36:	8b 00                	mov    (%eax),%eax
    1d38:	8d 50 01             	lea    0x1(%eax),%edx
    1d3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1d3e:	89 10                	mov    %edx,(%eax)
}
    1d40:	c9                   	leave  
    1d41:	c3                   	ret    

00001d42 <empty_q>:

int empty_q(struct queue *q){
    1d42:	55                   	push   %ebp
    1d43:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1d45:	8b 45 08             	mov    0x8(%ebp),%eax
    1d48:	8b 00                	mov    (%eax),%eax
    1d4a:	85 c0                	test   %eax,%eax
    1d4c:	75 07                	jne    1d55 <empty_q+0x13>
        return 1;
    1d4e:	b8 01 00 00 00       	mov    $0x1,%eax
    1d53:	eb 05                	jmp    1d5a <empty_q+0x18>
    else
        return 0;
    1d55:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d5a:	5d                   	pop    %ebp
    1d5b:	c3                   	ret    

00001d5c <pop_q>:
int pop_q(struct queue *q){
    1d5c:	55                   	push   %ebp
    1d5d:	89 e5                	mov    %esp,%ebp
    1d5f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d62:	8b 45 08             	mov    0x8(%ebp),%eax
    1d65:	89 04 24             	mov    %eax,(%esp)
    1d68:	e8 d5 ff ff ff       	call   1d42 <empty_q>
    1d6d:	85 c0                	test   %eax,%eax
    1d6f:	75 5d                	jne    1dce <pop_q+0x72>
       val = q->head->value; 
    1d71:	8b 45 08             	mov    0x8(%ebp),%eax
    1d74:	8b 40 04             	mov    0x4(%eax),%eax
    1d77:	8b 00                	mov    (%eax),%eax
    1d79:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1d7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7f:	8b 40 04             	mov    0x4(%eax),%eax
    1d82:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1d85:	8b 45 08             	mov    0x8(%ebp),%eax
    1d88:	8b 40 04             	mov    0x4(%eax),%eax
    1d8b:	8b 50 04             	mov    0x4(%eax),%edx
    1d8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d91:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d97:	89 04 24             	mov    %eax,(%esp)
    1d9a:	e8 b5 fb ff ff       	call   1954 <free>
       q->size--;
    1d9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1da2:	8b 00                	mov    (%eax),%eax
    1da4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1da7:	8b 45 08             	mov    0x8(%ebp),%eax
    1daa:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1dac:	8b 45 08             	mov    0x8(%ebp),%eax
    1daf:	8b 00                	mov    (%eax),%eax
    1db1:	85 c0                	test   %eax,%eax
    1db3:	75 14                	jne    1dc9 <pop_q+0x6d>
            q->head = 0;
    1db5:	8b 45 08             	mov    0x8(%ebp),%eax
    1db8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1dbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1dc9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dcc:	eb 05                	jmp    1dd3 <pop_q+0x77>
    }
    return -1;
    1dce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1dd3:	c9                   	leave  
    1dd4:	c3                   	ret    
    1dd5:	90                   	nop
    1dd6:	90                   	nop
    1dd7:	90                   	nop

00001dd8 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1dd8:	55                   	push   %ebp
    1dd9:	89 e5                	mov    %esp,%ebp
    1ddb:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1dde:	8b 45 08             	mov    0x8(%ebp),%eax
    1de1:	89 04 24             	mov    %eax,(%esp)
    1de4:	e8 a3 fd ff ff       	call   1b8c <lock_acquire>
	s->count--; 
    1de9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dec:	8b 40 04             	mov    0x4(%eax),%eax
    1def:	8d 50 ff             	lea    -0x1(%eax),%edx
    1df2:	8b 45 08             	mov    0x8(%ebp),%eax
    1df5:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1df8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfb:	8b 40 04             	mov    0x4(%eax),%eax
    1dfe:	85 c0                	test   %eax,%eax
    1e00:	79 27                	jns    1e29 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1e02:	e8 75 f8 ff ff       	call   167c <getpid>
    1e07:	8b 55 08             	mov    0x8(%ebp),%edx
    1e0a:	83 c2 08             	add    $0x8,%edx
    1e0d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e11:	89 14 24             	mov    %edx,(%esp)
    1e14:	e8 c9 fe ff ff       	call   1ce2 <add_q>
		lock_release(&s->lock); 
    1e19:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1c:	89 04 24             	mov    %eax,(%esp)
    1e1f:	e8 87 fd ff ff       	call   1bab <lock_release>
		tsleep(); 
    1e24:	e8 83 f8 ff ff       	call   16ac <tsleep>
	} 
	lock_release(&s->lock); 
    1e29:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2c:	89 04 24             	mov    %eax,(%esp)
    1e2f:	e8 77 fd ff ff       	call   1bab <lock_release>
}
    1e34:	c9                   	leave  
    1e35:	c3                   	ret    

00001e36 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1e36:	55                   	push   %ebp
    1e37:	89 e5                	mov    %esp,%ebp
    1e39:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1e3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3f:	89 04 24             	mov    %eax,(%esp)
    1e42:	e8 45 fd ff ff       	call   1b8c <lock_acquire>
	s->count++; 
    1e47:	8b 45 08             	mov    0x8(%ebp),%eax
    1e4a:	8b 40 04             	mov    0x4(%eax),%eax
    1e4d:	8d 50 01             	lea    0x1(%eax),%edx
    1e50:	8b 45 08             	mov    0x8(%ebp),%eax
    1e53:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1e56:	8b 45 08             	mov    0x8(%ebp),%eax
    1e59:	8b 40 04             	mov    0x4(%eax),%eax
    1e5c:	85 c0                	test   %eax,%eax
    1e5e:	7f 1c                	jg     1e7c <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1e60:	8b 45 08             	mov    0x8(%ebp),%eax
    1e63:	83 c0 08             	add    $0x8,%eax
    1e66:	89 04 24             	mov    %eax,(%esp)
    1e69:	e8 ee fe ff ff       	call   1d5c <pop_q>
    1e6e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e74:	89 04 24             	mov    %eax,(%esp)
    1e77:	e8 38 f8 ff ff       	call   16b4 <twakeup>
	}
	lock_release(&s->lock); 
    1e7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7f:	89 04 24             	mov    %eax,(%esp)
    1e82:	e8 24 fd ff ff       	call   1bab <lock_release>
} 
    1e87:	c9                   	leave  
    1e88:	c3                   	ret    

00001e89 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1e89:	55                   	push   %ebp
    1e8a:	89 e5                	mov    %esp,%ebp
    1e8c:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1e8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e92:	89 04 24             	mov    %eax,(%esp)
    1e95:	e8 e4 fc ff ff       	call   1b7e <lock_init>
	s->count = size; 
    1e9a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ea0:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1ea3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea6:	83 c0 08             	add    $0x8,%eax
    1ea9:	89 04 24             	mov    %eax,(%esp)
    1eac:	e8 0f fe ff ff       	call   1cc0 <init_q>
}
    1eb1:	c9                   	leave  
    1eb2:	c3                   	ret    
