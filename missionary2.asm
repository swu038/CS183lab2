
_missionary2:     file format elf32-i386


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
    1009:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1010:	e8 d3 0b 00 00       	call   1be8 <lock_acquire>
	printf(1,"Created 1 missionary, and 2 Cannibal. No boat will set off since the cannibals cannot be with 1 missioanry, infinite loop. \n"); 
    1015:	c7 44 24 04 10 1f 00 	movl   $0x1f10,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 d0 07 00 00       	call   17f9 <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1030:	e8 d2 0b 00 00       	call   1c07 <lock_release>
	
	sem_init(&M, 0); 
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    1044:	e8 9c 0e 00 00       	call   1ee5 <sem_init>
	sem_init(&C, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 a8 20 00 00 	movl   $0x20a8,(%esp)
    1058:	e8 88 0e 00 00       	call   1ee5 <sem_init>

	void *mid = thread_create(MissionaryArrives,(void *)0);
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 d7 10 00 00 	movl   $0x10d7,(%esp)
    106c:	e8 b1 0b 00 00       	call   1c22 <thread_create>
    1071:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(mid == 0) exit(); 
    1075:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 d7 05 00 00       	call   1658 <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 0e 12 00 00 	movl   $0x120e,(%esp)
    1090:	e8 8d 0b 00 00       	call   1c22 <thread_create>
    1095:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(cid == 0) exit(); 
    1099:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 b3 05 00 00       	call   1658 <exit>

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
    10a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 0e 12 00 00 	movl   $0x120e,(%esp)
    10b4:	e8 69 0b 00 00       	call   1c22 <thread_create>
    10b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(cid2 == 0) exit(); 
    10bd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 8f 05 00 00       	call   1658 <exit>

	while(wait() > 0); 
    10c9:	e8 92 05 00 00       	call   1660 <wait>
    10ce:	85 c0                	test   %eax,%eax
    10d0:	7f f7                	jg     10c9 <main+0xc9>

	exit(); 
    10d2:	e8 81 05 00 00       	call   1658 <exit>

000010d7 <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    10d7:	55                   	push   %ebp
    10d8:	89 e5                	mov    %esp,%ebp
    10da:	83 ec 18             	sub    $0x18,%esp
	if(numMissionaries == 2) 
    10dd:	a1 84 20 00 00       	mov    0x2084,%eax
    10e2:	83 f8 02             	cmp    $0x2,%eax
    10e5:	75 47                	jne    112e <MissionaryArrives+0x57>
	{
		lock_acquire(&mutex.lock);
    10e7:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    10ee:	e8 f5 0a 00 00       	call   1be8 <lock_acquire>
		missCount++; //for num of miss in boat. 
    10f3:	a1 90 20 00 00       	mov    0x2090,%eax
    10f8:	83 c0 01             	add    $0x1,%eax
    10fb:	a3 90 20 00 00       	mov    %eax,0x2090
		lock_release(&mutex.lock);
    1100:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1107:	e8 fb 0a 00 00       	call   1c07 <lock_release>
		sem_signal(&M); 
    110c:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    1113:	e8 7a 0d 00 00       	call   1e92 <sem_signal>
		sem_signal(&M); 
    1118:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    111f:	e8 6e 0d 00 00       	call   1e92 <sem_signal>
		RowBoat();
    1124:	e8 2f 02 00 00       	call   1358 <RowBoat>
    1129:	e9 db 00 00 00       	jmp    1209 <MissionaryArrives+0x132>
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    112e:	a1 84 20 00 00       	mov    0x2084,%eax
    1133:	83 f8 01             	cmp    $0x1,%eax
    1136:	75 51                	jne    1189 <MissionaryArrives+0xb2>
    1138:	a1 88 20 00 00       	mov    0x2088,%eax
    113d:	83 f8 01             	cmp    $0x1,%eax
    1140:	75 47                	jne    1189 <MissionaryArrives+0xb2>
		lock_acquire(&mutex.lock);
    1142:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1149:	e8 9a 0a 00 00       	call   1be8 <lock_acquire>
		missCount++; //for num of miss in boat. 
    114e:	a1 90 20 00 00       	mov    0x2090,%eax
    1153:	83 c0 01             	add    $0x1,%eax
    1156:	a3 90 20 00 00       	mov    %eax,0x2090
		lock_release(&mutex.lock);
    115b:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1162:	e8 a0 0a 00 00       	call   1c07 <lock_release>
		sem_signal(&M); 
    1167:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    116e:	e8 1f 0d 00 00       	call   1e92 <sem_signal>
		sem_signal(&C);
    1173:	c7 04 24 a8 20 00 00 	movl   $0x20a8,(%esp)
    117a:	e8 13 0d 00 00       	call   1e92 <sem_signal>
		RowBoat(); 
    117f:	e8 d4 01 00 00       	call   1358 <RowBoat>
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&M); 
		RowBoat();
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1184:	e9 80 00 00 00       	jmp    1209 <MissionaryArrives+0x132>
		sem_signal(&M); 
		sem_signal(&C);
		RowBoat(); 
	} 
	else {
		lock_acquire(&mutex.lock); 
    1189:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1190:	e8 53 0a 00 00       	call   1be8 <lock_acquire>
		numMissionaries++;
    1195:	a1 84 20 00 00       	mov    0x2084,%eax
    119a:	83 c0 01             	add    $0x1,%eax
    119d:	a3 84 20 00 00       	mov    %eax,0x2084
		missCount++;  //for num of miss in boat.
    11a2:	a1 90 20 00 00       	mov    0x2090,%eax
    11a7:	83 c0 01             	add    $0x1,%eax
    11aa:	a3 90 20 00 00       	mov    %eax,0x2090
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
    11af:	a1 90 20 00 00       	mov    0x2090,%eax
    11b4:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b8:	c7 44 24 04 90 1f 00 	movl   $0x1f90,0x4(%esp)
    11bf:	00 
    11c0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c7:	e8 2d 06 00 00       	call   17f9 <printf>
		lock_release(&mutex.lock);  
    11cc:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    11d3:	e8 2f 0a 00 00       	call   1c07 <lock_release>
		sem_acquire(&M);
    11d8:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    11df:	e8 50 0c 00 00       	call   1e34 <sem_acquire>
		lock_acquire(&mutex.lock);  
    11e4:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    11eb:	e8 f8 09 00 00       	call   1be8 <lock_acquire>
		numMissionaries--; 
    11f0:	a1 84 20 00 00       	mov    0x2084,%eax
    11f5:	83 e8 01             	sub    $0x1,%eax
    11f8:	a3 84 20 00 00       	mov    %eax,0x2084
		lock_release(&mutex.lock);  
    11fd:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1204:	e8 fe 09 00 00       	call   1c07 <lock_release>
	} 
	texit();  
    1209:	e8 f2 04 00 00       	call   1700 <texit>

