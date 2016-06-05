
_test_sleep:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
    int total;
}ttable;

void func(void *arg_ptr);

int main(int argc, char *argv[]){
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
    struct thread * t;
    int i;
    printf(1,"init ttable\n");
    1009:	c7 44 24 04 04 1d 00 	movl   $0x1d04,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1018:	e8 d0 05 00 00       	call   15ed <printf>
    lock_init(&ttable.lock);
    101d:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    1024:	e8 a5 09 00 00       	call   19ce <lock_init>
    ttable.total = 0;
    1029:	c7 05 24 1f 00 00 00 	movl   $0x0,0x1f24
    1030:	00 00 00 

    lock_acquire(&ttable.lock);
    1033:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    103a:	e8 9d 09 00 00       	call   19dc <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    103f:	c7 44 24 14 24 1e 00 	movl   $0x1e24,0x14(%esp)
    1046:	00 
    1047:	eb 0f                	jmp    1058 <main+0x58>
        t->tid = 0;
    1049:	8b 44 24 14          	mov    0x14(%esp),%eax
    104d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    printf(1,"init ttable\n");
    lock_init(&ttable.lock);
    ttable.total = 0;

    lock_acquire(&ttable.lock);
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    1053:	83 44 24 14 04       	addl   $0x4,0x14(%esp)
    1058:	b8 24 1f 00 00       	mov    $0x1f24,%eax
    105d:	39 44 24 14          	cmp    %eax,0x14(%esp)
    1061:	72 e6                	jb     1049 <main+0x49>
        t->tid = 0;
    }
    lock_release(&ttable.lock);
    1063:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    106a:	e8 8c 09 00 00       	call   19fb <lock_release>
    printf(1,"testing thread sleep and wakeup \n\n\n");
    106f:	c7 44 24 04 14 1d 00 	movl   $0x1d14,0x4(%esp)
    1076:	00 
    1077:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    107e:	e8 6a 05 00 00       	call   15ed <printf>
    void *stack = thread_create(func,0);
    1083:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    108a:	00 
    108b:	c7 04 24 6c 11 00 00 	movl   $0x116c,(%esp)
    1092:	e8 7f 09 00 00       	call   1a16 <thread_create>
    1097:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    thread_create(func,0);
    109b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10a2:	00 
    10a3:	c7 04 24 6c 11 00 00 	movl   $0x116c,(%esp)
    10aa:	e8 67 09 00 00       	call   1a16 <thread_create>
    thread_create(func,0);
    10af:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10b6:	00 
    10b7:	c7 04 24 6c 11 00 00 	movl   $0x116c,(%esp)
    10be:	e8 53 09 00 00       	call   1a16 <thread_create>

    i=0;
    10c3:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
    10ca:	00 
    while(i++ < 1000000);
    10cb:	81 7c 24 18 3f 42 0f 	cmpl   $0xf423f,0x18(%esp)
    10d2:	00 
    10d3:	0f 9e c0             	setle  %al
    10d6:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
    10db:	84 c0                	test   %al,%al
    10dd:	75 ec                	jne    10cb <main+0xcb>
    //find that thread
    lock_acquire(&ttable.lock);
    10df:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    10e6:	e8 f1 08 00 00       	call   19dc <lock_acquire>
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    10eb:	c7 44 24 14 24 1e 00 	movl   $0x1e24,0x14(%esp)
    10f2:	00 
    10f3:	eb 40                	jmp    1135 <main+0x135>
        if(t->tid != 0){
    10f5:	8b 44 24 14          	mov    0x14(%esp),%eax
    10f9:	8b 00                	mov    (%eax),%eax
    10fb:	85 c0                	test   %eax,%eax
    10fd:	74 31                	je     1130 <main+0x130>
            printf(1,"found one... %d,   wake up lazy boy !!!\n",t->tid);
    10ff:	8b 44 24 14          	mov    0x14(%esp),%eax
    1103:	8b 00                	mov    (%eax),%eax
    1105:	89 44 24 08          	mov    %eax,0x8(%esp)
    1109:	c7 44 24 04 38 1d 00 	movl   $0x1d38,0x4(%esp)
    1110:	00 
    1111:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1118:	e8 d0 04 00 00       	call   15ed <printf>
            twakeup(t->tid);
    111d:	8b 44 24 14          	mov    0x14(%esp),%eax
    1121:	8b 00                	mov    (%eax),%eax
    1123:	89 04 24             	mov    %eax,(%esp)
    1126:	e8 d9 03 00 00       	call   1504 <twakeup>
            i++;
    112b:	83 44 24 18 01       	addl   $0x1,0x18(%esp)

    i=0;
    while(i++ < 1000000);
    //find that thread
    lock_acquire(&ttable.lock);
    for(t=ttable.threads;t < &ttable.threads[64];t++){
    1130:	83 44 24 14 04       	addl   $0x4,0x14(%esp)
    1135:	b8 24 1f 00 00       	mov    $0x1f24,%eax
    113a:	39 44 24 14          	cmp    %eax,0x14(%esp)
    113e:	72 b5                	jb     10f5 <main+0xf5>
            printf(1,"found one... %d,   wake up lazy boy !!!\n",t->tid);
            twakeup(t->tid);
            i++;
        }
    }
    lock_release(&ttable.lock);
    1140:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    1147:	e8 af 08 00 00       	call   19fb <lock_release>
    wait();
    114c:	e8 03 03 00 00       	call   1454 <wait>
    wait();
    1151:	e8 fe 02 00 00       	call   1454 <wait>
    wait();
    1156:	e8 f9 02 00 00       	call   1454 <wait>
    free(stack);
    115b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
    115f:	89 04 24             	mov    %eax,(%esp)
    1162:	e8 3d 06 00 00       	call   17a4 <free>
    exit();
    1167:	e8 e0 02 00 00       	call   144c <exit>

0000116c <func>:
}

