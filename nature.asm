
_nature:     file format elf32-i386


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
    1009:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    1010:	e8 db 09 00 00       	call   19f0 <lock_acquire>
	printf(1,"Hydrogen count should be 2, and oxygen count should be 1, therefore 1 water should be created. \n"); 
    1015:	c7 44 24 04 18 1d 00 	movl   $0x1d18,0x4(%esp)
    101c:	00 
    101d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1024:	e8 d8 05 00 00       	call   1601 <printf>
	lock_release(&mutex.lock); 	
    1029:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    1030:	e8 da 09 00 00       	call   1a0f <lock_release>

	sem_init(&h, 0);
    1035:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    103c:	00 
    103d:	c7 04 24 68 1e 00 00 	movl   $0x1e68,(%esp)
    1044:	e8 a4 0c 00 00       	call   1ced <sem_init>
	sem_init(&o, 0);
    1049:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1050:	00 
    1051:	c7 04 24 50 1e 00 00 	movl   $0x1e50,(%esp)
    1058:	e8 90 0c 00 00       	call   1ced <sem_init>
 
	void *hid3 = thread_create(hReady,(void*)0); 
    105d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1064:	00 
    1065:	c7 04 24 96 11 00 00 	movl   $0x1196,(%esp)
    106c:	e8 b9 09 00 00       	call   1a2a <thread_create>
    1071:	89 44 24 14          	mov    %eax,0x14(%esp)
	if(hid3 == 0) exit(); 
    1075:	83 7c 24 14 00       	cmpl   $0x0,0x14(%esp)
    107a:	75 05                	jne    1081 <main+0x81>
    107c:	e8 df 03 00 00       	call   1460 <exit>

	void *hid4 = thread_create(hReady,(void*)0); 
    1081:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1088:	00 
    1089:	c7 04 24 96 11 00 00 	movl   $0x1196,(%esp)
    1090:	e8 95 09 00 00       	call   1a2a <thread_create>
    1095:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(hid4 == 0) exit(); 
    1099:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    109e:	75 05                	jne    10a5 <main+0xa5>
    10a0:	e8 bb 03 00 00       	call   1460 <exit>
	
	void *oid = thread_create(oReady,(void *)0); 
    10a5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10ac:	00 
    10ad:	c7 04 24 d7 10 00 00 	movl   $0x10d7,(%esp)
    10b4:	e8 71 09 00 00       	call   1a2a <thread_create>
    10b9:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(oid == 0) exit(); 
    10bd:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    10c2:	75 05                	jne    10c9 <main+0xc9>
    10c4:	e8 97 03 00 00       	call   1460 <exit>

	while(wait() > 0);
    10c9:	e8 9a 03 00 00       	call   1468 <wait>
    10ce:	85 c0                	test   %eax,%eax
    10d0:	7f f7                	jg     10c9 <main+0xc9>

	exit(); 
    10d2:	e8 89 03 00 00       	call   1460 <exit>

000010d7 <oReady>:
	return 0;
}

void oReady(void *arg) {
    10d7:	55                   	push   %ebp
    10d8:	89 e5                	mov    %esp,%ebp
    10da:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(&h);
    10dd:	c7 04 24 68 1e 00 00 	movl   $0x1e68,(%esp)
    10e4:	e8 53 0b 00 00       	call   1c3c <sem_acquire>
	lock_acquire(&mutex.lock); 
    10e9:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    10f0:	e8 fb 08 00 00       	call   19f0 <lock_acquire>
	oxygen++; 
    10f5:	a1 40 1e 00 00       	mov    0x1e40,%eax
    10fa:	83 c0 01             	add    $0x1,%eax
    10fd:	a3 40 1e 00 00       	mov    %eax,0x1e40
	printf(1,"created one oxygen. Oxygen count: %d.\n",oxygen);  
    1102:	a1 40 1e 00 00       	mov    0x1e40,%eax
    1107:	89 44 24 08          	mov    %eax,0x8(%esp)
    110b:	c7 44 24 04 7c 1d 00 	movl   $0x1d7c,0x4(%esp)
    1112:	00 
    1113:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    111a:	e8 e2 04 00 00       	call   1601 <printf>
	lock_release(&mutex.lock); 
    111f:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    1126:	e8 e4 08 00 00       	call   1a0f <lock_release>
	sem_acquire(&h);
    112b:	c7 04 24 68 1e 00 00 	movl   $0x1e68,(%esp)
    1132:	e8 05 0b 00 00       	call   1c3c <sem_acquire>
	sem_signal(&o);
    1137:	c7 04 24 50 1e 00 00 	movl   $0x1e50,(%esp)
    113e:	e8 57 0b 00 00       	call   1c9a <sem_signal>
	sem_signal(&o); 
    1143:	c7 04 24 50 1e 00 00 	movl   $0x1e50,(%esp)
    114a:	e8 4b 0b 00 00       	call   1c9a <sem_signal>
	lock_acquire(&mutex.lock);
    114f:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    1156:	e8 95 08 00 00       	call   19f0 <lock_acquire>
	water_molecule++;
    115b:	a1 38 1e 00 00       	mov    0x1e38,%eax
    1160:	83 c0 01             	add    $0x1,%eax
    1163:	a3 38 1e 00 00       	mov    %eax,0x1e38
 	printf(1,"created water molecule: %d.\n",water_molecule); 	
    1168:	a1 38 1e 00 00       	mov    0x1e38,%eax
    116d:	89 44 24 08          	mov    %eax,0x8(%esp)
    1171:	c7 44 24 04 a3 1d 00 	movl   $0x1da3,0x4(%esp)
    1178:	00 
    1179:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1180:	e8 7c 04 00 00       	call   1601 <printf>
	lock_release(&mutex.lock); 	 
    1185:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    118c:	e8 7e 08 00 00       	call   1a0f <lock_release>

	texit(); 	
    1191:	e8 72 03 00 00       	call   1508 <texit>

00001196 <hReady>:
}

