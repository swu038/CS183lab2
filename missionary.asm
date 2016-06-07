
_missionary:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
struct{
	lock_t lock; 
}mutex;    
int numBoat = 0; 

int main() {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp

	lock_acquire(&mutex.lock); 
    1009:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1010:	e8 d7 0c 00 00       	call   1cec <lock_acquire>
	printf(1,"Created 1 missionary, and 2 Cannibal. There should be no boat rides since we can't have 2 cannibals with 1 missioanry. \n"); 
    1015:	c7 44 24 04 14 20 00 	movl   $0x2014,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 d4 08 00 00       	call   18fd <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    1030:	e8 d6 0c 00 00       	call   1d0b <lock_release>
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 af 10 00 00 	movl   $0x10af,(%esp)
    1044:	e8 dd 0c 00 00       	call   1d26 <thread_create>
    1049:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(mid == 0) exit(); 
    104d:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1052:	75 05                	jne    1059 <main+0x59>
    1054:	e8 03 07 00 00       	call   175c <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    1059:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1060:	00 
    1061:	c7 04 24 c0 12 00 00 	movl   $0x12c0,(%esp)
    1068:	e8 b9 0c 00 00       	call   1d26 <thread_create>
    106d:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(cid == 0) exit(); 
    1071:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1076:	75 05                	jne    107d <main+0x7d>
    1078:	e8 df 06 00 00       	call   175c <exit>

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
    107d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1084:	00 
    1085:	c7 04 24 c0 12 00 00 	movl   $0x12c0,(%esp)
    108c:	e8 95 0c 00 00       	call   1d26 <thread_create>
    1091:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(cid2 == 0) exit(); 
    1095:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    109a:	75 05                	jne    10a1 <main+0xa1>
    109c:	e8 bb 06 00 00       	call   175c <exit>

	while(wait() > 0); 
    10a1:	e8 be 06 00 00       	call   1764 <wait>
    10a6:	85 c0                	test   %eax,%eax
    10a8:	7f f7                	jg     10a1 <main+0xa1>

	exit(); 
    10aa:	e8 ad 06 00 00       	call   175c <exit>

000010af <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    10af:	55                   	push   %ebp
    10b0:	89 e5                	mov    %esp,%ebp
    10b2:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    10b5:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    10bc:	e8 2b 0c 00 00       	call   1cec <lock_acquire>
	if(numMissionaries == 2) 
    10c1:	a1 f0 21 00 00       	mov    0x21f0,%eax
    10c6:	83 f8 02             	cmp    $0x2,%eax
    10c9:	0f 85 c8 00 00 00    	jne    1197 <MissionaryArrives+0xe8>
	{
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    10cf:	a1 f0 21 00 00       	mov    0x21f0,%eax
    10d4:	83 c0 01             	add    $0x1,%eax
    10d7:	a3 f0 21 00 00       	mov    %eax,0x21f0
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    10dc:	a1 f0 21 00 00       	mov    0x21f0,%eax
    10e1:	89 44 24 08          	mov    %eax,0x8(%esp)
    10e5:	c7 44 24 04 90 20 00 	movl   $0x2090,0x4(%esp)
    10ec:	00 
    10ed:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10f4:	e8 04 08 00 00       	call   18fd <printf>
		//sem_signal(&M); 
		//sem_signal(&M);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    10f9:	a1 f0 21 00 00       	mov    0x21f0,%eax
    10fe:	89 44 24 08          	mov    %eax,0x8(%esp)
    1102:	c7 44 24 04 b8 20 00 	movl   $0x20b8,0x4(%esp)
    1109:	00 
    110a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1111:	e8 e7 07 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals on boat: %d.\n",0);  
    1116:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    111d:	00 
    111e:	c7 44 24 04 e0 20 00 	movl   $0x20e0,0x4(%esp)
    1125:	00 
    1126:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    112d:	e8 cb 07 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock);
 
		RowBoat();
    1132:	e8 8c 03 00 00       	call   14c3 <RowBoat>

		//lock_acquire(&mutex.lock);	 
		numMissionaries = numMissionaries - 3;
    1137:	a1 f0 21 00 00       	mov    0x21f0,%eax
    113c:	83 e8 03             	sub    $0x3,%eax
    113f:	a3 f0 21 00 00       	mov    %eax,0x21f0
		
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1144:	a1 f0 21 00 00       	mov    0x21f0,%eax
    1149:	89 44 24 08          	mov    %eax,0x8(%esp)
    114d:	c7 44 24 04 04 21 00 	movl   $0x2104,0x4(%esp)
    1154:	00 
    1155:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    115c:	e8 9c 07 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1161:	a1 f4 21 00 00       	mov    0x21f4,%eax
    1166:	89 44 24 08          	mov    %eax,0x8(%esp)
    116a:	c7 44 24 04 2c 21 00 	movl   $0x212c,0x4(%esp)
    1171:	00 
    1172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1179:	e8 7f 07 00 00       	call   18fd <printf>
		printf(1,"==============================\n");  
    117e:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    1185:	00 
    1186:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    118d:	e8 6b 07 00 00       	call   18fd <printf>
    1192:	e9 18 01 00 00       	jmp    12af <MissionaryArrives+0x200>
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1197:	a1 f0 21 00 00       	mov    0x21f0,%eax
    119c:	83 f8 01             	cmp    $0x1,%eax
    119f:	0f 85 e0 00 00 00    	jne    1285 <MissionaryArrives+0x1d6>
    11a5:	a1 f4 21 00 00       	mov    0x21f4,%eax
    11aa:	83 f8 01             	cmp    $0x1,%eax
    11ad:	0f 85 d2 00 00 00    	jne    1285 <MissionaryArrives+0x1d6>
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    11b3:	a1 f0 21 00 00       	mov    0x21f0,%eax
    11b8:	83 c0 01             	add    $0x1,%eax
    11bb:	a3 f0 21 00 00       	mov    %eax,0x21f0
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    11c0:	a1 f0 21 00 00       	mov    0x21f0,%eax
    11c5:	89 44 24 08          	mov    %eax,0x8(%esp)
    11c9:	c7 44 24 04 90 20 00 	movl   $0x2090,0x4(%esp)
    11d0:	00 
    11d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d8:	e8 20 07 00 00       	call   18fd <printf>
		//sem_signal(&M); 
		//sem_signal(&C);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    11dd:	a1 f0 21 00 00       	mov    0x21f0,%eax
    11e2:	89 44 24 08          	mov    %eax,0x8(%esp)
    11e6:	c7 44 24 04 b8 20 00 	movl   $0x20b8,0x4(%esp)
    11ed:	00 
    11ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11f5:	e8 03 07 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals on boat: %d.\n",1); 
    11fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1201:	00 
    1202:	c7 44 24 04 e0 20 00 	movl   $0x20e0,0x4(%esp)
    1209:	00 
    120a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1211:	e8 e7 06 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock); 

		RowBoat();
    1216:	e8 a8 02 00 00       	call   14c3 <RowBoat>

		//lock_acquire(&mutex.lock);  
		numMissionaries = numMissionaries - 2; 
    121b:	a1 f0 21 00 00       	mov    0x21f0,%eax
    1220:	83 e8 02             	sub    $0x2,%eax
    1223:	a3 f0 21 00 00       	mov    %eax,0x21f0
		numCannibals--; 
    1228:	a1 f4 21 00 00       	mov    0x21f4,%eax
    122d:	83 e8 01             	sub    $0x1,%eax
    1230:	a3 f4 21 00 00       	mov    %eax,0x21f4
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1235:	a1 f0 21 00 00       	mov    0x21f0,%eax
    123a:	89 44 24 08          	mov    %eax,0x8(%esp)
    123e:	c7 44 24 04 04 21 00 	movl   $0x2104,0x4(%esp)
    1245:	00 
    1246:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124d:	e8 ab 06 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1252:	a1 f4 21 00 00       	mov    0x21f4,%eax
    1257:	89 44 24 08          	mov    %eax,0x8(%esp)
    125b:	c7 44 24 04 2c 21 00 	movl   $0x212c,0x4(%esp)
    1262:	00 
    1263:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    126a:	e8 8e 06 00 00       	call   18fd <printf>
		printf(1,"==============================\n");
    126f:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    1276:	00 
    1277:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    127e:	e8 7a 06 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1283:	eb 2a                	jmp    12af <MissionaryArrives+0x200>
		//texit(); 
			 
	} 
	else {
		//lock_acquire(&mutex.lock); 
		numMissionaries++;
    1285:	a1 f0 21 00 00       	mov    0x21f0,%eax
    128a:	83 c0 01             	add    $0x1,%eax
    128d:	a3 f0 21 00 00       	mov    %eax,0x21f0
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    1292:	a1 f0 21 00 00       	mov    0x21f0,%eax
    1297:	89 44 24 08          	mov    %eax,0x8(%esp)
    129b:	c7 44 24 04 90 20 00 	movl   $0x2090,0x4(%esp)
    12a2:	00 
    12a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12aa:	e8 4e 06 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock); 
		//texit();   
	}
	lock_release(&mutex.lock);
    12af:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    12b6:	e8 50 0a 00 00       	call   1d0b <lock_release>
	texit(); 
    12bb:	e8 44 05 00 00       	call   1804 <texit>

