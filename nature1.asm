
_nature1:     file format elf32-i386


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
    1006:	83 ec 20             	sub    $0x20,%esp
	lock_acquire(&mutex.lock); 	
    1009:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    1010:	e8 93 09 00 00       	call   19a8 <lock_acquire>
	printf(1,"Hydrogen count should be 0, and oxygen count should be 1, therefore water should be 0, or infinite loop. \n"); 
    1015:	c7 44 24 04 d0 1c 00 	movl   $0x1cd0,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 90 05 00 00       	call   15b9 <printf>
	lock_release(&mutex.lock); 	
    1029:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    1030:	e8 92 09 00 00       	call   19c7 <lock_release>

	sem_init(&h, 0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 28 1e 00 00 	movl   $0x1e28,(%esp)
    1044:	e8 5c 0c 00 00       	call   1ca5 <sem_init>
	sem_init(&o, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
    1058:	e8 48 0c 00 00       	call   1ca5 <sem_init>
	
	void *oid = thread_create(oReady,(void *)0); 
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 8f 10 00 00 	movl   $0x108f,(%esp)
    106c:	e8 71 09 00 00       	call   19e2 <thread_create>
    1071:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(oid == 0) exit(); 
    1075:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 97 03 00 00       	call   1418 <exit>
 
	while(wait() > 0);
    1081:	e8 9a 03 00 00       	call   1420 <wait>
    1086:	85 c0                	test   %eax,%eax
    1088:	7f f7                	jg     1081 <main+0x81>

	exit(); 
    108a:	e8 89 03 00 00       	call   1418 <exit>

0000108f <oReady>:
	return 0;
}

void oReady(void *arg) {
    108f:	55                   	push   %ebp
    1090:	89 e5                	mov    %esp,%ebp
    1092:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1095:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    109c:	e8 07 09 00 00       	call   19a8 <lock_acquire>
	oxygen++; 
    10a1:	a1 00 1e 00 00       	mov    0x1e00,%eax
    10a6:	83 c0 01             	add    $0x1,%eax
    10a9:	a3 00 1e 00 00       	mov    %eax,0x1e00
	printf(1,"created one oxygen. Oxygen count: %d.\n",oxygen);  
    10ae:	a1 00 1e 00 00       	mov    0x1e00,%eax
    10b3:	89 44 24 08          	mov    %eax,0x8(%esp)
    10b7:	c7 44 24 04 3c 1d 00 	movl   $0x1d3c,0x4(%esp)
    10be:	00 
    10bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10c6:	e8 ee 04 00 00       	call   15b9 <printf>
	lock_release(&mutex.lock);
    10cb:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    10d2:	e8 f0 08 00 00       	call   19c7 <lock_release>
	sem_acquire(&h); 
    10d7:	c7 04 24 28 1e 00 00 	movl   $0x1e28,(%esp)
    10de:	e8 11 0b 00 00       	call   1bf4 <sem_acquire>
	sem_acquire(&h);
    10e3:	c7 04 24 28 1e 00 00 	movl   $0x1e28,(%esp)
    10ea:	e8 05 0b 00 00       	call   1bf4 <sem_acquire>
	sem_signal(&o);
    10ef:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
    10f6:	e8 57 0b 00 00       	call   1c52 <sem_signal>
	sem_signal(&o); 
    10fb:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
    1102:	e8 4b 0b 00 00       	call   1c52 <sem_signal>
	lock_acquire(&mutex.lock);
    1107:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    110e:	e8 95 08 00 00       	call   19a8 <lock_acquire>
	water_molecule++;
    1113:	a1 f8 1d 00 00       	mov    0x1df8,%eax
    1118:	83 c0 01             	add    $0x1,%eax
    111b:	a3 f8 1d 00 00       	mov    %eax,0x1df8
 	printf(1,"created water molecule: %d.\n",water_molecule); 	
    1120:	a1 f8 1d 00 00       	mov    0x1df8,%eax
    1125:	89 44 24 08          	mov    %eax,0x8(%esp)
    1129:	c7 44 24 04 63 1d 00 	movl   $0x1d63,0x4(%esp)
    1130:	00 
    1131:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1138:	e8 7c 04 00 00       	call   15b9 <printf>
	lock_release(&mutex.lock); 	 
    113d:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    1144:	e8 7e 08 00 00       	call   19c7 <lock_release>

	texit(); 	
    1149:	e8 72 03 00 00       	call   14c0 <texit>

0000114e <hReady>:
}

void hReady(void *arg) { 
    114e:	55                   	push   %ebp
    114f:	89 e5                	mov    %esp,%ebp
    1151:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&mutex.lock); 
    1154:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    115b:	e8 48 08 00 00       	call   19a8 <lock_acquire>
	hydrogen++; 
    1160:	a1 fc 1d 00 00       	mov    0x1dfc,%eax
    1165:	83 c0 01             	add    $0x1,%eax
    1168:	a3 fc 1d 00 00       	mov    %eax,0x1dfc
	printf(1,"created one hydrogen. Hydrogen count: %d.\n",hydrogen); 	
    116d:	a1 fc 1d 00 00       	mov    0x1dfc,%eax
    1172:	89 44 24 08          	mov    %eax,0x8(%esp)
    1176:	c7 44 24 04 80 1d 00 	movl   $0x1d80,0x4(%esp)
    117d:	00 
    117e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1185:	e8 2f 04 00 00       	call   15b9 <printf>
	lock_release(&mutex.lock); 
    118a:	c7 04 24 24 1e 00 00 	movl   $0x1e24,(%esp)
    1191:	e8 31 08 00 00       	call   19c7 <lock_release>
	sem_signal(&h);
    1196:	c7 04 24 28 1e 00 00 	movl   $0x1e28,(%esp)
    119d:	e8 b0 0a 00 00       	call   1c52 <sem_signal>
	sem_acquire(&o);	
    11a2:	c7 04 24 10 1e 00 00 	movl   $0x1e10,(%esp)
    11a9:	e8 46 0a 00 00       	call   1bf4 <sem_acquire>

	texit();  
    11ae:	e8 0d 03 00 00       	call   14c0 <texit>
    11b3:	90                   	nop

000011b4 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11b4:	55                   	push   %ebp
    11b5:	89 e5                	mov    %esp,%ebp
    11b7:	57                   	push   %edi
    11b8:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11bc:	8b 55 10             	mov    0x10(%ebp),%edx
    11bf:	8b 45 0c             	mov    0xc(%ebp),%eax
    11c2:	89 cb                	mov    %ecx,%ebx
    11c4:	89 df                	mov    %ebx,%edi
    11c6:	89 d1                	mov    %edx,%ecx
    11c8:	fc                   	cld    
    11c9:	f3 aa                	rep stos %al,%es:(%edi)
    11cb:	89 ca                	mov    %ecx,%edx
    11cd:	89 fb                	mov    %edi,%ebx
    11cf:	89 5d 08             	mov    %ebx,0x8(%ebp)
    11d2:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    11d5:	5b                   	pop    %ebx
    11d6:	5f                   	pop    %edi
    11d7:	5d                   	pop    %ebp
    11d8:	c3                   	ret    

000011d9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    11d9:	55                   	push   %ebp
    11da:	89 e5                	mov    %esp,%ebp
    11dc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    11df:	8b 45 08             	mov    0x8(%ebp),%eax
    11e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    11e5:	8b 45 0c             	mov    0xc(%ebp),%eax
    11e8:	0f b6 10             	movzbl (%eax),%edx
    11eb:	8b 45 08             	mov    0x8(%ebp),%eax
    11ee:	88 10                	mov    %dl,(%eax)
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	0f b6 00             	movzbl (%eax),%eax
    11f6:	84 c0                	test   %al,%al
    11f8:	0f 95 c0             	setne  %al
    11fb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    11ff:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1203:	84 c0                	test   %al,%al
    1205:	75 de                	jne    11e5 <strcpy+0xc>
    ;
  return os;
    1207:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    120a:	c9                   	leave  
    120b:	c3                   	ret    

0000120c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    120c:	55                   	push   %ebp
    120d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    120f:	eb 08                	jmp    1219 <strcmp+0xd>
    p++, q++;
    1211:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1215:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1219:	8b 45 08             	mov    0x8(%ebp),%eax
    121c:	0f b6 00             	movzbl (%eax),%eax
    121f:	84 c0                	test   %al,%al
    1221:	74 10                	je     1233 <strcmp+0x27>
    1223:	8b 45 08             	mov    0x8(%ebp),%eax
    1226:	0f b6 10             	movzbl (%eax),%edx
    1229:	8b 45 0c             	mov    0xc(%ebp),%eax
    122c:	0f b6 00             	movzbl (%eax),%eax
    122f:	38 c2                	cmp    %al,%dl
    1231:	74 de                	je     1211 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	0f b6 00             	movzbl (%eax),%eax
    1239:	0f b6 d0             	movzbl %al,%edx
    123c:	8b 45 0c             	mov    0xc(%ebp),%eax
    123f:	0f b6 00             	movzbl (%eax),%eax
    1242:	0f b6 c0             	movzbl %al,%eax
    1245:	89 d1                	mov    %edx,%ecx
    1247:	29 c1                	sub    %eax,%ecx
    1249:	89 c8                	mov    %ecx,%eax
}
    124b:	5d                   	pop    %ebp
    124c:	c3                   	ret    