void hReady(void *arg) { 
    1196:	55                   	push   %ebp
    1197:	89 e5                	mov    %esp,%ebp
    1199:	83 ec 18             	sub    $0x18,%esp
	sem_signal(&h);
    119c:	c7 04 24 68 1e 00 00 	movl   $0x1e68,(%esp)
    11a3:	e8 f2 0a 00 00       	call   1c9a <sem_signal>
	sem_acquire(&o);
    11a8:	c7 04 24 50 1e 00 00 	movl   $0x1e50,(%esp)
    11af:	e8 88 0a 00 00       	call   1c3c <sem_acquire>
	lock_acquire(&mutex.lock); 
    11b4:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    11bb:	e8 30 08 00 00       	call   19f0 <lock_acquire>
	hydrogen++; 
    11c0:	a1 3c 1e 00 00       	mov    0x1e3c,%eax
    11c5:	83 c0 01             	add    $0x1,%eax
    11c8:	a3 3c 1e 00 00       	mov    %eax,0x1e3c
	printf(1,"created one hydrogen. Hydrogen count: %d.\n",hydrogen); 	
    11cd:	a1 3c 1e 00 00       	mov    0x1e3c,%eax
    11d2:	89 44 24 08          	mov    %eax,0x8(%esp)
    11d6:	c7 44 24 04 c0 1d 00 	movl   $0x1dc0,0x4(%esp)
    11dd:	00 
    11de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11e5:	e8 17 04 00 00       	call   1601 <printf>
	lock_release(&mutex.lock); 
    11ea:	c7 04 24 64 1e 00 00 	movl   $0x1e64,(%esp)
    11f1:	e8 19 08 00 00       	call   1a0f <lock_release>

	texit();  
    11f6:	e8 0d 03 00 00       	call   1508 <texit>
    11fb:	90                   	nop

000011fc <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11fc:	55                   	push   %ebp
    11fd:	89 e5                	mov    %esp,%ebp
    11ff:	57                   	push   %edi
    1200:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1201:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1204:	8b 55 10             	mov    0x10(%ebp),%edx
    1207:	8b 45 0c             	mov    0xc(%ebp),%eax
    120a:	89 cb                	mov    %ecx,%ebx
    120c:	89 df                	mov    %ebx,%edi
    120e:	89 d1                	mov    %edx,%ecx
    1210:	fc                   	cld    
    1211:	f3 aa                	rep stos %al,%es:(%edi)
    1213:	89 ca                	mov    %ecx,%edx
    1215:	89 fb                	mov    %edi,%ebx
    1217:	89 5d 08             	mov    %ebx,0x8(%ebp)
    121a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    121d:	5b                   	pop    %ebx
    121e:	5f                   	pop    %edi
    121f:	5d                   	pop    %ebp
    1220:	c3                   	ret    

00001221 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1221:	55                   	push   %ebp
    1222:	89 e5                	mov    %esp,%ebp
    1224:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1227:	8b 45 08             	mov    0x8(%ebp),%eax
    122a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    122d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1230:	0f b6 10             	movzbl (%eax),%edx
    1233:	8b 45 08             	mov    0x8(%ebp),%eax
    1236:	88 10                	mov    %dl,(%eax)
    1238:	8b 45 08             	mov    0x8(%ebp),%eax
    123b:	0f b6 00             	movzbl (%eax),%eax
    123e:	84 c0                	test   %al,%al
    1240:	0f 95 c0             	setne  %al
    1243:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1247:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    124b:	84 c0                	test   %al,%al
    124d:	75 de                	jne    122d <strcpy+0xc>
    ;
  return os;
    124f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1252:	c9                   	leave  
    1253:	c3                   	ret    

00001254 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1254:	55                   	push   %ebp
    1255:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1257:	eb 08                	jmp    1261 <strcmp+0xd>
    p++, q++;
    1259:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    125d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1261:	8b 45 08             	mov    0x8(%ebp),%eax
    1264:	0f b6 00             	movzbl (%eax),%eax
    1267:	84 c0                	test   %al,%al
    1269:	74 10                	je     127b <strcmp+0x27>
    126b:	8b 45 08             	mov    0x8(%ebp),%eax
    126e:	0f b6 10             	movzbl (%eax),%edx
    1271:	8b 45 0c             	mov    0xc(%ebp),%eax
    1274:	0f b6 00             	movzbl (%eax),%eax
    1277:	38 c2                	cmp    %al,%dl
    1279:	74 de                	je     1259 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    127b:	8b 45 08             	mov    0x8(%ebp),%eax
    127e:	0f b6 00             	movzbl (%eax),%eax
    1281:	0f b6 d0             	movzbl %al,%edx
    1284:	8b 45 0c             	mov    0xc(%ebp),%eax
    1287:	0f b6 00             	movzbl (%eax),%eax
    128a:	0f b6 c0             	movzbl %al,%eax
    128d:	89 d1                	mov    %edx,%ecx
    128f:	29 c1                	sub    %eax,%ecx
    1291:	89 c8                	mov    %ecx,%eax
}
    1293:	5d                   	pop    %ebp
    1294:	c3                   	ret    

00001295 <strlen>:

uint
strlen(char *s)
{
    1295:	55                   	push   %ebp
    1296:	89 e5                	mov    %esp,%ebp
    1298:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    129b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    12a2:	eb 04                	jmp    12a8 <strlen+0x13>
    12a4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    12a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    12ab:	03 45 08             	add    0x8(%ebp),%eax
    12ae:	0f b6 00             	movzbl (%eax),%eax
    12b1:	84 c0                	test   %al,%al
    12b3:	75 ef                	jne    12a4 <strlen+0xf>
    ;
  return n;
    12b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12b8:	c9                   	leave  
    12b9:	c3                   	ret    

000012ba <memset>:

void*
memset(void *dst, int c, uint n)
{
    12ba:	55                   	push   %ebp
    12bb:	89 e5                	mov    %esp,%ebp
    12bd:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    12c0:	8b 45 10             	mov    0x10(%ebp),%eax
    12c3:	89 44 24 08          	mov    %eax,0x8(%esp)
    12c7:	8b 45 0c             	mov    0xc(%ebp),%eax
    12ca:	89 44 24 04          	mov    %eax,0x4(%esp)
    12ce:	8b 45 08             	mov    0x8(%ebp),%eax
    12d1:	89 04 24             	mov    %eax,(%esp)
    12d4:	e8 23 ff ff ff       	call   11fc <stosb>
  return dst;
    12d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12dc:	c9                   	leave  
    12dd:	c3                   	ret    

000012de <strchr>:

char*
strchr(const char *s, char c)
{
    12de:	55                   	push   %ebp
    12df:	89 e5                	mov    %esp,%ebp
    12e1:	83 ec 04             	sub    $0x4,%esp
    12e4:	8b 45 0c             	mov    0xc(%ebp),%eax
    12e7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12ea:	eb 14                	jmp    1300 <strchr+0x22>
    if(*s == c)
    12ec:	8b 45 08             	mov    0x8(%ebp),%eax
    12ef:	0f b6 00             	movzbl (%eax),%eax
    12f2:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12f5:	75 05                	jne    12fc <strchr+0x1e>
      return (char*)s;
    12f7:	8b 45 08             	mov    0x8(%ebp),%eax
    12fa:	eb 13                	jmp    130f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1300:	8b 45 08             	mov    0x8(%ebp),%eax
    1303:	0f b6 00             	movzbl (%eax),%eax
    1306:	84 c0                	test   %al,%al
    1308:	75 e2                	jne    12ec <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    130a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    130f:	c9                   	leave  
    1310:	c3                   	ret    

00001311 <gets>:

char*
gets(char *buf, int max)
{
    1311:	55                   	push   %ebp
    1312:	89 e5                	mov    %esp,%ebp
    1314:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1317:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    131e:	eb 44                	jmp    1364 <gets+0x53>
    cc = read(0, &c, 1);
    1320:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1327:	00 
    1328:	8d 45 ef             	lea    -0x11(%ebp),%eax
    132b:	89 44 24 04          	mov    %eax,0x4(%esp)
    132f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1336:	e8 3d 01 00 00       	call   1478 <read>
    133b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    133e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1342:	7e 2d                	jle    1371 <gets+0x60>
      break;
    buf[i++] = c;
    1344:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1347:	03 45 08             	add    0x8(%ebp),%eax
    134a:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    134e:	88 10                	mov    %dl,(%eax)
    1350:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1354:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1358:	3c 0a                	cmp    $0xa,%al
    135a:	74 16                	je     1372 <gets+0x61>
    135c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1360:	3c 0d                	cmp    $0xd,%al
    1362:	74 0e                	je     1372 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1364:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1367:	83 c0 01             	add    $0x1,%eax
    136a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    136d:	7c b1                	jl     1320 <gets+0xf>
    136f:	eb 01                	jmp    1372 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1371:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1372:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1375:	03 45 08             	add    0x8(%ebp),%eax
    1378:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    137b:	8b 45 08             	mov    0x8(%ebp),%eax
}
    137e:	c9                   	leave  
    137f:	c3                   	ret    

00001380 <stat>:

int
stat(char *n, struct stat *st)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1386:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    138d:	00 
    138e:	8b 45 08             	mov    0x8(%ebp),%eax
    1391:	89 04 24             	mov    %eax,(%esp)
    1394:	e8 07 01 00 00       	call   14a0 <open>
    1399:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    139c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13a0:	79 07                	jns    13a9 <stat+0x29>
    return -1;
    13a2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13a7:	eb 23                	jmp    13cc <stat+0x4c>
  r = fstat(fd, st);
    13a9:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ac:	89 44 24 04          	mov    %eax,0x4(%esp)
    13b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13b3:	89 04 24             	mov    %eax,(%esp)
    13b6:	e8 fd 00 00 00       	call   14b8 <fstat>
    13bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    13be:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13c1:	89 04 24             	mov    %eax,(%esp)
    13c4:	e8 bf 00 00 00       	call   1488 <close>
  return r;
    13c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13cc:	c9                   	leave  
    13cd:	c3                   	ret    

000013ce <atoi>:

int
atoi(const char *s)
{
    13ce:	55                   	push   %ebp
    13cf:	89 e5                	mov    %esp,%ebp
    13d1:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13d4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13db:	eb 24                	jmp    1401 <atoi+0x33>
    n = n*10 + *s++ - '0';
    13dd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13e0:	89 d0                	mov    %edx,%eax
    13e2:	c1 e0 02             	shl    $0x2,%eax
    13e5:	01 d0                	add    %edx,%eax
    13e7:	01 c0                	add    %eax,%eax
    13e9:	89 c2                	mov    %eax,%edx
    13eb:	8b 45 08             	mov    0x8(%ebp),%eax
    13ee:	0f b6 00             	movzbl (%eax),%eax
    13f1:	0f be c0             	movsbl %al,%eax
    13f4:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13f7:	83 e8 30             	sub    $0x30,%eax
    13fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13fd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1401:	8b 45 08             	mov    0x8(%ebp),%eax
    1404:	0f b6 00             	movzbl (%eax),%eax
    1407:	3c 2f                	cmp    $0x2f,%al
    1409:	7e 0a                	jle    1415 <atoi+0x47>
    140b:	8b 45 08             	mov    0x8(%ebp),%eax
    140e:	0f b6 00             	movzbl (%eax),%eax
    1411:	3c 39                	cmp    $0x39,%al
    1413:	7e c8                	jle    13dd <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1415:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1418:	c9                   	leave  
    1419:	c3                   	ret    

0000141a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    141a:	55                   	push   %ebp
    141b:	89 e5                	mov    %esp,%ebp
    141d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1420:	8b 45 08             	mov    0x8(%ebp),%eax
    1423:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1426:	8b 45 0c             	mov    0xc(%ebp),%eax
    1429:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    142c:	eb 13                	jmp    1441 <memmove+0x27>
    *dst++ = *src++;
    142e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1431:	0f b6 10             	movzbl (%eax),%edx
    1434:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1437:	88 10                	mov    %dl,(%eax)
    1439:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    143d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1441:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1445:	0f 9f c0             	setg   %al
    1448:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    144c:	84 c0                	test   %al,%al
    144e:	75 de                	jne    142e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1450:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1453:	c9                   	leave  
    1454:	c3                   	ret    
    1455:	90                   	nop
    1456:	90                   	nop
    1457:	90                   	nop

00001458 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1458:	b8 01 00 00 00       	mov    $0x1,%eax
    145d:	cd 40                	int    $0x40
    145f:	c3                   	ret    

00001460 <exit>:
SYSCALL(exit)
    1460:	b8 02 00 00 00       	mov    $0x2,%eax
    1465:	cd 40                	int    $0x40
    1467:	c3                   	ret    

00001468 <wait>:
SYSCALL(wait)
    1468:	b8 03 00 00 00       	mov    $0x3,%eax
    146d:	cd 40                	int    $0x40
    146f:	c3                   	ret    

00001470 <pipe>:
SYSCALL(pipe)
    1470:	b8 04 00 00 00       	mov    $0x4,%eax
    1475:	cd 40                	int    $0x40
    1477:	c3                   	ret    

00001478 <read>:
SYSCALL(read)
    1478:	b8 05 00 00 00       	mov    $0x5,%eax
    147d:	cd 40                	int    $0x40
    147f:	c3                   	ret    

00001480 <write>:
SYSCALL(write)
    1480:	b8 10 00 00 00       	mov    $0x10,%eax
    1485:	cd 40                	int    $0x40
    1487:	c3                   	ret    

00001488 <close>:
SYSCALL(close)
    1488:	b8 15 00 00 00       	mov    $0x15,%eax
    148d:	cd 40                	int    $0x40
    148f:	c3                   	ret    

00001490 <kill>:
SYSCALL(kill)
    1490:	b8 06 00 00 00       	mov    $0x6,%eax
    1495:	cd 40                	int    $0x40
    1497:	c3                   	ret    

00001498 <exec>:
SYSCALL(exec)
    1498:	b8 07 00 00 00       	mov    $0x7,%eax
    149d:	cd 40                	int    $0x40
    149f:	c3                   	ret    

000014a0 <open>:
SYSCALL(open)
    14a0:	b8 0f 00 00 00       	mov    $0xf,%eax
    14a5:	cd 40                	int    $0x40
    14a7:	c3                   	ret    

000014a8 <mknod>:
SYSCALL(mknod)
    14a8:	b8 11 00 00 00       	mov    $0x11,%eax
    14ad:	cd 40                	int    $0x40
    14af:	c3                   	ret    

000014b0 <unlink>:
SYSCALL(unlink)
    14b0:	b8 12 00 00 00       	mov    $0x12,%eax
    14b5:	cd 40                	int    $0x40
    14b7:	c3                   	ret    

000014b8 <fstat>:
SYSCALL(fstat)
    14b8:	b8 08 00 00 00       	mov    $0x8,%eax
    14bd:	cd 40                	int    $0x40
    14bf:	c3                   	ret    

000014c0 <link>:
SYSCALL(link)
    14c0:	b8 13 00 00 00       	mov    $0x13,%eax
    14c5:	cd 40                	int    $0x40
    14c7:	c3                   	ret    

000014c8 <mkdir>:
SYSCALL(mkdir)
    14c8:	b8 14 00 00 00       	mov    $0x14,%eax
    14cd:	cd 40                	int    $0x40
    14cf:	c3                   	ret    

000014d0 <chdir>:
SYSCALL(chdir)
    14d0:	b8 09 00 00 00       	mov    $0x9,%eax
    14d5:	cd 40                	int    $0x40
    14d7:	c3                   	ret    

000014d8 <dup>:
SYSCALL(dup)
    14d8:	b8 0a 00 00 00       	mov    $0xa,%eax
    14dd:	cd 40                	int    $0x40
    14df:	c3                   	ret    

000014e0 <getpid>:
SYSCALL(getpid)
    14e0:	b8 0b 00 00 00       	mov    $0xb,%eax
    14e5:	cd 40                	int    $0x40
    14e7:	c3                   	ret    

000014e8 <sbrk>:
SYSCALL(sbrk)
    14e8:	b8 0c 00 00 00       	mov    $0xc,%eax
    14ed:	cd 40                	int    $0x40
    14ef:	c3                   	ret    

000014f0 <sleep>:
SYSCALL(sleep)
    14f0:	b8 0d 00 00 00       	mov    $0xd,%eax
    14f5:	cd 40                	int    $0x40
    14f7:	c3                   	ret    

000014f8 <uptime>:
SYSCALL(uptime)
    14f8:	b8 0e 00 00 00       	mov    $0xe,%eax
    14fd:	cd 40                	int    $0x40
    14ff:	c3                   	ret    

00001500 <clone>:
SYSCALL(clone)
    1500:	b8 16 00 00 00       	mov    $0x16,%eax
    1505:	cd 40                	int    $0x40
    1507:	c3                   	ret    

00001508 <texit>:
SYSCALL(texit)
    1508:	b8 17 00 00 00       	mov    $0x17,%eax
    150d:	cd 40                	int    $0x40
    150f:	c3                   	ret    

00001510 <tsleep>:
SYSCALL(tsleep)
    1510:	b8 18 00 00 00       	mov    $0x18,%eax
    1515:	cd 40                	int    $0x40
    1517:	c3                   	ret    

00001518 <twakeup>:
SYSCALL(twakeup)
    1518:	b8 19 00 00 00       	mov    $0x19,%eax
    151d:	cd 40                	int    $0x40
    151f:	c3                   	ret    

00001520 <thread_yield>:
SYSCALL(thread_yield) 
    1520:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1525:	cd 40                	int    $0x40
    1527:	c3                   	ret    

00001528 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1528:	55                   	push   %ebp
    1529:	89 e5                	mov    %esp,%ebp
    152b:	83 ec 28             	sub    $0x28,%esp
    152e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1531:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1534:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    153b:	00 
    153c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    153f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1543:	8b 45 08             	mov    0x8(%ebp),%eax
    1546:	89 04 24             	mov    %eax,(%esp)
    1549:	e8 32 ff ff ff       	call   1480 <write>
}
    154e:	c9                   	leave  
    154f:	c3                   	ret    

00001550 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1550:	55                   	push   %ebp
    1551:	89 e5                	mov    %esp,%ebp
    1553:	53                   	push   %ebx
    1554:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1557:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    155e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1562:	74 17                	je     157b <printint+0x2b>
    1564:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1568:	79 11                	jns    157b <printint+0x2b>
    neg = 1;
    156a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1571:	8b 45 0c             	mov    0xc(%ebp),%eax
    1574:	f7 d8                	neg    %eax
    1576:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1579:	eb 06                	jmp    1581 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    157b:	8b 45 0c             	mov    0xc(%ebp),%eax
    157e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1581:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1588:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    158b:	8b 5d 10             	mov    0x10(%ebp),%ebx
    158e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1591:	ba 00 00 00 00       	mov    $0x0,%edx
    1596:	f7 f3                	div    %ebx
    1598:	89 d0                	mov    %edx,%eax
    159a:	0f b6 80 20 1e 00 00 	movzbl 0x1e20(%eax),%eax
    15a1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    15a5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    15a9:	8b 45 10             	mov    0x10(%ebp),%eax
    15ac:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    15af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15b2:	ba 00 00 00 00       	mov    $0x0,%edx
    15b7:	f7 75 d4             	divl   -0x2c(%ebp)
    15ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15c1:	75 c5                	jne    1588 <printint+0x38>
  if(neg)
    15c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15c7:	74 28                	je     15f1 <printint+0xa1>
    buf[i++] = '-';
    15c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15cc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    15d1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    15d5:	eb 1a                	jmp    15f1 <printint+0xa1>
    putc(fd, buf[i]);
    15d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15da:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    15df:	0f be c0             	movsbl %al,%eax
    15e2:	89 44 24 04          	mov    %eax,0x4(%esp)
    15e6:	8b 45 08             	mov    0x8(%ebp),%eax
    15e9:	89 04 24             	mov    %eax,(%esp)
    15ec:	e8 37 ff ff ff       	call   1528 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15f1:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    15f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15f9:	79 dc                	jns    15d7 <printint+0x87>
    putc(fd, buf[i]);
}
    15fb:	83 c4 44             	add    $0x44,%esp
    15fe:	5b                   	pop    %ebx
    15ff:	5d                   	pop    %ebp
    1600:	c3                   	ret    

00001601 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1601:	55                   	push   %ebp
    1602:	89 e5                	mov    %esp,%ebp
    1604:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1607:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    160e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1611:	83 c0 04             	add    $0x4,%eax
    1614:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1617:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    161e:	e9 7e 01 00 00       	jmp    17a1 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1623:	8b 55 0c             	mov    0xc(%ebp),%edx
    1626:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1629:	8d 04 02             	lea    (%edx,%eax,1),%eax
    162c:	0f b6 00             	movzbl (%eax),%eax
    162f:	0f be c0             	movsbl %al,%eax
    1632:	25 ff 00 00 00       	and    $0xff,%eax
    1637:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    163a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    163e:	75 2c                	jne    166c <printf+0x6b>
      if(c == '%'){
    1640:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1644:	75 0c                	jne    1652 <printf+0x51>
        state = '%';
    1646:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    164d:	e9 4b 01 00 00       	jmp    179d <printf+0x19c>
      } else {
        putc(fd, c);
    1652:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1655:	0f be c0             	movsbl %al,%eax
    1658:	89 44 24 04          	mov    %eax,0x4(%esp)
    165c:	8b 45 08             	mov    0x8(%ebp),%eax
    165f:	89 04 24             	mov    %eax,(%esp)
    1662:	e8 c1 fe ff ff       	call   1528 <putc>
    1667:	e9 31 01 00 00       	jmp    179d <printf+0x19c>
      }
    } else if(state == '%'){
    166c:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1670:	0f 85 27 01 00 00    	jne    179d <printf+0x19c>
      if(c == 'd'){
    1676:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    167a:	75 2d                	jne    16a9 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    167c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    167f:	8b 00                	mov    (%eax),%eax
    1681:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1688:	00 
    1689:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1690:	00 
    1691:	89 44 24 04          	mov    %eax,0x4(%esp)
    1695:	8b 45 08             	mov    0x8(%ebp),%eax
    1698:	89 04 24             	mov    %eax,(%esp)
    169b:	e8 b0 fe ff ff       	call   1550 <printint>
        ap++;
    16a0:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    16a4:	e9 ed 00 00 00       	jmp    1796 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    16a9:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    16ad:	74 06                	je     16b5 <printf+0xb4>
    16af:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    16b3:	75 2d                	jne    16e2 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    16b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16b8:	8b 00                	mov    (%eax),%eax
    16ba:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16c1:	00 
    16c2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    16c9:	00 
    16ca:	89 44 24 04          	mov    %eax,0x4(%esp)
    16ce:	8b 45 08             	mov    0x8(%ebp),%eax
    16d1:	89 04 24             	mov    %eax,(%esp)
    16d4:	e8 77 fe ff ff       	call   1550 <printint>
        ap++;
    16d9:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    16dd:	e9 b4 00 00 00       	jmp    1796 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    16e2:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    16e6:	75 46                	jne    172e <printf+0x12d>
        s = (char*)*ap;
    16e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16eb:	8b 00                	mov    (%eax),%eax
    16ed:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    16f0:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    16f4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    16f8:	75 27                	jne    1721 <printf+0x120>
          s = "(null)";
    16fa:	c7 45 e4 eb 1d 00 00 	movl   $0x1deb,-0x1c(%ebp)
        while(*s != 0){
    1701:	eb 1f                	jmp    1722 <printf+0x121>
          putc(fd, *s);
    1703:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1706:	0f b6 00             	movzbl (%eax),%eax
    1709:	0f be c0             	movsbl %al,%eax
    170c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1710:	8b 45 08             	mov    0x8(%ebp),%eax
    1713:	89 04 24             	mov    %eax,(%esp)
    1716:	e8 0d fe ff ff       	call   1528 <putc>
          s++;
    171b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    171f:	eb 01                	jmp    1722 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1721:	90                   	nop
    1722:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1725:	0f b6 00             	movzbl (%eax),%eax
    1728:	84 c0                	test   %al,%al
    172a:	75 d7                	jne    1703 <printf+0x102>
    172c:	eb 68                	jmp    1796 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    172e:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1732:	75 1d                	jne    1751 <printf+0x150>
        putc(fd, *ap);
    1734:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1737:	8b 00                	mov    (%eax),%eax
    1739:	0f be c0             	movsbl %al,%eax
    173c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1740:	8b 45 08             	mov    0x8(%ebp),%eax
    1743:	89 04 24             	mov    %eax,(%esp)
    1746:	e8 dd fd ff ff       	call   1528 <putc>
        ap++;
    174b:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    174f:	eb 45                	jmp    1796 <printf+0x195>
      } else if(c == '%'){
    1751:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1755:	75 17                	jne    176e <printf+0x16d>
        putc(fd, c);
    1757:	8b 45 e8             	mov    -0x18(%ebp),%eax
    175a:	0f be c0             	movsbl %al,%eax
    175d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1761:	8b 45 08             	mov    0x8(%ebp),%eax
    1764:	89 04 24             	mov    %eax,(%esp)
    1767:	e8 bc fd ff ff       	call   1528 <putc>
    176c:	eb 28                	jmp    1796 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    176e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1775:	00 
    1776:	8b 45 08             	mov    0x8(%ebp),%eax
    1779:	89 04 24             	mov    %eax,(%esp)
    177c:	e8 a7 fd ff ff       	call   1528 <putc>
        putc(fd, c);
    1781:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1784:	0f be c0             	movsbl %al,%eax
    1787:	89 44 24 04          	mov    %eax,0x4(%esp)
    178b:	8b 45 08             	mov    0x8(%ebp),%eax
    178e:	89 04 24             	mov    %eax,(%esp)
    1791:	e8 92 fd ff ff       	call   1528 <putc>
      }
      state = 0;
    1796:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    179d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    17a1:	8b 55 0c             	mov    0xc(%ebp),%edx
    17a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a7:	8d 04 02             	lea    (%edx,%eax,1),%eax
    17aa:	0f b6 00             	movzbl (%eax),%eax
    17ad:	84 c0                	test   %al,%al
    17af:	0f 85 6e fe ff ff    	jne    1623 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17b5:	c9                   	leave  
    17b6:	c3                   	ret    
    17b7:	90                   	nop

000017b8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17b8:	55                   	push   %ebp
    17b9:	89 e5                	mov    %esp,%ebp
    17bb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17be:	8b 45 08             	mov    0x8(%ebp),%eax
    17c1:	83 e8 08             	sub    $0x8,%eax
    17c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17c7:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    17cc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17cf:	eb 24                	jmp    17f5 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d4:	8b 00                	mov    (%eax),%eax
    17d6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17d9:	77 12                	ja     17ed <free+0x35>
    17db:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17de:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17e1:	77 24                	ja     1807 <free+0x4f>
    17e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17e6:	8b 00                	mov    (%eax),%eax
    17e8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17eb:	77 1a                	ja     1807 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17f0:	8b 00                	mov    (%eax),%eax
    17f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17fb:	76 d4                	jbe    17d1 <free+0x19>
    17fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1800:	8b 00                	mov    (%eax),%eax
    1802:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1805:	76 ca                	jbe    17d1 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1807:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180a:	8b 40 04             	mov    0x4(%eax),%eax
    180d:	c1 e0 03             	shl    $0x3,%eax
    1810:	89 c2                	mov    %eax,%edx
    1812:	03 55 f8             	add    -0x8(%ebp),%edx
    1815:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1818:	8b 00                	mov    (%eax),%eax
    181a:	39 c2                	cmp    %eax,%edx
    181c:	75 24                	jne    1842 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    181e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1821:	8b 50 04             	mov    0x4(%eax),%edx
    1824:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1827:	8b 00                	mov    (%eax),%eax
    1829:	8b 40 04             	mov    0x4(%eax),%eax
    182c:	01 c2                	add    %eax,%edx
    182e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1831:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1834:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1837:	8b 00                	mov    (%eax),%eax
    1839:	8b 10                	mov    (%eax),%edx
    183b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    183e:	89 10                	mov    %edx,(%eax)
    1840:	eb 0a                	jmp    184c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1842:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1845:	8b 10                	mov    (%eax),%edx
    1847:	8b 45 f8             	mov    -0x8(%ebp),%eax
    184a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    184c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184f:	8b 40 04             	mov    0x4(%eax),%eax
    1852:	c1 e0 03             	shl    $0x3,%eax
    1855:	03 45 fc             	add    -0x4(%ebp),%eax
    1858:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    185b:	75 20                	jne    187d <free+0xc5>
    p->s.size += bp->s.size;
    185d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1860:	8b 50 04             	mov    0x4(%eax),%edx
    1863:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1866:	8b 40 04             	mov    0x4(%eax),%eax
    1869:	01 c2                	add    %eax,%edx
    186b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1871:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1874:	8b 10                	mov    (%eax),%edx
    1876:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1879:	89 10                	mov    %edx,(%eax)
    187b:	eb 08                	jmp    1885 <free+0xcd>
  } else
    p->s.ptr = bp;
    187d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1880:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1883:	89 10                	mov    %edx,(%eax)
  freep = p;
    1885:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1888:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
}
    188d:	c9                   	leave  
    188e:	c3                   	ret    

0000188f <morecore>:

static Header*
morecore(uint nu)
{
    188f:	55                   	push   %ebp
    1890:	89 e5                	mov    %esp,%ebp
    1892:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1895:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    189c:	77 07                	ja     18a5 <morecore+0x16>
    nu = 4096;
    189e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    18a5:	8b 45 08             	mov    0x8(%ebp),%eax
    18a8:	c1 e0 03             	shl    $0x3,%eax
    18ab:	89 04 24             	mov    %eax,(%esp)
    18ae:	e8 35 fc ff ff       	call   14e8 <sbrk>
    18b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    18b6:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    18ba:	75 07                	jne    18c3 <morecore+0x34>
    return 0;
    18bc:	b8 00 00 00 00       	mov    $0x0,%eax
    18c1:	eb 22                	jmp    18e5 <morecore+0x56>
  hp = (Header*)p;
    18c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    18c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18cc:	8b 55 08             	mov    0x8(%ebp),%edx
    18cf:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18d5:	83 c0 08             	add    $0x8,%eax
    18d8:	89 04 24             	mov    %eax,(%esp)
    18db:	e8 d8 fe ff ff       	call   17b8 <free>
  return freep;
    18e0:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
}
    18e5:	c9                   	leave  
    18e6:	c3                   	ret    

000018e7 <malloc>:

void*
malloc(uint nbytes)
{
    18e7:	55                   	push   %ebp
    18e8:	89 e5                	mov    %esp,%ebp
    18ea:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18ed:	8b 45 08             	mov    0x8(%ebp),%eax
    18f0:	83 c0 07             	add    $0x7,%eax
    18f3:	c1 e8 03             	shr    $0x3,%eax
    18f6:	83 c0 01             	add    $0x1,%eax
    18f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    18fc:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    1901:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1904:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1908:	75 23                	jne    192d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    190a:	c7 45 f0 44 1e 00 00 	movl   $0x1e44,-0x10(%ebp)
    1911:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1914:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
    1919:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    191e:	a3 44 1e 00 00       	mov    %eax,0x1e44
    base.s.size = 0;
    1923:	c7 05 48 1e 00 00 00 	movl   $0x0,0x1e48
    192a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    192d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1930:	8b 00                	mov    (%eax),%eax
    1932:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1935:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1938:	8b 40 04             	mov    0x4(%eax),%eax
    193b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    193e:	72 4d                	jb     198d <malloc+0xa6>
      if(p->s.size == nunits)
    1940:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1943:	8b 40 04             	mov    0x4(%eax),%eax
    1946:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1949:	75 0c                	jne    1957 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    194b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    194e:	8b 10                	mov    (%eax),%edx
    1950:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1953:	89 10                	mov    %edx,(%eax)
    1955:	eb 26                	jmp    197d <malloc+0x96>
      else {
        p->s.size -= nunits;
    1957:	8b 45 ec             	mov    -0x14(%ebp),%eax
    195a:	8b 40 04             	mov    0x4(%eax),%eax
    195d:	89 c2                	mov    %eax,%edx
    195f:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1962:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1965:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1968:	8b 45 ec             	mov    -0x14(%ebp),%eax
    196b:	8b 40 04             	mov    0x4(%eax),%eax
    196e:	c1 e0 03             	shl    $0x3,%eax
    1971:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1974:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1977:	8b 55 f4             	mov    -0xc(%ebp),%edx
    197a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    197d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1980:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
      return (void*)(p + 1);
    1985:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1988:	83 c0 08             	add    $0x8,%eax
    198b:	eb 38                	jmp    19c5 <malloc+0xde>
    }
    if(p == freep)
    198d:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
    1992:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1995:	75 1b                	jne    19b2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1997:	8b 45 f4             	mov    -0xc(%ebp),%eax
    199a:	89 04 24             	mov    %eax,(%esp)
    199d:	e8 ed fe ff ff       	call   188f <morecore>
    19a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    19a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19a9:	75 07                	jne    19b2 <malloc+0xcb>
        return 0;
    19ab:	b8 00 00 00 00       	mov    $0x0,%eax
    19b0:	eb 13                	jmp    19c5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    19b2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19b5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19bb:	8b 00                	mov    (%eax),%eax
    19bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    19c0:	e9 70 ff ff ff       	jmp    1935 <malloc+0x4e>
}
    19c5:	c9                   	leave  
    19c6:	c3                   	ret    
    19c7:	90                   	nop

000019c8 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    19c8:	55                   	push   %ebp
    19c9:	89 e5                	mov    %esp,%ebp
    19cb:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    19ce:	8b 55 08             	mov    0x8(%ebp),%edx
    19d1:	8b 45 0c             	mov    0xc(%ebp),%eax
    19d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19d7:	f0 87 02             	lock xchg %eax,(%edx)
    19da:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19e0:	c9                   	leave  
    19e1:	c3                   	ret    

000019e2 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19e2:	55                   	push   %ebp
    19e3:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19e5:	8b 45 08             	mov    0x8(%ebp),%eax
    19e8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19ee:	5d                   	pop    %ebp
    19ef:	c3                   	ret    

000019f0 <lock_acquire>:
void lock_acquire(lock_t *lock){
    19f0:	55                   	push   %ebp
    19f1:	89 e5                	mov    %esp,%ebp
    19f3:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19f6:	8b 45 08             	mov    0x8(%ebp),%eax
    19f9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1a00:	00 
    1a01:	89 04 24             	mov    %eax,(%esp)
    1a04:	e8 bf ff ff ff       	call   19c8 <xchg>
    1a09:	85 c0                	test   %eax,%eax
    1a0b:	75 e9                	jne    19f6 <lock_acquire+0x6>
}
    1a0d:	c9                   	leave  
    1a0e:	c3                   	ret    

00001a0f <lock_release>:
void lock_release(lock_t *lock){
    1a0f:	55                   	push   %ebp
    1a10:	89 e5                	mov    %esp,%ebp
    1a12:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1a15:	8b 45 08             	mov    0x8(%ebp),%eax
    1a18:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a1f:	00 
    1a20:	89 04 24             	mov    %eax,(%esp)
    1a23:	e8 a0 ff ff ff       	call   19c8 <xchg>
}
    1a28:	c9                   	leave  
    1a29:	c3                   	ret    

00001a2a <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1a2a:	55                   	push   %ebp
    1a2b:	89 e5                	mov    %esp,%ebp
    1a2d:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1a30:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a37:	e8 ab fe ff ff       	call   18e7 <malloc>
    1a3c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a42:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a45:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a48:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a4d:	85 c0                	test   %eax,%eax
    1a4f:	74 15                	je     1a66 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a54:	89 c2                	mov    %eax,%edx
    1a56:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1a5c:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a61:	29 d0                	sub    %edx,%eax
    1a63:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1a66:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a6a:	75 1b                	jne    1a87 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1a6c:	c7 44 24 04 f2 1d 00 	movl   $0x1df2,0x4(%esp)
    1a73:	00 
    1a74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a7b:	e8 81 fb ff ff       	call   1601 <printf>
        return 0;
    1a80:	b8 00 00 00 00       	mov    $0x0,%eax
    1a85:	eb 6f                	jmp    1af6 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a8a:	8b 55 08             	mov    0x8(%ebp),%edx
    1a8d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a90:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a94:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a98:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a9f:	00 
    1aa0:	89 04 24             	mov    %eax,(%esp)
    1aa3:	e8 58 fa ff ff       	call   1500 <clone>
    1aa8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1aab:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1aaf:	79 1b                	jns    1acc <thread_create+0xa2>
        printf(1,"clone fails\n");
    1ab1:	c7 44 24 04 00 1e 00 	movl   $0x1e00,0x4(%esp)
    1ab8:	00 
    1ab9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ac0:	e8 3c fb ff ff       	call   1601 <printf>
        return 0;
    1ac5:	b8 00 00 00 00       	mov    $0x0,%eax
    1aca:	eb 2a                	jmp    1af6 <thread_create+0xcc>
    }
    if(tid > 0){
    1acc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ad0:	7e 05                	jle    1ad7 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1ad2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ad5:	eb 1f                	jmp    1af6 <thread_create+0xcc>
    }
    if(tid == 0){
    1ad7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1adb:	75 14                	jne    1af1 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1add:	c7 44 24 04 0d 1e 00 	movl   $0x1e0d,0x4(%esp)
    1ae4:	00 
    1ae5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aec:	e8 10 fb ff ff       	call   1601 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1af1:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1af6:	c9                   	leave  
    1af7:	c3                   	ret    

00001af8 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1af8:	55                   	push   %ebp
    1af9:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1afb:	a1 34 1e 00 00       	mov    0x1e34,%eax
    1b00:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1b06:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1b0b:	a3 34 1e 00 00       	mov    %eax,0x1e34
    return (int)(rands % max);
    1b10:	a1 34 1e 00 00       	mov    0x1e34,%eax
    1b15:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b18:	ba 00 00 00 00       	mov    $0x0,%edx
    1b1d:	f7 f1                	div    %ecx
    1b1f:	89 d0                	mov    %edx,%eax
}
    1b21:	5d                   	pop    %ebp
    1b22:	c3                   	ret    
    1b23:	90                   	nop