000012c0 <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    12c0:	55                   	push   %ebp
    12c1:	89 e5                	mov    %esp,%ebp
    12c3:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    12c6:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    12cd:	e8 1a 0a 00 00       	call   1cec <lock_acquire>
	if(numCannibals == 2) 
    12d2:	a1 f4 21 00 00       	mov    0x21f4,%eax
    12d7:	83 f8 02             	cmp    $0x2,%eax
    12da:	0f 85 c8 00 00 00    	jne    13a8 <CannibalArrives+0xe8>
	{
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    12e0:	a1 f4 21 00 00       	mov    0x21f4,%eax
    12e5:	83 c0 01             	add    $0x1,%eax
    12e8:	a3 f4 21 00 00       	mov    %eax,0x21f4
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    12ed:	a1 f4 21 00 00       	mov    0x21f4,%eax
    12f2:	89 44 24 08          	mov    %eax,0x8(%esp)
    12f6:	c7 44 24 04 70 21 00 	movl   $0x2170,0x4(%esp)
    12fd:	00 
    12fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1305:	e8 f3 05 00 00       	call   18fd <printf>
 		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    130a:	a1 f4 21 00 00       	mov    0x21f4,%eax
    130f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1313:	c7 44 24 04 e0 20 00 	movl   $0x20e0,0x4(%esp)
    131a:	00 
    131b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1322:	e8 d6 05 00 00       	call   18fd <printf>
		printf(1, "Number of missionaries on boat: %d.\n",0);  
    1327:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    132e:	00 
    132f:	c7 44 24 04 b8 20 00 	movl   $0x20b8,0x4(%esp)
    1336:	00 
    1337:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    133e:	e8 ba 05 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&C); 
		//sem_signal(&C);
		RowBoat(); 
    1343:	e8 7b 01 00 00       	call   14c3 <RowBoat>
 	
		//lock_acquire(&mutex.lock); 
		numCannibals = numCannibals -3;  
    1348:	a1 f4 21 00 00       	mov    0x21f4,%eax
    134d:	83 e8 03             	sub    $0x3,%eax
    1350:	a3 f4 21 00 00       	mov    %eax,0x21f4

		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1355:	a1 f0 21 00 00       	mov    0x21f0,%eax
    135a:	89 44 24 08          	mov    %eax,0x8(%esp)
    135e:	c7 44 24 04 04 21 00 	movl   $0x2104,0x4(%esp)
    1365:	00 
    1366:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    136d:	e8 8b 05 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1372:	a1 f4 21 00 00       	mov    0x21f4,%eax
    1377:	89 44 24 08          	mov    %eax,0x8(%esp)
    137b:	c7 44 24 04 2c 21 00 	movl   $0x212c,0x4(%esp)
    1382:	00 
    1383:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    138a:	e8 6e 05 00 00       	call   18fd <printf>
		printf(1,"==============================\n");  
    138f:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    1396:	00 
    1397:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    139e:	e8 5a 05 00 00       	call   18fd <printf>
    13a3:	e9 0a 01 00 00       	jmp    14b2 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit();	
	}
	else if(numMissionaries == 2) {
    13a8:	a1 f0 21 00 00       	mov    0x21f0,%eax
    13ad:	83 f8 02             	cmp    $0x2,%eax
    13b0:	0f 85 d2 00 00 00    	jne    1488 <CannibalArrives+0x1c8>
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    13b6:	a1 f4 21 00 00       	mov    0x21f4,%eax
    13bb:	83 c0 01             	add    $0x1,%eax
    13be:	a3 f4 21 00 00       	mov    %eax,0x21f4
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    13c3:	a1 f4 21 00 00       	mov    0x21f4,%eax
    13c8:	89 44 24 08          	mov    %eax,0x8(%esp)
    13cc:	c7 44 24 04 70 21 00 	movl   $0x2170,0x4(%esp)
    13d3:	00 
    13d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13db:	e8 1d 05 00 00       	call   18fd <printf>
		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    13e0:	a1 f4 21 00 00       	mov    0x21f4,%eax
    13e5:	89 44 24 08          	mov    %eax,0x8(%esp)
    13e9:	c7 44 24 04 e0 20 00 	movl   $0x20e0,0x4(%esp)
    13f0:	00 
    13f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13f8:	e8 00 05 00 00       	call   18fd <printf>
		printf(1, "Number of missionaries on boat: %d.\n",2);  
    13fd:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1404:	00 
    1405:	c7 44 24 04 b8 20 00 	movl   $0x20b8,0x4(%esp)
    140c:	00 
    140d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1414:	e8 e4 04 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&M);
		//sem_signal(&M); 
		RowBoat();
    1419:	e8 a5 00 00 00       	call   14c3 <RowBoat>

		//lock_acquire(&mutex.lock); 
		numCannibals--; 
    141e:	a1 f4 21 00 00       	mov    0x21f4,%eax
    1423:	83 e8 01             	sub    $0x1,%eax
    1426:	a3 f4 21 00 00       	mov    %eax,0x21f4
		numMissionaries = numMissionaries -2; 
    142b:	a1 f0 21 00 00       	mov    0x21f0,%eax
    1430:	83 e8 02             	sub    $0x2,%eax
    1433:	a3 f0 21 00 00       	mov    %eax,0x21f0
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries); 
    1438:	a1 f0 21 00 00       	mov    0x21f0,%eax
    143d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1441:	c7 44 24 04 04 21 00 	movl   $0x2104,0x4(%esp)
    1448:	00 
    1449:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1450:	e8 a8 04 00 00       	call   18fd <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1455:	a1 f4 21 00 00       	mov    0x21f4,%eax
    145a:	89 44 24 08          	mov    %eax,0x8(%esp)
    145e:	c7 44 24 04 2c 21 00 	movl   $0x212c,0x4(%esp)
    1465:	00 
    1466:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    146d:	e8 8b 04 00 00       	call   18fd <printf>
		printf(1,"==============================\n");  
    1472:	c7 44 24 04 50 21 00 	movl   $0x2150,0x4(%esp)
    1479:	00 
    147a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1481:	e8 77 04 00 00       	call   18fd <printf>
    1486:	eb 2a                	jmp    14b2 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit(); 
	}
	else {
		//lock_acquire(&mutex.lock); 
		numCannibals++; 
    1488:	a1 f4 21 00 00       	mov    0x21f4,%eax
    148d:	83 c0 01             	add    $0x1,%eax
    1490:	a3 f4 21 00 00       	mov    %eax,0x21f4
		printf(1, "Number of cannibals arrived: %d.\n",numCannibals);  
    1495:	a1 f4 21 00 00       	mov    0x21f4,%eax
    149a:	89 44 24 08          	mov    %eax,0x8(%esp)
    149e:	c7 44 24 04 70 21 00 	movl   $0x2170,0x4(%esp)
    14a5:	00 
    14a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ad:	e8 4b 04 00 00       	call   18fd <printf>
		//lock_release(&mutex.lock);
		//texit();  
	}
	lock_release(&mutex.lock); 
    14b2:	c7 04 24 08 22 00 00 	movl   $0x2208,(%esp)
    14b9:	e8 4d 08 00 00       	call   1d0b <lock_release>
	texit(); 
    14be:	e8 41 03 00 00       	call   1804 <texit>

