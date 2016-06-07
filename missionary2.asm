
_missionary2:     file format elf32-i386


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
    1006:	83 ec 50             	sub    $0x50,%esp

	lock_acquire(&mutex.lock); 
    1009:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    1010:	e8 87 0e 00 00       	call   1e9c <lock_acquire>
	printf(1,"Created 10 missionary, and 5 Cannibal. There should only be 5 boat rides with none left over. \n"); 
    1015:	c7 44 24 04 c4 21 00 	movl   $0x21c4,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 84 0a 00 00       	call   1aad <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    1030:	e8 86 0e 00 00       	call   1ebb <lock_release>
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    1044:	e8 8d 0e 00 00       	call   1ed6 <thread_create>
    1049:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(mid == 0) exit(); 
    104d:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1052:	75 05                	jne    1059 <main+0x59>
    1054:	e8 b3 08 00 00       	call   190c <exit>

	void *mid2 = thread_create(MissionaryArrives,(void *)0);
    1059:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1060:	00 
    1061:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    1068:	e8 69 0e 00 00       	call   1ed6 <thread_create>
    106d:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid2 == 0) exit(); 
    1071:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1076:	75 05                	jne    107d <main+0x7d>
    1078:	e8 8f 08 00 00       	call   190c <exit>

	void *mid3 = thread_create(MissionaryArrives,(void *)0);
    107d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1084:	00 
    1085:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    108c:	e8 45 0e 00 00       	call   1ed6 <thread_create>
    1091:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(mid3 == 0) exit(); 
    1095:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    109a:	75 05                	jne    10a1 <main+0xa1>
    109c:	e8 6b 08 00 00       	call   190c <exit>

	void *mid4 = thread_create(MissionaryArrives,(void *)0);
    10a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10a8:	00 
    10a9:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    10b0:	e8 21 0e 00 00       	call   1ed6 <thread_create>
    10b5:	89 44 24 20          	mov    %eax,0x20(%esp)
	if(mid4 == 0) exit(); 
    10b9:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
    10be:	75 05                	jne    10c5 <main+0xc5>
    10c0:	e8 47 08 00 00       	call   190c <exit>

	void *mid5 = thread_create(MissionaryArrives,(void *)0);
    10c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10cc:	00 
    10cd:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    10d4:	e8 fd 0d 00 00       	call   1ed6 <thread_create>
    10d9:	89 44 24 24          	mov    %eax,0x24(%esp)
	if(mid5 == 0) exit(); 
    10dd:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
    10e2:	75 05                	jne    10e9 <main+0xe9>
    10e4:	e8 23 08 00 00       	call   190c <exit>

	void *mid6 = thread_create(MissionaryArrives,(void *)0);
    10e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10f0:	00 
    10f1:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    10f8:	e8 d9 0d 00 00       	call   1ed6 <thread_create>
    10fd:	89 44 24 28          	mov    %eax,0x28(%esp)
	if(mid6 == 0) exit();
    1101:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
    1106:	75 05                	jne    110d <main+0x10d>
    1108:	e8 ff 07 00 00       	call   190c <exit>

 	void *mid7 = thread_create(MissionaryArrives,(void *)0);
    110d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1114:	00 
    1115:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    111c:	e8 b5 0d 00 00       	call   1ed6 <thread_create>
    1121:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	if(mid7 == 0) exit(); 
    1125:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
    112a:	75 05                	jne    1131 <main+0x131>
    112c:	e8 db 07 00 00       	call   190c <exit>

	void *mid8 = thread_create(MissionaryArrives,(void *)0);
    1131:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1138:	00 
    1139:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    1140:	e8 91 0d 00 00       	call   1ed6 <thread_create>
    1145:	89 44 24 30          	mov    %eax,0x30(%esp)
	if(mid8 == 0) exit(); 
    1149:	83 7c 24 30 00       	cmpl   $0x0,0x30(%esp)
    114e:	75 05                	jne    1155 <main+0x155>
    1150:	e8 b7 07 00 00       	call   190c <exit>

	void *mid9 = thread_create(MissionaryArrives,(void *)0);
    1155:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    115c:	00 
    115d:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    1164:	e8 6d 0d 00 00       	call   1ed6 <thread_create>
    1169:	89 44 24 34          	mov    %eax,0x34(%esp)
	if(mid9 == 0) exit(); 
    116d:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
    1172:	75 05                	jne    1179 <main+0x179>
    1174:	e8 93 07 00 00       	call   190c <exit>

	void *mid10 = thread_create(MissionaryArrives,(void *)0);
    1179:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1180:	00 
    1181:	c7 04 24 5f 12 00 00 	movl   $0x125f,(%esp)
    1188:	e8 49 0d 00 00       	call   1ed6 <thread_create>
    118d:	89 44 24 38          	mov    %eax,0x38(%esp)
	if(mid10 == 0) exit(); 
    1191:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
    1196:	75 05                	jne    119d <main+0x19d>
    1198:	e8 6f 07 00 00       	call   190c <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    119d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11a4:	00 
    11a5:	c7 04 24 70 14 00 00 	movl   $0x1470,(%esp)
    11ac:	e8 25 0d 00 00       	call   1ed6 <thread_create>
    11b1:	89 44 24 3c          	mov    %eax,0x3c(%esp)
	if(cid == 0) exit(); 
    11b5:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
    11ba:	75 05                	jne    11c1 <main+0x1c1>
    11bc:	e8 4b 07 00 00       	call   190c <exit>

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
    11c1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11c8:	00 
    11c9:	c7 04 24 70 14 00 00 	movl   $0x1470,(%esp)
    11d0:	e8 01 0d 00 00       	call   1ed6 <thread_create>
    11d5:	89 44 24 40          	mov    %eax,0x40(%esp)
	if(cid2 == 0) exit(); 
    11d9:	83 7c 24 40 00       	cmpl   $0x0,0x40(%esp)
    11de:	75 05                	jne    11e5 <main+0x1e5>
    11e0:	e8 27 07 00 00       	call   190c <exit>

	void *cid3 = thread_create(CannibalArrives,(void *)0); 
    11e5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11ec:	00 
    11ed:	c7 04 24 70 14 00 00 	movl   $0x1470,(%esp)
    11f4:	e8 dd 0c 00 00       	call   1ed6 <thread_create>
    11f9:	89 44 24 44          	mov    %eax,0x44(%esp)
	if(cid3 == 0) exit(); 
    11fd:	83 7c 24 44 00       	cmpl   $0x0,0x44(%esp)
    1202:	75 05                	jne    1209 <main+0x209>
    1204:	e8 03 07 00 00       	call   190c <exit>

	void *cid4 = thread_create(CannibalArrives,(void *)0); 
    1209:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1210:	00 
    1211:	c7 04 24 70 14 00 00 	movl   $0x1470,(%esp)
    1218:	e8 b9 0c 00 00       	call   1ed6 <thread_create>
    121d:	89 44 24 48          	mov    %eax,0x48(%esp)
	if(cid4 == 0) exit();
    1221:	83 7c 24 48 00       	cmpl   $0x0,0x48(%esp)
    1226:	75 05                	jne    122d <main+0x22d>
    1228:	e8 df 06 00 00       	call   190c <exit>

	void *cid5 = thread_create(CannibalArrives,(void *)0);  
    122d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1234:	00 
    1235:	c7 04 24 70 14 00 00 	movl   $0x1470,(%esp)
    123c:	e8 95 0c 00 00       	call   1ed6 <thread_create>
    1241:	89 44 24 4c          	mov    %eax,0x4c(%esp)
	if(cid5 == 0) exit(); 
    1245:	83 7c 24 4c 00       	cmpl   $0x0,0x4c(%esp)
    124a:	75 05                	jne    1251 <main+0x251>
    124c:	e8 bb 06 00 00       	call   190c <exit>

	while(wait() > 0); 
    1251:	e8 be 06 00 00       	call   1914 <wait>
    1256:	85 c0                	test   %eax,%eax
    1258:	7f f7                	jg     1251 <main+0x251>

	exit(); 
    125a:	e8 ad 06 00 00       	call   190c <exit>