00001b24 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1b24:	55                   	push   %ebp
    1b25:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1b27:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1b30:	8b 45 08             	mov    0x8(%ebp),%eax
    1b33:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b3a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b44:	5d                   	pop    %ebp
    1b45:	c3                   	ret    

00001b46 <add_q>:

void add_q(struct queue *q, int v){
    1b46:	55                   	push   %ebp
    1b47:	89 e5                	mov    %esp,%ebp
    1b49:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b4c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b53:	e8 8f fd ff ff       	call   18e7 <malloc>
    1b58:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b5e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b68:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b6b:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b6d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b70:	8b 40 04             	mov    0x4(%eax),%eax
    1b73:	85 c0                	test   %eax,%eax
    1b75:	75 0b                	jne    1b82 <add_q+0x3c>
        q->head = n;
    1b77:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b7d:	89 50 04             	mov    %edx,0x4(%eax)
    1b80:	eb 0c                	jmp    1b8e <add_q+0x48>
    }else{
        q->tail->next = n;
    1b82:	8b 45 08             	mov    0x8(%ebp),%eax
    1b85:	8b 40 08             	mov    0x8(%eax),%eax
    1b88:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b8b:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b91:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b94:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b97:	8b 45 08             	mov    0x8(%ebp),%eax
    1b9a:	8b 00                	mov    (%eax),%eax
    1b9c:	8d 50 01             	lea    0x1(%eax),%edx
    1b9f:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba2:	89 10                	mov    %edx,(%eax)
}
    1ba4:	c9                   	leave  
    1ba5:	c3                   	ret    

