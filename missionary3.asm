
_missionary3:     file format elf32-i386


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
    1006:	83 ec 40             	sub    $0x40,%esp

	lock_acquire(&mutex.lock); 
    1009:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1010:	e8 4b 0d 00 00       	call   1d60 <lock_acquire>
	printf(1,"Created 6 missionary, and 4 Cannibal. No boat will set off since the cannibals cannot be with 1 missioanry, infinite loop. \n"); 
    1015:	c7 44 24 04 88 20 00 	movl   $0x2088,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 48 09 00 00       	call   1971 <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1030:	e8 4a 0d 00 00       	call   1d7f <lock_release>
	
	sem_init(&M, 0); 
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    1044:	e8 14 10 00 00       	call   205d <sem_init>
	sem_init(&C, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 48 22 00 00 	movl   $0x2248,(%esp)
    1058:	e8 00 10 00 00       	call   205d <sem_init>

	void *mid = thread_create(MissionaryArrives,(void *)0);
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    106c:	e8 29 0d 00 00       	call   1d9a <thread_create>
    1071:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid == 0) exit(); 
    1075:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 4f 07 00 00       	call   17d0 <exit>

	void *mid2 = thread_create(MissionaryArrives,(void *)0);
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    1090:	e8 05 0d 00 00       	call   1d9a <thread_create>
    1095:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(mid2 == 0) exit(); 
    1099:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 2b 07 00 00       	call   17d0 <exit>

	void *mid3 = thread_create(MissionaryArrives,(void *)0);
    10a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    10b4:	e8 e1 0c 00 00       	call   1d9a <thread_create>
    10b9:	89 44 24 20          	mov    %eax,0x20(%esp)
	if(mid3 == 0) exit(); 
    10bd:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 07 07 00 00       	call   17d0 <exit>

	void *mid4 = thread_create(MissionaryArrives,(void *)0);
    10c9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10d0:	00 
    10d1:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    10d8:	e8 bd 0c 00 00       	call   1d9a <thread_create>
    10dd:	89 44 24 24          	mov    %eax,0x24(%esp)
	if(mid4 == 0) exit(); 
    10e1:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
    10e6:	75 05                	jne    10ed <main+0xed>
    10e8:	e8 e3 06 00 00       	call   17d0 <exit>

	void *mid5 = thread_create(MissionaryArrives,(void *)0);
    10ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10f4:	00 
    10f5:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    10fc:	e8 99 0c 00 00       	call   1d9a <thread_create>
    1101:	89 44 24 28          	mov    %eax,0x28(%esp)
	if(mid5 == 0) exit(); 
    1105:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
    110a:	75 05                	jne    1111 <main+0x111>
    110c:	e8 bf 06 00 00       	call   17d0 <exit>

	void *mid6 = thread_create(MissionaryArrives,(void *)0);
    1111:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1118:	00 
    1119:	c7 04 24 d3 11 00 00 	movl   $0x11d3,(%esp)
    1120:	e8 75 0c 00 00       	call   1d9a <thread_create>
    1125:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	if(mid6 == 0) exit(); 
    1129:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
    112e:	75 05                	jne    1135 <main+0x135>
    1130:	e8 9b 06 00 00       	call   17d0 <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    1135:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    113c:	00 
    113d:	c7 04 24 61 13 00 00 	movl   $0x1361,(%esp)
    1144:	e8 51 0c 00 00       	call   1d9a <thread_create>
    1149:	89 44 24 30          	mov    %eax,0x30(%esp)
	if(cid == 0) exit(); 
    114d:	83 7c 24 30 00       	cmpl   $0x0,0x30(%esp)
    1152:	75 05                	jne    1159 <main+0x159>
    1154:	e8 77 06 00 00       	call   17d0 <exit>

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
    1159:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1160:	00 
    1161:	c7 04 24 61 13 00 00 	movl   $0x1361,(%esp)
    1168:	e8 2d 0c 00 00       	call   1d9a <thread_create>
    116d:	89 44 24 34          	mov    %eax,0x34(%esp)
	if(cid2 == 0) exit(); 
    1171:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
    1176:	75 05                	jne    117d <main+0x17d>
    1178:	e8 53 06 00 00       	call   17d0 <exit>

	void *cid3 = thread_create(CannibalArrives,(void *)0); 
    117d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1184:	00 
    1185:	c7 04 24 61 13 00 00 	movl   $0x1361,(%esp)
    118c:	e8 09 0c 00 00       	call   1d9a <thread_create>
    1191:	89 44 24 38          	mov    %eax,0x38(%esp)
	if(cid3 == 0) exit(); 
    1195:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
    119a:	75 05                	jne    11a1 <main+0x1a1>
    119c:	e8 2f 06 00 00       	call   17d0 <exit>

	void *cid4 = thread_create(CannibalArrives,(void *)0); 
    11a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11a8:	00 
    11a9:	c7 04 24 61 13 00 00 	movl   $0x1361,(%esp)
    11b0:	e8 e5 0b 00 00       	call   1d9a <thread_create>
    11b5:	89 44 24 3c          	mov    %eax,0x3c(%esp)
	if(cid4 == 0) exit(); 
    11b9:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
    11be:	75 05                	jne    11c5 <main+0x1c5>
    11c0:	e8 0b 06 00 00       	call   17d0 <exit>

	while(wait() > 0); 
    11c5:	e8 0e 06 00 00       	call   17d8 <wait>
    11ca:	85 c0                	test   %eax,%eax
    11cc:	7f f7                	jg     11c5 <main+0x1c5>

	exit(); 
    11ce:	e8 fd 05 00 00       	call   17d0 <exit>