void func(void *arg_ptr){
    116c:	55                   	push   %ebp
    116d:	89 e5                	mov    %esp,%ebp
    116f:	83 ec 28             	sub    $0x28,%esp
    int tid;
    tid = getpid();
    1172:	e8 55 03 00 00       	call   14cc <getpid>
    1177:	89 45 f4             	mov    %eax,-0xc(%ebp)
    lock_acquire(&ttable.lock);
    117a:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    1181:	e8 56 08 00 00       	call   19dc <lock_acquire>
    (ttable.threads[ttable.total]).tid = tid;
    1186:	a1 24 1f 00 00       	mov    0x1f24,%eax
    118b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    118e:	89 14 85 24 1e 00 00 	mov    %edx,0x1e24(,%eax,4)
    ttable.total++;
    1195:	a1 24 1f 00 00       	mov    0x1f24,%eax
    119a:	83 c0 01             	add    $0x1,%eax
    119d:	a3 24 1f 00 00       	mov    %eax,0x1f24
    lock_release(&ttable.lock);
    11a2:	c7 04 24 20 1e 00 00 	movl   $0x1e20,(%esp)
    11a9:	e8 4d 08 00 00       	call   19fb <lock_release>

    printf(1,"I am thread %d, is about to sleep\n",tid);
    11ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11b1:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b5:	c7 44 24 04 64 1d 00 	movl   $0x1d64,0x4(%esp)
    11bc:	00 
    11bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c4:	e8 24 04 00 00       	call   15ed <printf>
    tsleep();
    11c9:	e8 2e 03 00 00       	call   14fc <tsleep>
    printf(1,"I am wake up!\n");
    11ce:	c7 44 24 04 87 1d 00 	movl   $0x1d87,0x4(%esp)
    11d5:	00 
    11d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11dd:	e8 0b 04 00 00       	call   15ed <printf>
    texit();
    11e2:	e8 0d 03 00 00       	call   14f4 <texit>
    11e7:	90                   	nop

000011e8 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    11e8:	55                   	push   %ebp
    11e9:	89 e5                	mov    %esp,%ebp
    11eb:	57                   	push   %edi
    11ec:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    11ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
    11f0:	8b 55 10             	mov    0x10(%ebp),%edx
    11f3:	8b 45 0c             	mov    0xc(%ebp),%eax
    11f6:	89 cb                	mov    %ecx,%ebx
    11f8:	89 df                	mov    %ebx,%edi
    11fa:	89 d1                	mov    %edx,%ecx
    11fc:	fc                   	cld    
    11fd:	f3 aa                	rep stos %al,%es:(%edi)
    11ff:	89 ca                	mov    %ecx,%edx
    1201:	89 fb                	mov    %edi,%ebx
    1203:	89 5d 08             	mov    %ebx,0x8(%ebp)
    1206:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1209:	5b                   	pop    %ebx
    120a:	5f                   	pop    %edi
    120b:	5d                   	pop    %ebp
    120c:	c3                   	ret    

0000120d <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    120d:	55                   	push   %ebp
    120e:	89 e5                	mov    %esp,%ebp
    1210:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1213:	8b 45 08             	mov    0x8(%ebp),%eax
    1216:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1219:	8b 45 0c             	mov    0xc(%ebp),%eax
    121c:	0f b6 10             	movzbl (%eax),%edx
    121f:	8b 45 08             	mov    0x8(%ebp),%eax
    1222:	88 10                	mov    %dl,(%eax)
    1224:	8b 45 08             	mov    0x8(%ebp),%eax
    1227:	0f b6 00             	movzbl (%eax),%eax
    122a:	84 c0                	test   %al,%al
    122c:	0f 95 c0             	setne  %al
    122f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1233:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    1237:	84 c0                	test   %al,%al
    1239:	75 de                	jne    1219 <strcpy+0xc>
    ;
  return os;
    123b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    123e:	c9                   	leave  
    123f:	c3                   	ret    

00001240 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1240:	55                   	push   %ebp
    1241:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1243:	eb 08                	jmp    124d <strcmp+0xd>
    p++, q++;
    1245:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1249:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    124d:	8b 45 08             	mov    0x8(%ebp),%eax
    1250:	0f b6 00             	movzbl (%eax),%eax
    1253:	84 c0                	test   %al,%al
    1255:	74 10                	je     1267 <strcmp+0x27>
    1257:	8b 45 08             	mov    0x8(%ebp),%eax
    125a:	0f b6 10             	movzbl (%eax),%edx
    125d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1260:	0f b6 00             	movzbl (%eax),%eax
    1263:	38 c2                	cmp    %al,%dl
    1265:	74 de                	je     1245 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    1267:	8b 45 08             	mov    0x8(%ebp),%eax
    126a:	0f b6 00             	movzbl (%eax),%eax
    126d:	0f b6 d0             	movzbl %al,%edx
    1270:	8b 45 0c             	mov    0xc(%ebp),%eax
    1273:	0f b6 00             	movzbl (%eax),%eax
    1276:	0f b6 c0             	movzbl %al,%eax
    1279:	89 d1                	mov    %edx,%ecx
    127b:	29 c1                	sub    %eax,%ecx
    127d:	89 c8                	mov    %ecx,%eax
}
    127f:	5d                   	pop    %ebp
    1280:	c3                   	ret    

00001281 <strlen>:

uint
strlen(char *s)
{
    1281:	55                   	push   %ebp
    1282:	89 e5                	mov    %esp,%ebp
    1284:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    1287:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    128e:	eb 04                	jmp    1294 <strlen+0x13>
    1290:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    1294:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1297:	03 45 08             	add    0x8(%ebp),%eax
    129a:	0f b6 00             	movzbl (%eax),%eax
    129d:	84 c0                	test   %al,%al
    129f:	75 ef                	jne    1290 <strlen+0xf>
    ;
  return n;
    12a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    12a4:	c9                   	leave  
    12a5:	c3                   	ret    

000012a6 <memset>:

void*
memset(void *dst, int c, uint n)
{
    12a6:	55                   	push   %ebp
    12a7:	89 e5                	mov    %esp,%ebp
    12a9:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    12ac:	8b 45 10             	mov    0x10(%ebp),%eax
    12af:	89 44 24 08          	mov    %eax,0x8(%esp)
    12b3:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b6:	89 44 24 04          	mov    %eax,0x4(%esp)
    12ba:	8b 45 08             	mov    0x8(%ebp),%eax
    12bd:	89 04 24             	mov    %eax,(%esp)
    12c0:	e8 23 ff ff ff       	call   11e8 <stosb>
  return dst;
    12c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
    12c8:	c9                   	leave  
    12c9:	c3                   	ret    

000012ca <strchr>:

char*
strchr(const char *s, char c)
{
    12ca:	55                   	push   %ebp
    12cb:	89 e5                	mov    %esp,%ebp
    12cd:	83 ec 04             	sub    $0x4,%esp
    12d0:	8b 45 0c             	mov    0xc(%ebp),%eax
    12d3:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    12d6:	eb 14                	jmp    12ec <strchr+0x22>
    if(*s == c)
    12d8:	8b 45 08             	mov    0x8(%ebp),%eax
    12db:	0f b6 00             	movzbl (%eax),%eax
    12de:	3a 45 fc             	cmp    -0x4(%ebp),%al
    12e1:	75 05                	jne    12e8 <strchr+0x1e>
      return (char*)s;
    12e3:	8b 45 08             	mov    0x8(%ebp),%eax
    12e6:	eb 13                	jmp    12fb <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    12e8:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    12ec:	8b 45 08             	mov    0x8(%ebp),%eax
    12ef:	0f b6 00             	movzbl (%eax),%eax
    12f2:	84 c0                	test   %al,%al
    12f4:	75 e2                	jne    12d8 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    12f6:	b8 00 00 00 00       	mov    $0x0,%eax
}
    12fb:	c9                   	leave  
    12fc:	c3                   	ret    

000012fd <gets>:

char*
gets(char *buf, int max)
{
    12fd:	55                   	push   %ebp
    12fe:	89 e5                	mov    %esp,%ebp
    1300:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1303:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    130a:	eb 44                	jmp    1350 <gets+0x53>
    cc = read(0, &c, 1);
    130c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1313:	00 
    1314:	8d 45 ef             	lea    -0x11(%ebp),%eax
    1317:	89 44 24 04          	mov    %eax,0x4(%esp)
    131b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1322:	e8 3d 01 00 00       	call   1464 <read>
    1327:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    132a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    132e:	7e 2d                	jle    135d <gets+0x60>
      break;
    buf[i++] = c;
    1330:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1333:	03 45 08             	add    0x8(%ebp),%eax
    1336:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    133a:	88 10                	mov    %dl,(%eax)
    133c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1340:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1344:	3c 0a                	cmp    $0xa,%al
    1346:	74 16                	je     135e <gets+0x61>
    1348:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    134c:	3c 0d                	cmp    $0xd,%al
    134e:	74 0e                	je     135e <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1350:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1353:	83 c0 01             	add    $0x1,%eax
    1356:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1359:	7c b1                	jl     130c <gets+0xf>
    135b:	eb 01                	jmp    135e <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    135d:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    135e:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1361:	03 45 08             	add    0x8(%ebp),%eax
    1364:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    1367:	8b 45 08             	mov    0x8(%ebp),%eax
}
    136a:	c9                   	leave  
    136b:	c3                   	ret    

0000136c <stat>:

int
stat(char *n, struct stat *st)
{
    136c:	55                   	push   %ebp
    136d:	89 e5                	mov    %esp,%ebp
    136f:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1372:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1379:	00 
    137a:	8b 45 08             	mov    0x8(%ebp),%eax
    137d:	89 04 24             	mov    %eax,(%esp)
    1380:	e8 07 01 00 00       	call   148c <open>
    1385:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    1388:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    138c:	79 07                	jns    1395 <stat+0x29>
    return -1;
    138e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    1393:	eb 23                	jmp    13b8 <stat+0x4c>
  r = fstat(fd, st);
    1395:	8b 45 0c             	mov    0xc(%ebp),%eax
    1398:	89 44 24 04          	mov    %eax,0x4(%esp)
    139c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    139f:	89 04 24             	mov    %eax,(%esp)
    13a2:	e8 fd 00 00 00       	call   14a4 <fstat>
    13a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    13aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
    13ad:	89 04 24             	mov    %eax,(%esp)
    13b0:	e8 bf 00 00 00       	call   1474 <close>
  return r;
    13b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    13b8:	c9                   	leave  
    13b9:	c3                   	ret    

000013ba <atoi>:

int
atoi(const char *s)
{
    13ba:	55                   	push   %ebp
    13bb:	89 e5                	mov    %esp,%ebp
    13bd:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    13c0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    13c7:	eb 24                	jmp    13ed <atoi+0x33>
    n = n*10 + *s++ - '0';
    13c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
    13cc:	89 d0                	mov    %edx,%eax
    13ce:	c1 e0 02             	shl    $0x2,%eax
    13d1:	01 d0                	add    %edx,%eax
    13d3:	01 c0                	add    %eax,%eax
    13d5:	89 c2                	mov    %eax,%edx
    13d7:	8b 45 08             	mov    0x8(%ebp),%eax
    13da:	0f b6 00             	movzbl (%eax),%eax
    13dd:	0f be c0             	movsbl %al,%eax
    13e0:	8d 04 02             	lea    (%edx,%eax,1),%eax
    13e3:	83 e8 30             	sub    $0x30,%eax
    13e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    13e9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    13ed:	8b 45 08             	mov    0x8(%ebp),%eax
    13f0:	0f b6 00             	movzbl (%eax),%eax
    13f3:	3c 2f                	cmp    $0x2f,%al
    13f5:	7e 0a                	jle    1401 <atoi+0x47>
    13f7:	8b 45 08             	mov    0x8(%ebp),%eax
    13fa:	0f b6 00             	movzbl (%eax),%eax
    13fd:	3c 39                	cmp    $0x39,%al
    13ff:	7e c8                	jle    13c9 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1401:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1404:	c9                   	leave  
    1405:	c3                   	ret    

00001406 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1406:	55                   	push   %ebp
    1407:	89 e5                	mov    %esp,%ebp
    1409:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    140c:	8b 45 08             	mov    0x8(%ebp),%eax
    140f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1412:	8b 45 0c             	mov    0xc(%ebp),%eax
    1415:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1418:	eb 13                	jmp    142d <memmove+0x27>
    *dst++ = *src++;
    141a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    141d:	0f b6 10             	movzbl (%eax),%edx
    1420:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1423:	88 10                	mov    %dl,(%eax)
    1425:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1429:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    142d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1431:	0f 9f c0             	setg   %al
    1434:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1438:	84 c0                	test   %al,%al
    143a:	75 de                	jne    141a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    143c:	8b 45 08             	mov    0x8(%ebp),%eax
}
    143f:	c9                   	leave  
    1440:	c3                   	ret    
    1441:	90                   	nop
    1442:	90                   	nop
    1443:	90                   	nop

00001444 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1444:	b8 01 00 00 00       	mov    $0x1,%eax
    1449:	cd 40                	int    $0x40
    144b:	c3                   	ret    

0000144c <exit>:
SYSCALL(exit)
    144c:	b8 02 00 00 00       	mov    $0x2,%eax
    1451:	cd 40                	int    $0x40
    1453:	c3                   	ret    

00001454 <wait>:
SYSCALL(wait)
    1454:	b8 03 00 00 00       	mov    $0x3,%eax
    1459:	cd 40                	int    $0x40
    145b:	c3                   	ret    

0000145c <pipe>:
SYSCALL(pipe)
    145c:	b8 04 00 00 00       	mov    $0x4,%eax
    1461:	cd 40                	int    $0x40
    1463:	c3                   	ret    

00001464 <read>:
SYSCALL(read)
    1464:	b8 05 00 00 00       	mov    $0x5,%eax
    1469:	cd 40                	int    $0x40
    146b:	c3                   	ret    

0000146c <write>:
SYSCALL(write)
    146c:	b8 10 00 00 00       	mov    $0x10,%eax
    1471:	cd 40                	int    $0x40
    1473:	c3                   	ret    

00001474 <close>:
SYSCALL(close)
    1474:	b8 15 00 00 00       	mov    $0x15,%eax
    1479:	cd 40                	int    $0x40
    147b:	c3                   	ret    

0000147c <kill>:
SYSCALL(kill)
    147c:	b8 06 00 00 00       	mov    $0x6,%eax
    1481:	cd 40                	int    $0x40
    1483:	c3                   	ret    

00001484 <exec>:
SYSCALL(exec)
    1484:	b8 07 00 00 00       	mov    $0x7,%eax
    1489:	cd 40                	int    $0x40
    148b:	c3                   	ret    

0000148c <open>:
SYSCALL(open)
    148c:	b8 0f 00 00 00       	mov    $0xf,%eax
    1491:	cd 40                	int    $0x40
    1493:	c3                   	ret    

00001494 <mknod>:
SYSCALL(mknod)
    1494:	b8 11 00 00 00       	mov    $0x11,%eax
    1499:	cd 40                	int    $0x40
    149b:	c3                   	ret    

0000149c <unlink>:
SYSCALL(unlink)
    149c:	b8 12 00 00 00       	mov    $0x12,%eax
    14a1:	cd 40                	int    $0x40
    14a3:	c3                   	ret    

000014a4 <fstat>:
SYSCALL(fstat)
    14a4:	b8 08 00 00 00       	mov    $0x8,%eax
    14a9:	cd 40                	int    $0x40
    14ab:	c3                   	ret    

000014ac <link>:
SYSCALL(link)
    14ac:	b8 13 00 00 00       	mov    $0x13,%eax
    14b1:	cd 40                	int    $0x40
    14b3:	c3                   	ret    

000014b4 <mkdir>:
SYSCALL(mkdir)
    14b4:	b8 14 00 00 00       	mov    $0x14,%eax
    14b9:	cd 40                	int    $0x40
    14bb:	c3                   	ret    

000014bc <chdir>:
SYSCALL(chdir)
    14bc:	b8 09 00 00 00       	mov    $0x9,%eax
    14c1:	cd 40                	int    $0x40
    14c3:	c3                   	ret    

000014c4 <dup>:
SYSCALL(dup)
    14c4:	b8 0a 00 00 00       	mov    $0xa,%eax
    14c9:	cd 40                	int    $0x40
    14cb:	c3                   	ret    

000014cc <getpid>:
SYSCALL(getpid)
    14cc:	b8 0b 00 00 00       	mov    $0xb,%eax
    14d1:	cd 40                	int    $0x40
    14d3:	c3                   	ret    

000014d4 <sbrk>:
SYSCALL(sbrk)
    14d4:	b8 0c 00 00 00       	mov    $0xc,%eax
    14d9:	cd 40                	int    $0x40
    14db:	c3                   	ret    

000014dc <sleep>:
SYSCALL(sleep)
    14dc:	b8 0d 00 00 00       	mov    $0xd,%eax
    14e1:	cd 40                	int    $0x40
    14e3:	c3                   	ret    

000014e4 <uptime>:
SYSCALL(uptime)
    14e4:	b8 0e 00 00 00       	mov    $0xe,%eax
    14e9:	cd 40                	int    $0x40
    14eb:	c3                   	ret    

000014ec <clone>:
SYSCALL(clone)
    14ec:	b8 16 00 00 00       	mov    $0x16,%eax
    14f1:	cd 40                	int    $0x40
    14f3:	c3                   	ret    

000014f4 <texit>:
SYSCALL(texit)
    14f4:	b8 17 00 00 00       	mov    $0x17,%eax
    14f9:	cd 40                	int    $0x40
    14fb:	c3                   	ret    

000014fc <tsleep>:
SYSCALL(tsleep)
    14fc:	b8 18 00 00 00       	mov    $0x18,%eax
    1501:	cd 40                	int    $0x40
    1503:	c3                   	ret    

00001504 <twakeup>:
SYSCALL(twakeup)
    1504:	b8 19 00 00 00       	mov    $0x19,%eax
    1509:	cd 40                	int    $0x40
    150b:	c3                   	ret    

0000150c <thread_yield>:
SYSCALL(thread_yield) 
    150c:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1511:	cd 40                	int    $0x40
    1513:	c3                   	ret    

00001514 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1514:	55                   	push   %ebp
    1515:	89 e5                	mov    %esp,%ebp
    1517:	83 ec 28             	sub    $0x28,%esp
    151a:	8b 45 0c             	mov    0xc(%ebp),%eax
    151d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1520:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1527:	00 
    1528:	8d 45 f4             	lea    -0xc(%ebp),%eax
    152b:	89 44 24 04          	mov    %eax,0x4(%esp)
    152f:	8b 45 08             	mov    0x8(%ebp),%eax
    1532:	89 04 24             	mov    %eax,(%esp)
    1535:	e8 32 ff ff ff       	call   146c <write>
}
    153a:	c9                   	leave  
    153b:	c3                   	ret    

0000153c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    153c:	55                   	push   %ebp
    153d:	89 e5                	mov    %esp,%ebp
    153f:	53                   	push   %ebx
    1540:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1543:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    154a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    154e:	74 17                	je     1567 <printint+0x2b>
    1550:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1554:	79 11                	jns    1567 <printint+0x2b>
    neg = 1;
    1556:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    155d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1560:	f7 d8                	neg    %eax
    1562:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1565:	eb 06                	jmp    156d <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1567:	8b 45 0c             	mov    0xc(%ebp),%eax
    156a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    156d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    1574:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    1577:	8b 5d 10             	mov    0x10(%ebp),%ebx
    157a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    157d:	ba 00 00 00 00       	mov    $0x0,%edx
    1582:	f7 f3                	div    %ebx
    1584:	89 d0                	mov    %edx,%eax
    1586:	0f b6 80 cc 1d 00 00 	movzbl 0x1dcc(%eax),%eax
    158d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    1591:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    1595:	8b 45 10             	mov    0x10(%ebp),%eax
    1598:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    159b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    159e:	ba 00 00 00 00       	mov    $0x0,%edx
    15a3:	f7 75 d4             	divl   -0x2c(%ebp)
    15a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    15a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15ad:	75 c5                	jne    1574 <printint+0x38>
  if(neg)
    15af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    15b3:	74 28                	je     15dd <printint+0xa1>
    buf[i++] = '-';
    15b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15b8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    15bd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    15c1:	eb 1a                	jmp    15dd <printint+0xa1>
    putc(fd, buf[i]);
    15c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15c6:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    15cb:	0f be c0             	movsbl %al,%eax
    15ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d2:	8b 45 08             	mov    0x8(%ebp),%eax
    15d5:	89 04 24             	mov    %eax,(%esp)
    15d8:	e8 37 ff ff ff       	call   1514 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    15dd:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    15e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    15e5:	79 dc                	jns    15c3 <printint+0x87>
    putc(fd, buf[i]);
}
    15e7:	83 c4 44             	add    $0x44,%esp
    15ea:	5b                   	pop    %ebx
    15eb:	5d                   	pop    %ebp
    15ec:	c3                   	ret    

000015ed <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    15ed:	55                   	push   %ebp
    15ee:	89 e5                	mov    %esp,%ebp
    15f0:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    15f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    15fa:	8d 45 0c             	lea    0xc(%ebp),%eax
    15fd:	83 c0 04             	add    $0x4,%eax
    1600:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1603:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    160a:	e9 7e 01 00 00       	jmp    178d <printf+0x1a0>
    c = fmt[i] & 0xff;
    160f:	8b 55 0c             	mov    0xc(%ebp),%edx
    1612:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1615:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1618:	0f b6 00             	movzbl (%eax),%eax
    161b:	0f be c0             	movsbl %al,%eax
    161e:	25 ff 00 00 00       	and    $0xff,%eax
    1623:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    1626:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    162a:	75 2c                	jne    1658 <printf+0x6b>
      if(c == '%'){
    162c:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1630:	75 0c                	jne    163e <printf+0x51>
        state = '%';
    1632:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1639:	e9 4b 01 00 00       	jmp    1789 <printf+0x19c>
      } else {
        putc(fd, c);
    163e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1641:	0f be c0             	movsbl %al,%eax
    1644:	89 44 24 04          	mov    %eax,0x4(%esp)
    1648:	8b 45 08             	mov    0x8(%ebp),%eax
    164b:	89 04 24             	mov    %eax,(%esp)
    164e:	e8 c1 fe ff ff       	call   1514 <putc>
    1653:	e9 31 01 00 00       	jmp    1789 <printf+0x19c>
      }
    } else if(state == '%'){
    1658:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    165c:	0f 85 27 01 00 00    	jne    1789 <printf+0x19c>
      if(c == 'd'){
    1662:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    1666:	75 2d                	jne    1695 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1668:	8b 45 f4             	mov    -0xc(%ebp),%eax
    166b:	8b 00                	mov    (%eax),%eax
    166d:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    1674:	00 
    1675:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    167c:	00 
    167d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1681:	8b 45 08             	mov    0x8(%ebp),%eax
    1684:	89 04 24             	mov    %eax,(%esp)
    1687:	e8 b0 fe ff ff       	call   153c <printint>
        ap++;
    168c:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1690:	e9 ed 00 00 00       	jmp    1782 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    1695:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    1699:	74 06                	je     16a1 <printf+0xb4>
    169b:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    169f:	75 2d                	jne    16ce <printf+0xe1>
        printint(fd, *ap, 16, 0);
    16a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16a4:	8b 00                	mov    (%eax),%eax
    16a6:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    16ad:	00 
    16ae:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    16b5:	00 
    16b6:	89 44 24 04          	mov    %eax,0x4(%esp)
    16ba:	8b 45 08             	mov    0x8(%ebp),%eax
    16bd:	89 04 24             	mov    %eax,(%esp)
    16c0:	e8 77 fe ff ff       	call   153c <printint>
        ap++;
    16c5:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    16c9:	e9 b4 00 00 00       	jmp    1782 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    16ce:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    16d2:	75 46                	jne    171a <printf+0x12d>
        s = (char*)*ap;
    16d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16d7:	8b 00                	mov    (%eax),%eax
    16d9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    16dc:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    16e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    16e4:	75 27                	jne    170d <printf+0x120>
          s = "(null)";
    16e6:	c7 45 e4 96 1d 00 00 	movl   $0x1d96,-0x1c(%ebp)
        while(*s != 0){
    16ed:	eb 1f                	jmp    170e <printf+0x121>
          putc(fd, *s);
    16ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    16f2:	0f b6 00             	movzbl (%eax),%eax
    16f5:	0f be c0             	movsbl %al,%eax
    16f8:	89 44 24 04          	mov    %eax,0x4(%esp)
    16fc:	8b 45 08             	mov    0x8(%ebp),%eax
    16ff:	89 04 24             	mov    %eax,(%esp)
    1702:	e8 0d fe ff ff       	call   1514 <putc>
          s++;
    1707:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    170b:	eb 01                	jmp    170e <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    170d:	90                   	nop
    170e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1711:	0f b6 00             	movzbl (%eax),%eax
    1714:	84 c0                	test   %al,%al
    1716:	75 d7                	jne    16ef <printf+0x102>
    1718:	eb 68                	jmp    1782 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    171a:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    171e:	75 1d                	jne    173d <printf+0x150>
        putc(fd, *ap);
    1720:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1723:	8b 00                	mov    (%eax),%eax
    1725:	0f be c0             	movsbl %al,%eax
    1728:	89 44 24 04          	mov    %eax,0x4(%esp)
    172c:	8b 45 08             	mov    0x8(%ebp),%eax
    172f:	89 04 24             	mov    %eax,(%esp)
    1732:	e8 dd fd ff ff       	call   1514 <putc>
        ap++;
    1737:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    173b:	eb 45                	jmp    1782 <printf+0x195>
      } else if(c == '%'){
    173d:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1741:	75 17                	jne    175a <printf+0x16d>
        putc(fd, c);
    1743:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1746:	0f be c0             	movsbl %al,%eax
    1749:	89 44 24 04          	mov    %eax,0x4(%esp)
    174d:	8b 45 08             	mov    0x8(%ebp),%eax
    1750:	89 04 24             	mov    %eax,(%esp)
    1753:	e8 bc fd ff ff       	call   1514 <putc>
    1758:	eb 28                	jmp    1782 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    175a:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1761:	00 
    1762:	8b 45 08             	mov    0x8(%ebp),%eax
    1765:	89 04 24             	mov    %eax,(%esp)
    1768:	e8 a7 fd ff ff       	call   1514 <putc>
        putc(fd, c);
    176d:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1770:	0f be c0             	movsbl %al,%eax
    1773:	89 44 24 04          	mov    %eax,0x4(%esp)
    1777:	8b 45 08             	mov    0x8(%ebp),%eax
    177a:	89 04 24             	mov    %eax,(%esp)
    177d:	e8 92 fd ff ff       	call   1514 <putc>
      }
      state = 0;
    1782:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1789:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    178d:	8b 55 0c             	mov    0xc(%ebp),%edx
    1790:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1793:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1796:	0f b6 00             	movzbl (%eax),%eax
    1799:	84 c0                	test   %al,%al
    179b:	0f 85 6e fe ff ff    	jne    160f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    17a1:	c9                   	leave  
    17a2:	c3                   	ret    
    17a3:	90                   	nop

000017a4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    17a4:	55                   	push   %ebp
    17a5:	89 e5                	mov    %esp,%ebp
    17a7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    17aa:	8b 45 08             	mov    0x8(%ebp),%eax
    17ad:	83 e8 08             	sub    $0x8,%eax
    17b0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17b3:	a1 08 1e 00 00       	mov    0x1e08,%eax
    17b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17bb:	eb 24                	jmp    17e1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    17bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17c0:	8b 00                	mov    (%eax),%eax
    17c2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17c5:	77 12                	ja     17d9 <free+0x35>
    17c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17ca:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17cd:	77 24                	ja     17f3 <free+0x4f>
    17cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17d2:	8b 00                	mov    (%eax),%eax
    17d4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17d7:	77 1a                	ja     17f3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    17d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17dc:	8b 00                	mov    (%eax),%eax
    17de:	89 45 fc             	mov    %eax,-0x4(%ebp)
    17e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17e4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    17e7:	76 d4                	jbe    17bd <free+0x19>
    17e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    17ec:	8b 00                	mov    (%eax),%eax
    17ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    17f1:	76 ca                	jbe    17bd <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    17f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    17f6:	8b 40 04             	mov    0x4(%eax),%eax
    17f9:	c1 e0 03             	shl    $0x3,%eax
    17fc:	89 c2                	mov    %eax,%edx
    17fe:	03 55 f8             	add    -0x8(%ebp),%edx
    1801:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1804:	8b 00                	mov    (%eax),%eax
    1806:	39 c2                	cmp    %eax,%edx
    1808:	75 24                	jne    182e <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    180a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    180d:	8b 50 04             	mov    0x4(%eax),%edx
    1810:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1813:	8b 00                	mov    (%eax),%eax
    1815:	8b 40 04             	mov    0x4(%eax),%eax
    1818:	01 c2                	add    %eax,%edx
    181a:	8b 45 f8             	mov    -0x8(%ebp),%eax
    181d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1820:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1823:	8b 00                	mov    (%eax),%eax
    1825:	8b 10                	mov    (%eax),%edx
    1827:	8b 45 f8             	mov    -0x8(%ebp),%eax
    182a:	89 10                	mov    %edx,(%eax)
    182c:	eb 0a                	jmp    1838 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    182e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1831:	8b 10                	mov    (%eax),%edx
    1833:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1836:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1838:	8b 45 fc             	mov    -0x4(%ebp),%eax
    183b:	8b 40 04             	mov    0x4(%eax),%eax
    183e:	c1 e0 03             	shl    $0x3,%eax
    1841:	03 45 fc             	add    -0x4(%ebp),%eax
    1844:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1847:	75 20                	jne    1869 <free+0xc5>
    p->s.size += bp->s.size;
    1849:	8b 45 fc             	mov    -0x4(%ebp),%eax
    184c:	8b 50 04             	mov    0x4(%eax),%edx
    184f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1852:	8b 40 04             	mov    0x4(%eax),%eax
    1855:	01 c2                	add    %eax,%edx
    1857:	8b 45 fc             	mov    -0x4(%ebp),%eax
    185a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    185d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1860:	8b 10                	mov    (%eax),%edx
    1862:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1865:	89 10                	mov    %edx,(%eax)
    1867:	eb 08                	jmp    1871 <free+0xcd>
  } else
    p->s.ptr = bp;
    1869:	8b 45 fc             	mov    -0x4(%ebp),%eax
    186c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    186f:	89 10                	mov    %edx,(%eax)
  freep = p;
    1871:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1874:	a3 08 1e 00 00       	mov    %eax,0x1e08
}
    1879:	c9                   	leave  
    187a:	c3                   	ret    