000014c3 <RowBoat>:
} 

void RowBoat() {
    14c3:	55                   	push   %ebp
    14c4:	89 e5                	mov    %esp,%ebp
    14c6:	83 ec 18             	sub    $0x18,%esp
	//lock_acquire(&mutex.lock); 
	//printf(1,"Number of cannibals in boat: %d.\n",numCannibals); 
	//printf(1,"Number of missionaries in boat: %d.\n",numMissionaries); 
	numBoat++; 
    14c9:	a1 f8 21 00 00       	mov    0x21f8,%eax
    14ce:	83 c0 01             	add    $0x1,%eax
    14d1:	a3 f8 21 00 00       	mov    %eax,0x21f8
	printf(1,"Rowing boat: %d.\n",numBoat);
    14d6:	a1 f8 21 00 00       	mov    0x21f8,%eax
    14db:	89 44 24 08          	mov    %eax,0x8(%esp)
    14df:	c7 44 24 04 92 21 00 	movl   $0x2192,0x4(%esp)
    14e6:	00 
    14e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ee:	e8 0a 04 00 00       	call   18fd <printf>
	//lock_release(&mutex.lock); 
	  
} 
    14f3:	c9                   	leave  
    14f4:	c3                   	ret    
    14f5:	90                   	nop
    14f6:	90                   	nop
    14f7:	90                   	nop

000014f8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    14f8:	55                   	push   %ebp
    14f9:	89 e5                	mov    %esp,%ebp
    14fb:	57                   	push   %edi
    14fc:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    14fd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1500:	8b 55 10             	mov    0x10(%ebp),%edx
    1503:	8b 45 0c             	mov    0xc(%ebp),%eax
    1506:	89 cb                	mov    %ecx,%ebx
    1508:	89 df                	mov    %ebx,%edi
    150a:	89 d1                	mov    %edx,%ecx
    150c:	fc                   	cld    
    150d:	f3 aa                	rep stos %al,%es:(%edi)
    150f:	89 ca                	mov    %ecx,%edx
    1511:	89 fb                	mov    %edi,%ebx
    1513:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1516:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1519:	5b                   	pop    %ebx
    151a:	5f                   	pop    %edi
    151b:	5d                   	pop    %ebp
    151c:	c3                   	ret    

0000151d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    151d:	55                   	push   %ebp
    151e:	89 e5                	mov    %esp,%ebp
    1520:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1523:	8b 45 08             	mov    0x8(%ebp),%eax
    1526:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1529:	8b 45 0c             	mov    0xc(%ebp),%eax
    152c:	0f b6 10             	movzbl (%eax),%edx
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	88 10                	mov    %dl,(%eax)
    1534:	8b 45 08             	mov    0x8(%ebp),%eax
    1537:	0f b6 00             	movzbl (%eax),%eax
    153a:	84 c0                	test   %al,%al
    153c:	0f 95 c0             	setne  %al
    153f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1543:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1547:	84 c0                	test   %al,%al
    1549:	75 de                	jne    1529 <strcpy+0xc>
    ;
  return os;
    154b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    154e:	c9                   	leave  
    154f:	c3                   	ret    

00001550 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1553:	eb 08                	jmp    155d <strcmp+0xd>
    p++, q++;
    1555:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1559:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    155d:	8b 45 08             	mov    0x8(%ebp),%eax
    1560:	0f b6 00             	movzbl (%eax),%eax
    1563:	84 c0                	test   %al,%al
    1565:	74 10                	je     1577 <strcmp+0x27>
    1567:	8b 45 08             	mov    0x8(%ebp),%eax
    156a:	0f b6 10             	movzbl (%eax),%edx
    156d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1570:	0f b6 00             	movzbl (%eax),%eax
    1573:	38 c2                	cmp    %al,%dl
    1575:	74 de                	je     1555 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1577:	8b 45 08             	mov    0x8(%ebp),%eax
    157a:	0f b6 00             	movzbl (%eax),%eax
    157d:	0f b6 d0             	movzbl %al,%edx
    1580:	8b 45 0c             	mov    0xc(%ebp),%eax
    1583:	0f b6 00             	movzbl (%eax),%eax
    1586:	0f b6 c0             	movzbl %al,%eax
    1589:	89 d1                	mov    %edx,%ecx
    158b:	29 c1                	sub    %eax,%ecx
    158d:	89 c8                	mov    %ecx,%eax
}
    158f:	5d                   	pop    %ebp
    1590:	c3                   	ret    

00001591 <strlen>:

uint
strlen(char *s)
{
    1591:	55                   	push   %ebp
    1592:	89 e5                	mov    %esp,%ebp
    1594:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1597:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    159e:	eb 04                	jmp    15a4 <strlen+0x13>
    15a0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    15a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15a7:	03 45 08             	add    0x8(%ebp),%eax
    15aa:	0f b6 00             	movzbl (%eax),%eax
    15ad:	84 c0                	test   %al,%al
    15af:	75 ef                	jne    15a0 <strlen+0xf>
    ;
  return n;
    15b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15b4:	c9                   	leave  
    15b5:	c3                   	ret    

000015b6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    15b6:	55                   	push   %ebp
    15b7:	89 e5                	mov    %esp,%ebp
    15b9:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    15bc:	8b 45 10             	mov    0x10(%ebp),%eax
    15bf:	89 44 24 08          	mov    %eax,0x8(%esp)
    15c3:	8b 45 0c             	mov    0xc(%ebp),%eax
    15c6:	89 44 24 04          	mov    %eax,0x4(%esp)
    15ca:	8b 45 08             	mov    0x8(%ebp),%eax
    15cd:	89 04 24             	mov    %eax,(%esp)
    15d0:	e8 23 ff ff ff       	call   14f8 <stosb>
  return dst;
    15d5:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15d8:	c9                   	leave  
    15d9:	c3                   	ret    

000015da <strchr>:

char*
strchr(const char *s, char c)
{
    15da:	55                   	push   %ebp
    15db:	89 e5                	mov    %esp,%ebp
    15dd:	83 ec 04             	sub    $0x4,%esp
    15e0:	8b 45 0c             	mov    0xc(%ebp),%eax
    15e3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    15e6:	eb 14                	jmp    15fc <strchr+0x22>
    if(*s == c)
    15e8:	8b 45 08             	mov    0x8(%ebp),%eax
    15eb:	0f b6 00             	movzbl (%eax),%eax
    15ee:	3a 45 fc             	cmp    -0x4(%ebp),%al
    15f1:	75 05                	jne    15f8 <strchr+0x1e>
      return (char*)s;
    15f3:	8b 45 08             	mov    0x8(%ebp),%eax
    15f6:	eb 13                	jmp    160b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    15f8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15fc:	8b 45 08             	mov    0x8(%ebp),%eax
    15ff:	0f b6 00             	movzbl (%eax),%eax
    1602:	84 c0                	test   %al,%al
    1604:	75 e2                	jne    15e8 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1606:	b8 00 00 00 00       	mov    $0x0,%eax
}
    160b:	c9                   	leave  
    160c:	c3                   	ret    

0000160d <gets>:

char*
gets(char *buf, int max)
{
    160d:	55                   	push   %ebp
    160e:	89 e5                	mov    %esp,%ebp
    1610:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1613:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    161a:	eb 44                	jmp    1660 <gets+0x53>
    cc = read(0, &c, 1);
    161c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1623:	00 
    1624:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1627:	89 44 24 04          	mov    %eax,0x4(%esp)
    162b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1632:	e8 3d 01 00 00       	call   1774 <read>
    1637:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    163a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    163e:	7e 2d                	jle    166d <gets+0x60>
      break;
    buf[i++] = c;
    1640:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1643:	03 45 08             	add    0x8(%ebp),%eax
    1646:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    164a:	88 10                	mov    %dl,(%eax)
    164c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1650:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1654:	3c 0a                	cmp    $0xa,%al
    1656:	74 16                	je     166e <gets+0x61>
    1658:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    165c:	3c 0d                	cmp    $0xd,%al
    165e:	74 0e                	je     166e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1660:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1663:	83 c0 01             	add    $0x1,%eax
    1666:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1669:	7c b1                	jl     161c <gets+0xf>
    166b:	eb 01                	jmp    166e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    166d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    166e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1671:	03 45 08             	add    0x8(%ebp),%eax
    1674:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1677:	8b 45 08             	mov    0x8(%ebp),%eax
}
    167a:	c9                   	leave  
    167b:	c3                   	ret    

0000167c <stat>:

int
stat(char *n, struct stat *st)
{
    167c:	55                   	push   %ebp
    167d:	89 e5                	mov    %esp,%ebp
    167f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1682:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1689:	00 
    168a:	8b 45 08             	mov    0x8(%ebp),%eax
    168d:	89 04 24             	mov    %eax,(%esp)
    1690:	e8 07 01 00 00       	call   179c <open>
    1695:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1698:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    169c:	79 07                	jns    16a5 <stat+0x29>
    return -1;
    169e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    16a3:	eb 23                	jmp    16c8 <stat+0x4c>
  r = fstat(fd, st);
    16a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    16a8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16af:	89 04 24             	mov    %eax,(%esp)
    16b2:	e8 fd 00 00 00       	call   17b4 <fstat>
    16b7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    16ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16bd:	89 04 24             	mov    %eax,(%esp)
    16c0:	e8 bf 00 00 00       	call   1784 <close>
  return r;
    16c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16c8:	c9                   	leave  
    16c9:	c3                   	ret    

000016ca <atoi>:

int
atoi(const char *s)
{
    16ca:	55                   	push   %ebp
    16cb:	89 e5                	mov    %esp,%ebp
    16cd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    16d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    16d7:	eb 24                	jmp    16fd <atoi+0x33>
    n = n*10 + *s++ - '0';
    16d9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    16dc:	89 d0                	mov    %edx,%eax
    16de:	c1 e0 02             	shl    $0x2,%eax
    16e1:	01 d0                	add    %edx,%eax
    16e3:	01 c0                	add    %eax,%eax
    16e5:	89 c2                	mov    %eax,%edx
    16e7:	8b 45 08             	mov    0x8(%ebp),%eax
    16ea:	0f b6 00             	movzbl (%eax),%eax
    16ed:	0f be c0             	movsbl %al,%eax
    16f0:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16f3:	83 e8 30             	sub    $0x30,%eax
    16f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    16fd:	8b 45 08             	mov    0x8(%ebp),%eax
    1700:	0f b6 00             	movzbl (%eax),%eax
    1703:	3c 2f                	cmp    $0x2f,%al
    1705:	7e 0a                	jle    1711 <atoi+0x47>
    1707:	8b 45 08             	mov    0x8(%ebp),%eax
    170a:	0f b6 00             	movzbl (%eax),%eax
    170d:	3c 39                	cmp    $0x39,%al
    170f:	7e c8                	jle    16d9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1711:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1714:	c9                   	leave  
    1715:	c3                   	ret    

00001716 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1716:	55                   	push   %ebp
    1717:	89 e5                	mov    %esp,%ebp
    1719:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1722:	8b 45 0c             	mov    0xc(%ebp),%eax
    1725:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1728:	eb 13                	jmp    173d <memmove+0x27>
    *dst++ = *src++;
    172a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172d:	0f b6 10             	movzbl (%eax),%edx
    1730:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1733:	88 10                	mov    %dl,(%eax)
    1735:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1739:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    173d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1741:	0f 9f c0             	setg   %al
    1744:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1748:	84 c0                	test   %al,%al
    174a:	75 de                	jne    172a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    174c:	8b 45 08             	mov    0x8(%ebp),%eax
}
    174f:	c9                   	leave  
    1750:	c3                   	ret    
    1751:	90                   	nop
    1752:	90                   	nop
    1753:	90                   	nop

00001754 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1754:	b8 01 00 00 00       	mov    $0x1,%eax
    1759:	cd 40                	int    $0x40
    175b:	c3                   	ret    

0000175c <exit>:
SYSCALL(exit)
    175c:	b8 02 00 00 00       	mov    $0x2,%eax
    1761:	cd 40                	int    $0x40
    1763:	c3                   	ret    

00001764 <wait>:
SYSCALL(wait)
    1764:	b8 03 00 00 00       	mov    $0x3,%eax
    1769:	cd 40                	int    $0x40
    176b:	c3                   	ret    

0000176c <pipe>:
SYSCALL(pipe)
    176c:	b8 04 00 00 00       	mov    $0x4,%eax
    1771:	cd 40                	int    $0x40
    1773:	c3                   	ret    

00001774 <read>:
SYSCALL(read)
    1774:	b8 05 00 00 00       	mov    $0x5,%eax
    1779:	cd 40                	int    $0x40
    177b:	c3                   	ret    

0000177c <write>:
SYSCALL(write)
    177c:	b8 10 00 00 00       	mov    $0x10,%eax
    1781:	cd 40                	int    $0x40
    1783:	c3                   	ret    

00001784 <close>:
SYSCALL(close)
    1784:	b8 15 00 00 00       	mov    $0x15,%eax
    1789:	cd 40                	int    $0x40
    178b:	c3                   	ret    

0000178c <kill>:
SYSCALL(kill)
    178c:	b8 06 00 00 00       	mov    $0x6,%eax
    1791:	cd 40                	int    $0x40
    1793:	c3                   	ret    

00001794 <exec>:
SYSCALL(exec)
    1794:	b8 07 00 00 00       	mov    $0x7,%eax
    1799:	cd 40                	int    $0x40
    179b:	c3                   	ret    

0000179c <open>:
SYSCALL(open)
    179c:	b8 0f 00 00 00       	mov    $0xf,%eax
    17a1:	cd 40                	int    $0x40
    17a3:	c3                   	ret    

000017a4 <mknod>:
SYSCALL(mknod)
    17a4:	b8 11 00 00 00       	mov    $0x11,%eax
    17a9:	cd 40                	int    $0x40
    17ab:	c3                   	ret    

000017ac <unlink>:
SYSCALL(unlink)
    17ac:	b8 12 00 00 00       	mov    $0x12,%eax
    17b1:	cd 40                	int    $0x40
    17b3:	c3                   	ret    

000017b4 <fstat>:
SYSCALL(fstat)
    17b4:	b8 08 00 00 00       	mov    $0x8,%eax
    17b9:	cd 40                	int    $0x40
    17bb:	c3                   	ret    

000017bc <link>:
SYSCALL(link)
    17bc:	b8 13 00 00 00       	mov    $0x13,%eax
    17c1:	cd 40                	int    $0x40
    17c3:	c3                   	ret    

000017c4 <mkdir>:
SYSCALL(mkdir)
    17c4:	b8 14 00 00 00       	mov    $0x14,%eax
    17c9:	cd 40                	int    $0x40
    17cb:	c3                   	ret    

000017cc <chdir>:
SYSCALL(chdir)
    17cc:	b8 09 00 00 00       	mov    $0x9,%eax
    17d1:	cd 40                	int    $0x40
    17d3:	c3                   	ret    

000017d4 <dup>:
SYSCALL(dup)
    17d4:	b8 0a 00 00 00       	mov    $0xa,%eax
    17d9:	cd 40                	int    $0x40
    17db:	c3                   	ret    

000017dc <getpid>:
SYSCALL(getpid)
    17dc:	b8 0b 00 00 00       	mov    $0xb,%eax
    17e1:	cd 40                	int    $0x40
    17e3:	c3                   	ret    

000017e4 <sbrk>:
SYSCALL(sbrk)
    17e4:	b8 0c 00 00 00       	mov    $0xc,%eax
    17e9:	cd 40                	int    $0x40
    17eb:	c3                   	ret    

000017ec <sleep>:
SYSCALL(sleep)
    17ec:	b8 0d 00 00 00       	mov    $0xd,%eax
    17f1:	cd 40                	int    $0x40
    17f3:	c3                   	ret    

000017f4 <uptime>:
SYSCALL(uptime)
    17f4:	b8 0e 00 00 00       	mov    $0xe,%eax
    17f9:	cd 40                	int    $0x40
    17fb:	c3                   	ret    

000017fc <clone>:
SYSCALL(clone)
    17fc:	b8 16 00 00 00       	mov    $0x16,%eax
    1801:	cd 40                	int    $0x40
    1803:	c3                   	ret    

00001804 <texit>:
SYSCALL(texit)
    1804:	b8 17 00 00 00       	mov    $0x17,%eax
    1809:	cd 40                	int    $0x40
    180b:	c3                   	ret    

0000180c <tsleep>:
SYSCALL(tsleep)
    180c:	b8 18 00 00 00       	mov    $0x18,%eax
    1811:	cd 40                	int    $0x40
    1813:	c3                   	ret    

00001814 <twakeup>:
SYSCALL(twakeup)
    1814:	b8 19 00 00 00       	mov    $0x19,%eax
    1819:	cd 40                	int    $0x40
    181b:	c3                   	ret    

0000181c <thread_yield>:
SYSCALL(thread_yield) 
    181c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1821:	cd 40                	int    $0x40
    1823:	c3                   	ret    

00001824 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1824:	55                   	push   %ebp
    1825:	89 e5                	mov    %esp,%ebp
    1827:	83 ec 28             	sub    $0x28,%esp
    182a:	8b 45 0c             	mov    0xc(%ebp),%eax
    182d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1830:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1837:	00 
    1838:	8d 45 f4             	lea    -0xc(%ebp),%eax
    183b:	89 44 24 04          	mov    %eax,0x4(%esp)
    183f:	8b 45 08             	mov    0x8(%ebp),%eax
    1842:	89 04 24             	mov    %eax,(%esp)
    1845:	e8 32 ff ff ff       	call   177c <write>
}
    184a:	c9                   	leave  
    184b:	c3                   	ret    

0000184c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    184c:	55                   	push   %ebp
    184d:	89 e5                	mov    %esp,%ebp
    184f:	53                   	push   %ebx
    1850:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1853:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    185a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    185e:	74 17                	je     1877 <printint+0x2b>
    1860:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1864:	79 11                	jns    1877 <printint+0x2b>
    neg = 1;
    1866:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    186d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1870:	f7 d8                	neg    %eax
    1872:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1875:	eb 06                	jmp    187d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1877:	8b 45 0c             	mov    0xc(%ebp),%eax
    187a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    187d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1884:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1887:	8b 5d 10             	mov    0x10(%ebp),%ebx
    188a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188d:	ba 00 00 00 00       	mov    $0x0,%edx
    1892:	f7 f3                	div    %ebx
    1894:	89 d0                	mov    %edx,%eax
    1896:	0f b6 80 d8 21 00 00 	movzbl 0x21d8(%eax),%eax
    189d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    18a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    18a5:	8b 45 10             	mov    0x10(%ebp),%eax
    18a8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    18ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18ae:	ba 00 00 00 00       	mov    $0x0,%edx
    18b3:	f7 75 d4             	divl   -0x2c(%ebp)
    18b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    18b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    18bd:	75 c5                	jne    1884 <printint+0x38>
  if(neg)
    18bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18c3:	74 28                	je     18ed <printint+0xa1>
    buf[i++] = '-';
    18c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18c8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    18cd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    18d1:	eb 1a                	jmp    18ed <printint+0xa1>
    putc(fd, buf[i]);
    18d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18d6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    18db:	0f be c0             	movsbl %al,%eax
    18de:	89 44 24 04          	mov    %eax,0x4(%esp)
    18e2:	8b 45 08             	mov    0x8(%ebp),%eax
    18e5:	89 04 24             	mov    %eax,(%esp)
    18e8:	e8 37 ff ff ff       	call   1824 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18ed:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    18f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18f5:	79 dc                	jns    18d3 <printint+0x87>
    putc(fd, buf[i]);
}
    18f7:	83 c4 44             	add    $0x44,%esp
    18fa:	5b                   	pop    %ebx
    18fb:	5d                   	pop    %ebp
    18fc:	c3                   	ret    