0000120e <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    120e:	55                   	push   %ebp
    120f:	89 e5                	mov    %esp,%ebp
    1211:	83 ec 18             	sub    $0x18,%esp
	if(numCannibals == 2) 
    1214:	a1 88 20 00 00       	mov    0x2088,%eax
    1219:	83 f8 02             	cmp    $0x2,%eax
    121c:	75 64                	jne    1282 <CannibalArrives+0x74>
	{
		lock_acquire(&mutex.lock); 
    121e:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1225:	e8 be 09 00 00       	call   1be8 <lock_acquire>
		canCount++; //for num of can in boat. 
    122a:	a1 8c 20 00 00       	mov    0x208c,%eax
    122f:	83 c0 01             	add    $0x1,%eax
    1232:	a3 8c 20 00 00       	mov    %eax,0x208c
		printf(1,"Number of cannibals arrived: %d.\n",canCount);  
    1237:	a1 8c 20 00 00       	mov    0x208c,%eax
    123c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1240:	c7 44 24 04 b8 1f 00 	movl   $0x1fb8,0x4(%esp)
    1247:	00 
    1248:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124f:	e8 a5 05 00 00       	call   17f9 <printf>
		lock_release(&mutex.lock);  
    1254:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    125b:	e8 a7 09 00 00       	call   1c07 <lock_release>
		sem_signal(&C); 
    1260:	c7 04 24 a8 20 00 00 	movl   $0x20a8,(%esp)
    1267:	e8 26 0c 00 00       	call   1e92 <sem_signal>
		sem_signal(&C);
    126c:	c7 04 24 a8 20 00 00 	movl   $0x20a8,(%esp)
    1273:	e8 1a 0c 00 00       	call   1e92 <sem_signal>
		RowBoat();  		
    1278:	e8 db 00 00 00       	call   1358 <RowBoat>
    127d:	e9 d1 00 00 00       	jmp    1353 <CannibalArrives+0x145>
	}
	else if(numMissionaries == 2) {
    1282:	a1 84 20 00 00       	mov    0x2084,%eax
    1287:	83 f8 02             	cmp    $0x2,%eax
    128a:	75 47                	jne    12d3 <CannibalArrives+0xc5>
		lock_acquire(&mutex.lock); 
    128c:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1293:	e8 50 09 00 00       	call   1be8 <lock_acquire>
		canCount++; //for num of can in boat.  
    1298:	a1 8c 20 00 00       	mov    0x208c,%eax
    129d:	83 c0 01             	add    $0x1,%eax
    12a0:	a3 8c 20 00 00       	mov    %eax,0x208c
		lock_release(&mutex.lock);  
    12a5:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    12ac:	e8 56 09 00 00       	call   1c07 <lock_release>
		sem_signal(&M);
    12b1:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    12b8:	e8 d5 0b 00 00       	call   1e92 <sem_signal>
		sem_signal(&M); 
    12bd:	c7 04 24 bc 20 00 00 	movl   $0x20bc,(%esp)
    12c4:	e8 c9 0b 00 00       	call   1e92 <sem_signal>
		RowBoat(); 
    12c9:	e8 8a 00 00 00       	call   1358 <RowBoat>
    12ce:	e9 80 00 00 00       	jmp    1353 <CannibalArrives+0x145>
	}
	else {
	lock_acquire(&mutex.lock);
    12d3:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    12da:	e8 09 09 00 00       	call   1be8 <lock_acquire>
	canCount++; //for num of can in boat. 
    12df:	a1 8c 20 00 00       	mov    0x208c,%eax
    12e4:	83 c0 01             	add    $0x1,%eax
    12e7:	a3 8c 20 00 00       	mov    %eax,0x208c
	printf(1, "Number of cannibals arrived: %d.\n",canCount);  
    12ec:	a1 8c 20 00 00       	mov    0x208c,%eax
    12f1:	89 44 24 08          	mov    %eax,0x8(%esp)
    12f5:	c7 44 24 04 b8 1f 00 	movl   $0x1fb8,0x4(%esp)
    12fc:	00 
    12fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1304:	e8 f0 04 00 00       	call   17f9 <printf>
	numCannibals++; 
    1309:	a1 88 20 00 00       	mov    0x2088,%eax
    130e:	83 c0 01             	add    $0x1,%eax
    1311:	a3 88 20 00 00       	mov    %eax,0x2088
	lock_release(&mutex.lock);
    1316:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    131d:	e8 e5 08 00 00       	call   1c07 <lock_release>
	sem_acquire(&C); 
    1322:	c7 04 24 a8 20 00 00 	movl   $0x20a8,(%esp)
    1329:	e8 06 0b 00 00       	call   1e34 <sem_acquire>
	lock_acquire(&mutex.lock);  
    132e:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1335:	e8 ae 08 00 00       	call   1be8 <lock_acquire>
	numCannibals--;
    133a:	a1 88 20 00 00       	mov    0x2088,%eax
    133f:	83 e8 01             	sub    $0x1,%eax
    1342:	a3 88 20 00 00       	mov    %eax,0x2088
	lock_release(&mutex.lock);
    1347:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    134e:	e8 b4 08 00 00       	call   1c07 <lock_release>
	}
	texit(); 
    1353:	e8 a8 03 00 00       	call   1700 <texit>

00001358 <RowBoat>:
} 	

void RowBoat() {
    1358:	55                   	push   %ebp
    1359:	89 e5                	mov    %esp,%ebp
    135b:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    135e:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    1365:	e8 7e 08 00 00       	call   1be8 <lock_acquire>
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
    136a:	a1 8c 20 00 00       	mov    0x208c,%eax
    136f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1373:	c7 44 24 04 dc 1f 00 	movl   $0x1fdc,0x4(%esp)
    137a:	00 
    137b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1382:	e8 72 04 00 00       	call   17f9 <printf>
	printf(1,"Number of missionaries in boat: %d.\n",missCount); 
    1387:	a1 90 20 00 00       	mov    0x2090,%eax
    138c:	89 44 24 08          	mov    %eax,0x8(%esp)
    1390:	c7 44 24 04 00 20 00 	movl   $0x2000,0x4(%esp)
    1397:	00 
    1398:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    139f:	e8 55 04 00 00       	call   17f9 <printf>
	numBoat++;
    13a4:	a1 94 20 00 00       	mov    0x2094,%eax
    13a9:	83 c0 01             	add    $0x1,%eax
    13ac:	a3 94 20 00 00       	mov    %eax,0x2094
	canCount = 0; 
    13b1:	c7 05 8c 20 00 00 00 	movl   $0x0,0x208c
    13b8:	00 00 00 
	missCount = 0; 
    13bb:	c7 05 90 20 00 00 00 	movl   $0x0,0x2090
    13c2:	00 00 00 
	printf(1,"Rowing boat: %d.\n",numBoat);
    13c5:	a1 94 20 00 00       	mov    0x2094,%eax
    13ca:	89 44 24 08          	mov    %eax,0x8(%esp)
    13ce:	c7 44 24 04 25 20 00 	movl   $0x2025,0x4(%esp)
    13d5:	00 
    13d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13dd:	e8 17 04 00 00       	call   17f9 <printf>
	lock_release(&mutex.lock); 
    13e2:	c7 04 24 a4 20 00 00 	movl   $0x20a4,(%esp)
    13e9:	e8 19 08 00 00       	call   1c07 <lock_release>
	texit();  
    13ee:	e8 0d 03 00 00       	call   1700 <texit>
    13f3:	90                   	nop

000013f4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    13f4:	55                   	push   %ebp
    13f5:	89 e5                	mov    %esp,%ebp
    13f7:	57                   	push   %edi
    13f8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    13f9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13fc:	8b 55 10             	mov    0x10(%ebp),%edx
    13ff:	8b 45 0c             	mov    0xc(%ebp),%eax
    1402:	89 cb                	mov    %ecx,%ebx
    1404:	89 df                	mov    %ebx,%edi
    1406:	89 d1                	mov    %edx,%ecx
    1408:	fc                   	cld    
    1409:	f3 aa                	rep stos %al,%es:(%edi)
    140b:	89 ca                	mov    %ecx,%edx
    140d:	89 fb                	mov    %edi,%ebx
    140f:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1412:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1415:	5b                   	pop    %ebx
    1416:	5f                   	pop    %edi
    1417:	5d                   	pop    %ebp
    1418:	c3                   	ret    

00001419 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1419:	55                   	push   %ebp
    141a:	89 e5                	mov    %esp,%ebp
    141c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    141f:	8b 45 08             	mov    0x8(%ebp),%eax
    1422:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1425:	8b 45 0c             	mov    0xc(%ebp),%eax
    1428:	0f b6 10             	movzbl (%eax),%edx
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	88 10                	mov    %dl,(%eax)
    1430:	8b 45 08             	mov    0x8(%ebp),%eax
    1433:	0f b6 00             	movzbl (%eax),%eax
    1436:	84 c0                	test   %al,%al
    1438:	0f 95 c0             	setne  %al
    143b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    143f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1443:	84 c0                	test   %al,%al
    1445:	75 de                	jne    1425 <strcpy+0xc>
    ;
  return os;
    1447:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    144a:	c9                   	leave  
    144b:	c3                   	ret    

0000144c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    144c:	55                   	push   %ebp
    144d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    144f:	eb 08                	jmp    1459 <strcmp+0xd>
    p++, q++;
    1451:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1455:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
    145c:	0f b6 00             	movzbl (%eax),%eax
    145f:	84 c0                	test   %al,%al
    1461:	74 10                	je     1473 <strcmp+0x27>
    1463:	8b 45 08             	mov    0x8(%ebp),%eax
    1466:	0f b6 10             	movzbl (%eax),%edx
    1469:	8b 45 0c             	mov    0xc(%ebp),%eax
    146c:	0f b6 00             	movzbl (%eax),%eax
    146f:	38 c2                	cmp    %al,%dl
    1471:	74 de                	je     1451 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1473:	8b 45 08             	mov    0x8(%ebp),%eax
    1476:	0f b6 00             	movzbl (%eax),%eax
    1479:	0f b6 d0             	movzbl %al,%edx
    147c:	8b 45 0c             	mov    0xc(%ebp),%eax
    147f:	0f b6 00             	movzbl (%eax),%eax
    1482:	0f b6 c0             	movzbl %al,%eax
    1485:	89 d1                	mov    %edx,%ecx
    1487:	29 c1                	sub    %eax,%ecx
    1489:	89 c8                	mov    %ecx,%eax
}
    148b:	5d                   	pop    %ebp
    148c:	c3                   	ret    