00001ba6 <empty_q>:

int empty_q(struct queue *q){
    1ba6:	55                   	push   %ebp
    1ba7:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1ba9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bac:	8b 00                	mov    (%eax),%eax
    1bae:	85 c0                	test   %eax,%eax
    1bb0:	75 07                	jne    1bb9 <empty_q+0x13>
        return 1;
    1bb2:	b8 01 00 00 00       	mov    $0x1,%eax
    1bb7:	eb 05                	jmp    1bbe <empty_q+0x18>
    else
        return 0;
    1bb9:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1bbe:	5d                   	pop    %ebp
    1bbf:	c3                   	ret    

00001bc0 <pop_q>:
int pop_q(struct queue *q){
    1bc0:	55                   	push   %ebp
    1bc1:	89 e5                	mov    %esp,%ebp
    1bc3:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1bc6:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc9:	89 04 24             	mov    %eax,(%esp)
    1bcc:	e8 d5 ff ff ff       	call   1ba6 <empty_q>
    1bd1:	85 c0                	test   %eax,%eax
    1bd3:	75 5d                	jne    1c32 <pop_q+0x72>
       val = q->head->value; 
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	8b 40 04             	mov    0x4(%eax),%eax
    1bdb:	8b 00                	mov    (%eax),%eax
    1bdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1be0:	8b 45 08             	mov    0x8(%ebp),%eax
    1be3:	8b 40 04             	mov    0x4(%eax),%eax
    1be6:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1be9:	8b 45 08             	mov    0x8(%ebp),%eax
    1bec:	8b 40 04             	mov    0x4(%eax),%eax
    1bef:	8b 50 04             	mov    0x4(%eax),%edx
    1bf2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf5:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1bf8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bfb:	89 04 24             	mov    %eax,(%esp)
    1bfe:	e8 b5 fb ff ff       	call   17b8 <free>
       q->size--;
    1c03:	8b 45 08             	mov    0x8(%ebp),%eax
    1c06:	8b 00                	mov    (%eax),%eax
    1c08:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1c10:	8b 45 08             	mov    0x8(%ebp),%eax
    1c13:	8b 00                	mov    (%eax),%eax
    1c15:	85 c0                	test   %eax,%eax
    1c17:	75 14                	jne    1c2d <pop_q+0x6d>
            q->head = 0;
    1c19:	8b 45 08             	mov    0x8(%ebp),%eax
    1c1c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1c23:	8b 45 08             	mov    0x8(%ebp),%eax
    1c26:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1c2d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c30:	eb 05                	jmp    1c37 <pop_q+0x77>
    }
    return -1;
    1c32:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c37:	c9                   	leave  
    1c38:	c3                   	ret    
    1c39:	90                   	nop
    1c3a:	90                   	nop
    1c3b:	90                   	nop

00001c3c <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1c3c:	55                   	push   %ebp
    1c3d:	89 e5                	mov    %esp,%ebp
    1c3f:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1c42:	8b 45 08             	mov    0x8(%ebp),%eax
    1c45:	89 04 24             	mov    %eax,(%esp)
    1c48:	e8 a3 fd ff ff       	call   19f0 <lock_acquire>
	s->count--; 
    1c4d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c50:	8b 40 04             	mov    0x4(%eax),%eax
    1c53:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c56:	8b 45 08             	mov    0x8(%ebp),%eax
    1c59:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1c5c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c5f:	8b 40 04             	mov    0x4(%eax),%eax
    1c62:	85 c0                	test   %eax,%eax
    1c64:	79 27                	jns    1c8d <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1c66:	e8 75 f8 ff ff       	call   14e0 <getpid>
    1c6b:	8b 55 08             	mov    0x8(%ebp),%edx
    1c6e:	83 c2 08             	add    $0x8,%edx
    1c71:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c75:	89 14 24             	mov    %edx,(%esp)
    1c78:	e8 c9 fe ff ff       	call   1b46 <add_q>
		lock_release(&s->lock); 
    1c7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c80:	89 04 24             	mov    %eax,(%esp)
    1c83:	e8 87 fd ff ff       	call   1a0f <lock_release>
		tsleep(); 
    1c88:	e8 83 f8 ff ff       	call   1510 <tsleep>
	} 
	lock_release(&s->lock); 
    1c8d:	8b 45 08             	mov    0x8(%ebp),%eax
    1c90:	89 04 24             	mov    %eax,(%esp)
    1c93:	e8 77 fd ff ff       	call   1a0f <lock_release>
}
    1c98:	c9                   	leave  
    1c99:	c3                   	ret    