000018fd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    18fd:	55                   	push   %ebp
    18fe:	89 e5                	mov    %esp,%ebp
    1900:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1903:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    190a:	8d 45 0c             	lea    0xc(%ebp),%eax
    190d:	83 c0 04             	add    $0x4,%eax
    1910:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1913:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    191a:	e9 7e 01 00 00       	jmp    1a9d <printf+0x1a0>
    c = fmt[i] & 0xff;
    191f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1922:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1925:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1928:	0f b6 00             	movzbl (%eax),%eax
    192b:	0f be c0             	movsbl %al,%eax
    192e:	25 ff 00 00 00       	and    $0xff,%eax
    1933:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1936:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    193a:	75 2c                	jne    1968 <printf+0x6b>
      if(c == '%'){
    193c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1940:	75 0c                	jne    194e <printf+0x51>
        state = '%';
    1942:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1949:	e9 4b 01 00 00       	jmp    1a99 <printf+0x19c>
      } else {
        putc(fd, c);
    194e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1951:	0f be c0             	movsbl %al,%eax
    1954:	89 44 24 04          	mov    %eax,0x4(%esp)
    1958:	8b 45 08             	mov    0x8(%ebp),%eax
    195b:	89 04 24             	mov    %eax,(%esp)
    195e:	e8 c1 fe ff ff       	call   1824 <putc>
    1963:	e9 31 01 00 00       	jmp    1a99 <printf+0x19c>
      }
    } else if(state == '%'){
    1968:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    196c:	0f 85 27 01 00 00    	jne    1a99 <printf+0x19c>
      if(c == 'd'){
    1972:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1976:	75 2d                	jne    19a5 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1978:	8b 45 f4             	mov    -0xc(%ebp),%eax
    197b:	8b 00                	mov    (%eax),%eax
    197d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1984:	00 
    1985:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    198c:	00 
    198d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1991:	8b 45 08             	mov    0x8(%ebp),%eax
    1994:	89 04 24             	mov    %eax,(%esp)
    1997:	e8 b0 fe ff ff       	call   184c <printint>
        ap++;
    199c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    19a0:	e9 ed 00 00 00       	jmp    1a92 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    19a5:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    19a9:	74 06                	je     19b1 <printf+0xb4>
    19ab:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    19af:	75 2d                	jne    19de <printf+0xe1>
        printint(fd, *ap, 16, 0);
    19b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19b4:	8b 00                	mov    (%eax),%eax
    19b6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    19bd:	00 
    19be:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    19c5:	00 
    19c6:	89 44 24 04          	mov    %eax,0x4(%esp)
    19ca:	8b 45 08             	mov    0x8(%ebp),%eax
    19cd:	89 04 24             	mov    %eax,(%esp)
    19d0:	e8 77 fe ff ff       	call   184c <printint>
        ap++;
    19d5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    19d9:	e9 b4 00 00 00       	jmp    1a92 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    19de:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    19e2:	75 46                	jne    1a2a <printf+0x12d>
        s = (char*)*ap;
    19e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19e7:	8b 00                	mov    (%eax),%eax
    19e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    19ec:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    19f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    19f4:	75 27                	jne    1a1d <printf+0x120>
          s = "(null)";
    19f6:	c7 45 e4 a4 21 00 00 	movl   $0x21a4,-0x1c(%ebp)
        while(*s != 0){
    19fd:	eb 1f                	jmp    1a1e <printf+0x121>
          putc(fd, *s);
    19ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a02:	0f b6 00             	movzbl (%eax),%eax
    1a05:	0f be c0             	movsbl %al,%eax
    1a08:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a0f:	89 04 24             	mov    %eax,(%esp)
    1a12:	e8 0d fe ff ff       	call   1824 <putc>
          s++;
    1a17:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1a1b:	eb 01                	jmp    1a1e <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1a1d:	90                   	nop
    1a1e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1a21:	0f b6 00             	movzbl (%eax),%eax
    1a24:	84 c0                	test   %al,%al
    1a26:	75 d7                	jne    19ff <printf+0x102>
    1a28:	eb 68                	jmp    1a92 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1a2a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1a2e:	75 1d                	jne    1a4d <printf+0x150>
        putc(fd, *ap);
    1a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a33:	8b 00                	mov    (%eax),%eax
    1a35:	0f be c0             	movsbl %al,%eax
    1a38:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a3c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3f:	89 04 24             	mov    %eax,(%esp)
    1a42:	e8 dd fd ff ff       	call   1824 <putc>
        ap++;
    1a47:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1a4b:	eb 45                	jmp    1a92 <printf+0x195>
      } else if(c == '%'){
    1a4d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1a51:	75 17                	jne    1a6a <printf+0x16d>
        putc(fd, c);
    1a53:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a56:	0f be c0             	movsbl %al,%eax
    1a59:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a5d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a60:	89 04 24             	mov    %eax,(%esp)
    1a63:	e8 bc fd ff ff       	call   1824 <putc>
    1a68:	eb 28                	jmp    1a92 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1a6a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1a71:	00 
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	89 04 24             	mov    %eax,(%esp)
    1a78:	e8 a7 fd ff ff       	call   1824 <putc>
        putc(fd, c);
    1a7d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a80:	0f be c0             	movsbl %al,%eax
    1a83:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a87:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8a:	89 04 24             	mov    %eax,(%esp)
    1a8d:	e8 92 fd ff ff       	call   1824 <putc>
      }
      state = 0;
    1a92:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1a99:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a9d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1aa0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1aa3:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1aa6:	0f b6 00             	movzbl (%eax),%eax
    1aa9:	84 c0                	test   %al,%al
    1aab:	0f 85 6e fe ff ff    	jne    191f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1ab1:	c9                   	leave  
    1ab2:	c3                   	ret    
    1ab3:	90                   	nop

00001ab4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1ab4:	55                   	push   %ebp
    1ab5:	89 e5                	mov    %esp,%ebp
    1ab7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1aba:	8b 45 08             	mov    0x8(%ebp),%eax
    1abd:	83 e8 08             	sub    $0x8,%eax
    1ac0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ac3:	a1 04 22 00 00       	mov    0x2204,%eax
    1ac8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1acb:	eb 24                	jmp    1af1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1acd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ad0:	8b 00                	mov    (%eax),%eax
    1ad2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ad5:	77 12                	ja     1ae9 <free+0x35>
    1ad7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ada:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1add:	77 24                	ja     1b03 <free+0x4f>
    1adf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ae2:	8b 00                	mov    (%eax),%eax
    1ae4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ae7:	77 1a                	ja     1b03 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ae9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aec:	8b 00                	mov    (%eax),%eax
    1aee:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1af1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1af4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1af7:	76 d4                	jbe    1acd <free+0x19>
    1af9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1afc:	8b 00                	mov    (%eax),%eax
    1afe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b01:	76 ca                	jbe    1acd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1b03:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b06:	8b 40 04             	mov    0x4(%eax),%eax
    1b09:	c1 e0 03             	shl    $0x3,%eax
    1b0c:	89 c2                	mov    %eax,%edx
    1b0e:	03 55 f8             	add    -0x8(%ebp),%edx
    1b11:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b14:	8b 00                	mov    (%eax),%eax
    1b16:	39 c2                	cmp    %eax,%edx
    1b18:	75 24                	jne    1b3e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1b1a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b1d:	8b 50 04             	mov    0x4(%eax),%edx
    1b20:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b23:	8b 00                	mov    (%eax),%eax
    1b25:	8b 40 04             	mov    0x4(%eax),%eax
    1b28:	01 c2                	add    %eax,%edx
    1b2a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b2d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b30:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b33:	8b 00                	mov    (%eax),%eax
    1b35:	8b 10                	mov    (%eax),%edx
    1b37:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b3a:	89 10                	mov    %edx,(%eax)
    1b3c:	eb 0a                	jmp    1b48 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1b3e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b41:	8b 10                	mov    (%eax),%edx
    1b43:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b46:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1b48:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b4b:	8b 40 04             	mov    0x4(%eax),%eax
    1b4e:	c1 e0 03             	shl    $0x3,%eax
    1b51:	03 45 fc             	add    -0x4(%ebp),%eax
    1b54:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b57:	75 20                	jne    1b79 <free+0xc5>
    p->s.size += bp->s.size;
    1b59:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b5c:	8b 50 04             	mov    0x4(%eax),%edx
    1b5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b62:	8b 40 04             	mov    0x4(%eax),%eax
    1b65:	01 c2                	add    %eax,%edx
    1b67:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b6a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b70:	8b 10                	mov    (%eax),%edx
    1b72:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b75:	89 10                	mov    %edx,(%eax)
    1b77:	eb 08                	jmp    1b81 <free+0xcd>
  } else
    p->s.ptr = bp;
    1b79:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b7c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1b7f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1b81:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b84:	a3 04 22 00 00       	mov    %eax,0x2204
}
    1b89:	c9                   	leave  
    1b8a:	c3                   	ret    

