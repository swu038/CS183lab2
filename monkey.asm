
_monkey:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

void monkey(void *arg);
struct Semaphore tree;  
int coconut_grabbed = 0; 

int main() {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp

	sem_init(&tree,3); 
   9:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
  10:	00 
  11:	c7 04 24 1c 0c 00 00 	movl   $0xc1c,(%esp)
  18:	e8 62 0b 00 00       	call   b7f <sem_init>
	void* mid = thread_create(monkey,(void *)0); 
  1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  24:	00 
  25:	c7 04 24 68 00 00 00 	movl   $0x68,(%esp)
  2c:	e8 8d 08 00 00       	call   8be <thread_create>
  31:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(mid == 0) exit(); 
  35:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  3a:	75 05                	jne    41 <main+0x41>
  3c:	e8 bb 02 00 00       	call   2fc <exit>
	wait(); 
  41:	e8 be 02 00 00       	call   304 <wait>
	
	printf(1,"coconuts grabbed: %d.\n",coconut_grabbed); 	
  46:	a1 0c 0c 00 00       	mov    0xc0c,%eax
  4b:	89 44 24 08          	mov    %eax,0x8(%esp)
  4f:	c7 44 24 04 a9 0b 00 	movl   $0xba9,0x4(%esp)
  56:	00 
  57:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5e:	e8 32 04 00 00       	call   495 <printf>

	exit();
  63:	e8 94 02 00 00       	call   2fc <exit>

00000068 <monkey>:
	return 0; 
}