0000187b <morecore>:

static Header*
morecore(uint nu)
{
    187b:	55                   	push   %ebp
    187c:	89 e5                	mov    %esp,%ebp
    187e:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1881:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    1888:	77 07                	ja     1891 <morecore+0x16>
    nu = 4096;
    188a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    1891:	8b 45 08             	mov    0x8(%ebp),%eax
    1894:	c1 e0 03             	shl    $0x3,%eax
    1897:	89 04 24             	mov    %eax,(%esp)
    189a:	e8 35 fc ff ff       	call   14d4 <sbrk>
    189f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    18a2:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    18a6:	75 07                	jne    18af <morecore+0x34>
    return 0;
    18a8:	b8 00 00 00 00       	mov    $0x0,%eax
    18ad:	eb 22                	jmp    18d1 <morecore+0x56>
  hp = (Header*)p;
    18af:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18b2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    18b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b8:	8b 55 08             	mov    0x8(%ebp),%edx
    18bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    18be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18c1:	83 c0 08             	add    $0x8,%eax
    18c4:	89 04 24             	mov    %eax,(%esp)
    18c7:	e8 d8 fe ff ff       	call   17a4 <free>
  return freep;
    18cc:	a1 08 1e 00 00       	mov    0x1e08,%eax
}
    18d1:	c9                   	leave  
    18d2:	c3                   	ret    