0000124d <strlen>:

uint
strlen(char *s)
{
    124d:	55                   	push   %ebp
    124e:	89 e5                	mov    %esp,%ebp
    1250:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1253:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    125a:	eb 04                	jmp    1260 <strlen+0x13>
    125c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1260:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1263:	03 45 08             	add    0x8(%ebp),%eax
    1266:	0f b6 00             	movzbl (%eax),%eax
    1269:	84 c0                	test   %al,%al
    126b:	75 ef                	jne    125c <strlen+0xf>
    ;
  return n;
    126d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1270:	c9                   	leave  
    1271:	c3                   	ret    

00001272 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1272:	55                   	push   %ebp
    1273:	89 e5                	mov    %esp,%ebp
    1275:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    1278:	8b 45 10             	mov    0x10(%ebp),%eax
    127b:	89 44 24 08          	mov    %eax,0x8(%esp)
    127f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1282:	89 44 24 04          	mov    %eax,0x4(%esp)
    1286:	8b 45 08             	mov    0x8(%ebp),%eax
    1289:	89 04 24             	mov    %eax,(%esp)
    128c:	e8 23 ff ff ff       	call   11b4 <stosb>
  return dst;
    1291:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1294:	c9                   	leave  
    1295:	c3                   	ret    

00001296 <strchr>:

char*
strchr(const char *s, char c)
{
    1296:	55                   	push   %ebp
    1297:	89 e5                	mov    %esp,%ebp
    1299:	83 ec 04             	sub    $0x4,%esp
    129c:	8b 45 0c             	mov    0xc(%ebp),%eax
    129f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12a2:	eb 14                	jmp    12b8 <strchr+0x22>
    if(*s == c)
    12a4:	8b 45 08             	mov    0x8(%ebp),%eax
    12a7:	0f b6 00             	movzbl (%eax),%eax
    12aa:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12ad:	75 05                	jne    12b4 <strchr+0x1e>
      return (char*)s;
    12af:	8b 45 08             	mov    0x8(%ebp),%eax
    12b2:	eb 13                	jmp    12c7 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12b4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12b8:	8b 45 08             	mov    0x8(%ebp),%eax
    12bb:	0f b6 00             	movzbl (%eax),%eax
    12be:	84 c0                	test   %al,%al
    12c0:	75 e2                	jne    12a4 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12c7:	c9                   	leave  
    12c8:	c3                   	ret    

000012c9 <gets>:

char*
gets(char *buf, int max)
{
    12c9:	55                   	push   %ebp
    12ca:	89 e5                	mov    %esp,%ebp
    12cc:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    12cf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12d6:	eb 44                	jmp    131c <gets+0x53>
    cc = read(0, &c, 1);
    12d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    12df:	00 
    12e0:	8d 45 ef             	lea    -0x11(%ebp),%eax
    12e3:	89 44 24 04          	mov    %eax,0x4(%esp)
    12e7:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    12ee:	e8 3d 01 00 00       	call   1430 <read>
    12f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    12f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12fa:	7e 2d                	jle    1329 <gets+0x60>
      break;
    buf[i++] = c;
    12fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12ff:	03 45 08             	add    0x8(%ebp),%eax
    1302:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1306:	88 10                	mov    %dl,(%eax)
    1308:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    130c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1310:	3c 0a                	cmp    $0xa,%al
    1312:	74 16                	je     132a <gets+0x61>
    1314:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1318:	3c 0d                	cmp    $0xd,%al
    131a:	74 0e                	je     132a <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    131c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    131f:	83 c0 01             	add    $0x1,%eax
    1322:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1325:	7c b1                	jl     12d8 <gets+0xf>
    1327:	eb 01                	jmp    132a <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1329:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    132a:	8b 45 f0             	mov    -0x10(%ebp),%eax
    132d:	03 45 08             	add    0x8(%ebp),%eax
    1330:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1333:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1336:	c9                   	leave  
    1337:	c3                   	ret    

00001338 <stat>:

int
stat(char *n, struct stat *st)
{
    1338:	55                   	push   %ebp
    1339:	89 e5                	mov    %esp,%ebp
    133b:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    133e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1345:	00 
    1346:	8b 45 08             	mov    0x8(%ebp),%eax
    1349:	89 04 24             	mov    %eax,(%esp)
    134c:	e8 07 01 00 00       	call   1458 <open>
    1351:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1354:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1358:	79 07                	jns    1361 <stat+0x29>
    return -1;
    135a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    135f:	eb 23                	jmp    1384 <stat+0x4c>
  r = fstat(fd, st);
    1361:	8b 45 0c             	mov    0xc(%ebp),%eax
    1364:	89 44 24 04          	mov    %eax,0x4(%esp)
    1368:	8b 45 f0             	mov    -0x10(%ebp),%eax
    136b:	89 04 24             	mov    %eax,(%esp)
    136e:	e8 fd 00 00 00       	call   1470 <fstat>
    1373:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    1376:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1379:	89 04 24             	mov    %eax,(%esp)
    137c:	e8 bf 00 00 00       	call   1440 <close>
  return r;
    1381:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    1384:	c9                   	leave  
    1385:	c3                   	ret    

00001386 <atoi>:

int
atoi(const char *s)
{
    1386:	55                   	push   %ebp
    1387:	89 e5                	mov    %esp,%ebp
    1389:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    138c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    1393:	eb 24                	jmp    13b9 <atoi+0x33>
    n = n*10 + *s++ - '0';
    1395:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1398:	89 d0                	mov    %edx,%eax
    139a:	c1 e0 02             	shl    $0x2,%eax
    139d:	01 d0                	add    %edx,%eax
    139f:	01 c0                	add    %eax,%eax
    13a1:	89 c2                	mov    %eax,%edx
    13a3:	8b 45 08             	mov    0x8(%ebp),%eax
    13a6:	0f b6 00             	movzbl (%eax),%eax
    13a9:	0f be c0             	movsbl %al,%eax
    13ac:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13af:	83 e8 30             	sub    $0x30,%eax
    13b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13b5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13b9:	8b 45 08             	mov    0x8(%ebp),%eax
    13bc:	0f b6 00             	movzbl (%eax),%eax
    13bf:	3c 2f                	cmp    $0x2f,%al
    13c1:	7e 0a                	jle    13cd <atoi+0x47>
    13c3:	8b 45 08             	mov    0x8(%ebp),%eax
    13c6:	0f b6 00             	movzbl (%eax),%eax
    13c9:	3c 39                	cmp    $0x39,%al
    13cb:	7e c8                	jle    1395 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    13cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    13d0:	c9                   	leave  
    13d1:	c3                   	ret    

000013d2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    13d2:	55                   	push   %ebp
    13d3:	89 e5                	mov    %esp,%ebp
    13d5:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    13d8:	8b 45 08             	mov    0x8(%ebp),%eax
    13db:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    13de:	8b 45 0c             	mov    0xc(%ebp),%eax
    13e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    13e4:	eb 13                	jmp    13f9 <memmove+0x27>
    *dst++ = *src++;
    13e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    13e9:	0f b6 10             	movzbl (%eax),%edx
    13ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
    13ef:	88 10                	mov    %dl,(%eax)
    13f1:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    13f5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    13f9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    13fd:	0f 9f c0             	setg   %al
    1400:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1404:	84 c0                	test   %al,%al
    1406:	75 de                	jne    13e6 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1408:	8b 45 08             	mov    0x8(%ebp),%eax
}
    140b:	c9                   	leave  
    140c:	c3                   	ret    
    140d:	90                   	nop
    140e:	90                   	nop
    140f:	90                   	nop

00001410 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1410:	b8 01 00 00 00       	mov    $0x1,%eax
    1415:	cd 40                	int    $0x40
    1417:	c3                   	ret    

00001418 <exit>:
SYSCALL(exit)
    1418:	b8 02 00 00 00       	mov    $0x2,%eax
    141d:	cd 40                	int    $0x40
    141f:	c3                   	ret    

00001420 <wait>:
SYSCALL(wait)
    1420:	b8 03 00 00 00       	mov    $0x3,%eax
    1425:	cd 40                	int    $0x40
    1427:	c3                   	ret    

00001428 <pipe>:
SYSCALL(pipe)
    1428:	b8 04 00 00 00       	mov    $0x4,%eax
    142d:	cd 40                	int    $0x40
    142f:	c3                   	ret    

00001430 <read>:
SYSCALL(read)
    1430:	b8 05 00 00 00       	mov    $0x5,%eax
    1435:	cd 40                	int    $0x40
    1437:	c3                   	ret    

00001438 <write>:
SYSCALL(write)
    1438:	b8 10 00 00 00       	mov    $0x10,%eax
    143d:	cd 40                	int    $0x40
    143f:	c3                   	ret    

00001440 <close>:
SYSCALL(close)
    1440:	b8 15 00 00 00       	mov    $0x15,%eax
    1445:	cd 40                	int    $0x40
    1447:	c3                   	ret    

00001448 <kill>:
SYSCALL(kill)
    1448:	b8 06 00 00 00       	mov    $0x6,%eax
    144d:	cd 40                	int    $0x40
    144f:	c3                   	ret    

00001450 <exec>:
SYSCALL(exec)
    1450:	b8 07 00 00 00       	mov    $0x7,%eax
    1455:	cd 40                	int    $0x40
    1457:	c3                   	ret    

00001458 <open>:
SYSCALL(open)
    1458:	b8 0f 00 00 00       	mov    $0xf,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <mknod>:
SYSCALL(mknod)
    1460:	b8 11 00 00 00       	mov    $0x11,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <unlink>:
SYSCALL(unlink)
    1468:	b8 12 00 00 00       	mov    $0x12,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <fstat>:
SYSCALL(fstat)
    1470:	b8 08 00 00 00       	mov    $0x8,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <link>:
SYSCALL(link)
    1478:	b8 13 00 00 00       	mov    $0x13,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <mkdir>:
SYSCALL(mkdir)
    1480:	b8 14 00 00 00       	mov    $0x14,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <chdir>:
SYSCALL(chdir)
    1488:	b8 09 00 00 00       	mov    $0x9,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <dup>:
SYSCALL(dup)
    1490:	b8 0a 00 00 00       	mov    $0xa,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    

00001498 <getpid>:
SYSCALL(getpid)
    1498:	b8 0b 00 00 00       	mov    $0xb,%eax
    149d:	cd 40                	int    $0x40
    149f:	c3                   	ret    

000014a0 <sbrk>:
SYSCALL(sbrk)
    14a0:	b8 0c 00 00 00       	mov    $0xc,%eax
    14a5:	cd 40                	int    $0x40
    14a7:	c3                   	ret    

000014a8 <sleep>:
SYSCALL(sleep)
    14a8:	b8 0d 00 00 00       	mov    $0xd,%eax
    14ad:	cd 40                	int    $0x40
    14af:	c3                   	ret    

000014b0 <uptime>:
SYSCALL(uptime)
    14b0:	b8 0e 00 00 00       	mov    $0xe,%eax
    14b5:	cd 40                	int    $0x40
    14b7:	c3                   	ret    

000014b8 <clone>:
SYSCALL(clone)
    14b8:	b8 16 00 00 00       	mov    $0x16,%eax
    14bd:	cd 40                	int    $0x40
    14bf:	c3                   	ret    

000014c0 <texit>:
SYSCALL(texit)
    14c0:	b8 17 00 00 00       	mov    $0x17,%eax
    14c5:	cd 40                	int    $0x40
    14c7:	c3                   	ret    

000014c8 <tsleep>:
SYSCALL(tsleep)
    14c8:	b8 18 00 00 00       	mov    $0x18,%eax
    14cd:	cd 40                	int    $0x40
    14cf:	c3                   	ret    

000014d0 <twakeup>:
SYSCALL(twakeup)
    14d0:	b8 19 00 00 00       	mov    $0x19,%eax
    14d5:	cd 40                	int    $0x40
    14d7:	c3                   	ret    

000014d8 <thread_yield>:
SYSCALL(thread_yield) 
    14d8:	b8 1a 00 00 00       	mov    $0x1a,%eax
    14dd:	cd 40                	int    $0x40
    14df:	c3                   	ret    

000014e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    14e0:	55                   	push   %ebp
    14e1:	89 e5                	mov    %esp,%ebp
    14e3:	83 ec 28             	sub    $0x28,%esp
    14e6:	8b 45 0c             	mov    0xc(%ebp),%eax
    14e9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    14ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    14f3:	00 
    14f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
    14f7:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fb:	8b 45 08             	mov    0x8(%ebp),%eax
    14fe:	89 04 24             	mov    %eax,(%esp)
    1501:	e8 32 ff ff ff       	call   1438 <write>
}
    1506:	c9                   	leave  
    1507:	c3                   	ret    

00001508 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1508:	55                   	push   %ebp
    1509:	89 e5                	mov    %esp,%ebp
    150b:	53                   	push   %ebx
    150c:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    150f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1516:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    151a:	74 17                	je     1533 <printint+0x2b>
    151c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1520:	79 11                	jns    1533 <printint+0x2b>
    neg = 1;
    1522:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1529:	8b 45 0c             	mov    0xc(%ebp),%eax
    152c:	f7 d8                	neg    %eax
    152e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1531:	eb 06                	jmp    1539 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1533:	8b 45 0c             	mov    0xc(%ebp),%eax
    1536:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1539:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1540:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1543:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1549:	ba 00 00 00 00       	mov    $0x0,%edx
    154e:	f7 f3                	div    %ebx
    1550:	89 d0                	mov    %edx,%eax
    1552:	0f b6 80 e0 1d 00 00 	movzbl 0x1de0(%eax),%eax
    1559:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    155d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1561:	8b 45 10             	mov    0x10(%ebp),%eax
    1564:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1567:	8b 45 f4             	mov    -0xc(%ebp),%eax
    156a:	ba 00 00 00 00       	mov    $0x0,%edx
    156f:	f7 75 d4             	divl   -0x2c(%ebp)
    1572:	89 45 f4             	mov    %eax,-0xc(%ebp)
    1575:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1579:	75 c5                	jne    1540 <printint+0x38>
  if(neg)
    157b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    157f:	74 28                	je     15a9 <printint+0xa1>
    buf[i++] = '-';
    1581:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1584:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1589:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    158d:	eb 1a                	jmp    15a9 <printint+0xa1>
    putc(fd, buf[i]);
    158f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1592:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    1597:	0f be c0             	movsbl %al,%eax
    159a:	89 44 24 04          	mov    %eax,0x4(%esp)
    159e:	8b 45 08             	mov    0x8(%ebp),%eax
    15a1:	89 04 24             	mov    %eax,(%esp)
    15a4:	e8 37 ff ff ff       	call   14e0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15a9:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    15ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15b1:	79 dc                	jns    158f <printint+0x87>
    putc(fd, buf[i]);
}
    15b3:	83 c4 44             	add    $0x44,%esp
    15b6:	5b                   	pop    %ebx
    15b7:	5d                   	pop    %ebp
    15b8:	c3                   	ret    

000015b9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15b9:	55                   	push   %ebp
    15ba:	89 e5                	mov    %esp,%ebp
    15bc:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15c6:	8d 45 0c             	lea    0xc(%ebp),%eax
    15c9:	83 c0 04             	add    $0x4,%eax
    15cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    15cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    15d6:	e9 7e 01 00 00       	jmp    1759 <printf+0x1a0>
    c = fmt[i] & 0xff;
    15db:	8b 55 0c             	mov    0xc(%ebp),%edx
    15de:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15e1:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15e4:	0f b6 00             	movzbl (%eax),%eax
    15e7:	0f be c0             	movsbl %al,%eax
    15ea:	25 ff 00 00 00       	and    $0xff,%eax
    15ef:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    15f2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15f6:	75 2c                	jne    1624 <printf+0x6b>
      if(c == '%'){
    15f8:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    15fc:	75 0c                	jne    160a <printf+0x51>
        state = '%';
    15fe:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1605:	e9 4b 01 00 00       	jmp    1755 <printf+0x19c>
      } else {
        putc(fd, c);
    160a:	8b 45 e8             	mov    -0x18(%ebp),%eax
    160d:	0f be c0             	movsbl %al,%eax
    1610:	89 44 24 04          	mov    %eax,0x4(%esp)
    1614:	8b 45 08             	mov    0x8(%ebp),%eax
    1617:	89 04 24             	mov    %eax,(%esp)
    161a:	e8 c1 fe ff ff       	call   14e0 <putc>
    161f:	e9 31 01 00 00       	jmp    1755 <printf+0x19c>
      }
    } else if(state == '%'){
    1624:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1628:	0f 85 27 01 00 00    	jne    1755 <printf+0x19c>
      if(c == 'd'){
    162e:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1632:	75 2d                	jne    1661 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1634:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1637:	8b 00                	mov    (%eax),%eax
    1639:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1640:	00 
    1641:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1648:	00 
    1649:	89 44 24 04          	mov    %eax,0x4(%esp)
    164d:	8b 45 08             	mov    0x8(%ebp),%eax
    1650:	89 04 24             	mov    %eax,(%esp)
    1653:	e8 b0 fe ff ff       	call   1508 <printint>
        ap++;
    1658:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    165c:	e9 ed 00 00 00       	jmp    174e <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1661:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1665:	74 06                	je     166d <printf+0xb4>
    1667:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    166b:	75 2d                	jne    169a <printf+0xe1>
        printint(fd, *ap, 16, 0);
    166d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1670:	8b 00                	mov    (%eax),%eax
    1672:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    1679:	00 
    167a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    1681:	00 
    1682:	89 44 24 04          	mov    %eax,0x4(%esp)
    1686:	8b 45 08             	mov    0x8(%ebp),%eax
    1689:	89 04 24             	mov    %eax,(%esp)
    168c:	e8 77 fe ff ff       	call   1508 <printint>
        ap++;
    1691:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1695:	e9 b4 00 00 00       	jmp    174e <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    169a:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    169e:	75 46                	jne    16e6 <printf+0x12d>
        s = (char*)*ap;
    16a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a3:	8b 00                	mov    (%eax),%eax
    16a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    16a8:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    16ac:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    16b0:	75 27                	jne    16d9 <printf+0x120>
          s = "(null)";
    16b2:	c7 45 e4 ab 1d 00 00 	movl   $0x1dab,-0x1c(%ebp)
        while(*s != 0){
    16b9:	eb 1f                	jmp    16da <printf+0x121>
          putc(fd, *s);
    16bb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16be:	0f b6 00             	movzbl (%eax),%eax
    16c1:	0f be c0             	movsbl %al,%eax
    16c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16c8:	8b 45 08             	mov    0x8(%ebp),%eax
    16cb:	89 04 24             	mov    %eax,(%esp)
    16ce:	e8 0d fe ff ff       	call   14e0 <putc>
          s++;
    16d3:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    16d7:	eb 01                	jmp    16da <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    16d9:	90                   	nop
    16da:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16dd:	0f b6 00             	movzbl (%eax),%eax
    16e0:	84 c0                	test   %al,%al
    16e2:	75 d7                	jne    16bb <printf+0x102>
    16e4:	eb 68                	jmp    174e <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    16e6:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    16ea:	75 1d                	jne    1709 <printf+0x150>
        putc(fd, *ap);
    16ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16ef:	8b 00                	mov    (%eax),%eax
    16f1:	0f be c0             	movsbl %al,%eax
    16f4:	89 44 24 04          	mov    %eax,0x4(%esp)
    16f8:	8b 45 08             	mov    0x8(%ebp),%eax
    16fb:	89 04 24             	mov    %eax,(%esp)
    16fe:	e8 dd fd ff ff       	call   14e0 <putc>
        ap++;
    1703:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1707:	eb 45                	jmp    174e <printf+0x195>
      } else if(c == '%'){
    1709:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    170d:	75 17                	jne    1726 <printf+0x16d>
        putc(fd, c);
    170f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1712:	0f be c0             	movsbl %al,%eax
    1715:	89 44 24 04          	mov    %eax,0x4(%esp)
    1719:	8b 45 08             	mov    0x8(%ebp),%eax
    171c:	89 04 24             	mov    %eax,(%esp)
    171f:	e8 bc fd ff ff       	call   14e0 <putc>
    1724:	eb 28                	jmp    174e <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1726:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    172d:	00 
    172e:	8b 45 08             	mov    0x8(%ebp),%eax
    1731:	89 04 24             	mov    %eax,(%esp)
    1734:	e8 a7 fd ff ff       	call   14e0 <putc>
        putc(fd, c);
    1739:	8b 45 e8             	mov    -0x18(%ebp),%eax
    173c:	0f be c0             	movsbl %al,%eax
    173f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1743:	8b 45 08             	mov    0x8(%ebp),%eax
    1746:	89 04 24             	mov    %eax,(%esp)
    1749:	e8 92 fd ff ff       	call   14e0 <putc>
      }
      state = 0;
    174e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1755:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    1759:	8b 55 0c             	mov    0xc(%ebp),%edx
    175c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    175f:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1762:	0f b6 00             	movzbl (%eax),%eax
    1765:	84 c0                	test   %al,%al
    1767:	0f 85 6e fe ff ff    	jne    15db <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    176d:	c9                   	leave  
    176e:	c3                   	ret    
    176f:	90                   	nop

00001770 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1770:	55                   	push   %ebp
    1771:	89 e5                	mov    %esp,%ebp
    1773:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	83 e8 08             	sub    $0x8,%eax
    177c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    177f:	a1 0c 1e 00 00       	mov    0x1e0c,%eax
    1784:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1787:	eb 24                	jmp    17ad <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1789:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178c:	8b 00                	mov    (%eax),%eax
    178e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1791:	77 12                	ja     17a5 <free+0x35>
    1793:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1796:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1799:	77 24                	ja     17bf <free+0x4f>
    179b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    179e:	8b 00                	mov    (%eax),%eax
    17a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17a3:	77 1a                	ja     17bf <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17a8:	8b 00                	mov    (%eax),%eax
    17aa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17b0:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17b3:	76 d4                	jbe    1789 <free+0x19>
    17b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17b8:	8b 00                	mov    (%eax),%eax
    17ba:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17bd:	76 ca                	jbe    1789 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    17bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17c2:	8b 40 04             	mov    0x4(%eax),%eax
    17c5:	c1 e0 03             	shl    $0x3,%eax
    17c8:	89 c2                	mov    %eax,%edx
    17ca:	03 55 f8             	add    -0x8(%ebp),%edx
    17cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d0:	8b 00                	mov    (%eax),%eax
    17d2:	39 c2                	cmp    %eax,%edx
    17d4:	75 24                	jne    17fa <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    17d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17d9:	8b 50 04             	mov    0x4(%eax),%edx
    17dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17df:	8b 00                	mov    (%eax),%eax
    17e1:	8b 40 04             	mov    0x4(%eax),%eax
    17e4:	01 c2                	add    %eax,%edx
    17e6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    17ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ef:	8b 00                	mov    (%eax),%eax
    17f1:	8b 10                	mov    (%eax),%edx
    17f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f6:	89 10                	mov    %edx,(%eax)
    17f8:	eb 0a                	jmp    1804 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    17fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17fd:	8b 10                	mov    (%eax),%edx
    17ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1802:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1804:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1807:	8b 40 04             	mov    0x4(%eax),%eax
    180a:	c1 e0 03             	shl    $0x3,%eax
    180d:	03 45 fc             	add    -0x4(%ebp),%eax
    1810:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1813:	75 20                	jne    1835 <free+0xc5>
    p->s.size += bp->s.size;
    1815:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1818:	8b 50 04             	mov    0x4(%eax),%edx
    181b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181e:	8b 40 04             	mov    0x4(%eax),%eax
    1821:	01 c2                	add    %eax,%edx
    1823:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1826:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1829:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182c:	8b 10                	mov    (%eax),%edx
    182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1831:	89 10                	mov    %edx,(%eax)
    1833:	eb 08                	jmp    183d <free+0xcd>
  } else
    p->s.ptr = bp;
    1835:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1838:	8b 55 f8             	mov    -0x8(%ebp),%edx
    183b:	89 10                	mov    %edx,(%eax)
  freep = p;
    183d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1840:	a3 0c 1e 00 00       	mov    %eax,0x1e0c
}
    1845:	c9                   	leave  
    1846:	c3                   	ret    

00001847 <morecore>:

static Header*
morecore(uint nu)
{
    1847:	55                   	push   %ebp
    1848:	89 e5                	mov    %esp,%ebp
    184a:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    184d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1854:	77 07                	ja     185d <morecore+0x16>
    nu = 4096;
    1856:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    185d:	8b 45 08             	mov    0x8(%ebp),%eax
    1860:	c1 e0 03             	shl    $0x3,%eax
    1863:	89 04 24             	mov    %eax,(%esp)
    1866:	e8 35 fc ff ff       	call   14a0 <sbrk>
    186b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    186e:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    1872:	75 07                	jne    187b <morecore+0x34>
    return 0;
    1874:	b8 00 00 00 00       	mov    $0x0,%eax
    1879:	eb 22                	jmp    189d <morecore+0x56>
  hp = (Header*)p;
    187b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    187e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    1881:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1884:	8b 55 08             	mov    0x8(%ebp),%edx
    1887:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    188a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    188d:	83 c0 08             	add    $0x8,%eax
    1890:	89 04 24             	mov    %eax,(%esp)
    1893:	e8 d8 fe ff ff       	call   1770 <free>
  return freep;
    1898:	a1 0c 1e 00 00       	mov    0x1e0c,%eax
}
    189d:	c9                   	leave  
    189e:	c3                   	ret    

0000189f <malloc>:

void*
malloc(uint nbytes)
{
    189f:	55                   	push   %ebp
    18a0:	89 e5                	mov    %esp,%ebp
    18a2:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	83 c0 07             	add    $0x7,%eax
    18ab:	c1 e8 03             	shr    $0x3,%eax
    18ae:	83 c0 01             	add    $0x1,%eax
    18b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    18b4:	a1 0c 1e 00 00       	mov    0x1e0c,%eax
    18b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18c0:	75 23                	jne    18e5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    18c2:	c7 45 f0 04 1e 00 00 	movl   $0x1e04,-0x10(%ebp)
    18c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18cc:	a3 0c 1e 00 00       	mov    %eax,0x1e0c
    18d1:	a1 0c 1e 00 00       	mov    0x1e0c,%eax
    18d6:	a3 04 1e 00 00       	mov    %eax,0x1e04
    base.s.size = 0;
    18db:	c7 05 08 1e 00 00 00 	movl   $0x0,0x1e08
    18e2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18e8:	8b 00                	mov    (%eax),%eax
    18ea:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    18ed:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18f0:	8b 40 04             	mov    0x4(%eax),%eax
    18f3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    18f6:	72 4d                	jb     1945 <malloc+0xa6>
      if(p->s.size == nunits)
    18f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18fb:	8b 40 04             	mov    0x4(%eax),%eax
    18fe:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1901:	75 0c                	jne    190f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1903:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1906:	8b 10                	mov    (%eax),%edx
    1908:	8b 45 f0             	mov    -0x10(%ebp),%eax
    190b:	89 10                	mov    %edx,(%eax)
    190d:	eb 26                	jmp    1935 <malloc+0x96>
      else {
        p->s.size -= nunits;
    190f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1912:	8b 40 04             	mov    0x4(%eax),%eax
    1915:	89 c2                	mov    %eax,%edx
    1917:	2b 55 f4             	sub    -0xc(%ebp),%edx
    191a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    191d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1920:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1923:	8b 40 04             	mov    0x4(%eax),%eax
    1926:	c1 e0 03             	shl    $0x3,%eax
    1929:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    192c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192f:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1932:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1935:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1938:	a3 0c 1e 00 00       	mov    %eax,0x1e0c
      return (void*)(p + 1);
    193d:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1940:	83 c0 08             	add    $0x8,%eax
    1943:	eb 38                	jmp    197d <malloc+0xde>
    }
    if(p == freep)
    1945:	a1 0c 1e 00 00       	mov    0x1e0c,%eax
    194a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    194d:	75 1b                	jne    196a <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    194f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1952:	89 04 24             	mov    %eax,(%esp)
    1955:	e8 ed fe ff ff       	call   1847 <morecore>
    195a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    195d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1961:	75 07                	jne    196a <malloc+0xcb>
        return 0;
    1963:	b8 00 00 00 00       	mov    $0x0,%eax
    1968:	eb 13                	jmp    197d <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    196a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    196d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1970:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1973:	8b 00                	mov    (%eax),%eax
    1975:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    1978:	e9 70 ff ff ff       	jmp    18ed <malloc+0x4e>
}
    197d:	c9                   	leave  
    197e:	c3                   	ret    
    197f:	90                   	nop

00001980 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    1980:	55                   	push   %ebp
    1981:	89 e5                	mov    %esp,%ebp
    1983:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    1986:	8b 55 08             	mov    0x8(%ebp),%edx
    1989:	8b 45 0c             	mov    0xc(%ebp),%eax
    198c:	8b 4d 08             	mov    0x8(%ebp),%ecx
    198f:	f0 87 02             	lock xchg %eax,(%edx)
    1992:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    1995:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1998:	c9                   	leave  
    1999:	c3                   	ret    

0000199a <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    199a:	55                   	push   %ebp
    199b:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    199d:	8b 45 08             	mov    0x8(%ebp),%eax
    19a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19a6:	5d                   	pop    %ebp
    19a7:	c3                   	ret    

000019a8 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19a8:	55                   	push   %ebp
    19a9:	89 e5                	mov    %esp,%ebp
    19ab:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19ae:	8b 45 08             	mov    0x8(%ebp),%eax
    19b1:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19b8:	00 
    19b9:	89 04 24             	mov    %eax,(%esp)
    19bc:	e8 bf ff ff ff       	call   1980 <xchg>
    19c1:	85 c0                	test   %eax,%eax
    19c3:	75 e9                	jne    19ae <lock_acquire+0x6>
}
    19c5:	c9                   	leave  
    19c6:	c3                   	ret    