00001c9a <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1c9a:	55                   	push   %ebp
    1c9b:	89 e5                	mov    %esp,%ebp
    1c9d:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1ca0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca3:	89 04 24             	mov    %eax,(%esp)
    1ca6:	e8 45 fd ff ff       	call   19f0 <lock_acquire>
	s->count++; 
    1cab:	8b 45 08             	mov    0x8(%ebp),%eax
    1cae:	8b 40 04             	mov    0x4(%eax),%eax
    1cb1:	8d 50 01             	lea    0x1(%eax),%edx
    1cb4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb7:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1cba:	8b 45 08             	mov    0x8(%ebp),%eax
    1cbd:	8b 40 04             	mov    0x4(%eax),%eax
    1cc0:	85 c0                	test   %eax,%eax
    1cc2:	7f 1c                	jg     1ce0 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1cc4:	8b 45 08             	mov    0x8(%ebp),%eax
    1cc7:	83 c0 08             	add    $0x8,%eax
    1cca:	89 04 24             	mov    %eax,(%esp)
    1ccd:	e8 ee fe ff ff       	call   1bc0 <pop_q>
    1cd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cd8:	89 04 24             	mov    %eax,(%esp)
    1cdb:	e8 38 f8 ff ff       	call   1518 <twakeup>
	}
	lock_release(&s->lock); 
    1ce0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce3:	89 04 24             	mov    %eax,(%esp)
    1ce6:	e8 24 fd ff ff       	call   1a0f <lock_release>
} 
    1ceb:	c9                   	leave  
    1cec:	c3                   	ret    

00001ced <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1ced:	55                   	push   %ebp
    1cee:	89 e5                	mov    %esp,%ebp
    1cf0:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	89 04 24             	mov    %eax,(%esp)
    1cf9:	e8 e4 fc ff ff       	call   19e2 <lock_init>
	s->count = size; 
    1cfe:	8b 45 08             	mov    0x8(%ebp),%eax
    1d01:	8b 55 0c             	mov    0xc(%ebp),%edx
    1d04:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1d07:	8b 45 08             	mov    0x8(%ebp),%eax
    1d0a:	83 c0 08             	add    $0x8,%eax
    1d0d:	89 04 24             	mov    %eax,(%esp)
    1d10:	e8 0f fe ff ff       	call   1b24 <init_q>
}
    1d15:	c9                   	leave  
    1d16:	c3                   	ret    
