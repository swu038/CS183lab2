
_missionary4:     file format elf32-i386


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
    1006:	83 ec 40             	sub    $0x40,%esp

	lock_acquire(&mutex.lock); 
    1009:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    1010:	e8 f7 0d 00 00       	call   1e0c <lock_acquire>
	printf(1,"Created 6 missionary, and 5 Cannibal. There should only be 3 boat rides, with two left over. \n"); 
    1015:	c7 44 24 04 34 21 00 	movl   $0x2134,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 f4 09 00 00       	call   1a1d <printf>
	lock_release(&mutex.lock); 
    1029:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    1030:	e8 f6 0d 00 00       	call   1e2b <lock_release>
	
	//sem_init(&M, 0); 
	//sem_init(&C, 0);

	void *mid = thread_create(MissionaryArrives,(void *)0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    1044:	e8 fd 0d 00 00       	call   1e46 <thread_create>
    1049:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(mid == 0) exit(); 
    104d:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    1052:	75 05                	jne    1059 <main+0x59>
    1054:	e8 23 08 00 00       	call   187c <exit>

	void *mid2 = thread_create(MissionaryArrives,(void *)0);
    1059:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1060:	00 
    1061:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    1068:	e8 d9 0d 00 00       	call   1e46 <thread_create>
    106d:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(mid2 == 0) exit(); 
    1071:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    1076:	75 05                	jne    107d <main+0x7d>
    1078:	e8 ff 07 00 00       	call   187c <exit>

	void *mid3 = thread_create(MissionaryArrives,(void *)0);
    107d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1084:	00 
    1085:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    108c:	e8 b5 0d 00 00       	call   1e46 <thread_create>
    1091:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(mid3 == 0) exit(); 
    1095:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    109a:	75 05                	jne    10a1 <main+0xa1>
    109c:	e8 db 07 00 00       	call   187c <exit>

	void *mid4 = thread_create(MissionaryArrives,(void *)0);
    10a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10a8:	00 
    10a9:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    10b0:	e8 91 0d 00 00       	call   1e46 <thread_create>
    10b5:	89 44 24 20          	mov    %eax,0x20(%esp)
	if(mid4 == 0) exit(); 
    10b9:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
    10be:	75 05                	jne    10c5 <main+0xc5>
    10c0:	e8 b7 07 00 00       	call   187c <exit>

	void *mid5 = thread_create(MissionaryArrives,(void *)0);
    10c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10cc:	00 
    10cd:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    10d4:	e8 6d 0d 00 00       	call   1e46 <thread_create>
    10d9:	89 44 24 24          	mov    %eax,0x24(%esp)
	if(mid5 == 0) exit(); 
    10dd:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
    10e2:	75 05                	jne    10e9 <main+0xe9>
    10e4:	e8 93 07 00 00       	call   187c <exit>

	void *mid6 = thread_create(MissionaryArrives,(void *)0);
    10e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10f0:	00 
    10f1:	c7 04 24 cf 11 00 00 	movl   $0x11cf,(%esp)
    10f8:	e8 49 0d 00 00       	call   1e46 <thread_create>
    10fd:	89 44 24 28          	mov    %eax,0x28(%esp)
	if(mid6 == 0) exit(); 
    1101:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
    1106:	75 05                	jne    110d <main+0x10d>
    1108:	e8 6f 07 00 00       	call   187c <exit>

	void *cid = thread_create(CannibalArrives,(void *)0); 
    110d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1114:	00 
    1115:	c7 04 24 e0 13 00 00 	movl   $0x13e0,(%esp)
    111c:	e8 25 0d 00 00       	call   1e46 <thread_create>
    1121:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	if(cid == 0) exit(); 
    1125:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
    112a:	75 05                	jne    1131 <main+0x131>
    112c:	e8 4b 07 00 00       	call   187c <exit>

	void *cid2 = thread_create(CannibalArrives,(void *)0); 
    1131:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1138:	00 
    1139:	c7 04 24 e0 13 00 00 	movl   $0x13e0,(%esp)
    1140:	e8 01 0d 00 00       	call   1e46 <thread_create>
    1145:	89 44 24 30          	mov    %eax,0x30(%esp)
	if(cid2 == 0) exit(); 
    1149:	83 7c 24 30 00       	cmpl   $0x0,0x30(%esp)
    114e:	75 05                	jne    1155 <main+0x155>
    1150:	e8 27 07 00 00       	call   187c <exit>

	void *cid3 = thread_create(CannibalArrives,(void *)0); 
    1155:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    115c:	00 
    115d:	c7 04 24 e0 13 00 00 	movl   $0x13e0,(%esp)
    1164:	e8 dd 0c 00 00       	call   1e46 <thread_create>
    1169:	89 44 24 34          	mov    %eax,0x34(%esp)
	if(cid3 == 0) exit(); 
    116d:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
    1172:	75 05                	jne    1179 <main+0x179>
    1174:	e8 03 07 00 00       	call   187c <exit>

	void *cid4 = thread_create(CannibalArrives,(void *)0); 
    1179:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1180:	00 
    1181:	c7 04 24 e0 13 00 00 	movl   $0x13e0,(%esp)
    1188:	e8 b9 0c 00 00       	call   1e46 <thread_create>
    118d:	89 44 24 38          	mov    %eax,0x38(%esp)
	if(cid4 == 0) exit();
    1191:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
    1196:	75 05                	jne    119d <main+0x19d>
    1198:	e8 df 06 00 00       	call   187c <exit>

	void *cid5 = thread_create(CannibalArrives,(void *)0);  
    119d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11a4:	00 
    11a5:	c7 04 24 e0 13 00 00 	movl   $0x13e0,(%esp)
    11ac:	e8 95 0c 00 00       	call   1e46 <thread_create>
    11b1:	89 44 24 3c          	mov    %eax,0x3c(%esp)
	if(cid5 == 0) exit(); 
    11b5:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
    11ba:	75 05                	jne    11c1 <main+0x1c1>
    11bc:	e8 bb 06 00 00       	call   187c <exit>

	while(wait() > 0); 
    11c1:	e8 be 06 00 00       	call   1884 <wait>
    11c6:	85 c0                	test   %eax,%eax
    11c8:	7f f7                	jg     11c1 <main+0x1c1>

	exit(); 
    11ca:	e8 ad 06 00 00       	call   187c <exit>

000011cf <MissionaryArrives>:
	return 0;
}

