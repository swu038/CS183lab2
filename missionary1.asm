
_missionary1:     file format elf32-i386


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
    1009:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    1010:	e8 b3 0c 00 00       	call   1cc8 <lock_acquire>
	printf(1,"Created 1 missionary, and 1 Cannibal. There should be no boat rides since there are not enough people. \n"); 
    1015:	c7 44 24 04 f0 1f 00 	movl   $0x1ff0,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 b0 08 00 00       	call   18d9 <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    1030:	e8 b2 0c 00 00       	call   1ce7 <lock_release>
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 8b 10 00 00 	movl   $0x108b,(%esp)
    1044:	e8 b9 0c 00 00       	call   1d02 <thread_create>
    1049:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid == 0) exit(); 
    104d:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1052:	75 05                	jne    1059 <main+0x59>
    1054:	e8 df 06 00 00       	call   1738 <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    1059:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1060:	00 
    1061:	c7 04 24 9c 12 00 00 	movl   $0x129c,(%esp)
    1068:	e8 95 0c 00 00       	call   1d02 <thread_create>
    106d:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(cid == 0) exit(); 
    1071:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1076:	75 05                	jne    107d <main+0x7d>
    1078:	e8 bb 06 00 00       	call   1738 <exit>

	while(wait() > 0); 
    107d:	e8 be 06 00 00       	call   1740 <wait>
    1082:	85 c0                	test   %eax,%eax
    1084:	7f f7                	jg     107d <main+0x7d>

	exit(); 
    1086:	e8 ad 06 00 00       	call   1738 <exit>

0000108b <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    108b:	55                   	push   %ebp
    108c:	89 e5                	mov    %esp,%ebp
    108e:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1091:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    1098:	e8 2b 0c 00 00       	call   1cc8 <lock_acquire>
	if(numMissionaries == 2) 
    109d:	a1 bc 21 00 00       	mov    0x21bc,%eax
    10a2:	83 f8 02             	cmp    $0x2,%eax
    10a5:	0f 85 c8 00 00 00    	jne    1173 <MissionaryArrives+0xe8>
	{
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    10ab:	a1 bc 21 00 00       	mov    0x21bc,%eax
    10b0:	83 c0 01             	add    $0x1,%eax
    10b3:	a3 bc 21 00 00       	mov    %eax,0x21bc
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    10b8:	a1 bc 21 00 00       	mov    0x21bc,%eax
    10bd:	89 44 24 08          	mov    %eax,0x8(%esp)
    10c1:	c7 44 24 04 5c 20 00 	movl   $0x205c,0x4(%esp)
    10c8:	00 
    10c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10d0:	e8 04 08 00 00       	call   18d9 <printf>
		//sem_signal(&M); 
		//sem_signal(&M);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    10d5:	a1 bc 21 00 00       	mov    0x21bc,%eax
    10da:	89 44 24 08          	mov    %eax,0x8(%esp)
    10de:	c7 44 24 04 84 20 00 	movl   $0x2084,0x4(%esp)
    10e5:	00 
    10e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ed:	e8 e7 07 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals on boat: %d.\n",0);  
    10f2:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    10f9:	00 
    10fa:	c7 44 24 04 ac 20 00 	movl   $0x20ac,0x4(%esp)
    1101:	00 
    1102:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1109:	e8 cb 07 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock);
 
		RowBoat();
    110e:	e8 8c 03 00 00       	call   149f <RowBoat>

		//lock_acquire(&mutex.lock);	 
		numMissionaries = numMissionaries - 3;
    1113:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1118:	83 e8 03             	sub    $0x3,%eax
    111b:	a3 bc 21 00 00       	mov    %eax,0x21bc
		
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1120:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1125:	89 44 24 08          	mov    %eax,0x8(%esp)
    1129:	c7 44 24 04 d0 20 00 	movl   $0x20d0,0x4(%esp)
    1130:	00 
    1131:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1138:	e8 9c 07 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    113d:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1142:	89 44 24 08          	mov    %eax,0x8(%esp)
    1146:	c7 44 24 04 f8 20 00 	movl   $0x20f8,0x4(%esp)
    114d:	00 
    114e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1155:	e8 7f 07 00 00       	call   18d9 <printf>
		printf(1,"==============================\n");  
    115a:	c7 44 24 04 1c 21 00 	movl   $0x211c,0x4(%esp)
    1161:	00 
    1162:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1169:	e8 6b 07 00 00       	call   18d9 <printf>
    116e:	e9 18 01 00 00       	jmp    128b <MissionaryArrives+0x200>
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1173:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1178:	83 f8 01             	cmp    $0x1,%eax
    117b:	0f 85 e0 00 00 00    	jne    1261 <MissionaryArrives+0x1d6>
    1181:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1186:	83 f8 01             	cmp    $0x1,%eax
    1189:	0f 85 d2 00 00 00    	jne    1261 <MissionaryArrives+0x1d6>
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    118f:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1194:	83 c0 01             	add    $0x1,%eax
    1197:	a3 bc 21 00 00       	mov    %eax,0x21bc
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    119c:	a1 bc 21 00 00       	mov    0x21bc,%eax
    11a1:	89 44 24 08          	mov    %eax,0x8(%esp)
    11a5:	c7 44 24 04 5c 20 00 	movl   $0x205c,0x4(%esp)
    11ac:	00 
    11ad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11b4:	e8 20 07 00 00       	call   18d9 <printf>
		//sem_signal(&M); 
		//sem_signal(&C);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    11b9:	a1 bc 21 00 00       	mov    0x21bc,%eax
    11be:	89 44 24 08          	mov    %eax,0x8(%esp)
    11c2:	c7 44 24 04 84 20 00 	movl   $0x2084,0x4(%esp)
    11c9:	00 
    11ca:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11d1:	e8 03 07 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals on boat: %d.\n",1); 
    11d6:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    11dd:	00 
    11de:	c7 44 24 04 ac 20 00 	movl   $0x20ac,0x4(%esp)
    11e5:	00 
    11e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11ed:	e8 e7 06 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock); 

		RowBoat();
    11f2:	e8 a8 02 00 00       	call   149f <RowBoat>

		//lock_acquire(&mutex.lock);  
		numMissionaries = numMissionaries - 2; 
    11f7:	a1 bc 21 00 00       	mov    0x21bc,%eax
    11fc:	83 e8 02             	sub    $0x2,%eax
    11ff:	a3 bc 21 00 00       	mov    %eax,0x21bc
		numCannibals--; 
    1204:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1209:	83 e8 01             	sub    $0x1,%eax
    120c:	a3 c0 21 00 00       	mov    %eax,0x21c0
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1211:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1216:	89 44 24 08          	mov    %eax,0x8(%esp)
    121a:	c7 44 24 04 d0 20 00 	movl   $0x20d0,0x4(%esp)
    1221:	00 
    1222:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1229:	e8 ab 06 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    122e:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1233:	89 44 24 08          	mov    %eax,0x8(%esp)
    1237:	c7 44 24 04 f8 20 00 	movl   $0x20f8,0x4(%esp)
    123e:	00 
    123f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1246:	e8 8e 06 00 00       	call   18d9 <printf>
		printf(1,"==============================\n");
    124b:	c7 44 24 04 1c 21 00 	movl   $0x211c,0x4(%esp)
    1252:	00 
    1253:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    125a:	e8 7a 06 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    125f:	eb 2a                	jmp    128b <MissionaryArrives+0x200>
		//texit(); 
			 
	} 
	else {
		//lock_acquire(&mutex.lock); 
		numMissionaries++;
    1261:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1266:	83 c0 01             	add    $0x1,%eax
    1269:	a3 bc 21 00 00       	mov    %eax,0x21bc
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    126e:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1273:	89 44 24 08          	mov    %eax,0x8(%esp)
    1277:	c7 44 24 04 5c 20 00 	movl   $0x205c,0x4(%esp)
    127e:	00 
    127f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1286:	e8 4e 06 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock); 
		//texit();   
	}
	lock_release(&mutex.lock);
    128b:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    1292:	e8 50 0a 00 00       	call   1ce7 <lock_release>
	texit(); 
    1297:	e8 44 05 00 00       	call   17e0 <texit>