void monkey(void *arg) {
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(&tree);  
  6e:	c7 04 24 1c 0c 00 00 	movl   $0xc1c,(%esp)
  75:	e8 56 0a 00 00       	call   ad0 <sem_acquire>
	coconut_grabbed++;
  7a:	a1 0c 0c 00 00       	mov    0xc0c,%eax
  7f:	83 c0 01             	add    $0x1,%eax
  82:	a3 0c 0c 00 00       	mov    %eax,0xc0c
	sem_signal(&tree);
  87:	c7 04 24 1c 0c 00 00 	movl   $0xc1c,(%esp)
  8e:	e8 9a 0a 00 00       	call   b2d <sem_signal>
	
	texit(); 	
  93:	e8 0c 03 00 00       	call   3a4 <texit>

00000098 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  98:	55                   	push   %ebp
  99:	89 e5                	mov    %esp,%ebp
  9b:	57                   	push   %edi
  9c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  9d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  a0:	8b 55 10             	mov    0x10(%ebp),%edx
  a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  a6:	89 cb                	mov    %ecx,%ebx
  a8:	89 df                	mov    %ebx,%edi
  aa:	89 d1                	mov    %edx,%ecx
  ac:	fc                   	cld    
  ad:	f3 aa                	rep stos %al,%es:(%edi)
  af:	89 ca                	mov    %ecx,%edx
  b1:	89 fb                	mov    %edi,%ebx
  b3:	89 5d 08             	mov    %ebx,0x8(%ebp)
  b6:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b9:	5b                   	pop    %ebx
  ba:	5f                   	pop    %edi
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    

000000bd <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  c0:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
  c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  cc:	0f b6 10             	movzbl (%eax),%edx
  cf:	8b 45 08             	mov    0x8(%ebp),%eax
  d2:	88 10                	mov    %dl,(%eax)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	0f 95 c0             	setne  %al
  df:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  e7:	84 c0                	test   %al,%al
  e9:	75 de                	jne    c9 <strcpy+0xc>
    ;
  return os;
  eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ee:	c9                   	leave  
  ef:	c3                   	ret    

000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  f3:	eb 08                	jmp    fd <strcmp+0xd>
    p++, q++;
  f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  f9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 00             	movzbl (%eax),%eax
 103:	84 c0                	test   %al,%al
 105:	74 10                	je     117 <strcmp+0x27>
 107:	8b 45 08             	mov    0x8(%ebp),%eax
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	8b 45 0c             	mov    0xc(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	38 c2                	cmp    %al,%dl
 115:	74 de                	je     f5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	0f b6 00             	movzbl (%eax),%eax
 11d:	0f b6 d0             	movzbl %al,%edx
 120:	8b 45 0c             	mov    0xc(%ebp),%eax
 123:	0f b6 00             	movzbl (%eax),%eax
 126:	0f b6 c0             	movzbl %al,%eax
 129:	89 d1                	mov    %edx,%ecx
 12b:	29 c1                	sub    %eax,%ecx
 12d:	89 c8                	mov    %ecx,%eax
}
 12f:	5d                   	pop    %ebp
 130:	c3                   	ret    

00000131 <strlen>:

uint
strlen(char *s)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
 134:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 137:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 13e:	eb 04                	jmp    144 <strlen+0x13>
 140:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 144:	8b 45 fc             	mov    -0x4(%ebp),%eax
 147:	03 45 08             	add    0x8(%ebp),%eax
 14a:	0f b6 00             	movzbl (%eax),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 ef                	jne    140 <strlen+0xf>
    ;
  return n;
 151:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 154:	c9                   	leave  
 155:	c3                   	ret    

00000156 <memset>:

void*
memset(void *dst, int c, uint n)
{
 156:	55                   	push   %ebp
 157:	89 e5                	mov    %esp,%ebp
 159:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 15c:	8b 45 10             	mov    0x10(%ebp),%eax
 15f:	89 44 24 08          	mov    %eax,0x8(%esp)
 163:	8b 45 0c             	mov    0xc(%ebp),%eax
 166:	89 44 24 04          	mov    %eax,0x4(%esp)
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	89 04 24             	mov    %eax,(%esp)
 170:	e8 23 ff ff ff       	call   98 <stosb>
  return dst;
 175:	8b 45 08             	mov    0x8(%ebp),%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <strchr>:

char*
strchr(const char *s, char c)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 04             	sub    $0x4,%esp
 180:	8b 45 0c             	mov    0xc(%ebp),%eax
 183:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 186:	eb 14                	jmp    19c <strchr+0x22>
    if(*s == c)
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 191:	75 05                	jne    198 <strchr+0x1e>
      return (char*)s;
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	eb 13                	jmp    1ab <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 198:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 19c:	8b 45 08             	mov    0x8(%ebp),%eax
 19f:	0f b6 00             	movzbl (%eax),%eax
 1a2:	84 c0                	test   %al,%al
 1a4:	75 e2                	jne    188 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 1a6:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1ab:	c9                   	leave  
 1ac:	c3                   	ret    

000001ad <gets>:

char*
gets(char *buf, int max)
{
 1ad:	55                   	push   %ebp
 1ae:	89 e5                	mov    %esp,%ebp
 1b0:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 1ba:	eb 44                	jmp    200 <gets+0x53>
    cc = read(0, &c, 1);
 1bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1c3:	00 
 1c4:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d2:	e8 3d 01 00 00       	call   314 <read>
 1d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
 1da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1de:	7e 2d                	jle    20d <gets+0x60>
      break;
    buf[i++] = c;
 1e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 1e3:	03 45 08             	add    0x8(%ebp),%eax
 1e6:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 1ea:	88 10                	mov    %dl,(%eax)
 1ec:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
 1f0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1f4:	3c 0a                	cmp    $0xa,%al
 1f6:	74 16                	je     20e <gets+0x61>
 1f8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1fc:	3c 0d                	cmp    $0xd,%al
 1fe:	74 0e                	je     20e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 200:	8b 45 f0             	mov    -0x10(%ebp),%eax
 203:	83 c0 01             	add    $0x1,%eax
 206:	3b 45 0c             	cmp    0xc(%ebp),%eax
 209:	7c b1                	jl     1bc <gets+0xf>
 20b:	eb 01                	jmp    20e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 20d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 20e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 211:	03 45 08             	add    0x8(%ebp),%eax
 214:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 217:	8b 45 08             	mov    0x8(%ebp),%eax
}
 21a:	c9                   	leave  
 21b:	c3                   	ret    

0000021c <stat>:

int
stat(char *n, struct stat *st)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 222:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 229:	00 
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	89 04 24             	mov    %eax,(%esp)
 230:	e8 07 01 00 00       	call   33c <open>
 235:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
 238:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 23c:	79 07                	jns    245 <stat+0x29>
    return -1;
 23e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 243:	eb 23                	jmp    268 <stat+0x4c>
  r = fstat(fd, st);
 245:	8b 45 0c             	mov    0xc(%ebp),%eax
 248:	89 44 24 04          	mov    %eax,0x4(%esp)
 24c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 24f:	89 04 24             	mov    %eax,(%esp)
 252:	e8 fd 00 00 00       	call   354 <fstat>
 257:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
 25a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 25d:	89 04 24             	mov    %eax,(%esp)
 260:	e8 bf 00 00 00       	call   324 <close>
  return r;
 265:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 268:	c9                   	leave  
 269:	c3                   	ret    

0000026a <atoi>:

int
atoi(const char *s)
{
 26a:	55                   	push   %ebp
 26b:	89 e5                	mov    %esp,%ebp
 26d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 270:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 277:	eb 24                	jmp    29d <atoi+0x33>
    n = n*10 + *s++ - '0';
 279:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27c:	89 d0                	mov    %edx,%eax
 27e:	c1 e0 02             	shl    $0x2,%eax
 281:	01 d0                	add    %edx,%eax
 283:	01 c0                	add    %eax,%eax
 285:	89 c2                	mov    %eax,%edx
 287:	8b 45 08             	mov    0x8(%ebp),%eax
 28a:	0f b6 00             	movzbl (%eax),%eax
 28d:	0f be c0             	movsbl %al,%eax
 290:	8d 04 02             	lea    (%edx,%eax,1),%eax
 293:	83 e8 30             	sub    $0x30,%eax
 296:	89 45 fc             	mov    %eax,-0x4(%ebp)
 299:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
 2a0:	0f b6 00             	movzbl (%eax),%eax
 2a3:	3c 2f                	cmp    $0x2f,%al
 2a5:	7e 0a                	jle    2b1 <atoi+0x47>
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	0f b6 00             	movzbl (%eax),%eax
 2ad:	3c 39                	cmp    $0x39,%al
 2af:	7e c8                	jle    279 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 2b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2b4:	c9                   	leave  
 2b5:	c3                   	ret    

000002b6 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2b6:	55                   	push   %ebp
 2b7:	89 e5                	mov    %esp,%ebp
 2b9:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
 2bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
 2c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
 2c8:	eb 13                	jmp    2dd <memmove+0x27>
    *dst++ = *src++;
 2ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2cd:	0f b6 10             	movzbl (%eax),%edx
 2d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 2d3:	88 10                	mov    %dl,(%eax)
 2d5:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2d9:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 2e1:	0f 9f c0             	setg   %al
 2e4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 2e8:	84 c0                	test   %al,%al
 2ea:	75 de                	jne    2ca <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2ec:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ef:	c9                   	leave  
 2f0:	c3                   	ret    
 2f1:	90                   	nop
 2f2:	90                   	nop
 2f3:	90                   	nop

000002f4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f4:	b8 01 00 00 00       	mov    $0x1,%eax
 2f9:	cd 40                	int    $0x40
 2fb:	c3                   	ret    

000002fc <exit>:
SYSCALL(exit)
 2fc:	b8 02 00 00 00       	mov    $0x2,%eax
 301:	cd 40                	int    $0x40
 303:	c3                   	ret    

00000304 <wait>:
SYSCALL(wait)
 304:	b8 03 00 00 00       	mov    $0x3,%eax
 309:	cd 40                	int    $0x40
 30b:	c3                   	ret    

0000030c <pipe>:
SYSCALL(pipe)
 30c:	b8 04 00 00 00       	mov    $0x4,%eax
 311:	cd 40                	int    $0x40
 313:	c3                   	ret    

00000314 <read>:
SYSCALL(read)
 314:	b8 05 00 00 00       	mov    $0x5,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <write>:
SYSCALL(write)
 31c:	b8 10 00 00 00       	mov    $0x10,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <close>:
SYSCALL(close)
 324:	b8 15 00 00 00       	mov    $0x15,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <kill>:
SYSCALL(kill)
 32c:	b8 06 00 00 00       	mov    $0x6,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <exec>:
SYSCALL(exec)
 334:	b8 07 00 00 00       	mov    $0x7,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <open>:
SYSCALL(open)
 33c:	b8 0f 00 00 00       	mov    $0xf,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <mknod>:
SYSCALL(mknod)
 344:	b8 11 00 00 00       	mov    $0x11,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <unlink>:
SYSCALL(unlink)
 34c:	b8 12 00 00 00       	mov    $0x12,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <fstat>:
SYSCALL(fstat)
 354:	b8 08 00 00 00       	mov    $0x8,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <link>:
SYSCALL(link)
 35c:	b8 13 00 00 00       	mov    $0x13,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <mkdir>:
SYSCALL(mkdir)
 364:	b8 14 00 00 00       	mov    $0x14,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <chdir>:
SYSCALL(chdir)
 36c:	b8 09 00 00 00       	mov    $0x9,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <dup>:
SYSCALL(dup)
 374:	b8 0a 00 00 00       	mov    $0xa,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <getpid>:
SYSCALL(getpid)
 37c:	b8 0b 00 00 00       	mov    $0xb,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <sbrk>:
SYSCALL(sbrk)
 384:	b8 0c 00 00 00       	mov    $0xc,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <sleep>:
SYSCALL(sleep)
 38c:	b8 0d 00 00 00       	mov    $0xd,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <uptime>:
SYSCALL(uptime)
 394:	b8 0e 00 00 00       	mov    $0xe,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <clone>:
SYSCALL(clone)
 39c:	b8 16 00 00 00       	mov    $0x16,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <texit>:
SYSCALL(texit)
 3a4:	b8 17 00 00 00       	mov    $0x17,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <tsleep>:
SYSCALL(tsleep)
 3ac:	b8 18 00 00 00       	mov    $0x18,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <twakeup>:
SYSCALL(twakeup)
 3b4:	b8 19 00 00 00       	mov    $0x19,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3bc:	55                   	push   %ebp
 3bd:	89 e5                	mov    %esp,%ebp
 3bf:	83 ec 28             	sub    $0x28,%esp
 3c2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3c8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3cf:	00 
 3d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3d3:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d7:	8b 45 08             	mov    0x8(%ebp),%eax
 3da:	89 04 24             	mov    %eax,(%esp)
 3dd:	e8 3a ff ff ff       	call   31c <write>
}
 3e2:	c9                   	leave  
 3e3:	c3                   	ret    

000003e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e4:	55                   	push   %ebp
 3e5:	89 e5                	mov    %esp,%ebp
 3e7:	53                   	push   %ebx
 3e8:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3eb:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3f6:	74 17                	je     40f <printint+0x2b>
 3f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3fc:	79 11                	jns    40f <printint+0x2b>
    neg = 1;
 3fe:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 405:	8b 45 0c             	mov    0xc(%ebp),%eax
 408:	f7 d8                	neg    %eax
 40a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 40d:	eb 06                	jmp    415 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 40f:	8b 45 0c             	mov    0xc(%ebp),%eax
 412:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
 415:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
 41c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 41f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 422:	8b 45 f4             	mov    -0xc(%ebp),%eax
 425:	ba 00 00 00 00       	mov    $0x0,%edx
 42a:	f7 f3                	div    %ebx
 42c:	89 d0                	mov    %edx,%eax
 42e:	0f b6 80 f4 0b 00 00 	movzbl 0xbf4(%eax),%eax
 435:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 439:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
 43d:	8b 45 10             	mov    0x10(%ebp),%eax
 440:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 443:	8b 45 f4             	mov    -0xc(%ebp),%eax
 446:	ba 00 00 00 00       	mov    $0x0,%edx
 44b:	f7 75 d4             	divl   -0x2c(%ebp)
 44e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 451:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 455:	75 c5                	jne    41c <printint+0x38>
  if(neg)
 457:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45b:	74 28                	je     485 <printint+0xa1>
    buf[i++] = '-';
 45d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 460:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 465:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
 469:	eb 1a                	jmp    485 <printint+0xa1>
    putc(fd, buf[i]);
 46b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
 473:	0f be c0             	movsbl %al,%eax
 476:	89 44 24 04          	mov    %eax,0x4(%esp)
 47a:	8b 45 08             	mov    0x8(%ebp),%eax
 47d:	89 04 24             	mov    %eax,(%esp)
 480:	e8 37 ff ff ff       	call   3bc <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 485:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
 489:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48d:	79 dc                	jns    46b <printint+0x87>
    putc(fd, buf[i]);
}
 48f:	83 c4 44             	add    $0x44,%esp
 492:	5b                   	pop    %ebx
 493:	5d                   	pop    %ebp
 494:	c3                   	ret    

00000495 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 495:	55                   	push   %ebp
 496:	89 e5                	mov    %esp,%ebp
 498:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 49b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a2:	8d 45 0c             	lea    0xc(%ebp),%eax
 4a5:	83 c0 04             	add    $0x4,%eax
 4a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
 4ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 4b2:	e9 7e 01 00 00       	jmp    635 <printf+0x1a0>
    c = fmt[i] & 0xff;
 4b7:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4bd:	8d 04 02             	lea    (%edx,%eax,1),%eax
 4c0:	0f b6 00             	movzbl (%eax),%eax
 4c3:	0f be c0             	movsbl %al,%eax
 4c6:	25 ff 00 00 00       	and    $0xff,%eax
 4cb:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
 4ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4d2:	75 2c                	jne    500 <printf+0x6b>
      if(c == '%'){
 4d4:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 4d8:	75 0c                	jne    4e6 <printf+0x51>
        state = '%';
 4da:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
 4e1:	e9 4b 01 00 00       	jmp    631 <printf+0x19c>
      } else {
        putc(fd, c);
 4e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e9:	0f be c0             	movsbl %al,%eax
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	8b 45 08             	mov    0x8(%ebp),%eax
 4f3:	89 04 24             	mov    %eax,(%esp)
 4f6:	e8 c1 fe ff ff       	call   3bc <putc>
 4fb:	e9 31 01 00 00       	jmp    631 <printf+0x19c>
      }
    } else if(state == '%'){
 500:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
 504:	0f 85 27 01 00 00    	jne    631 <printf+0x19c>
      if(c == 'd'){
 50a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
 50e:	75 2d                	jne    53d <printf+0xa8>
        printint(fd, *ap, 10, 1);
 510:	8b 45 f4             	mov    -0xc(%ebp),%eax
 513:	8b 00                	mov    (%eax),%eax
 515:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 51c:	00 
 51d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 524:	00 
 525:	89 44 24 04          	mov    %eax,0x4(%esp)
 529:	8b 45 08             	mov    0x8(%ebp),%eax
 52c:	89 04 24             	mov    %eax,(%esp)
 52f:	e8 b0 fe ff ff       	call   3e4 <printint>
        ap++;
 534:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 538:	e9 ed 00 00 00       	jmp    62a <printf+0x195>
      } else if(c == 'x' || c == 'p'){
 53d:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
 541:	74 06                	je     549 <printf+0xb4>
 543:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
 547:	75 2d                	jne    576 <printf+0xe1>
        printint(fd, *ap, 16, 0);
 549:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 555:	00 
 556:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 55d:	00 
 55e:	89 44 24 04          	mov    %eax,0x4(%esp)
 562:	8b 45 08             	mov    0x8(%ebp),%eax
 565:	89 04 24             	mov    %eax,(%esp)
 568:	e8 77 fe ff ff       	call   3e4 <printint>
        ap++;
 56d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 571:	e9 b4 00 00 00       	jmp    62a <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 576:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
 57a:	75 46                	jne    5c2 <printf+0x12d>
        s = (char*)*ap;
 57c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 57f:	8b 00                	mov    (%eax),%eax
 581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
 584:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
 588:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 58c:	75 27                	jne    5b5 <printf+0x120>
          s = "(null)";
 58e:	c7 45 e4 c0 0b 00 00 	movl   $0xbc0,-0x1c(%ebp)
        while(*s != 0){
 595:	eb 1f                	jmp    5b6 <printf+0x121>
          putc(fd, *s);
 597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59a:	0f b6 00             	movzbl (%eax),%eax
 59d:	0f be c0             	movsbl %al,%eax
 5a0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a4:	8b 45 08             	mov    0x8(%ebp),%eax
 5a7:	89 04 24             	mov    %eax,(%esp)
 5aa:	e8 0d fe ff ff       	call   3bc <putc>
          s++;
 5af:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 5b3:	eb 01                	jmp    5b6 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b5:	90                   	nop
 5b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b9:	0f b6 00             	movzbl (%eax),%eax
 5bc:	84 c0                	test   %al,%al
 5be:	75 d7                	jne    597 <printf+0x102>
 5c0:	eb 68                	jmp    62a <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c2:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
 5c6:	75 1d                	jne    5e5 <printf+0x150>
        putc(fd, *ap);
 5c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	0f be c0             	movsbl %al,%eax
 5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d4:	8b 45 08             	mov    0x8(%ebp),%eax
 5d7:	89 04 24             	mov    %eax,(%esp)
 5da:	e8 dd fd ff ff       	call   3bc <putc>
        ap++;
 5df:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 5e3:	eb 45                	jmp    62a <printf+0x195>
      } else if(c == '%'){
 5e5:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 5e9:	75 17                	jne    602 <printf+0x16d>
        putc(fd, c);
 5eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ee:	0f be c0             	movsbl %al,%eax
 5f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f5:	8b 45 08             	mov    0x8(%ebp),%eax
 5f8:	89 04 24             	mov    %eax,(%esp)
 5fb:	e8 bc fd ff ff       	call   3bc <putc>
 600:	eb 28                	jmp    62a <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 602:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 609:	00 
 60a:	8b 45 08             	mov    0x8(%ebp),%eax
 60d:	89 04 24             	mov    %eax,(%esp)
 610:	e8 a7 fd ff ff       	call   3bc <putc>
        putc(fd, c);
 615:	8b 45 e8             	mov    -0x18(%ebp),%eax
 618:	0f be c0             	movsbl %al,%eax
 61b:	89 44 24 04          	mov    %eax,0x4(%esp)
 61f:	8b 45 08             	mov    0x8(%ebp),%eax
 622:	89 04 24             	mov    %eax,(%esp)
 625:	e8 92 fd ff ff       	call   3bc <putc>
      }
      state = 0;
 62a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 631:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 635:	8b 55 0c             	mov    0xc(%ebp),%edx
 638:	8b 45 ec             	mov    -0x14(%ebp),%eax
 63b:	8d 04 02             	lea    (%edx,%eax,1),%eax
 63e:	0f b6 00             	movzbl (%eax),%eax
 641:	84 c0                	test   %al,%al
 643:	0f 85 6e fe ff ff    	jne    4b7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 649:	c9                   	leave  
 64a:	c3                   	ret    
 64b:	90                   	nop

0000064c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 64c:	55                   	push   %ebp
 64d:	89 e5                	mov    %esp,%ebp
 64f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	83 e8 08             	sub    $0x8,%eax
 658:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65b:	a1 18 0c 00 00       	mov    0xc18,%eax
 660:	89 45 fc             	mov    %eax,-0x4(%ebp)
 663:	eb 24                	jmp    689 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66d:	77 12                	ja     681 <free+0x35>
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 24                	ja     69b <free+0x4f>
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67f:	77 1a                	ja     69b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	89 45 fc             	mov    %eax,-0x4(%ebp)
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68f:	76 d4                	jbe    665 <free+0x19>
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 699:	76 ca                	jbe    665 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	c1 e0 03             	shl    $0x3,%eax
 6a4:	89 c2                	mov    %eax,%edx
 6a6:	03 55 f8             	add    -0x8(%ebp),%edx
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	39 c2                	cmp    %eax,%edx
 6b0:	75 24                	jne    6d6 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b5:	8b 50 04             	mov    0x4(%eax),%edx
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	8b 00                	mov    (%eax),%eax
 6bd:	8b 40 04             	mov    0x4(%eax),%eax
 6c0:	01 c2                	add    %eax,%edx
 6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	8b 10                	mov    (%eax),%edx
 6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d2:	89 10                	mov    %edx,(%eax)
 6d4:	eb 0a                	jmp    6e0 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e3:	8b 40 04             	mov    0x4(%eax),%eax
 6e6:	c1 e0 03             	shl    $0x3,%eax
 6e9:	03 45 fc             	add    -0x4(%ebp),%eax
 6ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ef:	75 20                	jne    711 <free+0xc5>
    p->s.size += bp->s.size;
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 50 04             	mov    0x4(%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	01 c2                	add    %eax,%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 705:	8b 45 f8             	mov    -0x8(%ebp),%eax
 708:	8b 10                	mov    (%eax),%edx
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	89 10                	mov    %edx,(%eax)
 70f:	eb 08                	jmp    719 <free+0xcd>
  } else
    p->s.ptr = bp;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 55 f8             	mov    -0x8(%ebp),%edx
 717:	89 10                	mov    %edx,(%eax)
  freep = p;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	a3 18 0c 00 00       	mov    %eax,0xc18
}
 721:	c9                   	leave  
 722:	c3                   	ret    

00000723 <morecore>:

static Header*
morecore(uint nu)
{
 723:	55                   	push   %ebp
 724:	89 e5                	mov    %esp,%ebp
 726:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 729:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 730:	77 07                	ja     739 <morecore+0x16>
    nu = 4096;
 732:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 739:	8b 45 08             	mov    0x8(%ebp),%eax
 73c:	c1 e0 03             	shl    $0x3,%eax
 73f:	89 04 24             	mov    %eax,(%esp)
 742:	e8 3d fc ff ff       	call   384 <sbrk>
 747:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
 74a:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
 74e:	75 07                	jne    757 <morecore+0x34>
    return 0;
 750:	b8 00 00 00 00       	mov    $0x0,%eax
 755:	eb 22                	jmp    779 <morecore+0x56>
  hp = (Header*)p;
 757:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
 75d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 760:	8b 55 08             	mov    0x8(%ebp),%edx
 763:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 766:	8b 45 f4             	mov    -0xc(%ebp),%eax
 769:	83 c0 08             	add    $0x8,%eax
 76c:	89 04 24             	mov    %eax,(%esp)
 76f:	e8 d8 fe ff ff       	call   64c <free>
  return freep;
 774:	a1 18 0c 00 00       	mov    0xc18,%eax
}
 779:	c9                   	leave  
 77a:	c3                   	ret    

0000077b <malloc>:

void*
malloc(uint nbytes)
{
 77b:	55                   	push   %ebp
 77c:	89 e5                	mov    %esp,%ebp
 77e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 781:	8b 45 08             	mov    0x8(%ebp),%eax
 784:	83 c0 07             	add    $0x7,%eax
 787:	c1 e8 03             	shr    $0x3,%eax
 78a:	83 c0 01             	add    $0x1,%eax
 78d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
 790:	a1 18 0c 00 00       	mov    0xc18,%eax
 795:	89 45 f0             	mov    %eax,-0x10(%ebp)
 798:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79c:	75 23                	jne    7c1 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79e:	c7 45 f0 10 0c 00 00 	movl   $0xc10,-0x10(%ebp)
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	a3 18 0c 00 00       	mov    %eax,0xc18
 7ad:	a1 18 0c 00 00       	mov    0xc18,%eax
 7b2:	a3 10 0c 00 00       	mov    %eax,0xc10
    base.s.size = 0;
 7b7:	c7 05 14 0c 00 00 00 	movl   $0x0,0xc14
 7be:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c4:	8b 00                	mov    (%eax),%eax
 7c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
 7c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7cc:	8b 40 04             	mov    0x4(%eax),%eax
 7cf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 7d2:	72 4d                	jb     821 <malloc+0xa6>
      if(p->s.size == nunits)
 7d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7d7:	8b 40 04             	mov    0x4(%eax),%eax
 7da:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 7dd:	75 0c                	jne    7eb <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7df:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7e2:	8b 10                	mov    (%eax),%edx
 7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e7:	89 10                	mov    %edx,(%eax)
 7e9:	eb 26                	jmp    811 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7ee:	8b 40 04             	mov    0x4(%eax),%eax
 7f1:	89 c2                	mov    %eax,%edx
 7f3:	2b 55 f4             	sub    -0xc(%ebp),%edx
 7f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7f9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 7ff:	8b 40 04             	mov    0x4(%eax),%eax
 802:	c1 e0 03             	shl    $0x3,%eax
 805:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
 808:	8b 45 ec             	mov    -0x14(%ebp),%eax
 80b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 80e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 811:	8b 45 f0             	mov    -0x10(%ebp),%eax
 814:	a3 18 0c 00 00       	mov    %eax,0xc18
      return (void*)(p + 1);
 819:	8b 45 ec             	mov    -0x14(%ebp),%eax
 81c:	83 c0 08             	add    $0x8,%eax
 81f:	eb 38                	jmp    859 <malloc+0xde>
    }
    if(p == freep)
 821:	a1 18 0c 00 00       	mov    0xc18,%eax
 826:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 829:	75 1b                	jne    846 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	89 04 24             	mov    %eax,(%esp)
 831:	e8 ed fe ff ff       	call   723 <morecore>
 836:	89 45 ec             	mov    %eax,-0x14(%ebp)
 839:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 83d:	75 07                	jne    846 <malloc+0xcb>
        return 0;
 83f:	b8 00 00 00 00       	mov    $0x0,%eax
 844:	eb 13                	jmp    859 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 846:	8b 45 ec             	mov    -0x14(%ebp),%eax
 849:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 84f:	8b 00                	mov    (%eax),%eax
 851:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 854:	e9 70 ff ff ff       	jmp    7c9 <malloc+0x4e>
}
 859:	c9                   	leave  
 85a:	c3                   	ret    
 85b:	90                   	nop