void MissionaryArrives(void *arg) {
    11cf:	55                   	push   %ebp
    11d0:	89 e5                	mov    %esp,%ebp
    11d2:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    11d5:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    11dc:	e8 2b 0c 00 00       	call   1e0c <lock_acquire>
	if(numMissionaries == 2) 
    11e1:	a1 f4 22 00 00       	mov    0x22f4,%eax
    11e6:	83 f8 02             	cmp    $0x2,%eax
    11e9:	0f 85 c8 00 00 00    	jne    12b7 <MissionaryArrives+0xe8>
	{
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    11ef:	a1 f4 22 00 00       	mov    0x22f4,%eax
    11f4:	83 c0 01             	add    $0x1,%eax
    11f7:	a3 f4 22 00 00       	mov    %eax,0x22f4
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    11fc:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1201:	89 44 24 08          	mov    %eax,0x8(%esp)
    1205:	c7 44 24 04 94 21 00 	movl   $0x2194,0x4(%esp)
    120c:	00 
    120d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1214:	e8 04 08 00 00       	call   1a1d <printf>
		//sem_signal(&M); 
		//sem_signal(&M);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    1219:	a1 f4 22 00 00       	mov    0x22f4,%eax
    121e:	89 44 24 08          	mov    %eax,0x8(%esp)
    1222:	c7 44 24 04 bc 21 00 	movl   $0x21bc,0x4(%esp)
    1229:	00 
    122a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1231:	e8 e7 07 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals on boat: %d.\n",0);  
    1236:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    123d:	00 
    123e:	c7 44 24 04 e4 21 00 	movl   $0x21e4,0x4(%esp)
    1245:	00 
    1246:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124d:	e8 cb 07 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock);
 
		RowBoat();
    1252:	e8 8c 03 00 00       	call   15e3 <RowBoat>

		//lock_acquire(&mutex.lock);	 
		numMissionaries = numMissionaries - 3;
    1257:	a1 f4 22 00 00       	mov    0x22f4,%eax
    125c:	83 e8 03             	sub    $0x3,%eax
    125f:	a3 f4 22 00 00       	mov    %eax,0x22f4
		
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1264:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1269:	89 44 24 08          	mov    %eax,0x8(%esp)
    126d:	c7 44 24 04 08 22 00 	movl   $0x2208,0x4(%esp)
    1274:	00 
    1275:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    127c:	e8 9c 07 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1281:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1286:	89 44 24 08          	mov    %eax,0x8(%esp)
    128a:	c7 44 24 04 30 22 00 	movl   $0x2230,0x4(%esp)
    1291:	00 
    1292:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1299:	e8 7f 07 00 00       	call   1a1d <printf>
		printf(1,"==============================\n");  
    129e:	c7 44 24 04 54 22 00 	movl   $0x2254,0x4(%esp)
    12a5:	00 
    12a6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12ad:	e8 6b 07 00 00       	call   1a1d <printf>
    12b2:	e9 18 01 00 00       	jmp    13cf <MissionaryArrives+0x200>
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    12b7:	a1 f4 22 00 00       	mov    0x22f4,%eax
    12bc:	83 f8 01             	cmp    $0x1,%eax
    12bf:	0f 85 e0 00 00 00    	jne    13a5 <MissionaryArrives+0x1d6>
    12c5:	a1 f8 22 00 00       	mov    0x22f8,%eax
    12ca:	83 f8 01             	cmp    $0x1,%eax
    12cd:	0f 85 d2 00 00 00    	jne    13a5 <MissionaryArrives+0x1d6>
		//lock_acquire(&mutex.lock);
		numMissionaries++; //for num of miss in boat.
    12d3:	a1 f4 22 00 00       	mov    0x22f4,%eax
    12d8:	83 c0 01             	add    $0x1,%eax
    12db:	a3 f4 22 00 00       	mov    %eax,0x22f4
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    12e0:	a1 f4 22 00 00       	mov    0x22f4,%eax
    12e5:	89 44 24 08          	mov    %eax,0x8(%esp)
    12e9:	c7 44 24 04 94 21 00 	movl   $0x2194,0x4(%esp)
    12f0:	00 
    12f1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12f8:	e8 20 07 00 00       	call   1a1d <printf>
		//sem_signal(&M); 
		//sem_signal(&C);
		printf(1,"Number of missionaries on boat: %d.\n",numMissionaries); 
    12fd:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1302:	89 44 24 08          	mov    %eax,0x8(%esp)
    1306:	c7 44 24 04 bc 21 00 	movl   $0x21bc,0x4(%esp)
    130d:	00 
    130e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1315:	e8 03 07 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals on boat: %d.\n",1); 
    131a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1321:	00 
    1322:	c7 44 24 04 e4 21 00 	movl   $0x21e4,0x4(%esp)
    1329:	00 
    132a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1331:	e8 e7 06 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock); 

		RowBoat();
    1336:	e8 a8 02 00 00       	call   15e3 <RowBoat>

		//lock_acquire(&mutex.lock);  
		numMissionaries = numMissionaries - 2; 
    133b:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1340:	83 e8 02             	sub    $0x2,%eax
    1343:	a3 f4 22 00 00       	mov    %eax,0x22f4
		numCannibals--; 
    1348:	a1 f8 22 00 00       	mov    0x22f8,%eax
    134d:	83 e8 01             	sub    $0x1,%eax
    1350:	a3 f8 22 00 00       	mov    %eax,0x22f8
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1355:	a1 f4 22 00 00       	mov    0x22f4,%eax
    135a:	89 44 24 08          	mov    %eax,0x8(%esp)
    135e:	c7 44 24 04 08 22 00 	movl   $0x2208,0x4(%esp)
    1365:	00 
    1366:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    136d:	e8 ab 06 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1372:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1377:	89 44 24 08          	mov    %eax,0x8(%esp)
    137b:	c7 44 24 04 30 22 00 	movl   $0x2230,0x4(%esp)
    1382:	00 
    1383:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    138a:	e8 8e 06 00 00       	call   1a1d <printf>
		printf(1,"==============================\n");
    138f:	c7 44 24 04 54 22 00 	movl   $0x2254,0x4(%esp)
    1396:	00 
    1397:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    139e:	e8 7a 06 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
		printf(1,"==============================\n");  
		//lock_release(&mutex.lock);	
		//texit();  
	}
	else if (numMissionaries == 1 && numCannibals == 1) {
    13a3:	eb 2a                	jmp    13cf <MissionaryArrives+0x200>
		//texit(); 
			 
	} 
	else {
		//lock_acquire(&mutex.lock); 
		numMissionaries++;
    13a5:	a1 f4 22 00 00       	mov    0x22f4,%eax
    13aa:	83 c0 01             	add    $0x1,%eax
    13ad:	a3 f4 22 00 00       	mov    %eax,0x22f4
		printf(1,"Number of missionaries arrived: %d.\n",numMissionaries);  
    13b2:	a1 f4 22 00 00       	mov    0x22f4,%eax
    13b7:	89 44 24 08          	mov    %eax,0x8(%esp)
    13bb:	c7 44 24 04 94 21 00 	movl   $0x2194,0x4(%esp)
    13c2:	00 
    13c3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13ca:	e8 4e 06 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock); 
		//texit();   
	}
	lock_release(&mutex.lock);
    13cf:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    13d6:	e8 50 0a 00 00       	call   1e2b <lock_release>
	texit(); 
    13db:	e8 44 05 00 00       	call   1924 <texit>

000013e0 <CannibalArrives>:
}