000019c7 <lock_release>:
void lock_release(lock_t *lock){
    19c7:	55                   	push   %ebp
    19c8:	89 e5                	mov    %esp,%ebp
    19ca:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    19cd:	8b 45 08             	mov    0x8(%ebp),%eax
    19d0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19d7:	00 
    19d8:	89 04 24             	mov    %eax,(%esp)
    19db:	e8 a0 ff ff ff       	call   1980 <xchg>
}
    19e0:	c9                   	leave  
    19e1:	c3                   	ret    

000019e2 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    19e5:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    19e8:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    19ef:	e8 ab fe ff ff       	call   189f <malloc>
    19f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    19f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    19fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    19fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a00:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a05:	85 c0                	test   %eax,%eax
    1a07:	74 15                	je     1a1e <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a0c:	89 c2                	mov    %eax,%edx
    1a0e:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1a14:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a19:	29 d0                	sub    %edx,%eax
    1a1b:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1a1e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a22:	75 1b                	jne    1a3f <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1a24:	c7 44 24 04 b2 1d 00 	movl   $0x1db2,0x4(%esp)
    1a2b:	00 
    1a2c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a33:	e8 81 fb ff ff       	call   15b9 <printf>
        return 0;
    1a38:	b8 00 00 00 00       	mov    $0x0,%eax
    1a3d:	eb 6f                	jmp    1aae <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a3f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a42:	8b 55 08             	mov    0x8(%ebp),%edx
    1a45:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a48:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a4c:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a50:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a57:	00 
    1a58:	89 04 24             	mov    %eax,(%esp)
    1a5b:	e8 58 fa ff ff       	call   14b8 <clone>
    1a60:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a63:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a67:	79 1b                	jns    1a84 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1a69:	c7 44 24 04 c0 1d 00 	movl   $0x1dc0,0x4(%esp)
    1a70:	00 
    1a71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a78:	e8 3c fb ff ff       	call   15b9 <printf>
        return 0;
    1a7d:	b8 00 00 00 00       	mov    $0x0,%eax
    1a82:	eb 2a                	jmp    1aae <thread_create+0xcc>
    }
    if(tid > 0){
    1a84:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a88:	7e 05                	jle    1a8f <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1a8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a8d:	eb 1f                	jmp    1aae <thread_create+0xcc>
    }
    if(tid == 0){
    1a8f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a93:	75 14                	jne    1aa9 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1a95:	c7 44 24 04 cd 1d 00 	movl   $0x1dcd,0x4(%esp)
    1a9c:	00 
    1a9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aa4:	e8 10 fb ff ff       	call   15b9 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1aa9:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1aae:	c9                   	leave  
    1aaf:	c3                   	ret    

00001ab0 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ab0:	55                   	push   %ebp
    1ab1:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ab3:	a1 f4 1d 00 00       	mov    0x1df4,%eax
    1ab8:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1abe:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1ac3:	a3 f4 1d 00 00       	mov    %eax,0x1df4
    return (int)(rands % max);
    1ac8:	a1 f4 1d 00 00       	mov    0x1df4,%eax
    1acd:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1ad0:	ba 00 00 00 00       	mov    $0x0,%edx
    1ad5:	f7 f1                	div    %ecx
    1ad7:	89 d0                	mov    %edx,%eax
}
    1ad9:	5d                   	pop    %ebp
    1ada:	c3                   	ret    
    1adb:	90                   	nop