000018d3 <malloc>:

void*
malloc(uint nbytes)
{
    18d3:	55                   	push   %ebp
    18d4:	89 e5                	mov    %esp,%ebp
    18d6:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    18d9:	8b 45 08             	mov    0x8(%ebp),%eax
    18dc:	83 c0 07             	add    $0x7,%eax
    18df:	c1 e8 03             	shr    $0x3,%eax
    18e2:	83 c0 01             	add    $0x1,%eax
    18e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    18e8:	a1 08 1e 00 00       	mov    0x1e08,%eax
    18ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    18f4:	75 23                	jne    1919 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    18f6:	c7 45 f0 00 1e 00 00 	movl   $0x1e00,-0x10(%ebp)
    18fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1900:	a3 08 1e 00 00       	mov    %eax,0x1e08
    1905:	a1 08 1e 00 00       	mov    0x1e08,%eax
    190a:	a3 00 1e 00 00       	mov    %eax,0x1e00
    base.s.size = 0;
    190f:	c7 05 04 1e 00 00 00 	movl   $0x0,0x1e04
    1916:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1919:	8b 45 f0             	mov    -0x10(%ebp),%eax
    191c:	8b 00                	mov    (%eax),%eax
    191e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1921:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1924:	8b 40 04             	mov    0x4(%eax),%eax
    1927:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    192a:	72 4d                	jb     1979 <malloc+0xa6>
      if(p->s.size == nunits)
    192c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    192f:	8b 40 04             	mov    0x4(%eax),%eax
    1932:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1935:	75 0c                	jne    1943 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    1937:	8b 45 ec             	mov    -0x14(%ebp),%eax
    193a:	8b 10                	mov    (%eax),%edx
    193c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    193f:	89 10                	mov    %edx,(%eax)
    1941:	eb 26                	jmp    1969 <malloc+0x96>
      else {
        p->s.size -= nunits;
    1943:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1946:	8b 40 04             	mov    0x4(%eax),%eax
    1949:	89 c2                	mov    %eax,%edx
    194b:	2b 55 f4             	sub    -0xc(%ebp),%edx
    194e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1951:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1954:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1957:	8b 40 04             	mov    0x4(%eax),%eax
    195a:	c1 e0 03             	shl    $0x3,%eax
    195d:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1960:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1963:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1966:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1969:	8b 45 f0             	mov    -0x10(%ebp),%eax
    196c:	a3 08 1e 00 00       	mov    %eax,0x1e08
      return (void*)(p + 1);
    1971:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1974:	83 c0 08             	add    $0x8,%eax
    1977:	eb 38                	jmp    19b1 <malloc+0xde>
    }
    if(p == freep)
    1979:	a1 08 1e 00 00       	mov    0x1e08,%eax
    197e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1981:	75 1b                	jne    199e <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    1983:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1986:	89 04 24             	mov    %eax,(%esp)
    1989:	e8 ed fe ff ff       	call   187b <morecore>
    198e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    1991:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1995:	75 07                	jne    199e <malloc+0xcb>
        return 0;
    1997:	b8 00 00 00 00       	mov    $0x0,%eax
    199c:	eb 13                	jmp    19b1 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    199e:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19a1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    19a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    19a7:	8b 00                	mov    (%eax),%eax
    19a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    19ac:	e9 70 ff ff ff       	jmp    1921 <malloc+0x4e>
}
    19b1:	c9                   	leave  
    19b2:	c3                   	ret    
    19b3:	90                   	nop