0000125f <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    125f:	55                   	push   %ebp
    1260:	89 e5                	mov    %esp,%ebp
    1262:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1265:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    126c:	e8 2b 0c 00 00       	call   1e9c <lock_acquire>
	if(numMissionaries == 2) 
    1271:	a1 84 23 00 00       	mov    0x2384,%eax
    1276:	83 f8 02             	cmp    $0x2,%eax
    1279:	0f 85 c8 00 00 00    	jne    1347 <MissionaryArrives+0xe8>
	{
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    127f:	a1 84 23 00 00       	mov    0x2384,%eax
    1284:	83 c0 01             	add    $0x1,%eax
    1287:	a3 84 23 00 00       	mov    %eax,0x2384
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    128c:	a1 84 23 00 00       	mov    0x2384,%eax
    1291:	89 44 24 08          	mov    %eax,0x8(%esp)
    1295:	c7 44 24 04 24 22 00 	movl   $0x2224,0x4(%esp)
    129c:	00 
    129d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12a4:	e8 04 08 00 00       	call   1aad <printf>
		//sem_signal(&M); 
		//sem_signal(&M);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    12a9:	a1 84 23 00 00       	mov    0x2384,%eax
    12ae:	89 44 24 08          	mov    %eax,0x8(%esp)
    12b2:	c7 44 24 04 4c 22 00 	movl   $0x224c,0x4(%esp)
    12b9:	00 
    12ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12c1:	e8 e7 07 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals on boat: %d.\n",0);  
    12c6:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    12cd:	00 
    12ce:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    12d5:	00 
    12d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12dd:	e8 cb 07 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock);
 
		RowBoat();
    12e2:	e8 8c 03 00 00       	call   1673 <RowBoat>

		//lock_acquire(&mutex.lock);	 
		numMissionaries = numMissionaries - 3;
    12e7:	a1 84 23 00 00       	mov    0x2384,%eax
    12ec:	83 e8 03             	sub    $0x3,%eax
    12ef:	a3 84 23 00 00       	mov    %eax,0x2384
		
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    12f4:	a1 84 23 00 00       	mov    0x2384,%eax
    12f9:	89 44 24 08          	mov    %eax,0x8(%esp)
    12fd:	c7 44 24 04 98 22 00 	movl   $0x2298,0x4(%esp)
    1304:	00 
    1305:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    130c:	e8 9c 07 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1311:	a1 88 23 00 00       	mov    0x2388,%eax
    1316:	89 44 24 08          	mov    %eax,0x8(%esp)
    131a:	c7 44 24 04 c0 22 00 	movl   $0x22c0,0x4(%esp)
    1321:	00 
    1322:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1329:	e8 7f 07 00 00       	call   1aad <printf>
		printf(1,"==============================\n");  
    132e:	c7 44 24 04 e4 22 00 	movl   $0x22e4,0x4(%esp)
    1335:	00 
    1336:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    133d:	e8 6b 07 00 00       	call   1aad <printf>
    1342:	e9 18 01 00 00       	jmp    145f <MissionaryArrives+0x200>
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1347:	a1 84 23 00 00       	mov    0x2384,%eax
    134c:	83 f8 01             	cmp    $0x1,%eax
    134f:	0f 85 e0 00 00 00    	jne    1435 <MissionaryArrives+0x1d6>
    1355:	a1 88 23 00 00       	mov    0x2388,%eax
    135a:	83 f8 01             	cmp    $0x1,%eax
    135d:	0f 85 d2 00 00 00    	jne    1435 <MissionaryArrives+0x1d6>
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    1363:	a1 84 23 00 00       	mov    0x2384,%eax
    1368:	83 c0 01             	add    $0x1,%eax
    136b:	a3 84 23 00 00       	mov    %eax,0x2384
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    1370:	a1 84 23 00 00       	mov    0x2384,%eax
    1375:	89 44 24 08          	mov    %eax,0x8(%esp)
    1379:	c7 44 24 04 24 22 00 	movl   $0x2224,0x4(%esp)
    1380:	00 
    1381:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1388:	e8 20 07 00 00       	call   1aad <printf>
		//sem_signal(&M); 
		//sem_signal(&C);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    138d:	a1 84 23 00 00       	mov    0x2384,%eax
    1392:	89 44 24 08          	mov    %eax,0x8(%esp)
    1396:	c7 44 24 04 4c 22 00 	movl   $0x224c,0x4(%esp)
    139d:	00 
    139e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13a5:	e8 03 07 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals on boat: %d.\n",1); 
    13aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    13b1:	00 
    13b2:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    13b9:	00 
    13ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c1:	e8 e7 06 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock); 

		RowBoat();
    13c6:	e8 a8 02 00 00       	call   1673 <RowBoat>

		//lock_acquire(&mutex.lock);  
		numMissionaries = numMissionaries - 2; 
    13cb:	a1 84 23 00 00       	mov    0x2384,%eax
    13d0:	83 e8 02             	sub    $0x2,%eax
    13d3:	a3 84 23 00 00       	mov    %eax,0x2384
		numCannibals--; 
    13d8:	a1 88 23 00 00       	mov    0x2388,%eax
    13dd:	83 e8 01             	sub    $0x1,%eax
    13e0:	a3 88 23 00 00       	mov    %eax,0x2388
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    13e5:	a1 84 23 00 00       	mov    0x2384,%eax
    13ea:	89 44 24 08          	mov    %eax,0x8(%esp)
    13ee:	c7 44 24 04 98 22 00 	movl   $0x2298,0x4(%esp)
    13f5:	00 
    13f6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13fd:	e8 ab 06 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1402:	a1 88 23 00 00       	mov    0x2388,%eax
    1407:	89 44 24 08          	mov    %eax,0x8(%esp)
    140b:	c7 44 24 04 c0 22 00 	movl   $0x22c0,0x4(%esp)
    1412:	00 
    1413:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    141a:	e8 8e 06 00 00       	call   1aad <printf>
		printf(1,"==============================\n");
    141f:	c7 44 24 04 e4 22 00 	movl   $0x22e4,0x4(%esp)
    1426:	00 
    1427:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142e:	e8 7a 06 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    1433:	eb 2a                	jmp    145f <MissionaryArrives+0x200>
		//texit(); 
			 
	} 
	else {
		//lock_acquire(&mutex.lock); 
		numMissionaries++;
    1435:	a1 84 23 00 00       	mov    0x2384,%eax
    143a:	83 c0 01             	add    $0x1,%eax
    143d:	a3 84 23 00 00       	mov    %eax,0x2384
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    1442:	a1 84 23 00 00       	mov    0x2384,%eax
    1447:	89 44 24 08          	mov    %eax,0x8(%esp)
    144b:	c7 44 24 04 24 22 00 	movl   $0x2224,0x4(%esp)
    1452:	00 
    1453:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    145a:	e8 4e 06 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock); 
		//texit();   
	}
	lock_release(&mutex.lock);
    145f:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    1466:	e8 50 0a 00 00       	call   1ebb <lock_release>
	texit(); 
    146b:	e8 44 05 00 00       	call   19b4 <texit>