0000129c <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    129c:	55                   	push   %ebp
    129d:	89 e5                	mov    %esp,%ebp
    129f:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    12a2:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    12a9:	e8 1a 0a 00 00       	call   1cc8 <lock_acquire>
	if(numCannibals == 2) 
    12ae:	a1 c0 21 00 00       	mov    0x21c0,%eax
    12b3:	83 f8 02             	cmp    $0x2,%eax
    12b6:	0f 85 c8 00 00 00    	jne    1384 <CannibalArrives+0xe8>
	{
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    12bc:	a1 c0 21 00 00       	mov    0x21c0,%eax
    12c1:	83 c0 01             	add    $0x1,%eax
    12c4:	a3 c0 21 00 00       	mov    %eax,0x21c0
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    12c9:	a1 c0 21 00 00       	mov    0x21c0,%eax
    12ce:	89 44 24 08          	mov    %eax,0x8(%esp)
    12d2:	c7 44 24 04 3c 21 00 	movl   $0x213c,0x4(%esp)
    12d9:	00 
    12da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12e1:	e8 f3 05 00 00       	call   18d9 <printf>
 		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    12e6:	a1 c0 21 00 00       	mov    0x21c0,%eax
    12eb:	89 44 24 08          	mov    %eax,0x8(%esp)
    12ef:	c7 44 24 04 ac 20 00 	movl   $0x20ac,0x4(%esp)
    12f6:	00 
    12f7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12fe:	e8 d6 05 00 00       	call   18d9 <printf>
		printf(1, "Number of missionaries on boat: %d.\n",0);  
    1303:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    130a:	00 
    130b:	c7 44 24 04 84 20 00 	movl   $0x2084,0x4(%esp)
    1312:	00 
    1313:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    131a:	e8 ba 05 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&C); 
		//sem_signal(&C);
		RowBoat(); 
    131f:	e8 7b 01 00 00       	call   149f <RowBoat>
 	
		//lock_acquire(&mutex.lock); 
		numCannibals = numCannibals -3;  
    1324:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1329:	83 e8 03             	sub    $0x3,%eax
    132c:	a3 c0 21 00 00       	mov    %eax,0x21c0

		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1331:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1336:	89 44 24 08          	mov    %eax,0x8(%esp)
    133a:	c7 44 24 04 d0 20 00 	movl   $0x20d0,0x4(%esp)
    1341:	00 
    1342:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1349:	e8 8b 05 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    134e:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1353:	89 44 24 08          	mov    %eax,0x8(%esp)
    1357:	c7 44 24 04 f8 20 00 	movl   $0x20f8,0x4(%esp)
    135e:	00 
    135f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1366:	e8 6e 05 00 00       	call   18d9 <printf>
		printf(1,"==============================\n");  
    136b:	c7 44 24 04 1c 21 00 	movl   $0x211c,0x4(%esp)
    1372:	00 
    1373:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137a:	e8 5a 05 00 00       	call   18d9 <printf>
    137f:	e9 0a 01 00 00       	jmp    148e <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit();	
	}
	else if(numMissionaries == 2) {
    1384:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1389:	83 f8 02             	cmp    $0x2,%eax
    138c:	0f 85 d2 00 00 00    	jne    1464 <CannibalArrives+0x1c8>
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    1392:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1397:	83 c0 01             	add    $0x1,%eax
    139a:	a3 c0 21 00 00       	mov    %eax,0x21c0
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    139f:	a1 c0 21 00 00       	mov    0x21c0,%eax
    13a4:	89 44 24 08          	mov    %eax,0x8(%esp)
    13a8:	c7 44 24 04 3c 21 00 	movl   $0x213c,0x4(%esp)
    13af:	00 
    13b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13b7:	e8 1d 05 00 00       	call   18d9 <printf>
		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    13bc:	a1 c0 21 00 00       	mov    0x21c0,%eax
    13c1:	89 44 24 08          	mov    %eax,0x8(%esp)
    13c5:	c7 44 24 04 ac 20 00 	movl   $0x20ac,0x4(%esp)
    13cc:	00 
    13cd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13d4:	e8 00 05 00 00       	call   18d9 <printf>
		printf(1, "Number of missionaries on boat: %d.\n",2);  
    13d9:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    13e0:	00 
    13e1:	c7 44 24 04 84 20 00 	movl   $0x2084,0x4(%esp)
    13e8:	00 
    13e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13f0:	e8 e4 04 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&M);
		//sem_signal(&M); 
		RowBoat();
    13f5:	e8 a5 00 00 00       	call   149f <RowBoat>

		//lock_acquire(&mutex.lock); 
		numCannibals--; 
    13fa:	a1 c0 21 00 00       	mov    0x21c0,%eax
    13ff:	83 e8 01             	sub    $0x1,%eax
    1402:	a3 c0 21 00 00       	mov    %eax,0x21c0
		numMissionaries = numMissionaries -2; 
    1407:	a1 bc 21 00 00       	mov    0x21bc,%eax
    140c:	83 e8 02             	sub    $0x2,%eax
    140f:	a3 bc 21 00 00       	mov    %eax,0x21bc
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries); 
    1414:	a1 bc 21 00 00       	mov    0x21bc,%eax
    1419:	89 44 24 08          	mov    %eax,0x8(%esp)
    141d:	c7 44 24 04 d0 20 00 	movl   $0x20d0,0x4(%esp)
    1424:	00 
    1425:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142c:	e8 a8 04 00 00       	call   18d9 <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1431:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1436:	89 44 24 08          	mov    %eax,0x8(%esp)
    143a:	c7 44 24 04 f8 20 00 	movl   $0x20f8,0x4(%esp)
    1441:	00 
    1442:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1449:	e8 8b 04 00 00       	call   18d9 <printf>
		printf(1,"==============================\n");  
    144e:	c7 44 24 04 1c 21 00 	movl   $0x211c,0x4(%esp)
    1455:	00 
    1456:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    145d:	e8 77 04 00 00       	call   18d9 <printf>
    1462:	eb 2a                	jmp    148e <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit(); 
	}
	else {
		//lock_acquire(&mutex.lock); 
		numCannibals++; 
    1464:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1469:	83 c0 01             	add    $0x1,%eax
    146c:	a3 c0 21 00 00       	mov    %eax,0x21c0
		printf(1, "Number of cannibals arrived: %d.\n",numCannibals);  
    1471:	a1 c0 21 00 00       	mov    0x21c0,%eax
    1476:	89 44 24 08          	mov    %eax,0x8(%esp)
    147a:	c7 44 24 04 3c 21 00 	movl   $0x213c,0x4(%esp)
    1481:	00 
    1482:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1489:	e8 4b 04 00 00       	call   18d9 <printf>
		//lock_release(&mutex.lock);
		//texit();  
	}
	lock_release(&mutex.lock); 
    148e:	c7 04 24 d4 21 00 00 	movl   $0x21d4,(%esp)
    1495:	e8 4d 08 00 00       	call   1ce7 <lock_release>
	texit(); 
    149a:	e8 41 03 00 00       	call   17e0 <texit>

0000149f <RowBoat>:
} 

