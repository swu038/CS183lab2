
_domMonkey:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
int dmonk = 0;
struct{
	lock_t lock; 
}mutex; 

int main(){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 30             	sub    $0x30,%esp
  
  lock_acquire(&mutex.lock); 
    1009:	c7 04 24 00 1f 00 00 	movl   $0x1f00,(%esp)
    1010:	e8 df 0a 00 00       	call   1af4 <lock_acquire>
  printf(1,"We created 3 dominant monkey, and four regular monkeys\n" ); 
    1015:	c7 44 24 04 1c 1e 00 	movl   $0x1e1c,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 dc 06 00 00       	call   1705 <printf>
  lock_release(&mutex.lock); 
    1029:	c7 04 24 00 1f 00 00 	movl   $0x1f00,(%esp)
    1030:	e8 de 0a 00 00       	call   1b13 <lock_release>

  sem_init(&tree, 3);
    1035:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
    1044:	e8 a8 0d 00 00       	call   1df1 <sem_init>
  sem_init(&dom, 1);
    1049:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 04 1f 00 00 	movl   $0x1f04,(%esp)
    1058:	e8 94 0d 00 00       	call   1df1 <sem_init>

  void* cid = thread_create(dominant, (void*)&dmonk);
    105d:	c7 44 24 04 f0 1e 00 	movl   $0x1ef0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 6d 12 00 00 	movl   $0x126d,(%esp)
    106c:	e8 bd 0a 00 00       	call   1b2e <thread_create>
    1071:	89 44 24 14          	mov    %eax,0x14(%esp)
  if(cid == 0) exit(); 
    1075:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 e3 04 00 00       	call   1564 <exit>
  void* nid = thread_create(monkey, (void*)&monkeys);
    1081:	c7 44 24 04 ec 1e 00 	movl   $0x1eec,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 9e 11 00 00 	movl   $0x119e,(%esp)
    1090:	e8 99 0a 00 00       	call   1b2e <thread_create>
    1095:	89 44 24 18          	mov    %eax,0x18(%esp)
  if(nid == 0) exit();
    1099:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 bf 04 00 00       	call   1564 <exit>
  void* oid = thread_create(monkey, (void*)&monkeys);
    10a5:	c7 44 24 04 ec 1e 00 	movl   $0x1eec,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 9e 11 00 00 	movl   $0x119e,(%esp)
    10b4:	e8 75 0a 00 00       	call   1b2e <thread_create>
    10b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
  if(oid == 0) exit();
    10bd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 9b 04 00 00       	call   1564 <exit>
  void* bid = thread_create(dominant, (void*)&dmonk);
    10c9:	c7 44 24 04 f0 1e 00 	movl   $0x1ef0,0x4(%esp)
    10d0:	00 
    10d1:	c7 04 24 6d 12 00 00 	movl   $0x126d,(%esp)
    10d8:	e8 51 0a 00 00       	call   1b2e <thread_create>
    10dd:	89 44 24 20          	mov    %eax,0x20(%esp)
  if(bid == 0) exit();
    10e1:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
    10e6:	75 05                	jne    10ed <main+0xed>
    10e8:	e8 77 04 00 00       	call   1564 <exit>
  void* pid = thread_create(monkey, (void*)&monkeys);
    10ed:	c7 44 24 04 ec 1e 00 	movl   $0x1eec,0x4(%esp)
    10f4:	00 
    10f5:	c7 04 24 9e 11 00 00 	movl   $0x119e,(%esp)
    10fc:	e8 2d 0a 00 00       	call   1b2e <thread_create>
    1101:	89 44 24 24          	mov    %eax,0x24(%esp)
  if(pid == 0) exit();
    1105:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
    110a:	75 05                	jne    1111 <main+0x111>
    110c:	e8 53 04 00 00       	call   1564 <exit>
  void* qid = thread_create(monkey, (void*)&monkeys);
    1111:	c7 44 24 04 ec 1e 00 	movl   $0x1eec,0x4(%esp)
    1118:	00 
    1119:	c7 04 24 9e 11 00 00 	movl   $0x119e,(%esp)
    1120:	e8 09 0a 00 00       	call   1b2e <thread_create>
    1125:	89 44 24 28          	mov    %eax,0x28(%esp)
  if(qid == 0) exit();
    1129:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
    112e:	75 05                	jne    1135 <main+0x135>
    1130:	e8 2f 04 00 00       	call   1564 <exit>
  void* did = thread_create(dominant, (void*)&dmonk);
    1135:	c7 44 24 04 f0 1e 00 	movl   $0x1ef0,0x4(%esp)
    113c:	00 
    113d:	c7 04 24 6d 12 00 00 	movl   $0x126d,(%esp)
    1144:	e8 e5 09 00 00       	call   1b2e <thread_create>
    1149:	89 44 24 2c          	mov    %eax,0x2c(%esp)
  if(did == 0) exit();
    114d:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
    1152:	75 05                	jne    1159 <main+0x159>
    1154:	e8 0b 04 00 00       	call   1564 <exit>
  wait();
    1159:	e8 0e 04 00 00       	call   156c <wait>
  wait();
    115e:	e8 09 04 00 00       	call   156c <wait>
  wait();
    1163:	e8 04 04 00 00       	call   156c <wait>
  wait();
    1168:	e8 ff 03 00 00       	call   156c <wait>
  wait();
    116d:	e8 fa 03 00 00       	call   156c <wait>
  wait();
    1172:	e8 f5 03 00 00       	call   156c <wait>
  wait();
    1177:	e8 f0 03 00 00       	call   156c <wait>
  
  printf(1, "Coconuts: %d.\n", coconut_grabbed);
    117c:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    1181:	89 44 24 08          	mov    %eax,0x8(%esp)
    1185:	c7 44 24 04 54 1e 00 	movl   $0x1e54,0x4(%esp)
    118c:	00 
    118d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1194:	e8 6c 05 00 00       	call   1705 <printf>
  exit();
    1199:	e8 c6 03 00 00       	call   1564 <exit>

0000119e <monkey>:
  return 0;
}

