
_nature:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int water_molecule = 0; 
struct {
	lock_t lock; 
}mutex;  

int main() {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp

	sem_init(&h, 1);
   9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  10:	00 
  11:	c7 04 24 fc 0c 00 00 	movl   $0xcfc,(%esp)
  18:	e8 12 0c 00 00       	call   c2f <sem_init>
	sem_init(&o, 1); 
  1d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  24:	00 
  25:	c7 04 24 e4 0c 00 00 	movl   $0xce4,(%esp)
  2c:	e8 fe 0b 00 00       	call   c2f <sem_init>

	void *oid = thread_create(oReady,(void *)0); 
  31:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  38:	00 
  39:	c7 04 24 c2 00 00 00 	movl   $0xc2,(%esp)
  40:	e8 29 09 00 00       	call   96e <thread_create>
  45:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(oid == 0) exit(); 
  49:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  4e:	75 05                	jne    55 <main+0x55>
  50:	e8 57 03 00 00       	call   3ac <exit>
	wait(); 
  55:	e8 5a 03 00 00       	call   3b4 <wait>
	void *hid = thread_create(hReady,(void *)0); 
  5a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  61:	00 
  62:	c7 04 24 22 01 00 00 	movl   $0x122,(%esp)
  69:	e8 00 09 00 00       	call   96e <thread_create>
  6e:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(hid == 0) exit();  
  72:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  77:	75 05                	jne    7e <main+0x7e>
  79:	e8 2e 03 00 00       	call   3ac <exit>
	wait(); 
  7e:	e8 31 03 00 00       	call   3b4 <wait>

	printf(1,"created water molecule: %d.\n",water_molecule); 
  83:	a1 d4 0c 00 00       	mov    0xcd4,%eax
  88:	89 44 24 08          	mov    %eax,0x8(%esp)
  8c:	c7 44 24 04 59 0c 00 	movl   $0xc59,0x4(%esp)
  93:	00 
  94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9b:	e8 a5 04 00 00       	call   545 <printf>
	printf(1, "count of o: %d.\n",h.count);
  a0:	a1 00 0d 00 00       	mov    0xd00,%eax
  a5:	89 44 24 08          	mov    %eax,0x8(%esp)
  a9:	c7 44 24 04 76 0c 00 	movl   $0xc76,0x4(%esp)
  b0:	00 
  b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b8:	e8 88 04 00 00       	call   545 <printf>
	exit(); 
  bd:	e8 ea 02 00 00       	call   3ac <exit>

000000c2 <oReady>:
	return 0;
}

void oReady(void *arg) {
  c2:	55                   	push   %ebp
  c3:	89 e5                	mov    %esp,%ebp
  c5:	83 ec 18             	sub    $0x18,%esp
	sem_acquire(&h); 
  c8:	c7 04 24 fc 0c 00 00 	movl   $0xcfc,(%esp)
  cf:	e8 ac 0a 00 00       	call   b80 <sem_acquire>
	sem_acquire(&h); 
  d4:	c7 04 24 fc 0c 00 00 	movl   $0xcfc,(%esp)
  db:	e8 a0 0a 00 00       	call   b80 <sem_acquire>
	sem_signal(&o);
  e0:	c7 04 24 e4 0c 00 00 	movl   $0xce4,(%esp)
  e7:	e8 f1 0a 00 00       	call   bdd <sem_signal>
	sem_signal(&o); 
  ec:	c7 04 24 e4 0c 00 00 	movl   $0xce4,(%esp)
  f3:	e8 e5 0a 00 00       	call   bdd <sem_signal>
	lock_acquire(&mutex.lock);
  f8:	c7 04 24 f8 0c 00 00 	movl   $0xcf8,(%esp)
  ff:	e8 30 08 00 00       	call   934 <lock_acquire>
	water_molecule++; 
 104:	a1 d4 0c 00 00       	mov    0xcd4,%eax
 109:	83 c0 01             	add    $0x1,%eax
 10c:	a3 d4 0c 00 00       	mov    %eax,0xcd4
	lock_release(&mutex.lock); 	 
 111:	c7 04 24 f8 0c 00 00 	movl   $0xcf8,(%esp)
 118:	e8 36 08 00 00       	call   953 <lock_release>

	texit(); 	
 11d:	e8 32 03 00 00       	call   454 <texit>

00000122 <hReady>:
}