000011d3 <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    11d3:	55                   	push   %ebp
    11d4:	89 e5                	mov    %esp,%ebp
    11d6:	83 ec 18             	sub    $0x18,%esp
	if(numMissionaries == 2) 
    11d9:	a1 24 22 00 00       	mov    0x2224,%eax
    11de:	83 f8 02             	cmp    $0x2,%eax
    11e1:	75 64                	jne    1247 <MissionaryArrives+0x74>
	{
		lock_acquire(&mutex.lock);
    11e3:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    11ea:	e8 71 0b 00 00       	call   1d60 <lock_acquire>
		missCount++; //for num of miss in boat.
    11ef:	a1 30 22 00 00       	mov    0x2230,%eax
    11f4:	83 c0 01             	add    $0x1,%eax
    11f7:	a3 30 22 00 00       	mov    %eax,0x2230
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
    11fc:	a1 30 22 00 00       	mov    0x2230,%eax
    1201:	89 44 24 08          	mov    %eax,0x8(%esp)
    1205:	c7 44 24 04 08 21 00 	movl   $0x2108,0x4(%esp)
    120c:	00 
    120d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1214:	e8 58 07 00 00       	call   1971 <printf>
		lock_release(&mutex.lock);
    1219:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1220:	e8 5a 0b 00 00       	call   1d7f <lock_release>
		sem_signal(&M); 
    1225:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    122c:	e8 d9 0d 00 00       	call   200a <sem_signal>
		sem_signal(&M); 
    1231:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    1238:	e8 cd 0d 00 00       	call   200a <sem_signal>
		RowBoat();
    123d:	e8 86 02 00 00       	call   14c8 <RowBoat>
    1242:	e9 15 01 00 00       	jmp    135c <MissionaryArrives+0x189>
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1247:	a1 24 22 00 00       	mov    0x2224,%eax
    124c:	83 f8 01             	cmp    $0x1,%eax
    124f:	75 6e                	jne    12bf <MissionaryArrives+0xec>
    1251:	a1 28 22 00 00       	mov    0x2228,%eax
    1256:	83 f8 01             	cmp    $0x1,%eax
    1259:	75 64                	jne    12bf <MissionaryArrives+0xec>
		lock_acquire(&mutex.lock);
    125b:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1262:	e8 f9 0a 00 00       	call   1d60 <lock_acquire>
		missCount++; //for num of miss in boat.
    1267:	a1 30 22 00 00       	mov    0x2230,%eax
    126c:	83 c0 01             	add    $0x1,%eax
    126f:	a3 30 22 00 00       	mov    %eax,0x2230
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
    1274:	a1 30 22 00 00       	mov    0x2230,%eax
    1279:	89 44 24 08          	mov    %eax,0x8(%esp)
    127d:	c7 44 24 04 08 21 00 	movl   $0x2108,0x4(%esp)
    1284:	00 
    1285:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    128c:	e8 e0 06 00 00       	call   1971 <printf>
		lock_release(&mutex.lock);
    1291:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1298:	e8 e2 0a 00 00       	call   1d7f <lock_release>
		sem_signal(&M); 
    129d:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    12a4:	e8 61 0d 00 00       	call   200a <sem_signal>
		sem_signal(&C);
    12a9:	c7 04 24 48 22 00 00 	movl   $0x2248,(%esp)
    12b0:	e8 55 0d 00 00       	call   200a <sem_signal>
		RowBoat(); 
    12b5:	e8 0e 02 00 00       	call   14c8 <RowBoat>
		lock_release(&mutex.lock);
		sem_signal(&M); 
		sem_signal(&M); 
		RowBoat();
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    12ba:	e9 9d 00 00 00       	jmp    135c <MissionaryArrives+0x189>
		sem_signal(&M); 
		sem_signal(&C);
		RowBoat(); 
	} 
	else {
		lock_acquire(&mutex.lock); 
    12bf:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    12c6:	e8 95 0a 00 00       	call   1d60 <lock_acquire>
		numMissionaries++;
    12cb:	a1 24 22 00 00       	mov    0x2224,%eax
    12d0:	83 c0 01             	add    $0x1,%eax
    12d3:	a3 24 22 00 00       	mov    %eax,0x2224
		missCount++;  //for num of miss in boat.
    12d8:	a1 30 22 00 00       	mov    0x2230,%eax
    12dd:	83 c0 01             	add    $0x1,%eax
    12e0:	a3 30 22 00 00       	mov    %eax,0x2230
		printf(1,"Number of missionaries arrived: %d.\n",missCount);  
    12e5:	a1 30 22 00 00       	mov    0x2230,%eax
    12ea:	89 44 24 08          	mov    %eax,0x8(%esp)
    12ee:	c7 44 24 04 08 21 00 	movl   $0x2108,0x4(%esp)
    12f5:	00 
    12f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fd:	e8 6f 06 00 00       	call   1971 <printf>
		lock_release(&mutex.lock);  
    1302:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1309:	e8 71 0a 00 00       	call   1d7f <lock_release>
		sem_acquire(&M);
    130e:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    1315:	e8 92 0c 00 00       	call   1fac <sem_acquire>
		lock_acquire(&mutex.lock); 
    131a:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1321:	e8 3a 0a 00 00       	call   1d60 <lock_acquire>
		printf(1,"why am i not decreasing?? %d.\n",numMissionaries);  
    1326:	a1 24 22 00 00       	mov    0x2224,%eax
    132b:	89 44 24 08          	mov    %eax,0x8(%esp)
    132f:	c7 44 24 04 30 21 00 	movl   $0x2130,0x4(%esp)
    1336:	00 
    1337:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    133e:	e8 2e 06 00 00       	call   1971 <printf>
		numMissionaries--; 
    1343:	a1 24 22 00 00       	mov    0x2224,%eax
    1348:	83 e8 01             	sub    $0x1,%eax
    134b:	a3 24 22 00 00       	mov    %eax,0x2224
		lock_release(&mutex.lock);  
    1350:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1357:	e8 23 0a 00 00       	call   1d7f <lock_release>
	}
	texit();  
    135c:	e8 17 05 00 00       	call   1878 <texit>

00001361 <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    1361:	55                   	push   %ebp
    1362:	89 e5                	mov    %esp,%ebp
    1364:	83 ec 18             	sub    $0x18,%esp
	if(numCannibals == 2) 
    1367:	a1 28 22 00 00       	mov    0x2228,%eax
    136c:	83 f8 02             	cmp    $0x2,%eax
    136f:	75 64                	jne    13d5 <CannibalArrives+0x74>
	{
		lock_acquire(&mutex.lock); 
    1371:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1378:	e8 e3 09 00 00       	call   1d60 <lock_acquire>
		canCount++; //for num of can in boat. 
    137d:	a1 2c 22 00 00       	mov    0x222c,%eax
    1382:	83 c0 01             	add    $0x1,%eax
    1385:	a3 2c 22 00 00       	mov    %eax,0x222c
		printf(1,"Number of cannibals arrived: %d.\n",canCount);  
    138a:	a1 2c 22 00 00       	mov    0x222c,%eax
    138f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1393:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    139a:	00 
    139b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a2:	e8 ca 05 00 00       	call   1971 <printf>
		lock_release(&mutex.lock);  
    13a7:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    13ae:	e8 cc 09 00 00       	call   1d7f <lock_release>
		sem_signal(&C); 
    13b3:	c7 04 24 48 22 00 00 	movl   $0x2248,(%esp)
    13ba:	e8 4b 0c 00 00       	call   200a <sem_signal>
		sem_signal(&C);
    13bf:	c7 04 24 48 22 00 00 	movl   $0x2248,(%esp)
    13c6:	e8 3f 0c 00 00       	call   200a <sem_signal>
		RowBoat();  		
    13cb:	e8 f8 00 00 00       	call   14c8 <RowBoat>
    13d0:	e9 ee 00 00 00       	jmp    14c3 <CannibalArrives+0x162>
	}
	else if(numMissionaries == 2) {
    13d5:	a1 24 22 00 00       	mov    0x2224,%eax
    13da:	83 f8 02             	cmp    $0x2,%eax
    13dd:	75 64                	jne    1443 <CannibalArrives+0xe2>
		lock_acquire(&mutex.lock); 
    13df:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    13e6:	e8 75 09 00 00       	call   1d60 <lock_acquire>
		canCount++; //for num of can in boat. 
    13eb:	a1 2c 22 00 00       	mov    0x222c,%eax
    13f0:	83 c0 01             	add    $0x1,%eax
    13f3:	a3 2c 22 00 00       	mov    %eax,0x222c
		printf(1,"Number of cannibals arrived: %d.\n",canCount);  
    13f8:	a1 2c 22 00 00       	mov    0x222c,%eax
    13fd:	89 44 24 08          	mov    %eax,0x8(%esp)
    1401:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    1408:	00 
    1409:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1410:	e8 5c 05 00 00       	call   1971 <printf>
		lock_release(&mutex.lock);  
    1415:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    141c:	e8 5e 09 00 00       	call   1d7f <lock_release>
		sem_signal(&M);
    1421:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    1428:	e8 dd 0b 00 00       	call   200a <sem_signal>
		sem_signal(&M); 
    142d:	c7 04 24 5c 22 00 00 	movl   $0x225c,(%esp)
    1434:	e8 d1 0b 00 00       	call   200a <sem_signal>
		RowBoat(); 
    1439:	e8 8a 00 00 00       	call   14c8 <RowBoat>
    143e:	e9 80 00 00 00       	jmp    14c3 <CannibalArrives+0x162>
	}
	else {
		lock_acquire(&mutex.lock);
    1443:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    144a:	e8 11 09 00 00       	call   1d60 <lock_acquire>
		canCount++; //for num of can in boat. 
    144f:	a1 2c 22 00 00       	mov    0x222c,%eax
    1454:	83 c0 01             	add    $0x1,%eax
    1457:	a3 2c 22 00 00       	mov    %eax,0x222c
		printf(1, "Number of cannibals arrived: %d.\n",canCount);  
    145c:	a1 2c 22 00 00       	mov    0x222c,%eax
    1461:	89 44 24 08          	mov    %eax,0x8(%esp)
    1465:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    146c:	00 
    146d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1474:	e8 f8 04 00 00       	call   1971 <printf>
		numCannibals++; 
    1479:	a1 28 22 00 00       	mov    0x2228,%eax
    147e:	83 c0 01             	add    $0x1,%eax
    1481:	a3 28 22 00 00       	mov    %eax,0x2228
		lock_release(&mutex.lock); 
    1486:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    148d:	e8 ed 08 00 00       	call   1d7f <lock_release>
		sem_acquire(&C); 
    1492:	c7 04 24 48 22 00 00 	movl   $0x2248,(%esp)
    1499:	e8 0e 0b 00 00       	call   1fac <sem_acquire>
		lock_acquire(&mutex.lock);  
    149e:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    14a5:	e8 b6 08 00 00       	call   1d60 <lock_acquire>
		numCannibals--;
    14aa:	a1 28 22 00 00       	mov    0x2228,%eax
    14af:	83 e8 01             	sub    $0x1,%eax
    14b2:	a3 28 22 00 00       	mov    %eax,0x2228
		lock_release(&mutex.lock);
    14b7:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    14be:	e8 bc 08 00 00       	call   1d7f <lock_release>
	} 
	texit(); 
    14c3:	e8 b0 03 00 00       	call   1878 <texit>