void RowBoat() {
    149f:	55                   	push   %ebp
    14a0:	89 e5                	mov    %esp,%ebp
    14a2:	83 ec 18             	sub    $0x18,%esp
	//lock_acquire(&mutex.lock); 
	//printf(1,"Number of cannibals in boat: %d.\n",numCannibals); 
	//printf(1,"Number of missionaries in boat: %d.\n",numMissionaries); 
	numBoat++; 
    14a5:	a1 c4 21 00 00       	mov    0x21c4,%eax
    14aa:	83 c0 01             	add    $0x1,%eax
    14ad:	a3 c4 21 00 00       	mov    %eax,0x21c4
	printf(1,"Rowing boat: %d.\n",numBoat);
    14b2:	a1 c4 21 00 00       	mov    0x21c4,%eax
    14b7:	89 44 24 08          	mov    %eax,0x8(%esp)
    14bb:	c7 44 24 04 5e 21 00 	movl   $0x215e,0x4(%esp)
    14c2:	00 
    14c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ca:	e8 0a 04 00 00       	call   18d9 <printf>
	//lock_release(&mutex.lock); 
	  
} 
    14cf:	c9                   	leave  
    14d0:	c3                   	ret    
    14d1:	90                   	nop
    14d2:	90                   	nop
    14d3:	90                   	nop

000014d4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    14d4:	55                   	push   %ebp
    14d5:	89 e5                	mov    %esp,%ebp
    14d7:	57                   	push   %edi
    14d8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    14d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    14dc:	8b 55 10             	mov    0x10(%ebp),%edx
    14df:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e2:	89 cb                	mov    %ecx,%ebx
    14e4:	89 df                	mov    %ebx,%edi
    14e6:	89 d1                	mov    %edx,%ecx
    14e8:	fc                   	cld    
    14e9:	f3 aa                	rep stos %al,%es:(%edi)
    14eb:	89 ca                	mov    %ecx,%edx
    14ed:	89 fb                	mov    %edi,%ebx
    14ef:	89 5d 08             	mov    %ebx,0x8(%ebp)
    14f2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    14f5:	5b                   	pop    %ebx
    14f6:	5f                   	pop    %edi
    14f7:	5d                   	pop    %ebp
    14f8:	c3                   	ret    

000014f9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    14f9:	55                   	push   %ebp
    14fa:	89 e5                	mov    %esp,%ebp
    14fc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    14ff:	8b 45 08             	mov    0x8(%ebp),%eax
    1502:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1505:	8b 45 0c             	mov    0xc(%ebp),%eax
    1508:	0f b6 10             	movzbl (%eax),%edx
    150b:	8b 45 08             	mov    0x8(%ebp),%eax
    150e:	88 10                	mov    %dl,(%eax)
    1510:	8b 45 08             	mov    0x8(%ebp),%eax
    1513:	0f b6 00             	movzbl (%eax),%eax
    1516:	84 c0                	test   %al,%al
    1518:	0f 95 c0             	setne  %al
    151b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    151f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1523:	84 c0                	test   %al,%al
    1525:	75 de                	jne    1505 <strcpy+0xc>
    ;
  return os;
    1527:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    152a:	c9                   	leave  
    152b:	c3                   	ret    

0000152c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    152c:	55                   	push   %ebp
    152d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    152f:	eb 08                	jmp    1539 <strcmp+0xd>
    p++, q++;
    1531:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1535:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1539:	8b 45 08             	mov    0x8(%ebp),%eax
    153c:	0f b6 00             	movzbl (%eax),%eax
    153f:	84 c0                	test   %al,%al
    1541:	74 10                	je     1553 <strcmp+0x27>
    1543:	8b 45 08             	mov    0x8(%ebp),%eax
    1546:	0f b6 10             	movzbl (%eax),%edx
    1549:	8b 45 0c             	mov    0xc(%ebp),%eax
    154c:	0f b6 00             	movzbl (%eax),%eax
    154f:	38 c2                	cmp    %al,%dl
    1551:	74 de                	je     1531 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1553:	8b 45 08             	mov    0x8(%ebp),%eax
    1556:	0f b6 00             	movzbl (%eax),%eax
    1559:	0f b6 d0             	movzbl %al,%edx
    155c:	8b 45 0c             	mov    0xc(%ebp),%eax
    155f:	0f b6 00             	movzbl (%eax),%eax
    1562:	0f b6 c0             	movzbl %al,%eax
    1565:	89 d1                	mov    %edx,%ecx
    1567:	29 c1                	sub    %eax,%ecx
    1569:	89 c8                	mov    %ecx,%eax
}
    156b:	5d                   	pop    %ebp
    156c:	c3                   	ret    

0000156d <strlen>:

uint
strlen(char *s)
{
    156d:	55                   	push   %ebp
    156e:	89 e5                	mov    %esp,%ebp
    1570:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1573:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    157a:	eb 04                	jmp    1580 <strlen+0x13>
    157c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1580:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1583:	03 45 08             	add    0x8(%ebp),%eax
    1586:	0f b6 00             	movzbl (%eax),%eax
    1589:	84 c0                	test   %al,%al
    158b:	75 ef                	jne    157c <strlen+0xf>
    ;
  return n;
    158d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1590:	c9                   	leave  
    1591:	c3                   	ret    

00001592 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1592:	55                   	push   %ebp
    1593:	89 e5                	mov    %esp,%ebp
    1595:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1598:	8b 45 10             	mov    0x10(%ebp),%eax
    159b:	89 44 24 08          	mov    %eax,0x8(%esp)
    159f:	8b 45 0c             	mov    0xc(%ebp),%eax
    15a2:	89 44 24 04          	mov    %eax,0x4(%esp)
    15a6:	8b 45 08             	mov    0x8(%ebp),%eax
    15a9:	89 04 24             	mov    %eax,(%esp)
    15ac:	e8 23 ff ff ff       	call   14d4 <stosb>
  return dst;
    15b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
    15b4:	c9                   	leave  
    15b5:	c3                   	ret    

000015b6 <strchr>:

char*
strchr(const char *s, char c)
{
    15b6:	55                   	push   %ebp
    15b7:	89 e5                	mov    %esp,%ebp
    15b9:	83 ec 04             	sub    $0x4,%esp
    15bc:	8b 45 0c             	mov    0xc(%ebp),%eax
    15bf:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    15c2:	eb 14                	jmp    15d8 <strchr+0x22>
    if(*s == c)
    15c4:	8b 45 08             	mov    0x8(%ebp),%eax
    15c7:	0f b6 00             	movzbl (%eax),%eax
    15ca:	3a 45 fc             	cmp    -0x4(%ebp),%al
    15cd:	75 05                	jne    15d4 <strchr+0x1e>
      return (char*)s;
    15cf:	8b 45 08             	mov    0x8(%ebp),%eax
    15d2:	eb 13                	jmp    15e7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    15d4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    15d8:	8b 45 08             	mov    0x8(%ebp),%eax
    15db:	0f b6 00             	movzbl (%eax),%eax
    15de:	84 c0                	test   %al,%al
    15e0:	75 e2                	jne    15c4 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    15e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    15e7:	c9                   	leave  
    15e8:	c3                   	ret    

000015e9 <gets>:

char*
gets(char *buf, int max)
{
    15e9:	55                   	push   %ebp
    15ea:	89 e5                	mov    %esp,%ebp
    15ec:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    15ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    15f6:	eb 44                	jmp    163c <gets+0x53>
    cc = read(0, &c, 1);
    15f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    15ff:	00 
    1600:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1603:	89 44 24 04          	mov    %eax,0x4(%esp)
    1607:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    160e:	e8 3d 01 00 00       	call   1750 <read>
    1613:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1616:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    161a:	7e 2d                	jle    1649 <gets+0x60>
      break;
    buf[i++] = c;
    161c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    161f:	03 45 08             	add    0x8(%ebp),%eax
    1622:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1626:	88 10                	mov    %dl,(%eax)
    1628:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    162c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1630:	3c 0a                	cmp    $0xa,%al
    1632:	74 16                	je     164a <gets+0x61>
    1634:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1638:	3c 0d                	cmp    $0xd,%al
    163a:	74 0e                	je     164a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    163c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    163f:	83 c0 01             	add    $0x1,%eax
    1642:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1645:	7c b1                	jl     15f8 <gets+0xf>
    1647:	eb 01                	jmp    164a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1649:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    164a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    164d:	03 45 08             	add    0x8(%ebp),%eax
    1650:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1653:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1656:	c9                   	leave  
    1657:	c3                   	ret    

00001658 <stat>:

int
stat(char *n, struct stat *st)
{
    1658:	55                   	push   %ebp
    1659:	89 e5                	mov    %esp,%ebp
    165b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    165e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1665:	00 
    1666:	8b 45 08             	mov    0x8(%ebp),%eax
    1669:	89 04 24             	mov    %eax,(%esp)
    166c:	e8 07 01 00 00       	call   1778 <open>
    1671:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1674:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1678:	79 07                	jns    1681 <stat+0x29>
    return -1;
    167a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    167f:	eb 23                	jmp    16a4 <stat+0x4c>
  r = fstat(fd, st);
    1681:	8b 45 0c             	mov    0xc(%ebp),%eax
    1684:	89 44 24 04          	mov    %eax,0x4(%esp)
    1688:	8b 45 f0             	mov    -0x10(%ebp),%eax
    168b:	89 04 24             	mov    %eax,(%esp)
    168e:	e8 fd 00 00 00       	call   1790 <fstat>
    1693:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1696:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1699:	89 04 24             	mov    %eax,(%esp)
    169c:	e8 bf 00 00 00       	call   1760 <close>
  return r;
    16a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    16a4:	c9                   	leave  
    16a5:	c3                   	ret    

000016a6 <atoi>:

int
atoi(const char *s)
{
    16a6:	55                   	push   %ebp
    16a7:	89 e5                	mov    %esp,%ebp
    16a9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    16ac:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    16b3:	eb 24                	jmp    16d9 <atoi+0x33>
    n = n*10 + *s++ - '0';
    16b5:	8b 55 fc             	mov    -0x4(%ebp),%edx
    16b8:	89 d0                	mov    %edx,%eax
    16ba:	c1 e0 02             	shl    $0x2,%eax
    16bd:	01 d0                	add    %edx,%eax
    16bf:	01 c0                	add    %eax,%eax
    16c1:	89 c2                	mov    %eax,%edx
    16c3:	8b 45 08             	mov    0x8(%ebp),%eax
    16c6:	0f b6 00             	movzbl (%eax),%eax
    16c9:	0f be c0             	movsbl %al,%eax
    16cc:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16cf:	83 e8 30             	sub    $0x30,%eax
    16d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    16d9:	8b 45 08             	mov    0x8(%ebp),%eax
    16dc:	0f b6 00             	movzbl (%eax),%eax
    16df:	3c 2f                	cmp    $0x2f,%al
    16e1:	7e 0a                	jle    16ed <atoi+0x47>
    16e3:	8b 45 08             	mov    0x8(%ebp),%eax
    16e6:	0f b6 00             	movzbl (%eax),%eax
    16e9:	3c 39                	cmp    $0x39,%al
    16eb:	7e c8                	jle    16b5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    16ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    16f0:	c9                   	leave  
    16f1:	c3                   	ret    

000016f2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    16f2:	55                   	push   %ebp
    16f3:	89 e5                	mov    %esp,%ebp
    16f5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    16f8:	8b 45 08             	mov    0x8(%ebp),%eax
    16fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    16fe:	8b 45 0c             	mov    0xc(%ebp),%eax
    1701:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1704:	eb 13                	jmp    1719 <memmove+0x27>
    *dst++ = *src++;
    1706:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1709:	0f b6 10             	movzbl (%eax),%edx
    170c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170f:	88 10                	mov    %dl,(%eax)
    1711:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1715:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1719:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    171d:	0f 9f c0             	setg   %al
    1720:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1724:	84 c0                	test   %al,%al
    1726:	75 de                	jne    1706 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1728:	8b 45 08             	mov    0x8(%ebp),%eax
}
    172b:	c9                   	leave  
    172c:	c3                   	ret    
    172d:	90                   	nop
    172e:	90                   	nop
    172f:	90                   	nop

00001730 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1730:	b8 01 00 00 00       	mov    $0x1,%eax
    1735:	cd 40                	int    $0x40
    1737:	c3                   	ret    

00001738 <exit>:
SYSCALL(exit)
    1738:	b8 02 00 00 00       	mov    $0x2,%eax
    173d:	cd 40                	int    $0x40
    173f:	c3                   	ret    

00001740 <wait>:
SYSCALL(wait)
    1740:	b8 03 00 00 00       	mov    $0x3,%eax
    1745:	cd 40                	int    $0x40
    1747:	c3                   	ret    

00001748 <pipe>:
SYSCALL(pipe)
    1748:	b8 04 00 00 00       	mov    $0x4,%eax
    174d:	cd 40                	int    $0x40
    174f:	c3                   	ret    

00001750 <read>:
SYSCALL(read)
    1750:	b8 05 00 00 00       	mov    $0x5,%eax
    1755:	cd 40                	int    $0x40
    1757:	c3                   	ret    

00001758 <write>:
SYSCALL(write)
    1758:	b8 10 00 00 00       	mov    $0x10,%eax
    175d:	cd 40                	int    $0x40
    175f:	c3                   	ret    

00001760 <close>:
SYSCALL(close)
    1760:	b8 15 00 00 00       	mov    $0x15,%eax
    1765:	cd 40                	int    $0x40
    1767:	c3                   	ret    

00001768 <kill>:
SYSCALL(kill)
    1768:	b8 06 00 00 00       	mov    $0x6,%eax
    176d:	cd 40                	int    $0x40
    176f:	c3                   	ret    

00001770 <exec>:
SYSCALL(exec)
    1770:	b8 07 00 00 00       	mov    $0x7,%eax
    1775:	cd 40                	int    $0x40
    1777:	c3                   	ret    

00001778 <open>:
SYSCALL(open)
    1778:	b8 0f 00 00 00       	mov    $0xf,%eax
    177d:	cd 40                	int    $0x40
    177f:	c3                   	ret    

00001780 <mknod>:
SYSCALL(mknod)
    1780:	b8 11 00 00 00       	mov    $0x11,%eax
    1785:	cd 40                	int    $0x40
    1787:	c3                   	ret    

00001788 <unlink>:
SYSCALL(unlink)
    1788:	b8 12 00 00 00       	mov    $0x12,%eax
    178d:	cd 40                	int    $0x40
    178f:	c3                   	ret    

00001790 <fstat>:
SYSCALL(fstat)
    1790:	b8 08 00 00 00       	mov    $0x8,%eax
    1795:	cd 40                	int    $0x40
    1797:	c3                   	ret    

00001798 <link>:
SYSCALL(link)
    1798:	b8 13 00 00 00       	mov    $0x13,%eax
    179d:	cd 40                	int    $0x40
    179f:	c3                   	ret    

000017a0 <mkdir>:
SYSCALL(mkdir)
    17a0:	b8 14 00 00 00       	mov    $0x14,%eax
    17a5:	cd 40                	int    $0x40
    17a7:	c3                   	ret    

000017a8 <chdir>:
SYSCALL(chdir)
    17a8:	b8 09 00 00 00       	mov    $0x9,%eax
    17ad:	cd 40                	int    $0x40
    17af:	c3                   	ret    

000017b0 <dup>:
SYSCALL(dup)
    17b0:	b8 0a 00 00 00       	mov    $0xa,%eax
    17b5:	cd 40                	int    $0x40
    17b7:	c3                   	ret    

000017b8 <getpid>:
SYSCALL(getpid)
    17b8:	b8 0b 00 00 00       	mov    $0xb,%eax
    17bd:	cd 40                	int    $0x40
    17bf:	c3                   	ret    

000017c0 <sbrk>:
SYSCALL(sbrk)
    17c0:	b8 0c 00 00 00       	mov    $0xc,%eax
    17c5:	cd 40                	int    $0x40
    17c7:	c3                   	ret    

000017c8 <sleep>:
SYSCALL(sleep)
    17c8:	b8 0d 00 00 00       	mov    $0xd,%eax
    17cd:	cd 40                	int    $0x40
    17cf:	c3                   	ret    

000017d0 <uptime>:
SYSCALL(uptime)
    17d0:	b8 0e 00 00 00       	mov    $0xe,%eax
    17d5:	cd 40                	int    $0x40
    17d7:	c3                   	ret    

000017d8 <clone>:
SYSCALL(clone)
    17d8:	b8 16 00 00 00       	mov    $0x16,%eax
    17dd:	cd 40                	int    $0x40
    17df:	c3                   	ret    

000017e0 <texit>:
SYSCALL(texit)
    17e0:	b8 17 00 00 00       	mov    $0x17,%eax
    17e5:	cd 40                	int    $0x40
    17e7:	c3                   	ret    

000017e8 <tsleep>:
SYSCALL(tsleep)
    17e8:	b8 18 00 00 00       	mov    $0x18,%eax
    17ed:	cd 40                	int    $0x40
    17ef:	c3                   	ret    

000017f0 <twakeup>:
SYSCALL(twakeup)
    17f0:	b8 19 00 00 00       	mov    $0x19,%eax
    17f5:	cd 40                	int    $0x40
    17f7:	c3                   	ret    

000017f8 <thread_yield>:
SYSCALL(thread_yield) 
    17f8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    17fd:	cd 40                	int    $0x40
    17ff:	c3                   	ret    

00001800 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1800:	55                   	push   %ebp
    1801:	89 e5                	mov    %esp,%ebp
    1803:	83 ec 28             	sub    $0x28,%esp
    1806:	8b 45 0c             	mov    0xc(%ebp),%eax
    1809:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    180c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1813:	00 
    1814:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1817:	89 44 24 04          	mov    %eax,0x4(%esp)
    181b:	8b 45 08             	mov    0x8(%ebp),%eax
    181e:	89 04 24             	mov    %eax,(%esp)
    1821:	e8 32 ff ff ff       	call   1758 <write>
}
    1826:	c9                   	leave  
    1827:	c3                   	ret    

00001828 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1828:	55                   	push   %ebp
    1829:	89 e5                	mov    %esp,%ebp
    182b:	53                   	push   %ebx
    182c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    182f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1836:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    183a:	74 17                	je     1853 <printint+0x2b>
    183c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1840:	79 11                	jns    1853 <printint+0x2b>
    neg = 1;
    1842:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1849:	8b 45 0c             	mov    0xc(%ebp),%eax
    184c:	f7 d8                	neg    %eax
    184e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1851:	eb 06                	jmp    1859 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1853:	8b 45 0c             	mov    0xc(%ebp),%eax
    1856:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1859:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1860:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1863:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1866:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1869:	ba 00 00 00 00       	mov    $0x0,%edx
    186e:	f7 f3                	div    %ebx
    1870:	89 d0                	mov    %edx,%eax
    1872:	0f b6 80 a4 21 00 00 	movzbl 0x21a4(%eax),%eax
    1879:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    187d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1881:	8b 45 10             	mov    0x10(%ebp),%eax
    1884:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1887:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188a:	ba 00 00 00 00       	mov    $0x0,%edx
    188f:	f7 75 d4             	divl   -0x2c(%ebp)
    1892:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1895:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1899:	75 c5                	jne    1860 <printint+0x38>
  if(neg)
    189b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    189f:	74 28                	je     18c9 <printint+0xa1>
    buf[i++] = '-';
    18a1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18a4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    18a9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    18ad:	eb 1a                	jmp    18c9 <printint+0xa1>
    putc(fd, buf[i]);
    18af:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18b2:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    18b7:	0f be c0             	movsbl %al,%eax
    18ba:	89 44 24 04          	mov    %eax,0x4(%esp)
    18be:	8b 45 08             	mov    0x8(%ebp),%eax
    18c1:	89 04 24             	mov    %eax,(%esp)
    18c4:	e8 37 ff ff ff       	call   1800 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    18c9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    18cd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18d1:	79 dc                	jns    18af <printint+0x87>
    putc(fd, buf[i]);
}
    18d3:	83 c4 44             	add    $0x44,%esp
    18d6:	5b                   	pop    %ebx
    18d7:	5d                   	pop    %ebp
    18d8:	c3                   	ret    

000018d9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    18d9:	55                   	push   %ebp
    18da:	89 e5                	mov    %esp,%ebp
    18dc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    18df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    18e6:	8d 45 0c             	lea    0xc(%ebp),%eax
    18e9:	83 c0 04             	add    $0x4,%eax
    18ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    18ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    18f6:	e9 7e 01 00 00       	jmp    1a79 <printf+0x1a0>
    c = fmt[i] & 0xff;
    18fb:	8b 55 0c             	mov    0xc(%ebp),%edx
    18fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1901:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1904:	0f b6 00             	movzbl (%eax),%eax
    1907:	0f be c0             	movsbl %al,%eax
    190a:	25 ff 00 00 00       	and    $0xff,%eax
    190f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1912:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1916:	75 2c                	jne    1944 <printf+0x6b>
      if(c == '%'){
    1918:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    191c:	75 0c                	jne    192a <printf+0x51>
        state = '%';
    191e:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1925:	e9 4b 01 00 00       	jmp    1a75 <printf+0x19c>
      } else {
        putc(fd, c);
    192a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    192d:	0f be c0             	movsbl %al,%eax
    1930:	89 44 24 04          	mov    %eax,0x4(%esp)
    1934:	8b 45 08             	mov    0x8(%ebp),%eax
    1937:	89 04 24             	mov    %eax,(%esp)
    193a:	e8 c1 fe ff ff       	call   1800 <putc>
    193f:	e9 31 01 00 00       	jmp    1a75 <printf+0x19c>
      }
    } else if(state == '%'){
    1944:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1948:	0f 85 27 01 00 00    	jne    1a75 <printf+0x19c>
      if(c == 'd'){
    194e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1952:	75 2d                	jne    1981 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1954:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1957:	8b 00                	mov    (%eax),%eax
    1959:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1960:	00 
    1961:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1968:	00 
    1969:	89 44 24 04          	mov    %eax,0x4(%esp)
    196d:	8b 45 08             	mov    0x8(%ebp),%eax
    1970:	89 04 24             	mov    %eax,(%esp)
    1973:	e8 b0 fe ff ff       	call   1828 <printint>
        ap++;
    1978:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    197c:	e9 ed 00 00 00       	jmp    1a6e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1981:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1985:	74 06                	je     198d <printf+0xb4>
    1987:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    198b:	75 2d                	jne    19ba <printf+0xe1>
        printint(fd, *ap, 16, 0);
    198d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1990:	8b 00                	mov    (%eax),%eax
    1992:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1999:	00 
    199a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    19a1:	00 
    19a2:	89 44 24 04          	mov    %eax,0x4(%esp)
    19a6:	8b 45 08             	mov    0x8(%ebp),%eax
    19a9:	89 04 24             	mov    %eax,(%esp)
    19ac:	e8 77 fe ff ff       	call   1828 <printint>
        ap++;
    19b1:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    19b5:	e9 b4 00 00 00       	jmp    1a6e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    19ba:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    19be:	75 46                	jne    1a06 <printf+0x12d>
        s = (char*)*ap;
    19c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19c3:	8b 00                	mov    (%eax),%eax
    19c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    19c8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    19cc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    19d0:	75 27                	jne    19f9 <printf+0x120>
          s = "(null)";
    19d2:	c7 45 e4 70 21 00 00 	movl   $0x2170,-0x1c(%ebp)
        while(*s != 0){
    19d9:	eb 1f                	jmp    19fa <printf+0x121>
          putc(fd, *s);
    19db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19de:	0f b6 00             	movzbl (%eax),%eax
    19e1:	0f be c0             	movsbl %al,%eax
    19e4:	89 44 24 04          	mov    %eax,0x4(%esp)
    19e8:	8b 45 08             	mov    0x8(%ebp),%eax
    19eb:	89 04 24             	mov    %eax,(%esp)
    19ee:	e8 0d fe ff ff       	call   1800 <putc>
          s++;
    19f3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    19f7:	eb 01                	jmp    19fa <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    19f9:	90                   	nop
    19fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    19fd:	0f b6 00             	movzbl (%eax),%eax
    1a00:	84 c0                	test   %al,%al
    1a02:	75 d7                	jne    19db <printf+0x102>
    1a04:	eb 68                	jmp    1a6e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1a06:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1a0a:	75 1d                	jne    1a29 <printf+0x150>
        putc(fd, *ap);
    1a0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a0f:	8b 00                	mov    (%eax),%eax
    1a11:	0f be c0             	movsbl %al,%eax
    1a14:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a18:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1b:	89 04 24             	mov    %eax,(%esp)
    1a1e:	e8 dd fd ff ff       	call   1800 <putc>
        ap++;
    1a23:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1a27:	eb 45                	jmp    1a6e <printf+0x195>
      } else if(c == '%'){
    1a29:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1a2d:	75 17                	jne    1a46 <printf+0x16d>
        putc(fd, c);
    1a2f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a32:	0f be c0             	movsbl %al,%eax
    1a35:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a39:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3c:	89 04 24             	mov    %eax,(%esp)
    1a3f:	e8 bc fd ff ff       	call   1800 <putc>
    1a44:	eb 28                	jmp    1a6e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1a46:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1a4d:	00 
    1a4e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a51:	89 04 24             	mov    %eax,(%esp)
    1a54:	e8 a7 fd ff ff       	call   1800 <putc>
        putc(fd, c);
    1a59:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a5c:	0f be c0             	movsbl %al,%eax
    1a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a63:	8b 45 08             	mov    0x8(%ebp),%eax
    1a66:	89 04 24             	mov    %eax,(%esp)
    1a69:	e8 92 fd ff ff       	call   1800 <putc>
      }
      state = 0;
    1a6e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1a75:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1a79:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a7c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a7f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1a82:	0f b6 00             	movzbl (%eax),%eax
    1a85:	84 c0                	test   %al,%al
    1a87:	0f 85 6e fe ff ff    	jne    18fb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1a8d:	c9                   	leave  
    1a8e:	c3                   	ret    
    1a8f:	90                   	nop

00001a90 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a90:	55                   	push   %ebp
    1a91:	89 e5                	mov    %esp,%ebp
    1a93:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1a96:	8b 45 08             	mov    0x8(%ebp),%eax
    1a99:	83 e8 08             	sub    $0x8,%eax
    1a9c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a9f:	a1 d0 21 00 00       	mov    0x21d0,%eax
    1aa4:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1aa7:	eb 24                	jmp    1acd <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1aa9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aac:	8b 00                	mov    (%eax),%eax
    1aae:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ab1:	77 12                	ja     1ac5 <free+0x35>
    1ab3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ab6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ab9:	77 24                	ja     1adf <free+0x4f>
    1abb:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1abe:	8b 00                	mov    (%eax),%eax
    1ac0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1ac3:	77 1a                	ja     1adf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1ac5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ac8:	8b 00                	mov    (%eax),%eax
    1aca:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1acd:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ad0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ad3:	76 d4                	jbe    1aa9 <free+0x19>
    1ad5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ad8:	8b 00                	mov    (%eax),%eax
    1ada:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1add:	76 ca                	jbe    1aa9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1adf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ae2:	8b 40 04             	mov    0x4(%eax),%eax
    1ae5:	c1 e0 03             	shl    $0x3,%eax
    1ae8:	89 c2                	mov    %eax,%edx
    1aea:	03 55 f8             	add    -0x8(%ebp),%edx
    1aed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1af0:	8b 00                	mov    (%eax),%eax
    1af2:	39 c2                	cmp    %eax,%edx
    1af4:	75 24                	jne    1b1a <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1af6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1af9:	8b 50 04             	mov    0x4(%eax),%edx
    1afc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1aff:	8b 00                	mov    (%eax),%eax
    1b01:	8b 40 04             	mov    0x4(%eax),%eax
    1b04:	01 c2                	add    %eax,%edx
    1b06:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b09:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1b0c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b0f:	8b 00                	mov    (%eax),%eax
    1b11:	8b 10                	mov    (%eax),%edx
    1b13:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b16:	89 10                	mov    %edx,(%eax)
    1b18:	eb 0a                	jmp    1b24 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1b1a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b1d:	8b 10                	mov    (%eax),%edx
    1b1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b22:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1b24:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b27:	8b 40 04             	mov    0x4(%eax),%eax
    1b2a:	c1 e0 03             	shl    $0x3,%eax
    1b2d:	03 45 fc             	add    -0x4(%ebp),%eax
    1b30:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1b33:	75 20                	jne    1b55 <free+0xc5>
    p->s.size += bp->s.size;
    1b35:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b38:	8b 50 04             	mov    0x4(%eax),%edx
    1b3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b3e:	8b 40 04             	mov    0x4(%eax),%eax
    1b41:	01 c2                	add    %eax,%edx
    1b43:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b46:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1b49:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1b4c:	8b 10                	mov    (%eax),%edx
    1b4e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b51:	89 10                	mov    %edx,(%eax)
    1b53:	eb 08                	jmp    1b5d <free+0xcd>
  } else
    p->s.ptr = bp;
    1b55:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b58:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1b5b:	89 10                	mov    %edx,(%eax)
  freep = p;
    1b5d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1b60:	a3 d0 21 00 00       	mov    %eax,0x21d0
}
    1b65:	c9                   	leave  
    1b66:	c3                   	ret    

00001b67 <morecore>:

static Header*
morecore(uint nu)
{
    1b67:	55                   	push   %ebp
    1b68:	89 e5                	mov    %esp,%ebp
    1b6a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1b6d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1b74:	77 07                	ja     1b7d <morecore+0x16>
    nu = 4096;
    1b76:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1b7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b80:	c1 e0 03             	shl    $0x3,%eax
    1b83:	89 04 24             	mov    %eax,(%esp)
    1b86:	e8 35 fc ff ff       	call   17c0 <sbrk>
    1b8b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1b8e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1b92:	75 07                	jne    1b9b <morecore+0x34>
    return 0;
    1b94:	b8 00 00 00 00       	mov    $0x0,%eax
    1b99:	eb 22                	jmp    1bbd <morecore+0x56>
  hp = (Header*)p;
    1b9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1ba1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ba4:	8b 55 08             	mov    0x8(%ebp),%edx
    1ba7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1baa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bad:	83 c0 08             	add    $0x8,%eax
    1bb0:	89 04 24             	mov    %eax,(%esp)
    1bb3:	e8 d8 fe ff ff       	call   1a90 <free>
  return freep;
    1bb8:	a1 d0 21 00 00       	mov    0x21d0,%eax
}
    1bbd:	c9                   	leave  
    1bbe:	c3                   	ret    

00001bbf <malloc>:

void*
malloc(uint nbytes)
{
    1bbf:	55                   	push   %ebp
    1bc0:	89 e5                	mov    %esp,%ebp
    1bc2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1bc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc8:	83 c0 07             	add    $0x7,%eax
    1bcb:	c1 e8 03             	shr    $0x3,%eax
    1bce:	83 c0 01             	add    $0x1,%eax
    1bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1bd4:	a1 d0 21 00 00       	mov    0x21d0,%eax
    1bd9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1bdc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1be0:	75 23                	jne    1c05 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1be2:	c7 45 f0 c8 21 00 00 	movl   $0x21c8,-0x10(%ebp)
    1be9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bec:	a3 d0 21 00 00       	mov    %eax,0x21d0
    1bf1:	a1 d0 21 00 00       	mov    0x21d0,%eax
    1bf6:	a3 c8 21 00 00       	mov    %eax,0x21c8
    base.s.size = 0;
    1bfb:	c7 05 cc 21 00 00 00 	movl   $0x0,0x21cc
    1c02:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c08:	8b 00                	mov    (%eax),%eax
    1c0a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1c0d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c10:	8b 40 04             	mov    0x4(%eax),%eax
    1c13:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c16:	72 4d                	jb     1c65 <malloc+0xa6>
      if(p->s.size == nunits)
    1c18:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c1b:	8b 40 04             	mov    0x4(%eax),%eax
    1c1e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1c21:	75 0c                	jne    1c2f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1c23:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c26:	8b 10                	mov    (%eax),%edx
    1c28:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c2b:	89 10                	mov    %edx,(%eax)
    1c2d:	eb 26                	jmp    1c55 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1c2f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c32:	8b 40 04             	mov    0x4(%eax),%eax
    1c35:	89 c2                	mov    %eax,%edx
    1c37:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1c3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c3d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1c40:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c43:	8b 40 04             	mov    0x4(%eax),%eax
    1c46:	c1 e0 03             	shl    $0x3,%eax
    1c49:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1c4c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c4f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c52:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1c55:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c58:	a3 d0 21 00 00       	mov    %eax,0x21d0
      return (void*)(p + 1);
    1c5d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c60:	83 c0 08             	add    $0x8,%eax
    1c63:	eb 38                	jmp    1c9d <malloc+0xde>
    }
    if(p == freep)
    1c65:	a1 d0 21 00 00       	mov    0x21d0,%eax
    1c6a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1c6d:	75 1b                	jne    1c8a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c72:	89 04 24             	mov    %eax,(%esp)
    1c75:	e8 ed fe ff ff       	call   1b67 <morecore>
    1c7a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1c7d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c81:	75 07                	jne    1c8a <malloc+0xcb>
        return 0;
    1c83:	b8 00 00 00 00       	mov    $0x0,%eax
    1c88:	eb 13                	jmp    1c9d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c8a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1c90:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c93:	8b 00                	mov    (%eax),%eax
    1c95:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1c98:	e9 70 ff ff ff       	jmp    1c0d <malloc+0x4e>
}
    1c9d:	c9                   	leave  
    1c9e:	c3                   	ret    
    1c9f:	90                   	nop