0000148d <strlen>:

uint
strlen(char *s)
{
    148d:	55                   	push   %ebp
    148e:	89 e5                	mov    %esp,%ebp
    1490:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1493:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    149a:	eb 04                	jmp    14a0 <strlen+0x13>
    149c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    14a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    14a3:	03 45 08             	add    0x8(%ebp),%eax
    14a6:	0f b6 00             	movzbl (%eax),%eax
    14a9:	84 c0                	test   %al,%al
    14ab:	75 ef                	jne    149c <strlen+0xf>
    ;
  return n;
    14ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    14b0:	c9                   	leave  
    14b1:	c3                   	ret    

000014b2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    14b2:	55                   	push   %ebp
    14b3:	89 e5                	mov    %esp,%ebp
    14b5:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    14b8:	8b 45 10             	mov    0x10(%ebp),%eax
    14bb:	89 44 24 08          	mov    %eax,0x8(%esp)
    14bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    14c2:	89 44 24 04          	mov    %eax,0x4(%esp)
    14c6:	8b 45 08             	mov    0x8(%ebp),%eax
    14c9:	89 04 24             	mov    %eax,(%esp)
    14cc:	e8 23 ff ff ff       	call   13f4 <stosb>
  return dst;
    14d1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    14d4:	c9                   	leave  
    14d5:	c3                   	ret    

000014d6 <strchr>:

char*
strchr(const char *s, char c)
{
    14d6:	55                   	push   %ebp
    14d7:	89 e5                	mov    %esp,%ebp
    14d9:	83 ec 04             	sub    $0x4,%esp
    14dc:	8b 45 0c             	mov    0xc(%ebp),%eax
    14df:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    14e2:	eb 14                	jmp    14f8 <strchr+0x22>
    if(*s == c)
    14e4:	8b 45 08             	mov    0x8(%ebp),%eax
    14e7:	0f b6 00             	movzbl (%eax),%eax
    14ea:	3a 45 fc             	cmp    -0x4(%ebp),%al
    14ed:	75 05                	jne    14f4 <strchr+0x1e>
      return (char*)s;
    14ef:	8b 45 08             	mov    0x8(%ebp),%eax
    14f2:	eb 13                	jmp    1507 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    14f4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14f8:	8b 45 08             	mov    0x8(%ebp),%eax
    14fb:	0f b6 00             	movzbl (%eax),%eax
    14fe:	84 c0                	test   %al,%al
    1500:	75 e2                	jne    14e4 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1502:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1507:	c9                   	leave  
    1508:	c3                   	ret    

00001509 <gets>:

char*
gets(char *buf, int max)
{
    1509:	55                   	push   %ebp
    150a:	89 e5                	mov    %esp,%ebp
    150c:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    150f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1516:	eb 44                	jmp    155c <gets+0x53>
    cc = read(0, &c, 1);
    1518:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    151f:	00 
    1520:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1523:	89 44 24 04          	mov    %eax,0x4(%esp)
    1527:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    152e:	e8 3d 01 00 00       	call   1670 <read>
    1533:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1536:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    153a:	7e 2d                	jle    1569 <gets+0x60>
      break;
    buf[i++] = c;
    153c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    153f:	03 45 08             	add    0x8(%ebp),%eax
    1542:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1546:	88 10                	mov    %dl,(%eax)
    1548:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    154c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1550:	3c 0a                	cmp    $0xa,%al
    1552:	74 16                	je     156a <gets+0x61>
    1554:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1558:	3c 0d                	cmp    $0xd,%al
    155a:	74 0e                	je     156a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    155c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    155f:	83 c0 01             	add    $0x1,%eax
    1562:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1565:	7c b1                	jl     1518 <gets+0xf>
    1567:	eb 01                	jmp    156a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1569:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    156a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    156d:	03 45 08             	add    0x8(%ebp),%eax
    1570:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1573:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1576:	c9                   	leave  
    1577:	c3                   	ret    

00001578 <stat>:

int
stat(char *n, struct stat *st)
{
    1578:	55                   	push   %ebp
    1579:	89 e5                	mov    %esp,%ebp
    157b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    157e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1585:	00 
    1586:	8b 45 08             	mov    0x8(%ebp),%eax
    1589:	89 04 24             	mov    %eax,(%esp)
    158c:	e8 07 01 00 00       	call   1698 <open>
    1591:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1594:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1598:	79 07                	jns    15a1 <stat+0x29>
    return -1;
    159a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    159f:	eb 23                	jmp    15c4 <stat+0x4c>
  r = fstat(fd, st);
    15a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a4:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15ab:	89 04 24             	mov    %eax,(%esp)
    15ae:	e8 fd 00 00 00       	call   16b0 <fstat>
    15b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    15b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    15b9:	89 04 24             	mov    %eax,(%esp)
    15bc:	e8 bf 00 00 00       	call   1680 <close>
  return r;
    15c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    15c4:	c9                   	leave  
    15c5:	c3                   	ret    

000015c6 <atoi>:

int
atoi(const char *s)
{
    15c6:	55                   	push   %ebp
    15c7:	89 e5                	mov    %esp,%ebp
    15c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    15cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    15d3:	eb 24                	jmp    15f9 <atoi+0x33>
    n = n*10 + *s++ - '0';
    15d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    15d8:	89 d0                	mov    %edx,%eax
    15da:	c1 e0 02             	shl    $0x2,%eax
    15dd:	01 d0                	add    %edx,%eax
    15df:	01 c0                	add    %eax,%eax
    15e1:	89 c2                	mov    %eax,%edx
    15e3:	8b 45 08             	mov    0x8(%ebp),%eax
    15e6:	0f b6 00             	movzbl (%eax),%eax
    15e9:	0f be c0             	movsbl %al,%eax
    15ec:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15ef:	83 e8 30             	sub    $0x30,%eax
    15f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    15f9:	8b 45 08             	mov    0x8(%ebp),%eax
    15fc:	0f b6 00             	movzbl (%eax),%eax
    15ff:	3c 2f                	cmp    $0x2f,%al
    1601:	7e 0a                	jle    160d <atoi+0x47>
    1603:	8b 45 08             	mov    0x8(%ebp),%eax
    1606:	0f b6 00             	movzbl (%eax),%eax
    1609:	3c 39                	cmp    $0x39,%al
    160b:	7e c8                	jle    15d5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    160d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1610:	c9                   	leave  
    1611:	c3                   	ret    

00001612 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1612:	55                   	push   %ebp
    1613:	89 e5                	mov    %esp,%ebp
    1615:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1618:	8b 45 08             	mov    0x8(%ebp),%eax
    161b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    161e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1621:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1624:	eb 13                	jmp    1639 <memmove+0x27>
    *dst++ = *src++;
    1626:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1629:	0f b6 10             	movzbl (%eax),%edx
    162c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    162f:	88 10                	mov    %dl,(%eax)
    1631:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1635:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1639:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    163d:	0f 9f c0             	setg   %al
    1640:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1644:	84 c0                	test   %al,%al
    1646:	75 de                	jne    1626 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1648:	8b 45 08             	mov    0x8(%ebp),%eax
}
    164b:	c9                   	leave  
    164c:	c3                   	ret    
    164d:	90                   	nop
    164e:	90                   	nop
    164f:	90                   	nop

00001650 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1650:	b8 01 00 00 00       	mov    $0x1,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    

00001658 <exit>:
SYSCALL(exit)
    1658:	b8 02 00 00 00       	mov    $0x2,%eax
    165d:	cd 40                	int    $0x40
    165f:	c3                   	ret    

00001660 <wait>:
SYSCALL(wait)
    1660:	b8 03 00 00 00       	mov    $0x3,%eax
    1665:	cd 40                	int    $0x40
    1667:	c3                   	ret    

00001668 <pipe>:
SYSCALL(pipe)
    1668:	b8 04 00 00 00       	mov    $0x4,%eax
    166d:	cd 40                	int    $0x40
    166f:	c3                   	ret    

00001670 <read>:
SYSCALL(read)
    1670:	b8 05 00 00 00       	mov    $0x5,%eax
    1675:	cd 40                	int    $0x40
    1677:	c3                   	ret    

00001678 <write>:
SYSCALL(write)
    1678:	b8 10 00 00 00       	mov    $0x10,%eax
    167d:	cd 40                	int    $0x40
    167f:	c3                   	ret    

00001680 <close>:
SYSCALL(close)
    1680:	b8 15 00 00 00       	mov    $0x15,%eax
    1685:	cd 40                	int    $0x40
    1687:	c3                   	ret    

00001688 <kill>:
SYSCALL(kill)
    1688:	b8 06 00 00 00       	mov    $0x6,%eax
    168d:	cd 40                	int    $0x40
    168f:	c3                   	ret    

00001690 <exec>:
SYSCALL(exec)
    1690:	b8 07 00 00 00       	mov    $0x7,%eax
    1695:	cd 40                	int    $0x40
    1697:	c3                   	ret    

00001698 <open>:
SYSCALL(open)
    1698:	b8 0f 00 00 00       	mov    $0xf,%eax
    169d:	cd 40                	int    $0x40
    169f:	c3                   	ret    

000016a0 <mknod>:
SYSCALL(mknod)
    16a0:	b8 11 00 00 00       	mov    $0x11,%eax
    16a5:	cd 40                	int    $0x40
    16a7:	c3                   	ret    

000016a8 <unlink>:
SYSCALL(unlink)
    16a8:	b8 12 00 00 00       	mov    $0x12,%eax
    16ad:	cd 40                	int    $0x40
    16af:	c3                   	ret    

000016b0 <fstat>:
SYSCALL(fstat)
    16b0:	b8 08 00 00 00       	mov    $0x8,%eax
    16b5:	cd 40                	int    $0x40
    16b7:	c3                   	ret    

000016b8 <link>:
SYSCALL(link)
    16b8:	b8 13 00 00 00       	mov    $0x13,%eax
    16bd:	cd 40                	int    $0x40
    16bf:	c3                   	ret    

000016c0 <mkdir>:
SYSCALL(mkdir)
    16c0:	b8 14 00 00 00       	mov    $0x14,%eax
    16c5:	cd 40                	int    $0x40
    16c7:	c3                   	ret    

000016c8 <chdir>:
SYSCALL(chdir)
    16c8:	b8 09 00 00 00       	mov    $0x9,%eax
    16cd:	cd 40                	int    $0x40
    16cf:	c3                   	ret    

000016d0 <dup>:
SYSCALL(dup)
    16d0:	b8 0a 00 00 00       	mov    $0xa,%eax
    16d5:	cd 40                	int    $0x40
    16d7:	c3                   	ret    

000016d8 <getpid>:
SYSCALL(getpid)
    16d8:	b8 0b 00 00 00       	mov    $0xb,%eax
    16dd:	cd 40                	int    $0x40
    16df:	c3                   	ret    

000016e0 <sbrk>:
SYSCALL(sbrk)
    16e0:	b8 0c 00 00 00       	mov    $0xc,%eax
    16e5:	cd 40                	int    $0x40
    16e7:	c3                   	ret    

000016e8 <sleep>:
SYSCALL(sleep)
    16e8:	b8 0d 00 00 00       	mov    $0xd,%eax
    16ed:	cd 40                	int    $0x40
    16ef:	c3                   	ret    

000016f0 <uptime>:
SYSCALL(uptime)
    16f0:	b8 0e 00 00 00       	mov    $0xe,%eax
    16f5:	cd 40                	int    $0x40
    16f7:	c3                   	ret    

000016f8 <clone>:
SYSCALL(clone)
    16f8:	b8 16 00 00 00       	mov    $0x16,%eax
    16fd:	cd 40                	int    $0x40
    16ff:	c3                   	ret    

00001700 <texit>:
SYSCALL(texit)
    1700:	b8 17 00 00 00       	mov    $0x17,%eax
    1705:	cd 40                	int    $0x40
    1707:	c3                   	ret    

00001708 <tsleep>:
SYSCALL(tsleep)
    1708:	b8 18 00 00 00       	mov    $0x18,%eax
    170d:	cd 40                	int    $0x40
    170f:	c3                   	ret    

00001710 <twakeup>:
SYSCALL(twakeup)
    1710:	b8 19 00 00 00       	mov    $0x19,%eax
    1715:	cd 40                	int    $0x40
    1717:	c3                   	ret    

00001718 <thread_yield>:
SYSCALL(thread_yield) 
    1718:	b8 1a 00 00 00       	mov    $0x1a,%eax
    171d:	cd 40                	int    $0x40
    171f:	c3                   	ret    

00001720 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1720:	55                   	push   %ebp
    1721:	89 e5                	mov    %esp,%ebp
    1723:	83 ec 28             	sub    $0x28,%esp
    1726:	8b 45 0c             	mov    0xc(%ebp),%eax
    1729:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    172c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1733:	00 
    1734:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1737:	89 44 24 04          	mov    %eax,0x4(%esp)
    173b:	8b 45 08             	mov    0x8(%ebp),%eax
    173e:	89 04 24             	mov    %eax,(%esp)
    1741:	e8 32 ff ff ff       	call   1678 <write>
}
    1746:	c9                   	leave  
    1747:	c3                   	ret    

00001748 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1748:	55                   	push   %ebp
    1749:	89 e5                	mov    %esp,%ebp
    174b:	53                   	push   %ebx
    174c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    174f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1756:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    175a:	74 17                	je     1773 <printint+0x2b>
    175c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1760:	79 11                	jns    1773 <printint+0x2b>
    neg = 1;
    1762:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1769:	8b 45 0c             	mov    0xc(%ebp),%eax
    176c:	f7 d8                	neg    %eax
    176e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1771:	eb 06                	jmp    1779 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1773:	8b 45 0c             	mov    0xc(%ebp),%eax
    1776:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1779:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1780:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1783:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1786:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1789:	ba 00 00 00 00       	mov    $0x0,%edx
    178e:	f7 f3                	div    %ebx
    1790:	89 d0                	mov    %edx,%eax
    1792:	0f b6 80 6c 20 00 00 	movzbl 0x206c(%eax),%eax
    1799:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    179d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    17a1:	8b 45 10             	mov    0x10(%ebp),%eax
    17a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    17a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17aa:	ba 00 00 00 00       	mov    $0x0,%edx
    17af:	f7 75 d4             	divl   -0x2c(%ebp)
    17b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    17b5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17b9:	75 c5                	jne    1780 <printint+0x38>
  if(neg)
    17bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17bf:	74 28                	je     17e9 <printint+0xa1>
    buf[i++] = '-';
    17c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17c4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    17c9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    17cd:	eb 1a                	jmp    17e9 <printint+0xa1>
    putc(fd, buf[i]);
    17cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d2:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    17d7:	0f be c0             	movsbl %al,%eax
    17da:	89 44 24 04          	mov    %eax,0x4(%esp)
    17de:	8b 45 08             	mov    0x8(%ebp),%eax
    17e1:	89 04 24             	mov    %eax,(%esp)
    17e4:	e8 37 ff ff ff       	call   1720 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    17e9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    17ed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17f1:	79 dc                	jns    17cf <printint+0x87>
    putc(fd, buf[i]);
}
    17f3:	83 c4 44             	add    $0x44,%esp
    17f6:	5b                   	pop    %ebx
    17f7:	5d                   	pop    %ebp
    17f8:	c3                   	ret    

000017f9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    17f9:	55                   	push   %ebp
    17fa:	89 e5                	mov    %esp,%ebp
    17fc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    17ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1806:	8d 45 0c             	lea    0xc(%ebp),%eax
    1809:	83 c0 04             	add    $0x4,%eax
    180c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    180f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1816:	e9 7e 01 00 00       	jmp    1999 <printf+0x1a0>
    c = fmt[i] & 0xff;
    181b:	8b 55 0c             	mov    0xc(%ebp),%edx
    181e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1821:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1824:	0f b6 00             	movzbl (%eax),%eax
    1827:	0f be c0             	movsbl %al,%eax
    182a:	25 ff 00 00 00       	and    $0xff,%eax
    182f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1832:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1836:	75 2c                	jne    1864 <printf+0x6b>
      if(c == '%'){
    1838:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    183c:	75 0c                	jne    184a <printf+0x51>
        state = '%';
    183e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1845:	e9 4b 01 00 00       	jmp    1995 <printf+0x19c>
      } else {
        putc(fd, c);
    184a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    184d:	0f be c0             	movsbl %al,%eax
    1850:	89 44 24 04          	mov    %eax,0x4(%esp)
    1854:	8b 45 08             	mov    0x8(%ebp),%eax
    1857:	89 04 24             	mov    %eax,(%esp)
    185a:	e8 c1 fe ff ff       	call   1720 <putc>
    185f:	e9 31 01 00 00       	jmp    1995 <printf+0x19c>
      }
    } else if(state == '%'){
    1864:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1868:	0f 85 27 01 00 00    	jne    1995 <printf+0x19c>
      if(c == 'd'){
    186e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1872:	75 2d                	jne    18a1 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1874:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1877:	8b 00                	mov    (%eax),%eax
    1879:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1880:	00 
    1881:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1888:	00 
    1889:	89 44 24 04          	mov    %eax,0x4(%esp)
    188d:	8b 45 08             	mov    0x8(%ebp),%eax
    1890:	89 04 24             	mov    %eax,(%esp)
    1893:	e8 b0 fe ff ff       	call   1748 <printint>
        ap++;
    1898:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    189c:	e9 ed 00 00 00       	jmp    198e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    18a1:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    18a5:	74 06                	je     18ad <printf+0xb4>
    18a7:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    18ab:	75 2d                	jne    18da <printf+0xe1>
        printint(fd, *ap, 16, 0);
    18ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b0:	8b 00                	mov    (%eax),%eax
    18b2:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    18b9:	00 
    18ba:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    18c1:	00 
    18c2:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c6:	8b 45 08             	mov    0x8(%ebp),%eax
    18c9:	89 04 24             	mov    %eax,(%esp)
    18cc:	e8 77 fe ff ff       	call   1748 <printint>
        ap++;
    18d1:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    18d5:	e9 b4 00 00 00       	jmp    198e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    18da:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    18de:	75 46                	jne    1926 <printf+0x12d>
        s = (char*)*ap;
    18e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e3:	8b 00                	mov    (%eax),%eax
    18e5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    18e8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    18ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    18f0:	75 27                	jne    1919 <printf+0x120>
          s = "(null)";
    18f2:	c7 45 e4 37 20 00 00 	movl   $0x2037,-0x1c(%ebp)
        while(*s != 0){
    18f9:	eb 1f                	jmp    191a <printf+0x121>
          putc(fd, *s);
    18fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18fe:	0f b6 00             	movzbl (%eax),%eax
    1901:	0f be c0             	movsbl %al,%eax
    1904:	89 44 24 04          	mov    %eax,0x4(%esp)
    1908:	8b 45 08             	mov    0x8(%ebp),%eax
    190b:	89 04 24             	mov    %eax,(%esp)
    190e:	e8 0d fe ff ff       	call   1720 <putc>
          s++;
    1913:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1917:	eb 01                	jmp    191a <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1919:	90                   	nop
    191a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    191d:	0f b6 00             	movzbl (%eax),%eax
    1920:	84 c0                	test   %al,%al
    1922:	75 d7                	jne    18fb <printf+0x102>
    1924:	eb 68                	jmp    198e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1926:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    192a:	75 1d                	jne    1949 <printf+0x150>
        putc(fd, *ap);
    192c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    192f:	8b 00                	mov    (%eax),%eax
    1931:	0f be c0             	movsbl %al,%eax
    1934:	89 44 24 04          	mov    %eax,0x4(%esp)
    1938:	8b 45 08             	mov    0x8(%ebp),%eax
    193b:	89 04 24             	mov    %eax,(%esp)
    193e:	e8 dd fd ff ff       	call   1720 <putc>
        ap++;
    1943:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1947:	eb 45                	jmp    198e <printf+0x195>
      } else if(c == '%'){
    1949:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    194d:	75 17                	jne    1966 <printf+0x16d>
        putc(fd, c);
    194f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1952:	0f be c0             	movsbl %al,%eax
    1955:	89 44 24 04          	mov    %eax,0x4(%esp)
    1959:	8b 45 08             	mov    0x8(%ebp),%eax
    195c:	89 04 24             	mov    %eax,(%esp)
    195f:	e8 bc fd ff ff       	call   1720 <putc>
    1964:	eb 28                	jmp    198e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1966:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    196d:	00 
    196e:	8b 45 08             	mov    0x8(%ebp),%eax
    1971:	89 04 24             	mov    %eax,(%esp)
    1974:	e8 a7 fd ff ff       	call   1720 <putc>
        putc(fd, c);
    1979:	8b 45 e8             	mov    -0x18(%ebp),%eax
    197c:	0f be c0             	movsbl %al,%eax
    197f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1983:	8b 45 08             	mov    0x8(%ebp),%eax
    1986:	89 04 24             	mov    %eax,(%esp)
    1989:	e8 92 fd ff ff       	call   1720 <putc>
      }
      state = 0;
    198e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1995:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1999:	8b 55 0c             	mov    0xc(%ebp),%edx
    199c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    199f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    19a2:	0f b6 00             	movzbl (%eax),%eax
    19a5:	84 c0                	test   %al,%al
    19a7:	0f 85 6e fe ff ff    	jne    181b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    19ad:	c9                   	leave  
    19ae:	c3                   	ret    
    19af:	90                   	nop

000019b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    19b0:	55                   	push   %ebp
    19b1:	89 e5                	mov    %esp,%ebp
    19b3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    19b6:	8b 45 08             	mov    0x8(%ebp),%eax
    19b9:	83 e8 08             	sub    $0x8,%eax
    19bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19bf:	a1 a0 20 00 00       	mov    0x20a0,%eax
    19c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19c7:	eb 24                	jmp    19ed <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    19c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19cc:	8b 00                	mov    (%eax),%eax
    19ce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19d1:	77 12                	ja     19e5 <free+0x35>
    19d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19d9:	77 24                	ja     19ff <free+0x4f>
    19db:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19de:	8b 00                	mov    (%eax),%eax
    19e0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19e3:	77 1a                	ja     19ff <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    19e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e8:	8b 00                	mov    (%eax),%eax
    19ea:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19f0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19f3:	76 d4                	jbe    19c9 <free+0x19>
    19f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f8:	8b 00                	mov    (%eax),%eax
    19fa:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19fd:	76 ca                	jbe    19c9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    19ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a02:	8b 40 04             	mov    0x4(%eax),%eax
    1a05:	c1 e0 03             	shl    $0x3,%eax
    1a08:	89 c2                	mov    %eax,%edx
    1a0a:	03 55 f8             	add    -0x8(%ebp),%edx
    1a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a10:	8b 00                	mov    (%eax),%eax
    1a12:	39 c2                	cmp    %eax,%edx
    1a14:	75 24                	jne    1a3a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1a16:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a19:	8b 50 04             	mov    0x4(%eax),%edx
    1a1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a1f:	8b 00                	mov    (%eax),%eax
    1a21:	8b 40 04             	mov    0x4(%eax),%eax
    1a24:	01 c2                	add    %eax,%edx
    1a26:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a29:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1a2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a2f:	8b 00                	mov    (%eax),%eax
    1a31:	8b 10                	mov    (%eax),%edx
    1a33:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a36:	89 10                	mov    %edx,(%eax)
    1a38:	eb 0a                	jmp    1a44 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1a3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a3d:	8b 10                	mov    (%eax),%edx
    1a3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a42:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1a44:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a47:	8b 40 04             	mov    0x4(%eax),%eax
    1a4a:	c1 e0 03             	shl    $0x3,%eax
    1a4d:	03 45 fc             	add    -0x4(%ebp),%eax
    1a50:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a53:	75 20                	jne    1a75 <free+0xc5>
    p->s.size += bp->s.size;
    1a55:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a58:	8b 50 04             	mov    0x4(%eax),%edx
    1a5b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a5e:	8b 40 04             	mov    0x4(%eax),%eax
    1a61:	01 c2                	add    %eax,%edx
    1a63:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a66:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1a69:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a6c:	8b 10                	mov    (%eax),%edx
    1a6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a71:	89 10                	mov    %edx,(%eax)
    1a73:	eb 08                	jmp    1a7d <free+0xcd>
  } else
    p->s.ptr = bp;
    1a75:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a78:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a7b:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a80:	a3 a0 20 00 00       	mov    %eax,0x20a0
}
    1a85:	c9                   	leave  
    1a86:	c3                   	ret    

00001a87 <morecore>:

static Header*
morecore(uint nu)
{
    1a87:	55                   	push   %ebp
    1a88:	89 e5                	mov    %esp,%ebp
    1a8a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1a8d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1a94:	77 07                	ja     1a9d <morecore+0x16>
    nu = 4096;
    1a96:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1a9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa0:	c1 e0 03             	shl    $0x3,%eax
    1aa3:	89 04 24             	mov    %eax,(%esp)
    1aa6:	e8 35 fc ff ff       	call   16e0 <sbrk>
    1aab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1aae:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1ab2:	75 07                	jne    1abb <morecore+0x34>
    return 0;
    1ab4:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab9:	eb 22                	jmp    1add <morecore+0x56>
  hp = (Header*)p;
    1abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1abe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1ac1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac4:	8b 55 08             	mov    0x8(%ebp),%edx
    1ac7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1acd:	83 c0 08             	add    $0x8,%eax
    1ad0:	89 04 24             	mov    %eax,(%esp)
    1ad3:	e8 d8 fe ff ff       	call   19b0 <free>
  return freep;
    1ad8:	a1 a0 20 00 00       	mov    0x20a0,%eax
}
    1add:	c9                   	leave  
    1ade:	c3                   	ret    

00001adf <malloc>:

void*
malloc(uint nbytes)
{
    1adf:	55                   	push   %ebp
    1ae0:	89 e5                	mov    %esp,%ebp
    1ae2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1ae5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae8:	83 c0 07             	add    $0x7,%eax
    1aeb:	c1 e8 03             	shr    $0x3,%eax
    1aee:	83 c0 01             	add    $0x1,%eax
    1af1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1af4:	a1 a0 20 00 00       	mov    0x20a0,%eax
    1af9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1afc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b00:	75 23                	jne    1b25 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1b02:	c7 45 f0 98 20 00 00 	movl   $0x2098,-0x10(%ebp)
    1b09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b0c:	a3 a0 20 00 00       	mov    %eax,0x20a0
    1b11:	a1 a0 20 00 00       	mov    0x20a0,%eax
    1b16:	a3 98 20 00 00       	mov    %eax,0x2098
    base.s.size = 0;
    1b1b:	c7 05 9c 20 00 00 00 	movl   $0x0,0x209c
    1b22:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b25:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b28:	8b 00                	mov    (%eax),%eax
    1b2a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1b2d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b30:	8b 40 04             	mov    0x4(%eax),%eax
    1b33:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1b36:	72 4d                	jb     1b85 <malloc+0xa6>
      if(p->s.size == nunits)
    1b38:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b3b:	8b 40 04             	mov    0x4(%eax),%eax
    1b3e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1b41:	75 0c                	jne    1b4f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1b43:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b46:	8b 10                	mov    (%eax),%edx
    1b48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b4b:	89 10                	mov    %edx,(%eax)
    1b4d:	eb 26                	jmp    1b75 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1b4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b52:	8b 40 04             	mov    0x4(%eax),%eax
    1b55:	89 c2                	mov    %eax,%edx
    1b57:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1b5a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b5d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b60:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b63:	8b 40 04             	mov    0x4(%eax),%eax
    1b66:	c1 e0 03             	shl    $0x3,%eax
    1b69:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1b6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b6f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b72:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b75:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b78:	a3 a0 20 00 00       	mov    %eax,0x20a0
      return (void*)(p + 1);
    1b7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b80:	83 c0 08             	add    $0x8,%eax
    1b83:	eb 38                	jmp    1bbd <malloc+0xde>
    }
    if(p == freep)
    1b85:	a1 a0 20 00 00       	mov    0x20a0,%eax
    1b8a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1b8d:	75 1b                	jne    1baa <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1b8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b92:	89 04 24             	mov    %eax,(%esp)
    1b95:	e8 ed fe ff ff       	call   1a87 <morecore>
    1b9a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b9d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ba1:	75 07                	jne    1baa <malloc+0xcb>
        return 0;
    1ba3:	b8 00 00 00 00       	mov    $0x0,%eax
    1ba8:	eb 13                	jmp    1bbd <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1baa:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bb3:	8b 00                	mov    (%eax),%eax
    1bb5:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1bb8:	e9 70 ff ff ff       	jmp    1b2d <malloc+0x4e>
}
    1bbd:	c9                   	leave  
    1bbe:	c3                   	ret    
    1bbf:	90                   	nop

