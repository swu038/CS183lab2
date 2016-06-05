
_nature4:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
int oxygen = 0; 
struct {
	lock_t lock; 
}mutex;  

int main() {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 50             	sub    $0x50,%esp
	lock_acquire(&mutex.lock); 	
    1009:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1010:	e8 8b 0b 00 00       	call   1ba0 <lock_acquire>
	printf(1,"Hydrogen count should be 10, and oxygen count should be 5, therefore water should be 5. \n"); 
    1015:	c7 44 24 04 c8 1e 00 	movl   $0x1ec8,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 88 07 00 00       	call   17b1 <printf>
	lock_release(&mutex.lock); 	
    1029:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1030:	e8 8a 0b 00 00       	call   1bbf <lock_release>

	sem_init(&h, 0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 10 20 00 00 	movl   $0x2010,(%esp)
    1044:	e8 54 0e 00 00       	call   1e9d <sem_init>
	sem_init(&o, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 f8 1f 00 00 	movl   $0x1ff8,(%esp)
    1058:	e8 40 0e 00 00       	call   1e9d <sem_init>
	
	void *oid = thread_create(oReady,(void *)0); 
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 87 12 00 00 	movl   $0x1287,(%esp)
    106c:	e8 69 0b 00 00       	call   1bda <thread_create>
    1071:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(oid == 0) exit();
    1075:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 8f 05 00 00       	call   1610 <exit>

	void *oid2 = thread_create(oReady,(void *)0); 
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 87 12 00 00 	movl   $0x1287,(%esp)
    1090:	e8 45 0b 00 00       	call   1bda <thread_create>
    1095:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(oid2 == 0) exit();
    1099:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 6b 05 00 00       	call   1610 <exit>

	void *oid3 = thread_create(oReady,(void *)0); 
    10a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 87 12 00 00 	movl   $0x1287,(%esp)
    10b4:	e8 21 0b 00 00       	call   1bda <thread_create>
    10b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(oid3 == 0) exit();
    10bd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 47 05 00 00       	call   1610 <exit>
	
	void *oid4 = thread_create(oReady,(void *)0); 
    10c9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10d0:	00 
    10d1:	c7 04 24 87 12 00 00 	movl   $0x1287,(%esp)
    10d8:	e8 fd 0a 00 00       	call   1bda <thread_create>
    10dd:	89 44 24 20          	mov    %eax,0x20(%esp)
	if(oid4 == 0) exit();
    10e1:	83 7c 24 20 00       	cmpl   $0x0,0x20(%esp)
    10e6:	75 05                	jne    10ed <main+0xed>
    10e8:	e8 23 05 00 00       	call   1610 <exit>

	void *oid5 = thread_create(oReady,(void *)0); 
    10ed:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10f4:	00 
    10f5:	c7 04 24 87 12 00 00 	movl   $0x1287,(%esp)
    10fc:	e8 d9 0a 00 00       	call   1bda <thread_create>
    1101:	89 44 24 24          	mov    %eax,0x24(%esp)
	if(oid5 == 0) exit();
    1105:	83 7c 24 24 00       	cmpl   $0x0,0x24(%esp)
    110a:	75 05                	jne    1111 <main+0x111>
    110c:	e8 ff 04 00 00       	call   1610 <exit>

	void *hid = thread_create(hReady,(void *)0); 
    1111:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1118:	00 
    1119:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    1120:	e8 b5 0a 00 00       	call   1bda <thread_create>
    1125:	89 44 24 28          	mov    %eax,0x28(%esp)
	if(hid == 0) exit();  
    1129:	83 7c 24 28 00       	cmpl   $0x0,0x28(%esp)
    112e:	75 05                	jne    1135 <main+0x135>
    1130:	e8 db 04 00 00       	call   1610 <exit>

	void *hid2 = thread_create(hReady,(void *)0); 
    1135:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    113c:	00 
    113d:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    1144:	e8 91 0a 00 00       	call   1bda <thread_create>
    1149:	89 44 24 2c          	mov    %eax,0x2c(%esp)
	if(hid2 == 0) exit();  
    114d:	83 7c 24 2c 00       	cmpl   $0x0,0x2c(%esp)
    1152:	75 05                	jne    1159 <main+0x159>
    1154:	e8 b7 04 00 00       	call   1610 <exit>

	void *hid3 = thread_create(hReady,(void *)0); 
    1159:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1160:	00 
    1161:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    1168:	e8 6d 0a 00 00       	call   1bda <thread_create>
    116d:	89 44 24 30          	mov    %eax,0x30(%esp)
	if(hid3 == 0) exit();  
    1171:	83 7c 24 30 00       	cmpl   $0x0,0x30(%esp)
    1176:	75 05                	jne    117d <main+0x17d>
    1178:	e8 93 04 00 00       	call   1610 <exit>
  
	void *hid4 = thread_create(hReady,(void *)0); 
    117d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1184:	00 
    1185:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    118c:	e8 49 0a 00 00       	call   1bda <thread_create>
    1191:	89 44 24 34          	mov    %eax,0x34(%esp)
	if(hid4 == 0) exit();  
    1195:	83 7c 24 34 00       	cmpl   $0x0,0x34(%esp)
    119a:	75 05                	jne    11a1 <main+0x1a1>
    119c:	e8 6f 04 00 00       	call   1610 <exit>

	void *hid5 = thread_create(hReady,(void *)0); 
    11a1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11a8:	00 
    11a9:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    11b0:	e8 25 0a 00 00       	call   1bda <thread_create>
    11b5:	89 44 24 38          	mov    %eax,0x38(%esp)
	if(hid5 == 0) exit();  
    11b9:	83 7c 24 38 00       	cmpl   $0x0,0x38(%esp)
    11be:	75 05                	jne    11c5 <main+0x1c5>
    11c0:	e8 4b 04 00 00       	call   1610 <exit>
 
	void *hid6 = thread_create(hReady,(void *)0); 
    11c5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11cc:	00 
    11cd:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    11d4:	e8 01 0a 00 00       	call   1bda <thread_create>
    11d9:	89 44 24 3c          	mov    %eax,0x3c(%esp)
	if(hid6 == 0) exit();  
    11dd:	83 7c 24 3c 00       	cmpl   $0x0,0x3c(%esp)
    11e2:	75 05                	jne    11e9 <main+0x1e9>
    11e4:	e8 27 04 00 00       	call   1610 <exit>

	void *hid7 = thread_create(hReady,(void *)0); 
    11e9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11f0:	00 
    11f1:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    11f8:	e8 dd 09 00 00       	call   1bda <thread_create>
    11fd:	89 44 24 40          	mov    %eax,0x40(%esp)
	if(hid7 == 0) exit();  
    1201:	83 7c 24 40 00       	cmpl   $0x0,0x40(%esp)
    1206:	75 05                	jne    120d <main+0x20d>
    1208:	e8 03 04 00 00       	call   1610 <exit>

	void *hid8 = thread_create(hReady,(void *)0); 
    120d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1214:	00 
    1215:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    121c:	e8 b9 09 00 00       	call   1bda <thread_create>
    1221:	89 44 24 44          	mov    %eax,0x44(%esp)
	if(hid8 == 0) exit();  
    1225:	83 7c 24 44 00       	cmpl   $0x0,0x44(%esp)
    122a:	75 05                	jne    1231 <main+0x231>
    122c:	e8 df 03 00 00       	call   1610 <exit>

	void *hid9 = thread_create(hReady,(void *)0); 
    1231:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1238:	00 
    1239:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    1240:	e8 95 09 00 00       	call   1bda <thread_create>
    1245:	89 44 24 48          	mov    %eax,0x48(%esp)
	if(hid9 == 0) exit();  
    1249:	83 7c 24 48 00       	cmpl   $0x0,0x48(%esp)
    124e:	75 05                	jne    1255 <main+0x255>
    1250:	e8 bb 03 00 00       	call   1610 <exit>

	
	void *hid10 = thread_create(hReady,(void *)0); 
    1255:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    125c:	00 
    125d:	c7 04 24 46 13 00 00 	movl   $0x1346,(%esp)
    1264:	e8 71 09 00 00       	call   1bda <thread_create>
    1269:	89 44 24 4c          	mov    %eax,0x4c(%esp)
	if(hid10 == 0) exit();  
    126d:	83 7c 24 4c 00       	cmpl   $0x0,0x4c(%esp)
    1272:	75 05                	jne    1279 <main+0x279>
    1274:	e8 97 03 00 00       	call   1610 <exit>

	while(wait() > 0);
    1279:	e8 9a 03 00 00       	call   1618 <wait>
    127e:	85 c0                	test   %eax,%eax
    1280:	7f f7                	jg     1279 <main+0x279>

	exit(); 
    1282:	e8 89 03 00 00       	call   1610 <exit>

00001287 <oReady>:
	return 0;
}

void oReady(void *arg) {
    1287:	55                   	push   %ebp
    1288:	89 e5                	mov    %esp,%ebp
    128a:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    128d:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1294:	e8 07 09 00 00       	call   1ba0 <lock_acquire>
	oxygen++; 
    1299:	a1 e8 1f 00 00       	mov    0x1fe8,%eax
    129e:	83 c0 01             	add    $0x1,%eax
    12a1:	a3 e8 1f 00 00       	mov    %eax,0x1fe8
	printf(1,"created one oxygen. Oxygen count: %d.\n",oxygen);  
    12a6:	a1 e8 1f 00 00       	mov    0x1fe8,%eax
    12ab:	89 44 24 08          	mov    %eax,0x8(%esp)
    12af:	c7 44 24 04 24 1f 00 	movl   $0x1f24,0x4(%esp)
    12b6:	00 
    12b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    12be:	e8 ee 04 00 00       	call   17b1 <printf>
	lock_release(&mutex.lock);
    12c3:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    12ca:	e8 f0 08 00 00       	call   1bbf <lock_release>
	sem_acquire(&h);  
    12cf:	c7 04 24 10 20 00 00 	movl   $0x2010,(%esp)
    12d6:	e8 11 0b 00 00       	call   1dec <sem_acquire>
	sem_acquire(&h);
    12db:	c7 04 24 10 20 00 00 	movl   $0x2010,(%esp)
    12e2:	e8 05 0b 00 00       	call   1dec <sem_acquire>
	sem_signal(&o);
    12e7:	c7 04 24 f8 1f 00 00 	movl   $0x1ff8,(%esp)
    12ee:	e8 57 0b 00 00       	call   1e4a <sem_signal>
	sem_signal(&o); 
    12f3:	c7 04 24 f8 1f 00 00 	movl   $0x1ff8,(%esp)
    12fa:	e8 4b 0b 00 00       	call   1e4a <sem_signal>
	lock_acquire(&mutex.lock);
    12ff:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1306:	e8 95 08 00 00       	call   1ba0 <lock_acquire>
	water_molecule++;
    130b:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    1310:	83 c0 01             	add    $0x1,%eax
    1313:	a3 e0 1f 00 00       	mov    %eax,0x1fe0
 	printf(1,"created water molecule: %d.\n",water_molecule); 	
    1318:	a1 e0 1f 00 00       	mov    0x1fe0,%eax
    131d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1321:	c7 44 24 04 4b 1f 00 	movl   $0x1f4b,0x4(%esp)
    1328:	00 
    1329:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1330:	e8 7c 04 00 00       	call   17b1 <printf>
	lock_release(&mutex.lock); 	 
    1335:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    133c:	e8 7e 08 00 00       	call   1bbf <lock_release>

	texit(); 	
    1341:	e8 72 03 00 00       	call   16b8 <texit>

00001346 <hReady>:
}

void hReady(void *arg) { 
    1346:	55                   	push   %ebp
    1347:	89 e5                	mov    %esp,%ebp
    1349:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    134c:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1353:	e8 48 08 00 00       	call   1ba0 <lock_acquire>
	hydrogen++; 
    1358:	a1 e4 1f 00 00       	mov    0x1fe4,%eax
    135d:	83 c0 01             	add    $0x1,%eax
    1360:	a3 e4 1f 00 00       	mov    %eax,0x1fe4
	printf(1,"created one hydrogen. Hydrogen count: %d.\n",hydrogen); 	
    1365:	a1 e4 1f 00 00       	mov    0x1fe4,%eax
    136a:	89 44 24 08          	mov    %eax,0x8(%esp)
    136e:	c7 44 24 04 68 1f 00 	movl   $0x1f68,0x4(%esp)
    1375:	00 
    1376:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    137d:	e8 2f 04 00 00       	call   17b1 <printf>
	lock_release(&mutex.lock); 
    1382:	c7 04 24 0c 20 00 00 	movl   $0x200c,(%esp)
    1389:	e8 31 08 00 00       	call   1bbf <lock_release>
	sem_signal(&h);
    138e:	c7 04 24 10 20 00 00 	movl   $0x2010,(%esp)
    1395:	e8 b0 0a 00 00       	call   1e4a <sem_signal>
	sem_acquire(&o);
    139a:	c7 04 24 f8 1f 00 00 	movl   $0x1ff8,(%esp)
    13a1:	e8 46 0a 00 00       	call   1dec <sem_acquire>

	texit();  
    13a6:	e8 0d 03 00 00       	call   16b8 <texit>
    13ab:	90                   	nop

000013ac <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    13ac:	55                   	push   %ebp
    13ad:	89 e5                	mov    %esp,%ebp
    13af:	57                   	push   %edi
    13b0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    13b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    13b4:	8b 55 10             	mov    0x10(%ebp),%edx
    13b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ba:	89 cb                	mov    %ecx,%ebx
    13bc:	89 df                	mov    %ebx,%edi
    13be:	89 d1                	mov    %edx,%ecx
    13c0:	fc                   	cld    
    13c1:	f3 aa                	rep stos %al,%es:(%edi)
    13c3:	89 ca                	mov    %ecx,%edx
    13c5:	89 fb                	mov    %edi,%ebx
    13c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    13ca:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    13cd:	5b                   	pop    %ebx
    13ce:	5f                   	pop    %edi
    13cf:	5d                   	pop    %ebp
    13d0:	c3                   	ret    

000013d1 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    13d1:	55                   	push   %ebp
    13d2:	89 e5                	mov    %esp,%ebp
    13d4:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    13dd:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e0:	0f b6 10             	movzbl (%eax),%edx
    13e3:	8b 45 08             	mov    0x8(%ebp),%eax
    13e6:	88 10                	mov    %dl,(%eax)
    13e8:	8b 45 08             	mov    0x8(%ebp),%eax
    13eb:	0f b6 00             	movzbl (%eax),%eax
    13ee:	84 c0                	test   %al,%al
    13f0:	0f 95 c0             	setne  %al
    13f3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    13f7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    13fb:	84 c0                	test   %al,%al
    13fd:	75 de                	jne    13dd <strcpy+0xc>
    ;
  return os;
    13ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1402:	c9                   	leave  
    1403:	c3                   	ret    

00001404 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1404:	55                   	push   %ebp
    1405:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1407:	eb 08                	jmp    1411 <strcmp+0xd>
    p++, q++;
    1409:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    140d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1411:	8b 45 08             	mov    0x8(%ebp),%eax
    1414:	0f b6 00             	movzbl (%eax),%eax
    1417:	84 c0                	test   %al,%al
    1419:	74 10                	je     142b <strcmp+0x27>
    141b:	8b 45 08             	mov    0x8(%ebp),%eax
    141e:	0f b6 10             	movzbl (%eax),%edx
    1421:	8b 45 0c             	mov    0xc(%ebp),%eax
    1424:	0f b6 00             	movzbl (%eax),%eax
    1427:	38 c2                	cmp    %al,%dl
    1429:	74 de                	je     1409 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    142b:	8b 45 08             	mov    0x8(%ebp),%eax
    142e:	0f b6 00             	movzbl (%eax),%eax
    1431:	0f b6 d0             	movzbl %al,%edx
    1434:	8b 45 0c             	mov    0xc(%ebp),%eax
    1437:	0f b6 00             	movzbl (%eax),%eax
    143a:	0f b6 c0             	movzbl %al,%eax
    143d:	89 d1                	mov    %edx,%ecx
    143f:	29 c1                	sub    %eax,%ecx
    1441:	89 c8                	mov    %ecx,%eax
}
    1443:	5d                   	pop    %ebp
    1444:	c3                   	ret    

00001445 <strlen>:

uint
strlen(char *s)
{
    1445:	55                   	push   %ebp
    1446:	89 e5                	mov    %esp,%ebp
    1448:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    144b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    1452:	eb 04                	jmp    1458 <strlen+0x13>
    1454:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1458:	8b 45 fc             	mov    -0x4(%ebp),%eax
    145b:	03 45 08             	add    0x8(%ebp),%eax
    145e:	0f b6 00             	movzbl (%eax),%eax
    1461:	84 c0                	test   %al,%al
    1463:	75 ef                	jne    1454 <strlen+0xf>
    ;
  return n;
    1465:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1468:	c9                   	leave  
    1469:	c3                   	ret    

0000146a <memset>:

void*
memset(void *dst, int c, uint n)
{
    146a:	55                   	push   %ebp
    146b:	89 e5                	mov    %esp,%ebp
    146d:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1470:	8b 45 10             	mov    0x10(%ebp),%eax
    1473:	89 44 24 08          	mov    %eax,0x8(%esp)
    1477:	8b 45 0c             	mov    0xc(%ebp),%eax
    147a:	89 44 24 04          	mov    %eax,0x4(%esp)
    147e:	8b 45 08             	mov    0x8(%ebp),%eax
    1481:	89 04 24             	mov    %eax,(%esp)
    1484:	e8 23 ff ff ff       	call   13ac <stosb>
  return dst;
    1489:	8b 45 08             	mov    0x8(%ebp),%eax
}
    148c:	c9                   	leave  
    148d:	c3                   	ret    

0000148e <strchr>:

char*
strchr(const char *s, char c)
{
    148e:	55                   	push   %ebp
    148f:	89 e5                	mov    %esp,%ebp
    1491:	83 ec 04             	sub    $0x4,%esp
    1494:	8b 45 0c             	mov    0xc(%ebp),%eax
    1497:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    149a:	eb 14                	jmp    14b0 <strchr+0x22>
    if(*s == c)
    149c:	8b 45 08             	mov    0x8(%ebp),%eax
    149f:	0f b6 00             	movzbl (%eax),%eax
    14a2:	3a 45 fc             	cmp    -0x4(%ebp),%al
    14a5:	75 05                	jne    14ac <strchr+0x1e>
      return (char*)s;
    14a7:	8b 45 08             	mov    0x8(%ebp),%eax
    14aa:	eb 13                	jmp    14bf <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    14ac:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    14b0:	8b 45 08             	mov    0x8(%ebp),%eax
    14b3:	0f b6 00             	movzbl (%eax),%eax
    14b6:	84 c0                	test   %al,%al
    14b8:	75 e2                	jne    149c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    14ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
    14bf:	c9                   	leave  
    14c0:	c3                   	ret    

000014c1 <gets>:

char*
gets(char *buf, int max)
{
    14c1:	55                   	push   %ebp
    14c2:	89 e5                	mov    %esp,%ebp
    14c4:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    14c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14ce:	eb 44                	jmp    1514 <gets+0x53>
    cc = read(0, &c, 1);
    14d0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14d7:	00 
    14d8:	8d 45 ef             	lea    -0x11(%ebp),%eax
    14db:	89 44 24 04          	mov    %eax,0x4(%esp)
    14df:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    14e6:	e8 3d 01 00 00       	call   1628 <read>
    14eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    14ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14f2:	7e 2d                	jle    1521 <gets+0x60>
      break;
    buf[i++] = c;
    14f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    14f7:	03 45 08             	add    0x8(%ebp),%eax
    14fa:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    14fe:	88 10                	mov    %dl,(%eax)
    1500:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1504:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1508:	3c 0a                	cmp    $0xa,%al
    150a:	74 16                	je     1522 <gets+0x61>
    150c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1510:	3c 0d                	cmp    $0xd,%al
    1512:	74 0e                	je     1522 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1514:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1517:	83 c0 01             	add    $0x1,%eax
    151a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    151d:	7c b1                	jl     14d0 <gets+0xf>
    151f:	eb 01                	jmp    1522 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1521:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1522:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1525:	03 45 08             	add    0x8(%ebp),%eax
    1528:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    152b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    152e:	c9                   	leave  
    152f:	c3                   	ret    

00001530 <stat>:

int
stat(char *n, struct stat *st)
{
    1530:	55                   	push   %ebp
    1531:	89 e5                	mov    %esp,%ebp
    1533:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1536:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    153d:	00 
    153e:	8b 45 08             	mov    0x8(%ebp),%eax
    1541:	89 04 24             	mov    %eax,(%esp)
    1544:	e8 07 01 00 00       	call   1650 <open>
    1549:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    154c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1550:	79 07                	jns    1559 <stat+0x29>
    return -1;
    1552:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1557:	eb 23                	jmp    157c <stat+0x4c>
  r = fstat(fd, st);
    1559:	8b 45 0c             	mov    0xc(%ebp),%eax
    155c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1560:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1563:	89 04 24             	mov    %eax,(%esp)
    1566:	e8 fd 00 00 00       	call   1668 <fstat>
    156b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    156e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1571:	89 04 24             	mov    %eax,(%esp)
    1574:	e8 bf 00 00 00       	call   1638 <close>
  return r;
    1579:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    157c:	c9                   	leave  
    157d:	c3                   	ret    

0000157e <atoi>:

int
atoi(const char *s)
{
    157e:	55                   	push   %ebp
    157f:	89 e5                	mov    %esp,%ebp
    1581:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1584:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    158b:	eb 24                	jmp    15b1 <atoi+0x33>
    n = n*10 + *s++ - '0';
    158d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1590:	89 d0                	mov    %edx,%eax
    1592:	c1 e0 02             	shl    $0x2,%eax
    1595:	01 d0                	add    %edx,%eax
    1597:	01 c0                	add    %eax,%eax
    1599:	89 c2                	mov    %eax,%edx
    159b:	8b 45 08             	mov    0x8(%ebp),%eax
    159e:	0f b6 00             	movzbl (%eax),%eax
    15a1:	0f be c0             	movsbl %al,%eax
    15a4:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15a7:	83 e8 30             	sub    $0x30,%eax
    15aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    15b1:	8b 45 08             	mov    0x8(%ebp),%eax
    15b4:	0f b6 00             	movzbl (%eax),%eax
    15b7:	3c 2f                	cmp    $0x2f,%al
    15b9:	7e 0a                	jle    15c5 <atoi+0x47>
    15bb:	8b 45 08             	mov    0x8(%ebp),%eax
    15be:	0f b6 00             	movzbl (%eax),%eax
    15c1:	3c 39                	cmp    $0x39,%al
    15c3:	7e c8                	jle    158d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    15c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    15c8:	c9                   	leave  
    15c9:	c3                   	ret    

000015ca <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    15ca:	55                   	push   %ebp
    15cb:	89 e5                	mov    %esp,%ebp
    15cd:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    15d0:	8b 45 08             	mov    0x8(%ebp),%eax
    15d3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    15d6:	8b 45 0c             	mov    0xc(%ebp),%eax
    15d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    15dc:	eb 13                	jmp    15f1 <memmove+0x27>
    *dst++ = *src++;
    15de:	8b 45 fc             	mov    -0x4(%ebp),%eax
    15e1:	0f b6 10             	movzbl (%eax),%edx
    15e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
    15e7:	88 10                	mov    %dl,(%eax)
    15e9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    15ed:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    15f1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    15f5:	0f 9f c0             	setg   %al
    15f8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    15fc:	84 c0                	test   %al,%al
    15fe:	75 de                	jne    15de <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1600:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1603:	c9                   	leave  
    1604:	c3                   	ret    
    1605:	90                   	nop
    1606:	90                   	nop
    1607:	90                   	nop

00001608 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1608:	b8 01 00 00 00       	mov    $0x1,%eax
    160d:	cd 40                	int    $0x40
    160f:	c3                   	ret    

00001610 <exit>:
SYSCALL(exit)
    1610:	b8 02 00 00 00       	mov    $0x2,%eax
    1615:	cd 40                	int    $0x40
    1617:	c3                   	ret    

00001618 <wait>:
SYSCALL(wait)
    1618:	b8 03 00 00 00       	mov    $0x3,%eax
    161d:	cd 40                	int    $0x40
    161f:	c3                   	ret    

00001620 <pipe>:
SYSCALL(pipe)
    1620:	b8 04 00 00 00       	mov    $0x4,%eax
    1625:	cd 40                	int    $0x40
    1627:	c3                   	ret    

00001628 <read>:
SYSCALL(read)
    1628:	b8 05 00 00 00       	mov    $0x5,%eax
    162d:	cd 40                	int    $0x40
    162f:	c3                   	ret    

00001630 <write>:
SYSCALL(write)
    1630:	b8 10 00 00 00       	mov    $0x10,%eax
    1635:	cd 40                	int    $0x40
    1637:	c3                   	ret    

00001638 <close>:
SYSCALL(close)
    1638:	b8 15 00 00 00       	mov    $0x15,%eax
    163d:	cd 40                	int    $0x40
    163f:	c3                   	ret    

00001640 <kill>:
SYSCALL(kill)
    1640:	b8 06 00 00 00       	mov    $0x6,%eax
    1645:	cd 40                	int    $0x40
    1647:	c3                   	ret    

00001648 <exec>:
SYSCALL(exec)
    1648:	b8 07 00 00 00       	mov    $0x7,%eax
    164d:	cd 40                	int    $0x40
    164f:	c3                   	ret    

00001650 <open>:
SYSCALL(open)
    1650:	b8 0f 00 00 00       	mov    $0xf,%eax
    1655:	cd 40                	int    $0x40
    1657:	c3                   	ret    

00001658 <mknod>:
SYSCALL(mknod)
    1658:	b8 11 00 00 00       	mov    $0x11,%eax
    165d:	cd 40                	int    $0x40
    165f:	c3                   	ret    

00001660 <unlink>:
SYSCALL(unlink)
    1660:	b8 12 00 00 00       	mov    $0x12,%eax
    1665:	cd 40                	int    $0x40
    1667:	c3                   	ret    

00001668 <fstat>:
SYSCALL(fstat)
    1668:	b8 08 00 00 00       	mov    $0x8,%eax
    166d:	cd 40                	int    $0x40
    166f:	c3                   	ret    

00001670 <link>:
SYSCALL(link)
    1670:	b8 13 00 00 00       	mov    $0x13,%eax
    1675:	cd 40                	int    $0x40
    1677:	c3                   	ret    

00001678 <mkdir>:
SYSCALL(mkdir)
    1678:	b8 14 00 00 00       	mov    $0x14,%eax
    167d:	cd 40                	int    $0x40
    167f:	c3                   	ret    

00001680 <chdir>:
SYSCALL(chdir)
    1680:	b8 09 00 00 00       	mov    $0x9,%eax
    1685:	cd 40                	int    $0x40
    1687:	c3                   	ret    

00001688 <dup>:
SYSCALL(dup)
    1688:	b8 0a 00 00 00       	mov    $0xa,%eax
    168d:	cd 40                	int    $0x40
    168f:	c3                   	ret    

00001690 <getpid>:
SYSCALL(getpid)
    1690:	b8 0b 00 00 00       	mov    $0xb,%eax
    1695:	cd 40                	int    $0x40
    1697:	c3                   	ret    

00001698 <sbrk>:
SYSCALL(sbrk)
    1698:	b8 0c 00 00 00       	mov    $0xc,%eax
    169d:	cd 40                	int    $0x40
    169f:	c3                   	ret    

000016a0 <sleep>:
SYSCALL(sleep)
    16a0:	b8 0d 00 00 00       	mov    $0xd,%eax
    16a5:	cd 40                	int    $0x40
    16a7:	c3                   	ret    

000016a8 <uptime>:
SYSCALL(uptime)
    16a8:	b8 0e 00 00 00       	mov    $0xe,%eax
    16ad:	cd 40                	int    $0x40
    16af:	c3                   	ret    

000016b0 <clone>:
SYSCALL(clone)
    16b0:	b8 16 00 00 00       	mov    $0x16,%eax
    16b5:	cd 40                	int    $0x40
    16b7:	c3                   	ret    

000016b8 <texit>:
SYSCALL(texit)
    16b8:	b8 17 00 00 00       	mov    $0x17,%eax
    16bd:	cd 40                	int    $0x40
    16bf:	c3                   	ret    

000016c0 <tsleep>:
SYSCALL(tsleep)
    16c0:	b8 18 00 00 00       	mov    $0x18,%eax
    16c5:	cd 40                	int    $0x40
    16c7:	c3                   	ret    

000016c8 <twakeup>:
SYSCALL(twakeup)
    16c8:	b8 19 00 00 00       	mov    $0x19,%eax
    16cd:	cd 40                	int    $0x40
    16cf:	c3                   	ret    

000016d0 <thread_yield>:
SYSCALL(thread_yield) 
    16d0:	b8 1a 00 00 00       	mov    $0x1a,%eax
    16d5:	cd 40                	int    $0x40
    16d7:	c3                   	ret    

000016d8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    16d8:	55                   	push   %ebp
    16d9:	89 e5                	mov    %esp,%ebp
    16db:	83 ec 28             	sub    $0x28,%esp
    16de:	8b 45 0c             	mov    0xc(%ebp),%eax
    16e1:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    16e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    16eb:	00 
    16ec:	8d 45 f4             	lea    -0xc(%ebp),%eax
    16ef:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f3:	8b 45 08             	mov    0x8(%ebp),%eax
    16f6:	89 04 24             	mov    %eax,(%esp)
    16f9:	e8 32 ff ff ff       	call   1630 <write>
}
    16fe:	c9                   	leave  
    16ff:	c3                   	ret    

00001700 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1700:	55                   	push   %ebp
    1701:	89 e5                	mov    %esp,%ebp
    1703:	53                   	push   %ebx
    1704:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1707:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    170e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1712:	74 17                	je     172b <printint+0x2b>
    1714:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1718:	79 11                	jns    172b <printint+0x2b>
    neg = 1;
    171a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1721:	8b 45 0c             	mov    0xc(%ebp),%eax
    1724:	f7 d8                	neg    %eax
    1726:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1729:	eb 06                	jmp    1731 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    172b:	8b 45 0c             	mov    0xc(%ebp),%eax
    172e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1731:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1738:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    173b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    173e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1741:	ba 00 00 00 00       	mov    $0x0,%edx
    1746:	f7 f3                	div    %ebx
    1748:	89 d0                	mov    %edx,%eax
    174a:	0f b6 80 c8 1f 00 00 	movzbl 0x1fc8(%eax),%eax
    1751:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1755:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1759:	8b 45 10             	mov    0x10(%ebp),%eax
    175c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    175f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1762:	ba 00 00 00 00       	mov    $0x0,%edx
    1767:	f7 75 d4             	divl   -0x2c(%ebp)
    176a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    176d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1771:	75 c5                	jne    1738 <printint+0x38>
  if(neg)
    1773:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1777:	74 28                	je     17a1 <printint+0xa1>
    buf[i++] = '-';
    1779:	8b 45 ec             	mov    -0x14(%ebp),%eax
    177c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1781:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1785:	eb 1a                	jmp    17a1 <printint+0xa1>
    putc(fd, buf[i]);
    1787:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    178f:	0f be c0             	movsbl %al,%eax
    1792:	89 44 24 04          	mov    %eax,0x4(%esp)
    1796:	8b 45 08             	mov    0x8(%ebp),%eax
    1799:	89 04 24             	mov    %eax,(%esp)
    179c:	e8 37 ff ff ff       	call   16d8 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    17a1:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    17a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17a9:	79 dc                	jns    1787 <printint+0x87>
    putc(fd, buf[i]);
}
    17ab:	83 c4 44             	add    $0x44,%esp
    17ae:	5b                   	pop    %ebx
    17af:	5d                   	pop    %ebp
    17b0:	c3                   	ret    

000017b1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    17b1:	55                   	push   %ebp
    17b2:	89 e5                	mov    %esp,%ebp
    17b4:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    17b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    17be:	8d 45 0c             	lea    0xc(%ebp),%eax
    17c1:	83 c0 04             	add    $0x4,%eax
    17c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    17c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    17ce:	e9 7e 01 00 00       	jmp    1951 <printf+0x1a0>
    c = fmt[i] & 0xff;
    17d3:	8b 55 0c             	mov    0xc(%ebp),%edx
    17d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17d9:	8d 04 02             	lea    (%edx,%eax,1),%eax
    17dc:	0f b6 00             	movzbl (%eax),%eax
    17df:	0f be c0             	movsbl %al,%eax
    17e2:	25 ff 00 00 00       	and    $0xff,%eax
    17e7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    17ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    17ee:	75 2c                	jne    181c <printf+0x6b>
      if(c == '%'){
    17f0:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    17f4:	75 0c                	jne    1802 <printf+0x51>
        state = '%';
    17f6:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    17fd:	e9 4b 01 00 00       	jmp    194d <printf+0x19c>
      } else {
        putc(fd, c);
    1802:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1805:	0f be c0             	movsbl %al,%eax
    1808:	89 44 24 04          	mov    %eax,0x4(%esp)
    180c:	8b 45 08             	mov    0x8(%ebp),%eax
    180f:	89 04 24             	mov    %eax,(%esp)
    1812:	e8 c1 fe ff ff       	call   16d8 <putc>
    1817:	e9 31 01 00 00       	jmp    194d <printf+0x19c>
      }
    } else if(state == '%'){
    181c:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1820:	0f 85 27 01 00 00    	jne    194d <printf+0x19c>
      if(c == 'd'){
    1826:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    182a:	75 2d                	jne    1859 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    182f:	8b 00                	mov    (%eax),%eax
    1831:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1838:	00 
    1839:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1840:	00 
    1841:	89 44 24 04          	mov    %eax,0x4(%esp)
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	89 04 24             	mov    %eax,(%esp)
    184b:	e8 b0 fe ff ff       	call   1700 <printint>
        ap++;
    1850:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1854:	e9 ed 00 00 00       	jmp    1946 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1859:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    185d:	74 06                	je     1865 <printf+0xb4>
    185f:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    1863:	75 2d                	jne    1892 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    1865:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1868:	8b 00                	mov    (%eax),%eax
    186a:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1871:	00 
    1872:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1879:	00 
    187a:	89 44 24 04          	mov    %eax,0x4(%esp)
    187e:	8b 45 08             	mov    0x8(%ebp),%eax
    1881:	89 04 24             	mov    %eax,(%esp)
    1884:	e8 77 fe ff ff       	call   1700 <printint>
        ap++;
    1889:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    188d:	e9 b4 00 00 00       	jmp    1946 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1892:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1896:	75 46                	jne    18de <printf+0x12d>
        s = (char*)*ap;
    1898:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189b:	8b 00                	mov    (%eax),%eax
    189d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    18a0:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    18a4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    18a8:	75 27                	jne    18d1 <printf+0x120>
          s = "(null)";
    18aa:	c7 45 e4 93 1f 00 00 	movl   $0x1f93,-0x1c(%ebp)
        while(*s != 0){
    18b1:	eb 1f                	jmp    18d2 <printf+0x121>
          putc(fd, *s);
    18b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18b6:	0f b6 00             	movzbl (%eax),%eax
    18b9:	0f be c0             	movsbl %al,%eax
    18bc:	89 44 24 04          	mov    %eax,0x4(%esp)
    18c0:	8b 45 08             	mov    0x8(%ebp),%eax
    18c3:	89 04 24             	mov    %eax,(%esp)
    18c6:	e8 0d fe ff ff       	call   16d8 <putc>
          s++;
    18cb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    18cf:	eb 01                	jmp    18d2 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    18d1:	90                   	nop
    18d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    18d5:	0f b6 00             	movzbl (%eax),%eax
    18d8:	84 c0                	test   %al,%al
    18da:	75 d7                	jne    18b3 <printf+0x102>
    18dc:	eb 68                	jmp    1946 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    18de:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    18e2:	75 1d                	jne    1901 <printf+0x150>
        putc(fd, *ap);
    18e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18e7:	8b 00                	mov    (%eax),%eax
    18e9:	0f be c0             	movsbl %al,%eax
    18ec:	89 44 24 04          	mov    %eax,0x4(%esp)
    18f0:	8b 45 08             	mov    0x8(%ebp),%eax
    18f3:	89 04 24             	mov    %eax,(%esp)
    18f6:	e8 dd fd ff ff       	call   16d8 <putc>
        ap++;
    18fb:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    18ff:	eb 45                	jmp    1946 <printf+0x195>
      } else if(c == '%'){
    1901:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1905:	75 17                	jne    191e <printf+0x16d>
        putc(fd, c);
    1907:	8b 45 e8             	mov    -0x18(%ebp),%eax
    190a:	0f be c0             	movsbl %al,%eax
    190d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1911:	8b 45 08             	mov    0x8(%ebp),%eax
    1914:	89 04 24             	mov    %eax,(%esp)
    1917:	e8 bc fd ff ff       	call   16d8 <putc>
    191c:	eb 28                	jmp    1946 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    191e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1925:	00 
    1926:	8b 45 08             	mov    0x8(%ebp),%eax
    1929:	89 04 24             	mov    %eax,(%esp)
    192c:	e8 a7 fd ff ff       	call   16d8 <putc>
        putc(fd, c);
    1931:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1934:	0f be c0             	movsbl %al,%eax
    1937:	89 44 24 04          	mov    %eax,0x4(%esp)
    193b:	8b 45 08             	mov    0x8(%ebp),%eax
    193e:	89 04 24             	mov    %eax,(%esp)
    1941:	e8 92 fd ff ff       	call   16d8 <putc>
      }
      state = 0;
    1946:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    194d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1951:	8b 55 0c             	mov    0xc(%ebp),%edx
    1954:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1957:	8d 04 02             	lea    (%edx,%eax,1),%eax
    195a:	0f b6 00             	movzbl (%eax),%eax
    195d:	84 c0                	test   %al,%al
    195f:	0f 85 6e fe ff ff    	jne    17d3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1965:	c9                   	leave  
    1966:	c3                   	ret    
    1967:	90                   	nop

00001968 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1968:	55                   	push   %ebp
    1969:	89 e5                	mov    %esp,%ebp
    196b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    196e:	8b 45 08             	mov    0x8(%ebp),%eax
    1971:	83 e8 08             	sub    $0x8,%eax
    1974:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1977:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    197c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    197f:	eb 24                	jmp    19a5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1981:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1984:	8b 00                	mov    (%eax),%eax
    1986:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1989:	77 12                	ja     199d <free+0x35>
    198b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    198e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1991:	77 24                	ja     19b7 <free+0x4f>
    1993:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1996:	8b 00                	mov    (%eax),%eax
    1998:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    199b:	77 1a                	ja     19b7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    199d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19a0:	8b 00                	mov    (%eax),%eax
    19a2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    19a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19a8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    19ab:	76 d4                	jbe    1981 <free+0x19>
    19ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19b0:	8b 00                	mov    (%eax),%eax
    19b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    19b5:	76 ca                	jbe    1981 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    19b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19ba:	8b 40 04             	mov    0x4(%eax),%eax
    19bd:	c1 e0 03             	shl    $0x3,%eax
    19c0:	89 c2                	mov    %eax,%edx
    19c2:	03 55 f8             	add    -0x8(%ebp),%edx
    19c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19c8:	8b 00                	mov    (%eax),%eax
    19ca:	39 c2                	cmp    %eax,%edx
    19cc:	75 24                	jne    19f2 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    19ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19d1:	8b 50 04             	mov    0x4(%eax),%edx
    19d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19d7:	8b 00                	mov    (%eax),%eax
    19d9:	8b 40 04             	mov    0x4(%eax),%eax
    19dc:	01 c2                	add    %eax,%edx
    19de:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19e1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    19e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19e7:	8b 00                	mov    (%eax),%eax
    19e9:	8b 10                	mov    (%eax),%edx
    19eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19ee:	89 10                	mov    %edx,(%eax)
    19f0:	eb 0a                	jmp    19fc <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    19f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19f5:	8b 10                	mov    (%eax),%edx
    19f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    19fa:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    19fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    19ff:	8b 40 04             	mov    0x4(%eax),%eax
    1a02:	c1 e0 03             	shl    $0x3,%eax
    1a05:	03 45 fc             	add    -0x4(%ebp),%eax
    1a08:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1a0b:	75 20                	jne    1a2d <free+0xc5>
    p->s.size += bp->s.size;
    1a0d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a10:	8b 50 04             	mov    0x4(%eax),%edx
    1a13:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a16:	8b 40 04             	mov    0x4(%eax),%eax
    1a19:	01 c2                	add    %eax,%edx
    1a1b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a1e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1a21:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1a24:	8b 10                	mov    (%eax),%edx
    1a26:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a29:	89 10                	mov    %edx,(%eax)
    1a2b:	eb 08                	jmp    1a35 <free+0xcd>
  } else
    p->s.ptr = bp;
    1a2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a30:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1a33:	89 10                	mov    %edx,(%eax)
  freep = p;
    1a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1a38:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
}
    1a3d:	c9                   	leave  
    1a3e:	c3                   	ret    

00001a3f <morecore>:

static Header*
morecore(uint nu)
{
    1a3f:	55                   	push   %ebp
    1a40:	89 e5                	mov    %esp,%ebp
    1a42:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1a45:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1a4c:	77 07                	ja     1a55 <morecore+0x16>
    nu = 4096;
    1a4e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1a55:	8b 45 08             	mov    0x8(%ebp),%eax
    1a58:	c1 e0 03             	shl    $0x3,%eax
    1a5b:	89 04 24             	mov    %eax,(%esp)
    1a5e:	e8 35 fc ff ff       	call   1698 <sbrk>
    1a63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    1a66:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1a6a:	75 07                	jne    1a73 <morecore+0x34>
    return 0;
    1a6c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a71:	eb 22                	jmp    1a95 <morecore+0x56>
  hp = (Header*)p;
    1a73:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a7c:	8b 55 08             	mov    0x8(%ebp),%edx
    1a7f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1a82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a85:	83 c0 08             	add    $0x8,%eax
    1a88:	89 04 24             	mov    %eax,(%esp)
    1a8b:	e8 d8 fe ff ff       	call   1968 <free>
  return freep;
    1a90:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
}
    1a95:	c9                   	leave  
    1a96:	c3                   	ret    

00001a97 <malloc>:

void*
malloc(uint nbytes)
{
    1a97:	55                   	push   %ebp
    1a98:	89 e5                	mov    %esp,%ebp
    1a9a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1a9d:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa0:	83 c0 07             	add    $0x7,%eax
    1aa3:	c1 e8 03             	shr    $0x3,%eax
    1aa6:	83 c0 01             	add    $0x1,%eax
    1aa9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1aac:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1ab4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1ab8:	75 23                	jne    1add <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    1aba:	c7 45 f0 ec 1f 00 00 	movl   $0x1fec,-0x10(%ebp)
    1ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ac4:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
    1ac9:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1ace:	a3 ec 1f 00 00       	mov    %eax,0x1fec
    base.s.size = 0;
    1ad3:	c7 05 f0 1f 00 00 00 	movl   $0x0,0x1ff0
    1ada:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1add:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1ae0:	8b 00                	mov    (%eax),%eax
    1ae2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1ae5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1ae8:	8b 40 04             	mov    0x4(%eax),%eax
    1aeb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1aee:	72 4d                	jb     1b3d <malloc+0xa6>
      if(p->s.size == nunits)
    1af0:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1af3:	8b 40 04             	mov    0x4(%eax),%eax
    1af6:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1af9:	75 0c                	jne    1b07 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1afb:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1afe:	8b 10                	mov    (%eax),%edx
    1b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b03:	89 10                	mov    %edx,(%eax)
    1b05:	eb 26                	jmp    1b2d <malloc+0x96>
      else {
        p->s.size -= nunits;
    1b07:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b0a:	8b 40 04             	mov    0x4(%eax),%eax
    1b0d:	89 c2                	mov    %eax,%edx
    1b0f:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1b12:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b15:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1b18:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b1b:	8b 40 04             	mov    0x4(%eax),%eax
    1b1e:	c1 e0 03             	shl    $0x3,%eax
    1b21:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1b24:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b27:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b2a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1b2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b30:	a3 f4 1f 00 00       	mov    %eax,0x1ff4
      return (void*)(p + 1);
    1b35:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b38:	83 c0 08             	add    $0x8,%eax
    1b3b:	eb 38                	jmp    1b75 <malloc+0xde>
    }
    if(p == freep)
    1b3d:	a1 f4 1f 00 00       	mov    0x1ff4,%eax
    1b42:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1b45:	75 1b                	jne    1b62 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b4a:	89 04 24             	mov    %eax,(%esp)
    1b4d:	e8 ed fe ff ff       	call   1a3f <morecore>
    1b52:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1b55:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b59:	75 07                	jne    1b62 <malloc+0xcb>
        return 0;
    1b5b:	b8 00 00 00 00       	mov    $0x0,%eax
    1b60:	eb 13                	jmp    1b75 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1b62:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b65:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1b68:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1b6b:	8b 00                	mov    (%eax),%eax
    1b6d:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1b70:	e9 70 ff ff ff       	jmp    1ae5 <malloc+0x4e>
}
    1b75:	c9                   	leave  
    1b76:	c3                   	ret    
    1b77:	90                   	nop

00001b78 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1b78:	55                   	push   %ebp
    1b79:	89 e5                	mov    %esp,%ebp
    1b7b:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1b7e:	8b 55 08             	mov    0x8(%ebp),%edx
    1b81:	8b 45 0c             	mov    0xc(%ebp),%eax
    1b84:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b87:	f0 87 02             	lock xchg %eax,(%edx)
    1b8a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1b8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1b90:	c9                   	leave  
    1b91:	c3                   	ret    

00001b92 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1b92:	55                   	push   %ebp
    1b93:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1b95:	8b 45 08             	mov    0x8(%ebp),%eax
    1b98:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    1b9e:	5d                   	pop    %ebp
    1b9f:	c3                   	ret    

00001ba0 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1ba0:	55                   	push   %ebp
    1ba1:	89 e5                	mov    %esp,%ebp
    1ba3:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1ba6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1bb0:	00 
    1bb1:	89 04 24             	mov    %eax,(%esp)
    1bb4:	e8 bf ff ff ff       	call   1b78 <xchg>
    1bb9:	85 c0                	test   %eax,%eax
    1bbb:	75 e9                	jne    1ba6 <lock_acquire+0x6>
}
    1bbd:	c9                   	leave  
    1bbe:	c3                   	ret    

00001bbf <lock_release>:
void lock_release(lock_t *lock){
    1bbf:	55                   	push   %ebp
    1bc0:	89 e5                	mov    %esp,%ebp
    1bc2:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1bc5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1bcf:	00 
    1bd0:	89 04 24             	mov    %eax,(%esp)
    1bd3:	e8 a0 ff ff ff       	call   1b78 <xchg>
}
    1bd8:	c9                   	leave  
    1bd9:	c3                   	ret    

00001bda <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1bda:	55                   	push   %ebp
    1bdb:	89 e5                	mov    %esp,%ebp
    1bdd:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1be0:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1be7:	e8 ab fe ff ff       	call   1a97 <malloc>
    1bec:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1bef:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1bf8:	25 ff 0f 00 00       	and    $0xfff,%eax
    1bfd:	85 c0                	test   %eax,%eax
    1bff:	74 15                	je     1c16 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1c01:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c04:	89 c2                	mov    %eax,%edx
    1c06:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1c0c:	b8 00 10 00 00       	mov    $0x1000,%eax
    1c11:	29 d0                	sub    %edx,%eax
    1c13:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1c16:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1c1a:	75 1b                	jne    1c37 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1c1c:	c7 44 24 04 9a 1f 00 	movl   $0x1f9a,0x4(%esp)
    1c23:	00 
    1c24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c2b:	e8 81 fb ff ff       	call   17b1 <printf>
        return 0;
    1c30:	b8 00 00 00 00       	mov    $0x0,%eax
    1c35:	eb 6f                	jmp    1ca6 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1c37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1c3a:	8b 55 08             	mov    0x8(%ebp),%edx
    1c3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c40:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1c44:	89 54 24 08          	mov    %edx,0x8(%esp)
    1c48:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1c4f:	00 
    1c50:	89 04 24             	mov    %eax,(%esp)
    1c53:	e8 58 fa ff ff       	call   16b0 <clone>
    1c58:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1c5b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c5f:	79 1b                	jns    1c7c <thread_create+0xa2>
        printf(1,"clone fails\n");
    1c61:	c7 44 24 04 a8 1f 00 	movl   $0x1fa8,0x4(%esp)
    1c68:	00 
    1c69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c70:	e8 3c fb ff ff       	call   17b1 <printf>
        return 0;
    1c75:	b8 00 00 00 00       	mov    $0x0,%eax
    1c7a:	eb 2a                	jmp    1ca6 <thread_create+0xcc>
    }
    if(tid > 0){
    1c7c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c80:	7e 05                	jle    1c87 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1c82:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c85:	eb 1f                	jmp    1ca6 <thread_create+0xcc>
    }
    if(tid == 0){
    1c87:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1c8b:	75 14                	jne    1ca1 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1c8d:	c7 44 24 04 b5 1f 00 	movl   $0x1fb5,0x4(%esp)
    1c94:	00 
    1c95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c9c:	e8 10 fb ff ff       	call   17b1 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1ca1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ca6:	c9                   	leave  
    1ca7:	c3                   	ret    

00001ca8 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ca8:	55                   	push   %ebp
    1ca9:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1cab:	a1 dc 1f 00 00       	mov    0x1fdc,%eax
    1cb0:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1cb6:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1cbb:	a3 dc 1f 00 00       	mov    %eax,0x1fdc
    return (int)(rands % max);
    1cc0:	a1 dc 1f 00 00       	mov    0x1fdc,%eax
    1cc5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1cc8:	ba 00 00 00 00       	mov    $0x0,%edx
    1ccd:	f7 f1                	div    %ecx
    1ccf:	89 d0                	mov    %edx,%eax
}
    1cd1:	5d                   	pop    %ebp
    1cd2:	c3                   	ret    
    1cd3:	90                   	nop

00001cd4 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1cd4:	55                   	push   %ebp
    1cd5:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1cd7:	8b 45 08             	mov    0x8(%ebp),%eax
    1cda:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ce0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce3:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1cea:	8b 45 08             	mov    0x8(%ebp),%eax
    1ced:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1cf4:	5d                   	pop    %ebp
    1cf5:	c3                   	ret    

00001cf6 <add_q>:

void add_q(struct queue *q, int v){
    1cf6:	55                   	push   %ebp
    1cf7:	89 e5                	mov    %esp,%ebp
    1cf9:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1cfc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1d03:	e8 8f fd ff ff       	call   1a97 <malloc>
    1d08:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d0e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1d15:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1d18:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d1b:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1d1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1d20:	8b 40 04             	mov    0x4(%eax),%eax
    1d23:	85 c0                	test   %eax,%eax
    1d25:	75 0b                	jne    1d32 <add_q+0x3c>
        q->head = n;
    1d27:	8b 45 08             	mov    0x8(%ebp),%eax
    1d2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d2d:	89 50 04             	mov    %edx,0x4(%eax)
    1d30:	eb 0c                	jmp    1d3e <add_q+0x48>
    }else{
        q->tail->next = n;
    1d32:	8b 45 08             	mov    0x8(%ebp),%eax
    1d35:	8b 40 08             	mov    0x8(%eax),%eax
    1d38:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d3b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1d3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1d41:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1d44:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1d47:	8b 45 08             	mov    0x8(%ebp),%eax
    1d4a:	8b 00                	mov    (%eax),%eax
    1d4c:	8d 50 01             	lea    0x1(%eax),%edx
    1d4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1d52:	89 10                	mov    %edx,(%eax)
}
    1d54:	c9                   	leave  
    1d55:	c3                   	ret    

00001d56 <empty_q>:

int empty_q(struct queue *q){
    1d56:	55                   	push   %ebp
    1d57:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1d59:	8b 45 08             	mov    0x8(%ebp),%eax
    1d5c:	8b 00                	mov    (%eax),%eax
    1d5e:	85 c0                	test   %eax,%eax
    1d60:	75 07                	jne    1d69 <empty_q+0x13>
        return 1;
    1d62:	b8 01 00 00 00       	mov    $0x1,%eax
    1d67:	eb 05                	jmp    1d6e <empty_q+0x18>
    else
        return 0;
    1d69:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1d6e:	5d                   	pop    %ebp
    1d6f:	c3                   	ret    

00001d70 <pop_q>:
int pop_q(struct queue *q){
    1d70:	55                   	push   %ebp
    1d71:	89 e5                	mov    %esp,%ebp
    1d73:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1d76:	8b 45 08             	mov    0x8(%ebp),%eax
    1d79:	89 04 24             	mov    %eax,(%esp)
    1d7c:	e8 d5 ff ff ff       	call   1d56 <empty_q>
    1d81:	85 c0                	test   %eax,%eax
    1d83:	75 5d                	jne    1de2 <pop_q+0x72>
       val = q->head->value; 
    1d85:	8b 45 08             	mov    0x8(%ebp),%eax
    1d88:	8b 40 04             	mov    0x4(%eax),%eax
    1d8b:	8b 00                	mov    (%eax),%eax
    1d8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1d90:	8b 45 08             	mov    0x8(%ebp),%eax
    1d93:	8b 40 04             	mov    0x4(%eax),%eax
    1d96:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1d99:	8b 45 08             	mov    0x8(%ebp),%eax
    1d9c:	8b 40 04             	mov    0x4(%eax),%eax
    1d9f:	8b 50 04             	mov    0x4(%eax),%edx
    1da2:	8b 45 08             	mov    0x8(%ebp),%eax
    1da5:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1da8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1dab:	89 04 24             	mov    %eax,(%esp)
    1dae:	e8 b5 fb ff ff       	call   1968 <free>
       q->size--;
    1db3:	8b 45 08             	mov    0x8(%ebp),%eax
    1db6:	8b 00                	mov    (%eax),%eax
    1db8:	8d 50 ff             	lea    -0x1(%eax),%edx
    1dbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1dbe:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1dc0:	8b 45 08             	mov    0x8(%ebp),%eax
    1dc3:	8b 00                	mov    (%eax),%eax
    1dc5:	85 c0                	test   %eax,%eax
    1dc7:	75 14                	jne    1ddd <pop_q+0x6d>
            q->head = 0;
    1dc9:	8b 45 08             	mov    0x8(%ebp),%eax
    1dcc:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1dd3:	8b 45 08             	mov    0x8(%ebp),%eax
    1dd6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1ddd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1de0:	eb 05                	jmp    1de7 <pop_q+0x77>
    }
    return -1;
    1de2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1de7:	c9                   	leave  
    1de8:	c3                   	ret    
    1de9:	90                   	nop
    1dea:	90                   	nop
    1deb:	90                   	nop

00001dec <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1dec:	55                   	push   %ebp
    1ded:	89 e5                	mov    %esp,%ebp
    1def:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1df2:	8b 45 08             	mov    0x8(%ebp),%eax
    1df5:	89 04 24             	mov    %eax,(%esp)
    1df8:	e8 a3 fd ff ff       	call   1ba0 <lock_acquire>
	s->count--; 
    1dfd:	8b 45 08             	mov    0x8(%ebp),%eax
    1e00:	8b 40 04             	mov    0x4(%eax),%eax
    1e03:	8d 50 ff             	lea    -0x1(%eax),%edx
    1e06:	8b 45 08             	mov    0x8(%ebp),%eax
    1e09:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1e0c:	8b 45 08             	mov    0x8(%ebp),%eax
    1e0f:	8b 40 04             	mov    0x4(%eax),%eax
    1e12:	85 c0                	test   %eax,%eax
    1e14:	79 27                	jns    1e3d <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1e16:	e8 75 f8 ff ff       	call   1690 <getpid>
    1e1b:	8b 55 08             	mov    0x8(%ebp),%edx
    1e1e:	83 c2 08             	add    $0x8,%edx
    1e21:	89 44 24 04          	mov    %eax,0x4(%esp)
    1e25:	89 14 24             	mov    %edx,(%esp)
    1e28:	e8 c9 fe ff ff       	call   1cf6 <add_q>
		lock_release(&s->lock); 
    1e2d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e30:	89 04 24             	mov    %eax,(%esp)
    1e33:	e8 87 fd ff ff       	call   1bbf <lock_release>
		tsleep(); 
    1e38:	e8 83 f8 ff ff       	call   16c0 <tsleep>
	} 
	lock_release(&s->lock); 
    1e3d:	8b 45 08             	mov    0x8(%ebp),%eax
    1e40:	89 04 24             	mov    %eax,(%esp)
    1e43:	e8 77 fd ff ff       	call   1bbf <lock_release>
}
    1e48:	c9                   	leave  
    1e49:	c3                   	ret    

00001e4a <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1e4a:	55                   	push   %ebp
    1e4b:	89 e5                	mov    %esp,%ebp
    1e4d:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1e50:	8b 45 08             	mov    0x8(%ebp),%eax
    1e53:	89 04 24             	mov    %eax,(%esp)
    1e56:	e8 45 fd ff ff       	call   1ba0 <lock_acquire>
	s->count++; 
    1e5b:	8b 45 08             	mov    0x8(%ebp),%eax
    1e5e:	8b 40 04             	mov    0x4(%eax),%eax
    1e61:	8d 50 01             	lea    0x1(%eax),%edx
    1e64:	8b 45 08             	mov    0x8(%ebp),%eax
    1e67:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1e6a:	8b 45 08             	mov    0x8(%ebp),%eax
    1e6d:	8b 40 04             	mov    0x4(%eax),%eax
    1e70:	85 c0                	test   %eax,%eax
    1e72:	7f 1c                	jg     1e90 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1e74:	8b 45 08             	mov    0x8(%ebp),%eax
    1e77:	83 c0 08             	add    $0x8,%eax
    1e7a:	89 04 24             	mov    %eax,(%esp)
    1e7d:	e8 ee fe ff ff       	call   1d70 <pop_q>
    1e82:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1e85:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e88:	89 04 24             	mov    %eax,(%esp)
    1e8b:	e8 38 f8 ff ff       	call   16c8 <twakeup>
	}
	lock_release(&s->lock); 
    1e90:	8b 45 08             	mov    0x8(%ebp),%eax
    1e93:	89 04 24             	mov    %eax,(%esp)
    1e96:	e8 24 fd ff ff       	call   1bbf <lock_release>
} 
    1e9b:	c9                   	leave  
    1e9c:	c3                   	ret    

00001e9d <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1e9d:	55                   	push   %ebp
    1e9e:	89 e5                	mov    %esp,%ebp
    1ea0:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1ea3:	8b 45 08             	mov    0x8(%ebp),%eax
    1ea6:	89 04 24             	mov    %eax,(%esp)
    1ea9:	e8 e4 fc ff ff       	call   1b92 <lock_init>
	s->count = size; 
    1eae:	8b 45 08             	mov    0x8(%ebp),%eax
    1eb1:	8b 55 0c             	mov    0xc(%ebp),%edx
    1eb4:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1eb7:	8b 45 08             	mov    0x8(%ebp),%eax
    1eba:	83 c0 08             	add    $0x8,%eax
    1ebd:	89 04 24             	mov    %eax,(%esp)
    1ec0:	e8 0f fe ff ff       	call   1cd4 <init_q>
}
    1ec5:	c9                   	leave  
    1ec6:	c3                   	ret    