void monkey(void* arg){
    119e:	55                   	push   %ebp
    119f:	89 e5                	mov    %esp,%ebp
    11a1:	83 ec 18             	sub    $0x18,%esp
    
  monkeys++;
    11a4:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    11a9:	83 c0 01             	add    $0x1,%eax
    11ac:	a3 ec 1e 00 00       	mov    %eax,0x1eec
  printf(1, "Monkeys %d.\n", monkeys);
    11b1:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    11b6:	89 44 24 08          	mov    %eax,0x8(%esp)
    11ba:	c7 44 24 04 63 1e 00 	movl   $0x1e63,0x4(%esp)
    11c1:	00 
    11c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c9:	e8 37 05 00 00       	call   1705 <printf>
  if(dmonk ==  1){
    11ce:	a1 f0 1e 00 00       	mov    0x1ef0,%eax
    11d3:	83 f8 01             	cmp    $0x1,%eax
    11d6:	75 20                	jne    11f8 <monkey+0x5a>
    printf(1, "waiting\n");
    11d8:	c7 44 24 04 70 1e 00 	movl   $0x1e70,0x4(%esp)
    11df:	00 
    11e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11e7:	e8 19 05 00 00       	call   1705 <printf>
    sem_acquire(&dom);
    11ec:	c7 04 24 04 1f 00 00 	movl   $0x1f04,(%esp)
    11f3:	e8 48 0b 00 00       	call   1d40 <sem_acquire>
  }
 
  sem_acquire(&tree);
    11f8:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
    11ff:	e8 3c 0b 00 00       	call   1d40 <sem_acquire>
  sleep(20);  
    1204:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
    120b:	e8 e4 03 00 00       	call   15f4 <sleep>
  coconut_grabbed++;
    1210:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    1215:	83 c0 01             	add    $0x1,%eax
    1218:	a3 e8 1e 00 00       	mov    %eax,0x1ee8
  sem_signal(&tree);
    121d:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
    1224:	e8 75 0b 00 00       	call   1d9e <sem_signal>
  
  monkeys--;
    1229:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    122e:	83 e8 01             	sub    $0x1,%eax
    1231:	a3 ec 1e 00 00       	mov    %eax,0x1eec
  printf(1, "Monkeys out  %d.\n", monkeys);
    1236:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    123b:	89 44 24 08          	mov    %eax,0x8(%esp)
    123f:	c7 44 24 04 79 1e 00 	movl   $0x1e79,0x4(%esp)
    1246:	00 
    1247:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    124e:	e8 b2 04 00 00       	call   1705 <printf>
  if(dmonk >= 0)
    1253:	a1 f0 1e 00 00       	mov    0x1ef0,%eax
    1258:	85 c0                	test   %eax,%eax
    125a:	78 0c                	js     1268 <monkey+0xca>
      sem_signal(&dom);
    125c:	c7 04 24 04 1f 00 00 	movl   $0x1f04,(%esp)
    1263:	e8 36 0b 00 00       	call   1d9e <sem_signal>

  texit();
    1268:	e8 9f 03 00 00       	call   160c <texit>

0000126d <dominant>:
}

void dominant(void* arg){
    126d:	55                   	push   %ebp
    126e:	89 e5                	mov    %esp,%ebp
    1270:	83 ec 18             	sub    $0x18,%esp

  printf(1, "Dominant Monkey.\n");
    1273:	c7 44 24 04 8b 1e 00 	movl   $0x1e8b,0x4(%esp)
    127a:	00 
    127b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1282:	e8 7e 04 00 00       	call   1705 <printf>
  sem_acquire(&dom);
    1287:	c7 04 24 04 1f 00 00 	movl   $0x1f04,(%esp)
    128e:	e8 ad 0a 00 00       	call   1d40 <sem_acquire>
  dmonk++;
    1293:	a1 f0 1e 00 00       	mov    0x1ef0,%eax
    1298:	83 c0 01             	add    $0x1,%eax
    129b:	a3 f0 1e 00 00       	mov    %eax,0x1ef0
  sem_acquire(&tree);
    12a0:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
    12a7:	e8 94 0a 00 00       	call   1d40 <sem_acquire>
  monkeys++;
    12ac:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    12b1:	83 c0 01             	add    $0x1,%eax
    12b4:	a3 ec 1e 00 00       	mov    %eax,0x1eec
  coconut_grabbed++;
    12b9:	a1 e8 1e 00 00       	mov    0x1ee8,%eax
    12be:	83 c0 01             	add    $0x1,%eax
    12c1:	a3 e8 1e 00 00       	mov    %eax,0x1ee8
  monkeys--;
    12c6:	a1 ec 1e 00 00       	mov    0x1eec,%eax
    12cb:	83 e8 01             	sub    $0x1,%eax
    12ce:	a3 ec 1e 00 00       	mov    %eax,0x1eec
  dmonk--;
    12d3:	a1 f0 1e 00 00       	mov    0x1ef0,%eax
    12d8:	83 e8 01             	sub    $0x1,%eax
    12db:	a3 f0 1e 00 00       	mov    %eax,0x1ef0
  sem_signal(&tree);
    12e0:	c7 04 24 18 1f 00 00 	movl   $0x1f18,(%esp)
    12e7:	e8 b2 0a 00 00       	call   1d9e <sem_signal>
   sem_signal(&dom);
    12ec:	c7 04 24 04 1f 00 00 	movl   $0x1f04,(%esp)
    12f3:	e8 a6 0a 00 00       	call   1d9e <sem_signal>
          
  texit();
    12f8:	e8 0f 03 00 00       	call   160c <texit>
    12fd:	90                   	nop
    12fe:	90                   	nop
    12ff:	90                   	nop

00001300 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	57                   	push   %edi
    1304:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1305:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1308:	8b 55 10             	mov    0x10(%ebp),%edx
    130b:	8b 45 0c             	mov    0xc(%ebp),%eax
    130e:	89 cb                	mov    %ecx,%ebx
    1310:	89 df                	mov    %ebx,%edi
    1312:	89 d1                	mov    %edx,%ecx
    1314:	fc                   	cld    
    1315:	f3 aa                	rep stos %al,%es:(%edi)
    1317:	89 ca                	mov    %ecx,%edx
    1319:	89 fb                	mov    %edi,%ebx
    131b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    131e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1321:	5b                   	pop    %ebx
    1322:	5f                   	pop    %edi
    1323:	5d                   	pop    %ebp
    1324:	c3                   	ret    

00001325 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1325:	55                   	push   %ebp
    1326:	89 e5                	mov    %esp,%ebp
    1328:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    132b:	8b 45 08             	mov    0x8(%ebp),%eax
    132e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1331:	8b 45 0c             	mov    0xc(%ebp),%eax
    1334:	0f b6 10             	movzbl (%eax),%edx
    1337:	8b 45 08             	mov    0x8(%ebp),%eax
    133a:	88 10                	mov    %dl,(%eax)
    133c:	8b 45 08             	mov    0x8(%ebp),%eax
    133f:	0f b6 00             	movzbl (%eax),%eax
    1342:	84 c0                	test   %al,%al
    1344:	0f 95 c0             	setne  %al
    1347:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    134b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    134f:	84 c0                	test   %al,%al
    1351:	75 de                	jne    1331 <strcpy+0xc>
    ;
  return os;
    1353:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1356:	c9                   	leave  
    1357:	c3                   	ret    

00001358 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1358:	55                   	push   %ebp
    1359:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    135b:	eb 08                	jmp    1365 <strcmp+0xd>
    p++, q++;
    135d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1361:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1365:	8b 45 08             	mov    0x8(%ebp),%eax
    1368:	0f b6 00             	movzbl (%eax),%eax
    136b:	84 c0                	test   %al,%al
    136d:	74 10                	je     137f <strcmp+0x27>
    136f:	8b 45 08             	mov    0x8(%ebp),%eax
    1372:	0f b6 10             	movzbl (%eax),%edx
    1375:	8b 45 0c             	mov    0xc(%ebp),%eax
    1378:	0f b6 00             	movzbl (%eax),%eax
    137b:	38 c2                	cmp    %al,%dl
    137d:	74 de                	je     135d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    137f:	8b 45 08             	mov    0x8(%ebp),%eax
    1382:	0f b6 00             	movzbl (%eax),%eax
    1385:	0f b6 d0             	movzbl %al,%edx
    1388:	8b 45 0c             	mov    0xc(%ebp),%eax
    138b:	0f b6 00             	movzbl (%eax),%eax
    138e:	0f b6 c0             	movzbl %al,%eax
    1391:	89 d1                	mov    %edx,%ecx
    1393:	29 c1                	sub    %eax,%ecx
    1395:	89 c8                	mov    %ecx,%eax
}
    1397:	5d                   	pop    %ebp
    1398:	c3                   	ret    