00001ca0 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1ca0:	55                   	push   %ebp
    1ca1:	89 e5                	mov    %esp,%ebp
    1ca3:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1ca6:	8b 55 08             	mov    0x8(%ebp),%edx
    1ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
    1cac:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1caf:	f0 87 02             	lock xchg %eax,(%edx)
    1cb2:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1cb5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1cb8:	c9                   	leave  
    1cb9:	c3                   	ret    

00001cba <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1cba:	55                   	push   %ebp
    1cbb:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1cbd:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1cc6:	5d                   	pop    %ebp
    1cc7:	c3                   	ret    

00001cc8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1cc8:	55                   	push   %ebp
    1cc9:	89 e5                	mov    %esp,%ebp
    1ccb:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1cce:	8b 45 08             	mov    0x8(%ebp),%eax
    1cd1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1cd8:	00 
    1cd9:	89 04 24             	mov    %eax,(%esp)
    1cdc:	e8 bf ff ff ff       	call   1ca0 <xchg>
    1ce1:	85 c0                	test   %eax,%eax
    1ce3:	75 e9                	jne    1cce <lock_acquire+0x6>
}
    1ce5:	c9                   	leave  
    1ce6:	c3                   	ret    

00001ce7 <lock_release>:
void lock_release(lock_t *lock){
    1ce7:	55                   	push   %ebp
    1ce8:	89 e5                	mov    %esp,%ebp
    1cea:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1ced:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1cf7:	00 
    1cf8:	89 04 24             	mov    %eax,(%esp)
    1cfb:	e8 a0 ff ff ff       	call   1ca0 <xchg>
}
    1d00:	c9                   	leave  
    1d01:	c3                   	ret    