00001bc0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1bc0:	55                   	push   %ebp
    1bc1:	89 e5                	mov    %esp,%ebp
    1bc3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1bc6:	8b 55 08             	mov    0x8(%ebp),%edx
    1bc9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1bcc:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1bcf:	f0 87 02             	lock xchg %eax,(%edx)
    1bd2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1bd5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1bd8:	c9                   	leave  
    1bd9:	c3                   	ret    

00001bda <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1bda:	55                   	push   %ebp
    1bdb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1bdd:	8b 45 08             	mov    0x8(%ebp),%eax
    1be0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1be6:	5d                   	pop    %ebp
    1be7:	c3                   	ret    

00001be8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1be8:	55                   	push   %ebp
    1be9:	89 e5                	mov    %esp,%ebp
    1beb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1bee:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1bf8:	00 
    1bf9:	89 04 24             	mov    %eax,(%esp)
    1bfc:	e8 bf ff ff ff       	call   1bc0 <xchg>
    1c01:	85 c0                	test   %eax,%eax
    1c03:	75 e9                	jne    1bee <lock_acquire+0x6>
}
    1c05:	c9                   	leave  
    1c06:	c3                   	ret    

00001c07 <lock_release>:
void lock_release(lock_t *lock){
    1c07:	55                   	push   %ebp
    1c08:	89 e5                	mov    %esp,%ebp
    1c0a:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1c0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c10:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1c17:	00 
    1c18:	89 04 24             	mov    %eax,(%esp)
    1c1b:	e8 a0 ff ff ff       	call   1bc0 <xchg>
}
    1c20:	c9                   	leave  
    1c21:	c3                   	ret    