00001399 <strlen>:

uint
strlen(char *s)
{
    1399:	55                   	push   %ebp
    139a:	89 e5                	mov    %esp,%ebp
    139c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    139f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    13a6:	eb 04                	jmp    13ac <strlen+0x13>
    13a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    13ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13af:	03 45 08             	add    0x8(%ebp),%eax
    13b2:	0f b6 00             	movzbl (%eax),%eax
    13b5:	84 c0                	test   %al,%al
    13b7:	75 ef                	jne    13a8 <strlen+0xf>
    ;
  return n;
    13b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13bc:	c9                   	leave  
    13bd:	c3                   	ret    

000013be <memset>:

void*
memset(void *dst, int c, uint n)
{
    13be:	55                   	push   %ebp
    13bf:	89 e5                	mov    %esp,%ebp
    13c1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    13c4:	8b 45 10             	mov    0x10(%ebp),%eax
    13c7:	89 44 24 08          	mov    %eax,0x8(%esp)
    13cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    13d2:	8b 45 08             	mov    0x8(%ebp),%eax
    13d5:	89 04 24             	mov    %eax,(%esp)
    13d8:	e8 23 ff ff ff       	call   1300 <stosb>
  return dst;
    13dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
    13e0:	c9                   	leave  
    13e1:	c3                   	ret    

000013e2 <strchr>:

char*
strchr(const char *s, char c)
{
    13e2:	55                   	push   %ebp
    13e3:	89 e5                	mov    %esp,%ebp
    13e5:	83 ec 04             	sub    $0x4,%esp
    13e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    13eb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    13ee:	eb 14                	jmp    1404 <strchr+0x22>
    if(*s == c)
    13f0:	8b 45 08             	mov    0x8(%ebp),%eax
    13f3:	0f b6 00             	movzbl (%eax),%eax
    13f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
    13f9:	75 05                	jne    1400 <strchr+0x1e>
      return (char*)s;
    13fb:	8b 45 08             	mov    0x8(%ebp),%eax
    13fe:	eb 13                	jmp    1413 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1400:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1404:	8b 45 08             	mov    0x8(%ebp),%eax
    1407:	0f b6 00             	movzbl (%eax),%eax
    140a:	84 c0                	test   %al,%al
    140c:	75 e2                	jne    13f0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    140e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1413:	c9                   	leave  
    1414:	c3                   	ret    

00001415 <gets>:

char*
gets(char *buf, int max)
{
    1415:	55                   	push   %ebp
    1416:	89 e5                	mov    %esp,%ebp
    1418:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    141b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1422:	eb 44                	jmp    1468 <gets+0x53>
    cc = read(0, &c, 1);
    1424:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    142b:	00 
    142c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    142f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1433:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    143a:	e8 3d 01 00 00       	call   157c <read>
    143f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1442:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1446:	7e 2d                	jle    1475 <gets+0x60>
      break;
    buf[i++] = c;
    1448:	8b 45 f0             	mov    -0x10(%ebp),%eax
    144b:	03 45 08             	add    0x8(%ebp),%eax
    144e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1452:	88 10                	mov    %dl,(%eax)
    1454:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1458:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    145c:	3c 0a                	cmp    $0xa,%al
    145e:	74 16                	je     1476 <gets+0x61>
    1460:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1464:	3c 0d                	cmp    $0xd,%al
    1466:	74 0e                	je     1476 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1468:	8b 45 f0             	mov    -0x10(%ebp),%eax
    146b:	83 c0 01             	add    $0x1,%eax
    146e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1471:	7c b1                	jl     1424 <gets+0xf>
    1473:	eb 01                	jmp    1476 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1475:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1476:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1479:	03 45 08             	add    0x8(%ebp),%eax
    147c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    147f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1482:	c9                   	leave  
    1483:	c3                   	ret    

00001484 <stat>:

int
stat(char *n, struct stat *st)
{
    1484:	55                   	push   %ebp
    1485:	89 e5                	mov    %esp,%ebp
    1487:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    148a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1491:	00 
    1492:	8b 45 08             	mov    0x8(%ebp),%eax
    1495:	89 04 24             	mov    %eax,(%esp)
    1498:	e8 07 01 00 00       	call   15a4 <open>
    149d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    14a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14a4:	79 07                	jns    14ad <stat+0x29>
    return -1;
    14a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    14ab:	eb 23                	jmp    14d0 <stat+0x4c>
  r = fstat(fd, st);
    14ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    14b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    14b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14b7:	89 04 24             	mov    %eax,(%esp)
    14ba:	e8 fd 00 00 00       	call   15bc <fstat>
    14bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    14c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14c5:	89 04 24             	mov    %eax,(%esp)
    14c8:	e8 bf 00 00 00       	call   158c <close>
  return r;
    14cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    14d0:	c9                   	leave  
    14d1:	c3                   	ret    

000014d2 <atoi>:

int
atoi(const char *s)
{
    14d2:	55                   	push   %ebp
    14d3:	89 e5                	mov    %esp,%ebp
    14d5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    14d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    14df:	eb 24                	jmp    1505 <atoi+0x33>
    n = n*10 + *s++ - '0';
    14e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    14e4:	89 d0                	mov    %edx,%eax
    14e6:	c1 e0 02             	shl    $0x2,%eax
    14e9:	01 d0                	add    %edx,%eax
    14eb:	01 c0                	add    %eax,%eax
    14ed:	89 c2                	mov    %eax,%edx
    14ef:	8b 45 08             	mov    0x8(%ebp),%eax
    14f2:	0f b6 00             	movzbl (%eax),%eax
    14f5:	0f be c0             	movsbl %al,%eax
    14f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    14fb:	83 e8 30             	sub    $0x30,%eax
    14fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1501:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1505:	8b 45 08             	mov    0x8(%ebp),%eax
    1508:	0f b6 00             	movzbl (%eax),%eax
    150b:	3c 2f                	cmp    $0x2f,%al
    150d:	7e 0a                	jle    1519 <atoi+0x47>
    150f:	8b 45 08             	mov    0x8(%ebp),%eax
    1512:	0f b6 00             	movzbl (%eax),%eax
    1515:	3c 39                	cmp    $0x39,%al
    1517:	7e c8                	jle    14e1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1519:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    151c:	c9                   	leave  
    151d:	c3                   	ret    

0000151e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    151e:	55                   	push   %ebp
    151f:	89 e5                	mov    %esp,%ebp
    1521:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1524:	8b 45 08             	mov    0x8(%ebp),%eax
    1527:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    152a:	8b 45 0c             	mov    0xc(%ebp),%eax
    152d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1530:	eb 13                	jmp    1545 <memmove+0x27>
    *dst++ = *src++;
    1532:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1535:	0f b6 10             	movzbl (%eax),%edx
    1538:	8b 45 f8             	mov    -0x8(%ebp),%eax
    153b:	88 10                	mov    %dl,(%eax)
    153d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1541:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1545:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1549:	0f 9f c0             	setg   %al
    154c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1550:	84 c0                	test   %al,%al
    1552:	75 de                	jne    1532 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1554:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1557:	c9                   	leave  
    1558:	c3                   	ret    
    1559:	90                   	nop
    155a:	90                   	nop
    155b:	90                   	nop

0000155c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    155c:	b8 01 00 00 00       	mov    $0x1,%eax
    1561:	cd 40                	int    $0x40
    1563:	c3                   	ret    

00001564 <exit>:
SYSCALL(exit)
    1564:	b8 02 00 00 00       	mov    $0x2,%eax
    1569:	cd 40                	int    $0x40
    156b:	c3                   	ret    

0000156c <wait>:
SYSCALL(wait)
    156c:	b8 03 00 00 00       	mov    $0x3,%eax
    1571:	cd 40                	int    $0x40
    1573:	c3                   	ret    

00001574 <pipe>:
SYSCALL(pipe)
    1574:	b8 04 00 00 00       	mov    $0x4,%eax
    1579:	cd 40                	int    $0x40
    157b:	c3                   	ret    

0000157c <read>:
SYSCALL(read)
    157c:	b8 05 00 00 00       	mov    $0x5,%eax
    1581:	cd 40                	int    $0x40
    1583:	c3                   	ret    

00001584 <write>:
SYSCALL(write)
    1584:	b8 10 00 00 00       	mov    $0x10,%eax
    1589:	cd 40                	int    $0x40
    158b:	c3                   	ret    

0000158c <close>:
SYSCALL(close)
    158c:	b8 15 00 00 00       	mov    $0x15,%eax
    1591:	cd 40                	int    $0x40
    1593:	c3                   	ret    

00001594 <kill>:
SYSCALL(kill)
    1594:	b8 06 00 00 00       	mov    $0x6,%eax
    1599:	cd 40                	int    $0x40
    159b:	c3                   	ret    

0000159c <exec>:
SYSCALL(exec)
    159c:	b8 07 00 00 00       	mov    $0x7,%eax
    15a1:	cd 40                	int    $0x40
    15a3:	c3                   	ret    

000015a4 <open>:
SYSCALL(open)
    15a4:	b8 0f 00 00 00       	mov    $0xf,%eax
    15a9:	cd 40                	int    $0x40
    15ab:	c3                   	ret    

000015ac <mknod>:
SYSCALL(mknod)
    15ac:	b8 11 00 00 00       	mov    $0x11,%eax
    15b1:	cd 40                	int    $0x40
    15b3:	c3                   	ret    

000015b4 <unlink>:
SYSCALL(unlink)
    15b4:	b8 12 00 00 00       	mov    $0x12,%eax
    15b9:	cd 40                	int    $0x40
    15bb:	c3                   	ret    

000015bc <fstat>:
SYSCALL(fstat)
    15bc:	b8 08 00 00 00       	mov    $0x8,%eax
    15c1:	cd 40                	int    $0x40
    15c3:	c3                   	ret    

000015c4 <link>:
SYSCALL(link)
    15c4:	b8 13 00 00 00       	mov    $0x13,%eax
    15c9:	cd 40                	int    $0x40
    15cb:	c3                   	ret    

000015cc <mkdir>:
SYSCALL(mkdir)
    15cc:	b8 14 00 00 00       	mov    $0x14,%eax
    15d1:	cd 40                	int    $0x40
    15d3:	c3                   	ret    

000015d4 <chdir>:
SYSCALL(chdir)
    15d4:	b8 09 00 00 00       	mov    $0x9,%eax
    15d9:	cd 40                	int    $0x40
    15db:	c3                   	ret    

000015dc <dup>:
SYSCALL(dup)
    15dc:	b8 0a 00 00 00       	mov    $0xa,%eax
    15e1:	cd 40                	int    $0x40
    15e3:	c3                   	ret    

000015e4 <getpid>:
SYSCALL(getpid)
    15e4:	b8 0b 00 00 00       	mov    $0xb,%eax
    15e9:	cd 40                	int    $0x40
    15eb:	c3                   	ret    

000015ec <sbrk>:
SYSCALL(sbrk)
    15ec:	b8 0c 00 00 00       	mov    $0xc,%eax
    15f1:	cd 40                	int    $0x40
    15f3:	c3                   	ret    

000015f4 <sleep>:
SYSCALL(sleep)
    15f4:	b8 0d 00 00 00       	mov    $0xd,%eax
    15f9:	cd 40                	int    $0x40
    15fb:	c3                   	ret    

000015fc <uptime>:
SYSCALL(uptime)
    15fc:	b8 0e 00 00 00       	mov    $0xe,%eax
    1601:	cd 40                	int    $0x40
    1603:	c3                   	ret    

00001604 <clone>:
SYSCALL(clone)
    1604:	b8 16 00 00 00       	mov    $0x16,%eax
    1609:	cd 40                	int    $0x40
    160b:	c3                   	ret    

0000160c <texit>:
SYSCALL(texit)
    160c:	b8 17 00 00 00       	mov    $0x17,%eax
    1611:	cd 40                	int    $0x40
    1613:	c3                   	ret    

00001614 <tsleep>:
SYSCALL(tsleep)
    1614:	b8 18 00 00 00       	mov    $0x18,%eax
    1619:	cd 40                	int    $0x40
    161b:	c3                   	ret    

0000161c <twakeup>:
SYSCALL(twakeup)
    161c:	b8 19 00 00 00       	mov    $0x19,%eax
    1621:	cd 40                	int    $0x40
    1623:	c3                   	ret    

00001624 <thread_yield>:
SYSCALL(thread_yield) 
    1624:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1629:	cd 40                	int    $0x40
    162b:	c3                   	ret    

0000162c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    162c:	55                   	push   %ebp
    162d:	89 e5                	mov    %esp,%ebp
    162f:	83 ec 28             	sub    $0x28,%esp
    1632:	8b 45 0c             	mov    0xc(%ebp),%eax
    1635:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1638:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    163f:	00 
    1640:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1643:	89 44 24 04          	mov    %eax,0x4(%esp)
    1647:	8b 45 08             	mov    0x8(%ebp),%eax
    164a:	89 04 24             	mov    %eax,(%esp)
    164d:	e8 32 ff ff ff       	call   1584 <write>
}
    1652:	c9                   	leave  
    1653:	c3                   	ret    

00001654 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1654:	55                   	push   %ebp
    1655:	89 e5                	mov    %esp,%ebp
    1657:	53                   	push   %ebx
    1658:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    165b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1662:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1666:	74 17                	je     167f <printint+0x2b>
    1668:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    166c:	79 11                	jns    167f <printint+0x2b>
    neg = 1;
    166e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1675:	8b 45 0c             	mov    0xc(%ebp),%eax
    1678:	f7 d8                	neg    %eax
    167a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    167d:	eb 06                	jmp    1685 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    167f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1682:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1685:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    168c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    168f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1692:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1695:	ba 00 00 00 00       	mov    $0x0,%edx
    169a:	f7 f3                	div    %ebx
    169c:	89 d0                	mov    %edx,%eax
    169e:	0f b6 80 d0 1e 00 00 	movzbl 0x1ed0(%eax),%eax
    16a5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    16a9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    16ad:	8b 45 10             	mov    0x10(%ebp),%eax
    16b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    16b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b6:	ba 00 00 00 00       	mov    $0x0,%edx
    16bb:	f7 75 d4             	divl   -0x2c(%ebp)
    16be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    16c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    16c5:	75 c5                	jne    168c <printint+0x38>
  if(neg)
    16c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    16cb:	74 28                	je     16f5 <printint+0xa1>
    buf[i++] = '-';
    16cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16d0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    16d5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    16d9:	eb 1a                	jmp    16f5 <printint+0xa1>
    putc(fd, buf[i]);
    16db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16de:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    16e3:	0f be c0             	movsbl %al,%eax
    16e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    16ea:	8b 45 08             	mov    0x8(%ebp),%eax
    16ed:	89 04 24             	mov    %eax,(%esp)
    16f0:	e8 37 ff ff ff       	call   162c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    16f5:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    16f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16fd:	79 dc                	jns    16db <printint+0x87>
    putc(fd, buf[i]);
}
    16ff:	83 c4 44             	add    $0x44,%esp
    1702:	5b                   	pop    %ebx
    1703:	5d                   	pop    %ebp
    1704:	c3                   	ret    

00001705 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1705:	55                   	push   %ebp
    1706:	89 e5                	mov    %esp,%ebp
    1708:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    170b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1712:	8d 45 0c             	lea    0xc(%ebp),%eax
    1715:	83 c0 04             	add    $0x4,%eax
    1718:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    171b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1722:	e9 7e 01 00 00       	jmp    18a5 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1727:	8b 55 0c             	mov    0xc(%ebp),%edx
    172a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    172d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1730:	0f b6 00             	movzbl (%eax),%eax
    1733:	0f be c0             	movsbl %al,%eax
    1736:	25 ff 00 00 00       	and    $0xff,%eax
    173b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    173e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1742:	75 2c                	jne    1770 <printf+0x6b>
      if(c == '%'){
    1744:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1748:	75 0c                	jne    1756 <printf+0x51>
        state = '%';
    174a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1751:	e9 4b 01 00 00       	jmp    18a1 <printf+0x19c>
      } else {
        putc(fd, c);
    1756:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1759:	0f be c0             	movsbl %al,%eax
    175c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1760:	8b 45 08             	mov    0x8(%ebp),%eax
    1763:	89 04 24             	mov    %eax,(%esp)
    1766:	e8 c1 fe ff ff       	call   162c <putc>
    176b:	e9 31 01 00 00       	jmp    18a1 <printf+0x19c>
      }
    } else if(state == '%'){
    1770:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1774:	0f 85 27 01 00 00    	jne    18a1 <printf+0x19c>
      if(c == 'd'){
    177a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    177e:	75 2d                	jne    17ad <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1780:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1783:	8b 00                	mov    (%eax),%eax
    1785:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    178c:	00 
    178d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1794:	00 
    1795:	89 44 24 04          	mov    %eax,0x4(%esp)
    1799:	8b 45 08             	mov    0x8(%ebp),%eax
    179c:	89 04 24             	mov    %eax,(%esp)
    179f:	e8 b0 fe ff ff       	call   1654 <printint>
        ap++;
    17a4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    17a8:	e9 ed 00 00 00       	jmp    189a <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    17ad:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    17b1:	74 06                	je     17b9 <printf+0xb4>
    17b3:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    17b7:	75 2d                	jne    17e6 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    17b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17bc:	8b 00                	mov    (%eax),%eax
    17be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    17c5:	00 
    17c6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    17cd:	00 
    17ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    17d2:	8b 45 08             	mov    0x8(%ebp),%eax
    17d5:	89 04 24             	mov    %eax,(%esp)
    17d8:	e8 77 fe ff ff       	call   1654 <printint>
        ap++;
    17dd:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    17e1:	e9 b4 00 00 00       	jmp    189a <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    17e6:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    17ea:	75 46                	jne    1832 <printf+0x12d>
        s = (char*)*ap;
    17ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ef:	8b 00                	mov    (%eax),%eax
    17f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    17f4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    17f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    17fc:	75 27                	jne    1825 <printf+0x120>
          s = "(null)";
    17fe:	c7 45 e4 9d 1e 00 00 	movl   $0x1e9d,-0x1c(%ebp)
        while(*s != 0){
    1805:	eb 1f                	jmp    1826 <printf+0x121>
          putc(fd, *s);
    1807:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    180a:	0f b6 00             	movzbl (%eax),%eax
    180d:	0f be c0             	movsbl %al,%eax
    1810:	89 44 24 04          	mov    %eax,0x4(%esp)
    1814:	8b 45 08             	mov    0x8(%ebp),%eax
    1817:	89 04 24             	mov    %eax,(%esp)
    181a:	e8 0d fe ff ff       	call   162c <putc>
          s++;
    181f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1823:	eb 01                	jmp    1826 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1825:	90                   	nop
    1826:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1829:	0f b6 00             	movzbl (%eax),%eax
    182c:	84 c0                	test   %al,%al
    182e:	75 d7                	jne    1807 <printf+0x102>
    1830:	eb 68                	jmp    189a <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1832:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1836:	75 1d                	jne    1855 <printf+0x150>
        putc(fd, *ap);
    1838:	8b 45 f4             	mov    -0xc(%ebp),%eax
    183b:	8b 00                	mov    (%eax),%eax
    183d:	0f be c0             	movsbl %al,%eax
    1840:	89 44 24 04          	mov    %eax,0x4(%esp)
    1844:	8b 45 08             	mov    0x8(%ebp),%eax
    1847:	89 04 24             	mov    %eax,(%esp)
    184a:	e8 dd fd ff ff       	call   162c <putc>
        ap++;
    184f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1853:	eb 45                	jmp    189a <printf+0x195>
      } else if(c == '%'){
    1855:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1859:	75 17                	jne    1872 <printf+0x16d>
        putc(fd, c);
    185b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    185e:	0f be c0             	movsbl %al,%eax
    1861:	89 44 24 04          	mov    %eax,0x4(%esp)
    1865:	8b 45 08             	mov    0x8(%ebp),%eax
    1868:	89 04 24             	mov    %eax,(%esp)
    186b:	e8 bc fd ff ff       	call   162c <putc>
    1870:	eb 28                	jmp    189a <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1872:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1879:	00 
    187a:	8b 45 08             	mov    0x8(%ebp),%eax
    187d:	89 04 24             	mov    %eax,(%esp)
    1880:	e8 a7 fd ff ff       	call   162c <putc>
        putc(fd, c);
    1885:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1888:	0f be c0             	movsbl %al,%eax
    188b:	89 44 24 04          	mov    %eax,0x4(%esp)
    188f:	8b 45 08             	mov    0x8(%ebp),%eax
    1892:	89 04 24             	mov    %eax,(%esp)
    1895:	e8 92 fd ff ff       	call   162c <putc>
      }
      state = 0;
    189a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    18a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    18a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    18a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18ab:	8d 04 02             	lea    (%edx,%eax,1),%eax
    18ae:	0f b6 00             	movzbl (%eax),%eax
    18b1:	84 c0                	test   %al,%al
    18b3:	0f 85 6e fe ff ff    	jne    1727 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    18b9:	c9                   	leave  
    18ba:	c3                   	ret    
    18bb:	90                   	nop

000018bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    18bc:	55                   	push   %ebp
    18bd:	89 e5                	mov    %esp,%ebp
    18bf:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    18c2:	8b 45 08             	mov    0x8(%ebp),%eax
    18c5:	83 e8 08             	sub    $0x8,%eax
    18c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18cb:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    18d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18d3:	eb 24                	jmp    18f9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    18d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18d8:	8b 00                	mov    (%eax),%eax
    18da:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18dd:	77 12                	ja     18f1 <free+0x35>
    18df:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18e5:	77 24                	ja     190b <free+0x4f>
    18e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18ea:	8b 00                	mov    (%eax),%eax
    18ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    18ef:	77 1a                	ja     190b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    18f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    18f4:	8b 00                	mov    (%eax),%eax
    18f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    18f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    18fc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    18ff:	76 d4                	jbe    18d5 <free+0x19>
    1901:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1904:	8b 00                	mov    (%eax),%eax
    1906:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1909:	76 ca                	jbe    18d5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    190b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    190e:	8b 40 04             	mov    0x4(%eax),%eax
    1911:	c1 e0 03             	shl    $0x3,%eax
    1914:	89 c2                	mov    %eax,%edx
    1916:	03 55 f8             	add    -0x8(%ebp),%edx
    1919:	8b 45 fc             	mov    -0x4(%ebp),%eax
    191c:	8b 00                	mov    (%eax),%eax
    191e:	39 c2                	cmp    %eax,%edx
    1920:	75 24                	jne    1946 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1922:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1925:	8b 50 04             	mov    0x4(%eax),%edx
    1928:	8b 45 fc             	mov    -0x4(%ebp),%eax
    192b:	8b 00                	mov    (%eax),%eax
    192d:	8b 40 04             	mov    0x4(%eax),%eax
    1930:	01 c2                	add    %eax,%edx
    1932:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1935:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1938:	8b 45 fc             	mov    -0x4(%ebp),%eax
    193b:	8b 00                	mov    (%eax),%eax
    193d:	8b 10                	mov    (%eax),%edx
    193f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1942:	89 10                	mov    %edx,(%eax)
    1944:	eb 0a                	jmp    1950 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1946:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1949:	8b 10                	mov    (%eax),%edx
    194b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    194e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1950:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1953:	8b 40 04             	mov    0x4(%eax),%eax
    1956:	c1 e0 03             	shl    $0x3,%eax
    1959:	03 45 fc             	add    -0x4(%ebp),%eax
    195c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    195f:	75 20                	jne    1981 <free+0xc5>
    p->s.size += bp->s.size;
    1961:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1964:	8b 50 04             	mov    0x4(%eax),%edx
    1967:	8b 45 f8             	mov    -0x8(%ebp),%eax
    196a:	8b 40 04             	mov    0x4(%eax),%eax
    196d:	01 c2                	add    %eax,%edx
    196f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1972:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1975:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1978:	8b 10                	mov    (%eax),%edx
    197a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    197d:	89 10                	mov    %edx,(%eax)
    197f:	eb 08                	jmp    1989 <free+0xcd>
  } else
    p->s.ptr = bp;
    1981:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1984:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1987:	89 10                	mov    %edx,(%eax)
  freep = p;
    1989:	8b 45 fc             	mov    -0x4(%ebp),%eax
    198c:	a3 fc 1e 00 00       	mov    %eax,0x1efc
}
    1991:	c9                   	leave  
    1992:	c3                   	ret    

00001993 <morecore>:

static Header*
morecore(uint nu)
{
    1993:	55                   	push   %ebp
    1994:	89 e5                	mov    %esp,%ebp
    1996:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1999:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    19a0:	77 07                	ja     19a9 <morecore+0x16>
    nu = 4096;
    19a2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    19a9:	8b 45 08             	mov    0x8(%ebp),%eax
    19ac:	c1 e0 03             	shl    $0x3,%eax
    19af:	89 04 24             	mov    %eax,(%esp)
    19b2:	e8 35 fc ff ff       	call   15ec <sbrk>
    19b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    19ba:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    19be:	75 07                	jne    19c7 <morecore+0x34>
    return 0;
    19c0:	b8 00 00 00 00       	mov    $0x0,%eax
    19c5:	eb 22                	jmp    19e9 <morecore+0x56>
  hp = (Header*)p;
    19c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    19cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d0:	8b 55 08             	mov    0x8(%ebp),%edx
    19d3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    19d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d9:	83 c0 08             	add    $0x8,%eax
    19dc:	89 04 24             	mov    %eax,(%esp)
    19df:	e8 d8 fe ff ff       	call   18bc <free>
  return freep;
    19e4:	a1 fc 1e 00 00       	mov    0x1efc,%eax
}
    19e9:	c9                   	leave  
    19ea:	c3                   	ret    

000019eb <malloc>:

void*
malloc(uint nbytes)
{
    19eb:	55                   	push   %ebp
    19ec:	89 e5                	mov    %esp,%ebp
    19ee:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    19f1:	8b 45 08             	mov    0x8(%ebp),%eax
    19f4:	83 c0 07             	add    $0x7,%eax
    19f7:	c1 e8 03             	shr    $0x3,%eax
    19fa:	83 c0 01             	add    $0x1,%eax
    19fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1a00:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1a05:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1a08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a0c:	75 23                	jne    1a31 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1a0e:	c7 45 f0 f4 1e 00 00 	movl   $0x1ef4,-0x10(%ebp)
    1a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a18:	a3 fc 1e 00 00       	mov    %eax,0x1efc
    1a1d:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1a22:	a3 f4 1e 00 00       	mov    %eax,0x1ef4
    base.s.size = 0;
    1a27:	c7 05 f8 1e 00 00 00 	movl   $0x0,0x1ef8
    1a2e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a34:	8b 00                	mov    (%eax),%eax
    1a36:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1a39:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a3c:	8b 40 04             	mov    0x4(%eax),%eax
    1a3f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a42:	72 4d                	jb     1a91 <malloc+0xa6>
      if(p->s.size == nunits)
    1a44:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a47:	8b 40 04             	mov    0x4(%eax),%eax
    1a4a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1a4d:	75 0c                	jne    1a5b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1a4f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a52:	8b 10                	mov    (%eax),%edx
    1a54:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a57:	89 10                	mov    %edx,(%eax)
    1a59:	eb 26                	jmp    1a81 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1a5b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a5e:	8b 40 04             	mov    0x4(%eax),%eax
    1a61:	89 c2                	mov    %eax,%edx
    1a63:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1a66:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a69:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1a6c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a6f:	8b 40 04             	mov    0x4(%eax),%eax
    1a72:	c1 e0 03             	shl    $0x3,%eax
    1a75:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1a78:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a7e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a84:	a3 fc 1e 00 00       	mov    %eax,0x1efc
      return (void*)(p + 1);
    1a89:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1a8c:	83 c0 08             	add    $0x8,%eax
    1a8f:	eb 38                	jmp    1ac9 <malloc+0xde>
    }
    if(p == freep)
    1a91:	a1 fc 1e 00 00       	mov    0x1efc,%eax
    1a96:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1a99:	75 1b                	jne    1ab6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a9e:	89 04 24             	mov    %eax,(%esp)
    1aa1:	e8 ed fe ff ff       	call   1993 <morecore>
    1aa6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1aa9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aad:	75 07                	jne    1ab6 <malloc+0xcb>
        return 0;
    1aaf:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab4:	eb 13                	jmp    1ac9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1ab6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ab9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1abc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1abf:	8b 00                	mov    (%eax),%eax
    1ac1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1ac4:	e9 70 ff ff ff       	jmp    1a39 <malloc+0x4e>
}
    1ac9:	c9                   	leave  
    1aca:	c3                   	ret    
    1acb:	90                   	nop

00001acc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1acc:	55                   	push   %ebp
    1acd:	89 e5                	mov    %esp,%ebp
    1acf:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1ad2:	8b 55 08             	mov    0x8(%ebp),%edx
    1ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
    1ad8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1adb:	f0 87 02             	lock xchg %eax,(%edx)
    1ade:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1ae1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1ae4:	c9                   	leave  
    1ae5:	c3                   	ret    

00001ae6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1ae6:	55                   	push   %ebp
    1ae7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1ae9:	8b 45 08             	mov    0x8(%ebp),%eax
    1aec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1af2:	5d                   	pop    %ebp
    1af3:	c3                   	ret    

00001af4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1af4:	55                   	push   %ebp
    1af5:	89 e5                	mov    %esp,%ebp
    1af7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1afa:	8b 45 08             	mov    0x8(%ebp),%eax
    1afd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1b04:	00 
    1b05:	89 04 24             	mov    %eax,(%esp)
    1b08:	e8 bf ff ff ff       	call   1acc <xchg>
    1b0d:	85 c0                	test   %eax,%eax
    1b0f:	75 e9                	jne    1afa <lock_acquire+0x6>
}
    1b11:	c9                   	leave  
    1b12:	c3                   	ret    

00001b13 <lock_release>:
void lock_release(lock_t *lock){
    1b13:	55                   	push   %ebp
    1b14:	89 e5                	mov    %esp,%ebp
    1b16:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1b19:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1b23:	00 
    1b24:	89 04 24             	mov    %eax,(%esp)
    1b27:	e8 a0 ff ff ff       	call   1acc <xchg>
}
    1b2c:	c9                   	leave  
    1b2d:	c3                   	ret    

00001b2e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1b2e:	55                   	push   %ebp
    1b2f:	89 e5                	mov    %esp,%ebp
    1b31:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1b34:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1b3b:	e8 ab fe ff ff       	call   19eb <malloc>
    1b40:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1b43:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b46:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1b49:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b4c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1b51:	85 c0                	test   %eax,%eax
    1b53:	74 15                	je     1b6a <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1b55:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b58:	89 c2                	mov    %eax,%edx
    1b5a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1b60:	b8 00 10 00 00       	mov    $0x1000,%eax
    1b65:	29 d0                	sub    %edx,%eax
    1b67:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1b6a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b6e:	75 1b                	jne    1b8b <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1b70:	c7 44 24 04 a4 1e 00 	movl   $0x1ea4,0x4(%esp)
    1b77:	00 
    1b78:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b7f:	e8 81 fb ff ff       	call   1705 <printf>
        return 0;
    1b84:	b8 00 00 00 00       	mov    $0x0,%eax
    1b89:	eb 6f                	jmp    1bfa <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1b8b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1b8e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b91:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b94:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1b98:	89 54 24 08          	mov    %edx,0x8(%esp)
    1b9c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1ba3:	00 
    1ba4:	89 04 24             	mov    %eax,(%esp)
    1ba7:	e8 58 fa ff ff       	call   1604 <clone>
    1bac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1baf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bb3:	79 1b                	jns    1bd0 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1bb5:	c7 44 24 04 b2 1e 00 	movl   $0x1eb2,0x4(%esp)
    1bbc:	00 
    1bbd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bc4:	e8 3c fb ff ff       	call   1705 <printf>
        return 0;
    1bc9:	b8 00 00 00 00       	mov    $0x0,%eax
    1bce:	eb 2a                	jmp    1bfa <thread_create+0xcc>
    }
    if(tid > 0){
    1bd0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bd4:	7e 05                	jle    1bdb <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bd9:	eb 1f                	jmp    1bfa <thread_create+0xcc>
    }
    if(tid == 0){
    1bdb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1bdf:	75 14                	jne    1bf5 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1be1:	c7 44 24 04 bf 1e 00 	movl   $0x1ebf,0x4(%esp)
    1be8:	00 
    1be9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bf0:	e8 10 fb ff ff       	call   1705 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1bf5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1bfa:	c9                   	leave  
    1bfb:	c3                   	ret    

00001bfc <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1bfc:	55                   	push   %ebp
    1bfd:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1bff:	a1 e4 1e 00 00       	mov    0x1ee4,%eax
    1c04:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1c0a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1c0f:	a3 e4 1e 00 00       	mov    %eax,0x1ee4
    return (int)(rands % max);
    1c14:	a1 e4 1e 00 00       	mov    0x1ee4,%eax
    1c19:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1c1c:	ba 00 00 00 00       	mov    $0x0,%edx
    1c21:	f7 f1                	div    %ecx
    1c23:	89 d0                	mov    %edx,%eax
}
    1c25:	5d                   	pop    %ebp
    1c26:	c3                   	ret    
    1c27:	90                   	nop

