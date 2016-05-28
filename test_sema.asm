
_test_sema:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
void test_func2(void *arg); 
struct Semaphore s;
int var = 7;
int var1 = 8;

int main(){ 
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
 
	sem_init(&s,1);	
   9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10:	00 
  11:	c7 04 24 84 0c 00 00 	movl   $0xc84,(%esp)
  18:	e8 ca 0b 00 00       	call   be7 <sem_init>
	void* tid = thread_create(test_func,(void *)&var);
  1d:	c7 44 24 04 58 0c 00 	movl   $0xc58,0x4(%esp)
  24:	00 
  25:	c7 04 24 74 00 00 00 	movl   $0x74,(%esp)
  2c:	e8 f5 08 00 00       	call   926 <thread_create>
  31:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(tid == 0) exit(); 
  35:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  3a:	75 05                	jne    41 <main+0x41>
  3c:	e8 23 03 00 00       	call   364 <exit>
	wait(); 
  41:	e8 26 03 00 00       	call   36c <wait>
	void* yid = thread_create(test_func2,(void *)&var1);  
  46:	c7 44 24 04 5c 0c 00 	movl   $0xc5c,0x4(%esp)
  4d:	00 
  4e:	c7 04 24 ba 00 00 00 	movl   $0xba,(%esp)
  55:	e8 cc 08 00 00       	call   926 <thread_create>
  5a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(yid == 0) exit(); 
  5e:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  63:	75 05                	jne    6a <main+0x6a>
  65:	e8 fa 02 00 00       	call   364 <exit>
	wait();
  6a:	e8 fd 02 00 00       	call   36c <wait>

	exit();  
  6f:	e8 f0 02 00 00       	call   364 <exit>

00000074 <test_func>:
	return 0; 
}

void test_func(void *arg) {
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	83 ec 28             	sub    $0x28,%esp
	int* num = (void*)arg;  
  7a:	8b 45 08             	mov    0x8(%ebp),%eax
  7d:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sem_acquire(&s); 
  80:	c7 04 24 84 0c 00 00 	movl   $0xc84,(%esp)
  87:	e8 ac 0a 00 00       	call   b38 <sem_acquire>
	printf(1,"hi %d.\n",*num);		
  8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8f:	8b 00                	mov    (%eax),%eax
  91:	89 44 24 08          	mov    %eax,0x8(%esp)
  95:	c7 44 24 04 11 0c 00 	movl   $0xc11,0x4(%esp)
  9c:	00 
  9d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a4:	e8 54 04 00 00       	call   4fd <printf>
	sem_signal(&s); 
  a9:	c7 04 24 84 0c 00 00 	movl   $0xc84,(%esp)
  b0:	e8 e0 0a 00 00       	call   b95 <sem_signal>

	texit(); 
  b5:	e8 52 03 00 00       	call   40c <texit>

000000ba <test_func2>:
} 