00001470 <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1476:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    147d:	e8 1a 0a 00 00       	call   1e9c <lock_acquire>
	if(numCannibals == 2) 
    1482:	a1 88 23 00 00       	mov    0x2388,%eax
    1487:	83 f8 02             	cmp    $0x2,%eax
    148a:	0f 85 c8 00 00 00    	jne    1558 <CannibalArrives+0xe8>
	{
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    1490:	a1 88 23 00 00       	mov    0x2388,%eax
    1495:	83 c0 01             	add    $0x1,%eax
    1498:	a3 88 23 00 00       	mov    %eax,0x2388
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    149d:	a1 88 23 00 00       	mov    0x2388,%eax
    14a2:	89 44 24 08          	mov    %eax,0x8(%esp)
    14a6:	c7 44 24 04 04 23 00 	movl   $0x2304,0x4(%esp)
    14ad:	00 
    14ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14b5:	e8 f3 05 00 00       	call   1aad <printf>
 		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    14ba:	a1 88 23 00 00       	mov    0x2388,%eax
    14bf:	89 44 24 08          	mov    %eax,0x8(%esp)
    14c3:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    14ca:	00 
    14cb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14d2:	e8 d6 05 00 00       	call   1aad <printf>
		printf(1, "Number of missionaries on boat: %d.\n",0);  
    14d7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    14de:	00 
    14df:	c7 44 24 04 4c 22 00 	movl   $0x224c,0x4(%esp)
    14e6:	00 
    14e7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14ee:	e8 ba 05 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&C); 
		//sem_signal(&C);
		RowBoat(); 
    14f3:	e8 7b 01 00 00       	call   1673 <RowBoat>
 	
		//lock_acquire(&mutex.lock); 
		numCannibals = numCannibals -3;  
    14f8:	a1 88 23 00 00       	mov    0x2388,%eax
    14fd:	83 e8 03             	sub    $0x3,%eax
    1500:	a3 88 23 00 00       	mov    %eax,0x2388

		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1505:	a1 84 23 00 00       	mov    0x2384,%eax
    150a:	89 44 24 08          	mov    %eax,0x8(%esp)
    150e:	c7 44 24 04 98 22 00 	movl   $0x2298,0x4(%esp)
    1515:	00 
    1516:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    151d:	e8 8b 05 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1522:	a1 88 23 00 00       	mov    0x2388,%eax
    1527:	89 44 24 08          	mov    %eax,0x8(%esp)
    152b:	c7 44 24 04 c0 22 00 	movl   $0x22c0,0x4(%esp)
    1532:	00 
    1533:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    153a:	e8 6e 05 00 00       	call   1aad <printf>
		printf(1,"==============================\n");  
    153f:	c7 44 24 04 e4 22 00 	movl   $0x22e4,0x4(%esp)
    1546:	00 
    1547:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    154e:	e8 5a 05 00 00       	call   1aad <printf>
    1553:	e9 0a 01 00 00       	jmp    1662 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit();	
	}
	else if(numMissionaries == 2) {
    1558:	a1 84 23 00 00       	mov    0x2384,%eax
    155d:	83 f8 02             	cmp    $0x2,%eax
    1560:	0f 85 d2 00 00 00    	jne    1638 <CannibalArrives+0x1c8>
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    1566:	a1 88 23 00 00       	mov    0x2388,%eax
    156b:	83 c0 01             	add    $0x1,%eax
    156e:	a3 88 23 00 00       	mov    %eax,0x2388
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    1573:	a1 88 23 00 00       	mov    0x2388,%eax
    1578:	89 44 24 08          	mov    %eax,0x8(%esp)
    157c:	c7 44 24 04 04 23 00 	movl   $0x2304,0x4(%esp)
    1583:	00 
    1584:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    158b:	e8 1d 05 00 00       	call   1aad <printf>
		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    1590:	a1 88 23 00 00       	mov    0x2388,%eax
    1595:	89 44 24 08          	mov    %eax,0x8(%esp)
    1599:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    15a0:	00 
    15a1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15a8:	e8 00 05 00 00       	call   1aad <printf>
		printf(1, "Number of missionaries on boat: %d.\n",2);  
    15ad:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    15b4:	00 
    15b5:	c7 44 24 04 4c 22 00 	movl   $0x224c,0x4(%esp)
    15bc:	00 
    15bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15c4:	e8 e4 04 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&M);
		//sem_signal(&M); 
		RowBoat();
    15c9:	e8 a5 00 00 00       	call   1673 <RowBoat>

		//lock_acquire(&mutex.lock); 
		numCannibals--; 
    15ce:	a1 88 23 00 00       	mov    0x2388,%eax
    15d3:	83 e8 01             	sub    $0x1,%eax
    15d6:	a3 88 23 00 00       	mov    %eax,0x2388
		numMissionaries = numMissionaries -2; 
    15db:	a1 84 23 00 00       	mov    0x2384,%eax
    15e0:	83 e8 02             	sub    $0x2,%eax
    15e3:	a3 84 23 00 00       	mov    %eax,0x2384
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries); 
    15e8:	a1 84 23 00 00       	mov    0x2384,%eax
    15ed:	89 44 24 08          	mov    %eax,0x8(%esp)
    15f1:	c7 44 24 04 98 22 00 	movl   $0x2298,0x4(%esp)
    15f8:	00 
    15f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1600:	e8 a8 04 00 00       	call   1aad <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1605:	a1 88 23 00 00       	mov    0x2388,%eax
    160a:	89 44 24 08          	mov    %eax,0x8(%esp)
    160e:	c7 44 24 04 c0 22 00 	movl   $0x22c0,0x4(%esp)
    1615:	00 
    1616:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    161d:	e8 8b 04 00 00       	call   1aad <printf>
		printf(1,"==============================\n");  
    1622:	c7 44 24 04 e4 22 00 	movl   $0x22e4,0x4(%esp)
    1629:	00 
    162a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1631:	e8 77 04 00 00       	call   1aad <printf>
    1636:	eb 2a                	jmp    1662 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit(); 
	}
	else {
		//lock_acquire(&mutex.lock); 
		numCannibals++; 
    1638:	a1 88 23 00 00       	mov    0x2388,%eax
    163d:	83 c0 01             	add    $0x1,%eax
    1640:	a3 88 23 00 00       	mov    %eax,0x2388
		printf(1, "Number of cannibals arrived: %d.\n",numCannibals);  
    1645:	a1 88 23 00 00       	mov    0x2388,%eax
    164a:	89 44 24 08          	mov    %eax,0x8(%esp)
    164e:	c7 44 24 04 04 23 00 	movl   $0x2304,0x4(%esp)
    1655:	00 
    1656:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    165d:	e8 4b 04 00 00       	call   1aad <printf>
		//lock_release(&mutex.lock);
		//texit();  
	}
	lock_release(&mutex.lock); 
    1662:	c7 04 24 9c 23 00 00 	movl   $0x239c,(%esp)
    1669:	e8 4d 08 00 00       	call   1ebb <lock_release>
	texit(); 
    166e:	e8 41 03 00 00       	call   19b4 <texit>

00001673 <RowBoat>:
} 

void RowBoat() {
    1673:	55                   	push   %ebp
    1674:	89 e5                	mov    %esp,%ebp
    1676:	83 ec 18             	sub    $0x18,%esp
	//lock_acquire(&mutex.lock); 
	//printf(1,"Number of cannibals in boat: %d.\n",numCannibals); 
	//printf(1,"Number of missionaries in boat: %d.\n",numMissionaries); 
	numBoat++; 
    1679:	a1 8c 23 00 00       	mov    0x238c,%eax
    167e:	83 c0 01             	add    $0x1,%eax
    1681:	a3 8c 23 00 00       	mov    %eax,0x238c
	printf(1,"Rowing boat: %d.\n",numBoat);
    1686:	a1 8c 23 00 00       	mov    0x238c,%eax
    168b:	89 44 24 08          	mov    %eax,0x8(%esp)
    168f:	c7 44 24 04 26 23 00 	movl   $0x2326,0x4(%esp)
    1696:	00 
    1697:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    169e:	e8 0a 04 00 00       	call   1aad <printf>
	//lock_release(&mutex.lock); 
	  
} 
    16a3:	c9                   	leave  
    16a4:	c3                   	ret    
    16a5:	90                   	nop
    16a6:	90                   	nop
    16a7:	90                   	nop

000016a8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    16a8:	55                   	push   %ebp
    16a9:	89 e5                	mov    %esp,%ebp
    16ab:	57                   	push   %edi
    16ac:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    16ad:	8b 4d 08             	mov    0x8(%ebp),%ecx
    16b0:	8b 55 10             	mov    0x10(%ebp),%edx
    16b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    16b6:	89 cb                	mov    %ecx,%ebx
    16b8:	89 df                	mov    %ebx,%edi
    16ba:	89 d1                	mov    %edx,%ecx
    16bc:	fc                   	cld    
    16bd:	f3 aa                	rep stos %al,%es:(%edi)
    16bf:	89 ca                	mov    %ecx,%edx
    16c1:	89 fb                	mov    %edi,%ebx
    16c3:	89 5d 08             	mov    %ebx,0x8(%ebp)
    16c6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    16c9:	5b                   	pop    %ebx
    16ca:	5f                   	pop    %edi
    16cb:	5d                   	pop    %ebp
    16cc:	c3                   	ret    

000016cd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    16cd:	55                   	push   %ebp
    16ce:	89 e5                	mov    %esp,%ebp
    16d0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    16d3:	8b 45 08             	mov    0x8(%ebp),%eax
    16d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    16d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    16dc:	0f b6 10             	movzbl (%eax),%edx
    16df:	8b 45 08             	mov    0x8(%ebp),%eax
    16e2:	88 10                	mov    %dl,(%eax)
    16e4:	8b 45 08             	mov    0x8(%ebp),%eax
    16e7:	0f b6 00             	movzbl (%eax),%eax
    16ea:	84 c0                	test   %al,%al
    16ec:	0f 95 c0             	setne  %al
    16ef:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    16f3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    16f7:	84 c0                	test   %al,%al
    16f9:	75 de                	jne    16d9 <strcpy+0xc>
    ;
  return os;
    16fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    16fe:	c9                   	leave  
    16ff:	c3                   	ret    

00001700 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1703:	eb 08                	jmp    170d <strcmp+0xd>
    p++, q++;
    1705:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1709:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    170d:	8b 45 08             	mov    0x8(%ebp),%eax
    1710:	0f b6 00             	movzbl (%eax),%eax
    1713:	84 c0                	test   %al,%al
    1715:	74 10                	je     1727 <strcmp+0x27>
    1717:	8b 45 08             	mov    0x8(%ebp),%eax
    171a:	0f b6 10             	movzbl (%eax),%edx
    171d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1720:	0f b6 00             	movzbl (%eax),%eax
    1723:	38 c2                	cmp    %al,%dl
    1725:	74 de                	je     1705 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1727:	8b 45 08             	mov    0x8(%ebp),%eax
    172a:	0f b6 00             	movzbl (%eax),%eax
    172d:	0f b6 d0             	movzbl %al,%edx
    1730:	8b 45 0c             	mov    0xc(%ebp),%eax
    1733:	0f b6 00             	movzbl (%eax),%eax
    1736:	0f b6 c0             	movzbl %al,%eax
    1739:	89 d1                	mov    %edx,%ecx
    173b:	29 c1                	sub    %eax,%ecx
    173d:	89 c8                	mov    %ecx,%eax
}
    173f:	5d                   	pop    %ebp
    1740:	c3                   	ret    