00001b8b <morecore>:

static Header*
morecore(uint nu)
{
    1b8b:	55                   	push   %ebp
    1b8c:	89 e5                	mov    %esp,%ebp
    1b8e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1b91:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1b98:	77 07                	ja     1ba1 <morecore+0x16>
    nu = 4096;
    1b9a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1ba1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba4:	c1 e0 03             	shl    $0x3,%eax
    1ba7:	89 04 24             	mov    %eax,(%esp)
    1baa:	e8 35 fc ff ff       	call   17e4 <sbrk>
    1baf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1bb2:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1bb6:	75 07                	jne    1bbf <morecore+0x34>
    return 0;
    1bb8:	b8 00 00 00 00       	mov    $0x0,%eax
    1bbd:	eb 22                	jmp    1be1 <morecore+0x56>
  hp = (Header*)p;
    1bbf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1bc5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc8:	8b 55 08             	mov    0x8(%ebp),%edx
    1bcb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd1:	83 c0 08             	add    $0x8,%eax
    1bd4:	89 04 24             	mov    %eax,(%esp)
    1bd7:	e8 d8 fe ff ff       	call   1ab4 <free>
  return freep;
    1bdc:	a1 04 22 00 00       	mov    0x2204,%eax
}
    1be1:	c9                   	leave  
    1be2:	c3                   	ret    

00001be3 <malloc>:

void*
malloc(uint nbytes)
{
    1be3:	55                   	push   %ebp
    1be4:	89 e5                	mov    %esp,%ebp
    1be6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1be9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bec:	83 c0 07             	add    $0x7,%eax
    1bef:	c1 e8 03             	shr    $0x3,%eax
    1bf2:	83 c0 01             	add    $0x1,%eax
    1bf5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1bf8:	a1 04 22 00 00       	mov    0x2204,%eax
    1bfd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c00:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c04:	75 23                	jne    1c29 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1c06:	c7 45 f0 fc 21 00 00 	movl   $0x21fc,-0x10(%ebp)
    1c0d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c10:	a3 04 22 00 00       	mov    %eax,0x2204
    1c15:	a1 04 22 00 00       	mov    0x2204,%eax
    1c1a:	a3 fc 21 00 00       	mov    %eax,0x21fc
    base.s.size = 0;
    1c1f:	c7 05 00 22 00 00 00 	movl   $0x0,0x2200
    1c26:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c2c:	8b 00                	mov    (%eax),%eax
    1c2e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1c31:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c34:	8b 40 04             	mov    0x4(%eax),%eax
    1c37:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c3a:	72 4d                	jb     1c89 <malloc+0xa6>
      if(p->s.size == nunits)
    1c3c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c3f:	8b 40 04             	mov    0x4(%eax),%eax
    1c42:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c45:	75 0c                	jne    1c53 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1c47:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c4a:	8b 10                	mov    (%eax),%edx
    1c4c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c4f:	89 10                	mov    %edx,(%eax)
    1c51:	eb 26                	jmp    1c79 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1c53:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c56:	8b 40 04             	mov    0x4(%eax),%eax
    1c59:	89 c2                	mov    %eax,%edx
    1c5b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1c5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c61:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1c64:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c67:	8b 40 04             	mov    0x4(%eax),%eax
    1c6a:	c1 e0 03             	shl    $0x3,%eax
    1c6d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1c70:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c73:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c76:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1c79:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c7c:	a3 04 22 00 00       	mov    %eax,0x2204
      return (void*)(p + 1);
    1c81:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c84:	83 c0 08             	add    $0x8,%eax
    1c87:	eb 38                	jmp    1cc1 <malloc+0xde>
    }
    if(p == freep)
    1c89:	a1 04 22 00 00       	mov    0x2204,%eax
    1c8e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1c91:	75 1b                	jne    1cae <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1c93:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c96:	89 04 24             	mov    %eax,(%esp)
    1c99:	e8 ed fe ff ff       	call   1b8b <morecore>
    1c9e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1ca1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ca5:	75 07                	jne    1cae <malloc+0xcb>
        return 0;
    1ca7:	b8 00 00 00 00       	mov    $0x0,%eax
    1cac:	eb 13                	jmp    1cc1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1cae:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1cb4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1cb7:	8b 00                	mov    (%eax),%eax
    1cb9:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1cbc:	e9 70 ff ff ff       	jmp    1c31 <malloc+0x4e>
}
    1cc1:	c9                   	leave  
    1cc2:	c3                   	ret    
    1cc3:	90                   	nop

00001cc4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1cc4:	55                   	push   %ebp
    1cc5:	89 e5                	mov    %esp,%ebp
    1cc7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1cca:	8b 55 08             	mov    0x8(%ebp),%edx
    1ccd:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cd0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cd3:	f0 87 02             	lock xchg %eax,(%edx)
    1cd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1cd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1cdc:	c9                   	leave  
    1cdd:	c3                   	ret    

00001cde <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1cde:	55                   	push   %ebp
    1cdf:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1ce1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1cea:	5d                   	pop    %ebp
    1ceb:	c3                   	ret    

00001cec <lock_acquire>:
void lock_acquire(lock_t *lock){
    1cec:	55                   	push   %ebp
    1ced:	89 e5                	mov    %esp,%ebp
    1cef:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1cf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1cfc:	00 
    1cfd:	89 04 24             	mov    %eax,(%esp)
    1d00:	e8 bf ff ff ff       	call   1cc4 <xchg>
    1d05:	85 c0                	test   %eax,%eax
    1d07:	75 e9                	jne    1cf2 <lock_acquire+0x6>
}
    1d09:	c9                   	leave  
    1d0a:	c3                   	ret    

00001d0b <lock_release>:
void lock_release(lock_t *lock){
    1d0b:	55                   	push   %ebp
    1d0c:	89 e5                	mov    %esp,%ebp
    1d0e:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1d11:	8b 45 08             	mov    0x8(%ebp),%eax
    1d14:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1d1b:	00 
    1d1c:	89 04 24             	mov    %eax,(%esp)
    1d1f:	e8 a0 ff ff ff       	call   1cc4 <xchg>
}
    1d24:	c9                   	leave  
    1d25:	c3                   	ret    

00001d26 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1d26:	55                   	push   %ebp
    1d27:	89 e5                	mov    %esp,%ebp
    1d29:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1d2c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1d33:	e8 ab fe ff ff       	call   1be3 <malloc>
    1d38:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1d3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1d41:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d44:	25 ff 0f 00 00       	and    $0xfff,%eax
    1d49:	85 c0                	test   %eax,%eax
    1d4b:	74 15                	je     1d62 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1d4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d50:	89 c2                	mov    %eax,%edx
    1d52:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1d58:	b8 00 10 00 00       	mov    $0x1000,%eax
    1d5d:	29 d0                	sub    %edx,%eax
    1d5f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1d62:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d66:	75 1b                	jne    1d83 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1d68:	c7 44 24 04 ab 21 00 	movl   $0x21ab,0x4(%esp)
    1d6f:	00 
    1d70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d77:	e8 81 fb ff ff       	call   18fd <printf>
        return 0;
    1d7c:	b8 00 00 00 00       	mov    $0x0,%eax
    1d81:	eb 6f                	jmp    1df2 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1d83:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1d86:	8b 55 08             	mov    0x8(%ebp),%edx
    1d89:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d8c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1d90:	89 54 24 08          	mov    %edx,0x8(%esp)
    1d94:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1d9b:	00 
    1d9c:	89 04 24             	mov    %eax,(%esp)
    1d9f:	e8 58 fa ff ff       	call   17fc <clone>
    1da4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1da7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dab:	79 1b                	jns    1dc8 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1dad:	c7 44 24 04 b9 21 00 	movl   $0x21b9,0x4(%esp)
    1db4:	00 
    1db5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dbc:	e8 3c fb ff ff       	call   18fd <printf>
        return 0;
    1dc1:	b8 00 00 00 00       	mov    $0x0,%eax
    1dc6:	eb 2a                	jmp    1df2 <thread_create+0xcc>
    }
    if(tid > 0){
    1dc8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dcc:	7e 05                	jle    1dd3 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1dce:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dd1:	eb 1f                	jmp    1df2 <thread_create+0xcc>
    }
    if(tid == 0){
    1dd3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dd7:	75 14                	jne    1ded <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1dd9:	c7 44 24 04 c6 21 00 	movl   $0x21c6,0x4(%esp)
    1de0:	00 
    1de1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1de8:	e8 10 fb ff ff       	call   18fd <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ded:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1df2:	c9                   	leave  
    1df3:	c3                   	ret    

00001df4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1df4:	55                   	push   %ebp
    1df5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1df7:	a1 ec 21 00 00       	mov    0x21ec,%eax
    1dfc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1e02:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1e07:	a3 ec 21 00 00       	mov    %eax,0x21ec
    return (int)(rands % max);
    1e0c:	a1 ec 21 00 00       	mov    0x21ec,%eax
    1e11:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e14:	ba 00 00 00 00       	mov    $0x0,%edx
    1e19:	f7 f1                	div    %ecx
    1e1b:	89 d0                	mov    %edx,%eax
}
    1e1d:	5d                   	pop    %ebp
    1e1e:	c3                   	ret    
    1e1f:	90                   	nop

00001e20 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1e20:	55                   	push   %ebp
    1e21:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1e23:	8b 45 08             	mov    0x8(%ebp),%eax
    1e26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1e2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e2f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1e36:	8b 45 08             	mov    0x8(%ebp),%eax
    1e39:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1e40:	5d                   	pop    %ebp
    1e41:	c3                   	ret    