000014c8 <RowBoat>:
} 	

void RowBoat() {
    14c8:	55                   	push   %ebp
    14c9:	89 e5                	mov    %esp,%ebp
    14cb:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    14ce:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    14d5:	e8 86 08 00 00       	call   1d60 <lock_acquire>
	printf(1,"Number of cannibals in boat: %d.\n",canCount); 
    14da:	a1 2c 22 00 00       	mov    0x222c,%eax
    14df:	89 44 24 08          	mov    %eax,0x8(%esp)
    14e3:	c7 44 24 04 74 21 00 	movl   $0x2174,0x4(%esp)
    14ea:	00 
    14eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14f2:	e8 7a 04 00 00       	call   1971 <printf>
	printf(1,"Number of missionaries in boat: %d.\n",missCount);
    14f7:	a1 30 22 00 00       	mov    0x2230,%eax
    14fc:	89 44 24 08          	mov    %eax,0x8(%esp)
    1500:	c7 44 24 04 98 21 00 	movl   $0x2198,0x4(%esp)
    1507:	00 
    1508:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    150f:	e8 5d 04 00 00       	call   1971 <printf>
	printf(1,"m: %d.\n",numMissionaries);  
    1514:	a1 24 22 00 00       	mov    0x2224,%eax
    1519:	89 44 24 08          	mov    %eax,0x8(%esp)
    151d:	c7 44 24 04 bd 21 00 	movl   $0x21bd,0x4(%esp)
    1524:	00 
    1525:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    152c:	e8 40 04 00 00       	call   1971 <printf>
	numBoat++; 
    1531:	a1 34 22 00 00       	mov    0x2234,%eax
    1536:	83 c0 01             	add    $0x1,%eax
    1539:	a3 34 22 00 00       	mov    %eax,0x2234
	printf(1,"Rowing boat: %d.\n",numBoat);
    153e:	a1 34 22 00 00       	mov    0x2234,%eax
    1543:	89 44 24 08          	mov    %eax,0x8(%esp)
    1547:	c7 44 24 04 c5 21 00 	movl   $0x21c5,0x4(%esp)
    154e:	00 
    154f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1556:	e8 16 04 00 00       	call   1971 <printf>
	lock_release(&mutex.lock); 
    155b:	c7 04 24 44 22 00 00 	movl   $0x2244,(%esp)
    1562:	e8 18 08 00 00       	call   1d7f <lock_release>
	texit();  
    1567:	e8 0c 03 00 00       	call   1878 <texit>

0000156c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    156c:	55                   	push   %ebp
    156d:	89 e5                	mov    %esp,%ebp
    156f:	57                   	push   %edi
    1570:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1571:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1574:	8b 55 10             	mov    0x10(%ebp),%edx
    1577:	8b 45 0c             	mov    0xc(%ebp),%eax
    157a:	89 cb                	mov    %ecx,%ebx
    157c:	89 df                	mov    %ebx,%edi
    157e:	89 d1                	mov    %edx,%ecx
    1580:	fc                   	cld    
    1581:	f3 aa                	rep stos %al,%es:(%edi)
    1583:	89 ca                	mov    %ecx,%edx
    1585:	89 fb                	mov    %edi,%ebx
    1587:	89 5d 08             	mov    %ebx,0x8(%ebp)
    158a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    158d:	5b                   	pop    %ebx
    158e:	5f                   	pop    %edi
    158f:	5d                   	pop    %ebp
    1590:	c3                   	ret    

00001591 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1591:	55                   	push   %ebp
    1592:	89 e5                	mov    %esp,%ebp
    1594:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1597:	8b 45 08             	mov    0x8(%ebp),%eax
    159a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    159d:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a0:	0f b6 10             	movzbl (%eax),%edx
    15a3:	8b 45 08             	mov    0x8(%ebp),%eax
    15a6:	88 10                	mov    %dl,(%eax)
    15a8:	8b 45 08             	mov    0x8(%ebp),%eax
    15ab:	0f b6 00             	movzbl (%eax),%eax
    15ae:	84 c0                	test   %al,%al
    15b0:	0f 95 c0             	setne  %al
    15b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15b7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    15bb:	84 c0                	test   %al,%al
    15bd:	75 de                	jne    159d <strcpy+0xc>
    ;
  return os;
    15bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15c2:	c9                   	leave  
    15c3:	c3                   	ret    

000015c4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    15c4:	55                   	push   %ebp
    15c5:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    15c7:	eb 08                	jmp    15d1 <strcmp+0xd>
    p++, q++;
    15c9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15cd:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    15d1:	8b 45 08             	mov    0x8(%ebp),%eax
    15d4:	0f b6 00             	movzbl (%eax),%eax
    15d7:	84 c0                	test   %al,%al
    15d9:	74 10                	je     15eb <strcmp+0x27>
    15db:	8b 45 08             	mov    0x8(%ebp),%eax
    15de:	0f b6 10             	movzbl (%eax),%edx
    15e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e4:	0f b6 00             	movzbl (%eax),%eax
    15e7:	38 c2                	cmp    %al,%dl
    15e9:	74 de                	je     15c9 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    15eb:	8b 45 08             	mov    0x8(%ebp),%eax
    15ee:	0f b6 00             	movzbl (%eax),%eax
    15f1:	0f b6 d0             	movzbl %al,%edx
    15f4:	8b 45 0c             	mov    0xc(%ebp),%eax
    15f7:	0f b6 00             	movzbl (%eax),%eax
    15fa:	0f b6 c0             	movzbl %al,%eax
    15fd:	89 d1                	mov    %edx,%ecx
    15ff:	29 c1                	sub    %eax,%ecx
    1601:	89 c8                	mov    %ecx,%eax
}
    1603:	5d                   	pop    %ebp
    1604:	c3                   	ret    

00001605 <strlen>:

uint
strlen(char *s)
{
    1605:	55                   	push   %ebp
    1606:	89 e5                	mov    %esp,%ebp
    1608:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    160b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1612:	eb 04                	jmp    1618 <strlen+0x13>
    1614:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1618:	8b 45 fc             	mov    -0x4(%ebp),%eax
    161b:	03 45 08             	add    0x8(%ebp),%eax
    161e:	0f b6 00             	movzbl (%eax),%eax
    1621:	84 c0                	test   %al,%al
    1623:	75 ef                	jne    1614 <strlen+0xf>
    ;
  return n;
    1625:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1628:	c9                   	leave  
    1629:	c3                   	ret    

0000162a <memset>:

void*
memset(void *dst, int c, uint n)
{
    162a:	55                   	push   %ebp
    162b:	89 e5                	mov    %esp,%ebp
    162d:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1630:	8b 45 10             	mov    0x10(%ebp),%eax
    1633:	89 44 24 08          	mov    %eax,0x8(%esp)
    1637:	8b 45 0c             	mov    0xc(%ebp),%eax
    163a:	89 44 24 04          	mov    %eax,0x4(%esp)
    163e:	8b 45 08             	mov    0x8(%ebp),%eax
    1641:	89 04 24             	mov    %eax,(%esp)
    1644:	e8 23 ff ff ff       	call   156c <stosb>
  return dst;
    1649:	8b 45 08             	mov    0x8(%ebp),%eax
}
    164c:	c9                   	leave  
    164d:	c3                   	ret    

0000164e <strchr>:

char*
strchr(const char *s, char c)
{
    164e:	55                   	push   %ebp
    164f:	89 e5                	mov    %esp,%ebp
    1651:	83 ec 04             	sub    $0x4,%esp
    1654:	8b 45 0c             	mov    0xc(%ebp),%eax
    1657:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    165a:	eb 14                	jmp    1670 <strchr+0x22>
    if(*s == c)
    165c:	8b 45 08             	mov    0x8(%ebp),%eax
    165f:	0f b6 00             	movzbl (%eax),%eax
    1662:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1665:	75 05                	jne    166c <strchr+0x1e>
      return (char*)s;
    1667:	8b 45 08             	mov    0x8(%ebp),%eax
    166a:	eb 13                	jmp    167f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    166c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1670:	8b 45 08             	mov    0x8(%ebp),%eax
    1673:	0f b6 00             	movzbl (%eax),%eax
    1676:	84 c0                	test   %al,%al
    1678:	75 e2                	jne    165c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    167a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    167f:	c9                   	leave  
    1680:	c3                   	ret    

00001681 <gets>:

char*
gets(char *buf, int max)
{
    1681:	55                   	push   %ebp
    1682:	89 e5                	mov    %esp,%ebp
    1684:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1687:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    168e:	eb 44                	jmp    16d4 <gets+0x53>
    cc = read(0, &c, 1);
    1690:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1697:	00 
    1698:	8d 45 ef             	lea    -0x11(%ebp),%eax
    169b:	89 44 24 04          	mov    %eax,0x4(%esp)
    169f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    16a6:	e8 3d 01 00 00       	call   17e8 <read>
    16ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    16ae:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16b2:	7e 2d                	jle    16e1 <gets+0x60>
      break;
    buf[i++] = c;
    16b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16b7:	03 45 08             	add    0x8(%ebp),%eax
    16ba:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    16be:	88 10                	mov    %dl,(%eax)
    16c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    16c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    16c8:	3c 0a                	cmp    $0xa,%al
    16ca:	74 16                	je     16e2 <gets+0x61>
    16cc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    16d0:	3c 0d                	cmp    $0xd,%al
    16d2:	74 0e                	je     16e2 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    16d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16d7:	83 c0 01             	add    $0x1,%eax
    16da:	3b 45 0c             	cmp    0xc(%ebp),%eax
    16dd:	7c b1                	jl     1690 <gets+0xf>
    16df:	eb 01                	jmp    16e2 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    16e1:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    16e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16e5:	03 45 08             	add    0x8(%ebp),%eax
    16e8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    16eb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    16ee:	c9                   	leave  
    16ef:	c3                   	ret    

000016f0 <stat>:

int
stat(char *n, struct stat *st)
{
    16f0:	55                   	push   %ebp
    16f1:	89 e5                	mov    %esp,%ebp
    16f3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    16f6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    16fd:	00 
    16fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1701:	89 04 24             	mov    %eax,(%esp)
    1704:	e8 07 01 00 00       	call   1810 <open>
    1709:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    170c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1710:	79 07                	jns    1719 <stat+0x29>
    return -1;
    1712:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1717:	eb 23                	jmp    173c <stat+0x4c>
  r = fstat(fd, st);
    1719:	8b 45 0c             	mov    0xc(%ebp),%eax
    171c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1720:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1723:	89 04 24             	mov    %eax,(%esp)
    1726:	e8 fd 00 00 00       	call   1828 <fstat>
    172b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    172e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1731:	89 04 24             	mov    %eax,(%esp)
    1734:	e8 bf 00 00 00       	call   17f8 <close>
  return r;
    1739:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    173c:	c9                   	leave  
    173d:	c3                   	ret    

0000173e <atoi>:

int
atoi(const char *s)
{
    173e:	55                   	push   %ebp
    173f:	89 e5                	mov    %esp,%ebp
    1741:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1744:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    174b:	eb 24                	jmp    1771 <atoi+0x33>
    n = n*10 + *s++ - '0';
    174d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1750:	89 d0                	mov    %edx,%eax
    1752:	c1 e0 02             	shl    $0x2,%eax
    1755:	01 d0                	add    %edx,%eax
    1757:	01 c0                	add    %eax,%eax
    1759:	89 c2                	mov    %eax,%edx
    175b:	8b 45 08             	mov    0x8(%ebp),%eax
    175e:	0f b6 00             	movzbl (%eax),%eax
    1761:	0f be c0             	movsbl %al,%eax
    1764:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1767:	83 e8 30             	sub    $0x30,%eax
    176a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    176d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1771:	8b 45 08             	mov    0x8(%ebp),%eax
    1774:	0f b6 00             	movzbl (%eax),%eax
    1777:	3c 2f                	cmp    $0x2f,%al
    1779:	7e 0a                	jle    1785 <atoi+0x47>
    177b:	8b 45 08             	mov    0x8(%ebp),%eax
    177e:	0f b6 00             	movzbl (%eax),%eax
    1781:	3c 39                	cmp    $0x39,%al
    1783:	7e c8                	jle    174d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1785:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1788:	c9                   	leave  
    1789:	c3                   	ret    

0000178a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    178a:	55                   	push   %ebp
    178b:	89 e5                	mov    %esp,%ebp
    178d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1790:	8b 45 08             	mov    0x8(%ebp),%eax
    1793:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1796:	8b 45 0c             	mov    0xc(%ebp),%eax
    1799:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    179c:	eb 13                	jmp    17b1 <memmove+0x27>
    *dst++ = *src++;
    179e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a1:	0f b6 10             	movzbl (%eax),%edx
    17a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17a7:	88 10                	mov    %dl,(%eax)
    17a9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    17ad:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    17b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    17b5:	0f 9f c0             	setg   %al
    17b8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    17bc:	84 c0                	test   %al,%al
    17be:	75 de                	jne    179e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    17c0:	8b 45 08             	mov    0x8(%ebp),%eax
}
    17c3:	c9                   	leave  
    17c4:	c3                   	ret    
    17c5:	90                   	nop
    17c6:	90                   	nop
    17c7:	90                   	nop

000017c8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    17c8:	b8 01 00 00 00       	mov    $0x1,%eax
    17cd:	cd 40                	int    $0x40
    17cf:	c3                   	ret    

000017d0 <exit>:
SYSCALL(exit)
    17d0:	b8 02 00 00 00       	mov    $0x2,%eax
    17d5:	cd 40                	int    $0x40
    17d7:	c3                   	ret    

000017d8 <wait>:
SYSCALL(wait)
    17d8:	b8 03 00 00 00       	mov    $0x3,%eax
    17dd:	cd 40                	int    $0x40
    17df:	c3                   	ret    

000017e0 <pipe>:
SYSCALL(pipe)
    17e0:	b8 04 00 00 00       	mov    $0x4,%eax
    17e5:	cd 40                	int    $0x40
    17e7:	c3                   	ret    

000017e8 <read>:
SYSCALL(read)
    17e8:	b8 05 00 00 00       	mov    $0x5,%eax
    17ed:	cd 40                	int    $0x40
    17ef:	c3                   	ret    

000017f0 <write>:
SYSCALL(write)
    17f0:	b8 10 00 00 00       	mov    $0x10,%eax
    17f5:	cd 40                	int    $0x40
    17f7:	c3                   	ret    

000017f8 <close>:
SYSCALL(close)
    17f8:	b8 15 00 00 00       	mov    $0x15,%eax
    17fd:	cd 40                	int    $0x40
    17ff:	c3                   	ret    

00001800 <kill>:
SYSCALL(kill)
    1800:	b8 06 00 00 00       	mov    $0x6,%eax
    1805:	cd 40                	int    $0x40
    1807:	c3                   	ret    

00001808 <exec>:
SYSCALL(exec)
    1808:	b8 07 00 00 00       	mov    $0x7,%eax
    180d:	cd 40                	int    $0x40
    180f:	c3                   	ret    

00001810 <open>:
SYSCALL(open)
    1810:	b8 0f 00 00 00       	mov    $0xf,%eax
    1815:	cd 40                	int    $0x40
    1817:	c3                   	ret    

00001818 <mknod>:
SYSCALL(mknod)
    1818:	b8 11 00 00 00       	mov    $0x11,%eax
    181d:	cd 40                	int    $0x40
    181f:	c3                   	ret    

00001820 <unlink>:
SYSCALL(unlink)
    1820:	b8 12 00 00 00       	mov    $0x12,%eax
    1825:	cd 40                	int    $0x40
    1827:	c3                   	ret    

00001828 <fstat>:
SYSCALL(fstat)
    1828:	b8 08 00 00 00       	mov    $0x8,%eax
    182d:	cd 40                	int    $0x40
    182f:	c3                   	ret    

00001830 <link>:
SYSCALL(link)
    1830:	b8 13 00 00 00       	mov    $0x13,%eax
    1835:	cd 40                	int    $0x40
    1837:	c3                   	ret    

00001838 <mkdir>:
SYSCALL(mkdir)
    1838:	b8 14 00 00 00       	mov    $0x14,%eax
    183d:	cd 40                	int    $0x40
    183f:	c3                   	ret    

00001840 <chdir>:
SYSCALL(chdir)
    1840:	b8 09 00 00 00       	mov    $0x9,%eax
    1845:	cd 40                	int    $0x40
    1847:	c3                   	ret    

00001848 <dup>:
SYSCALL(dup)
    1848:	b8 0a 00 00 00       	mov    $0xa,%eax
    184d:	cd 40                	int    $0x40
    184f:	c3                   	ret    

00001850 <getpid>:
SYSCALL(getpid)
    1850:	b8 0b 00 00 00       	mov    $0xb,%eax
    1855:	cd 40                	int    $0x40
    1857:	c3                   	ret    

00001858 <sbrk>:
SYSCALL(sbrk)
    1858:	b8 0c 00 00 00       	mov    $0xc,%eax
    185d:	cd 40                	int    $0x40
    185f:	c3                   	ret    

00001860 <sleep>:
SYSCALL(sleep)
    1860:	b8 0d 00 00 00       	mov    $0xd,%eax
    1865:	cd 40                	int    $0x40
    1867:	c3                   	ret    

00001868 <uptime>:
SYSCALL(uptime)
    1868:	b8 0e 00 00 00       	mov    $0xe,%eax
    186d:	cd 40                	int    $0x40
    186f:	c3                   	ret    

00001870 <clone>:
SYSCALL(clone)
    1870:	b8 16 00 00 00       	mov    $0x16,%eax
    1875:	cd 40                	int    $0x40
    1877:	c3                   	ret    

00001878 <texit>:
SYSCALL(texit)
    1878:	b8 17 00 00 00       	mov    $0x17,%eax
    187d:	cd 40                	int    $0x40
    187f:	c3                   	ret    

00001880 <tsleep>:
SYSCALL(tsleep)
    1880:	b8 18 00 00 00       	mov    $0x18,%eax
    1885:	cd 40                	int    $0x40
    1887:	c3                   	ret    

00001888 <twakeup>:
SYSCALL(twakeup)
    1888:	b8 19 00 00 00       	mov    $0x19,%eax
    188d:	cd 40                	int    $0x40
    188f:	c3                   	ret    

00001890 <thread_yield>:
SYSCALL(thread_yield) 
    1890:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1895:	cd 40                	int    $0x40
    1897:	c3                   	ret    

00001898 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1898:	55                   	push   %ebp
    1899:	89 e5                	mov    %esp,%ebp
    189b:	83 ec 28             	sub    $0x28,%esp
    189e:	8b 45 0c             	mov    0xc(%ebp),%eax
    18a1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    18a4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    18ab:	00 
    18ac:	8d 45 f4             	lea    -0xc(%ebp),%eax
    18af:	89 44 24 04          	mov    %eax,0x4(%esp)
    18b3:	8b 45 08             	mov    0x8(%ebp),%eax
    18b6:	89 04 24             	mov    %eax,(%esp)
    18b9:	e8 32 ff ff ff       	call   17f0 <write>
}
    18be:	c9                   	leave  
    18bf:	c3                   	ret    

000018c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    18c0:	55                   	push   %ebp
    18c1:	89 e5                	mov    %esp,%ebp
    18c3:	53                   	push   %ebx
    18c4:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    18c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    18ce:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    18d2:	74 17                	je     18eb <printint+0x2b>
    18d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    18d8:	79 11                	jns    18eb <printint+0x2b>
    neg = 1;
    18da:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    18e1:	8b 45 0c             	mov    0xc(%ebp),%eax
    18e4:	f7 d8                	neg    %eax
    18e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    18e9:	eb 06                	jmp    18f1 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    18eb:	8b 45 0c             	mov    0xc(%ebp),%eax
    18ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    18f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    18f8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    18fb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    18fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1901:	ba 00 00 00 00       	mov    $0x0,%edx
    1906:	f7 f3                	div    %ebx
    1908:	89 d0                	mov    %edx,%eax
    190a:	0f b6 80 0c 22 00 00 	movzbl 0x220c(%eax),%eax
    1911:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1915:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1919:	8b 45 10             	mov    0x10(%ebp),%eax
    191c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    191f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1922:	ba 00 00 00 00       	mov    $0x0,%edx
    1927:	f7 75 d4             	divl   -0x2c(%ebp)
    192a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    192d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1931:	75 c5                	jne    18f8 <printint+0x38>
  if(neg)
    1933:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1937:	74 28                	je     1961 <printint+0xa1>
    buf[i++] = '-';
    1939:	8b 45 ec             	mov    -0x14(%ebp),%eax
    193c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1941:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1945:	eb 1a                	jmp    1961 <printint+0xa1>
    putc(fd, buf[i]);
    1947:	8b 45 ec             	mov    -0x14(%ebp),%eax
    194a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    194f:	0f be c0             	movsbl %al,%eax
    1952:	89 44 24 04          	mov    %eax,0x4(%esp)
    1956:	8b 45 08             	mov    0x8(%ebp),%eax
    1959:	89 04 24             	mov    %eax,(%esp)
    195c:	e8 37 ff ff ff       	call   1898 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1961:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1965:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1969:	79 dc                	jns    1947 <printint+0x87>
    putc(fd, buf[i]);
}
    196b:	83 c4 44             	add    $0x44,%esp
    196e:	5b                   	pop    %ebx
    196f:	5d                   	pop    %ebp
    1970:	c3                   	ret    

00001971 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1971:	55                   	push   %ebp
    1972:	89 e5                	mov    %esp,%ebp
    1974:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1977:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    197e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1981:	83 c0 04             	add    $0x4,%eax
    1984:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1987:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    198e:	e9 7e 01 00 00       	jmp    1b11 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1993:	8b 55 0c             	mov    0xc(%ebp),%edx
    1996:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1999:	8d 04 02             	lea    (%edx,%eax,1),%eax
    199c:	0f b6 00             	movzbl (%eax),%eax
    199f:	0f be c0             	movsbl %al,%eax
    19a2:	25 ff 00 00 00       	and    $0xff,%eax
    19a7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    19aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19ae:	75 2c                	jne    19dc <printf+0x6b>
      if(c == '%'){
    19b0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    19b4:	75 0c                	jne    19c2 <printf+0x51>
        state = '%';
    19b6:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    19bd:	e9 4b 01 00 00       	jmp    1b0d <printf+0x19c>
      } else {
        putc(fd, c);
    19c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
    19c5:	0f be c0             	movsbl %al,%eax
    19c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    19cc:	8b 45 08             	mov    0x8(%ebp),%eax
    19cf:	89 04 24             	mov    %eax,(%esp)
    19d2:	e8 c1 fe ff ff       	call   1898 <putc>
    19d7:	e9 31 01 00 00       	jmp    1b0d <printf+0x19c>
      }
    } else if(state == '%'){
    19dc:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    19e0:	0f 85 27 01 00 00    	jne    1b0d <printf+0x19c>
      if(c == 'd'){
    19e6:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    19ea:	75 2d                	jne    1a19 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    19ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ef:	8b 00                	mov    (%eax),%eax
    19f1:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    19f8:	00 
    19f9:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1a00:	00 
    1a01:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a05:	8b 45 08             	mov    0x8(%ebp),%eax
    1a08:	89 04 24             	mov    %eax,(%esp)
    1a0b:	e8 b0 fe ff ff       	call   18c0 <printint>
        ap++;
    1a10:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1a14:	e9 ed 00 00 00       	jmp    1b06 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1a19:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1a1d:	74 06                	je     1a25 <printf+0xb4>
    1a1f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1a23:	75 2d                	jne    1a52 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1a25:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a28:	8b 00                	mov    (%eax),%eax
    1a2a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1a31:	00 
    1a32:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1a39:	00 
    1a3a:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	89 04 24             	mov    %eax,(%esp)
    1a44:	e8 77 fe ff ff       	call   18c0 <printint>
        ap++;
    1a49:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1a4d:	e9 b4 00 00 00       	jmp    1b06 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1a52:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1a56:	75 46                	jne    1a9e <printf+0x12d>
        s = (char*)*ap;
    1a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5b:	8b 00                	mov    (%eax),%eax
    1a5d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1a60:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1a64:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1a68:	75 27                	jne    1a91 <printf+0x120>
          s = "(null)";
    1a6a:	c7 45 e4 d7 21 00 00 	movl   $0x21d7,-0x1c(%ebp)
        while(*s != 0){
    1a71:	eb 1f                	jmp    1a92 <printf+0x121>
          putc(fd, *s);
    1a73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a76:	0f b6 00             	movzbl (%eax),%eax
    1a79:	0f be c0             	movsbl %al,%eax
    1a7c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a80:	8b 45 08             	mov    0x8(%ebp),%eax
    1a83:	89 04 24             	mov    %eax,(%esp)
    1a86:	e8 0d fe ff ff       	call   1898 <putc>
          s++;
    1a8b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1a8f:	eb 01                	jmp    1a92 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1a91:	90                   	nop
    1a92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a95:	0f b6 00             	movzbl (%eax),%eax
    1a98:	84 c0                	test   %al,%al
    1a9a:	75 d7                	jne    1a73 <printf+0x102>
    1a9c:	eb 68                	jmp    1b06 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1a9e:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1aa2:	75 1d                	jne    1ac1 <printf+0x150>
        putc(fd, *ap);
    1aa4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aa7:	8b 00                	mov    (%eax),%eax
    1aa9:	0f be c0             	movsbl %al,%eax
    1aac:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ab0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab3:	89 04 24             	mov    %eax,(%esp)
    1ab6:	e8 dd fd ff ff       	call   1898 <putc>
        ap++;
    1abb:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1abf:	eb 45                	jmp    1b06 <printf+0x195>
      } else if(c == '%'){
    1ac1:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1ac5:	75 17                	jne    1ade <printf+0x16d>
        putc(fd, c);
    1ac7:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1aca:	0f be c0             	movsbl %al,%eax
    1acd:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ad1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad4:	89 04 24             	mov    %eax,(%esp)
    1ad7:	e8 bc fd ff ff       	call   1898 <putc>
    1adc:	eb 28                	jmp    1b06 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1ade:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1ae5:	00 
    1ae6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae9:	89 04 24             	mov    %eax,(%esp)
    1aec:	e8 a7 fd ff ff       	call   1898 <putc>
        putc(fd, c);
    1af1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1af4:	0f be c0             	movsbl %al,%eax
    1af7:	89 44 24 04          	mov    %eax,0x4(%esp)
    1afb:	8b 45 08             	mov    0x8(%ebp),%eax
    1afe:	89 04 24             	mov    %eax,(%esp)
    1b01:	e8 92 fd ff ff       	call   1898 <putc>
      }
      state = 0;
    1b06:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1b0d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1b11:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b14:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b17:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1b1a:	0f b6 00             	movzbl (%eax),%eax
    1b1d:	84 c0                	test   %al,%al
    1b1f:	0f 85 6e fe ff ff    	jne    1993 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1b25:	c9                   	leave  
    1b26:	c3                   	ret    
    1b27:	90                   	nop

00001b28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1b28:	55                   	push   %ebp
    1b29:	89 e5                	mov    %esp,%ebp
    1b2b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1b2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b31:	83 e8 08             	sub    $0x8,%eax
    1b34:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b37:	a1 40 22 00 00       	mov    0x2240,%eax
    1b3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b3f:	eb 24                	jmp    1b65 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1b41:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b44:	8b 00                	mov    (%eax),%eax
    1b46:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b49:	77 12                	ja     1b5d <free+0x35>
    1b4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b4e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b51:	77 24                	ja     1b77 <free+0x4f>
    1b53:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b56:	8b 00                	mov    (%eax),%eax
    1b58:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b5b:	77 1a                	ja     1b77 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1b5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b60:	8b 00                	mov    (%eax),%eax
    1b62:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1b65:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b68:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1b6b:	76 d4                	jbe    1b41 <free+0x19>
    1b6d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b70:	8b 00                	mov    (%eax),%eax
    1b72:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b75:	76 ca                	jbe    1b41 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b77:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b7a:	8b 40 04             	mov    0x4(%eax),%eax
    1b7d:	c1 e0 03             	shl    $0x3,%eax
    1b80:	89 c2                	mov    %eax,%edx
    1b82:	03 55 f8             	add    -0x8(%ebp),%edx
    1b85:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b88:	8b 00                	mov    (%eax),%eax
    1b8a:	39 c2                	cmp    %eax,%edx
    1b8c:	75 24                	jne    1bb2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1b8e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b91:	8b 50 04             	mov    0x4(%eax),%edx
    1b94:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b97:	8b 00                	mov    (%eax),%eax
    1b99:	8b 40 04             	mov    0x4(%eax),%eax
    1b9c:	01 c2                	add    %eax,%edx
    1b9e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ba1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ba4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ba7:	8b 00                	mov    (%eax),%eax
    1ba9:	8b 10                	mov    (%eax),%edx
    1bab:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bae:	89 10                	mov    %edx,(%eax)
    1bb0:	eb 0a                	jmp    1bbc <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1bb2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bb5:	8b 10                	mov    (%eax),%edx
    1bb7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bba:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1bbc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bbf:	8b 40 04             	mov    0x4(%eax),%eax
    1bc2:	c1 e0 03             	shl    $0x3,%eax
    1bc5:	03 45 fc             	add    -0x4(%ebp),%eax
    1bc8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1bcb:	75 20                	jne    1bed <free+0xc5>
    p->s.size += bp->s.size;
    1bcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bd0:	8b 50 04             	mov    0x4(%eax),%edx
    1bd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bd6:	8b 40 04             	mov    0x4(%eax),%eax
    1bd9:	01 c2                	add    %eax,%edx
    1bdb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bde:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1be1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1be4:	8b 10                	mov    (%eax),%edx
    1be6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1be9:	89 10                	mov    %edx,(%eax)
    1beb:	eb 08                	jmp    1bf5 <free+0xcd>
  } else
    p->s.ptr = bp;
    1bed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bf0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1bf3:	89 10                	mov    %edx,(%eax)
  freep = p;
    1bf5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bf8:	a3 40 22 00 00       	mov    %eax,0x2240
}
    1bfd:	c9                   	leave  
    1bfe:	c3                   	ret    

00001bff <morecore>:

static Header*
morecore(uint nu)
{
    1bff:	55                   	push   %ebp
    1c00:	89 e5                	mov    %esp,%ebp
    1c02:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1c05:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1c0c:	77 07                	ja     1c15 <morecore+0x16>
    nu = 4096;
    1c0e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1c15:	8b 45 08             	mov    0x8(%ebp),%eax
    1c18:	c1 e0 03             	shl    $0x3,%eax
    1c1b:	89 04 24             	mov    %eax,(%esp)
    1c1e:	e8 35 fc ff ff       	call   1858 <sbrk>
    1c23:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1c26:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1c2a:	75 07                	jne    1c33 <morecore+0x34>
    return 0;
    1c2c:	b8 00 00 00 00       	mov    $0x0,%eax
    1c31:	eb 22                	jmp    1c55 <morecore+0x56>
  hp = (Header*)p;
    1c33:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c3c:	8b 55 08             	mov    0x8(%ebp),%edx
    1c3f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1c42:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c45:	83 c0 08             	add    $0x8,%eax
    1c48:	89 04 24             	mov    %eax,(%esp)
    1c4b:	e8 d8 fe ff ff       	call   1b28 <free>
  return freep;
    1c50:	a1 40 22 00 00       	mov    0x2240,%eax
}
    1c55:	c9                   	leave  
    1c56:	c3                   	ret    

00001c57 <malloc>:

void*
malloc(uint nbytes)
{
    1c57:	55                   	push   %ebp
    1c58:	89 e5                	mov    %esp,%ebp
    1c5a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c60:	83 c0 07             	add    $0x7,%eax
    1c63:	c1 e8 03             	shr    $0x3,%eax
    1c66:	83 c0 01             	add    $0x1,%eax
    1c69:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1c6c:	a1 40 22 00 00       	mov    0x2240,%eax
    1c71:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c74:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c78:	75 23                	jne    1c9d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1c7a:	c7 45 f0 38 22 00 00 	movl   $0x2238,-0x10(%ebp)
    1c81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c84:	a3 40 22 00 00       	mov    %eax,0x2240
    1c89:	a1 40 22 00 00       	mov    0x2240,%eax
    1c8e:	a3 38 22 00 00       	mov    %eax,0x2238
    base.s.size = 0;
    1c93:	c7 05 3c 22 00 00 00 	movl   $0x0,0x223c
    1c9a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ca0:	8b 00                	mov    (%eax),%eax
    1ca2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1ca5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ca8:	8b 40 04             	mov    0x4(%eax),%eax
    1cab:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1cae:	72 4d                	jb     1cfd <malloc+0xa6>
      if(p->s.size == nunits)
    1cb0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cb3:	8b 40 04             	mov    0x4(%eax),%eax
    1cb6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1cb9:	75 0c                	jne    1cc7 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1cbb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cbe:	8b 10                	mov    (%eax),%edx
    1cc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cc3:	89 10                	mov    %edx,(%eax)
    1cc5:	eb 26                	jmp    1ced <malloc+0x96>
      else {
        p->s.size -= nunits;
    1cc7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cca:	8b 40 04             	mov    0x4(%eax),%eax
    1ccd:	89 c2                	mov    %eax,%edx
    1ccf:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1cd2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cd5:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1cd8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cdb:	8b 40 04             	mov    0x4(%eax),%eax
    1cde:	c1 e0 03             	shl    $0x3,%eax
    1ce1:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1ce4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ce7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1cea:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1ced:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1cf0:	a3 40 22 00 00       	mov    %eax,0x2240
      return (void*)(p + 1);
    1cf5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cf8:	83 c0 08             	add    $0x8,%eax
    1cfb:	eb 38                	jmp    1d35 <malloc+0xde>
    }
    if(p == freep)
    1cfd:	a1 40 22 00 00       	mov    0x2240,%eax
    1d02:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1d05:	75 1b                	jne    1d22 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1d07:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d0a:	89 04 24             	mov    %eax,(%esp)
    1d0d:	e8 ed fe ff ff       	call   1bff <morecore>
    1d12:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1d15:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d19:	75 07                	jne    1d22 <malloc+0xcb>
        return 0;
    1d1b:	b8 00 00 00 00       	mov    $0x0,%eax
    1d20:	eb 13                	jmp    1d35 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d22:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d25:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d28:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d2b:	8b 00                	mov    (%eax),%eax
    1d2d:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1d30:	e9 70 ff ff ff       	jmp    1ca5 <malloc+0x4e>
}
    1d35:	c9                   	leave  
    1d36:	c3                   	ret    
    1d37:	90                   	nop

00001d38 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1d38:	55                   	push   %ebp
    1d39:	89 e5                	mov    %esp,%ebp
    1d3b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1d3e:	8b 55 08             	mov    0x8(%ebp),%edx
    1d41:	8b 45 0c             	mov    0xc(%ebp),%eax
    1d44:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1d47:	f0 87 02             	lock xchg %eax,(%edx)
    1d4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1d4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1d50:	c9                   	leave  
    1d51:	c3                   	ret    

00001d52 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1d52:	55                   	push   %ebp
    1d53:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1d55:	8b 45 08             	mov    0x8(%ebp),%eax
    1d58:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1d5e:	5d                   	pop    %ebp
    1d5f:	c3                   	ret    

00001d60 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1d60:	55                   	push   %ebp
    1d61:	89 e5                	mov    %esp,%ebp
    1d63:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1d66:	8b 45 08             	mov    0x8(%ebp),%eax
    1d69:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1d70:	00 
    1d71:	89 04 24             	mov    %eax,(%esp)
    1d74:	e8 bf ff ff ff       	call   1d38 <xchg>
    1d79:	85 c0                	test   %eax,%eax
    1d7b:	75 e9                	jne    1d66 <lock_acquire+0x6>
}
    1d7d:	c9                   	leave  
    1d7e:	c3                   	ret    