00001741 <strlen>:

uint
strlen(char *s)
{
    1741:	55                   	push   %ebp
    1742:	89 e5                	mov    %esp,%ebp
    1744:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1747:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    174e:	eb 04                	jmp    1754 <strlen+0x13>
    1750:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1754:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1757:	03 45 08             	add    0x8(%ebp),%eax
    175a:	0f b6 00             	movzbl (%eax),%eax
    175d:	84 c0                	test   %al,%al
    175f:	75 ef                	jne    1750 <strlen+0xf>
    ;
  return n;
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1764:	c9                   	leave  
    1765:	c3                   	ret    

00001766 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1766:	55                   	push   %ebp
    1767:	89 e5                	mov    %esp,%ebp
    1769:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    176c:	8b 45 10             	mov    0x10(%ebp),%eax
    176f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1773:	8b 45 0c             	mov    0xc(%ebp),%eax
    1776:	89 44 24 04          	mov    %eax,0x4(%esp)
    177a:	8b 45 08             	mov    0x8(%ebp),%eax
    177d:	89 04 24             	mov    %eax,(%esp)
    1780:	e8 23 ff ff ff       	call   16a8 <stosb>
  return dst;
    1785:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1788:	c9                   	leave  
    1789:	c3                   	ret    

0000178a <strchr>:

char*
strchr(const char *s, char c)
{
    178a:	55                   	push   %ebp
    178b:	89 e5                	mov    %esp,%ebp
    178d:	83 ec 04             	sub    $0x4,%esp
    1790:	8b 45 0c             	mov    0xc(%ebp),%eax
    1793:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1796:	eb 14                	jmp    17ac <strchr+0x22>
    if(*s == c)
    1798:	8b 45 08             	mov    0x8(%ebp),%eax
    179b:	0f b6 00             	movzbl (%eax),%eax
    179e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    17a1:	75 05                	jne    17a8 <strchr+0x1e>
      return (char*)s;
    17a3:	8b 45 08             	mov    0x8(%ebp),%eax
    17a6:	eb 13                	jmp    17bb <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    17a8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    17ac:	8b 45 08             	mov    0x8(%ebp),%eax
    17af:	0f b6 00             	movzbl (%eax),%eax
    17b2:	84 c0                	test   %al,%al
    17b4:	75 e2                	jne    1798 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    17b6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    17bb:	c9                   	leave  
    17bc:	c3                   	ret    

000017bd <gets>:

char*
gets(char *buf, int max)
{
    17bd:	55                   	push   %ebp
    17be:	89 e5                	mov    %esp,%ebp
    17c0:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    17c3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    17ca:	eb 44                	jmp    1810 <gets+0x53>
    cc = read(0, &c, 1);
    17cc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    17d3:	00 
    17d4:	8d 45 ef             	lea    -0x11(%ebp),%eax
    17d7:	89 44 24 04          	mov    %eax,0x4(%esp)
    17db:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    17e2:	e8 3d 01 00 00       	call   1924 <read>
    17e7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    17ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17ee:	7e 2d                	jle    181d <gets+0x60>
      break;
    buf[i++] = c;
    17f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17f3:	03 45 08             	add    0x8(%ebp),%eax
    17f6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    17fa:	88 10                	mov    %dl,(%eax)
    17fc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1800:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1804:	3c 0a                	cmp    $0xa,%al
    1806:	74 16                	je     181e <gets+0x61>
    1808:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    180c:	3c 0d                	cmp    $0xd,%al
    180e:	74 0e                	je     181e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1810:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1813:	83 c0 01             	add    $0x1,%eax
    1816:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1819:	7c b1                	jl     17cc <gets+0xf>
    181b:	eb 01                	jmp    181e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    181d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    181e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1821:	03 45 08             	add    0x8(%ebp),%eax
    1824:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1827:	8b 45 08             	mov    0x8(%ebp),%eax
}
    182a:	c9                   	leave  
    182b:	c3                   	ret    

0000182c <stat>:

int
stat(char *n, struct stat *st)
{
    182c:	55                   	push   %ebp
    182d:	89 e5                	mov    %esp,%ebp
    182f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1832:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1839:	00 
    183a:	8b 45 08             	mov    0x8(%ebp),%eax
    183d:	89 04 24             	mov    %eax,(%esp)
    1840:	e8 07 01 00 00       	call   194c <open>
    1845:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    184c:	79 07                	jns    1855 <stat+0x29>
    return -1;
    184e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1853:	eb 23                	jmp    1878 <stat+0x4c>
  r = fstat(fd, st);
    1855:	8b 45 0c             	mov    0xc(%ebp),%eax
    1858:	89 44 24 04          	mov    %eax,0x4(%esp)
    185c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    185f:	89 04 24             	mov    %eax,(%esp)
    1862:	e8 fd 00 00 00       	call   1964 <fstat>
    1867:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    186a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    186d:	89 04 24             	mov    %eax,(%esp)
    1870:	e8 bf 00 00 00       	call   1934 <close>
  return r;
    1875:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1878:	c9                   	leave  
    1879:	c3                   	ret    

0000187a <atoi>:

int
atoi(const char *s)
{
    187a:	55                   	push   %ebp
    187b:	89 e5                	mov    %esp,%ebp
    187d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1880:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1887:	eb 24                	jmp    18ad <atoi+0x33>
    n = n*10 + *s++ - '0';
    1889:	8b 55 fc             	mov    -0x4(%ebp),%edx
    188c:	89 d0                	mov    %edx,%eax
    188e:	c1 e0 02             	shl    $0x2,%eax
    1891:	01 d0                	add    %edx,%eax
    1893:	01 c0                	add    %eax,%eax
    1895:	89 c2                	mov    %eax,%edx
    1897:	8b 45 08             	mov    0x8(%ebp),%eax
    189a:	0f b6 00             	movzbl (%eax),%eax
    189d:	0f be c0             	movsbl %al,%eax
    18a0:	8d 04 02             	lea    (%edx,%eax,1),%eax
    18a3:	83 e8 30             	sub    $0x30,%eax
    18a6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18a9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    18ad:	8b 45 08             	mov    0x8(%ebp),%eax
    18b0:	0f b6 00             	movzbl (%eax),%eax
    18b3:	3c 2f                	cmp    $0x2f,%al
    18b5:	7e 0a                	jle    18c1 <atoi+0x47>
    18b7:	8b 45 08             	mov    0x8(%ebp),%eax
    18ba:	0f b6 00             	movzbl (%eax),%eax
    18bd:	3c 39                	cmp    $0x39,%al
    18bf:	7e c8                	jle    1889 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    18c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18c4:	c9                   	leave  
    18c5:	c3                   	ret    

000018c6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    18c6:	55                   	push   %ebp
    18c7:	89 e5                	mov    %esp,%ebp
    18c9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    18cc:	8b 45 08             	mov    0x8(%ebp),%eax
    18cf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    18d2:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    18d8:	eb 13                	jmp    18ed <memmove+0x27>
    *dst++ = *src++;
    18da:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18dd:	0f b6 10             	movzbl (%eax),%edx
    18e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18e3:	88 10                	mov    %dl,(%eax)
    18e5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    18e9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    18ed:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    18f1:	0f 9f c0             	setg   %al
    18f4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    18f8:	84 c0                	test   %al,%al
    18fa:	75 de                	jne    18da <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    18fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
    18ff:	c9                   	leave  
    1900:	c3                   	ret    
    1901:	90                   	nop
    1902:	90                   	nop
    1903:	90                   	nop

00001904 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1904:	b8 01 00 00 00       	mov    $0x1,%eax
    1909:	cd 40                	int    $0x40
    190b:	c3                   	ret    

0000190c <exit>:
SYSCALL(exit)
    190c:	b8 02 00 00 00       	mov    $0x2,%eax
    1911:	cd 40                	int    $0x40
    1913:	c3                   	ret    

00001914 <wait>:
SYSCALL(wait)
    1914:	b8 03 00 00 00       	mov    $0x3,%eax
    1919:	cd 40                	int    $0x40
    191b:	c3                   	ret    

0000191c <pipe>:
SYSCALL(pipe)
    191c:	b8 04 00 00 00       	mov    $0x4,%eax
    1921:	cd 40                	int    $0x40
    1923:	c3                   	ret    

00001924 <read>:
SYSCALL(read)
    1924:	b8 05 00 00 00       	mov    $0x5,%eax
    1929:	cd 40                	int    $0x40
    192b:	c3                   	ret    

0000192c <write>:
SYSCALL(write)
    192c:	b8 10 00 00 00       	mov    $0x10,%eax
    1931:	cd 40                	int    $0x40
    1933:	c3                   	ret    

00001934 <close>:
SYSCALL(close)
    1934:	b8 15 00 00 00       	mov    $0x15,%eax
    1939:	cd 40                	int    $0x40
    193b:	c3                   	ret    

0000193c <kill>:
SYSCALL(kill)
    193c:	b8 06 00 00 00       	mov    $0x6,%eax
    1941:	cd 40                	int    $0x40
    1943:	c3                   	ret    

00001944 <exec>:
SYSCALL(exec)
    1944:	b8 07 00 00 00       	mov    $0x7,%eax
    1949:	cd 40                	int    $0x40
    194b:	c3                   	ret    

0000194c <open>:
SYSCALL(open)
    194c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1951:	cd 40                	int    $0x40
    1953:	c3                   	ret    

00001954 <mknod>:
SYSCALL(mknod)
    1954:	b8 11 00 00 00       	mov    $0x11,%eax
    1959:	cd 40                	int    $0x40
    195b:	c3                   	ret    

0000195c <unlink>:
SYSCALL(unlink)
    195c:	b8 12 00 00 00       	mov    $0x12,%eax
    1961:	cd 40                	int    $0x40
    1963:	c3                   	ret    

00001964 <fstat>:
SYSCALL(fstat)
    1964:	b8 08 00 00 00       	mov    $0x8,%eax
    1969:	cd 40                	int    $0x40
    196b:	c3                   	ret    

0000196c <link>:
SYSCALL(link)
    196c:	b8 13 00 00 00       	mov    $0x13,%eax
    1971:	cd 40                	int    $0x40
    1973:	c3                   	ret    

00001974 <mkdir>:
SYSCALL(mkdir)
    1974:	b8 14 00 00 00       	mov    $0x14,%eax
    1979:	cd 40                	int    $0x40
    197b:	c3                   	ret    

0000197c <chdir>:
SYSCALL(chdir)
    197c:	b8 09 00 00 00       	mov    $0x9,%eax
    1981:	cd 40                	int    $0x40
    1983:	c3                   	ret    

00001984 <dup>:
SYSCALL(dup)
    1984:	b8 0a 00 00 00       	mov    $0xa,%eax
    1989:	cd 40                	int    $0x40
    198b:	c3                   	ret    

0000198c <getpid>:
SYSCALL(getpid)
    198c:	b8 0b 00 00 00       	mov    $0xb,%eax
    1991:	cd 40                	int    $0x40
    1993:	c3                   	ret    

00001994 <sbrk>:
SYSCALL(sbrk)
    1994:	b8 0c 00 00 00       	mov    $0xc,%eax
    1999:	cd 40                	int    $0x40
    199b:	c3                   	ret    

0000199c <sleep>:
SYSCALL(sleep)
    199c:	b8 0d 00 00 00       	mov    $0xd,%eax
    19a1:	cd 40                	int    $0x40
    19a3:	c3                   	ret    

000019a4 <uptime>:
SYSCALL(uptime)
    19a4:	b8 0e 00 00 00       	mov    $0xe,%eax
    19a9:	cd 40                	int    $0x40
    19ab:	c3                   	ret    

000019ac <clone>:
SYSCALL(clone)
    19ac:	b8 16 00 00 00       	mov    $0x16,%eax
    19b1:	cd 40                	int    $0x40
    19b3:	c3                   	ret    

000019b4 <texit>:
SYSCALL(texit)
    19b4:	b8 17 00 00 00       	mov    $0x17,%eax
    19b9:	cd 40                	int    $0x40
    19bb:	c3                   	ret    

000019bc <tsleep>:
SYSCALL(tsleep)
    19bc:	b8 18 00 00 00       	mov    $0x18,%eax
    19c1:	cd 40                	int    $0x40
    19c3:	c3                   	ret    

000019c4 <twakeup>:
SYSCALL(twakeup)
    19c4:	b8 19 00 00 00       	mov    $0x19,%eax
    19c9:	cd 40                	int    $0x40
    19cb:	c3                   	ret    

000019cc <thread_yield>:
SYSCALL(thread_yield) 
    19cc:	b8 1a 00 00 00       	mov    $0x1a,%eax
    19d1:	cd 40                	int    $0x40
    19d3:	c3                   	ret    

000019d4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    19d4:	55                   	push   %ebp
    19d5:	89 e5                	mov    %esp,%ebp
    19d7:	83 ec 28             	sub    $0x28,%esp
    19da:	8b 45 0c             	mov    0xc(%ebp),%eax
    19dd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    19e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    19e7:	00 
    19e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
    19eb:	89 44 24 04          	mov    %eax,0x4(%esp)
    19ef:	8b 45 08             	mov    0x8(%ebp),%eax
    19f2:	89 04 24             	mov    %eax,(%esp)
    19f5:	e8 32 ff ff ff       	call   192c <write>
}
    19fa:	c9                   	leave  
    19fb:	c3                   	ret    

000019fc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    19fc:	55                   	push   %ebp
    19fd:	89 e5                	mov    %esp,%ebp
    19ff:	53                   	push   %ebx
    1a00:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1a03:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1a0a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1a0e:	74 17                	je     1a27 <printint+0x2b>
    1a10:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1a14:	79 11                	jns    1a27 <printint+0x2b>
    neg = 1;
    1a16:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1a1d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a20:	f7 d8                	neg    %eax
    1a22:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1a25:	eb 06                	jmp    1a2d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1a27:	8b 45 0c             	mov    0xc(%ebp),%eax
    1a2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1a2d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1a34:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1a37:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a3d:	ba 00 00 00 00       	mov    $0x0,%edx
    1a42:	f7 f3                	div    %ebx
    1a44:	89 d0                	mov    %edx,%eax
    1a46:	0f b6 80 6c 23 00 00 	movzbl 0x236c(%eax),%eax
    1a4d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1a51:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1a55:	8b 45 10             	mov    0x10(%ebp),%eax
    1a58:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a5e:	ba 00 00 00 00       	mov    $0x0,%edx
    1a63:	f7 75 d4             	divl   -0x2c(%ebp)
    1a66:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1a69:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1a6d:	75 c5                	jne    1a34 <printint+0x38>
  if(neg)
    1a6f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a73:	74 28                	je     1a9d <printint+0xa1>
    buf[i++] = '-';
    1a75:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a78:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1a7d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1a81:	eb 1a                	jmp    1a9d <printint+0xa1>
    putc(fd, buf[i]);
    1a83:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a86:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1a8b:	0f be c0             	movsbl %al,%eax
    1a8e:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a92:	8b 45 08             	mov    0x8(%ebp),%eax
    1a95:	89 04 24             	mov    %eax,(%esp)
    1a98:	e8 37 ff ff ff       	call   19d4 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1a9d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1aa1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aa5:	79 dc                	jns    1a83 <printint+0x87>
    putc(fd, buf[i]);
}
    1aa7:	83 c4 44             	add    $0x44,%esp
    1aaa:	5b                   	pop    %ebx
    1aab:	5d                   	pop    %ebp
    1aac:	c3                   	ret    

00001aad <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1aad:	55                   	push   %ebp
    1aae:	89 e5                	mov    %esp,%ebp
    1ab0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1ab3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1aba:	8d 45 0c             	lea    0xc(%ebp),%eax
    1abd:	83 c0 04             	add    $0x4,%eax
    1ac0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1ac3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1aca:	e9 7e 01 00 00       	jmp    1c4d <printf+0x1a0>
    c = fmt[i] & 0xff;
    1acf:	8b 55 0c             	mov    0xc(%ebp),%edx
    1ad2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ad5:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1ad8:	0f b6 00             	movzbl (%eax),%eax
    1adb:	0f be c0             	movsbl %al,%eax
    1ade:	25 ff 00 00 00       	and    $0xff,%eax
    1ae3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1ae6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1aea:	75 2c                	jne    1b18 <printf+0x6b>
      if(c == '%'){
    1aec:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1af0:	75 0c                	jne    1afe <printf+0x51>
        state = '%';
    1af2:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1af9:	e9 4b 01 00 00       	jmp    1c49 <printf+0x19c>
      } else {
        putc(fd, c);
    1afe:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b01:	0f be c0             	movsbl %al,%eax
    1b04:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b08:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0b:	89 04 24             	mov    %eax,(%esp)
    1b0e:	e8 c1 fe ff ff       	call   19d4 <putc>
    1b13:	e9 31 01 00 00       	jmp    1c49 <printf+0x19c>
      }
    } else if(state == '%'){
    1b18:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1b1c:	0f 85 27 01 00 00    	jne    1c49 <printf+0x19c>
      if(c == 'd'){
    1b22:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1b26:	75 2d                	jne    1b55 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1b28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b2b:	8b 00                	mov    (%eax),%eax
    1b2d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1b34:	00 
    1b35:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1b3c:	00 
    1b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b41:	8b 45 08             	mov    0x8(%ebp),%eax
    1b44:	89 04 24             	mov    %eax,(%esp)
    1b47:	e8 b0 fe ff ff       	call   19fc <printint>
        ap++;
    1b4c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1b50:	e9 ed 00 00 00       	jmp    1c42 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1b55:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1b59:	74 06                	je     1b61 <printf+0xb4>
    1b5b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1b5f:	75 2d                	jne    1b8e <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b64:	8b 00                	mov    (%eax),%eax
    1b66:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1b6d:	00 
    1b6e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1b75:	00 
    1b76:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7d:	89 04 24             	mov    %eax,(%esp)
    1b80:	e8 77 fe ff ff       	call   19fc <printint>
        ap++;
    1b85:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1b89:	e9 b4 00 00 00       	jmp    1c42 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1b8e:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1b92:	75 46                	jne    1bda <printf+0x12d>
        s = (char*)*ap;
    1b94:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b97:	8b 00                	mov    (%eax),%eax
    1b99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1b9c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1ba0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1ba4:	75 27                	jne    1bcd <printf+0x120>
          s = "(null)";
    1ba6:	c7 45 e4 38 23 00 00 	movl   $0x2338,-0x1c(%ebp)
        while(*s != 0){
    1bad:	eb 1f                	jmp    1bce <printf+0x121>
          putc(fd, *s);
    1baf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bb2:	0f b6 00             	movzbl (%eax),%eax
    1bb5:	0f be c0             	movsbl %al,%eax
    1bb8:	89 44 24 04          	mov    %eax,0x4(%esp)
    1bbc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbf:	89 04 24             	mov    %eax,(%esp)
    1bc2:	e8 0d fe ff ff       	call   19d4 <putc>
          s++;
    1bc7:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1bcb:	eb 01                	jmp    1bce <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1bcd:	90                   	nop
    1bce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bd1:	0f b6 00             	movzbl (%eax),%eax
    1bd4:	84 c0                	test   %al,%al
    1bd6:	75 d7                	jne    1baf <printf+0x102>
    1bd8:	eb 68                	jmp    1c42 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1bda:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1bde:	75 1d                	jne    1bfd <printf+0x150>
        putc(fd, *ap);
    1be0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be3:	8b 00                	mov    (%eax),%eax
    1be5:	0f be c0             	movsbl %al,%eax
    1be8:	89 44 24 04          	mov    %eax,0x4(%esp)
    1bec:	8b 45 08             	mov    0x8(%ebp),%eax
    1bef:	89 04 24             	mov    %eax,(%esp)
    1bf2:	e8 dd fd ff ff       	call   19d4 <putc>
        ap++;
    1bf7:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1bfb:	eb 45                	jmp    1c42 <printf+0x195>
      } else if(c == '%'){
    1bfd:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1c01:	75 17                	jne    1c1a <printf+0x16d>
        putc(fd, c);
    1c03:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c06:	0f be c0             	movsbl %al,%eax
    1c09:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c0d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c10:	89 04 24             	mov    %eax,(%esp)
    1c13:	e8 bc fd ff ff       	call   19d4 <putc>
    1c18:	eb 28                	jmp    1c42 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1c1a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1c21:	00 
    1c22:	8b 45 08             	mov    0x8(%ebp),%eax
    1c25:	89 04 24             	mov    %eax,(%esp)
    1c28:	e8 a7 fd ff ff       	call   19d4 <putc>
        putc(fd, c);
    1c2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1c30:	0f be c0             	movsbl %al,%eax
    1c33:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c37:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3a:	89 04 24             	mov    %eax,(%esp)
    1c3d:	e8 92 fd ff ff       	call   19d4 <putc>
      }
      state = 0;
    1c42:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1c49:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1c4d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c50:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1c53:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1c56:	0f b6 00             	movzbl (%eax),%eax
    1c59:	84 c0                	test   %al,%al
    1c5b:	0f 85 6e fe ff ff    	jne    1acf <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1c61:	c9                   	leave  
    1c62:	c3                   	ret    
    1c63:	90                   	nop

00001c64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1c64:	55                   	push   %ebp
    1c65:	89 e5                	mov    %esp,%ebp
    1c67:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1c6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6d:	83 e8 08             	sub    $0x8,%eax
    1c70:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c73:	a1 98 23 00 00       	mov    0x2398,%eax
    1c78:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1c7b:	eb 24                	jmp    1ca1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1c7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c80:	8b 00                	mov    (%eax),%eax
    1c82:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1c85:	77 12                	ja     1c99 <free+0x35>
    1c87:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c8a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1c8d:	77 24                	ja     1cb3 <free+0x4f>
    1c8f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c92:	8b 00                	mov    (%eax),%eax
    1c94:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c97:	77 1a                	ja     1cb3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c9c:	8b 00                	mov    (%eax),%eax
    1c9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1ca1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ca4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1ca7:	76 d4                	jbe    1c7d <free+0x19>
    1ca9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cac:	8b 00                	mov    (%eax),%eax
    1cae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1cb1:	76 ca                	jbe    1c7d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1cb3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cb6:	8b 40 04             	mov    0x4(%eax),%eax
    1cb9:	c1 e0 03             	shl    $0x3,%eax
    1cbc:	89 c2                	mov    %eax,%edx
    1cbe:	03 55 f8             	add    -0x8(%ebp),%edx
    1cc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cc4:	8b 00                	mov    (%eax),%eax
    1cc6:	39 c2                	cmp    %eax,%edx
    1cc8:	75 24                	jne    1cee <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1cca:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1ccd:	8b 50 04             	mov    0x4(%eax),%edx
    1cd0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cd3:	8b 00                	mov    (%eax),%eax
    1cd5:	8b 40 04             	mov    0x4(%eax),%eax
    1cd8:	01 c2                	add    %eax,%edx
    1cda:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cdd:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1ce0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ce3:	8b 00                	mov    (%eax),%eax
    1ce5:	8b 10                	mov    (%eax),%edx
    1ce7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cea:	89 10                	mov    %edx,(%eax)
    1cec:	eb 0a                	jmp    1cf8 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1cee:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cf1:	8b 10                	mov    (%eax),%edx
    1cf3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1cf6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1cf8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1cfb:	8b 40 04             	mov    0x4(%eax),%eax
    1cfe:	c1 e0 03             	shl    $0x3,%eax
    1d01:	03 45 fc             	add    -0x4(%ebp),%eax
    1d04:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1d07:	75 20                	jne    1d29 <free+0xc5>
    p->s.size += bp->s.size;
    1d09:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1d0c:	8b 50 04             	mov    0x4(%eax),%edx
    1d0f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1d12:	8b 40 04             	mov    0x4(%eax),%eax
    1d15:	01 c2                	add    %eax,%edx
    1d17:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1d1a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1d1d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1d20:	8b 10                	mov    (%eax),%edx
    1d22:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1d25:	89 10                	mov    %edx,(%eax)
    1d27:	eb 08                	jmp    1d31 <free+0xcd>
  } else
    p->s.ptr = bp;
    1d29:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1d2c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1d2f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1d31:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1d34:	a3 98 23 00 00       	mov    %eax,0x2398
}
    1d39:	c9                   	leave  
    1d3a:	c3                   	ret    

00001d3b <morecore>:

static Header*
morecore(uint nu)
{
    1d3b:	55                   	push   %ebp
    1d3c:	89 e5                	mov    %esp,%ebp
    1d3e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1d41:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1d48:	77 07                	ja     1d51 <morecore+0x16>
    nu = 4096;
    1d4a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1d51:	8b 45 08             	mov    0x8(%ebp),%eax
    1d54:	c1 e0 03             	shl    $0x3,%eax
    1d57:	89 04 24             	mov    %eax,(%esp)
    1d5a:	e8 35 fc ff ff       	call   1994 <sbrk>
    1d5f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1d62:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1d66:	75 07                	jne    1d6f <morecore+0x34>
    return 0;
    1d68:	b8 00 00 00 00       	mov    $0x0,%eax
    1d6d:	eb 22                	jmp    1d91 <morecore+0x56>
  hp = (Header*)p;
    1d6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1d75:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d78:	8b 55 08             	mov    0x8(%ebp),%edx
    1d7b:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d81:	83 c0 08             	add    $0x8,%eax
    1d84:	89 04 24             	mov    %eax,(%esp)
    1d87:	e8 d8 fe ff ff       	call   1c64 <free>
  return freep;
    1d8c:	a1 98 23 00 00       	mov    0x2398,%eax
}
    1d91:	c9                   	leave  
    1d92:	c3                   	ret    

00001d93 <malloc>:

void*
malloc(uint nbytes)
{
    1d93:	55                   	push   %ebp
    1d94:	89 e5                	mov    %esp,%ebp
    1d96:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d99:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9c:	83 c0 07             	add    $0x7,%eax
    1d9f:	c1 e8 03             	shr    $0x3,%eax
    1da2:	83 c0 01             	add    $0x1,%eax
    1da5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1da8:	a1 98 23 00 00       	mov    0x2398,%eax
    1dad:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1db0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1db4:	75 23                	jne    1dd9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1db6:	c7 45 f0 90 23 00 00 	movl   $0x2390,-0x10(%ebp)
    1dbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dc0:	a3 98 23 00 00       	mov    %eax,0x2398
    1dc5:	a1 98 23 00 00       	mov    0x2398,%eax
    1dca:	a3 90 23 00 00       	mov    %eax,0x2390
    base.s.size = 0;
    1dcf:	c7 05 94 23 00 00 00 	movl   $0x0,0x2394
    1dd6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ddc:	8b 00                	mov    (%eax),%eax
    1dde:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1de1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1de4:	8b 40 04             	mov    0x4(%eax),%eax
    1de7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1dea:	72 4d                	jb     1e39 <malloc+0xa6>
      if(p->s.size == nunits)
    1dec:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1def:	8b 40 04             	mov    0x4(%eax),%eax
    1df2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1df5:	75 0c                	jne    1e03 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1df7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1dfa:	8b 10                	mov    (%eax),%edx
    1dfc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1dff:	89 10                	mov    %edx,(%eax)
    1e01:	eb 26                	jmp    1e29 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1e03:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e06:	8b 40 04             	mov    0x4(%eax),%eax
    1e09:	89 c2                	mov    %eax,%edx
    1e0b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1e0e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e11:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1e14:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e17:	8b 40 04             	mov    0x4(%eax),%eax
    1e1a:	c1 e0 03             	shl    $0x3,%eax
    1e1d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1e20:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e23:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1e26:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1e29:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e2c:	a3 98 23 00 00       	mov    %eax,0x2398
      return (void*)(p + 1);
    1e31:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e34:	83 c0 08             	add    $0x8,%eax
    1e37:	eb 38                	jmp    1e71 <malloc+0xde>
    }
    if(p == freep)
    1e39:	a1 98 23 00 00       	mov    0x2398,%eax
    1e3e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1e41:	75 1b                	jne    1e5e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e46:	89 04 24             	mov    %eax,(%esp)
    1e49:	e8 ed fe ff ff       	call   1d3b <morecore>
    1e4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1e51:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1e55:	75 07                	jne    1e5e <malloc+0xcb>
        return 0;
    1e57:	b8 00 00 00 00       	mov    $0x0,%eax
    1e5c:	eb 13                	jmp    1e71 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1e5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e61:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1e64:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1e67:	8b 00                	mov    (%eax),%eax
    1e69:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1e6c:	e9 70 ff ff ff       	jmp    1de1 <malloc+0x4e>
}
    1e71:	c9                   	leave  
    1e72:	c3                   	ret    
    1e73:	90                   	nop