00001c28 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1c28:	55                   	push   %ebp
    1c29:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1c2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1c34:	8b 45 08             	mov    0x8(%ebp),%eax
    1c37:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1c3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c41:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1c48:	5d                   	pop    %ebp
    1c49:	c3                   	ret    

00001c4a <add_q>:

void add_q(struct queue *q, int v){
    1c4a:	55                   	push   %ebp
    1c4b:	89 e5                	mov    %esp,%ebp
    1c4d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1c50:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1c57:	e8 8f fd ff ff       	call   19eb <malloc>
    1c5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c62:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c6c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c6f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1c71:	8b 45 08             	mov    0x8(%ebp),%eax
    1c74:	8b 40 04             	mov    0x4(%eax),%eax
    1c77:	85 c0                	test   %eax,%eax
    1c79:	75 0b                	jne    1c86 <add_q+0x3c>
        q->head = n;
    1c7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c81:	89 50 04             	mov    %edx,0x4(%eax)
    1c84:	eb 0c                	jmp    1c92 <add_q+0x48>
    }else{
        q->tail->next = n;
    1c86:	8b 45 08             	mov    0x8(%ebp),%eax
    1c89:	8b 40 08             	mov    0x8(%eax),%eax
    1c8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c8f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1c92:	8b 45 08             	mov    0x8(%ebp),%eax
    1c95:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1c98:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1c9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9e:	8b 00                	mov    (%eax),%eax
    1ca0:	8d 50 01             	lea    0x1(%eax),%edx
    1ca3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca6:	89 10                	mov    %edx,(%eax)
}
    1ca8:	c9                   	leave  
    1ca9:	c3                   	ret    