void hReady(void *arg) { 
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
 125:	83 ec 18             	sub    $0x18,%esp
	sem_signal(&h);
 128:	c7 04 24 fc 0c 00 00 	movl   $0xcfc,(%esp)
 12f:	e8 a9 0a 00 00       	call   bdd <sem_signal>
	sem_acquire(&o); 
 134:	c7 04 24 e4 0c 00 00 	movl   $0xce4,(%esp)
 13b:	e8 40 0a 00 00       	call   b80 <sem_acquire>

	texit();  
 140:	e8 0f 03 00 00       	call   454 <texit>
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop

00000148 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	57                   	push   %edi
 14c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 14d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 150:	8b 55 10             	mov    0x10(%ebp),%edx
 153:	8b 45 0c             	mov    0xc(%ebp),%eax
 156:	89 cb                	mov    %ecx,%ebx
 158:	89 df                	mov    %ebx,%edi
 15a:	89 d1                	mov    %edx,%ecx
 15c:	fc                   	cld    
 15d:	f3 aa                	rep stos %al,%es:(%edi)
 15f:	89 ca                	mov    %ecx,%edx
 161:	89 fb                	mov    %edi,%ebx
 163:	89 5d 08             	mov    %ebx,0x8(%ebp)
 166:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 169:	5b                   	pop    %ebx
 16a:	5f                   	pop    %edi
 16b:	5d                   	pop    %ebp
 16c:	c3                   	ret    

0000016d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 16d:	55                   	push   %ebp
 16e:	89 e5                	mov    %esp,%ebp
 170:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 179:	8b 45 0c             	mov    0xc(%ebp),%eax
 17c:	0f b6 10             	movzbl (%eax),%edx
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	88 10                	mov    %dl,(%eax)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	0f 95 c0             	setne  %al
 18f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 193:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 197:	84 c0                	test   %al,%al
 199:	75 de                	jne    179 <strcpy+0xc>
    ;
  return os;
 19b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 19e:	c9                   	leave  
 19f:	c3                   	ret    

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1a3:	eb 08                	jmp    1ad <strcmp+0xd>
    p++, q++;
 1a5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1a9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
 1b0:	0f b6 00             	movzbl (%eax),%eax
 1b3:	84 c0                	test   %al,%al
 1b5:	74 10                	je     1c7 <strcmp+0x27>
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c0:	0f b6 00             	movzbl (%eax),%eax
 1c3:	38 c2                	cmp    %al,%dl
 1c5:	74 de                	je     1a5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1c7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ca:	0f b6 00             	movzbl (%eax),%eax
 1cd:	0f b6 d0             	movzbl %al,%edx
 1d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d3:	0f b6 00             	movzbl (%eax),%eax
 1d6:	0f b6 c0             	movzbl %al,%eax
 1d9:	89 d1                	mov    %edx,%ecx
 1db:	29 c1                	sub    %eax,%ecx
 1dd:	89 c8                	mov    %ecx,%eax
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    

000001e1 <strlen>:

uint
strlen(char *s)
{
 1e1:	55                   	push   %ebp
 1e2:	89 e5                	mov    %esp,%ebp
 1e4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1ee:	eb 04                	jmp    1f4 <strlen+0x13>
 1f0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1f7:	03 45 08             	add    0x8(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	75 ef                	jne    1f0 <strlen+0xf>
    ;
  return n;
 201:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 204:	c9                   	leave  
 205:	c3                   	ret    

00000206 <memset>:

void*
memset(void *dst, int c, uint n)
{
 206:	55                   	push   %ebp
 207:	89 e5                	mov    %esp,%ebp
 209:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 20c:	8b 45 10             	mov    0x10(%ebp),%eax
 20f:	89 44 24 08          	mov    %eax,0x8(%esp)
 213:	8b 45 0c             	mov    0xc(%ebp),%eax
 216:	89 44 24 04          	mov    %eax,0x4(%esp)
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	89 04 24             	mov    %eax,(%esp)
 220:	e8 23 ff ff ff       	call   148 <stosb>
  return dst;
 225:	8b 45 08             	mov    0x8(%ebp),%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <strchr>:

char*
strchr(const char *s, char c)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 04             	sub    $0x4,%esp
 230:	8b 45 0c             	mov    0xc(%ebp),%eax
 233:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 236:	eb 14                	jmp    24c <strchr+0x22>
    if(*s == c)
 238:	8b 45 08             	mov    0x8(%ebp),%eax
 23b:	0f b6 00             	movzbl (%eax),%eax
 23e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 241:	75 05                	jne    248 <strchr+0x1e>
      return (char*)s;
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	eb 13                	jmp    25b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 248:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 24c:	8b 45 08             	mov    0x8(%ebp),%eax
 24f:	0f b6 00             	movzbl (%eax),%eax
 252:	84 c0                	test   %al,%al
 254:	75 e2                	jne    238 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 256:	b8 00 00 00 00       	mov    $0x0,%eax
}
 25b:	c9                   	leave  
 25c:	c3                   	ret    

0000025d <gets>:

char*
gets(char *buf, int max)
{
 25d:	55                   	push   %ebp
 25e:	89 e5                	mov    %esp,%ebp
 260:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 263:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 26a:	eb 44                	jmp    2b0 <gets+0x53>
    cc = read(0, &c, 1);
 26c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 273:	00 
 274:	8d 45 ef             	lea    -0x11(%ebp),%eax
 277:	89 44 24 04          	mov    %eax,0x4(%esp)
 27b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 282:	e8 3d 01 00 00       	call   3c4 <read>
 287:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
 28a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 28e:	7e 2d                	jle    2bd <gets+0x60>
      break;
    buf[i++] = c;
 290:	8b 45 f0             	mov    -0x10(%ebp),%eax
 293:	03 45 08             	add    0x8(%ebp),%eax
 296:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
 29a:	88 10                	mov    %dl,(%eax)
 29c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
 2a0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a4:	3c 0a                	cmp    $0xa,%al
 2a6:	74 16                	je     2be <gets+0x61>
 2a8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2ac:	3c 0d                	cmp    $0xd,%al
 2ae:	74 0e                	je     2be <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2b3:	83 c0 01             	add    $0x1,%eax
 2b6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2b9:	7c b1                	jl     26c <gets+0xf>
 2bb:	eb 01                	jmp    2be <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2bd:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2c1:	03 45 08             	add    0x8(%ebp),%eax
 2c4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <stat>:

int
stat(char *n, struct stat *st)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2d9:	00 
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	89 04 24             	mov    %eax,(%esp)
 2e0:	e8 07 01 00 00       	call   3ec <open>
 2e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
 2e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ec:	79 07                	jns    2f5 <stat+0x29>
    return -1;
 2ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2f3:	eb 23                	jmp    318 <stat+0x4c>
  r = fstat(fd, st);
 2f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f8:	89 44 24 04          	mov    %eax,0x4(%esp)
 2fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2ff:	89 04 24             	mov    %eax,(%esp)
 302:	e8 fd 00 00 00       	call   404 <fstat>
 307:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
 30a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 30d:	89 04 24             	mov    %eax,(%esp)
 310:	e8 bf 00 00 00       	call   3d4 <close>
  return r;
 315:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
 318:	c9                   	leave  
 319:	c3                   	ret    

0000031a <atoi>:

int
atoi(const char *s)
{
 31a:	55                   	push   %ebp
 31b:	89 e5                	mov    %esp,%ebp
 31d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 320:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 327:	eb 24                	jmp    34d <atoi+0x33>
    n = n*10 + *s++ - '0';
 329:	8b 55 fc             	mov    -0x4(%ebp),%edx
 32c:	89 d0                	mov    %edx,%eax
 32e:	c1 e0 02             	shl    $0x2,%eax
 331:	01 d0                	add    %edx,%eax
 333:	01 c0                	add    %eax,%eax
 335:	89 c2                	mov    %eax,%edx
 337:	8b 45 08             	mov    0x8(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	0f be c0             	movsbl %al,%eax
 340:	8d 04 02             	lea    (%edx,%eax,1),%eax
 343:	83 e8 30             	sub    $0x30,%eax
 346:	89 45 fc             	mov    %eax,-0x4(%ebp)
 349:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34d:	8b 45 08             	mov    0x8(%ebp),%eax
 350:	0f b6 00             	movzbl (%eax),%eax
 353:	3c 2f                	cmp    $0x2f,%al
 355:	7e 0a                	jle    361 <atoi+0x47>
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	0f b6 00             	movzbl (%eax),%eax
 35d:	3c 39                	cmp    $0x39,%al
 35f:	7e c8                	jle    329 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 361:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 364:	c9                   	leave  
 365:	c3                   	ret    

00000366 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 366:	55                   	push   %ebp
 367:	89 e5                	mov    %esp,%ebp
 369:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 36c:	8b 45 08             	mov    0x8(%ebp),%eax
 36f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
 372:	8b 45 0c             	mov    0xc(%ebp),%eax
 375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
 378:	eb 13                	jmp    38d <memmove+0x27>
    *dst++ = *src++;
 37a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 37d:	0f b6 10             	movzbl (%eax),%edx
 380:	8b 45 f8             	mov    -0x8(%ebp),%eax
 383:	88 10                	mov    %dl,(%eax)
 385:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 389:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
 391:	0f 9f c0             	setg   %al
 394:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
 398:	84 c0                	test   %al,%al
 39a:	75 de                	jne    37a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 39f:	c9                   	leave  
 3a0:	c3                   	ret    
 3a1:	90                   	nop
 3a2:	90                   	nop
 3a3:	90                   	nop

000003a4 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a4:	b8 01 00 00 00       	mov    $0x1,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <exit>:
SYSCALL(exit)
 3ac:	b8 02 00 00 00       	mov    $0x2,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <wait>:
SYSCALL(wait)
 3b4:	b8 03 00 00 00       	mov    $0x3,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <pipe>:
SYSCALL(pipe)
 3bc:	b8 04 00 00 00       	mov    $0x4,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <read>:
SYSCALL(read)
 3c4:	b8 05 00 00 00       	mov    $0x5,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <write>:
SYSCALL(write)
 3cc:	b8 10 00 00 00       	mov    $0x10,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <close>:
SYSCALL(close)
 3d4:	b8 15 00 00 00       	mov    $0x15,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <kill>:
SYSCALL(kill)
 3dc:	b8 06 00 00 00       	mov    $0x6,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <exec>:
SYSCALL(exec)
 3e4:	b8 07 00 00 00       	mov    $0x7,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <open>:
SYSCALL(open)
 3ec:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <mknod>:
SYSCALL(mknod)
 3f4:	b8 11 00 00 00       	mov    $0x11,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <unlink>:
SYSCALL(unlink)
 3fc:	b8 12 00 00 00       	mov    $0x12,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <fstat>:
SYSCALL(fstat)
 404:	b8 08 00 00 00       	mov    $0x8,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <link>:
SYSCALL(link)
 40c:	b8 13 00 00 00       	mov    $0x13,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <mkdir>:
SYSCALL(mkdir)
 414:	b8 14 00 00 00       	mov    $0x14,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <chdir>:
SYSCALL(chdir)
 41c:	b8 09 00 00 00       	mov    $0x9,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <dup>:
SYSCALL(dup)
 424:	b8 0a 00 00 00       	mov    $0xa,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <getpid>:
SYSCALL(getpid)
 42c:	b8 0b 00 00 00       	mov    $0xb,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <sbrk>:
SYSCALL(sbrk)
 434:	b8 0c 00 00 00       	mov    $0xc,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <sleep>:
SYSCALL(sleep)
 43c:	b8 0d 00 00 00       	mov    $0xd,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <uptime>:
SYSCALL(uptime)
 444:	b8 0e 00 00 00       	mov    $0xe,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <clone>:
SYSCALL(clone)
 44c:	b8 16 00 00 00       	mov    $0x16,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <texit>:
SYSCALL(texit)
 454:	b8 17 00 00 00       	mov    $0x17,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <tsleep>:
SYSCALL(tsleep)
 45c:	b8 18 00 00 00       	mov    $0x18,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <twakeup>:
SYSCALL(twakeup)
 464:	b8 19 00 00 00       	mov    $0x19,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 46c:	55                   	push   %ebp
 46d:	89 e5                	mov    %esp,%ebp
 46f:	83 ec 28             	sub    $0x28,%esp
 472:	8b 45 0c             	mov    0xc(%ebp),%eax
 475:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 478:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47f:	00 
 480:	8d 45 f4             	lea    -0xc(%ebp),%eax
 483:	89 44 24 04          	mov    %eax,0x4(%esp)
 487:	8b 45 08             	mov    0x8(%ebp),%eax
 48a:	89 04 24             	mov    %eax,(%esp)
 48d:	e8 3a ff ff ff       	call   3cc <write>
}
 492:	c9                   	leave  
 493:	c3                   	ret    

00000494 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	53                   	push   %ebx
 498:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 49b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4a6:	74 17                	je     4bf <printint+0x2b>
 4a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ac:	79 11                	jns    4bf <printint+0x2b>
    neg = 1;
 4ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b8:	f7 d8                	neg    %eax
 4ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bd:	eb 06                	jmp    4c5 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
 4c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
 4cc:	8b 4d ec             	mov    -0x14(%ebp),%ecx
 4cf:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4d5:	ba 00 00 00 00       	mov    $0x0,%edx
 4da:	f7 f3                	div    %ebx
 4dc:	89 d0                	mov    %edx,%eax
 4de:	0f b6 80 bc 0c 00 00 	movzbl 0xcbc(%eax),%eax
 4e5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
 4e9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
 4ed:	8b 45 10             	mov    0x10(%ebp),%eax
 4f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f6:	ba 00 00 00 00       	mov    $0x0,%edx
 4fb:	f7 75 d4             	divl   -0x2c(%ebp)
 4fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
 501:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 505:	75 c5                	jne    4cc <printint+0x38>
  if(neg)
 507:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 50b:	74 28                	je     535 <printint+0xa1>
    buf[i++] = '-';
 50d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 510:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
 515:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
 519:	eb 1a                	jmp    535 <printint+0xa1>
    putc(fd, buf[i]);
 51b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 51e:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
 523:	0f be c0             	movsbl %al,%eax
 526:	89 44 24 04          	mov    %eax,0x4(%esp)
 52a:	8b 45 08             	mov    0x8(%ebp),%eax
 52d:	89 04 24             	mov    %eax,(%esp)
 530:	e8 37 ff ff ff       	call   46c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 535:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
 539:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 53d:	79 dc                	jns    51b <printint+0x87>
    putc(fd, buf[i]);
}
 53f:	83 c4 44             	add    $0x44,%esp
 542:	5b                   	pop    %ebx
 543:	5d                   	pop    %ebp
 544:	c3                   	ret    

00000545 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 545:	55                   	push   %ebp
 546:	89 e5                	mov    %esp,%ebp
 548:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 552:	8d 45 0c             	lea    0xc(%ebp),%eax
 555:	83 c0 04             	add    $0x4,%eax
 558:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
 55b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
 562:	e9 7e 01 00 00       	jmp    6e5 <printf+0x1a0>
    c = fmt[i] & 0xff;
 567:	8b 55 0c             	mov    0xc(%ebp),%edx
 56a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 56d:	8d 04 02             	lea    (%edx,%eax,1),%eax
 570:	0f b6 00             	movzbl (%eax),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	25 ff 00 00 00       	and    $0xff,%eax
 57b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
 57e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 582:	75 2c                	jne    5b0 <printf+0x6b>
      if(c == '%'){
 584:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 588:	75 0c                	jne    596 <printf+0x51>
        state = '%';
 58a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
 591:	e9 4b 01 00 00       	jmp    6e1 <printf+0x19c>
      } else {
        putc(fd, c);
 596:	8b 45 e8             	mov    -0x18(%ebp),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a0:	8b 45 08             	mov    0x8(%ebp),%eax
 5a3:	89 04 24             	mov    %eax,(%esp)
 5a6:	e8 c1 fe ff ff       	call   46c <putc>
 5ab:	e9 31 01 00 00       	jmp    6e1 <printf+0x19c>
      }
    } else if(state == '%'){
 5b0:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
 5b4:	0f 85 27 01 00 00    	jne    6e1 <printf+0x19c>
      if(c == 'd'){
 5ba:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
 5be:	75 2d                	jne    5ed <printf+0xa8>
        printint(fd, *ap, 10, 1);
 5c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c3:	8b 00                	mov    (%eax),%eax
 5c5:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5cc:	00 
 5cd:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5d4:	00 
 5d5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d9:	8b 45 08             	mov    0x8(%ebp),%eax
 5dc:	89 04 24             	mov    %eax,(%esp)
 5df:	e8 b0 fe ff ff       	call   494 <printint>
        ap++;
 5e4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 5e8:	e9 ed 00 00 00       	jmp    6da <printf+0x195>
      } else if(c == 'x' || c == 'p'){
 5ed:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
 5f1:	74 06                	je     5f9 <printf+0xb4>
 5f3:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
 5f7:	75 2d                	jne    626 <printf+0xe1>
        printint(fd, *ap, 16, 0);
 5f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5fc:	8b 00                	mov    (%eax),%eax
 5fe:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 605:	00 
 606:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 60d:	00 
 60e:	89 44 24 04          	mov    %eax,0x4(%esp)
 612:	8b 45 08             	mov    0x8(%ebp),%eax
 615:	89 04 24             	mov    %eax,(%esp)
 618:	e8 77 fe ff ff       	call   494 <printint>
        ap++;
 61d:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 621:	e9 b4 00 00 00       	jmp    6da <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 626:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
 62a:	75 46                	jne    672 <printf+0x12d>
        s = (char*)*ap;
 62c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
 634:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
 638:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
 63c:	75 27                	jne    665 <printf+0x120>
          s = "(null)";
 63e:	c7 45 e4 87 0c 00 00 	movl   $0xc87,-0x1c(%ebp)
        while(*s != 0){
 645:	eb 1f                	jmp    666 <printf+0x121>
          putc(fd, *s);
 647:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64a:	0f b6 00             	movzbl (%eax),%eax
 64d:	0f be c0             	movsbl %al,%eax
 650:	89 44 24 04          	mov    %eax,0x4(%esp)
 654:	8b 45 08             	mov    0x8(%ebp),%eax
 657:	89 04 24             	mov    %eax,(%esp)
 65a:	e8 0d fe ff ff       	call   46c <putc>
          s++;
 65f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 663:	eb 01                	jmp    666 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 665:	90                   	nop
 666:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 669:	0f b6 00             	movzbl (%eax),%eax
 66c:	84 c0                	test   %al,%al
 66e:	75 d7                	jne    647 <printf+0x102>
 670:	eb 68                	jmp    6da <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 672:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
 676:	75 1d                	jne    695 <printf+0x150>
        putc(fd, *ap);
 678:	8b 45 f4             	mov    -0xc(%ebp),%eax
 67b:	8b 00                	mov    (%eax),%eax
 67d:	0f be c0             	movsbl %al,%eax
 680:	89 44 24 04          	mov    %eax,0x4(%esp)
 684:	8b 45 08             	mov    0x8(%ebp),%eax
 687:	89 04 24             	mov    %eax,(%esp)
 68a:	e8 dd fd ff ff       	call   46c <putc>
        ap++;
 68f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
 693:	eb 45                	jmp    6da <printf+0x195>
      } else if(c == '%'){
 695:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
 699:	75 17                	jne    6b2 <printf+0x16d>
        putc(fd, c);
 69b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69e:	0f be c0             	movsbl %al,%eax
 6a1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a5:	8b 45 08             	mov    0x8(%ebp),%eax
 6a8:	89 04 24             	mov    %eax,(%esp)
 6ab:	e8 bc fd ff ff       	call   46c <putc>
 6b0:	eb 28                	jmp    6da <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6b2:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6b9:	00 
 6ba:	8b 45 08             	mov    0x8(%ebp),%eax
 6bd:	89 04 24             	mov    %eax,(%esp)
 6c0:	e8 a7 fd ff ff       	call   46c <putc>
        putc(fd, c);
 6c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c8:	0f be c0             	movsbl %al,%eax
 6cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cf:	8b 45 08             	mov    0x8(%ebp),%eax
 6d2:	89 04 24             	mov    %eax,(%esp)
 6d5:	e8 92 fd ff ff       	call   46c <putc>
      }
      state = 0;
 6da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6e1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
 6e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6eb:	8d 04 02             	lea    (%edx,%eax,1),%eax
 6ee:	0f b6 00             	movzbl (%eax),%eax
 6f1:	84 c0                	test   %al,%al
 6f3:	0f 85 6e fe ff ff    	jne    567 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6f9:	c9                   	leave  
 6fa:	c3                   	ret    
 6fb:	90                   	nop

000006fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6fc:	55                   	push   %ebp
 6fd:	89 e5                	mov    %esp,%ebp
 6ff:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 702:	8b 45 08             	mov    0x8(%ebp),%eax
 705:	83 e8 08             	sub    $0x8,%eax
 708:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70b:	a1 e0 0c 00 00       	mov    0xce0,%eax
 710:	89 45 fc             	mov    %eax,-0x4(%ebp)
 713:	eb 24                	jmp    739 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	8b 00                	mov    (%eax),%eax
 71a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71d:	77 12                	ja     731 <free+0x35>
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 725:	77 24                	ja     74b <free+0x4f>
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72f:	77 1a                	ja     74b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	8b 45 fc             	mov    -0x4(%ebp),%eax
 734:	8b 00                	mov    (%eax),%eax
 736:	89 45 fc             	mov    %eax,-0x4(%ebp)
 739:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 73f:	76 d4                	jbe    715 <free+0x19>
 741:	8b 45 fc             	mov    -0x4(%ebp),%eax
 744:	8b 00                	mov    (%eax),%eax
 746:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 749:	76 ca                	jbe    715 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 74b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	c1 e0 03             	shl    $0x3,%eax
 754:	89 c2                	mov    %eax,%edx
 756:	03 55 f8             	add    -0x8(%ebp),%edx
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	39 c2                	cmp    %eax,%edx
 760:	75 24                	jne    786 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
 762:	8b 45 f8             	mov    -0x8(%ebp),%eax
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76b:	8b 00                	mov    (%eax),%eax
 76d:	8b 40 04             	mov    0x4(%eax),%eax
 770:	01 c2                	add    %eax,%edx
 772:	8b 45 f8             	mov    -0x8(%ebp),%eax
 775:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 778:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77b:	8b 00                	mov    (%eax),%eax
 77d:	8b 10                	mov    (%eax),%edx
 77f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 782:	89 10                	mov    %edx,(%eax)
 784:	eb 0a                	jmp    790 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	8b 10                	mov    (%eax),%edx
 78b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 790:	8b 45 fc             	mov    -0x4(%ebp),%eax
 793:	8b 40 04             	mov    0x4(%eax),%eax
 796:	c1 e0 03             	shl    $0x3,%eax
 799:	03 45 fc             	add    -0x4(%ebp),%eax
 79c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 79f:	75 20                	jne    7c1 <free+0xc5>
    p->s.size += bp->s.size;
 7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a4:	8b 50 04             	mov    0x4(%eax),%edx
 7a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7aa:	8b 40 04             	mov    0x4(%eax),%eax
 7ad:	01 c2                	add    %eax,%edx
 7af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b8:	8b 10                	mov    (%eax),%edx
 7ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bd:	89 10                	mov    %edx,(%eax)
 7bf:	eb 08                	jmp    7c9 <free+0xcd>
  } else
    p->s.ptr = bp;
 7c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	a3 e0 0c 00 00       	mov    %eax,0xce0
}
 7d1:	c9                   	leave  
 7d2:	c3                   	ret    

000007d3 <morecore>:

static Header*
morecore(uint nu)
{
 7d3:	55                   	push   %ebp
 7d4:	89 e5                	mov    %esp,%ebp
 7d6:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7d9:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e0:	77 07                	ja     7e9 <morecore+0x16>
    nu = 4096;
 7e2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ec:	c1 e0 03             	shl    $0x3,%eax
 7ef:	89 04 24             	mov    %eax,(%esp)
 7f2:	e8 3d fc ff ff       	call   434 <sbrk>
 7f7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
 7fa:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
 7fe:	75 07                	jne    807 <morecore+0x34>
    return 0;
 800:	b8 00 00 00 00       	mov    $0x0,%eax
 805:	eb 22                	jmp    829 <morecore+0x56>
  hp = (Header*)p;
 807:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
 80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 810:	8b 55 08             	mov    0x8(%ebp),%edx
 813:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	83 c0 08             	add    $0x8,%eax
 81c:	89 04 24             	mov    %eax,(%esp)
 81f:	e8 d8 fe ff ff       	call   6fc <free>
  return freep;
 824:	a1 e0 0c 00 00       	mov    0xce0,%eax
}
 829:	c9                   	leave  
 82a:	c3                   	ret    

0000082b <malloc>:

void*
malloc(uint nbytes)
{
 82b:	55                   	push   %ebp
 82c:	89 e5                	mov    %esp,%ebp
 82e:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 831:	8b 45 08             	mov    0x8(%ebp),%eax
 834:	83 c0 07             	add    $0x7,%eax
 837:	c1 e8 03             	shr    $0x3,%eax
 83a:	83 c0 01             	add    $0x1,%eax
 83d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
 840:	a1 e0 0c 00 00       	mov    0xce0,%eax
 845:	89 45 f0             	mov    %eax,-0x10(%ebp)
 848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 84c:	75 23                	jne    871 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 84e:	c7 45 f0 d8 0c 00 00 	movl   $0xcd8,-0x10(%ebp)
 855:	8b 45 f0             	mov    -0x10(%ebp),%eax
 858:	a3 e0 0c 00 00       	mov    %eax,0xce0
 85d:	a1 e0 0c 00 00       	mov    0xce0,%eax
 862:	a3 d8 0c 00 00       	mov    %eax,0xcd8
    base.s.size = 0;
 867:	c7 05 dc 0c 00 00 00 	movl   $0x0,0xcdc
 86e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 871:	8b 45 f0             	mov    -0x10(%ebp),%eax
 874:	8b 00                	mov    (%eax),%eax
 876:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
 879:	8b 45 ec             	mov    -0x14(%ebp),%eax
 87c:	8b 40 04             	mov    0x4(%eax),%eax
 87f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 882:	72 4d                	jb     8d1 <malloc+0xa6>
      if(p->s.size == nunits)
 884:	8b 45 ec             	mov    -0x14(%ebp),%eax
 887:	8b 40 04             	mov    0x4(%eax),%eax
 88a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
 88d:	75 0c                	jne    89b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 88f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 892:	8b 10                	mov    (%eax),%edx
 894:	8b 45 f0             	mov    -0x10(%ebp),%eax
 897:	89 10                	mov    %edx,(%eax)
 899:	eb 26                	jmp    8c1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 89b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 89e:	8b 40 04             	mov    0x4(%eax),%eax
 8a1:	89 c2                	mov    %eax,%edx
 8a3:	2b 55 f4             	sub    -0xc(%ebp),%edx
 8a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8a9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8ac:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8af:	8b 40 04             	mov    0x4(%eax),%eax
 8b2:	c1 e0 03             	shl    $0x3,%eax
 8b5:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
 8b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 8be:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c4:	a3 e0 0c 00 00       	mov    %eax,0xce0
      return (void*)(p + 1);
 8c9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8cc:	83 c0 08             	add    $0x8,%eax
 8cf:	eb 38                	jmp    909 <malloc+0xde>
    }
    if(p == freep)
 8d1:	a1 e0 0c 00 00       	mov    0xce0,%eax
 8d6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8d9:	75 1b                	jne    8f6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8de:	89 04 24             	mov    %eax,(%esp)
 8e1:	e8 ed fe ff ff       	call   7d3 <morecore>
 8e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 8e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 8ed:	75 07                	jne    8f6 <malloc+0xcb>
        return 0;
 8ef:	b8 00 00 00 00       	mov    $0x0,%eax
 8f4:	eb 13                	jmp    909 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8ff:	8b 00                	mov    (%eax),%eax
 901:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 904:	e9 70 ff ff ff       	jmp    879 <malloc+0x4e>
}
 909:	c9                   	leave  
 90a:	c3                   	ret    
 90b:	90                   	nop

0000090c <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
 90c:	55                   	push   %ebp
 90d:	89 e5                	mov    %esp,%ebp
 90f:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
 912:	8b 55 08             	mov    0x8(%ebp),%edx
 915:	8b 45 0c             	mov    0xc(%ebp),%eax
 918:	8b 4d 08             	mov    0x8(%ebp),%ecx
 91b:	f0 87 02             	lock xchg %eax,(%edx)
 91e:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
 921:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 924:	c9                   	leave  
 925:	c3                   	ret    

00000926 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
 926:	55                   	push   %ebp
 927:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
 929:	8b 45 08             	mov    0x8(%ebp),%eax
 92c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
 932:	5d                   	pop    %ebp
 933:	c3                   	ret    

00000934 <lock_acquire>:
void lock_acquire(lock_t *lock){
 934:	55                   	push   %ebp
 935:	89 e5                	mov    %esp,%ebp
 937:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
 93a:	8b 45 08             	mov    0x8(%ebp),%eax
 93d:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
 944:	00 
 945:	89 04 24             	mov    %eax,(%esp)
 948:	e8 bf ff ff ff       	call   90c <xchg>
 94d:	85 c0                	test   %eax,%eax
 94f:	75 e9                	jne    93a <lock_acquire+0x6>
}
 951:	c9                   	leave  
 952:	c3                   	ret    

00000953 <lock_release>:
void lock_release(lock_t *lock){
 953:	55                   	push   %ebp
 954:	89 e5                	mov    %esp,%ebp
 956:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
 959:	8b 45 08             	mov    0x8(%ebp),%eax
 95c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 963:	00 
 964:	89 04 24             	mov    %eax,(%esp)
 967:	e8 a0 ff ff ff       	call   90c <xchg>
}
 96c:	c9                   	leave  
 96d:	c3                   	ret    

0000096e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
 96e:	55                   	push   %ebp
 96f:	89 e5                	mov    %esp,%ebp
 971:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
 974:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
 97b:	e8 ab fe ff ff       	call   82b <malloc>
 980:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
 983:	8b 45 f0             	mov    -0x10(%ebp),%eax
 986:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
 989:	8b 45 f0             	mov    -0x10(%ebp),%eax
 98c:	25 ff 0f 00 00       	and    $0xfff,%eax
 991:	85 c0                	test   %eax,%eax
 993:	74 15                	je     9aa <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
 995:	8b 45 f0             	mov    -0x10(%ebp),%eax
 998:	89 c2                	mov    %eax,%edx
 99a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
 9a0:	b8 00 10 00 00       	mov    $0x1000,%eax
 9a5:	29 d0                	sub    %edx,%eax
 9a7:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
 9aa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9ae:	75 1b                	jne    9cb <thread_create+0x5d>

        printf(1,"malloc fail \n");
 9b0:	c7 44 24 04 8e 0c 00 	movl   $0xc8e,0x4(%esp)
 9b7:	00 
 9b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9bf:	e8 81 fb ff ff       	call   545 <printf>
        return 0;
 9c4:	b8 00 00 00 00       	mov    $0x0,%eax
 9c9:	eb 6f                	jmp    a3a <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
 9cb:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 9ce:	8b 55 08             	mov    0x8(%ebp),%edx
 9d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9d4:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
 9d8:	89 54 24 08          	mov    %edx,0x8(%esp)
 9dc:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
 9e3:	00 
 9e4:	89 04 24             	mov    %eax,(%esp)
 9e7:	e8 60 fa ff ff       	call   44c <clone>
 9ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
 9ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 9f3:	79 1b                	jns    a10 <thread_create+0xa2>
        printf(1,"clone fails\n");
 9f5:	c7 44 24 04 9c 0c 00 	movl   $0xc9c,0x4(%esp)
 9fc:	00 
 9fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a04:	e8 3c fb ff ff       	call   545 <printf>
        return 0;
 a09:	b8 00 00 00 00       	mov    $0x0,%eax
 a0e:	eb 2a                	jmp    a3a <thread_create+0xcc>
    }
    if(tid > 0){
 a10:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a14:	7e 05                	jle    a1b <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
 a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a19:	eb 1f                	jmp    a3a <thread_create+0xcc>
    }
    if(tid == 0){
 a1b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 a1f:	75 14                	jne    a35 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
 a21:	c7 44 24 04 a9 0c 00 	movl   $0xca9,0x4(%esp)
 a28:	00 
 a29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a30:	e8 10 fb ff ff       	call   545 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
 a35:	b8 00 00 00 00       	mov    $0x0,%eax
}
 a3a:	c9                   	leave  
 a3b:	c3                   	ret    

00000a3c <random>:

// generate 0 -> max random number exclude max.
int random(int max){
 a3c:	55                   	push   %ebp
 a3d:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
 a3f:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 a44:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
 a4a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
 a4f:	a3 d0 0c 00 00       	mov    %eax,0xcd0
    return (int)(rands % max);
 a54:	a1 d0 0c 00 00       	mov    0xcd0,%eax
 a59:	8b 4d 08             	mov    0x8(%ebp),%ecx
 a5c:	ba 00 00 00 00       	mov    $0x0,%edx
 a61:	f7 f1                	div    %ecx
 a63:	89 d0                	mov    %edx,%eax
}
 a65:	5d                   	pop    %ebp
 a66:	c3                   	ret    
 a67:	90                   	nop

00000a68 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
 a68:	55                   	push   %ebp
 a69:	89 e5                	mov    %esp,%ebp
    q->size = 0;
 a6b:	8b 45 08             	mov    0x8(%ebp),%eax
 a6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
 a74:	8b 45 08             	mov    0x8(%ebp),%eax
 a77:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
 a7e:	8b 45 08             	mov    0x8(%ebp),%eax
 a81:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
 a88:	5d                   	pop    %ebp
 a89:	c3                   	ret    

00000a8a <add_q>:

void add_q(struct queue *q, int v){
 a8a:	55                   	push   %ebp
 a8b:	89 e5                	mov    %esp,%ebp
 a8d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
 a90:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 a97:	e8 8f fd ff ff       	call   82b <malloc>
 a9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
 a9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa2:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
 aa9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aac:	8b 55 0c             	mov    0xc(%ebp),%edx
 aaf:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
 ab1:	8b 45 08             	mov    0x8(%ebp),%eax
 ab4:	8b 40 04             	mov    0x4(%eax),%eax
 ab7:	85 c0                	test   %eax,%eax
 ab9:	75 0b                	jne    ac6 <add_q+0x3c>
        q->head = n;
 abb:	8b 45 08             	mov    0x8(%ebp),%eax
 abe:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ac1:	89 50 04             	mov    %edx,0x4(%eax)
 ac4:	eb 0c                	jmp    ad2 <add_q+0x48>
    }else{
        q->tail->next = n;
 ac6:	8b 45 08             	mov    0x8(%ebp),%eax
 ac9:	8b 40 08             	mov    0x8(%eax),%eax
 acc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 acf:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
 ad2:	8b 45 08             	mov    0x8(%ebp),%eax
 ad5:	8b 55 f4             	mov    -0xc(%ebp),%edx
 ad8:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
 adb:	8b 45 08             	mov    0x8(%ebp),%eax
 ade:	8b 00                	mov    (%eax),%eax
 ae0:	8d 50 01             	lea    0x1(%eax),%edx
 ae3:	8b 45 08             	mov    0x8(%ebp),%eax
 ae6:	89 10                	mov    %edx,(%eax)
}
 ae8:	c9                   	leave  
 ae9:	c3                   	ret    

00000aea <empty_q>:

int empty_q(struct queue *q){
 aea:	55                   	push   %ebp
 aeb:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
 aed:	8b 45 08             	mov    0x8(%ebp),%eax
 af0:	8b 00                	mov    (%eax),%eax
 af2:	85 c0                	test   %eax,%eax
 af4:	75 07                	jne    afd <empty_q+0x13>
        return 1;
 af6:	b8 01 00 00 00       	mov    $0x1,%eax
 afb:	eb 05                	jmp    b02 <empty_q+0x18>
    else
        return 0;
 afd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
 b02:	5d                   	pop    %ebp
 b03:	c3                   	ret    

00000b04 <pop_q>:
int pop_q(struct queue *q){
 b04:	55                   	push   %ebp
 b05:	89 e5                	mov    %esp,%ebp
 b07:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
 b0a:	8b 45 08             	mov    0x8(%ebp),%eax
 b0d:	89 04 24             	mov    %eax,(%esp)
 b10:	e8 d5 ff ff ff       	call   aea <empty_q>
 b15:	85 c0                	test   %eax,%eax
 b17:	75 5d                	jne    b76 <pop_q+0x72>
       val = q->head->value; 
 b19:	8b 45 08             	mov    0x8(%ebp),%eax
 b1c:	8b 40 04             	mov    0x4(%eax),%eax
 b1f:	8b 00                	mov    (%eax),%eax
 b21:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
 b24:	8b 45 08             	mov    0x8(%ebp),%eax
 b27:	8b 40 04             	mov    0x4(%eax),%eax
 b2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
 b2d:	8b 45 08             	mov    0x8(%ebp),%eax
 b30:	8b 40 04             	mov    0x4(%eax),%eax
 b33:	8b 50 04             	mov    0x4(%eax),%edx
 b36:	8b 45 08             	mov    0x8(%ebp),%eax
 b39:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
 b3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b3f:	89 04 24             	mov    %eax,(%esp)
 b42:	e8 b5 fb ff ff       	call   6fc <free>
       q->size--;
 b47:	8b 45 08             	mov    0x8(%ebp),%eax
 b4a:	8b 00                	mov    (%eax),%eax
 b4c:	8d 50 ff             	lea    -0x1(%eax),%edx
 b4f:	8b 45 08             	mov    0x8(%ebp),%eax
 b52:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
 b54:	8b 45 08             	mov    0x8(%ebp),%eax
 b57:	8b 00                	mov    (%eax),%eax
 b59:	85 c0                	test   %eax,%eax
 b5b:	75 14                	jne    b71 <pop_q+0x6d>
            q->head = 0;
 b5d:	8b 45 08             	mov    0x8(%ebp),%eax
 b60:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
 b67:	8b 45 08             	mov    0x8(%ebp),%eax
 b6a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
 b71:	8b 45 f0             	mov    -0x10(%ebp),%eax
 b74:	eb 05                	jmp    b7b <pop_q+0x77>
    }
    return -1;
 b76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
 b7b:	c9                   	leave  
 b7c:	c3                   	ret    
 b7d:	90                   	nop
 b7e:	90                   	nop
 b7f:	90                   	nop

00000b80 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock); 
 b86:	8b 45 08             	mov    0x8(%ebp),%eax
 b89:	89 04 24             	mov    %eax,(%esp)
 b8c:	e8 a3 fd ff ff       	call   934 <lock_acquire>
	if( s->count-- < 0) 
 b91:	8b 45 08             	mov    0x8(%ebp),%eax
 b94:	8b 40 04             	mov    0x4(%eax),%eax
 b97:	89 c2                	mov    %eax,%edx
 b99:	c1 ea 1f             	shr    $0x1f,%edx
 b9c:	8d 48 ff             	lea    -0x1(%eax),%ecx
 b9f:	8b 45 08             	mov    0x8(%ebp),%eax
 ba2:	89 48 04             	mov    %ecx,0x4(%eax)
 ba5:	84 d2                	test   %dl,%dl
 ba7:	74 27                	je     bd0 <sem_acquire+0x50>
	{
		add_q(&s->q, getpid()); 
 ba9:	e8 7e f8 ff ff       	call   42c <getpid>
 bae:	8b 55 08             	mov    0x8(%ebp),%edx
 bb1:	83 c2 08             	add    $0x8,%edx
 bb4:	89 44 24 04          	mov    %eax,0x4(%esp)
 bb8:	89 14 24             	mov    %edx,(%esp)
 bbb:	e8 ca fe ff ff       	call   a8a <add_q>
		lock_release(&s->lock); 
 bc0:	8b 45 08             	mov    0x8(%ebp),%eax
 bc3:	89 04 24             	mov    %eax,(%esp)
 bc6:	e8 88 fd ff ff       	call   953 <lock_release>
		tsleep(); 
 bcb:	e8 8c f8 ff ff       	call   45c <tsleep>
	} 
	lock_release(&s->lock); 
 bd0:	8b 45 08             	mov    0x8(%ebp),%eax
 bd3:	89 04 24             	mov    %eax,(%esp)
 bd6:	e8 78 fd ff ff       	call   953 <lock_release>
}
 bdb:	c9                   	leave  
 bdc:	c3                   	ret    