00001c22 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1c22:	55                   	push   %ebp
    1c23:	89 e5                	mov    %esp,%ebp
    1c25:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1c28:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1c2f:	e8 ab fe ff ff       	call   1adf <malloc>
    1c34:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1c37:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c40:	25 ff 0f 00 00       	and    $0xfff,%eax
    1c45:	85 c0                	test   %eax,%eax
    1c47:	74 15                	je     1c5e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1c49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c4c:	89 c2                	mov    %eax,%edx
    1c4e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1c54:	b8 00 10 00 00       	mov    $0x1000,%eax
    1c59:	29 d0                	sub    %edx,%eax
    1c5b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1c5e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c62:	75 1b                	jne    1c7f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1c64:	c7 44 24 04 3e 20 00 	movl   $0x203e,0x4(%esp)
    1c6b:	00 
    1c6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c73:	e8 81 fb ff ff       	call   17f9 <printf>
        return 0;
    1c78:	b8 00 00 00 00       	mov    $0x0,%eax
    1c7d:	eb 6f                	jmp    1cee <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1c7f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c82:	8b 55 08             	mov    0x8(%ebp),%edx
    1c85:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c88:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1c8c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1c90:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1c97:	00 
    1c98:	89 04 24             	mov    %eax,(%esp)
    1c9b:	e8 58 fa ff ff       	call   16f8 <clone>
    1ca0:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1ca3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ca7:	79 1b                	jns    1cc4 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1ca9:	c7 44 24 04 4c 20 00 	movl   $0x204c,0x4(%esp)
    1cb0:	00 
    1cb1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1cb8:	e8 3c fb ff ff       	call   17f9 <printf>
        return 0;
    1cbd:	b8 00 00 00 00       	mov    $0x0,%eax
    1cc2:	eb 2a                	jmp    1cee <thread_create+0xcc>
    }
    if(tid > 0){
    1cc4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cc8:	7e 05                	jle    1ccf <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ccd:	eb 1f                	jmp    1cee <thread_create+0xcc>
    }
    if(tid == 0){
    1ccf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1cd3:	75 14                	jne    1ce9 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1cd5:	c7 44 24 04 59 20 00 	movl   $0x2059,0x4(%esp)
    1cdc:	00 
    1cdd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ce4:	e8 10 fb ff ff       	call   17f9 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ce9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1cee:	c9                   	leave  
    1cef:	c3                   	ret    

00001cf0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1cf0:	55                   	push   %ebp
    1cf1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1cf3:	a1 80 20 00 00       	mov    0x2080,%eax
    1cf8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1cfe:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1d03:	a3 80 20 00 00       	mov    %eax,0x2080
    return (int)(rands % max);
    1d08:	a1 80 20 00 00       	mov    0x2080,%eax
    1d0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d10:	ba 00 00 00 00       	mov    $0x0,%edx
    1d15:	f7 f1                	div    %ecx
    1d17:	89 d0                	mov    %edx,%eax
}
    1d19:	5d                   	pop    %ebp
    1d1a:	c3                   	ret    
    1d1b:	90                   	nop