0000085c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 85c:	55                   	push   %ebp
 85d:	89 e5                	mov    %esp,%ebp
 85f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 862:	8b 55 08             	mov    0x8(%ebp),%edx
 865:	8b 45 0c             	mov    0xc(%ebp),%eax
 868:	8b 4d 08             	mov    0x8(%ebp),%ecx
 86b:	f0 87 02             	lock xchg %eax,(%edx)
 86e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 871:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 874:	c9                   	leave  
 875:	c3                   	ret    

00000876 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
 876:	55                   	push   %ebp
 877:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
 87c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 882:	5d                   	pop    %ebp
 883:	c3                   	ret    

00000884 <lock_acquire>:
void lock_acquire(lock_t *lock){
 884:	55                   	push   %ebp
 885:	89 e5                	mov    %esp,%ebp
 887:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
 88a:	8b 45 08             	mov    0x8(%ebp),%eax
 88d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 894:	00 
 895:	89 04 24             	mov    %eax,(%esp)
 898:	e8 bf ff ff ff       	call   85c <xchg>
 89d:	85 c0                	test   %eax,%eax
 89f:	75 e9                	jne    88a <lock_acquire+0x6>
}
 8a1:	c9                   	leave  
 8a2:	c3                   	ret    

000008a3 <lock_release>:
void lock_release(lock_t *lock){
 8a3:	55                   	push   %ebp
 8a4:	89 e5                	mov    %esp,%ebp
 8a6:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
 8a9:	8b 45 08             	mov    0x8(%ebp),%eax
 8ac:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 8b3:	00 
 8b4:	89 04 24             	mov    %eax,(%esp)
 8b7:	e8 a0 ff ff ff       	call   85c <xchg>
}
 8bc:	c9                   	leave  
 8bd:	c3                   	ret    