00001d7f <lock_release>:
void lock_release(lock_t *lock){
    1d7f:	55                   	push   %ebp
    1d80:	89 e5                	mov    %esp,%ebp
    1d82:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1d85:	8b 45 08             	mov    0x8(%ebp),%eax
    1d88:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d8f:	00 
    1d90:	89 04 24             	mov    %eax,(%esp)
    1d93:	e8 a0 ff ff ff       	call   1d38 <xchg>
}
    1d98:	c9                   	leave  
    1d99:	c3                   	ret    

00001d9a <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1d9a:	55                   	push   %ebp
    1d9b:	89 e5                	mov    %esp,%ebp
    1d9d:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1da0:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1da7:	e8 ab fe ff ff       	call   1c57 <malloc>
    1dac:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1daf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db2:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1db5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1db8:	25 ff 0f 00 00       	and    $0xfff,%eax
    1dbd:	85 c0                	test   %eax,%eax
    1dbf:	74 15                	je     1dd6 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1dc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dc4:	89 c2                	mov    %eax,%edx
    1dc6:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1dcc:	b8 00 10 00 00       	mov    $0x1000,%eax
    1dd1:	29 d0                	sub    %edx,%eax
    1dd3:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1dd6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1dda:	75 1b                	jne    1df7 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1ddc:	c7 44 24 04 de 21 00 	movl   $0x21de,0x4(%esp)
    1de3:	00 
    1de4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1deb:	e8 81 fb ff ff       	call   1971 <printf>
        return 0;
    1df0:	b8 00 00 00 00       	mov    $0x0,%eax
    1df5:	eb 6f                	jmp    1e66 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1df7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1dfa:	8b 55 08             	mov    0x8(%ebp),%edx
    1dfd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e00:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1e04:	89 54 24 08          	mov    %edx,0x8(%esp)
    1e08:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1e0f:	00 
    1e10:	89 04 24             	mov    %eax,(%esp)
    1e13:	e8 58 fa ff ff       	call   1870 <clone>
    1e18:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1e1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e1f:	79 1b                	jns    1e3c <thread_create+0xa2>
        printf(1,"clone fails\n");
    1e21:	c7 44 24 04 ec 21 00 	movl   $0x21ec,0x4(%esp)
    1e28:	00 
    1e29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e30:	e8 3c fb ff ff       	call   1971 <printf>
        return 0;
    1e35:	b8 00 00 00 00       	mov    $0x0,%eax
    1e3a:	eb 2a                	jmp    1e66 <thread_create+0xcc>
    }
    if(tid > 0){
    1e3c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e40:	7e 05                	jle    1e47 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1e42:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e45:	eb 1f                	jmp    1e66 <thread_create+0xcc>
    }
    if(tid == 0){
    1e47:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e4b:	75 14                	jne    1e61 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1e4d:	c7 44 24 04 f9 21 00 	movl   $0x21f9,0x4(%esp)
    1e54:	00 
    1e55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e5c:	e8 10 fb ff ff       	call   1971 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1e61:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1e66:	c9                   	leave  
    1e67:	c3                   	ret    

00001e68 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1e68:	55                   	push   %ebp
    1e69:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1e6b:	a1 20 22 00 00       	mov    0x2220,%eax
    1e70:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1e76:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1e7b:	a3 20 22 00 00       	mov    %eax,0x2220
    return (int)(rands % max);
    1e80:	a1 20 22 00 00       	mov    0x2220,%eax
    1e85:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e88:	ba 00 00 00 00       	mov    $0x0,%edx
    1e8d:	f7 f1                	div    %ecx
    1e8f:	89 d0                	mov    %edx,%eax
}
    1e91:	5d                   	pop    %ebp
    1e92:	c3                   	ret    
    1e93:	90                   	nop