void test_func2(void *arg) {
  ba:	55                   	push   %ebp
  bb:	89 e5                	mov    %esp,%ebp
  bd:	83 ec 28             	sub    $0x28,%esp
	int* num = (void*)arg;
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	
	sem_acquire(&s);  
  c6:	c7 04 24 84 0c 00 00 	movl   $0xc84,(%esp)
  cd:	e8 66 0a 00 00       	call   b38 <sem_acquire>
	printf(1,"hey %d.\n",*num); 
  d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d5:	8b 00                	mov    (%eax),%eax
  d7:	89 44 24 08          	mov    %eax,0x8(%esp)
  db:	c7 44 24 04 19 0c 00 	movl   $0xc19,0x4(%esp)
  e2:	00 
  e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ea:	e8 0e 04 00 00       	call   4fd <printf>
	sem_signal(&s); 
  ef:	c7 04 24 84 0c 00 00 	movl   $0xc84,(%esp)
  f6:	e8 9a 0a 00 00       	call   b95 <sem_signal>

	texit(); 
  fb:	e8 0c 03 00 00       	call   40c <texit>

00000100 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	57                   	push   %edi
 104:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 105:	8b 4d 08             	mov    0x8(%ebp),%ecx
 108:	8b 55 10             	mov    0x10(%ebp),%edx
 10b:	8b 45 0c             	mov    0xc(%ebp),%eax
 10e:	89 cb                	mov    %ecx,%ebx
 110:	89 df                	mov    %ebx,%edi
 112:	89 d1                	mov    %edx,%ecx
 114:	fc                   	cld    
 115:	f3 aa                	rep stos %al,%es:(%edi)
 117:	89 ca                	mov    %ecx,%edx
 119:	89 fb                	mov    %edi,%ebx
 11b:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 121:	5b                   	pop    %ebx
 122:	5f                   	pop    %edi
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    

00000125 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12b:	8b 45 08             	mov    0x8(%ebp),%eax
 12e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 131:	8b 45 0c             	mov    0xc(%ebp),%eax
 134:	0f b6 10             	movzbl (%eax),%edx
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	88 10                	mov    %dl,(%eax)
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	84 c0                	test   %al,%al
 144:	0f 95 c0             	setne  %al
 147:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 14b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 14f:	84 c0                	test   %al,%al
 151:	75 de                	jne    131 <strcpy+0xc>
    ;
  return os;
 153:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 156:	c9                   	leave  
 157:	c3                   	ret    

00000158 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 158:	55                   	push   %ebp
 159:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15b:	eb 08                	jmp    165 <strcmp+0xd>
    p++, q++;
 15d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 161:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 165:	8b 45 08             	mov    0x8(%ebp),%eax
 168:	0f b6 00             	movzbl (%eax),%eax
 16b:	84 c0                	test   %al,%al
 16d:	74 10                	je     17f <strcmp+0x27>
 16f:	8b 45 08             	mov    0x8(%ebp),%eax
 172:	0f b6 10             	movzbl (%eax),%edx
 175:	8b 45 0c             	mov    0xc(%ebp),%eax
 178:	0f b6 00             	movzbl (%eax),%eax
 17b:	38 c2                	cmp    %al,%dl
 17d:	74 de                	je     15d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	0f b6 00             	movzbl (%eax),%eax
 185:	0f b6 d0             	movzbl %al,%edx
 188:	8b 45 0c             	mov    0xc(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	0f b6 c0             	movzbl %al,%eax
 191:	89 d1                	mov    %edx,%ecx
 193:	29 c1                	sub    %eax,%ecx
 195:	89 c8                	mov    %ecx,%eax
}
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    

00000199 <strlen>:

uint
strlen(char *s)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 19f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a6:	eb 04                	jmp    1ac <strlen+0x13>
 1a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1af:	03 45 08             	add    0x8(%ebp),%eax
 1b2:	0f b6 00             	movzbl (%eax),%eax
 1b5:	84 c0                	test   %al,%al
 1b7:	75 ef                	jne    1a8 <strlen+0xf>
    ;
  return n;
 1b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bc:	c9                   	leave  
 1bd:	c3                   	ret    

000001be <memset>:

void*
memset(void *dst, int c, uint n)
{
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1c4:	8b 45 10             	mov    0x10(%ebp),%eax
 1c7:	89 44 24 08          	mov    %eax,0x8(%esp)
 1cb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ce:	89 44 24 04          	mov    %eax,0x4(%esp)
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
 1d5:	89 04 24             	mov    %eax,(%esp)
 1d8:	e8 23 ff ff ff       	call   100 <stosb>
  return dst;
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e0:	c9                   	leave  
 1e1:	c3                   	ret    

000001e2 <strchr>:

char*
strchr(const char *s, char c)
{
 1e2:	55                   	push   %ebp
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	83 ec 04             	sub    $0x4,%esp
 1e8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1eb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ee:	eb 14                	jmp    204 <strchr+0x22>
    if(*s == c)
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	0f b6 00             	movzbl (%eax),%eax
 1f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1f9:	75 05                	jne    200 <strchr+0x1e>
      return (char*)s;
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	eb 13                	jmp    213 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 200:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	84 c0                	test   %al,%al
 20c:	75 e2                	jne    1f0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 20e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 213:	c9                   	leave  
 214:	c3                   	ret    

00000215 <gets>:

char*
gets(char *buf, int max)
{
 215:	55                   	push   %ebp
 216:	89 e5                	mov    %esp,%ebp
 218:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 222:	eb 44                	jmp    268 <gets+0x53>
    cc = read(0, &c, 1);
 224:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 22b:	00 
 22c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 22f:	89 44 24 04          	mov    %eax,0x4(%esp)
 233:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 23a:	e8 3d 01 00 00       	call   37c <read>
 23f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
 242:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 246:	7e 2d                	jle    275 <gets+0x60>
      break;
    buf[i++] = c;
 248:	8b 45 f0             	mov    -0x10(%ebp),%eax
 24b:	03 45 08             	add    0x8(%ebp),%eax
 24e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 252:	88 10                	mov    %dl,(%eax)
 254:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
 258:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25c:	3c 0a                	cmp    $0xa,%al
 25e:	74 16                	je     276 <gets+0x61>
 260:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 264:	3c 0d                	cmp    $0xd,%al
 266:	74 0e                	je     276 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 268:	8b 45 f0             	mov    -0x10(%ebp),%eax
 26b:	83 c0 01             	add    $0x1,%eax
 26e:	3b 45 0c             	cmp    0xc(%ebp),%eax
 271:	7c b1                	jl     224 <gets+0xf>
 273:	eb 01                	jmp    276 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 275:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 276:	8b 45 f0             	mov    -0x10(%ebp),%eax
 279:	03 45 08             	add    0x8(%ebp),%eax
 27c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <stat>:

int
stat(char *n, struct stat *st)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 291:	00 
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	89 04 24             	mov    %eax,(%esp)
 298:	e8 07 01 00 00       	call   3a4 <open>
 29d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
 2a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2a4:	79 07                	jns    2ad <stat+0x29>
    return -1;
 2a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ab:	eb 23                	jmp    2d0 <stat+0x4c>
  r = fstat(fd, st);
 2ad:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b0:	89 44 24 04          	mov    %eax,0x4(%esp)
 2b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2b7:	89 04 24             	mov    %eax,(%esp)
 2ba:	e8 fd 00 00 00       	call   3bc <fstat>
 2bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
 2c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2c5:	89 04 24             	mov    %eax,(%esp)
 2c8:	e8 bf 00 00 00       	call   38c <close>
  return r;
 2cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <atoi>:

int
atoi(const char *s)
{
 2d2:	55                   	push   %ebp
 2d3:	89 e5                	mov    %esp,%ebp
 2d5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2df:	eb 24                	jmp    305 <atoi+0x33>
    n = n*10 + *s++ - '0';
 2e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e4:	89 d0                	mov    %edx,%eax
 2e6:	c1 e0 02             	shl    $0x2,%eax
 2e9:	01 d0                	add    %edx,%eax
 2eb:	01 c0                	add    %eax,%eax
 2ed:	89 c2                	mov    %eax,%edx
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	0f b6 00             	movzbl (%eax),%eax
 2f5:	0f be c0             	movsbl %al,%eax
 2f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
 2fb:	83 e8 30             	sub    $0x30,%eax
 2fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
 301:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	0f b6 00             	movzbl (%eax),%eax
 30b:	3c 2f                	cmp    $0x2f,%al
 30d:	7e 0a                	jle    319 <atoi+0x47>
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	0f b6 00             	movzbl (%eax),%eax
 315:	3c 39                	cmp    $0x39,%al
 317:	7e c8                	jle    2e1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 319:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 31c:	c9                   	leave  
 31d:	c3                   	ret    

0000031e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31e:	55                   	push   %ebp
 31f:	89 e5                	mov    %esp,%ebp
 321:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
 32a:	8b 45 0c             	mov    0xc(%ebp),%eax
 32d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
 330:	eb 13                	jmp    345 <memmove+0x27>
    *dst++ = *src++;
 332:	8b 45 fc             	mov    -0x4(%ebp),%eax
 335:	0f b6 10             	movzbl (%eax),%edx
 338:	8b 45 f8             	mov    -0x8(%ebp),%eax
 33b:	88 10                	mov    %dl,(%eax)
 33d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 341:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 345:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 349:	0f 9f c0             	setg   %al
 34c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 350:	84 c0                	test   %al,%al
 352:	75 de                	jne    332 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 354:	8b 45 08             	mov    0x8(%ebp),%eax
}
 357:	c9                   	leave  
 358:	c3                   	ret    
 359:	90                   	nop
 35a:	90                   	nop
 35b:	90                   	nop

0000035c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35c:	b8 01 00 00 00       	mov    $0x1,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <exit>:
SYSCALL(exit)
 364:	b8 02 00 00 00       	mov    $0x2,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <wait>:
SYSCALL(wait)
 36c:	b8 03 00 00 00       	mov    $0x3,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <pipe>:
SYSCALL(pipe)
 374:	b8 04 00 00 00       	mov    $0x4,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <read>:
SYSCALL(read)
 37c:	b8 05 00 00 00       	mov    $0x5,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <write>:
SYSCALL(write)
 384:	b8 10 00 00 00       	mov    $0x10,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <close>:
SYSCALL(close)
 38c:	b8 15 00 00 00       	mov    $0x15,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <kill>:
SYSCALL(kill)
 394:	b8 06 00 00 00       	mov    $0x6,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <exec>:
SYSCALL(exec)
 39c:	b8 07 00 00 00       	mov    $0x7,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <open>:
SYSCALL(open)
 3a4:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <mknod>:
SYSCALL(mknod)
 3ac:	b8 11 00 00 00       	mov    $0x11,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <unlink>:
SYSCALL(unlink)
 3b4:	b8 12 00 00 00       	mov    $0x12,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <fstat>:
SYSCALL(fstat)
 3bc:	b8 08 00 00 00       	mov    $0x8,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <link>:
SYSCALL(link)
 3c4:	b8 13 00 00 00       	mov    $0x13,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <mkdir>:
SYSCALL(mkdir)
 3cc:	b8 14 00 00 00       	mov    $0x14,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <chdir>:
SYSCALL(chdir)
 3d4:	b8 09 00 00 00       	mov    $0x9,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <dup>:
SYSCALL(dup)
 3dc:	b8 0a 00 00 00       	mov    $0xa,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <getpid>:
SYSCALL(getpid)
 3e4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <sbrk>:
SYSCALL(sbrk)
 3ec:	b8 0c 00 00 00       	mov    $0xc,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <sleep>:
SYSCALL(sleep)
 3f4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <uptime>:
SYSCALL(uptime)
 3fc:	b8 0e 00 00 00       	mov    $0xe,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <clone>:
SYSCALL(clone)
 404:	b8 16 00 00 00       	mov    $0x16,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <texit>:
SYSCALL(texit)
 40c:	b8 17 00 00 00       	mov    $0x17,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <tsleep>:
SYSCALL(tsleep)
 414:	b8 18 00 00 00       	mov    $0x18,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <twakeup>:
SYSCALL(twakeup)
 41c:	b8 19 00 00 00       	mov    $0x19,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 424:	55                   	push   %ebp
 425:	89 e5                	mov    %esp,%ebp
 427:	83 ec 28             	sub    $0x28,%esp
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 430:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 437:	00 
 438:	8d 45 f4             	lea    -0xc(%ebp),%eax
 43b:	89 44 24 04          	mov    %eax,0x4(%esp)
 43f:	8b 45 08             	mov    0x8(%ebp),%eax
 442:	89 04 24             	mov    %eax,(%esp)
 445:	e8 3a ff ff ff       	call   384 <write>
}
 44a:	c9                   	leave  
 44b:	c3                   	ret    

0000044c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 44c:	55                   	push   %ebp
 44d:	89 e5                	mov    %esp,%ebp
 44f:	53                   	push   %ebx
 450:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 453:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 45a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 45e:	74 17                	je     477 <printint+0x2b>
 460:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 464:	79 11                	jns    477 <printint+0x2b>
    neg = 1;
 466:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 46d:	8b 45 0c             	mov    0xc(%ebp),%eax
 470:	f7 d8                	neg    %eax
 472:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 475:	eb 06                	jmp    47d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 477:	8b 45 0c             	mov    0xc(%ebp),%eax
 47a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
 47d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
 484:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 487:	8b 5d 10             	mov    0x10(%ebp),%ebx
 48a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48d:	ba 00 00 00 00       	mov    $0x0,%edx
 492:	f7 f3                	div    %ebx
 494:	89 d0                	mov    %edx,%eax
 496:	0f b6 80 60 0c 00 00 	movzbl 0xc60(%eax),%eax
 49d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 4a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
 4a5:	8b 45 10             	mov    0x10(%ebp),%eax
 4a8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ae:	ba 00 00 00 00       	mov    $0x0,%edx
 4b3:	f7 75 d4             	divl   -0x2c(%ebp)
 4b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bd:	75 c5                	jne    484 <printint+0x38>
  if(neg)
 4bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4c3:	74 28                	je     4ed <printint+0xa1>
    buf[i++] = '-';
 4c5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4c8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 4cd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
 4d1:	eb 1a                	jmp    4ed <printint+0xa1>
    putc(fd, buf[i]);
 4d3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
 4db:	0f be c0             	movsbl %al,%eax
 4de:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e2:	8b 45 08             	mov    0x8(%ebp),%eax
 4e5:	89 04 24             	mov    %eax,(%esp)
 4e8:	e8 37 ff ff ff       	call   424 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4ed:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
 4f1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f5:	79 dc                	jns    4d3 <printint+0x87>
    putc(fd, buf[i]);
}
 4f7:	83 c4 44             	add    $0x44,%esp
 4fa:	5b                   	pop    %ebx
 4fb:	5d                   	pop    %ebp
 4fc:	c3                   	ret    

000004fd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4fd:	55                   	push   %ebp
 4fe:	89 e5                	mov    %esp,%ebp
 500:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 503:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 50a:	8d 45 0c             	lea    0xc(%ebp),%eax
 50d:	83 c0 04             	add    $0x4,%eax
 510:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
 513:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 51a:	e9 7e 01 00 00       	jmp    69d <printf+0x1a0>
    c = fmt[i] & 0xff;
 51f:	8b 55 0c             	mov    0xc(%ebp),%edx
 522:	8b 45 ec             	mov    -0x14(%ebp),%eax
 525:	8d 04 02             	lea    (%edx,%eax,1),%eax
 528:	0f b6 00             	movzbl (%eax),%eax
 52b:	0f be c0             	movsbl %al,%eax
 52e:	25 ff 00 00 00       	and    $0xff,%eax
 533:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
 536:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 53a:	75 2c                	jne    568 <printf+0x6b>
      if(c == '%'){
 53c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 540:	75 0c                	jne    54e <printf+0x51>
        state = '%';
 542:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
 549:	e9 4b 01 00 00       	jmp    699 <printf+0x19c>
      } else {
        putc(fd, c);
 54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 551:	0f be c0             	movsbl %al,%eax
 554:	89 44 24 04          	mov    %eax,0x4(%esp)
 558:	8b 45 08             	mov    0x8(%ebp),%eax
 55b:	89 04 24             	mov    %eax,(%esp)
 55e:	e8 c1 fe ff ff       	call   424 <putc>
 563:	e9 31 01 00 00       	jmp    699 <printf+0x19c>
      }
    } else if(state == '%'){
 568:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
 56c:	0f 85 27 01 00 00    	jne    699 <printf+0x19c>
      if(c == 'd'){
 572:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
 576:	75 2d                	jne    5a5 <printf+0xa8>
        printint(fd, *ap, 10, 1);
 578:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57b:	8b 00                	mov    (%eax),%eax
 57d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 584:	00 
 585:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 58c:	00 
 58d:	89 44 24 04          	mov    %eax,0x4(%esp)
 591:	8b 45 08             	mov    0x8(%ebp),%eax
 594:	89 04 24             	mov    %eax,(%esp)
 597:	e8 b0 fe ff ff       	call   44c <printint>
        ap++;
 59c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 5a0:	e9 ed 00 00 00       	jmp    692 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
 5a5:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
 5a9:	74 06                	je     5b1 <printf+0xb4>
 5ab:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
 5af:	75 2d                	jne    5de <printf+0xe1>
        printint(fd, *ap, 16, 0);
 5b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b4:	8b 00                	mov    (%eax),%eax
 5b6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 5bd:	00 
 5be:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 5c5:	00 
 5c6:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ca:	8b 45 08             	mov    0x8(%ebp),%eax
 5cd:	89 04 24             	mov    %eax,(%esp)
 5d0:	e8 77 fe ff ff       	call   44c <printint>
        ap++;
 5d5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d9:	e9 b4 00 00 00       	jmp    692 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5de:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
 5e2:	75 46                	jne    62a <printf+0x12d>
        s = (char*)*ap;
 5e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
 5ec:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
 5f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 5f4:	75 27                	jne    61d <printf+0x120>
          s = "(null)";
 5f6:	c7 45 e4 22 0c 00 00 	movl   $0xc22,-0x1c(%ebp)
        while(*s != 0){
 5fd:	eb 1f                	jmp    61e <printf+0x121>
          putc(fd, *s);
 5ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 602:	0f b6 00             	movzbl (%eax),%eax
 605:	0f be c0             	movsbl %al,%eax
 608:	89 44 24 04          	mov    %eax,0x4(%esp)
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 0d fe ff ff       	call   424 <putc>
          s++;
 617:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 61b:	eb 01                	jmp    61e <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 61d:	90                   	nop
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f b6 00             	movzbl (%eax),%eax
 624:	84 c0                	test   %al,%al
 626:	75 d7                	jne    5ff <printf+0x102>
 628:	eb 68                	jmp    692 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 62a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
 62e:	75 1d                	jne    64d <printf+0x150>
        putc(fd, *ap);
 630:	8b 45 f4             	mov    -0xc(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	0f be c0             	movsbl %al,%eax
 638:	89 44 24 04          	mov    %eax,0x4(%esp)
 63c:	8b 45 08             	mov    0x8(%ebp),%eax
 63f:	89 04 24             	mov    %eax,(%esp)
 642:	e8 dd fd ff ff       	call   424 <putc>
        ap++;
 647:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 64b:	eb 45                	jmp    692 <printf+0x195>
      } else if(c == '%'){
 64d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 651:	75 17                	jne    66a <printf+0x16d>
        putc(fd, c);
 653:	8b 45 e8             	mov    -0x18(%ebp),%eax
 656:	0f be c0             	movsbl %al,%eax
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	89 04 24             	mov    %eax,(%esp)
 663:	e8 bc fd ff ff       	call   424 <putc>
 668:	eb 28                	jmp    692 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 66a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 671:	00 
 672:	8b 45 08             	mov    0x8(%ebp),%eax
 675:	89 04 24             	mov    %eax,(%esp)
 678:	e8 a7 fd ff ff       	call   424 <putc>
        putc(fd, c);
 67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 680:	0f be c0             	movsbl %al,%eax
 683:	89 44 24 04          	mov    %eax,0x4(%esp)
 687:	8b 45 08             	mov    0x8(%ebp),%eax
 68a:	89 04 24             	mov    %eax,(%esp)
 68d:	e8 92 fd ff ff       	call   424 <putc>
      }
      state = 0;
 692:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 699:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 69d:	8b 55 0c             	mov    0xc(%ebp),%edx
 6a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6a3:	8d 04 02             	lea    (%edx,%eax,1),%eax
 6a6:	0f b6 00             	movzbl (%eax),%eax
 6a9:	84 c0                	test   %al,%al
 6ab:	0f 85 6e fe ff ff    	jne    51f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6b1:	c9                   	leave  
 6b2:	c3                   	ret    
 6b3:	90                   	nop

000006b4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ba:	8b 45 08             	mov    0x8(%ebp),%eax
 6bd:	83 e8 08             	sub    $0x8,%eax
 6c0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c3:	a1 80 0c 00 00       	mov    0xc80,%eax
 6c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6cb:	eb 24                	jmp    6f1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 00                	mov    (%eax),%eax
 6d2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6d5:	77 12                	ja     6e9 <free+0x35>
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6dd:	77 24                	ja     703 <free+0x4f>
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 00                	mov    (%eax),%eax
 6e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e7:	77 1a                	ja     703 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 00                	mov    (%eax),%eax
 6ee:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f7:	76 d4                	jbe    6cd <free+0x19>
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	8b 00                	mov    (%eax),%eax
 6fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 701:	76 ca                	jbe    6cd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	8b 40 04             	mov    0x4(%eax),%eax
 709:	c1 e0 03             	shl    $0x3,%eax
 70c:	89 c2                	mov    %eax,%edx
 70e:	03 55 f8             	add    -0x8(%ebp),%edx
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 00                	mov    (%eax),%eax
 716:	39 c2                	cmp    %eax,%edx
 718:	75 24                	jne    73e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 71a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71d:	8b 50 04             	mov    0x4(%eax),%edx
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	8b 00                	mov    (%eax),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	01 c2                	add    %eax,%edx
 72a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 730:	8b 45 fc             	mov    -0x4(%ebp),%eax
 733:	8b 00                	mov    (%eax),%eax
 735:	8b 10                	mov    (%eax),%edx
 737:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73a:	89 10                	mov    %edx,(%eax)
 73c:	eb 0a                	jmp    748 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 73e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 741:	8b 10                	mov    (%eax),%edx
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 748:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74b:	8b 40 04             	mov    0x4(%eax),%eax
 74e:	c1 e0 03             	shl    $0x3,%eax
 751:	03 45 fc             	add    -0x4(%ebp),%eax
 754:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 757:	75 20                	jne    779 <free+0xc5>
    p->s.size += bp->s.size;
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 50 04             	mov    0x4(%eax),%edx
 75f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 762:	8b 40 04             	mov    0x4(%eax),%eax
 765:	01 c2                	add    %eax,%edx
 767:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 76d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 770:	8b 10                	mov    (%eax),%edx
 772:	8b 45 fc             	mov    -0x4(%ebp),%eax
 775:	89 10                	mov    %edx,(%eax)
 777:	eb 08                	jmp    781 <free+0xcd>
  } else
    p->s.ptr = bp;
 779:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 77f:	89 10                	mov    %edx,(%eax)
  freep = p;
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	a3 80 0c 00 00       	mov    %eax,0xc80
}
 789:	c9                   	leave  
 78a:	c3                   	ret    

0000078b <morecore>:

static Header*
morecore(uint nu)
{
 78b:	55                   	push   %ebp
 78c:	89 e5                	mov    %esp,%ebp
 78e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 791:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 798:	77 07                	ja     7a1 <morecore+0x16>
    nu = 4096;
 79a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7a1:	8b 45 08             	mov    0x8(%ebp),%eax
 7a4:	c1 e0 03             	shl    $0x3,%eax
 7a7:	89 04 24             	mov    %eax,(%esp)
 7aa:	e8 3d fc ff ff       	call   3ec <sbrk>
 7af:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
 7b2:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
 7b6:	75 07                	jne    7bf <morecore+0x34>
    return 0;
 7b8:	b8 00 00 00 00       	mov    $0x0,%eax
 7bd:	eb 22                	jmp    7e1 <morecore+0x56>
  hp = (Header*)p;
 7bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 55 08             	mov    0x8(%ebp),%edx
 7cb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d1:	83 c0 08             	add    $0x8,%eax
 7d4:	89 04 24             	mov    %eax,(%esp)
 7d7:	e8 d8 fe ff ff       	call   6b4 <free>
  return freep;
 7dc:	a1 80 0c 00 00       	mov    0xc80,%eax
}
 7e1:	c9                   	leave  
 7e2:	c3                   	ret    

000007e3 <malloc>:

void*
malloc(uint nbytes)
{
 7e3:	55                   	push   %ebp
 7e4:	89 e5                	mov    %esp,%ebp
 7e6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ec:	83 c0 07             	add    $0x7,%eax
 7ef:	c1 e8 03             	shr    $0x3,%eax
 7f2:	83 c0 01             	add    $0x1,%eax
 7f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
 7f8:	a1 80 0c 00 00       	mov    0xc80,%eax
 7fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 800:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 804:	75 23                	jne    829 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 806:	c7 45 f0 78 0c 00 00 	movl   $0xc78,-0x10(%ebp)
 80d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 810:	a3 80 0c 00 00       	mov    %eax,0xc80
 815:	a1 80 0c 00 00       	mov    0xc80,%eax
 81a:	a3 78 0c 00 00       	mov    %eax,0xc78
    base.s.size = 0;
 81f:	c7 05 7c 0c 00 00 00 	movl   $0x0,0xc7c
 826:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 829:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82c:	8b 00                	mov    (%eax),%eax
 82e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
 831:	8b 45 ec             	mov    -0x14(%ebp),%eax
 834:	8b 40 04             	mov    0x4(%eax),%eax
 837:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 83a:	72 4d                	jb     889 <malloc+0xa6>
      if(p->s.size == nunits)
 83c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 83f:	8b 40 04             	mov    0x4(%eax),%eax
 842:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 845:	75 0c                	jne    853 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 847:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84a:	8b 10                	mov    (%eax),%edx
 84c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84f:	89 10                	mov    %edx,(%eax)
 851:	eb 26                	jmp    879 <malloc+0x96>
      else {
        p->s.size -= nunits;
 853:	8b 45 ec             	mov    -0x14(%ebp),%eax
 856:	8b 40 04             	mov    0x4(%eax),%eax
 859:	89 c2                	mov    %eax,%edx
 85b:	2b 55 f4             	sub    -0xc(%ebp),%edx
 85e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 861:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 864:	8b 45 ec             	mov    -0x14(%ebp),%eax
 867:	8b 40 04             	mov    0x4(%eax),%eax
 86a:	c1 e0 03             	shl    $0x3,%eax
 86d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
 870:	8b 45 ec             	mov    -0x14(%ebp),%eax
 873:	8b 55 f4             	mov    -0xc(%ebp),%edx
 876:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 879:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87c:	a3 80 0c 00 00       	mov    %eax,0xc80
      return (void*)(p + 1);
 881:	8b 45 ec             	mov    -0x14(%ebp),%eax
 884:	83 c0 08             	add    $0x8,%eax
 887:	eb 38                	jmp    8c1 <malloc+0xde>
    }
    if(p == freep)
 889:	a1 80 0c 00 00       	mov    0xc80,%eax
 88e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 891:	75 1b                	jne    8ae <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	89 04 24             	mov    %eax,(%esp)
 899:	e8 ed fe ff ff       	call   78b <morecore>
 89e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 8a5:	75 07                	jne    8ae <malloc+0xcb>
        return 0;
 8a7:	b8 00 00 00 00       	mov    $0x0,%eax
 8ac:	eb 13                	jmp    8c1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8b7:	8b 00                	mov    (%eax),%eax
 8b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8bc:	e9 70 ff ff ff       	jmp    831 <malloc+0x4e>
}
 8c1:	c9                   	leave  
 8c2:	c3                   	ret    
 8c3:	90                   	nop

000008c4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 8c4:	55                   	push   %ebp
 8c5:	89 e5                	mov    %esp,%ebp
 8c7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 8ca:	8b 55 08             	mov    0x8(%ebp),%edx
 8cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 8d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
 8d3:	f0 87 02             	lock xchg %eax,(%edx)
 8d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 8d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 8dc:	c9                   	leave  
 8dd:	c3                   	ret    

000008de <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
 8de:	55                   	push   %ebp
 8df:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
 8e1:	8b 45 08             	mov    0x8(%ebp),%eax
 8e4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 8ea:	5d                   	pop    %ebp
 8eb:	c3                   	ret    

000008ec <lock_acquire>:
void lock_acquire(lock_t *lock){
 8ec:	55                   	push   %ebp
 8ed:	89 e5                	mov    %esp,%ebp
 8ef:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
 8f2:	8b 45 08             	mov    0x8(%ebp),%eax
 8f5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 8fc:	00 
 8fd:	89 04 24             	mov    %eax,(%esp)
 900:	e8 bf ff ff ff       	call   8c4 <xchg>
 905:	85 c0                	test   %eax,%eax
 907:	75 e9                	jne    8f2 <lock_acquire+0x6>
}
 909:	c9                   	leave  
 90a:	c3                   	ret    

0000090b <lock_release>:
void lock_release(lock_t *lock){
 90b:	55                   	push   %ebp
 90c:	89 e5                	mov    %esp,%ebp
 90e:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
 911:	8b 45 08             	mov    0x8(%ebp),%eax
 914:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 91b:	00 
 91c:	89 04 24             	mov    %eax,(%esp)
 91f:	e8 a0 ff ff ff       	call   8c4 <xchg>
}
 924:	c9                   	leave  
 925:	c3                   	ret    

00000926 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
 926:	55                   	push   %ebp
 927:	89 e5                	mov    %esp,%ebp
 929:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
 92c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 933:	e8 ab fe ff ff       	call   7e3 <malloc>
 938:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
 93b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93e:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
 941:	8b 45 f0             	mov    -0x10(%ebp),%eax
 944:	25 ff 0f 00 00       	and    $0xfff,%eax
 949:	85 c0                	test   %eax,%eax
 94b:	74 15                	je     962 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
 94d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 950:	89 c2                	mov    %eax,%edx
 952:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
 958:	b8 00 10 00 00       	mov    $0x1000,%eax
 95d:	29 d0                	sub    %edx,%eax
 95f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
 962:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 966:	75 1b                	jne    983 <thread_create+0x5d>

        printf(1,"malloc fail \n");
 968:	c7 44 24 04 29 0c 00 	movl   $0xc29,0x4(%esp)
 96f:	00 
 970:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 977:	e8 81 fb ff ff       	call   4fd <printf>
        return 0;
 97c:	b8 00 00 00 00       	mov    $0x0,%eax
 981:	eb 6f                	jmp    9f2 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
 983:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 986:	8b 55 08             	mov    0x8(%ebp),%edx
 989:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 990:	89 54 24 08          	mov    %edx,0x8(%esp)
 994:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 99b:	00 
 99c:	89 04 24             	mov    %eax,(%esp)
 99f:	e8 60 fa ff ff       	call   404 <clone>
 9a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
 9a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9ab:	79 1b                	jns    9c8 <thread_create+0xa2>
        printf(1,"clone fails\n");
 9ad:	c7 44 24 04 37 0c 00 	movl   $0xc37,0x4(%esp)
 9b4:	00 
 9b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9bc:	e8 3c fb ff ff       	call   4fd <printf>
        return 0;
 9c1:	b8 00 00 00 00       	mov    $0x0,%eax
 9c6:	eb 2a                	jmp    9f2 <thread_create+0xcc>
    }
    if(tid > 0){
 9c8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9cc:	7e 05                	jle    9d3 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
 9ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9d1:	eb 1f                	jmp    9f2 <thread_create+0xcc>
    }
    if(tid == 0){
 9d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9d7:	75 14                	jne    9ed <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
 9d9:	c7 44 24 04 44 0c 00 	movl   $0xc44,0x4(%esp)
 9e0:	00 
 9e1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9e8:	e8 10 fb ff ff       	call   4fd <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
 9ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
 9f2:	c9                   	leave  
 9f3:	c3                   	ret    

000009f4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
 9f4:	55                   	push   %ebp
 9f5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
 9f7:	a1 74 0c 00 00       	mov    0xc74,%eax
 9fc:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
 a02:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
 a07:	a3 74 0c 00 00       	mov    %eax,0xc74
    return (int)(rands % max);
 a0c:	a1 74 0c 00 00       	mov    0xc74,%eax
 a11:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a14:	ba 00 00 00 00       	mov    $0x0,%edx
 a19:	f7 f1                	div    %ecx
 a1b:	89 d0                	mov    %edx,%eax
}
 a1d:	5d                   	pop    %ebp
 a1e:	c3                   	ret    
 a1f:	90                   	nop

00000a20 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
    q->size = 0;
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
 a26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
 a2c:	8b 45 08             	mov    0x8(%ebp),%eax
 a2f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
 a36:	8b 45 08             	mov    0x8(%ebp),%eax
 a39:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
 a40:	5d                   	pop    %ebp
 a41:	c3                   	ret    

00000a42 <add_q>:

void add_q(struct queue *q, int v){
 a42:	55                   	push   %ebp
 a43:	89 e5                	mov    %esp,%ebp
 a45:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
 a48:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 a4f:	e8 8f fd ff ff       	call   7e3 <malloc>
 a54:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
 a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	8b 55 0c             	mov    0xc(%ebp),%edx
 a67:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
 a69:	8b 45 08             	mov    0x8(%ebp),%eax
 a6c:	8b 40 04             	mov    0x4(%eax),%eax
 a6f:	85 c0                	test   %eax,%eax
 a71:	75 0b                	jne    a7e <add_q+0x3c>
        q->head = n;
 a73:	8b 45 08             	mov    0x8(%ebp),%eax
 a76:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a79:	89 50 04             	mov    %edx,0x4(%eax)
 a7c:	eb 0c                	jmp    a8a <add_q+0x48>
    }else{
        q->tail->next = n;
 a7e:	8b 45 08             	mov    0x8(%ebp),%eax
 a81:	8b 40 08             	mov    0x8(%eax),%eax
 a84:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a87:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
 a8a:	8b 45 08             	mov    0x8(%ebp),%eax
 a8d:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a90:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
 a93:	8b 45 08             	mov    0x8(%ebp),%eax
 a96:	8b 00                	mov    (%eax),%eax
 a98:	8d 50 01             	lea    0x1(%eax),%edx
 a9b:	8b 45 08             	mov    0x8(%ebp),%eax
 a9e:	89 10                	mov    %edx,(%eax)
}
 aa0:	c9                   	leave  
 aa1:	c3                   	ret    

00000aa2 <empty_q>:

int empty_q(struct queue *q){
 aa2:	55                   	push   %ebp
 aa3:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
 aa5:	8b 45 08             	mov    0x8(%ebp),%eax
 aa8:	8b 00                	mov    (%eax),%eax
 aaa:	85 c0                	test   %eax,%eax
 aac:	75 07                	jne    ab5 <empty_q+0x13>
        return 1;
 aae:	b8 01 00 00 00       	mov    $0x1,%eax
 ab3:	eb 05                	jmp    aba <empty_q+0x18>
    else
        return 0;
 ab5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
 aba:	5d                   	pop    %ebp
 abb:	c3                   	ret    

00000abc <pop_q>:
int pop_q(struct queue *q){
 abc:	55                   	push   %ebp
 abd:	89 e5                	mov    %esp,%ebp
 abf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
 ac2:	8b 45 08             	mov    0x8(%ebp),%eax
 ac5:	89 04 24             	mov    %eax,(%esp)
 ac8:	e8 d5 ff ff ff       	call   aa2 <empty_q>
 acd:	85 c0                	test   %eax,%eax
 acf:	75 5d                	jne    b2e <pop_q+0x72>
       val = q->head->value; 
 ad1:	8b 45 08             	mov    0x8(%ebp),%eax
 ad4:	8b 40 04             	mov    0x4(%eax),%eax
 ad7:	8b 00                	mov    (%eax),%eax
 ad9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
 adc:	8b 45 08             	mov    0x8(%ebp),%eax
 adf:	8b 40 04             	mov    0x4(%eax),%eax
 ae2:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
 ae5:	8b 45 08             	mov    0x8(%ebp),%eax
 ae8:	8b 40 04             	mov    0x4(%eax),%eax
 aeb:	8b 50 04             	mov    0x4(%eax),%edx
 aee:	8b 45 08             	mov    0x8(%ebp),%eax
 af1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
 af4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af7:	89 04 24             	mov    %eax,(%esp)
 afa:	e8 b5 fb ff ff       	call   6b4 <free>
       q->size--;
 aff:	8b 45 08             	mov    0x8(%ebp),%eax
 b02:	8b 00                	mov    (%eax),%eax
 b04:	8d 50 ff             	lea    -0x1(%eax),%edx
 b07:	8b 45 08             	mov    0x8(%ebp),%eax
 b0a:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
 b0c:	8b 45 08             	mov    0x8(%ebp),%eax
 b0f:	8b 00                	mov    (%eax),%eax
 b11:	85 c0                	test   %eax,%eax
 b13:	75 14                	jne    b29 <pop_q+0x6d>
            q->head = 0;
 b15:	8b 45 08             	mov    0x8(%ebp),%eax
 b18:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
 b1f:	8b 45 08             	mov    0x8(%ebp),%eax
 b22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
 b29:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b2c:	eb 05                	jmp    b33 <pop_q+0x77>
    }
    return -1;
 b2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 b33:	c9                   	leave  
 b34:	c3                   	ret    
 b35:	90                   	nop
 b36:	90                   	nop
 b37:	90                   	nop

00000b38 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
 b38:	55                   	push   %ebp
 b39:	89 e5                	mov    %esp,%ebp
 b3b:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock); 
 b3e:	8b 45 08             	mov    0x8(%ebp),%eax
 b41:	89 04 24             	mov    %eax,(%esp)
 b44:	e8 a3 fd ff ff       	call   8ec <lock_acquire>
	if( s->count-- < 0) 
 b49:	8b 45 08             	mov    0x8(%ebp),%eax
 b4c:	8b 40 04             	mov    0x4(%eax),%eax
 b4f:	89 c2                	mov    %eax,%edx
 b51:	c1 ea 1f             	shr    $0x1f,%edx
 b54:	8d 48 ff             	lea    -0x1(%eax),%ecx
 b57:	8b 45 08             	mov    0x8(%ebp),%eax
 b5a:	89 48 04             	mov    %ecx,0x4(%eax)
 b5d:	84 d2                	test   %dl,%dl
 b5f:	74 27                	je     b88 <sem_acquire+0x50>
	{
		add_q(&s->q, getpid()); 
 b61:	e8 7e f8 ff ff       	call   3e4 <getpid>
 b66:	8b 55 08             	mov    0x8(%ebp),%edx
 b69:	83 c2 08             	add    $0x8,%edx
 b6c:	89 44 24 04          	mov    %eax,0x4(%esp)
 b70:	89 14 24             	mov    %edx,(%esp)
 b73:	e8 ca fe ff ff       	call   a42 <add_q>
		lock_release(&s->lock); 
 b78:	8b 45 08             	mov    0x8(%ebp),%eax
 b7b:	89 04 24             	mov    %eax,(%esp)
 b7e:	e8 88 fd ff ff       	call   90b <lock_release>
		tsleep(); 
 b83:	e8 8c f8 ff ff       	call   414 <tsleep>
	} 
	lock_release(&s->lock); 
 b88:	8b 45 08             	mov    0x8(%ebp),%eax
 b8b:	89 04 24             	mov    %eax,(%esp)
 b8e:	e8 78 fd ff ff       	call   90b <lock_release>
}
 b93:	c9                   	leave  
 b94:	c3                   	ret    