000008be <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
 8be:	55                   	push   %ebp
 8bf:	89 e5                	mov    %esp,%ebp
 8c1:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
 8c4:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 8cb:	e8 ab fe ff ff       	call   77b <malloc>
 8d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
 8d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
 8d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8dc:	25 ff 0f 00 00       	and    $0xfff,%eax
 8e1:	85 c0                	test   %eax,%eax
 8e3:	74 15                	je     8fa <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
 8e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e8:	89 c2                	mov    %eax,%edx
 8ea:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
 8f0:	b8 00 10 00 00       	mov    $0x1000,%eax
 8f5:	29 d0                	sub    %edx,%eax
 8f7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
 8fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8fe:	75 1b                	jne    91b <thread_create+0x5d>

        printf(1,"malloc fail \n");
 900:	c7 44 24 04 c7 0b 00 	movl   $0xbc7,0x4(%esp)
 907:	00 
 908:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 90f:	e8 81 fb ff ff       	call   495 <printf>
        return 0;
 914:	b8 00 00 00 00       	mov    $0x0,%eax
 919:	eb 6f                	jmp    98a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
 91b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 91e:	8b 55 08             	mov    0x8(%ebp),%edx
 921:	8b 45 f0             	mov    -0x10(%ebp),%eax
 924:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 928:	89 54 24 08          	mov    %edx,0x8(%esp)
 92c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 933:	00 
 934:	89 04 24             	mov    %eax,(%esp)
 937:	e8 60 fa ff ff       	call   39c <clone>
 93c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
 93f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 943:	79 1b                	jns    960 <thread_create+0xa2>
        printf(1,"clone fails\n");
 945:	c7 44 24 04 d5 0b 00 	movl   $0xbd5,0x4(%esp)
 94c:	00 
 94d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 954:	e8 3c fb ff ff       	call   495 <printf>
        return 0;
 959:	b8 00 00 00 00       	mov    $0x0,%eax
 95e:	eb 2a                	jmp    98a <thread_create+0xcc>
    }
    if(tid > 0){
 960:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 964:	7e 05                	jle    96b <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
 966:	8b 45 f4             	mov    -0xc(%ebp),%eax
 969:	eb 1f                	jmp    98a <thread_create+0xcc>
    }
    if(tid == 0){
 96b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 96f:	75 14                	jne    985 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
 971:	c7 44 24 04 e2 0b 00 	movl   $0xbe2,0x4(%esp)
 978:	00 
 979:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 980:	e8 10 fb ff ff       	call   495 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
 985:	b8 00 00 00 00       	mov    $0x0,%eax
}
 98a:	c9                   	leave  
 98b:	c3                   	ret    