00001d1c <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1d1c:	55                   	push   %ebp
    1d1d:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1d1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d22:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1d28:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1d32:	8b 45 08             	mov    0x8(%ebp),%eax
    1d35:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1d3c:	5d                   	pop    %ebp
    1d3d:	c3                   	ret    

00001d3e <add_q>:

void add_q(struct queue *q, int v){
    1d3e:	55                   	push   %ebp
    1d3f:	89 e5                	mov    %esp,%ebp
    1d41:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1d44:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d4b:	e8 8f fd ff ff       	call   1adf <malloc>
    1d50:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d56:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d60:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d63:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d65:	8b 45 08             	mov    0x8(%ebp),%eax
    1d68:	8b 40 04             	mov    0x4(%eax),%eax
    1d6b:	85 c0                	test   %eax,%eax
    1d6d:	75 0b                	jne    1d7a <add_q+0x3c>
        q->head = n;
    1d6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d72:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d75:	89 50 04             	mov    %edx,0x4(%eax)
    1d78:	eb 0c                	jmp    1d86 <add_q+0x48>
    }else{
        q->tail->next = n;
    1d7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d7d:	8b 40 08             	mov    0x8(%eax),%eax
    1d80:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d83:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1d86:	8b 45 08             	mov    0x8(%ebp),%eax
    1d89:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d8c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1d8f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d92:	8b 00                	mov    (%eax),%eax
    1d94:	8d 50 01             	lea    0x1(%eax),%edx
    1d97:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9a:	89 10                	mov    %edx,(%eax)
}
    1d9c:	c9                   	leave  
    1d9d:	c3                   	ret    