00001e94 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1e94:	55                   	push   %ebp
    1e95:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1e97:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ea0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1eaa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ead:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1eb4:	5d                   	pop    %ebp
    1eb5:	c3                   	ret    

00001eb6 <add_q>:

void add_q(struct queue *q, int v){
    1eb6:	55                   	push   %ebp
    1eb7:	89 e5                	mov    %esp,%ebp
    1eb9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1ebc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1ec3:	e8 8f fd ff ff       	call   1c57 <malloc>
    1ec8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1ecb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ece:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1ed5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
    1edb:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1edd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee0:	8b 40 04             	mov    0x4(%eax),%eax
    1ee3:	85 c0                	test   %eax,%eax
    1ee5:	75 0b                	jne    1ef2 <add_q+0x3c>
        q->head = n;
    1ee7:	8b 45 08             	mov    0x8(%ebp),%eax
    1eea:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1eed:	89 50 04             	mov    %edx,0x4(%eax)
    1ef0:	eb 0c                	jmp    1efe <add_q+0x48>
    }else{
        q->tail->next = n;
    1ef2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef5:	8b 40 08             	mov    0x8(%eax),%eax
    1ef8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1efb:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1efe:	8b 45 08             	mov    0x8(%ebp),%eax
    1f01:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1f04:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1f07:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0a:	8b 00                	mov    (%eax),%eax
    1f0c:	8d 50 01             	lea    0x1(%eax),%edx
    1f0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f12:	89 10                	mov    %edx,(%eax)
}
    1f14:	c9                   	leave  
    1f15:	c3                   	ret    