0000098c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
 98c:	55                   	push   %ebp
 98d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
 98f:	a1 08 0c 00 00       	mov    0xc08,%eax
 994:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
 99a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
 99f:	a3 08 0c 00 00       	mov    %eax,0xc08
    return (int)(rands % max);
 9a4:	a1 08 0c 00 00       	mov    0xc08,%eax
 9a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
 9ac:	ba 00 00 00 00       	mov    $0x0,%edx
 9b1:	f7 f1                	div    %ecx
 9b3:	89 d0                	mov    %edx,%eax
}
 9b5:	5d                   	pop    %ebp
 9b6:	c3                   	ret    
 9b7:	90                   	nop

000009b8 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
 9b8:	55                   	push   %ebp
 9b9:	89 e5                	mov    %esp,%ebp
    q->size = 0;
 9bb:	8b 45 08             	mov    0x8(%ebp),%eax
 9be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
 9c4:	8b 45 08             	mov    0x8(%ebp),%eax
 9c7:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
 9ce:	8b 45 08             	mov    0x8(%ebp),%eax
 9d1:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
 9d8:	5d                   	pop    %ebp
 9d9:	c3                   	ret    

000009da <add_q>:

void add_q(struct queue *q, int v){
 9da:	55                   	push   %ebp
 9db:	89 e5                	mov    %esp,%ebp
 9dd:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
 9e0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 9e7:	e8 8f fd ff ff       	call   77b <malloc>
 9ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
 9ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9f2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
 9f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9fc:	8b 55 0c             	mov    0xc(%ebp),%edx
 9ff:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
 a01:	8b 45 08             	mov    0x8(%ebp),%eax
 a04:	8b 40 04             	mov    0x4(%eax),%eax
 a07:	85 c0                	test   %eax,%eax
 a09:	75 0b                	jne    a16 <add_q+0x3c>
        q->head = n;
 a0b:	8b 45 08             	mov    0x8(%ebp),%eax
 a0e:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a11:	89 50 04             	mov    %edx,0x4(%eax)
 a14:	eb 0c                	jmp    a22 <add_q+0x48>
    }else{
        q->tail->next = n;
 a16:	8b 45 08             	mov    0x8(%ebp),%eax
 a19:	8b 40 08             	mov    0x8(%eax),%eax
 a1c:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a1f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
 a22:	8b 45 08             	mov    0x8(%ebp),%eax
 a25:	8b 55 f4             	mov    -0xc(%ebp),%edx
 a28:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
 a2b:	8b 45 08             	mov    0x8(%ebp),%eax
 a2e:	8b 00                	mov    (%eax),%eax
 a30:	8d 50 01             	lea    0x1(%eax),%edx
 a33:	8b 45 08             	mov    0x8(%ebp),%eax
 a36:	89 10                	mov    %edx,(%eax)
}
 a38:	c9                   	leave  
 a39:	c3                   	ret    