void CannibalArrives(void *arg) {
    13e0:	55                   	push   %ebp
    13e1:	89 e5                	mov    %esp,%ebp
    13e3:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    13e6:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    13ed:	e8 1a 0a 00 00       	call   1e0c <lock_acquire>
	if(numCannibals == 2) 
    13f2:	a1 f8 22 00 00       	mov    0x22f8,%eax
    13f7:	83 f8 02             	cmp    $0x2,%eax
    13fa:	0f 85 c8 00 00 00    	jne    14c8 <CannibalArrives+0xe8>
	{
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    1400:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1405:	83 c0 01             	add    $0x1,%eax
    1408:	a3 f8 22 00 00       	mov    %eax,0x22f8
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    140d:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1412:	89 44 24 08          	mov    %eax,0x8(%esp)
    1416:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    141d:	00 
    141e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1425:	e8 f3 05 00 00       	call   1a1d <printf>
 		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    142a:	a1 f8 22 00 00       	mov    0x22f8,%eax
    142f:	89 44 24 08          	mov    %eax,0x8(%esp)
    1433:	c7 44 24 04 e4 21 00 	movl   $0x21e4,0x4(%esp)
    143a:	00 
    143b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1442:	e8 d6 05 00 00       	call   1a1d <printf>
		printf(1, "Number of missionaries on boat: %d.\n",0);  
    1447:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
    144e:	00 
    144f:	c7 44 24 04 bc 21 00 	movl   $0x21bc,0x4(%esp)
    1456:	00 
    1457:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    145e:	e8 ba 05 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&C); 
		//sem_signal(&C);
		RowBoat(); 
    1463:	e8 7b 01 00 00       	call   15e3 <RowBoat>
 	
		//lock_acquire(&mutex.lock); 
		numCannibals = numCannibals -3;  
    1468:	a1 f8 22 00 00       	mov    0x22f8,%eax
    146d:	83 e8 03             	sub    $0x3,%eax
    1470:	a3 f8 22 00 00       	mov    %eax,0x22f8

		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries);
    1475:	a1 f4 22 00 00       	mov    0x22f4,%eax
    147a:	89 44 24 08          	mov    %eax,0x8(%esp)
    147e:	c7 44 24 04 08 22 00 	movl   $0x2208,0x4(%esp)
    1485:	00 
    1486:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    148d:	e8 8b 05 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1492:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1497:	89 44 24 08          	mov    %eax,0x8(%esp)
    149b:	c7 44 24 04 30 22 00 	movl   $0x2230,0x4(%esp)
    14a2:	00 
    14a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14aa:	e8 6e 05 00 00       	call   1a1d <printf>
		printf(1,"==============================\n");  
    14af:	c7 44 24 04 54 22 00 	movl   $0x2254,0x4(%esp)
    14b6:	00 
    14b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14be:	e8 5a 05 00 00       	call   1a1d <printf>
    14c3:	e9 0a 01 00 00       	jmp    15d2 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit();	
	}
	else if(numMissionaries == 2) {
    14c8:	a1 f4 22 00 00       	mov    0x22f4,%eax
    14cd:	83 f8 02             	cmp    $0x2,%eax
    14d0:	0f 85 d2 00 00 00    	jne    15a8 <CannibalArrives+0x1c8>
		//lock_acquire(&mutex.lock); 
		numCannibals++; //for num of can in boat. 
    14d6:	a1 f8 22 00 00       	mov    0x22f8,%eax
    14db:	83 c0 01             	add    $0x1,%eax
    14de:	a3 f8 22 00 00       	mov    %eax,0x22f8
		printf(1,"Number of cannibals arrived: %d.\n",numCannibals); 
    14e3:	a1 f8 22 00 00       	mov    0x22f8,%eax
    14e8:	89 44 24 08          	mov    %eax,0x8(%esp)
    14ec:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    14f3:	00 
    14f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    14fb:	e8 1d 05 00 00       	call   1a1d <printf>
		printf(1, "Number of cannibals on boat: %d.\n",numCannibals); 
    1500:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1505:	89 44 24 08          	mov    %eax,0x8(%esp)
    1509:	c7 44 24 04 e4 21 00 	movl   $0x21e4,0x4(%esp)
    1510:	00 
    1511:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1518:	e8 00 05 00 00       	call   1a1d <printf>
		printf(1, "Number of missionaries on boat: %d.\n",2);  
    151d:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1524:	00 
    1525:	c7 44 24 04 bc 21 00 	movl   $0x21bc,0x4(%esp)
    152c:	00 
    152d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1534:	e8 e4 04 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock);  
		//sem_signal(&M);
		//sem_signal(&M); 
		RowBoat();
    1539:	e8 a5 00 00 00       	call   15e3 <RowBoat>

		//lock_acquire(&mutex.lock); 
		numCannibals--; 
    153e:	a1 f8 22 00 00       	mov    0x22f8,%eax
    1543:	83 e8 01             	sub    $0x1,%eax
    1546:	a3 f8 22 00 00       	mov    %eax,0x22f8
		numMissionaries = numMissionaries -2; 
    154b:	a1 f4 22 00 00       	mov    0x22f4,%eax
    1550:	83 e8 02             	sub    $0x2,%eax
    1553:	a3 f4 22 00 00       	mov    %eax,0x22f4
	
		printf(1,"Number of missionaries waiting: %d.\n",numMissionaries); 
    1558:	a1 f4 22 00 00       	mov    0x22f4,%eax
    155d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1561:	c7 44 24 04 08 22 00 	movl   $0x2208,0x4(%esp)
    1568:	00 
    1569:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1570:	e8 a8 04 00 00       	call   1a1d <printf>
		printf(1,"Number of cannibals waiting: %d.\n",numCannibals);
    1575:	a1 f8 22 00 00       	mov    0x22f8,%eax
    157a:	89 44 24 08          	mov    %eax,0x8(%esp)
    157e:	c7 44 24 04 30 22 00 	movl   $0x2230,0x4(%esp)
    1585:	00 
    1586:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    158d:	e8 8b 04 00 00       	call   1a1d <printf>
		printf(1,"==============================\n");  
    1592:	c7 44 24 04 54 22 00 	movl   $0x2254,0x4(%esp)
    1599:	00 
    159a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15a1:	e8 77 04 00 00       	call   1a1d <printf>
    15a6:	eb 2a                	jmp    15d2 <CannibalArrives+0x1f2>
		//lock_release(&mutex.lock); 
		//texit(); 
	}
	else {
		//lock_acquire(&mutex.lock); 
		numCannibals++; 
    15a8:	a1 f8 22 00 00       	mov    0x22f8,%eax
    15ad:	83 c0 01             	add    $0x1,%eax
    15b0:	a3 f8 22 00 00       	mov    %eax,0x22f8
		printf(1, "Number of cannibals arrived: %d.\n",numCannibals);  
    15b5:	a1 f8 22 00 00       	mov    0x22f8,%eax
    15ba:	89 44 24 08          	mov    %eax,0x8(%esp)
    15be:	c7 44 24 04 74 22 00 	movl   $0x2274,0x4(%esp)
    15c5:	00 
    15c6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15cd:	e8 4b 04 00 00       	call   1a1d <printf>
		//lock_release(&mutex.lock);
		//texit();  
	}
	lock_release(&mutex.lock); 
    15d2:	c7 04 24 0c 23 00 00 	movl   $0x230c,(%esp)
    15d9:	e8 4d 08 00 00       	call   1e2b <lock_release>
	texit(); 
    15de:	e8 41 03 00 00       	call   1924 <texit>

000015e3 <RowBoat>:
} 

void RowBoat() {
    15e3:	55                   	push   %ebp
    15e4:	89 e5                	mov    %esp,%ebp
    15e6:	83 ec 18             	sub    $0x18,%esp
	//lock_acquire(&mutex.lock); 
	//printf(1,"Number of cannibals in boat: %d.\n",numCannibals); 
	//printf(1,"Number of missionaries in boat: %d.\n",numMissionaries); 
	numBoat++; 
    15e9:	a1 fc 22 00 00       	mov    0x22fc,%eax
    15ee:	83 c0 01             	add    $0x1,%eax
    15f1:	a3 fc 22 00 00       	mov    %eax,0x22fc
	printf(1,"Rowing boat: %d.\n",numBoat);
    15f6:	a1 fc 22 00 00       	mov    0x22fc,%eax
    15fb:	89 44 24 08          	mov    %eax,0x8(%esp)
    15ff:	c7 44 24 04 96 22 00 	movl   $0x2296,0x4(%esp)
    1606:	00 
    1607:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    160e:	e8 0a 04 00 00       	call   1a1d <printf>
	//lock_release(&mutex.lock); 
	  
} 
    1613:	c9                   	leave  
    1614:	c3                   	ret    
    1615:	90                   	nop
    1616:	90                   	nop
    1617:	90                   	nop

00001618 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1618:	55                   	push   %ebp
    1619:	89 e5                	mov    %esp,%ebp
    161b:	57                   	push   %edi
    161c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    161d:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1620:	8b 55 10             	mov    0x10(%ebp),%edx
    1623:	8b 45 0c             	mov    0xc(%ebp),%eax
    1626:	89 cb                	mov    %ecx,%ebx
    1628:	89 df                	mov    %ebx,%edi
    162a:	89 d1                	mov    %edx,%ecx
    162c:	fc                   	cld    
    162d:	f3 aa                	rep stos %al,%es:(%edi)
    162f:	89 ca                	mov    %ecx,%edx
    1631:	89 fb                	mov    %edi,%ebx
    1633:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1636:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1639:	5b                   	pop    %ebx
    163a:	5f                   	pop    %edi
    163b:	5d                   	pop    %ebp
    163c:	c3                   	ret    

0000163d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    163d:	55                   	push   %ebp
    163e:	89 e5                	mov    %esp,%ebp
    1640:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1643:	8b 45 08             	mov    0x8(%ebp),%eax
    1646:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1649:	8b 45 0c             	mov    0xc(%ebp),%eax
    164c:	0f b6 10             	movzbl (%eax),%edx
    164f:	8b 45 08             	mov    0x8(%ebp),%eax
    1652:	88 10                	mov    %dl,(%eax)
    1654:	8b 45 08             	mov    0x8(%ebp),%eax
    1657:	0f b6 00             	movzbl (%eax),%eax
    165a:	84 c0                	test   %al,%al
    165c:	0f 95 c0             	setne  %al
    165f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1663:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1667:	84 c0                	test   %al,%al
    1669:	75 de                	jne    1649 <strcpy+0xc>
    ;
  return os;
    166b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    166e:	c9                   	leave  
    166f:	c3                   	ret    

00001670 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1670:	55                   	push   %ebp
    1671:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1673:	eb 08                	jmp    167d <strcmp+0xd>
    p++, q++;
    1675:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1679:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    167d:	8b 45 08             	mov    0x8(%ebp),%eax
    1680:	0f b6 00             	movzbl (%eax),%eax
    1683:	84 c0                	test   %al,%al
    1685:	74 10                	je     1697 <strcmp+0x27>
    1687:	8b 45 08             	mov    0x8(%ebp),%eax
    168a:	0f b6 10             	movzbl (%eax),%edx
    168d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1690:	0f b6 00             	movzbl (%eax),%eax
    1693:	38 c2                	cmp    %al,%dl
    1695:	74 de                	je     1675 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1697:	8b 45 08             	mov    0x8(%ebp),%eax
    169a:	0f b6 00             	movzbl (%eax),%eax
    169d:	0f b6 d0             	movzbl %al,%edx
    16a0:	8b 45 0c             	mov    0xc(%ebp),%eax
    16a3:	0f b6 00             	movzbl (%eax),%eax
    16a6:	0f b6 c0             	movzbl %al,%eax
    16a9:	89 d1                	mov    %edx,%ecx
    16ab:	29 c1                	sub    %eax,%ecx
    16ad:	89 c8                	mov    %ecx,%eax
}
    16af:	5d                   	pop    %ebp
    16b0:	c3                   	ret    

000016b1 <strlen>:

uint
strlen(char *s)
{
    16b1:	55                   	push   %ebp
    16b2:	89 e5                	mov    %esp,%ebp
    16b4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    16b7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    16be:	eb 04                	jmp    16c4 <strlen+0x13>
    16c0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    16c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16c7:	03 45 08             	add    0x8(%ebp),%eax
    16ca:	0f b6 00             	movzbl (%eax),%eax
    16cd:	84 c0                	test   %al,%al
    16cf:	75 ef                	jne    16c0 <strlen+0xf>
    ;
  return n;
    16d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    16d4:	c9                   	leave  
    16d5:	c3                   	ret    

000016d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    16d6:	55                   	push   %ebp
    16d7:	89 e5                	mov    %esp,%ebp
    16d9:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    16dc:	8b 45 10             	mov    0x10(%ebp),%eax
    16df:	89 44 24 08          	mov    %eax,0x8(%esp)
    16e3:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	89 04 24             	mov    %eax,(%esp)
    16f0:	e8 23 ff ff ff       	call   1618 <stosb>
  return dst;
    16f5:	8b 45 08             	mov    0x8(%ebp),%eax
}
    16f8:	c9                   	leave  
    16f9:	c3                   	ret    

000016fa <strchr>:

char*
strchr(const char *s, char c)
{
    16fa:	55                   	push   %ebp
    16fb:	89 e5                	mov    %esp,%ebp
    16fd:	83 ec 04             	sub    $0x4,%esp
    1700:	8b 45 0c             	mov    0xc(%ebp),%eax
    1703:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    1706:	eb 14                	jmp    171c <strchr+0x22>
    if(*s == c)
    1708:	8b 45 08             	mov    0x8(%ebp),%eax
    170b:	0f b6 00             	movzbl (%eax),%eax
    170e:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1711:	75 05                	jne    1718 <strchr+0x1e>
      return (char*)s;
    1713:	8b 45 08             	mov    0x8(%ebp),%eax
    1716:	eb 13                	jmp    172b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1718:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    171c:	8b 45 08             	mov    0x8(%ebp),%eax
    171f:	0f b6 00             	movzbl (%eax),%eax
    1722:	84 c0                	test   %al,%al
    1724:	75 e2                	jne    1708 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    1726:	b8 00 00 00 00       	mov    $0x0,%eax
}
    172b:	c9                   	leave  
    172c:	c3                   	ret    

0000172d <gets>:

char*
gets(char *buf, int max)
{
    172d:	55                   	push   %ebp
    172e:	89 e5                	mov    %esp,%ebp
    1730:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1733:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    173a:	eb 44                	jmp    1780 <gets+0x53>
    cc = read(0, &c, 1);
    173c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1743:	00 
    1744:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1747:	89 44 24 04          	mov    %eax,0x4(%esp)
    174b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1752:	e8 3d 01 00 00       	call   1894 <read>
    1757:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    175a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    175e:	7e 2d                	jle    178d <gets+0x60>
      break;
    buf[i++] = c;
    1760:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1763:	03 45 08             	add    0x8(%ebp),%eax
    1766:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    176a:	88 10                	mov    %dl,(%eax)
    176c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1770:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1774:	3c 0a                	cmp    $0xa,%al
    1776:	74 16                	je     178e <gets+0x61>
    1778:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    177c:	3c 0d                	cmp    $0xd,%al
    177e:	74 0e                	je     178e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1780:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1783:	83 c0 01             	add    $0x1,%eax
    1786:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1789:	7c b1                	jl     173c <gets+0xf>
    178b:	eb 01                	jmp    178e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    178d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    178e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1791:	03 45 08             	add    0x8(%ebp),%eax
    1794:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1797:	8b 45 08             	mov    0x8(%ebp),%eax
}
    179a:	c9                   	leave  
    179b:	c3                   	ret    

0000179c <stat>:

int
stat(char *n, struct stat *st)
{
    179c:	55                   	push   %ebp
    179d:	89 e5                	mov    %esp,%ebp
    179f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    17a2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    17a9:	00 
    17aa:	8b 45 08             	mov    0x8(%ebp),%eax
    17ad:	89 04 24             	mov    %eax,(%esp)
    17b0:	e8 07 01 00 00       	call   18bc <open>
    17b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    17b8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17bc:	79 07                	jns    17c5 <stat+0x29>
    return -1;
    17be:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    17c3:	eb 23                	jmp    17e8 <stat+0x4c>
  r = fstat(fd, st);
    17c5:	8b 45 0c             	mov    0xc(%ebp),%eax
    17c8:	89 44 24 04          	mov    %eax,0x4(%esp)
    17cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17cf:	89 04 24             	mov    %eax,(%esp)
    17d2:	e8 fd 00 00 00       	call   18d4 <fstat>
    17d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    17da:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17dd:	89 04 24             	mov    %eax,(%esp)
    17e0:	e8 bf 00 00 00       	call   18a4 <close>
  return r;
    17e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    17e8:	c9                   	leave  
    17e9:	c3                   	ret    

000017ea <atoi>:

int
atoi(const char *s)
{
    17ea:	55                   	push   %ebp
    17eb:	89 e5                	mov    %esp,%ebp
    17ed:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    17f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    17f7:	eb 24                	jmp    181d <atoi+0x33>
    n = n*10 + *s++ - '0';
    17f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    17fc:	89 d0                	mov    %edx,%eax
    17fe:	c1 e0 02             	shl    $0x2,%eax
    1801:	01 d0                	add    %edx,%eax
    1803:	01 c0                	add    %eax,%eax
    1805:	89 c2                	mov    %eax,%edx
    1807:	8b 45 08             	mov    0x8(%ebp),%eax
    180a:	0f b6 00             	movzbl (%eax),%eax
    180d:	0f be c0             	movsbl %al,%eax
    1810:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1813:	83 e8 30             	sub    $0x30,%eax
    1816:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1819:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    181d:	8b 45 08             	mov    0x8(%ebp),%eax
    1820:	0f b6 00             	movzbl (%eax),%eax
    1823:	3c 2f                	cmp    $0x2f,%al
    1825:	7e 0a                	jle    1831 <atoi+0x47>
    1827:	8b 45 08             	mov    0x8(%ebp),%eax
    182a:	0f b6 00             	movzbl (%eax),%eax
    182d:	3c 39                	cmp    $0x39,%al
    182f:	7e c8                	jle    17f9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1831:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1834:	c9                   	leave  
    1835:	c3                   	ret    

00001836 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1836:	55                   	push   %ebp
    1837:	89 e5                	mov    %esp,%ebp
    1839:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    183c:	8b 45 08             	mov    0x8(%ebp),%eax
    183f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1842:	8b 45 0c             	mov    0xc(%ebp),%eax
    1845:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1848:	eb 13                	jmp    185d <memmove+0x27>
    *dst++ = *src++;
    184a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184d:	0f b6 10             	movzbl (%eax),%edx
    1850:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1853:	88 10                	mov    %dl,(%eax)
    1855:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1859:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    185d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1861:	0f 9f c0             	setg   %al
    1864:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1868:	84 c0                	test   %al,%al
    186a:	75 de                	jne    184a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    186c:	8b 45 08             	mov    0x8(%ebp),%eax
}
    186f:	c9                   	leave  
    1870:	c3                   	ret    
    1871:	90                   	nop
    1872:	90                   	nop
    1873:	90                   	nop

00001874 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1874:	b8 01 00 00 00       	mov    $0x1,%eax
    1879:	cd 40                	int    $0x40
    187b:	c3                   	ret    

0000187c <exit>:
SYSCALL(exit)
    187c:	b8 02 00 00 00       	mov    $0x2,%eax
    1881:	cd 40                	int    $0x40
    1883:	c3                   	ret    

00001884 <wait>:
SYSCALL(wait)
    1884:	b8 03 00 00 00       	mov    $0x3,%eax
    1889:	cd 40                	int    $0x40
    188b:	c3                   	ret    

0000188c <pipe>:
SYSCALL(pipe)
    188c:	b8 04 00 00 00       	mov    $0x4,%eax
    1891:	cd 40                	int    $0x40
    1893:	c3                   	ret    

00001894 <read>:
SYSCALL(read)
    1894:	b8 05 00 00 00       	mov    $0x5,%eax
    1899:	cd 40                	int    $0x40
    189b:	c3                   	ret    

0000189c <write>:
SYSCALL(write)
    189c:	b8 10 00 00 00       	mov    $0x10,%eax
    18a1:	cd 40                	int    $0x40
    18a3:	c3                   	ret    

000018a4 <close>:
SYSCALL(close)
    18a4:	b8 15 00 00 00       	mov    $0x15,%eax
    18a9:	cd 40                	int    $0x40
    18ab:	c3                   	ret    

000018ac <kill>:
SYSCALL(kill)
    18ac:	b8 06 00 00 00       	mov    $0x6,%eax
    18b1:	cd 40                	int    $0x40
    18b3:	c3                   	ret    

000018b4 <exec>:
SYSCALL(exec)
    18b4:	b8 07 00 00 00       	mov    $0x7,%eax
    18b9:	cd 40                	int    $0x40
    18bb:	c3                   	ret    

000018bc <open>:
SYSCALL(open)
    18bc:	b8 0f 00 00 00       	mov    $0xf,%eax
    18c1:	cd 40                	int    $0x40
    18c3:	c3                   	ret    

000018c4 <mknod>:
SYSCALL(mknod)
    18c4:	b8 11 00 00 00       	mov    $0x11,%eax
    18c9:	cd 40                	int    $0x40
    18cb:	c3                   	ret    

000018cc <unlink>:
SYSCALL(unlink)
    18cc:	b8 12 00 00 00       	mov    $0x12,%eax
    18d1:	cd 40                	int    $0x40
    18d3:	c3                   	ret    

000018d4 <fstat>:
SYSCALL(fstat)
    18d4:	b8 08 00 00 00       	mov    $0x8,%eax
    18d9:	cd 40                	int    $0x40
    18db:	c3                   	ret    

000018dc <link>:
SYSCALL(link)
    18dc:	b8 13 00 00 00       	mov    $0x13,%eax
    18e1:	cd 40                	int    $0x40
    18e3:	c3                   	ret    

000018e4 <mkdir>:
SYSCALL(mkdir)
    18e4:	b8 14 00 00 00       	mov    $0x14,%eax
    18e9:	cd 40                	int    $0x40
    18eb:	c3                   	ret    

000018ec <chdir>:
SYSCALL(chdir)
    18ec:	b8 09 00 00 00       	mov    $0x9,%eax
    18f1:	cd 40                	int    $0x40
    18f3:	c3                   	ret    

000018f4 <dup>:
SYSCALL(dup)
    18f4:	b8 0a 00 00 00       	mov    $0xa,%eax
    18f9:	cd 40                	int    $0x40
    18fb:	c3                   	ret    

000018fc <getpid>:
SYSCALL(getpid)
    18fc:	b8 0b 00 00 00       	mov    $0xb,%eax
    1901:	cd 40                	int    $0x40
    1903:	c3                   	ret    

00001904 <sbrk>:
SYSCALL(sbrk)
    1904:	b8 0c 00 00 00       	mov    $0xc,%eax
    1909:	cd 40                	int    $0x40
    190b:	c3                   	ret    

0000190c <sleep>:
SYSCALL(sleep)
    190c:	b8 0d 00 00 00       	mov    $0xd,%eax
    1911:	cd 40                	int    $0x40
    1913:	c3                   	ret    

00001914 <uptime>:
SYSCALL(uptime)
    1914:	b8 0e 00 00 00       	mov    $0xe,%eax
    1919:	cd 40                	int    $0x40
    191b:	c3                   	ret    

0000191c <clone>:
SYSCALL(clone)
    191c:	b8 16 00 00 00       	mov    $0x16,%eax
    1921:	cd 40                	int    $0x40
    1923:	c3                   	ret    

00001924 <texit>:
SYSCALL(texit)
    1924:	b8 17 00 00 00       	mov    $0x17,%eax
    1929:	cd 40                	int    $0x40
    192b:	c3                   	ret    

0000192c <tsleep>:
SYSCALL(tsleep)
    192c:	b8 18 00 00 00       	mov    $0x18,%eax
    1931:	cd 40                	int    $0x40
    1933:	c3                   	ret    

00001934 <twakeup>:
SYSCALL(twakeup)
    1934:	b8 19 00 00 00       	mov    $0x19,%eax
    1939:	cd 40                	int    $0x40
    193b:	c3                   	ret    

0000193c <thread_yield>:
SYSCALL(thread_yield) 
    193c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1941:	cd 40                	int    $0x40
    1943:	c3                   	ret    

00001944 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1944:	55                   	push   %ebp
    1945:	89 e5                	mov    %esp,%ebp
    1947:	83 ec 28             	sub    $0x28,%esp
    194a:	8b 45 0c             	mov    0xc(%ebp),%eax
    194d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1950:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1957:	00 
    1958:	8d 45 f4             	lea    -0xc(%ebp),%eax
    195b:	89 44 24 04          	mov    %eax,0x4(%esp)
    195f:	8b 45 08             	mov    0x8(%ebp),%eax
    1962:	89 04 24             	mov    %eax,(%esp)
    1965:	e8 32 ff ff ff       	call   189c <write>
}
    196a:	c9                   	leave  
    196b:	c3                   	ret    