00001d02 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1d02:	55                   	push   %ebp
    1d03:	89 e5                	mov    %esp,%ebp
    1d05:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1d08:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1d0f:	e8 ab fe ff ff       	call   1bbf <malloc>
    1d14:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1d17:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1d1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d20:	25 ff 0f 00 00       	and    $0xfff,%eax
    1d25:	85 c0                	test   %eax,%eax
    1d27:	74 15                	je     1d3e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1d29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d2c:	89 c2                	mov    %eax,%edx
    1d2e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1d34:	b8 00 10 00 00       	mov    $0x1000,%eax
    1d39:	29 d0                	sub    %edx,%eax
    1d3b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1d3e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d42:	75 1b                	jne    1d5f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1d44:	c7 44 24 04 77 21 00 	movl   $0x2177,0x4(%esp)
    1d4b:	00 
    1d4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d53:	e8 81 fb ff ff       	call   18d9 <printf>
        return 0;
    1d58:	b8 00 00 00 00       	mov    $0x0,%eax
    1d5d:	eb 6f                	jmp    1dce <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1d5f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1d62:	8b 55 08             	mov    0x8(%ebp),%edx
    1d65:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d68:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1d6c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1d70:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1d77:	00 
    1d78:	89 04 24             	mov    %eax,(%esp)
    1d7b:	e8 58 fa ff ff       	call   17d8 <clone>
    1d80:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1d83:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d87:	79 1b                	jns    1da4 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1d89:	c7 44 24 04 85 21 00 	movl   $0x2185,0x4(%esp)
    1d90:	00 
    1d91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d98:	e8 3c fb ff ff       	call   18d9 <printf>
        return 0;
    1d9d:	b8 00 00 00 00       	mov    $0x0,%eax
    1da2:	eb 2a                	jmp    1dce <thread_create+0xcc>
    }
    if(tid > 0){
    1da4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1da8:	7e 05                	jle    1daf <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dad:	eb 1f                	jmp    1dce <thread_create+0xcc>
    }
    if(tid == 0){
    1daf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1db3:	75 14                	jne    1dc9 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1db5:	c7 44 24 04 92 21 00 	movl   $0x2192,0x4(%esp)
    1dbc:	00 
    1dbd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1dc4:	e8 10 fb ff ff       	call   18d9 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1dc9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1dce:	c9                   	leave  
    1dcf:	c3                   	ret    

00001dd0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1dd0:	55                   	push   %ebp
    1dd1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1dd3:	a1 b8 21 00 00       	mov    0x21b8,%eax
    1dd8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1dde:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1de3:	a3 b8 21 00 00       	mov    %eax,0x21b8
    return (int)(rands % max);
    1de8:	a1 b8 21 00 00       	mov    0x21b8,%eax
    1ded:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1df0:	ba 00 00 00 00       	mov    $0x0,%edx
    1df5:	f7 f1                	div    %ecx
    1df7:	89 d0                	mov    %edx,%eax
}
    1df9:	5d                   	pop    %ebp
    1dfa:	c3                   	ret    
    1dfb:	90                   	nop