00000a3a <empty_q>:

int empty_q(struct queue *q){
 a3a:	55                   	push   %ebp
 a3b:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
 a3d:	8b 45 08             	mov    0x8(%ebp),%eax
 a40:	8b 00                	mov    (%eax),%eax
 a42:	85 c0                	test   %eax,%eax
 a44:	75 07                	jne    a4d <empty_q+0x13>
        return 1;
 a46:	b8 01 00 00 00       	mov    $0x1,%eax
 a4b:	eb 05                	jmp    a52 <empty_q+0x18>
    else
        return 0;
 a4d:	b8 00 00 00 00       	mov    $0x0,%eax
} 
 a52:	5d                   	pop    %ebp
 a53:	c3                   	ret    

00000a54 <pop_q>:
int pop_q(struct queue *q){
 a54:	55                   	push   %ebp
 a55:	89 e5                	mov    %esp,%ebp
 a57:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
 a5a:	8b 45 08             	mov    0x8(%ebp),%eax
 a5d:	89 04 24             	mov    %eax,(%esp)
 a60:	e8 d5 ff ff ff       	call   a3a <empty_q>
 a65:	85 c0                	test   %eax,%eax
 a67:	75 5d                	jne    ac6 <pop_q+0x72>
       val = q->head->value; 
 a69:	8b 45 08             	mov    0x8(%ebp),%eax
 a6c:	8b 40 04             	mov    0x4(%eax),%eax
 a6f:	8b 00                	mov    (%eax),%eax
 a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
 a74:	8b 45 08             	mov    0x8(%ebp),%eax
 a77:	8b 40 04             	mov    0x4(%eax),%eax
 a7a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
 a7d:	8b 45 08             	mov    0x8(%ebp),%eax
 a80:	8b 40 04             	mov    0x4(%eax),%eax
 a83:	8b 50 04             	mov    0x4(%eax),%edx
 a86:	8b 45 08             	mov    0x8(%ebp),%eax
 a89:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
 a8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8f:	89 04 24             	mov    %eax,(%esp)
 a92:	e8 b5 fb ff ff       	call   64c <free>
       q->size--;
 a97:	8b 45 08             	mov    0x8(%ebp),%eax
 a9a:	8b 00                	mov    (%eax),%eax
 a9c:	8d 50 ff             	lea    -0x1(%eax),%edx
 a9f:	8b 45 08             	mov    0x8(%ebp),%eax
 aa2:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
 aa4:	8b 45 08             	mov    0x8(%ebp),%eax
 aa7:	8b 00                	mov    (%eax),%eax
 aa9:	85 c0                	test   %eax,%eax
 aab:	75 14                	jne    ac1 <pop_q+0x6d>
            q->head = 0;
 aad:	8b 45 08             	mov    0x8(%ebp),%eax
 ab0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
 ab7:	8b 45 08             	mov    0x8(%ebp),%eax
 aba:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
 ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac4:	eb 05                	jmp    acb <pop_q+0x77>
    }
    return -1;
 ac6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 acb:	c9                   	leave  
 acc:	c3                   	ret    
 acd:	90                   	nop
 ace:	90                   	nop
 acf:	90                   	nop