00000b95 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
 b95:	55                   	push   %ebp
 b96:	89 e5                	mov    %esp,%ebp
 b98:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock); 
 b9b:	8b 45 08             	mov    0x8(%ebp),%eax
 b9e:	89 04 24             	mov    %eax,(%esp)
 ba1:	e8 46 fd ff ff       	call   8ec <lock_acquire>
	if( s->count++ <= 0) 
 ba6:	8b 45 08             	mov    0x8(%ebp),%eax
 ba9:	8b 40 04             	mov    0x4(%eax),%eax
 bac:	85 c0                	test   %eax,%eax
 bae:	0f 9e c2             	setle  %dl
 bb1:	8d 48 01             	lea    0x1(%eax),%ecx
 bb4:	8b 45 08             	mov    0x8(%ebp),%eax
 bb7:	89 48 04             	mov    %ecx,0x4(%eax)
 bba:	84 d2                	test   %dl,%dl
 bbc:	74 1c                	je     bda <sem_signal+0x45>
	{
		int tid = pop_q(&s->q); 
 bbe:	8b 45 08             	mov    0x8(%ebp),%eax
 bc1:	83 c0 08             	add    $0x8,%eax
 bc4:	89 04 24             	mov    %eax,(%esp)
 bc7:	e8 f0 fe ff ff       	call   abc <pop_q>
 bcc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
 bcf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 bd2:	89 04 24             	mov    %eax,(%esp)
 bd5:	e8 42 f8 ff ff       	call   41c <twakeup>
	}
	lock_release(&s->lock); 
 bda:	8b 45 08             	mov    0x8(%ebp),%eax
 bdd:	89 04 24             	mov    %eax,(%esp)
 be0:	e8 26 fd ff ff       	call   90b <lock_release>
} 
 be5:	c9                   	leave  
 be6:	c3                   	ret    

00000be7 <sem_init>:

void sem_init(struct Semaphore *s, int size){
 be7:	55                   	push   %ebp
 be8:	89 e5                	mov    %esp,%ebp
 bea:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
 bed:	8b 45 08             	mov    0x8(%ebp),%eax
 bf0:	89 04 24             	mov    %eax,(%esp)
 bf3:	e8 e6 fc ff ff       	call   8de <lock_init>
	s->count = size; 
 bf8:	8b 45 08             	mov    0x8(%ebp),%eax
 bfb:	8b 55 0c             	mov    0xc(%ebp),%edx
 bfe:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
 c01:	8b 45 08             	mov    0x8(%ebp),%eax
 c04:	83 c0 08             	add    $0x8,%eax
 c07:	89 04 24             	mov    %eax,(%esp)
 c0a:	e8 11 fe ff ff       	call   a20 <init_q>
}
 c0f:	c9                   	leave  
 c10:	c3                   	ret    