00001e74 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1e74:	55                   	push   %ebp
    1e75:	89 e5                	mov    %esp,%ebp
    1e77:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1e7a:	8b 55 08             	mov    0x8(%ebp),%edx
    1e7d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1e80:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1e83:	f0 87 02             	lock xchg %eax,(%edx)
    1e86:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1e89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1e8c:	c9                   	leave  
    1e8d:	c3                   	ret    

00001e8e <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1e8e:	55                   	push   %ebp
    1e8f:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1e91:	8b 45 08             	mov    0x8(%ebp),%eax
    1e94:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1e9a:	5d                   	pop    %ebp
    1e9b:	c3                   	ret    

00001e9c <lock_acquire>:
void lock_acquire(lock_t *lock){
    1e9c:	55                   	push   %ebp
    1e9d:	89 e5                	mov    %esp,%ebp
    1e9f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1ea2:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1eac:	00 
    1ead:	89 04 24             	mov    %eax,(%esp)
    1eb0:	e8 bf ff ff ff       	call   1e74 <xchg>
    1eb5:	85 c0                	test   %eax,%eax
    1eb7:	75 e9                	jne    1ea2 <lock_acquire+0x6>
}
    1eb9:	c9                   	leave  
    1eba:	c3                   	ret    

00001ebb <lock_release>:
void lock_release(lock_t *lock){
    1ebb:	55                   	push   %ebp
    1ebc:	89 e5                	mov    %esp,%ebp
    1ebe:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1ec1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ec4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ecb:	00 
    1ecc:	89 04 24             	mov    %eax,(%esp)
    1ecf:	e8 a0 ff ff ff       	call   1e74 <xchg>
}
    1ed4:	c9                   	leave  
    1ed5:	c3                   	ret    