00000ad0 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock); 
 ad6:	8b 45 08             	mov    0x8(%ebp),%eax
 ad9:	89 04 24             	mov    %eax,(%esp)
 adc:	e8 a3 fd ff ff       	call   884 <lock_acquire>
	if( s->count-- < 0) 
 ae1:	8b 45 08             	mov    0x8(%ebp),%eax
 ae4:	8b 40 04             	mov    0x4(%eax),%eax
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	c1 ea 1f             	shr    $0x1f,%edx
 aec:	8d 48 ff             	lea    -0x1(%eax),%ecx
 aef:	8b 45 08             	mov    0x8(%ebp),%eax
 af2:	89 48 04             	mov    %ecx,0x4(%eax)
 af5:	84 d2                	test   %dl,%dl
 af7:	74 27                	je     b20 <sem_acquire+0x50>
	{
		add_q(&s->q, getpid()); 
 af9:	e8 7e f8 ff ff       	call   37c <getpid>
 afe:	8b 55 08             	mov    0x8(%ebp),%edx
 b01:	83 c2 08             	add    $0x8,%edx
 b04:	89 44 24 04          	mov    %eax,0x4(%esp)
 b08:	89 14 24             	mov    %edx,(%esp)
 b0b:	e8 ca fe ff ff       	call   9da <add_q>
		lock_release(&s->lock); 
 b10:	8b 45 08             	mov    0x8(%ebp),%eax
 b13:	89 04 24             	mov    %eax,(%esp)
 b16:	e8 88 fd ff ff       	call   8a3 <lock_release>
		tsleep(); 
 b1b:	e8 8c f8 ff ff       	call   3ac <tsleep>
	} 
	lock_release(&s->lock); 
 b20:	8b 45 08             	mov    0x8(%ebp),%eax
 b23:	89 04 24             	mov    %eax,(%esp)
 b26:	e8 78 fd ff ff       	call   8a3 <lock_release>
}
 b2b:	c9                   	leave  
 b2c:	c3                   	ret    