00001adc <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1adc:	55                   	push   %ebp
    1add:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1adf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1ae8:	8b 45 08             	mov    0x8(%ebp),%eax
    1aeb:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1af2:	8b 45 08             	mov    0x8(%ebp),%eax
    1af5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1afc:	5d                   	pop    %ebp
    1afd:	c3                   	ret    

00001afe <add_q>:

void add_q(struct queue *q, int v){
    1afe:	55                   	push   %ebp
    1aff:	89 e5                	mov    %esp,%ebp
    1b01:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b04:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b0b:	e8 8f fd ff ff       	call   189f <malloc>
    1b10:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b13:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b16:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b20:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b23:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b25:	8b 45 08             	mov    0x8(%ebp),%eax
    1b28:	8b 40 04             	mov    0x4(%eax),%eax
    1b2b:	85 c0                	test   %eax,%eax
    1b2d:	75 0b                	jne    1b3a <add_q+0x3c>
        q->head = n;
    1b2f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b32:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b35:	89 50 04             	mov    %edx,0x4(%eax)
    1b38:	eb 0c                	jmp    1b46 <add_q+0x48>
    }else{
        q->tail->next = n;
    1b3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3d:	8b 40 08             	mov    0x8(%eax),%eax
    1b40:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b43:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b46:	8b 45 08             	mov    0x8(%ebp),%eax
    1b49:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b4c:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b4f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b52:	8b 00                	mov    (%eax),%eax
    1b54:	8d 50 01             	lea    0x1(%eax),%edx
    1b57:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5a:	89 10                	mov    %edx,(%eax)
}
    1b5c:	c9                   	leave  
    1b5d:	c3                   	ret    