00001dfc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1dfc:	55                   	push   %ebp
    1dfd:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1dff:	8b 45 08             	mov    0x8(%ebp),%eax
    1e02:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1e08:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0b:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1e12:	8b 45 08             	mov    0x8(%ebp),%eax
    1e15:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1e1c:	5d                   	pop    %ebp
    1e1d:	c3                   	ret    

00001e1e <add_q>:

void add_q(struct queue *q, int v){
    1e1e:	55                   	push   %ebp
    1e1f:	89 e5                	mov    %esp,%ebp
    1e21:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1e24:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1e2b:	e8 8f fd ff ff       	call   1bbf <malloc>
    1e30:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1e33:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e36:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1e3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e40:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e43:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1e45:	8b 45 08             	mov    0x8(%ebp),%eax
    1e48:	8b 40 04             	mov    0x4(%eax),%eax
    1e4b:	85 c0                	test   %eax,%eax
    1e4d:	75 0b                	jne    1e5a <add_q+0x3c>
        q->head = n;
    1e4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e52:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e55:	89 50 04             	mov    %edx,0x4(%eax)
    1e58:	eb 0c                	jmp    1e66 <add_q+0x48>
    }else{
        q->tail->next = n;
    1e5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5d:	8b 40 08             	mov    0x8(%eax),%eax
    1e60:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e63:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1e66:	8b 45 08             	mov    0x8(%ebp),%eax
    1e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e6c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1e6f:	8b 45 08             	mov    0x8(%ebp),%eax
    1e72:	8b 00                	mov    (%eax),%eax
    1e74:	8d 50 01             	lea    0x1(%eax),%edx
    1e77:	8b 45 08             	mov    0x8(%ebp),%eax
    1e7a:	89 10                	mov    %edx,(%eax)
}
    1e7c:	c9                   	leave  
    1e7d:	c3                   	ret    