0000196c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    196c:	55                   	push   %ebp
    196d:	89 e5                	mov    %esp,%ebp
    196f:	53                   	push   %ebx
    1970:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1973:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    197a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    197e:	74 17                	je     1997 <printint+0x2b>
    1980:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1984:	79 11                	jns    1997 <printint+0x2b>
    neg = 1;
    1986:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    198d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1990:	f7 d8                	neg    %eax
    1992:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1995:	eb 06                	jmp    199d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1997:	8b 45 0c             	mov    0xc(%ebp),%eax
    199a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    199d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    19a4:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    19a7:	8b 5d 10             	mov    0x10(%ebp),%ebx
    19aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ad:	ba 00 00 00 00       	mov    $0x0,%edx
    19b2:	f7 f3                	div    %ebx
    19b4:	89 d0                	mov    %edx,%eax
    19b6:	0f b6 80 dc 22 00 00 	movzbl 0x22dc(%eax),%eax
    19bd:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    19c1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    19c5:	8b 45 10             	mov    0x10(%ebp),%eax
    19c8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    19cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19ce:	ba 00 00 00 00       	mov    $0x0,%edx
    19d3:	f7 75 d4             	divl   -0x2c(%ebp)
    19d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    19d9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    19dd:	75 c5                	jne    19a4 <printint+0x38>
  if(neg)
    19df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    19e3:	74 28                	je     1a0d <printint+0xa1>
    buf[i++] = '-';
    19e5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19e8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    19ed:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    19f1:	eb 1a                	jmp    1a0d <printint+0xa1>
    putc(fd, buf[i]);
    19f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19f6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    19fb:	0f be c0             	movsbl %al,%eax
    19fe:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a02:	8b 45 08             	mov    0x8(%ebp),%eax
    1a05:	89 04 24             	mov    %eax,(%esp)
    1a08:	e8 37 ff ff ff       	call   1944 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1a0d:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1a11:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a15:	79 dc                	jns    19f3 <printint+0x87>
    putc(fd, buf[i]);
}
    1a17:	83 c4 44             	add    $0x44,%esp
    1a1a:	5b                   	pop    %ebx
    1a1b:	5d                   	pop    %ebp
    1a1c:	c3                   	ret    