00001caa <empty_q>:

int empty_q(struct queue *q){
    1caa:	55                   	push   %ebp
    1cab:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1cad:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb0:	8b 00                	mov    (%eax),%eax
    1cb2:	85 c0                	test   %eax,%eax
    1cb4:	75 07                	jne    1cbd <empty_q+0x13>
        return 1;
    1cb6:	b8 01 00 00 00       	mov    $0x1,%eax
    1cbb:	eb 05                	jmp    1cc2 <empty_q+0x18>
    else
        return 0;
    1cbd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1cc2:	5d                   	pop    %ebp
    1cc3:	c3                   	ret    

00001cc4 <pop_q>:
int pop_q(struct queue *q){
    1cc4:	55                   	push   %ebp
    1cc5:	89 e5                	mov    %esp,%ebp
    1cc7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1cca:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccd:	89 04 24             	mov    %eax,(%esp)
    1cd0:	e8 d5 ff ff ff       	call   1caa <empty_q>
    1cd5:	85 c0                	test   %eax,%eax
    1cd7:	75 5d                	jne    1d36 <pop_q+0x72>
       val = q->head->value; 
    1cd9:	8b 45 08             	mov    0x8(%ebp),%eax
    1cdc:	8b 40 04             	mov    0x4(%eax),%eax
    1cdf:	8b 00                	mov    (%eax),%eax
    1ce1:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1ce4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce7:	8b 40 04             	mov    0x4(%eax),%eax
    1cea:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1ced:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf0:	8b 40 04             	mov    0x4(%eax),%eax
    1cf3:	8b 50 04             	mov    0x4(%eax),%edx
    1cf6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1cfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cff:	89 04 24             	mov    %eax,(%esp)
    1d02:	e8 b5 fb ff ff       	call   18bc <free>
       q->size--;
    1d07:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0a:	8b 00                	mov    (%eax),%eax
    1d0c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d12:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1d14:	8b 45 08             	mov    0x8(%ebp),%eax
    1d17:	8b 00                	mov    (%eax),%eax
    1d19:	85 c0                	test   %eax,%eax
    1d1b:	75 14                	jne    1d31 <pop_q+0x6d>
            q->head = 0;
    1d1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d20:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1d27:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1d31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d34:	eb 05                	jmp    1d3b <pop_q+0x77>
    }
    return -1;
    1d36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1d3b:	c9                   	leave  
    1d3c:	c3                   	ret    
    1d3d:	90                   	nop
    1d3e:	90                   	nop
    1d3f:	90                   	nop

00001d40 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1d40:	55                   	push   %ebp
    1d41:	89 e5                	mov    %esp,%ebp
    1d43:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1d46:	8b 45 08             	mov    0x8(%ebp),%eax
    1d49:	89 04 24             	mov    %eax,(%esp)
    1d4c:	e8 a3 fd ff ff       	call   1af4 <lock_acquire>
	s->count--; 
    1d51:	8b 45 08             	mov    0x8(%ebp),%eax
    1d54:	8b 40 04             	mov    0x4(%eax),%eax
    1d57:	8d 50 ff             	lea    -0x1(%eax),%edx
    1d5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5d:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1d60:	8b 45 08             	mov    0x8(%ebp),%eax
    1d63:	8b 40 04             	mov    0x4(%eax),%eax
    1d66:	85 c0                	test   %eax,%eax
    1d68:	79 27                	jns    1d91 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1d6a:	e8 75 f8 ff ff       	call   15e4 <getpid>
    1d6f:	8b 55 08             	mov    0x8(%ebp),%edx
    1d72:	83 c2 08             	add    $0x8,%edx
    1d75:	89 44 24 04          	mov    %eax,0x4(%esp)
    1d79:	89 14 24             	mov    %edx,(%esp)
    1d7c:	e8 c9 fe ff ff       	call   1c4a <add_q>
		lock_release(&s->lock); 
    1d81:	8b 45 08             	mov    0x8(%ebp),%eax
    1d84:	89 04 24             	mov    %eax,(%esp)
    1d87:	e8 87 fd ff ff       	call   1b13 <lock_release>
		tsleep(); 
    1d8c:	e8 83 f8 ff ff       	call   1614 <tsleep>
	} 
	lock_release(&s->lock); 
    1d91:	8b 45 08             	mov    0x8(%ebp),%eax
    1d94:	89 04 24             	mov    %eax,(%esp)
    1d97:	e8 77 fd ff ff       	call   1b13 <lock_release>
}
    1d9c:	c9                   	leave  
    1d9d:	c3                   	ret    