00001b5e <empty_q>:

int empty_q(struct queue *q){
    1b5e:	55                   	push   %ebp
    1b5f:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b61:	8b 45 08             	mov    0x8(%ebp),%eax
    1b64:	8b 00                	mov    (%eax),%eax
    1b66:	85 c0                	test   %eax,%eax
    1b68:	75 07                	jne    1b71 <empty_q+0x13>
        return 1;
    1b6a:	b8 01 00 00 00       	mov    $0x1,%eax
    1b6f:	eb 05                	jmp    1b76 <empty_q+0x18>
    else
        return 0;
    1b71:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1b76:	5d                   	pop    %ebp
    1b77:	c3                   	ret    

00001b78 <pop_q>:
int pop_q(struct queue *q){
    1b78:	55                   	push   %ebp
    1b79:	89 e5                	mov    %esp,%ebp
    1b7b:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1b7e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b81:	89 04 24             	mov    %eax,(%esp)
    1b84:	e8 d5 ff ff ff       	call   1b5e <empty_q>
    1b89:	85 c0                	test   %eax,%eax
    1b8b:	75 5d                	jne    1bea <pop_q+0x72>
       val = q->head->value; 
    1b8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b90:	8b 40 04             	mov    0x4(%eax),%eax
    1b93:	8b 00                	mov    (%eax),%eax
    1b95:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1b98:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9b:	8b 40 04             	mov    0x4(%eax),%eax
    1b9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1ba1:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba4:	8b 40 04             	mov    0x4(%eax),%eax
    1ba7:	8b 50 04             	mov    0x4(%eax),%edx
    1baa:	8b 45 08             	mov    0x8(%ebp),%eax
    1bad:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bb3:	89 04 24             	mov    %eax,(%esp)
    1bb6:	e8 b5 fb ff ff       	call   1770 <free>
       q->size--;
    1bbb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbe:	8b 00                	mov    (%eax),%eax
    1bc0:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bc3:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc6:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcb:	8b 00                	mov    (%eax),%eax
    1bcd:	85 c0                	test   %eax,%eax
    1bcf:	75 14                	jne    1be5 <pop_q+0x6d>
            q->head = 0;
    1bd1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd4:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1bdb:	8b 45 08             	mov    0x8(%ebp),%eax
    1bde:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1be5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1be8:	eb 05                	jmp    1bef <pop_q+0x77>
    }
    return -1;
    1bea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1bef:	c9                   	leave  
    1bf0:	c3                   	ret    
    1bf1:	90                   	nop
    1bf2:	90                   	nop
    1bf3:	90                   	nop

00001bf4 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1bf4:	55                   	push   %ebp
    1bf5:	89 e5                	mov    %esp,%ebp
    1bf7:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1bfa:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfd:	89 04 24             	mov    %eax,(%esp)
    1c00:	e8 a3 fd ff ff       	call   19a8 <lock_acquire>
	s->count--; 
    1c05:	8b 45 08             	mov    0x8(%ebp),%eax
    1c08:	8b 40 04             	mov    0x4(%eax),%eax
    1c0b:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c0e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c11:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1c14:	8b 45 08             	mov    0x8(%ebp),%eax
    1c17:	8b 40 04             	mov    0x4(%eax),%eax
    1c1a:	85 c0                	test   %eax,%eax
    1c1c:	79 27                	jns    1c45 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1c1e:	e8 75 f8 ff ff       	call   1498 <getpid>
    1c23:	8b 55 08             	mov    0x8(%ebp),%edx
    1c26:	83 c2 08             	add    $0x8,%edx
    1c29:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c2d:	89 14 24             	mov    %edx,(%esp)
    1c30:	e8 c9 fe ff ff       	call   1afe <add_q>
		lock_release(&s->lock); 
    1c35:	8b 45 08             	mov    0x8(%ebp),%eax
    1c38:	89 04 24             	mov    %eax,(%esp)
    1c3b:	e8 87 fd ff ff       	call   19c7 <lock_release>
		tsleep(); 
    1c40:	e8 83 f8 ff ff       	call   14c8 <tsleep>
	} 
	lock_release(&s->lock); 
    1c45:	8b 45 08             	mov    0x8(%ebp),%eax
    1c48:	89 04 24             	mov    %eax,(%esp)
    1c4b:	e8 77 fd ff ff       	call   19c7 <lock_release>
}
    1c50:	c9                   	leave  
    1c51:	c3                   	ret    