00001ed6 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1ed6:	55                   	push   %ebp
    1ed7:	89 e5                	mov    %esp,%ebp
    1ed9:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1edc:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1ee3:	e8 ab fe ff ff       	call   1d93 <malloc>
    1ee8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1eeb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eee:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1ef1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ef4:	25 ff 0f 00 00       	and    $0xfff,%eax
    1ef9:	85 c0                	test   %eax,%eax
    1efb:	74 15                	je     1f12 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1efd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f00:	89 c2                	mov    %eax,%edx
    1f02:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1f08:	b8 00 10 00 00       	mov    $0x1000,%eax
    1f0d:	29 d0                	sub    %edx,%eax
    1f0f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1f12:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1f16:	75 1b                	jne    1f33 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1f18:	c7 44 24 04 3f 23 00 	movl   $0x233f,0x4(%esp)
    1f1f:	00 
    1f20:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f27:	e8 81 fb ff ff       	call   1aad <printf>
        return 0;
    1f2c:	b8 00 00 00 00       	mov    $0x0,%eax
    1f31:	eb 6f                	jmp    1fa2 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1f33:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1f36:	8b 55 08             	mov    0x8(%ebp),%edx
    1f39:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1f3c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1f40:	89 54 24 08          	mov    %edx,0x8(%esp)
    1f44:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1f4b:	00 
    1f4c:	89 04 24             	mov    %eax,(%esp)
    1f4f:	e8 58 fa ff ff       	call   19ac <clone>
    1f54:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1f57:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f5b:	79 1b                	jns    1f78 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1f5d:	c7 44 24 04 4d 23 00 	movl   $0x234d,0x4(%esp)
    1f64:	00 
    1f65:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f6c:	e8 3c fb ff ff       	call   1aad <printf>
        return 0;
    1f71:	b8 00 00 00 00       	mov    $0x0,%eax
    1f76:	eb 2a                	jmp    1fa2 <thread_create+0xcc>
    }
    if(tid > 0){
    1f78:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f7c:	7e 05                	jle    1f83 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1f7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f81:	eb 1f                	jmp    1fa2 <thread_create+0xcc>
    }
    if(tid == 0){
    1f83:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1f87:	75 14                	jne    1f9d <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1f89:	c7 44 24 04 5a 23 00 	movl   $0x235a,0x4(%esp)
    1f90:	00 
    1f91:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f98:	e8 10 fb ff ff       	call   1aad <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1f9d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1fa2:	c9                   	leave  
    1fa3:	c3                   	ret    

00001fa4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1fa4:	55                   	push   %ebp
    1fa5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1fa7:	a1 80 23 00 00       	mov    0x2380,%eax
    1fac:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1fb2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1fb7:	a3 80 23 00 00       	mov    %eax,0x2380
    return (int)(rands % max);
    1fbc:	a1 80 23 00 00       	mov    0x2380,%eax
    1fc1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1fc4:	ba 00 00 00 00       	mov    $0x0,%edx
    1fc9:	f7 f1                	div    %ecx
    1fcb:	89 d0                	mov    %edx,%eax
}
    1fcd:	5d                   	pop    %ebp
    1fce:	c3                   	ret    
    1fcf:	90                   	nop