00001f16 <empty_q>:

int empty_q(struct queue *q){
    1f16:	55                   	push   %ebp
    1f17:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1f19:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1c:	8b 00                	mov    (%eax),%eax
    1f1e:	85 c0                	test   %eax,%eax
    1f20:	75 07                	jne    1f29 <empty_q+0x13>
        return 1;
    1f22:	b8 01 00 00 00       	mov    $0x1,%eax
    1f27:	eb 05                	jmp    1f2e <empty_q+0x18>
    else
        return 0;
    1f29:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1f2e:	5d                   	pop    %ebp
    1f2f:	c3                   	ret    

00001f30 <pop_q>:
int pop_q(struct queue *q){
    1f30:	55                   	push   %ebp
    1f31:	89 e5                	mov    %esp,%ebp
    1f33:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1f36:	8b 45 08             	mov    0x8(%ebp),%eax
    1f39:	89 04 24             	mov    %eax,(%esp)
    1f3c:	e8 d5 ff ff ff       	call   1f16 <empty_q>
    1f41:	85 c0                	test   %eax,%eax
    1f43:	75 5d                	jne    1fa2 <pop_q+0x72>
       val = q->head->value; 
    1f45:	8b 45 08             	mov    0x8(%ebp),%eax
    1f48:	8b 40 04             	mov    0x4(%eax),%eax
    1f4b:	8b 00                	mov    (%eax),%eax
    1f4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1f50:	8b 45 08             	mov    0x8(%ebp),%eax
    1f53:	8b 40 04             	mov    0x4(%eax),%eax
    1f56:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1f59:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5c:	8b 40 04             	mov    0x4(%eax),%eax
    1f5f:	8b 50 04             	mov    0x4(%eax),%edx
    1f62:	8b 45 08             	mov    0x8(%ebp),%eax
    1f65:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1f68:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f6b:	89 04 24             	mov    %eax,(%esp)
    1f6e:	e8 b5 fb ff ff       	call   1b28 <free>
       q->size--;
    1f73:	8b 45 08             	mov    0x8(%ebp),%eax
    1f76:	8b 00                	mov    (%eax),%eax
    1f78:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1f80:	8b 45 08             	mov    0x8(%ebp),%eax
    1f83:	8b 00                	mov    (%eax),%eax
    1f85:	85 c0                	test   %eax,%eax
    1f87:	75 14                	jne    1f9d <pop_q+0x6d>
            q->head = 0;
    1f89:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1f93:	8b 45 08             	mov    0x8(%ebp),%eax
    1f96:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1f9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1fa0:	eb 05                	jmp    1fa7 <pop_q+0x77>
    }
    return -1;
    1fa2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1fa7:	c9                   	leave  
    1fa8:	c3                   	ret    
    1fa9:	90                   	nop
    1faa:	90                   	nop
    1fab:	90                   	nop

00001fac <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1fac:	55                   	push   %ebp
    1fad:	89 e5                	mov    %esp,%ebp
    1faf:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1fb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb5:	89 04 24             	mov    %eax,(%esp)
    1fb8:	e8 a3 fd ff ff       	call   1d60 <lock_acquire>
	s->count--; 
    1fbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc0:	8b 40 04             	mov    0x4(%eax),%eax
    1fc3:	8d 50 ff             	lea    -0x1(%eax),%edx
    1fc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc9:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1fcc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fcf:	8b 40 04             	mov    0x4(%eax),%eax
    1fd2:	85 c0                	test   %eax,%eax
    1fd4:	79 27                	jns    1ffd <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1fd6:	e8 75 f8 ff ff       	call   1850 <getpid>
    1fdb:	8b 55 08             	mov    0x8(%ebp),%edx
    1fde:	83 c2 08             	add    $0x8,%edx
    1fe1:	89 44 24 04          	mov    %eax,0x4(%esp)
    1fe5:	89 14 24             	mov    %edx,(%esp)
    1fe8:	e8 c9 fe ff ff       	call   1eb6 <add_q>
		lock_release(&s->lock); 
    1fed:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff0:	89 04 24             	mov    %eax,(%esp)
    1ff3:	e8 87 fd ff ff       	call   1d7f <lock_release>
		tsleep(); 
    1ff8:	e8 83 f8 ff ff       	call   1880 <tsleep>
	} 
	lock_release(&s->lock); 
    1ffd:	8b 45 08             	mov    0x8(%ebp),%eax
    2000:	89 04 24             	mov    %eax,(%esp)
    2003:	e8 77 fd ff ff       	call   1d7f <lock_release>
}
    2008:	c9                   	leave  
    2009:	c3                   	ret    