00001c52 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1c52:	55                   	push   %ebp
    1c53:	89 e5                	mov    %esp,%ebp
    1c55:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1c58:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5b:	89 04 24             	mov    %eax,(%esp)
    1c5e:	e8 45 fd ff ff       	call   19a8 <lock_acquire>
	s->count++; 
    1c63:	8b 45 08             	mov    0x8(%ebp),%eax
    1c66:	8b 40 04             	mov    0x4(%eax),%eax
    1c69:	8d 50 01             	lea    0x1(%eax),%edx
    1c6c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6f:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1c72:	8b 45 08             	mov    0x8(%ebp),%eax
    1c75:	8b 40 04             	mov    0x4(%eax),%eax
    1c78:	85 c0                	test   %eax,%eax
    1c7a:	7f 1c                	jg     1c98 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1c7c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7f:	83 c0 08             	add    $0x8,%eax
    1c82:	89 04 24             	mov    %eax,(%esp)
    1c85:	e8 ee fe ff ff       	call   1b78 <pop_q>
    1c8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1c8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c90:	89 04 24             	mov    %eax,(%esp)
    1c93:	e8 38 f8 ff ff       	call   14d0 <twakeup>
	}
	lock_release(&s->lock); 
    1c98:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9b:	89 04 24             	mov    %eax,(%esp)
    1c9e:	e8 24 fd ff ff       	call   19c7 <lock_release>
} 
    1ca3:	c9                   	leave  
    1ca4:	c3                   	ret    

00001ca5 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1ca5:	55                   	push   %ebp
    1ca6:	89 e5                	mov    %esp,%ebp
    1ca8:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1cab:	8b 45 08             	mov    0x8(%ebp),%eax
    1cae:	89 04 24             	mov    %eax,(%esp)
    1cb1:	e8 e4 fc ff ff       	call   199a <lock_init>
	s->count = size; 
    1cb6:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb9:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cbc:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1cbf:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc2:	83 c0 08             	add    $0x8,%eax
    1cc5:	89 04 24             	mov    %eax,(%esp)
    1cc8:	e8 0f fe ff ff       	call   1adc <init_q>
}
    1ccd:	c9                   	leave  
    1cce:	c3                   	ret    