00001fd0 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1fd0:	55                   	push   %ebp
    1fd1:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1fd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fd6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1fdc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fdf:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1fe6:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1ff0:	5d                   	pop    %ebp
    1ff1:	c3                   	ret    

00001ff2 <add_q>:

void add_q(struct queue *q, int v){
    1ff2:	55                   	push   %ebp
    1ff3:	89 e5                	mov    %esp,%ebp
    1ff5:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1ff8:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1fff:	e8 8f fd ff ff       	call   1d93 <malloc>
    2004:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    2007:	8b 45 f4             	mov    -0xc(%ebp),%eax
    200a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    2011:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2014:	8b 55 0c             	mov    0xc(%ebp),%edx
    2017:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    2019:	8b 45 08             	mov    0x8(%ebp),%eax
    201c:	8b 40 04             	mov    0x4(%eax),%eax
    201f:	85 c0                	test   %eax,%eax
    2021:	75 0b                	jne    202e <add_q+0x3c>
        q->head = n;
    2023:	8b 45 08             	mov    0x8(%ebp),%eax
    2026:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2029:	89 50 04             	mov    %edx,0x4(%eax)
    202c:	eb 0c                	jmp    203a <add_q+0x48>
    }else{
        q->tail->next = n;
    202e:	8b 45 08             	mov    0x8(%ebp),%eax
    2031:	8b 40 08             	mov    0x8(%eax),%eax
    2034:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2037:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    203a:	8b 45 08             	mov    0x8(%ebp),%eax
    203d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    2040:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    2043:	8b 45 08             	mov    0x8(%ebp),%eax
    2046:	8b 00                	mov    (%eax),%eax
    2048:	8d 50 01             	lea    0x1(%eax),%edx
    204b:	8b 45 08             	mov    0x8(%ebp),%eax
    204e:	89 10                	mov    %edx,(%eax)
}
    2050:	c9                   	leave  
    2051:	c3                   	ret    