00001d9e <empty_q>:

int empty_q(struct queue *q){
    1d9e:	55                   	push   %ebp
    1d9f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1da1:	8b 45 08             	mov    0x8(%ebp),%eax
    1da4:	8b 00                	mov    (%eax),%eax
    1da6:	85 c0                	test   %eax,%eax
    1da8:	75 07                	jne    1db1 <empty_q+0x13>
        return 1;
    1daa:	b8 01 00 00 00       	mov    $0x1,%eax
    1daf:	eb 05                	jmp    1db6 <empty_q+0x18>
    else
        return 0;
    1db1:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1db6:	5d                   	pop    %ebp
    1db7:	c3                   	ret    

00001db8 <pop_q>:
int pop_q(struct queue *q){
    1db8:	55                   	push   %ebp
    1db9:	89 e5                	mov    %esp,%ebp
    1dbb:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1dbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc1:	89 04 24             	mov    %eax,(%esp)
    1dc4:	e8 d5 ff ff ff       	call   1d9e <empty_q>
    1dc9:	85 c0                	test   %eax,%eax
    1dcb:	75 5d                	jne    1e2a <pop_q+0x72>
       val = q->head->value; 
    1dcd:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd0:	8b 40 04             	mov    0x4(%eax),%eax
    1dd3:	8b 00                	mov    (%eax),%eax
    1dd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1dd8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ddb:	8b 40 04             	mov    0x4(%eax),%eax
    1dde:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1de1:	8b 45 08             	mov    0x8(%ebp),%eax
    1de4:	8b 40 04             	mov    0x4(%eax),%eax
    1de7:	8b 50 04             	mov    0x4(%eax),%edx
    1dea:	8b 45 08             	mov    0x8(%ebp),%eax
    1ded:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1df0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1df3:	89 04 24             	mov    %eax,(%esp)
    1df6:	e8 b5 fb ff ff       	call   19b0 <free>
       q->size--;
    1dfb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfe:	8b 00                	mov    (%eax),%eax
    1e00:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e03:	8b 45 08             	mov    0x8(%ebp),%eax
    1e06:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1e08:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0b:	8b 00                	mov    (%eax),%eax
    1e0d:	85 c0                	test   %eax,%eax
    1e0f:	75 14                	jne    1e25 <pop_q+0x6d>
            q->head = 0;
    1e11:	8b 45 08             	mov    0x8(%ebp),%eax
    1e14:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1e1b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e1e:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1e25:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e28:	eb 05                	jmp    1e2f <pop_q+0x77>
    }
    return -1;
    1e2a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1e2f:	c9                   	leave  
    1e30:	c3                   	ret    
    1e31:	90                   	nop
    1e32:	90                   	nop
    1e33:	90                   	nop

00001e34 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1e34:	55                   	push   %ebp
    1e35:	89 e5                	mov    %esp,%ebp
    1e37:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1e3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e3d:	89 04 24             	mov    %eax,(%esp)
    1e40:	e8 a3 fd ff ff       	call   1be8 <lock_acquire>
	s->count--; 
    1e45:	8b 45 08             	mov    0x8(%ebp),%eax
    1e48:	8b 40 04             	mov    0x4(%eax),%eax
    1e4b:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e51:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1e54:	8b 45 08             	mov    0x8(%ebp),%eax
    1e57:	8b 40 04             	mov    0x4(%eax),%eax
    1e5a:	85 c0                	test   %eax,%eax
    1e5c:	79 27                	jns    1e85 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1e5e:	e8 75 f8 ff ff       	call   16d8 <getpid>
    1e63:	8b 55 08             	mov    0x8(%ebp),%edx
    1e66:	83 c2 08             	add    $0x8,%edx
    1e69:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e6d:	89 14 24             	mov    %edx,(%esp)
    1e70:	e8 c9 fe ff ff       	call   1d3e <add_q>
		lock_release(&s->lock); 
    1e75:	8b 45 08             	mov    0x8(%ebp),%eax
    1e78:	89 04 24             	mov    %eax,(%esp)
    1e7b:	e8 87 fd ff ff       	call   1c07 <lock_release>
		tsleep(); 
    1e80:	e8 83 f8 ff ff       	call   1708 <tsleep>
	} 
	lock_release(&s->lock); 
    1e85:	8b 45 08             	mov    0x8(%ebp),%eax
    1e88:	89 04 24             	mov    %eax,(%esp)
    1e8b:	e8 77 fd ff ff       	call   1c07 <lock_release>
}
    1e90:	c9                   	leave  
    1e91:	c3                   	ret    