00000b2d <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
 b2d:	55                   	push   %ebp
 b2e:	89 e5                	mov    %esp,%ebp
 b30:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock); 
 b33:	8b 45 08             	mov    0x8(%ebp),%eax
 b36:	89 04 24             	mov    %eax,(%esp)
 b39:	e8 46 fd ff ff       	call   884 <lock_acquire>
	if( s->count++ <= 0) 
 b3e:	8b 45 08             	mov    0x8(%ebp),%eax
 b41:	8b 40 04             	mov    0x4(%eax),%eax
 b44:	85 c0                	test   %eax,%eax
 b46:	0f 9e c2             	setle  %dl
 b49:	8d 48 01             	lea    0x1(%eax),%ecx
 b4c:	8b 45 08             	mov    0x8(%ebp),%eax
 b4f:	89 48 04             	mov    %ecx,0x4(%eax)
 b52:	84 d2                	test   %dl,%dl
 b54:	74 1c                	je     b72 <sem_signal+0x45>
	{
		int tid = pop_q(&s->q); 
 b56:	8b 45 08             	mov    0x8(%ebp),%eax
 b59:	83 c0 08             	add    $0x8,%eax
 b5c:	89 04 24             	mov    %eax,(%esp)
 b5f:	e8 f0 fe ff ff       	call   a54 <pop_q>
 b64:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
 b67:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b6a:	89 04 24             	mov    %eax,(%esp)
 b6d:	e8 42 f8 ff ff       	call   3b4 <twakeup>
	}
	lock_release(&s->lock); 
 b72:	8b 45 08             	mov    0x8(%ebp),%eax
 b75:	89 04 24             	mov    %eax,(%esp)
 b78:	e8 26 fd ff ff       	call   8a3 <lock_release>
} 
 b7d:	c9                   	leave  
 b7e:	c3                   	ret    

00000b7f <sem_init>:

void sem_init(struct Semaphore *s, int size){
 b7f:	55                   	push   %ebp
 b80:	89 e5                	mov    %esp,%ebp
 b82:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
 b85:	8b 45 08             	mov    0x8(%ebp),%eax
 b88:	89 04 24             	mov    %eax,(%esp)
 b8b:	e8 e6 fc ff ff       	call   876 <lock_init>
	s->count = size; 
 b90:	8b 45 08             	mov    0x8(%ebp),%eax
 b93:	8b 55 0c             	mov    0xc(%ebp),%edx
 b96:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
 b99:	8b 45 08             	mov    0x8(%ebp),%eax
 b9c:	83 c0 08             	add    $0x8,%eax
 b9f:	89 04 24             	mov    %eax,(%esp)
 ba2:	e8 11 fe ff ff       	call   9b8 <init_q>
}
 ba7:	c9                   	leave  
 ba8:	c3                   	ret    