00002052 <empty_q>:

int empty_q(struct queue *q){
    2052:	55                   	push   %ebp
    2053:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    2055:	8b 45 08             	mov    0x8(%ebp),%eax
    2058:	8b 00                	mov    (%eax),%eax
    205a:	85 c0                	test   %eax,%eax
    205c:	75 07                	jne    2065 <empty_q+0x13>
        return 1;
    205e:	b8 01 00 00 00       	mov    $0x1,%eax
    2063:	eb 05                	jmp    206a <empty_q+0x18>
    else
        return 0;
    2065:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    206a:	5d                   	pop    %ebp
    206b:	c3                   	ret    

0000206c <pop_q>:
int pop_q(struct queue *q){
    206c:	55                   	push   %ebp
    206d:	89 e5                	mov    %esp,%ebp
    206f:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    2072:	8b 45 08             	mov    0x8(%ebp),%eax
    2075:	89 04 24             	mov    %eax,(%esp)
    2078:	e8 d5 ff ff ff       	call   2052 <empty_q>
    207d:	85 c0                	test   %eax,%eax
    207f:	75 5d                	jne    20de <pop_q+0x72>
       val = q->head->value; 
    2081:	8b 45 08             	mov    0x8(%ebp),%eax
    2084:	8b 40 04             	mov    0x4(%eax),%eax
    2087:	8b 00                	mov    (%eax),%eax
    2089:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    208c:	8b 45 08             	mov    0x8(%ebp),%eax
    208f:	8b 40 04             	mov    0x4(%eax),%eax
    2092:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    2095:	8b 45 08             	mov    0x8(%ebp),%eax
    2098:	8b 40 04             	mov    0x4(%eax),%eax
    209b:	8b 50 04             	mov    0x4(%eax),%edx
    209e:	8b 45 08             	mov    0x8(%ebp),%eax
    20a1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    20a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20a7:	89 04 24             	mov    %eax,(%esp)
    20aa:	e8 b5 fb ff ff       	call   1c64 <free>
       q->size--;
    20af:	8b 45 08             	mov    0x8(%ebp),%eax
    20b2:	8b 00                	mov    (%eax),%eax
    20b4:	8d 50 ff             	lea    -0x1(%eax),%edx
    20b7:	8b 45 08             	mov    0x8(%ebp),%eax
    20ba:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    20bc:	8b 45 08             	mov    0x8(%ebp),%eax
    20bf:	8b 00                	mov    (%eax),%eax
    20c1:	85 c0                	test   %eax,%eax
    20c3:	75 14                	jne    20d9 <pop_q+0x6d>
            q->head = 0;
    20c5:	8b 45 08             	mov    0x8(%ebp),%eax
    20c8:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    20cf:	8b 45 08             	mov    0x8(%ebp),%eax
    20d2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    20d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    20dc:	eb 05                	jmp    20e3 <pop_q+0x77>
    }
    return -1;
    20de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    20e3:	c9                   	leave  
    20e4:	c3                   	ret    
    20e5:	90                   	nop
    20e6:	90                   	nop
    20e7:	90                   	nop

000020e8 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    20e8:	55                   	push   %ebp
    20e9:	89 e5                	mov    %esp,%ebp
    20eb:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    20ee:	8b 45 08             	mov    0x8(%ebp),%eax
    20f1:	89 04 24             	mov    %eax,(%esp)
    20f4:	e8 a3 fd ff ff       	call   1e9c <lock_acquire>
	s->count--; 
    20f9:	8b 45 08             	mov    0x8(%ebp),%eax
    20fc:	8b 40 04             	mov    0x4(%eax),%eax
    20ff:	8d 50 ff             	lea    -0x1(%eax),%edx
    2102:	8b 45 08             	mov    0x8(%ebp),%eax
    2105:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    2108:	8b 45 08             	mov    0x8(%ebp),%eax
    210b:	8b 40 04             	mov    0x4(%eax),%eax
    210e:	85 c0                	test   %eax,%eax
    2110:	79 27                	jns    2139 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    2112:	e8 75 f8 ff ff       	call   198c <getpid>
    2117:	8b 55 08             	mov    0x8(%ebp),%edx
    211a:	83 c2 08             	add    $0x8,%edx
    211d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2121:	89 14 24             	mov    %edx,(%esp)
    2124:	e8 c9 fe ff ff       	call   1ff2 <add_q>
		lock_release(&s->lock); 
    2129:	8b 45 08             	mov    0x8(%ebp),%eax
    212c:	89 04 24             	mov    %eax,(%esp)
    212f:	e8 87 fd ff ff       	call   1ebb <lock_release>
		tsleep(); 
    2134:	e8 83 f8 ff ff       	call   19bc <tsleep>
	} 
	lock_release(&s->lock); 
    2139:	8b 45 08             	mov    0x8(%ebp),%eax
    213c:	89 04 24             	mov    %eax,(%esp)
    213f:	e8 77 fd ff ff       	call   1ebb <lock_release>
}
    2144:	c9                   	leave  
    2145:	c3                   	ret    

00002146 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    2146:	55                   	push   %ebp
    2147:	89 e5                	mov    %esp,%ebp
    2149:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    214c:	8b 45 08             	mov    0x8(%ebp),%eax
    214f:	89 04 24             	mov    %eax,(%esp)
    2152:	e8 45 fd ff ff       	call   1e9c <lock_acquire>
	s->count++; 
    2157:	8b 45 08             	mov    0x8(%ebp),%eax
    215a:	8b 40 04             	mov    0x4(%eax),%eax
    215d:	8d 50 01             	lea    0x1(%eax),%edx
    2160:	8b 45 08             	mov    0x8(%ebp),%eax
    2163:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    2166:	8b 45 08             	mov    0x8(%ebp),%eax
    2169:	8b 40 04             	mov    0x4(%eax),%eax
    216c:	85 c0                	test   %eax,%eax
    216e:	7f 1c                	jg     218c <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    2170:	8b 45 08             	mov    0x8(%ebp),%eax
    2173:	83 c0 08             	add    $0x8,%eax
    2176:	89 04 24             	mov    %eax,(%esp)
    2179:	e8 ee fe ff ff       	call   206c <pop_q>
    217e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    2181:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2184:	89 04 24             	mov    %eax,(%esp)
    2187:	e8 38 f8 ff ff       	call   19c4 <twakeup>
	}
	lock_release(&s->lock); 
    218c:	8b 45 08             	mov    0x8(%ebp),%eax
    218f:	89 04 24             	mov    %eax,(%esp)
    2192:	e8 24 fd ff ff       	call   1ebb <lock_release>
} 
    2197:	c9                   	leave  
    2198:	c3                   	ret    

00002199 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    2199:	55                   	push   %ebp
    219a:	89 e5                	mov    %esp,%ebp
    219c:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    219f:	8b 45 08             	mov    0x8(%ebp),%eax
    21a2:	89 04 24             	mov    %eax,(%esp)
    21a5:	e8 e4 fc ff ff       	call   1e8e <lock_init>
	s->count = size; 
    21aa:	8b 45 08             	mov    0x8(%ebp),%eax
    21ad:	8b 55 0c             	mov    0xc(%ebp),%edx
    21b0:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    21b3:	8b 45 08             	mov    0x8(%ebp),%eax
    21b6:	83 c0 08             	add    $0x8,%eax
    21b9:	89 04 24             	mov    %eax,(%esp)
    21bc:	e8 0f fe ff ff       	call   1fd0 <init_q>
}
    21c1:	c9                   	leave  
    21c2:	c3                   	ret    