000019b4 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    19b4:	55                   	push   %ebp
    19b5:	89 e5                	mov    %esp,%ebp
    19b7:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    19ba:	8b 55 08             	mov    0x8(%ebp),%edx
    19bd:	8b 45 0c             	mov    0xc(%ebp),%eax
    19c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
    19c3:	f0 87 02             	lock xchg %eax,(%edx)
    19c6:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    19c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    19cc:	c9                   	leave  
    19cd:	c3                   	ret    

000019ce <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    19ce:	55                   	push   %ebp
    19cf:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    19d1:	8b 45 08             	mov    0x8(%ebp),%eax
    19d4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    19da:	5d                   	pop    %ebp
    19db:	c3                   	ret    

000019dc <lock_acquire>:
void lock_acquire(lock_t *lock){
    19dc:	55                   	push   %ebp
    19dd:	89 e5                	mov    %esp,%ebp
    19df:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    19e2:	8b 45 08             	mov    0x8(%ebp),%eax
    19e5:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    19ec:	00 
    19ed:	89 04 24             	mov    %eax,(%esp)
    19f0:	e8 bf ff ff ff       	call   19b4 <xchg>
    19f5:	85 c0                	test   %eax,%eax
    19f7:	75 e9                	jne    19e2 <lock_acquire+0x6>
}
    19f9:	c9                   	leave  
    19fa:	c3                   	ret    