00001e7e <empty_q>:

int empty_q(struct queue *q){
    1e7e:	55                   	push   %ebp
    1e7f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1e81:	8b 45 08             	mov    0x8(%ebp),%eax
    1e84:	8b 00                	mov    (%eax),%eax
    1e86:	85 c0                	test   %eax,%eax
    1e88:	75 07                	jne    1e91 <empty_q+0x13>
        return 1;
    1e8a:	b8 01 00 00 00       	mov    $0x1,%eax
    1e8f:	eb 05                	jmp    1e96 <empty_q+0x18>
    else
        return 0;
    1e91:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1e96:	5d                   	pop    %ebp
    1e97:	c3                   	ret    

00001e98 <pop_q>:
int pop_q(struct queue *q){
    1e98:	55                   	push   %ebp
    1e99:	89 e5                	mov    %esp,%ebp
    1e9b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1e9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea1:	89 04 24             	mov    %eax,(%esp)
    1ea4:	e8 d5 ff ff ff       	call   1e7e <empty_q>
    1ea9:	85 c0                	test   %eax,%eax
    1eab:	75 5d                	jne    1f0a <pop_q+0x72>
       val = q->head->value; 
    1ead:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb0:	8b 40 04             	mov    0x4(%eax),%eax
    1eb3:	8b 00                	mov    (%eax),%eax
    1eb5:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1eb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1ebb:	8b 40 04             	mov    0x4(%eax),%eax
    1ebe:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	8b 40 04             	mov    0x4(%eax),%eax
    1ec7:	8b 50 04             	mov    0x4(%eax),%edx
    1eca:	8b 45 08             	mov    0x8(%ebp),%eax
    1ecd:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1ed0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ed3:	89 04 24             	mov    %eax,(%esp)
    1ed6:	e8 b5 fb ff ff       	call   1a90 <free>
       q->size--;
    1edb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ede:	8b 00                	mov    (%eax),%eax
    1ee0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1ee3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ee6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1ee8:	8b 45 08             	mov    0x8(%ebp),%eax
    1eeb:	8b 00                	mov    (%eax),%eax
    1eed:	85 c0                	test   %eax,%eax
    1eef:	75 14                	jne    1f05 <pop_q+0x6d>
            q->head = 0;
    1ef1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ef4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1efb:	8b 45 08             	mov    0x8(%ebp),%eax
    1efe:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1f05:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f08:	eb 05                	jmp    1f0f <pop_q+0x77>
    }
    return -1;
    1f0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1f0f:	c9                   	leave  
    1f10:	c3                   	ret    
    1f11:	90                   	nop
    1f12:	90                   	nop
    1f13:	90                   	nop

00001f14 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1f14:	55                   	push   %ebp
    1f15:	89 e5                	mov    %esp,%ebp
    1f17:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1f1a:	8b 45 08             	mov    0x8(%ebp),%eax
    1f1d:	89 04 24             	mov    %eax,(%esp)
    1f20:	e8 a3 fd ff ff       	call   1cc8 <lock_acquire>
	s->count--; 
    1f25:	8b 45 08             	mov    0x8(%ebp),%eax
    1f28:	8b 40 04             	mov    0x4(%eax),%eax
    1f2b:	8d 50 ff             	lea    -0x1(%eax),%edx
    1f2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1f31:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1f34:	8b 45 08             	mov    0x8(%ebp),%eax
    1f37:	8b 40 04             	mov    0x4(%eax),%eax
    1f3a:	85 c0                	test   %eax,%eax
    1f3c:	79 27                	jns    1f65 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1f3e:	e8 75 f8 ff ff       	call   17b8 <getpid>
    1f43:	8b 55 08             	mov    0x8(%ebp),%edx
    1f46:	83 c2 08             	add    $0x8,%edx
    1f49:	89 44 24 04          	mov    %eax,0x4(%esp)
    1f4d:	89 14 24             	mov    %edx,(%esp)
    1f50:	e8 c9 fe ff ff       	call   1e1e <add_q>
		lock_release(&s->lock); 
    1f55:	8b 45 08             	mov    0x8(%ebp),%eax
    1f58:	89 04 24             	mov    %eax,(%esp)
    1f5b:	e8 87 fd ff ff       	call   1ce7 <lock_release>
		tsleep(); 
    1f60:	e8 83 f8 ff ff       	call   17e8 <tsleep>
	} 
	lock_release(&s->lock); 
    1f65:	8b 45 08             	mov    0x8(%ebp),%eax
    1f68:	89 04 24             	mov    %eax,(%esp)
    1f6b:	e8 77 fd ff ff       	call   1ce7 <lock_release>
}
    1f70:	c9                   	leave  
    1f71:	c3                   	ret    

00001f72 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1f72:	55                   	push   %ebp
    1f73:	89 e5                	mov    %esp,%ebp
    1f75:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1f78:	8b 45 08             	mov    0x8(%ebp),%eax
    1f7b:	89 04 24             	mov    %eax,(%esp)
    1f7e:	e8 45 fd ff ff       	call   1cc8 <lock_acquire>
	s->count++; 
    1f83:	8b 45 08             	mov    0x8(%ebp),%eax
    1f86:	8b 40 04             	mov    0x4(%eax),%eax
    1f89:	8d 50 01             	lea    0x1(%eax),%edx
    1f8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8f:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1f92:	8b 45 08             	mov    0x8(%ebp),%eax
    1f95:	8b 40 04             	mov    0x4(%eax),%eax
    1f98:	85 c0                	test   %eax,%eax
    1f9a:	7f 1c                	jg     1fb8 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1f9c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f9f:	83 c0 08             	add    $0x8,%eax
    1fa2:	89 04 24             	mov    %eax,(%esp)
    1fa5:	e8 ee fe ff ff       	call   1e98 <pop_q>
    1faa:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1fb0:	89 04 24             	mov    %eax,(%esp)
    1fb3:	e8 38 f8 ff ff       	call   17f0 <twakeup>
	}
	lock_release(&s->lock); 
    1fb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbb:	89 04 24             	mov    %eax,(%esp)
    1fbe:	e8 24 fd ff ff       	call   1ce7 <lock_release>
} 
    1fc3:	c9                   	leave  
    1fc4:	c3                   	ret    

00001fc5 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1fc5:	55                   	push   %ebp
    1fc6:	89 e5                	mov    %esp,%ebp
    1fc8:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1fcb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fce:	89 04 24             	mov    %eax,(%esp)
    1fd1:	e8 e4 fc ff ff       	call   1cba <lock_init>
	s->count = size; 
    1fd6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1fdc:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1fdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe2:	83 c0 08             	add    $0x8,%eax
    1fe5:	89 04 24             	mov    %eax,(%esp)
    1fe8:	e8 0f fe ff ff       	call   1dfc <init_q>
}
    1fed:	c9                   	leave  
    1fee:	c3                   	ret    