00001d9e <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1d9e:	55                   	push   %ebp
    1d9f:	89 e5                	mov    %esp,%ebp
    1da1:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1da4:	8b 45 08             	mov    0x8(%ebp),%eax
    1da7:	89 04 24             	mov    %eax,(%esp)
    1daa:	e8 45 fd ff ff       	call   1af4 <lock_acquire>
	s->count++; 
    1daf:	8b 45 08             	mov    0x8(%ebp),%eax
    1db2:	8b 40 04             	mov    0x4(%eax),%eax
    1db5:	8d 50 01             	lea    0x1(%eax),%edx
    1db8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbb:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1dbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc1:	8b 40 04             	mov    0x4(%eax),%eax
    1dc4:	85 c0                	test   %eax,%eax
    1dc6:	7f 1c                	jg     1de4 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1dc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcb:	83 c0 08             	add    $0x8,%eax
    1dce:	89 04 24             	mov    %eax,(%esp)
    1dd1:	e8 ee fe ff ff       	call   1cc4 <pop_q>
    1dd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1dd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ddc:	89 04 24             	mov    %eax,(%esp)
    1ddf:	e8 38 f8 ff ff       	call   161c <twakeup>
	}
	lock_release(&s->lock); 
    1de4:	8b 45 08             	mov    0x8(%ebp),%eax
    1de7:	89 04 24             	mov    %eax,(%esp)
    1dea:	e8 24 fd ff ff       	call   1b13 <lock_release>
} 
    1def:	c9                   	leave  
    1df0:	c3                   	ret    

00001df1 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1df1:	55                   	push   %ebp
    1df2:	89 e5                	mov    %esp,%ebp
    1df4:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1df7:	8b 45 08             	mov    0x8(%ebp),%eax
    1dfa:	89 04 24             	mov    %eax,(%esp)
    1dfd:	e8 e4 fc ff ff       	call   1ae6 <lock_init>
	s->count = size; 
    1e02:	8b 45 08             	mov    0x8(%ebp),%eax
    1e05:	8b 55 0c             	mov    0xc(%ebp),%edx
    1e08:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1e0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0e:	83 c0 08             	add    $0x8,%eax
    1e11:	89 04 24             	mov    %eax,(%esp)
    1e14:	e8 0f fe ff ff       	call   1c28 <init_q>
}
    1e19:	c9                   	leave  
    1e1a:	c3                   	ret    