000019fb <lock_release>:
void lock_release(lock_t *lock){
    19fb:	55                   	push   %ebp
    19fc:	89 e5                	mov    %esp,%ebp
    19fe:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1a01:	8b 45 08             	mov    0x8(%ebp),%eax
    1a04:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1a0b:	00 
    1a0c:	89 04 24             	mov    %eax,(%esp)
    1a0f:	e8 a0 ff ff ff       	call   19b4 <xchg>
}
    1a14:	c9                   	leave  
    1a15:	c3                   	ret    

00001a16 <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    1a16:	55                   	push   %ebp
    1a17:	89 e5                	mov    %esp,%ebp
    1a19:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1a1c:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1a23:	e8 ab fe ff ff       	call   18d3 <malloc>
    1a28:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1a2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1a31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a34:	25 ff 0f 00 00       	and    $0xfff,%eax
    1a39:	85 c0                	test   %eax,%eax
    1a3b:	74 15                	je     1a52 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1a3d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a40:	89 c2                	mov    %eax,%edx
    1a42:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1a48:	b8 00 10 00 00       	mov    $0x1000,%eax
    1a4d:	29 d0                	sub    %edx,%eax
    1a4f:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1a52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1a56:	75 1b                	jne    1a73 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1a58:	c7 44 24 04 9d 1d 00 	movl   $0x1d9d,0x4(%esp)
    1a5f:	00 
    1a60:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a67:	e8 81 fb ff ff       	call   15ed <printf>
        return 0;
    1a6c:	b8 00 00 00 00       	mov    $0x0,%eax
    1a71:	eb 6f                	jmp    1ae2 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    1a73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    1a76:	8b 55 08             	mov    0x8(%ebp),%edx
    1a79:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a7c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1a80:	89 54 24 08          	mov    %edx,0x8(%esp)
    1a84:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    1a8b:	00 
    1a8c:	89 04 24             	mov    %eax,(%esp)
    1a8f:	e8 58 fa ff ff       	call   14ec <clone>
    1a94:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    1a97:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a9b:	79 1b                	jns    1ab8 <thread_create+0xa2>
        printf(1,"clone fails\n");
    1a9d:	c7 44 24 04 ab 1d 00 	movl   $0x1dab,0x4(%esp)
    1aa4:	00 
    1aa5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aac:	e8 3c fb ff ff       	call   15ed <printf>
        return 0;
    1ab1:	b8 00 00 00 00       	mov    $0x0,%eax
    1ab6:	eb 2a                	jmp    1ae2 <thread_create+0xcc>
    }
    if(tid > 0){
    1ab8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1abc:	7e 05                	jle    1ac3 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ac1:	eb 1f                	jmp    1ae2 <thread_create+0xcc>
    }
    if(tid == 0){
    1ac3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1ac7:	75 14                	jne    1add <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    1ac9:	c7 44 24 04 b8 1d 00 	movl   $0x1db8,0x4(%esp)
    1ad0:	00 
    1ad1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ad8:	e8 10 fb ff ff       	call   15ed <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1add:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1ae2:	c9                   	leave  
    1ae3:	c3                   	ret    

00001ae4 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1ae4:	55                   	push   %ebp
    1ae5:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    1ae7:	a1 e0 1d 00 00       	mov    0x1de0,%eax
    1aec:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1af2:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1af7:	a3 e0 1d 00 00       	mov    %eax,0x1de0
    return (int)(rands % max);
    1afc:	a1 e0 1d 00 00       	mov    0x1de0,%eax
    1b01:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1b04:	ba 00 00 00 00       	mov    $0x0,%edx
    1b09:	f7 f1                	div    %ecx
    1b0b:	89 d0                	mov    %edx,%eax
}
    1b0d:	5d                   	pop    %ebp
    1b0e:	c3                   	ret    
    1b0f:	90                   	nop

00001b10 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1b10:	55                   	push   %ebp
    1b11:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1b13:	8b 45 08             	mov    0x8(%ebp),%eax
    1b16:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1b1c:	8b 45 08             	mov    0x8(%ebp),%eax
    1b1f:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1b26:	8b 45 08             	mov    0x8(%ebp),%eax
    1b29:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1b30:	5d                   	pop    %ebp
    1b31:	c3                   	ret    

00001b32 <add_q>:

void add_q(struct queue *q, int v){
    1b32:	55                   	push   %ebp
    1b33:	89 e5                	mov    %esp,%ebp
    1b35:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1b38:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1b3f:	e8 8f fd ff ff       	call   18d3 <malloc>
    1b44:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1b47:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b4a:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1b51:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b54:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b57:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1b59:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5c:	8b 40 04             	mov    0x4(%eax),%eax
    1b5f:	85 c0                	test   %eax,%eax
    1b61:	75 0b                	jne    1b6e <add_q+0x3c>
        q->head = n;
    1b63:	8b 45 08             	mov    0x8(%ebp),%eax
    1b66:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b69:	89 50 04             	mov    %edx,0x4(%eax)
    1b6c:	eb 0c                	jmp    1b7a <add_q+0x48>
    }else{
        q->tail->next = n;
    1b6e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b71:	8b 40 08             	mov    0x8(%eax),%eax
    1b74:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b77:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1b7a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1b80:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1b83:	8b 45 08             	mov    0x8(%ebp),%eax
    1b86:	8b 00                	mov    (%eax),%eax
    1b88:	8d 50 01             	lea    0x1(%eax),%edx
    1b8b:	8b 45 08             	mov    0x8(%ebp),%eax
    1b8e:	89 10                	mov    %edx,(%eax)
}
    1b90:	c9                   	leave  
    1b91:	c3                   	ret    

00001b92 <empty_q>:

int empty_q(struct queue *q){
    1b92:	55                   	push   %ebp
    1b93:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1b95:	8b 45 08             	mov    0x8(%ebp),%eax
    1b98:	8b 00                	mov    (%eax),%eax
    1b9a:	85 c0                	test   %eax,%eax
    1b9c:	75 07                	jne    1ba5 <empty_q+0x13>
        return 1;
    1b9e:	b8 01 00 00 00       	mov    $0x1,%eax
    1ba3:	eb 05                	jmp    1baa <empty_q+0x18>
    else
        return 0;
    1ba5:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1baa:	5d                   	pop    %ebp
    1bab:	c3                   	ret    

00001bac <pop_q>:
int pop_q(struct queue *q){
    1bac:	55                   	push   %ebp
    1bad:	89 e5                	mov    %esp,%ebp
    1baf:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1bb2:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb5:	89 04 24             	mov    %eax,(%esp)
    1bb8:	e8 d5 ff ff ff       	call   1b92 <empty_q>
    1bbd:	85 c0                	test   %eax,%eax
    1bbf:	75 5d                	jne    1c1e <pop_q+0x72>
       val = q->head->value; 
    1bc1:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc4:	8b 40 04             	mov    0x4(%eax),%eax
    1bc7:	8b 00                	mov    (%eax),%eax
    1bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1bcc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcf:	8b 40 04             	mov    0x4(%eax),%eax
    1bd2:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1bd5:	8b 45 08             	mov    0x8(%ebp),%eax
    1bd8:	8b 40 04             	mov    0x4(%eax),%eax
    1bdb:	8b 50 04             	mov    0x4(%eax),%edx
    1bde:	8b 45 08             	mov    0x8(%ebp),%eax
    1be1:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1be4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1be7:	89 04 24             	mov    %eax,(%esp)
    1bea:	e8 b5 fb ff ff       	call   17a4 <free>
       q->size--;
    1bef:	8b 45 08             	mov    0x8(%ebp),%eax
    1bf2:	8b 00                	mov    (%eax),%eax
    1bf4:	8d 50 ff             	lea    -0x1(%eax),%edx
    1bf7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfa:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1bfc:	8b 45 08             	mov    0x8(%ebp),%eax
    1bff:	8b 00                	mov    (%eax),%eax
    1c01:	85 c0                	test   %eax,%eax
    1c03:	75 14                	jne    1c19 <pop_q+0x6d>
            q->head = 0;
    1c05:	8b 45 08             	mov    0x8(%ebp),%eax
    1c08:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1c0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1c12:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1c1c:	eb 05                	jmp    1c23 <pop_q+0x77>
    }
    return -1;
    1c1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1c23:	c9                   	leave  
    1c24:	c3                   	ret    
    1c25:	90                   	nop
    1c26:	90                   	nop
    1c27:	90                   	nop

00001c28 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1c28:	55                   	push   %ebp
    1c29:	89 e5                	mov    %esp,%ebp
    1c2b:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1c2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1c31:	89 04 24             	mov    %eax,(%esp)
    1c34:	e8 a3 fd ff ff       	call   19dc <lock_acquire>
	s->count--; 
    1c39:	8b 45 08             	mov    0x8(%ebp),%eax
    1c3c:	8b 40 04             	mov    0x4(%eax),%eax
    1c3f:	8d 50 ff             	lea    -0x1(%eax),%edx
    1c42:	8b 45 08             	mov    0x8(%ebp),%eax
    1c45:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1c48:	8b 45 08             	mov    0x8(%ebp),%eax
    1c4b:	8b 40 04             	mov    0x4(%eax),%eax
    1c4e:	85 c0                	test   %eax,%eax
    1c50:	79 27                	jns    1c79 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1c52:	e8 75 f8 ff ff       	call   14cc <getpid>
    1c57:	8b 55 08             	mov    0x8(%ebp),%edx
    1c5a:	83 c2 08             	add    $0x8,%edx
    1c5d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1c61:	89 14 24             	mov    %edx,(%esp)
    1c64:	e8 c9 fe ff ff       	call   1b32 <add_q>
		lock_release(&s->lock); 
    1c69:	8b 45 08             	mov    0x8(%ebp),%eax
    1c6c:	89 04 24             	mov    %eax,(%esp)
    1c6f:	e8 87 fd ff ff       	call   19fb <lock_release>
		tsleep(); 
    1c74:	e8 83 f8 ff ff       	call   14fc <tsleep>
	} 
	lock_release(&s->lock); 
    1c79:	8b 45 08             	mov    0x8(%ebp),%eax
    1c7c:	89 04 24             	mov    %eax,(%esp)
    1c7f:	e8 77 fd ff ff       	call   19fb <lock_release>
}
    1c84:	c9                   	leave  
    1c85:	c3                   	ret    

00001c86 <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1c86:	55                   	push   %ebp
    1c87:	89 e5                	mov    %esp,%ebp
    1c89:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1c8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1c8f:	89 04 24             	mov    %eax,(%esp)
    1c92:	e8 45 fd ff ff       	call   19dc <lock_acquire>
	s->count++; 
    1c97:	8b 45 08             	mov    0x8(%ebp),%eax
    1c9a:	8b 40 04             	mov    0x4(%eax),%eax
    1c9d:	8d 50 01             	lea    0x1(%eax),%edx
    1ca0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca3:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1ca6:	8b 45 08             	mov    0x8(%ebp),%eax
    1ca9:	8b 40 04             	mov    0x4(%eax),%eax
    1cac:	85 c0                	test   %eax,%eax
    1cae:	7f 1c                	jg     1ccc <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1cb0:	8b 45 08             	mov    0x8(%ebp),%eax
    1cb3:	83 c0 08             	add    $0x8,%eax
    1cb6:	89 04 24             	mov    %eax,(%esp)
    1cb9:	e8 ee fe ff ff       	call   1bac <pop_q>
    1cbe:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1cc4:	89 04 24             	mov    %eax,(%esp)
    1cc7:	e8 38 f8 ff ff       	call   1504 <twakeup>
	}
	lock_release(&s->lock); 
    1ccc:	8b 45 08             	mov    0x8(%ebp),%eax
    1ccf:	89 04 24             	mov    %eax,(%esp)
    1cd2:	e8 24 fd ff ff       	call   19fb <lock_release>
} 
    1cd7:	c9                   	leave  
    1cd8:	c3                   	ret    

00001cd9 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1cd9:	55                   	push   %ebp
    1cda:	89 e5                	mov    %esp,%ebp
    1cdc:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1cdf:	8b 45 08             	mov    0x8(%ebp),%eax
    1ce2:	89 04 24             	mov    %eax,(%esp)
    1ce5:	e8 e4 fc ff ff       	call   19ce <lock_init>
	s->count = size; 
    1cea:	8b 45 08             	mov    0x8(%ebp),%eax
    1ced:	8b 55 0c             	mov    0xc(%ebp),%edx
    1cf0:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1cf3:	8b 45 08             	mov    0x8(%ebp),%eax
    1cf6:	83 c0 08             	add    $0x8,%eax
    1cf9:	89 04 24             	mov    %eax,(%esp)
    1cfc:	e8 0f fe ff ff       	call   1b10 <init_q>
}
    1d01:	c9                   	leave  
    1d02:	c3                   	ret    