00001a1d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1a1d:	55                   	push   %ebp
    1a1e:	89 e5                	mov    %esp,%ebp
    1a20:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1a23:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1a2a:	8d 45 0c             	lea    0xc(%ebp),%eax
    1a2d:	83 c0 04             	add    $0x4,%eax
    1a30:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1a33:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1a3a:	e9 7e 01 00 00       	jmp    1bbd <printf+0x1a0>
    c = fmt[i] & 0xff;
    1a3f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a42:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a45:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1a48:	0f b6 00             	movzbl (%eax),%eax
    1a4b:	0f be c0             	movsbl %al,%eax
    1a4e:	25 ff 00 00 00       	and    $0xff,%eax
    1a53:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1a56:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a5a:	75 2c                	jne    1a88 <printf+0x6b>
      if(c == '%'){
    1a5c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1a60:	75 0c                	jne    1a6e <printf+0x51>
        state = '%';
    1a62:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1a69:	e9 4b 01 00 00       	jmp    1bb9 <printf+0x19c>
      } else {
        putc(fd, c);
    1a6e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1a71:	0f be c0             	movsbl %al,%eax
    1a74:	89 44 24 04          	mov    %eax,0x4(%esp)
    1a78:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7b:	89 04 24             	mov    %eax,(%esp)
    1a7e:	e8 c1 fe ff ff       	call   1944 <putc>
    1a83:	e9 31 01 00 00       	jmp    1bb9 <printf+0x19c>
      }
    } else if(state == '%'){
    1a88:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1a8c:	0f 85 27 01 00 00    	jne    1bb9 <printf+0x19c>
      if(c == 'd'){
    1a92:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1a96:	75 2d                	jne    1ac5 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1a98:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9b:	8b 00                	mov    (%eax),%eax
    1a9d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1aa4:	00 
    1aa5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1aac:	00 
    1aad:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ab1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab4:	89 04 24             	mov    %eax,(%esp)
    1ab7:	e8 b0 fe ff ff       	call   196c <printint>
        ap++;
    1abc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1ac0:	e9 ed 00 00 00       	jmp    1bb2 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1ac5:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1ac9:	74 06                	je     1ad1 <printf+0xb4>
    1acb:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1acf:	75 2d                	jne    1afe <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1ad1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad4:	8b 00                	mov    (%eax),%eax
    1ad6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1add:	00 
    1ade:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1ae5:	00 
    1ae6:	89 44 24 04          	mov    %eax,0x4(%esp)
    1aea:	8b 45 08             	mov    0x8(%ebp),%eax
    1aed:	89 04 24             	mov    %eax,(%esp)
    1af0:	e8 77 fe ff ff       	call   196c <printint>
        ap++;
    1af5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1af9:	e9 b4 00 00 00       	jmp    1bb2 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1afe:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1b02:	75 46                	jne    1b4a <printf+0x12d>
        s = (char*)*ap;
    1b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b07:	8b 00                	mov    (%eax),%eax
    1b09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1b0c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1b10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1b14:	75 27                	jne    1b3d <printf+0x120>
          s = "(null)";
    1b16:	c7 45 e4 a8 22 00 00 	movl   $0x22a8,-0x1c(%ebp)
        while(*s != 0){
    1b1d:	eb 1f                	jmp    1b3e <printf+0x121>
          putc(fd, *s);
    1b1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b22:	0f b6 00             	movzbl (%eax),%eax
    1b25:	0f be c0             	movsbl %al,%eax
    1b28:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b2c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2f:	89 04 24             	mov    %eax,(%esp)
    1b32:	e8 0d fe ff ff       	call   1944 <putc>
          s++;
    1b37:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1b3b:	eb 01                	jmp    1b3e <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1b3d:	90                   	nop
    1b3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1b41:	0f b6 00             	movzbl (%eax),%eax
    1b44:	84 c0                	test   %al,%al
    1b46:	75 d7                	jne    1b1f <printf+0x102>
    1b48:	eb 68                	jmp    1bb2 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1b4a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1b4e:	75 1d                	jne    1b6d <printf+0x150>
        putc(fd, *ap);
    1b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b53:	8b 00                	mov    (%eax),%eax
    1b55:	0f be c0             	movsbl %al,%eax
    1b58:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5f:	89 04 24             	mov    %eax,(%esp)
    1b62:	e8 dd fd ff ff       	call   1944 <putc>
        ap++;
    1b67:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1b6b:	eb 45                	jmp    1bb2 <printf+0x195>
      } else if(c == '%'){
    1b6d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1b71:	75 17                	jne    1b8a <printf+0x16d>
        putc(fd, c);
    1b73:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1b76:	0f be c0             	movsbl %al,%eax
    1b79:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b80:	89 04 24             	mov    %eax,(%esp)
    1b83:	e8 bc fd ff ff       	call   1944 <putc>
    1b88:	eb 28                	jmp    1bb2 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1b8a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1b91:	00 
    1b92:	8b 45 08             	mov    0x8(%ebp),%eax
    1b95:	89 04 24             	mov    %eax,(%esp)
    1b98:	e8 a7 fd ff ff       	call   1944 <putc>
        putc(fd, c);
    1b9d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1ba0:	0f be c0             	movsbl %al,%eax
    1ba3:	89 44 24 04          	mov    %eax,0x4(%esp)
    1ba7:	8b 45 08             	mov    0x8(%ebp),%eax
    1baa:	89 04 24             	mov    %eax,(%esp)
    1bad:	e8 92 fd ff ff       	call   1944 <putc>
      }
      state = 0;
    1bb2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1bb9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1bbd:	8b 55 0c             	mov    0xc(%ebp),%edx
    1bc0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1bc3:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1bc6:	0f b6 00             	movzbl (%eax),%eax
    1bc9:	84 c0                	test   %al,%al
    1bcb:	0f 85 6e fe ff ff    	jne    1a3f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1bd1:	c9                   	leave  
    1bd2:	c3                   	ret    
    1bd3:	90                   	nop

00001bd4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1bd4:	55                   	push   %ebp
    1bd5:	89 e5                	mov    %esp,%ebp
    1bd7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1bda:	8b 45 08             	mov    0x8(%ebp),%eax
    1bdd:	83 e8 08             	sub    $0x8,%eax
    1be0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1be3:	a1 08 23 00 00       	mov    0x2308,%eax
    1be8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1beb:	eb 24                	jmp    1c11 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1bed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1bf0:	8b 00                	mov    (%eax),%eax
    1bf2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1bf5:	77 12                	ja     1c09 <free+0x35>
    1bf7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1bfa:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1bfd:	77 24                	ja     1c23 <free+0x4f>
    1bff:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c02:	8b 00                	mov    (%eax),%eax
    1c04:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c07:	77 1a                	ja     1c23 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1c09:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c0c:	8b 00                	mov    (%eax),%eax
    1c0e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1c11:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c14:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1c17:	76 d4                	jbe    1bed <free+0x19>
    1c19:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c1c:	8b 00                	mov    (%eax),%eax
    1c1e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c21:	76 ca                	jbe    1bed <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1c23:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c26:	8b 40 04             	mov    0x4(%eax),%eax
    1c29:	c1 e0 03             	shl    $0x3,%eax
    1c2c:	89 c2                	mov    %eax,%edx
    1c2e:	03 55 f8             	add    -0x8(%ebp),%edx
    1c31:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c34:	8b 00                	mov    (%eax),%eax
    1c36:	39 c2                	cmp    %eax,%edx
    1c38:	75 24                	jne    1c5e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1c3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c3d:	8b 50 04             	mov    0x4(%eax),%edx
    1c40:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c43:	8b 00                	mov    (%eax),%eax
    1c45:	8b 40 04             	mov    0x4(%eax),%eax
    1c48:	01 c2                	add    %eax,%edx
    1c4a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c4d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1c50:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c53:	8b 00                	mov    (%eax),%eax
    1c55:	8b 10                	mov    (%eax),%edx
    1c57:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c5a:	89 10                	mov    %edx,(%eax)
    1c5c:	eb 0a                	jmp    1c68 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1c5e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c61:	8b 10                	mov    (%eax),%edx
    1c63:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c66:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1c68:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c6b:	8b 40 04             	mov    0x4(%eax),%eax
    1c6e:	c1 e0 03             	shl    $0x3,%eax
    1c71:	03 45 fc             	add    -0x4(%ebp),%eax
    1c74:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1c77:	75 20                	jne    1c99 <free+0xc5>
    p->s.size += bp->s.size;
    1c79:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c7c:	8b 50 04             	mov    0x4(%eax),%edx
    1c7f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c82:	8b 40 04             	mov    0x4(%eax),%eax
    1c85:	01 c2                	add    %eax,%edx
    1c87:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c8a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1c8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1c90:	8b 10                	mov    (%eax),%edx
    1c92:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c95:	89 10                	mov    %edx,(%eax)
    1c97:	eb 08                	jmp    1ca1 <free+0xcd>
  } else
    p->s.ptr = bp;
    1c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1c9c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1c9f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1ca1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1ca4:	a3 08 23 00 00       	mov    %eax,0x2308
}
    1ca9:	c9                   	leave  
    1caa:	c3                   	ret    

00001cab <morecore>:

static Header*
morecore(uint nu)
{
    1cab:	55                   	push   %ebp
    1cac:	89 e5                	mov    %esp,%ebp
    1cae:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1cb1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1cb8:	77 07                	ja     1cc1 <morecore+0x16>
    nu = 4096;
    1cba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1cc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc4:	c1 e0 03             	shl    $0x3,%eax
    1cc7:	89 04 24             	mov    %eax,(%esp)
    1cca:	e8 35 fc ff ff       	call   1904 <sbrk>
    1ccf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1cd2:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1cd6:	75 07                	jne    1cdf <morecore+0x34>
    return 0;
    1cd8:	b8 00 00 00 00       	mov    $0x0,%eax
    1cdd:	eb 22                	jmp    1d01 <morecore+0x56>
  hp = (Header*)p;
    1cdf:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ce2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1ce5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ce8:	8b 55 08             	mov    0x8(%ebp),%edx
    1ceb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1cee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cf1:	83 c0 08             	add    $0x8,%eax
    1cf4:	89 04 24             	mov    %eax,(%esp)
    1cf7:	e8 d8 fe ff ff       	call   1bd4 <free>
  return freep;
    1cfc:	a1 08 23 00 00       	mov    0x2308,%eax
}
    1d01:	c9                   	leave  
    1d02:	c3                   	ret    

00001d03 <malloc>:

void*
malloc(uint nbytes)
{
    1d03:	55                   	push   %ebp
    1d04:	89 e5                	mov    %esp,%ebp
    1d06:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1d09:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0c:	83 c0 07             	add    $0x7,%eax
    1d0f:	c1 e8 03             	shr    $0x3,%eax
    1d12:	83 c0 01             	add    $0x1,%eax
    1d15:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1d18:	a1 08 23 00 00       	mov    0x2308,%eax
    1d1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1d20:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1d24:	75 23                	jne    1d49 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1d26:	c7 45 f0 00 23 00 00 	movl   $0x2300,-0x10(%ebp)
    1d2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d30:	a3 08 23 00 00       	mov    %eax,0x2308
    1d35:	a1 08 23 00 00       	mov    0x2308,%eax
    1d3a:	a3 00 23 00 00       	mov    %eax,0x2300
    base.s.size = 0;
    1d3f:	c7 05 04 23 00 00 00 	movl   $0x0,0x2304
    1d46:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d4c:	8b 00                	mov    (%eax),%eax
    1d4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1d51:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d54:	8b 40 04             	mov    0x4(%eax),%eax
    1d57:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1d5a:	72 4d                	jb     1da9 <malloc+0xa6>
      if(p->s.size == nunits)
    1d5c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d5f:	8b 40 04             	mov    0x4(%eax),%eax
    1d62:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1d65:	75 0c                	jne    1d73 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1d67:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d6a:	8b 10                	mov    (%eax),%edx
    1d6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d6f:	89 10                	mov    %edx,(%eax)
    1d71:	eb 26                	jmp    1d99 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1d73:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d76:	8b 40 04             	mov    0x4(%eax),%eax
    1d79:	89 c2                	mov    %eax,%edx
    1d7b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1d7e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d81:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1d84:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d87:	8b 40 04             	mov    0x4(%eax),%eax
    1d8a:	c1 e0 03             	shl    $0x3,%eax
    1d8d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1d90:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1d93:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d96:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1d99:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d9c:	a3 08 23 00 00       	mov    %eax,0x2308
      return (void*)(p + 1);
    1da1:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1da4:	83 c0 08             	add    $0x8,%eax
    1da7:	eb 38                	jmp    1de1 <malloc+0xde>
    }
    if(p == freep)
    1da9:	a1 08 23 00 00       	mov    0x2308,%eax
    1dae:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1db1:	75 1b                	jne    1dce <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1db6:	89 04 24             	mov    %eax,(%esp)
    1db9:	e8 ed fe ff ff       	call   1cab <morecore>
    1dbe:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1dc1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1dc5:	75 07                	jne    1dce <malloc+0xcb>
        return 0;
    1dc7:	b8 00 00 00 00       	mov    $0x0,%eax
    1dcc:	eb 13                	jmp    1de1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1dce:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1dd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1dd4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1dd7:	8b 00                	mov    (%eax),%eax
    1dd9:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1ddc:	e9 70 ff ff ff       	jmp    1d51 <malloc+0x4e>
}
    1de1:	c9                   	leave  
    1de2:	c3                   	ret    
    1de3:	90                   	nop

00001de4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1de4:	55                   	push   %ebp
    1de5:	89 e5                	mov    %esp,%ebp
    1de7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1dea:	8b 55 08             	mov    0x8(%ebp),%edx
    1ded:	8b 45 0c             	mov    0xc(%ebp),%eax
    1df0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1df3:	f0 87 02             	lock xchg %eax,(%edx)
    1df6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1df9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1dfc:	c9                   	leave  
    1dfd:	c3                   	ret    

00001dfe <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1dfe:	55                   	push   %ebp
    1dff:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1e01:	8b 45 08             	mov    0x8(%ebp),%eax
    1e04:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1e0a:	5d                   	pop    %ebp
    1e0b:	c3                   	ret    

00001e0c <lock_acquire>:
void lock_acquire(lock_t *lock){
    1e0c:	55                   	push   %ebp
    1e0d:	89 e5                	mov    %esp,%ebp
    1e0f:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1e12:	8b 45 08             	mov    0x8(%ebp),%eax
    1e15:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1e1c:	00 
    1e1d:	89 04 24             	mov    %eax,(%esp)
    1e20:	e8 bf ff ff ff       	call   1de4 <xchg>
    1e25:	85 c0                	test   %eax,%eax
    1e27:	75 e9                	jne    1e12 <lock_acquire+0x6>
}
    1e29:	c9                   	leave  
    1e2a:	c3                   	ret    

00001e2b <lock_release>:
void lock_release(lock_t *lock){
    1e2b:	55                   	push   %ebp
    1e2c:	89 e5                	mov    %esp,%ebp
    1e2e:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1e31:	8b 45 08             	mov    0x8(%ebp),%eax
    1e34:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1e3b:	00 
    1e3c:	89 04 24             	mov    %eax,(%esp)
    1e3f:	e8 a0 ff ff ff       	call   1de4 <xchg>
}
    1e44:	c9                   	leave  
    1e45:	c3                   	ret    

00001e46 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1e46:	55                   	push   %ebp
    1e47:	89 e5                	mov    %esp,%ebp
    1e49:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1e4c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1e53:	e8 ab fe ff ff       	call   1d03 <malloc>
    1e58:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1e5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e5e:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1e61:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e64:	25 ff 0f 00 00       	and    $0xfff,%eax
    1e69:	85 c0                	test   %eax,%eax
    1e6b:	74 15                	je     1e82 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1e70:	89 c2                	mov    %eax,%edx
    1e72:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1e78:	b8 00 10 00 00       	mov    $0x1000,%eax
    1e7d:	29 d0                	sub    %edx,%eax
    1e7f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1e82:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e86:	75 1b                	jne    1ea3 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1e88:	c7 44 24 04 af 22 00 	movl   $0x22af,0x4(%esp)
    1e8f:	00 
    1e90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1e97:	e8 81 fb ff ff       	call   1a1d <printf>
        return 0;
    1e9c:	b8 00 00 00 00       	mov    $0x0,%eax
    1ea1:	eb 6f                	jmp    1f12 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1ea3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1ea6:	8b 55 08             	mov    0x8(%ebp),%edx
    1ea9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1eac:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1eb0:	89 54 24 08          	mov    %edx,0x8(%esp)
    1eb4:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1ebb:	00 
    1ebc:	89 04 24             	mov    %eax,(%esp)
    1ebf:	e8 58 fa ff ff       	call   191c <clone>
    1ec4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1ec7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ecb:	79 1b                	jns    1ee8 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1ecd:	c7 44 24 04 bd 22 00 	movl   $0x22bd,0x4(%esp)
    1ed4:	00 
    1ed5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1edc:	e8 3c fb ff ff       	call   1a1d <printf>
        return 0;
    1ee1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ee6:	eb 2a                	jmp    1f12 <thread_create+0xcc>
    }
    if(tid > 0){
    1ee8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1eec:	7e 05                	jle    1ef3 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1eee:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ef1:	eb 1f                	jmp    1f12 <thread_create+0xcc>
    }
    if(tid == 0){
    1ef3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ef7:	75 14                	jne    1f0d <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1ef9:	c7 44 24 04 ca 22 00 	movl   $0x22ca,0x4(%esp)
    1f00:	00 
    1f01:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1f08:	e8 10 fb ff ff       	call   1a1d <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1f0d:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1f12:	c9                   	leave  
    1f13:	c3                   	ret    

00001f14 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1f14:	55                   	push   %ebp
    1f15:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1f17:	a1 f0 22 00 00       	mov    0x22f0,%eax
    1f1c:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1f22:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1f27:	a3 f0 22 00 00       	mov    %eax,0x22f0
    return (int)(rands % max);
    1f2c:	a1 f0 22 00 00       	mov    0x22f0,%eax
    1f31:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1f34:	ba 00 00 00 00       	mov    $0x0,%edx
    1f39:	f7 f1                	div    %ecx
    1f3b:	89 d0                	mov    %edx,%eax
}
    1f3d:	5d                   	pop    %ebp
    1f3e:	c3                   	ret    
    1f3f:	90                   	nop

00001f40 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1f40:	55                   	push   %ebp
    1f41:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1f43:	8b 45 08             	mov    0x8(%ebp),%eax
    1f46:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1f4c:	8b 45 08             	mov    0x8(%ebp),%eax
    1f4f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1f56:	8b 45 08             	mov    0x8(%ebp),%eax
    1f59:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1f60:	5d                   	pop    %ebp
    1f61:	c3                   	ret    

00001f62 <add_q>:

void add_q(struct queue *q, int v){
    1f62:	55                   	push   %ebp
    1f63:	89 e5                	mov    %esp,%ebp
    1f65:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1f68:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1f6f:	e8 8f fd ff ff       	call   1d03 <malloc>
    1f74:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1f77:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f7a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1f81:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f84:	8b 55 0c             	mov    0xc(%ebp),%edx
    1f87:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1f89:	8b 45 08             	mov    0x8(%ebp),%eax
    1f8c:	8b 40 04             	mov    0x4(%eax),%eax
    1f8f:	85 c0                	test   %eax,%eax
    1f91:	75 0b                	jne    1f9e <add_q+0x3c>
        q->head = n;
    1f93:	8b 45 08             	mov    0x8(%ebp),%eax
    1f96:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1f99:	89 50 04             	mov    %edx,0x4(%eax)
    1f9c:	eb 0c                	jmp    1faa <add_q+0x48>
    }else{
        q->tail->next = n;
    1f9e:	8b 45 08             	mov    0x8(%ebp),%eax
    1fa1:	8b 40 08             	mov    0x8(%eax),%eax
    1fa4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1fa7:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1faa:	8b 45 08             	mov    0x8(%ebp),%eax
    1fad:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1fb0:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1fb3:	8b 45 08             	mov    0x8(%ebp),%eax
    1fb6:	8b 00                	mov    (%eax),%eax
    1fb8:	8d 50 01             	lea    0x1(%eax),%edx
    1fbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1fbe:	89 10                	mov    %edx,(%eax)
}
    1fc0:	c9                   	leave  
    1fc1:	c3                   	ret    

00001fc2 <empty_q>:

int empty_q(struct queue *q){
    1fc2:	55                   	push   %ebp
    1fc3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1fc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1fc8:	8b 00                	mov    (%eax),%eax
    1fca:	85 c0                	test   %eax,%eax
    1fcc:	75 07                	jne    1fd5 <empty_q+0x13>
        return 1;
    1fce:	b8 01 00 00 00       	mov    $0x1,%eax
    1fd3:	eb 05                	jmp    1fda <empty_q+0x18>
    else
        return 0;
    1fd5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1fda:	5d                   	pop    %ebp
    1fdb:	c3                   	ret    

00001fdc <pop_q>:
int pop_q(struct queue *q){
    1fdc:	55                   	push   %ebp
    1fdd:	89 e5                	mov    %esp,%ebp
    1fdf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1fe2:	8b 45 08             	mov    0x8(%ebp),%eax
    1fe5:	89 04 24             	mov    %eax,(%esp)
    1fe8:	e8 d5 ff ff ff       	call   1fc2 <empty_q>
    1fed:	85 c0                	test   %eax,%eax
    1fef:	75 5d                	jne    204e <pop_q+0x72>
       val = q->head->value; 
    1ff1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ff4:	8b 40 04             	mov    0x4(%eax),%eax
    1ff7:	8b 00                	mov    (%eax),%eax
    1ff9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1ffc:	8b 45 08             	mov    0x8(%ebp),%eax
    1fff:	8b 40 04             	mov    0x4(%eax),%eax
    2002:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    2005:	8b 45 08             	mov    0x8(%ebp),%eax
    2008:	8b 40 04             	mov    0x4(%eax),%eax
    200b:	8b 50 04             	mov    0x4(%eax),%edx
    200e:	8b 45 08             	mov    0x8(%ebp),%eax
    2011:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    2014:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2017:	89 04 24             	mov    %eax,(%esp)
    201a:	e8 b5 fb ff ff       	call   1bd4 <free>
       q->size--;
    201f:	8b 45 08             	mov    0x8(%ebp),%eax
    2022:	8b 00                	mov    (%eax),%eax
    2024:	8d 50 ff             	lea    -0x1(%eax),%edx
    2027:	8b 45 08             	mov    0x8(%ebp),%eax
    202a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    202c:	8b 45 08             	mov    0x8(%ebp),%eax
    202f:	8b 00                	mov    (%eax),%eax
    2031:	85 c0                	test   %eax,%eax
    2033:	75 14                	jne    2049 <pop_q+0x6d>
            q->head = 0;
    2035:	8b 45 08             	mov    0x8(%ebp),%eax
    2038:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    203f:	8b 45 08             	mov    0x8(%ebp),%eax
    2042:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    2049:	8b 45 f0             	mov    -0x10(%ebp),%eax
    204c:	eb 05                	jmp    2053 <pop_q+0x77>
    }
    return -1;
    204e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    2053:	c9                   	leave  
    2054:	c3                   	ret    
    2055:	90                   	nop
    2056:	90                   	nop
    2057:	90                   	nop

00002058 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    2058:	55                   	push   %ebp
    2059:	89 e5                	mov    %esp,%ebp
    205b:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    205e:	8b 45 08             	mov    0x8(%ebp),%eax
    2061:	89 04 24             	mov    %eax,(%esp)
    2064:	e8 a3 fd ff ff       	call   1e0c <lock_acquire>
	s->count--; 
    2069:	8b 45 08             	mov    0x8(%ebp),%eax
    206c:	8b 40 04             	mov    0x4(%eax),%eax
    206f:	8d 50 ff             	lea    -0x1(%eax),%edx
    2072:	8b 45 08             	mov    0x8(%ebp),%eax
    2075:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    2078:	8b 45 08             	mov    0x8(%ebp),%eax
    207b:	8b 40 04             	mov    0x4(%eax),%eax
    207e:	85 c0                	test   %eax,%eax
    2080:	79 27                	jns    20a9 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    2082:	e8 75 f8 ff ff       	call   18fc <getpid>
    2087:	8b 55 08             	mov    0x8(%ebp),%edx
    208a:	83 c2 08             	add    $0x8,%edx
    208d:	89 44 24 04          	mov    %eax,0x4(%esp)
    2091:	89 14 24             	mov    %edx,(%esp)
    2094:	e8 c9 fe ff ff       	call   1f62 <add_q>
		lock_release(&s->lock); 
    2099:	8b 45 08             	mov    0x8(%ebp),%eax
    209c:	89 04 24             	mov    %eax,(%esp)
    209f:	e8 87 fd ff ff       	call   1e2b <lock_release>
		tsleep(); 
    20a4:	e8 83 f8 ff ff       	call   192c <tsleep>
	} 
	lock_release(&s->lock); 
    20a9:	8b 45 08             	mov    0x8(%ebp),%eax
    20ac:	89 04 24             	mov    %eax,(%esp)
    20af:	e8 77 fd ff ff       	call   1e2b <lock_release>
}
    20b4:	c9                   	leave  
    20b5:	c3                   	ret    

000020b6 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    20b6:	55                   	push   %ebp
    20b7:	89 e5                	mov    %esp,%ebp
    20b9:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    20bc:	8b 45 08             	mov    0x8(%ebp),%eax
    20bf:	89 04 24             	mov    %eax,(%esp)
    20c2:	e8 45 fd ff ff       	call   1e0c <lock_acquire>
	s->count++; 
    20c7:	8b 45 08             	mov    0x8(%ebp),%eax
    20ca:	8b 40 04             	mov    0x4(%eax),%eax
    20cd:	8d 50 01             	lea    0x1(%eax),%edx
    20d0:	8b 45 08             	mov    0x8(%ebp),%eax
    20d3:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    20d6:	8b 45 08             	mov    0x8(%ebp),%eax
    20d9:	8b 40 04             	mov    0x4(%eax),%eax
    20dc:	85 c0                	test   %eax,%eax
    20de:	7f 1c                	jg     20fc <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    20e0:	8b 45 08             	mov    0x8(%ebp),%eax
    20e3:	83 c0 08             	add    $0x8,%eax
    20e6:	89 04 24             	mov    %eax,(%esp)
    20e9:	e8 ee fe ff ff       	call   1fdc <pop_q>
    20ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    20f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    20f4:	89 04 24             	mov    %eax,(%esp)
    20f7:	e8 38 f8 ff ff       	call   1934 <twakeup>
	}
	lock_release(&s->lock); 
    20fc:	8b 45 08             	mov    0x8(%ebp),%eax
    20ff:	89 04 24             	mov    %eax,(%esp)
    2102:	e8 24 fd ff ff       	call   1e2b <lock_release>
} 
    2107:	c9                   	leave  
    2108:	c3                   	ret    

00002109 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    2109:	55                   	push   %ebp
    210a:	89 e5                	mov    %esp,%ebp
    210c:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    210f:	8b 45 08             	mov    0x8(%ebp),%eax
    2112:	89 04 24             	mov    %eax,(%esp)
    2115:	e8 e4 fc ff ff       	call   1dfe <lock_init>
	s->count = size; 
    211a:	8b 45 08             	mov    0x8(%ebp),%eax
    211d:	8b 55 0c             	mov    0xc(%ebp),%edx
    2120:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    2123:	8b 45 08             	mov    0x8(%ebp),%eax
    2126:	83 c0 08             	add    $0x8,%eax
    2129:	89 04 24             	mov    %eax,(%esp)
    212c:	e8 0f fe ff ff       	call   1f40 <init_q>
}
    2131:	c9                   	leave  
    2132:	c3                   	ret    