00001e92 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1e92:	55                   	push   %ebp
    1e93:	89 e5                	mov    %esp,%ebp
    1e95:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1e98:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9b:	89 04 24             	mov    %eax,(%esp)
    1e9e:	e8 45 fd ff ff       	call   1be8 <lock_acquire>
	s->count++; 
    1ea3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea6:	8b 40 04             	mov    0x4(%eax),%eax
    1ea9:	8d 50 01             	lea    0x1(%eax),%edx
    1eac:	8b 45 08             	mov    0x8(%ebp),%eax
    1eaf:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1eb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb5:	8b 40 04             	mov    0x4(%eax),%eax
    1eb8:	85 c0                	test   %eax,%eax
    1eba:	7f 1c                	jg     1ed8 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1ebc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebf:	83 c0 08             	add    $0x8,%eax
    1ec2:	89 04 24             	mov    %eax,(%esp)
    1ec5:	e8 ee fe ff ff       	call   1db8 <pop_q>
    1eca:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1ecd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ed0:	89 04 24             	mov    %eax,(%esp)
    1ed3:	e8 38 f8 ff ff       	call   1710 <twakeup>
	}
	lock_release(&s->lock); 
    1ed8:	8b 45 08             	mov    0x8(%ebp),%eax
    1edb:	89 04 24             	mov    %eax,(%esp)
    1ede:	e8 24 fd ff ff       	call   1c07 <lock_release>
} 
    1ee3:	c9                   	leave  
    1ee4:	c3                   	ret    

00001ee5 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1ee5:	55                   	push   %ebp
    1ee6:	89 e5                	mov    %esp,%ebp
    1ee8:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1eeb:	8b 45 08             	mov    0x8(%ebp),%eax
    1eee:	89 04 24             	mov    %eax,(%esp)
    1ef1:	e8 e4 fc ff ff       	call   1bda <lock_init>
	s->count = size; 
    1ef6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1efc:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1eff:	8b 45 08             	mov    0x8(%ebp),%eax
    1f02:	83 c0 08             	add    $0x8,%eax
    1f05:	89 04 24             	mov    %eax,(%esp)
    1f08:	e8 0f fe ff ff       	call   1d1c <init_q>
}
    1f0d:	c9                   	leave  
    1f0e:	c3                   	ret    