0000200a <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    200a:	55                   	push   %ebp
    200b:	89 e5                	mov    %esp,%ebp
    200d:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    2010:	8b 45 08             	mov    0x8(%ebp),%eax
    2013:	89 04 24             	mov    %eax,(%esp)
    2016:	e8 45 fd ff ff       	call   1d60 <lock_acquire>
	s->count++; 
    201b:	8b 45 08             	mov    0x8(%ebp),%eax
    201e:	8b 40 04             	mov    0x4(%eax),%eax
    2021:	8d 50 01             	lea    0x1(%eax),%edx
    2024:	8b 45 08             	mov    0x8(%ebp),%eax
    2027:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    202a:	8b 45 08             	mov    0x8(%ebp),%eax
    202d:	8b 40 04             	mov    0x4(%eax),%eax
    2030:	85 c0                	test   %eax,%eax
    2032:	7f 1c                	jg     2050 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    2034:	8b 45 08             	mov    0x8(%ebp),%eax
    2037:	83 c0 08             	add    $0x8,%eax
    203a:	89 04 24             	mov    %eax,(%esp)
    203d:	e8 ee fe ff ff       	call   1f30 <pop_q>
    2042:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    2045:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2048:	89 04 24             	mov    %eax,(%esp)
    204b:	e8 38 f8 ff ff       	call   1888 <twakeup>
	}
	lock_release(&s->lock); 
    2050:	8b 45 08             	mov    0x8(%ebp),%eax
    2053:	89 04 24             	mov    %eax,(%esp)
    2056:	e8 24 fd ff ff       	call   1d7f <lock_release>
} 
    205b:	c9                   	leave  
    205c:	c3                   	ret    

0000205d <sem_init>:

void sem_init(struct Semaphore *s, int size){
    205d:	55                   	push   %ebp
    205e:	89 e5                	mov    %esp,%ebp
    2060:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    2063:	8b 45 08             	mov    0x8(%ebp),%eax
    2066:	89 04 24             	mov    %eax,(%esp)
    2069:	e8 e4 fc ff ff       	call   1d52 <lock_init>
	s->count = size; 
    206e:	8b 45 08             	mov    0x8(%ebp),%eax
    2071:	8b 55 0c             	mov    0xc(%ebp),%edx
    2074:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    2077:	8b 45 08             	mov    0x8(%ebp),%eax
    207a:	83 c0 08             	add    $0x8,%eax
    207d:	89 04 24             	mov    %eax,(%esp)
    2080:	e8 0f fe ff ff       	call   1e94 <init_q>
}
    2085:	c9                   	leave  
    2086:	c3                   	ret    