00000bdd <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
 bdd:	55                   	push   %ebp
 bde:	89 e5                	mov    %esp,%ebp
 be0:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock); 
 be3:	8b 45 08             	mov    0x8(%ebp),%eax
 be6:	89 04 24             	mov    %eax,(%esp)
 be9:	e8 46 fd ff ff       	call   934 <lock_acquire>
	if( s->count++ <= 0) 
 bee:	8b 45 08             	mov    0x8(%ebp),%eax
 bf1:	8b 40 04             	mov    0x4(%eax),%eax
 bf4:	85 c0                	test   %eax,%eax
 bf6:	0f 9e c2             	setle  %dl
 bf9:	8d 48 01             	lea    0x1(%eax),%ecx
 bfc:	8b 45 08             	mov    0x8(%ebp),%eax
 bff:	89 48 04             	mov    %ecx,0x4(%eax)
 c02:	84 d2                	test   %dl,%dl
 c04:	74 1c                	je     c22 <sem_signal+0x45>
	{
		int tid = pop_q(&s->q); 
 c06:	8b 45 08             	mov    0x8(%ebp),%eax
 c09:	83 c0 08             	add    $0x8,%eax
 c0c:	89 04 24             	mov    %eax,(%esp)
 c0f:	e8 f0 fe ff ff       	call   b04 <pop_q>
 c14:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
 c17:	8b 45 f4             	mov    -0xc(%ebp),%eax
 c1a:	89 04 24             	mov    %eax,(%esp)
 c1d:	e8 42 f8 ff ff       	call   464 <twakeup>
	}
	lock_release(&s->lock); 
 c22:	8b 45 08             	mov    0x8(%ebp),%eax
 c25:	89 04 24             	mov    %eax,(%esp)
 c28:	e8 26 fd ff ff       	call   953 <lock_release>
} 
 c2d:	c9                   	leave  
 c2e:	c3                   	ret    

00000c2f <sem_init>:

void sem_init(struct Semaphore *s, int size){
 c2f:	55                   	push   %ebp
 c30:	89 e5                	mov    %esp,%ebp
 c32:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
 c35:	8b 45 08             	mov    0x8(%ebp),%eax
 c38:	89 04 24             	mov    %eax,(%esp)
 c3b:	e8 e6 fc ff ff       	call   926 <lock_init>
	s->count = size; 
 c40:	8b 45 08             	mov    0x8(%ebp),%eax
 c43:	8b 55 0c             	mov    0xc(%ebp),%edx
 c46:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
 c49:	8b 45 08             	mov    0x8(%ebp),%eax
 c4c:	83 c0 08             	add    $0x8,%eax
 c4f:	89 04 24             	mov    %eax,(%esp)
 c52:	e8 11 fe ff ff       	call   a68 <init_q>
}
 c57:	c9                   	leave  
 c58:	c3                   	ret    