00001e42 <add_q>:

void add_q(struct queue *q, int v){
    1e42:	55                   	push   %ebp
    1e43:	89 e5                	mov    %esp,%ebp
    1e45:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1e48:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1e4f:	e8 8f fd ff ff       	call   1be3 <malloc>
    1e54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1e57:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e5a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e64:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e67:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1e69:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6c:	8b 40 04             	mov    0x4(%eax),%eax
    1e6f:	85 c0                	test   %eax,%eax
    1e71:	75 0b                	jne    1e7e <add_q+0x3c>
        q->head = n;
    1e73:	8b 45 08             	mov    0x8(%ebp),%eax
    1e76:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e79:	89 50 04             	mov    %edx,0x4(%eax)
    1e7c:	eb 0c                	jmp    1e8a <add_q+0x48>
    }else{
        q->tail->next = n;
    1e7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1e81:	8b 40 08             	mov    0x8(%eax),%eax
    1e84:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e87:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1e8a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e90:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1e93:	8b 45 08             	mov    0x8(%ebp),%eax
    1e96:	8b 00                	mov    (%eax),%eax
    1e98:	8d 50 01             	lea    0x1(%eax),%edx
    1e9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e9e:	89 10                	mov    %edx,(%eax)
}
    1ea0:	c9                   	leave  
    1ea1:	c3                   	ret    

00001ea2 <empty_q>:

int empty_q(struct queue *q){
    1ea2:	55                   	push   %ebp
    1ea3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1ea5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea8:	8b 00                	mov    (%eax),%eax
    1eaa:	85 c0                	test   %eax,%eax
    1eac:	75 07                	jne    1eb5 <empty_q+0x13>
        return 1;
    1eae:	b8 01 00 00 00       	mov    $0x1,%eax
    1eb3:	eb 05                	jmp    1eba <empty_q+0x18>
    else
        return 0;
    1eb5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1eba:	5d                   	pop    %ebp
    1ebb:	c3                   	ret    

00001ebc <pop_q>:
int pop_q(struct queue *q){
    1ebc:	55                   	push   %ebp
    1ebd:	89 e5                	mov    %esp,%ebp
    1ebf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1ec2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec5:	89 04 24             	mov    %eax,(%esp)
    1ec8:	e8 d5 ff ff ff       	call   1ea2 <empty_q>
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	75 5d                	jne    1f2e <pop_q+0x72>
       val = q->head->value; 
    1ed1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ed4:	8b 40 04             	mov    0x4(%eax),%eax
    1ed7:	8b 00                	mov    (%eax),%eax
    1ed9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1edc:	8b 45 08             	mov    0x8(%ebp),%eax
    1edf:	8b 40 04             	mov    0x4(%eax),%eax
    1ee2:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1ee5:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee8:	8b 40 04             	mov    0x4(%eax),%eax
    1eeb:	8b 50 04             	mov    0x4(%eax),%edx
    1eee:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ef4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ef7:	89 04 24             	mov    %eax,(%esp)
    1efa:	e8 b5 fb ff ff       	call   1ab4 <free>
       q->size--;
    1eff:	8b 45 08             	mov    0x8(%ebp),%eax
    1f02:	8b 00                	mov    (%eax),%eax
    1f04:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f07:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1f0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f0f:	8b 00                	mov    (%eax),%eax
    1f11:	85 c0                	test   %eax,%eax
    1f13:	75 14                	jne    1f29 <pop_q+0x6d>
            q->head = 0;
    1f15:	8b 45 08             	mov    0x8(%ebp),%eax
    1f18:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1f1f:	8b 45 08             	mov    0x8(%ebp),%eax
    1f22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1f29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f2c:	eb 05                	jmp    1f33 <pop_q+0x77>
    }
    return -1;
    1f2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1f33:	c9                   	leave  
    1f34:	c3                   	ret    
    1f35:	90                   	nop
    1f36:	90                   	nop
    1f37:	90                   	nop

00001f38 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1f38:	55                   	push   %ebp
    1f39:	89 e5                	mov    %esp,%ebp
    1f3b:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1f3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f41:	89 04 24             	mov    %eax,(%esp)
    1f44:	e8 a3 fd ff ff       	call   1cec <lock_acquire>
	s->count--; 
    1f49:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4c:	8b 40 04             	mov    0x4(%eax),%eax
    1f4f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f52:	8b 45 08             	mov    0x8(%ebp),%eax
    1f55:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1f58:	8b 45 08             	mov    0x8(%ebp),%eax
    1f5b:	8b 40 04             	mov    0x4(%eax),%eax
    1f5e:	85 c0                	test   %eax,%eax
    1f60:	79 27                	jns    1f89 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1f62:	e8 75 f8 ff ff       	call   17dc <getpid>
    1f67:	8b 55 08             	mov    0x8(%ebp),%edx
    1f6a:	83 c2 08             	add    $0x8,%edx
    1f6d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f71:	89 14 24             	mov    %edx,(%esp)
    1f74:	e8 c9 fe ff ff       	call   1e42 <add_q>
		lock_release(&s->lock); 
    1f79:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7c:	89 04 24             	mov    %eax,(%esp)
    1f7f:	e8 87 fd ff ff       	call   1d0b <lock_release>
		tsleep(); 
    1f84:	e8 83 f8 ff ff       	call   180c <tsleep>
	} 
	lock_release(&s->lock); 
    1f89:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8c:	89 04 24             	mov    %eax,(%esp)
    1f8f:	e8 77 fd ff ff       	call   1d0b <lock_release>
}
    1f94:	c9                   	leave  
    1f95:	c3                   	ret    

00001f96 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1f96:	55                   	push   %ebp
    1f97:	89 e5                	mov    %esp,%ebp
    1f99:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1f9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9f:	89 04 24             	mov    %eax,(%esp)
    1fa2:	e8 45 fd ff ff       	call   1cec <lock_acquire>
	s->count++; 
    1fa7:	8b 45 08             	mov    0x8(%ebp),%eax
    1faa:	8b 40 04             	mov    0x4(%eax),%eax
    1fad:	8d 50 01             	lea    0x1(%eax),%edx
    1fb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb3:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1fb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb9:	8b 40 04             	mov    0x4(%eax),%eax
    1fbc:	85 c0                	test   %eax,%eax
    1fbe:	7f 1c                	jg     1fdc <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1fc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc3:	83 c0 08             	add    $0x8,%eax
    1fc6:	89 04 24             	mov    %eax,(%esp)
    1fc9:	e8 ee fe ff ff       	call   1ebc <pop_q>
    1fce:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fd4:	89 04 24             	mov    %eax,(%esp)
    1fd7:	e8 38 f8 ff ff       	call   1814 <twakeup>
	}
	lock_release(&s->lock); 
    1fdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdf:	89 04 24             	mov    %eax,(%esp)
    1fe2:	e8 24 fd ff ff       	call   1d0b <lock_release>
} 
    1fe7:	c9                   	leave  
    1fe8:	c3                   	ret    

00001fe9 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1fe9:	55                   	push   %ebp
    1fea:	89 e5                	mov    %esp,%ebp
    1fec:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1fef:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff2:	89 04 24             	mov    %eax,(%esp)
    1ff5:	e8 e4 fc ff ff       	call   1cde <lock_init>
	s->count = size; 
    1ffa:	8b 45 08             	mov    0x8(%ebp),%eax
    1ffd:	8b 55 0c             	mov    0xc(%ebp),%edx
    2000:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    2003:	8b 45 08             	mov    0x8(%ebp),%eax
    2006:	83 c0 08             	add    $0x8,%eax
    2009:	89 04 24             	mov    %eax,(%esp)
    200c:	e8 0f fe ff ff       	call   1e20 <init_q>
}
    2011:	c9                   	leave  
    2012:	c3                   	ret    
