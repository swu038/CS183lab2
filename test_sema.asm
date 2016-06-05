
_test_sema:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:
void test_func2(void *arg); 
struct Semaphore s;
int var = 7;
int var1 = 8;

int main(){ 
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 e4 f0             	and    $0xfffffff0,%esp
    1006:	83 ec 20             	sub    $0x20,%esp
 
	sem_init(&s,1);	
    1009:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1010:	00 
    1011:	c7 04 24 8c 1c 00 00 	movl   $0x1c8c,(%esp)
    1018:	e8 d4 0b 00 00       	call   1bf1 <sem_init>
	void* tid = thread_create(test_func,(void *)&var);
    101d:	c7 44 24 04 60 1c 00 	movl   $0x1c60,0x4(%esp)
    1024:	00 
    1025:	c7 04 24 74 10 00 00 	movl   $0x1074,(%esp)
    102c:	e8 fd 08 00 00       	call   192e <thread_create>
    1031:	89 44 24 18          	mov    %eax,0x18(%esp)
	if(tid == 0) exit(); 
    1035:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
    103a:	75 05                	jne    1041 <main+0x41>
    103c:	e8 23 03 00 00       	call   1364 <exit>
	wait(); 
    1041:	e8 26 03 00 00       	call   136c <wait>
	void* yid = thread_create(test_func2,(void *)&var1);  
    1046:	c7 44 24 04 64 1c 00 	movl   $0x1c64,0x4(%esp)
    104d:	00 
    104e:	c7 04 24 ba 10 00 00 	movl   $0x10ba,(%esp)
    1055:	e8 d4 08 00 00       	call   192e <thread_create>
    105a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
	if(yid == 0) exit(); 
    105e:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
    1063:	75 05                	jne    106a <main+0x6a>
    1065:	e8 fa 02 00 00       	call   1364 <exit>
	wait();
    106a:	e8 fd 02 00 00       	call   136c <wait>

	exit();  
    106f:	e8 f0 02 00 00       	call   1364 <exit>

00001074 <test_func>:
	return 0; 
}

void test_func(void *arg) {
    1074:	55                   	push   %ebp
    1075:	89 e5                	mov    %esp,%ebp
    1077:	83 ec 28             	sub    $0x28,%esp
	int* num = (void*)arg;  
    107a:	8b 45 08             	mov    0x8(%ebp),%eax
    107d:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sem_acquire(&s); 
    1080:	c7 04 24 8c 1c 00 00 	movl   $0x1c8c,(%esp)
    1087:	e8 b4 0a 00 00       	call   1b40 <sem_acquire>
	printf(1,"hi %d.\n",*num);		
    108c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    108f:	8b 00                	mov    (%eax),%eax
    1091:	89 44 24 08          	mov    %eax,0x8(%esp)
    1095:	c7 44 24 04 1b 1c 00 	movl   $0x1c1b,0x4(%esp)
    109c:	00 
    109d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10a4:	e8 5c 04 00 00       	call   1505 <printf>
	sem_signal(&s); 
    10a9:	c7 04 24 8c 1c 00 00 	movl   $0x1c8c,(%esp)
    10b0:	e8 e9 0a 00 00       	call   1b9e <sem_signal>

	texit(); 
    10b5:	e8 52 03 00 00       	call   140c <texit>

000010ba <test_func2>:
} 

void test_func2(void *arg) {
    10ba:	55                   	push   %ebp
    10bb:	89 e5                	mov    %esp,%ebp
    10bd:	83 ec 28             	sub    $0x28,%esp
	int* num = (void*)arg;
    10c0:	8b 45 08             	mov    0x8(%ebp),%eax
    10c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	
	sem_acquire(&s);  
    10c6:	c7 04 24 8c 1c 00 00 	movl   $0x1c8c,(%esp)
    10cd:	e8 6e 0a 00 00       	call   1b40 <sem_acquire>
	printf(1,"hey %d.\n",*num); 
    10d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10d5:	8b 00                	mov    (%eax),%eax
    10d7:	89 44 24 08          	mov    %eax,0x8(%esp)
    10db:	c7 44 24 04 23 1c 00 	movl   $0x1c23,0x4(%esp)
    10e2:	00 
    10e3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10ea:	e8 16 04 00 00       	call   1505 <printf>
	sem_signal(&s); 
    10ef:	c7 04 24 8c 1c 00 00 	movl   $0x1c8c,(%esp)
    10f6:	e8 a3 0a 00 00       	call   1b9e <sem_signal>

	texit(); 
    10fb:	e8 0c 03 00 00       	call   140c <texit>

00001100 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    1100:	55                   	push   %ebp
    1101:	89 e5                	mov    %esp,%ebp
    1103:	57                   	push   %edi
    1104:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1105:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1108:	8b 55 10             	mov    0x10(%ebp),%edx
    110b:	8b 45 0c             	mov    0xc(%ebp),%eax
    110e:	89 cb                	mov    %ecx,%ebx
    1110:	89 df                	mov    %ebx,%edi
    1112:	89 d1                	mov    %edx,%ecx
    1114:	fc                   	cld    
    1115:	f3 aa                	rep stos %al,%es:(%edi)
    1117:	89 ca                	mov    %ecx,%edx
    1119:	89 fb                	mov    %edi,%ebx
    111b:	89 5d 08             	mov    %ebx,0x8(%ebp)
    111e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    1121:	5b                   	pop    %ebx
    1122:	5f                   	pop    %edi
    1123:	5d                   	pop    %ebp
    1124:	c3                   	ret    

00001125 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1125:	55                   	push   %ebp
    1126:	89 e5                	mov    %esp,%ebp
    1128:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    112b:	8b 45 08             	mov    0x8(%ebp),%eax
    112e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    1131:	8b 45 0c             	mov    0xc(%ebp),%eax
    1134:	0f b6 10             	movzbl (%eax),%edx
    1137:	8b 45 08             	mov    0x8(%ebp),%eax
    113a:	88 10                	mov    %dl,(%eax)
    113c:	8b 45 08             	mov    0x8(%ebp),%eax
    113f:	0f b6 00             	movzbl (%eax),%eax
    1142:	84 c0                	test   %al,%al
    1144:	0f 95 c0             	setne  %al
    1147:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    114b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    114f:	84 c0                	test   %al,%al
    1151:	75 de                	jne    1131 <strcpy+0xc>
    ;
  return os;
    1153:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1156:	c9                   	leave  
    1157:	c3                   	ret    

00001158 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1158:	55                   	push   %ebp
    1159:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    115b:	eb 08                	jmp    1165 <strcmp+0xd>
    p++, q++;
    115d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1161:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1165:	8b 45 08             	mov    0x8(%ebp),%eax
    1168:	0f b6 00             	movzbl (%eax),%eax
    116b:	84 c0                	test   %al,%al
    116d:	74 10                	je     117f <strcmp+0x27>
    116f:	8b 45 08             	mov    0x8(%ebp),%eax
    1172:	0f b6 10             	movzbl (%eax),%edx
    1175:	8b 45 0c             	mov    0xc(%ebp),%eax
    1178:	0f b6 00             	movzbl (%eax),%eax
    117b:	38 c2                	cmp    %al,%dl
    117d:	74 de                	je     115d <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    117f:	8b 45 08             	mov    0x8(%ebp),%eax
    1182:	0f b6 00             	movzbl (%eax),%eax
    1185:	0f b6 d0             	movzbl %al,%edx
    1188:	8b 45 0c             	mov    0xc(%ebp),%eax
    118b:	0f b6 00             	movzbl (%eax),%eax
    118e:	0f b6 c0             	movzbl %al,%eax
    1191:	89 d1                	mov    %edx,%ecx
    1193:	29 c1                	sub    %eax,%ecx
    1195:	89 c8                	mov    %ecx,%eax
}
    1197:	5d                   	pop    %ebp
    1198:	c3                   	ret    

00001199 <strlen>:

uint
strlen(char *s)
{
    1199:	55                   	push   %ebp
    119a:	89 e5                	mov    %esp,%ebp
    119c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    119f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    11a6:	eb 04                	jmp    11ac <strlen+0x13>
    11a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    11ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
    11af:	03 45 08             	add    0x8(%ebp),%eax
    11b2:	0f b6 00             	movzbl (%eax),%eax
    11b5:	84 c0                	test   %al,%al
    11b7:	75 ef                	jne    11a8 <strlen+0xf>
    ;
  return n;
    11b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    11bc:	c9                   	leave  
    11bd:	c3                   	ret    

000011be <memset>:

void*
memset(void *dst, int c, uint n)
{
    11be:	55                   	push   %ebp
    11bf:	89 e5                	mov    %esp,%ebp
    11c1:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    11c4:	8b 45 10             	mov    0x10(%ebp),%eax
    11c7:	89 44 24 08          	mov    %eax,0x8(%esp)
    11cb:	8b 45 0c             	mov    0xc(%ebp),%eax
    11ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    11d2:	8b 45 08             	mov    0x8(%ebp),%eax
    11d5:	89 04 24             	mov    %eax,(%esp)
    11d8:	e8 23 ff ff ff       	call   1100 <stosb>
  return dst;
    11dd:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11e0:	c9                   	leave  
    11e1:	c3                   	ret    

000011e2 <strchr>:

char*
strchr(const char *s, char c)
{
    11e2:	55                   	push   %ebp
    11e3:	89 e5                	mov    %esp,%ebp
    11e5:	83 ec 04             	sub    $0x4,%esp
    11e8:	8b 45 0c             	mov    0xc(%ebp),%eax
    11eb:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    11ee:	eb 14                	jmp    1204 <strchr+0x22>
    if(*s == c)
    11f0:	8b 45 08             	mov    0x8(%ebp),%eax
    11f3:	0f b6 00             	movzbl (%eax),%eax
    11f6:	3a 45 fc             	cmp    -0x4(%ebp),%al
    11f9:	75 05                	jne    1200 <strchr+0x1e>
      return (char*)s;
    11fb:	8b 45 08             	mov    0x8(%ebp),%eax
    11fe:	eb 13                	jmp    1213 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    1200:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1204:	8b 45 08             	mov    0x8(%ebp),%eax
    1207:	0f b6 00             	movzbl (%eax),%eax
    120a:	84 c0                	test   %al,%al
    120c:	75 e2                	jne    11f0 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    120e:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1213:	c9                   	leave  
    1214:	c3                   	ret    

00001215 <gets>:

char*
gets(char *buf, int max)
{
    1215:	55                   	push   %ebp
    1216:	89 e5                	mov    %esp,%ebp
    1218:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    121b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    1222:	eb 44                	jmp    1268 <gets+0x53>
    cc = read(0, &c, 1);
    1224:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    122b:	00 
    122c:	8d 45 ef             	lea    -0x11(%ebp),%eax
    122f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1233:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    123a:	e8 3d 01 00 00       	call   137c <read>
    123f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    1242:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1246:	7e 2d                	jle    1275 <gets+0x60>
      break;
    buf[i++] = c;
    1248:	8b 45 f0             	mov    -0x10(%ebp),%eax
    124b:	03 45 08             	add    0x8(%ebp),%eax
    124e:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    1252:	88 10                	mov    %dl,(%eax)
    1254:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1258:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    125c:	3c 0a                	cmp    $0xa,%al
    125e:	74 16                	je     1276 <gets+0x61>
    1260:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1264:	3c 0d                	cmp    $0xd,%al
    1266:	74 0e                	je     1276 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1268:	8b 45 f0             	mov    -0x10(%ebp),%eax
    126b:	83 c0 01             	add    $0x1,%eax
    126e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    1271:	7c b1                	jl     1224 <gets+0xf>
    1273:	eb 01                	jmp    1276 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    1275:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    1276:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1279:	03 45 08             	add    0x8(%ebp),%eax
    127c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    127f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1282:	c9                   	leave  
    1283:	c3                   	ret    

00001284 <stat>:

int
stat(char *n, struct stat *st)
{
    1284:	55                   	push   %ebp
    1285:	89 e5                	mov    %esp,%ebp
    1287:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    128a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1291:	00 
    1292:	8b 45 08             	mov    0x8(%ebp),%eax
    1295:	89 04 24             	mov    %eax,(%esp)
    1298:	e8 07 01 00 00       	call   13a4 <open>
    129d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    12a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    12a4:	79 07                	jns    12ad <stat+0x29>
    return -1;
    12a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    12ab:	eb 23                	jmp    12d0 <stat+0x4c>
  r = fstat(fd, st);
    12ad:	8b 45 0c             	mov    0xc(%ebp),%eax
    12b0:	89 44 24 04          	mov    %eax,0x4(%esp)
    12b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12b7:	89 04 24             	mov    %eax,(%esp)
    12ba:	e8 fd 00 00 00       	call   13bc <fstat>
    12bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    12c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    12c5:	89 04 24             	mov    %eax,(%esp)
    12c8:	e8 bf 00 00 00       	call   138c <close>
  return r;
    12cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    12d0:	c9                   	leave  
    12d1:	c3                   	ret    

000012d2 <atoi>:

int
atoi(const char *s)
{
    12d2:	55                   	push   %ebp
    12d3:	89 e5                	mov    %esp,%ebp
    12d5:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    12d8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    12df:	eb 24                	jmp    1305 <atoi+0x33>
    n = n*10 + *s++ - '0';
    12e1:	8b 55 fc             	mov    -0x4(%ebp),%edx
    12e4:	89 d0                	mov    %edx,%eax
    12e6:	c1 e0 02             	shl    $0x2,%eax
    12e9:	01 d0                	add    %edx,%eax
    12eb:	01 c0                	add    %eax,%eax
    12ed:	89 c2                	mov    %eax,%edx
    12ef:	8b 45 08             	mov    0x8(%ebp),%eax
    12f2:	0f b6 00             	movzbl (%eax),%eax
    12f5:	0f be c0             	movsbl %al,%eax
    12f8:	8d 04 02             	lea    (%edx,%eax,1),%eax
    12fb:	83 e8 30             	sub    $0x30,%eax
    12fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1301:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1305:	8b 45 08             	mov    0x8(%ebp),%eax
    1308:	0f b6 00             	movzbl (%eax),%eax
    130b:	3c 2f                	cmp    $0x2f,%al
    130d:	7e 0a                	jle    1319 <atoi+0x47>
    130f:	8b 45 08             	mov    0x8(%ebp),%eax
    1312:	0f b6 00             	movzbl (%eax),%eax
    1315:	3c 39                	cmp    $0x39,%al
    1317:	7e c8                	jle    12e1 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1319:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    131c:	c9                   	leave  
    131d:	c3                   	ret    

0000131e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    131e:	55                   	push   %ebp
    131f:	89 e5                	mov    %esp,%ebp
    1321:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1324:	8b 45 08             	mov    0x8(%ebp),%eax
    1327:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    132a:	8b 45 0c             	mov    0xc(%ebp),%eax
    132d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    1330:	eb 13                	jmp    1345 <memmove+0x27>
    *dst++ = *src++;
    1332:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1335:	0f b6 10             	movzbl (%eax),%edx
    1338:	8b 45 f8             	mov    -0x8(%ebp),%eax
    133b:	88 10                	mov    %dl,(%eax)
    133d:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    1341:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1345:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1349:	0f 9f c0             	setg   %al
    134c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    1350:	84 c0                	test   %al,%al
    1352:	75 de                	jne    1332 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1354:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1357:	c9                   	leave  
    1358:	c3                   	ret    
    1359:	90                   	nop
    135a:	90                   	nop
    135b:	90                   	nop

0000135c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    135c:	b8 01 00 00 00       	mov    $0x1,%eax
    1361:	cd 40                	int    $0x40
    1363:	c3                   	ret    

00001364 <exit>:
SYSCALL(exit)
    1364:	b8 02 00 00 00       	mov    $0x2,%eax
    1369:	cd 40                	int    $0x40
    136b:	c3                   	ret    

0000136c <wait>:
SYSCALL(wait)
    136c:	b8 03 00 00 00       	mov    $0x3,%eax
    1371:	cd 40                	int    $0x40
    1373:	c3                   	ret    

00001374 <pipe>:
SYSCALL(pipe)
    1374:	b8 04 00 00 00       	mov    $0x4,%eax
    1379:	cd 40                	int    $0x40
    137b:	c3                   	ret    

0000137c <read>:
SYSCALL(read)
    137c:	b8 05 00 00 00       	mov    $0x5,%eax
    1381:	cd 40                	int    $0x40
    1383:	c3                   	ret    

00001384 <write>:
SYSCALL(write)
    1384:	b8 10 00 00 00       	mov    $0x10,%eax
    1389:	cd 40                	int    $0x40
    138b:	c3                   	ret    

0000138c <close>:
SYSCALL(close)
    138c:	b8 15 00 00 00       	mov    $0x15,%eax
    1391:	cd 40                	int    $0x40
    1393:	c3                   	ret    

00001394 <kill>:
SYSCALL(kill)
    1394:	b8 06 00 00 00       	mov    $0x6,%eax
    1399:	cd 40                	int    $0x40
    139b:	c3                   	ret    

0000139c <exec>:
SYSCALL(exec)
    139c:	b8 07 00 00 00       	mov    $0x7,%eax
    13a1:	cd 40                	int    $0x40
    13a3:	c3                   	ret    

000013a4 <open>:
SYSCALL(open)
    13a4:	b8 0f 00 00 00       	mov    $0xf,%eax
    13a9:	cd 40                	int    $0x40
    13ab:	c3                   	ret    

000013ac <mknod>:
SYSCALL(mknod)
    13ac:	b8 11 00 00 00       	mov    $0x11,%eax
    13b1:	cd 40                	int    $0x40
    13b3:	c3                   	ret    

000013b4 <unlink>:
SYSCALL(unlink)
    13b4:	b8 12 00 00 00       	mov    $0x12,%eax
    13b9:	cd 40                	int    $0x40
    13bb:	c3                   	ret    

000013bc <fstat>:
SYSCALL(fstat)
    13bc:	b8 08 00 00 00       	mov    $0x8,%eax
    13c1:	cd 40                	int    $0x40
    13c3:	c3                   	ret    

000013c4 <link>:
SYSCALL(link)
    13c4:	b8 13 00 00 00       	mov    $0x13,%eax
    13c9:	cd 40                	int    $0x40
    13cb:	c3                   	ret    

000013cc <mkdir>:
SYSCALL(mkdir)
    13cc:	b8 14 00 00 00       	mov    $0x14,%eax
    13d1:	cd 40                	int    $0x40
    13d3:	c3                   	ret    

000013d4 <chdir>:
SYSCALL(chdir)
    13d4:	b8 09 00 00 00       	mov    $0x9,%eax
    13d9:	cd 40                	int    $0x40
    13db:	c3                   	ret    

000013dc <dup>:
SYSCALL(dup)
    13dc:	b8 0a 00 00 00       	mov    $0xa,%eax
    13e1:	cd 40                	int    $0x40
    13e3:	c3                   	ret    

000013e4 <getpid>:
SYSCALL(getpid)
    13e4:	b8 0b 00 00 00       	mov    $0xb,%eax
    13e9:	cd 40                	int    $0x40
    13eb:	c3                   	ret    

000013ec <sbrk>:
SYSCALL(sbrk)
    13ec:	b8 0c 00 00 00       	mov    $0xc,%eax
    13f1:	cd 40                	int    $0x40
    13f3:	c3                   	ret    

000013f4 <sleep>:
SYSCALL(sleep)
    13f4:	b8 0d 00 00 00       	mov    $0xd,%eax
    13f9:	cd 40                	int    $0x40
    13fb:	c3                   	ret    

000013fc <uptime>:
SYSCALL(uptime)
    13fc:	b8 0e 00 00 00       	mov    $0xe,%eax
    1401:	cd 40                	int    $0x40
    1403:	c3                   	ret    

00001404 <clone>:
SYSCALL(clone)
    1404:	b8 16 00 00 00       	mov    $0x16,%eax
    1409:	cd 40                	int    $0x40
    140b:	c3                   	ret    

0000140c <texit>:
SYSCALL(texit)
    140c:	b8 17 00 00 00       	mov    $0x17,%eax
    1411:	cd 40                	int    $0x40
    1413:	c3                   	ret    

00001414 <tsleep>:
SYSCALL(tsleep)
    1414:	b8 18 00 00 00       	mov    $0x18,%eax
    1419:	cd 40                	int    $0x40
    141b:	c3                   	ret    

0000141c <twakeup>:
SYSCALL(twakeup)
    141c:	b8 19 00 00 00       	mov    $0x19,%eax
    1421:	cd 40                	int    $0x40
    1423:	c3                   	ret    

00001424 <thread_yield>:
SYSCALL(thread_yield) 
    1424:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1429:	cd 40                	int    $0x40
    142b:	c3                   	ret    

0000142c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    142c:	55                   	push   %ebp
    142d:	89 e5                	mov    %esp,%ebp
    142f:	83 ec 28             	sub    $0x28,%esp
    1432:	8b 45 0c             	mov    0xc(%ebp),%eax
    1435:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1438:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    143f:	00 
    1440:	8d 45 f4             	lea    -0xc(%ebp),%eax
    1443:	89 44 24 04          	mov    %eax,0x4(%esp)
    1447:	8b 45 08             	mov    0x8(%ebp),%eax
    144a:	89 04 24             	mov    %eax,(%esp)
    144d:	e8 32 ff ff ff       	call   1384 <write>
}
    1452:	c9                   	leave  
    1453:	c3                   	ret    

00001454 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1454:	55                   	push   %ebp
    1455:	89 e5                	mov    %esp,%ebp
    1457:	53                   	push   %ebx
    1458:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    145b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    1462:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1466:	74 17                	je     147f <printint+0x2b>
    1468:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    146c:	79 11                	jns    147f <printint+0x2b>
    neg = 1;
    146e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    1475:	8b 45 0c             	mov    0xc(%ebp),%eax
    1478:	f7 d8                	neg    %eax
    147a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    147d:	eb 06                	jmp    1485 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    147f:	8b 45 0c             	mov    0xc(%ebp),%eax
    1482:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    1485:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    148c:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    148f:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1492:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1495:	ba 00 00 00 00       	mov    $0x0,%edx
    149a:	f7 f3                	div    %ebx
    149c:	89 d0                	mov    %edx,%eax
    149e:	0f b6 80 68 1c 00 00 	movzbl 0x1c68(%eax),%eax
    14a5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    14a9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    14ad:	8b 45 10             	mov    0x10(%ebp),%eax
    14b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    14b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14b6:	ba 00 00 00 00       	mov    $0x0,%edx
    14bb:	f7 75 d4             	divl   -0x2c(%ebp)
    14be:	89 45 f4             	mov    %eax,-0xc(%ebp)
    14c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    14c5:	75 c5                	jne    148c <printint+0x38>
  if(neg)
    14c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    14cb:	74 28                	je     14f5 <printint+0xa1>
    buf[i++] = '-';
    14cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14d0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    14d5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    14d9:	eb 1a                	jmp    14f5 <printint+0xa1>
    putc(fd, buf[i]);
    14db:	8b 45 ec             	mov    -0x14(%ebp),%eax
    14de:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    14e3:	0f be c0             	movsbl %al,%eax
    14e6:	89 44 24 04          	mov    %eax,0x4(%esp)
    14ea:	8b 45 08             	mov    0x8(%ebp),%eax
    14ed:	89 04 24             	mov    %eax,(%esp)
    14f0:	e8 37 ff ff ff       	call   142c <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    14f5:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    14f9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    14fd:	79 dc                	jns    14db <printint+0x87>
    putc(fd, buf[i]);
}
    14ff:	83 c4 44             	add    $0x44,%esp
    1502:	5b                   	pop    %ebx
    1503:	5d                   	pop    %ebp
    1504:	c3                   	ret    

00001505 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1505:	55                   	push   %ebp
    1506:	89 e5                	mov    %esp,%ebp
    1508:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    150b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    1512:	8d 45 0c             	lea    0xc(%ebp),%eax
    1515:	83 c0 04             	add    $0x4,%eax
    1518:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    151b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    1522:	e9 7e 01 00 00       	jmp    16a5 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1527:	8b 55 0c             	mov    0xc(%ebp),%edx
    152a:	8b 45 ec             	mov    -0x14(%ebp),%eax
    152d:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1530:	0f b6 00             	movzbl (%eax),%eax
    1533:	0f be c0             	movsbl %al,%eax
    1536:	25 ff 00 00 00       	and    $0xff,%eax
    153b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    153e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1542:	75 2c                	jne    1570 <printf+0x6b>
      if(c == '%'){
    1544:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1548:	75 0c                	jne    1556 <printf+0x51>
        state = '%';
    154a:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    1551:	e9 4b 01 00 00       	jmp    16a1 <printf+0x19c>
      } else {
        putc(fd, c);
    1556:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1559:	0f be c0             	movsbl %al,%eax
    155c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1560:	8b 45 08             	mov    0x8(%ebp),%eax
    1563:	89 04 24             	mov    %eax,(%esp)
    1566:	e8 c1 fe ff ff       	call   142c <putc>
    156b:	e9 31 01 00 00       	jmp    16a1 <printf+0x19c>
      }
    } else if(state == '%'){
    1570:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    1574:	0f 85 27 01 00 00    	jne    16a1 <printf+0x19c>
      if(c == 'd'){
    157a:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    157e:	75 2d                	jne    15ad <printf+0xa8>
        printint(fd, *ap, 10, 1);
    1580:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1583:	8b 00                	mov    (%eax),%eax
    1585:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    158c:	00 
    158d:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1594:	00 
    1595:	89 44 24 04          	mov    %eax,0x4(%esp)
    1599:	8b 45 08             	mov    0x8(%ebp),%eax
    159c:	89 04 24             	mov    %eax,(%esp)
    159f:	e8 b0 fe ff ff       	call   1454 <printint>
        ap++;
    15a4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    15a8:	e9 ed 00 00 00       	jmp    169a <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    15ad:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    15b1:	74 06                	je     15b9 <printf+0xb4>
    15b3:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    15b7:	75 2d                	jne    15e6 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    15b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15bc:	8b 00                	mov    (%eax),%eax
    15be:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    15c5:	00 
    15c6:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    15cd:	00 
    15ce:	89 44 24 04          	mov    %eax,0x4(%esp)
    15d2:	8b 45 08             	mov    0x8(%ebp),%eax
    15d5:	89 04 24             	mov    %eax,(%esp)
    15d8:	e8 77 fe ff ff       	call   1454 <printint>
        ap++;
    15dd:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    15e1:	e9 b4 00 00 00       	jmp    169a <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    15e6:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    15ea:	75 46                	jne    1632 <printf+0x12d>
        s = (char*)*ap;
    15ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
    15ef:	8b 00                	mov    (%eax),%eax
    15f1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    15f4:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    15f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    15fc:	75 27                	jne    1625 <printf+0x120>
          s = "(null)";
    15fe:	c7 45 e4 2c 1c 00 00 	movl   $0x1c2c,-0x1c(%ebp)
        while(*s != 0){
    1605:	eb 1f                	jmp    1626 <printf+0x121>
          putc(fd, *s);
    1607:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    160a:	0f b6 00             	movzbl (%eax),%eax
    160d:	0f be c0             	movsbl %al,%eax
    1610:	89 44 24 04          	mov    %eax,0x4(%esp)
    1614:	8b 45 08             	mov    0x8(%ebp),%eax
    1617:	89 04 24             	mov    %eax,(%esp)
    161a:	e8 0d fe ff ff       	call   142c <putc>
          s++;
    161f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    1623:	eb 01                	jmp    1626 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1625:	90                   	nop
    1626:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1629:	0f b6 00             	movzbl (%eax),%eax
    162c:	84 c0                	test   %al,%al
    162e:	75 d7                	jne    1607 <printf+0x102>
    1630:	eb 68                	jmp    169a <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    1632:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1636:	75 1d                	jne    1655 <printf+0x150>
        putc(fd, *ap);
    1638:	8b 45 f4             	mov    -0xc(%ebp),%eax
    163b:	8b 00                	mov    (%eax),%eax
    163d:	0f be c0             	movsbl %al,%eax
    1640:	89 44 24 04          	mov    %eax,0x4(%esp)
    1644:	8b 45 08             	mov    0x8(%ebp),%eax
    1647:	89 04 24             	mov    %eax,(%esp)
    164a:	e8 dd fd ff ff       	call   142c <putc>
        ap++;
    164f:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    1653:	eb 45                	jmp    169a <printf+0x195>
      } else if(c == '%'){
    1655:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1659:	75 17                	jne    1672 <printf+0x16d>
        putc(fd, c);
    165b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    165e:	0f be c0             	movsbl %al,%eax
    1661:	89 44 24 04          	mov    %eax,0x4(%esp)
    1665:	8b 45 08             	mov    0x8(%ebp),%eax
    1668:	89 04 24             	mov    %eax,(%esp)
    166b:	e8 bc fd ff ff       	call   142c <putc>
    1670:	eb 28                	jmp    169a <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    1672:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    1679:	00 
    167a:	8b 45 08             	mov    0x8(%ebp),%eax
    167d:	89 04 24             	mov    %eax,(%esp)
    1680:	e8 a7 fd ff ff       	call   142c <putc>
        putc(fd, c);
    1685:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1688:	0f be c0             	movsbl %al,%eax
    168b:	89 44 24 04          	mov    %eax,0x4(%esp)
    168f:	8b 45 08             	mov    0x8(%ebp),%eax
    1692:	89 04 24             	mov    %eax,(%esp)
    1695:	e8 92 fd ff ff       	call   142c <putc>
      }
      state = 0;
    169a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    16a1:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    16a5:	8b 55 0c             	mov    0xc(%ebp),%edx
    16a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    16ab:	8d 04 02             	lea    (%edx,%eax,1),%eax
    16ae:	0f b6 00             	movzbl (%eax),%eax
    16b1:	84 c0                	test   %al,%al
    16b3:	0f 85 6e fe ff ff    	jne    1527 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    16b9:	c9                   	leave  
    16ba:	c3                   	ret    
    16bb:	90                   	nop

000016bc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16bc:	55                   	push   %ebp
    16bd:	89 e5                	mov    %esp,%ebp
    16bf:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    16c2:	8b 45 08             	mov    0x8(%ebp),%eax
    16c5:	83 e8 08             	sub    $0x8,%eax
    16c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16cb:	a1 88 1c 00 00       	mov    0x1c88,%eax
    16d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16d3:	eb 24                	jmp    16f9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    16d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16d8:	8b 00                	mov    (%eax),%eax
    16da:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16dd:	77 12                	ja     16f1 <free+0x35>
    16df:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16e2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16e5:	77 24                	ja     170b <free+0x4f>
    16e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16ea:	8b 00                	mov    (%eax),%eax
    16ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    16ef:	77 1a                	ja     170b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16f4:	8b 00                	mov    (%eax),%eax
    16f6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    16f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16fc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    16ff:	76 d4                	jbe    16d5 <free+0x19>
    1701:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1704:	8b 00                	mov    (%eax),%eax
    1706:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1709:	76 ca                	jbe    16d5 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    170b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    170e:	8b 40 04             	mov    0x4(%eax),%eax
    1711:	c1 e0 03             	shl    $0x3,%eax
    1714:	89 c2                	mov    %eax,%edx
    1716:	03 55 f8             	add    -0x8(%ebp),%edx
    1719:	8b 45 fc             	mov    -0x4(%ebp),%eax
    171c:	8b 00                	mov    (%eax),%eax
    171e:	39 c2                	cmp    %eax,%edx
    1720:	75 24                	jne    1746 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    1722:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1725:	8b 50 04             	mov    0x4(%eax),%edx
    1728:	8b 45 fc             	mov    -0x4(%ebp),%eax
    172b:	8b 00                	mov    (%eax),%eax
    172d:	8b 40 04             	mov    0x4(%eax),%eax
    1730:	01 c2                	add    %eax,%edx
    1732:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1735:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1738:	8b 45 fc             	mov    -0x4(%ebp),%eax
    173b:	8b 00                	mov    (%eax),%eax
    173d:	8b 10                	mov    (%eax),%edx
    173f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1742:	89 10                	mov    %edx,(%eax)
    1744:	eb 0a                	jmp    1750 <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1746:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1749:	8b 10                	mov    (%eax),%edx
    174b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    174e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    1750:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1753:	8b 40 04             	mov    0x4(%eax),%eax
    1756:	c1 e0 03             	shl    $0x3,%eax
    1759:	03 45 fc             	add    -0x4(%ebp),%eax
    175c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    175f:	75 20                	jne    1781 <free+0xc5>
    p->s.size += bp->s.size;
    1761:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1764:	8b 50 04             	mov    0x4(%eax),%edx
    1767:	8b 45 f8             	mov    -0x8(%ebp),%eax
    176a:	8b 40 04             	mov    0x4(%eax),%eax
    176d:	01 c2                	add    %eax,%edx
    176f:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1772:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1775:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1778:	8b 10                	mov    (%eax),%edx
    177a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    177d:	89 10                	mov    %edx,(%eax)
    177f:	eb 08                	jmp    1789 <free+0xcd>
  } else
    p->s.ptr = bp;
    1781:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1784:	8b 55 f8             	mov    -0x8(%ebp),%edx
    1787:	89 10                	mov    %edx,(%eax)
  freep = p;
    1789:	8b 45 fc             	mov    -0x4(%ebp),%eax
    178c:	a3 88 1c 00 00       	mov    %eax,0x1c88
}
    1791:	c9                   	leave  
    1792:	c3                   	ret    

00001793 <morecore>:

static Header*
morecore(uint nu)
{
    1793:	55                   	push   %ebp
    1794:	89 e5                	mov    %esp,%ebp
    1796:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    1799:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    17a0:	77 07                	ja     17a9 <morecore+0x16>
    nu = 4096;
    17a2:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    17a9:	8b 45 08             	mov    0x8(%ebp),%eax
    17ac:	c1 e0 03             	shl    $0x3,%eax
    17af:	89 04 24             	mov    %eax,(%esp)
    17b2:	e8 35 fc ff ff       	call   13ec <sbrk>
    17b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    17ba:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    17be:	75 07                	jne    17c7 <morecore+0x34>
    return 0;
    17c0:	b8 00 00 00 00       	mov    $0x0,%eax
    17c5:	eb 22                	jmp    17e9 <morecore+0x56>
  hp = (Header*)p;
    17c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    17cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d0:	8b 55 08             	mov    0x8(%ebp),%edx
    17d3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    17d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17d9:	83 c0 08             	add    $0x8,%eax
    17dc:	89 04 24             	mov    %eax,(%esp)
    17df:	e8 d8 fe ff ff       	call   16bc <free>
  return freep;
    17e4:	a1 88 1c 00 00       	mov    0x1c88,%eax
}
    17e9:	c9                   	leave  
    17ea:	c3                   	ret    

000017eb <malloc>:

void*
malloc(uint nbytes)
{
    17eb:	55                   	push   %ebp
    17ec:	89 e5                	mov    %esp,%ebp
    17ee:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    17f1:	8b 45 08             	mov    0x8(%ebp),%eax
    17f4:	83 c0 07             	add    $0x7,%eax
    17f7:	c1 e8 03             	shr    $0x3,%eax
    17fa:	83 c0 01             	add    $0x1,%eax
    17fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    1800:	a1 88 1c 00 00       	mov    0x1c88,%eax
    1805:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1808:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    180c:	75 23                	jne    1831 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    180e:	c7 45 f0 80 1c 00 00 	movl   $0x1c80,-0x10(%ebp)
    1815:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1818:	a3 88 1c 00 00       	mov    %eax,0x1c88
    181d:	a1 88 1c 00 00       	mov    0x1c88,%eax
    1822:	a3 80 1c 00 00       	mov    %eax,0x1c80
    base.s.size = 0;
    1827:	c7 05 84 1c 00 00 00 	movl   $0x0,0x1c84
    182e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1831:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1834:	8b 00                	mov    (%eax),%eax
    1836:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1839:	8b 45 ec             	mov    -0x14(%ebp),%eax
    183c:	8b 40 04             	mov    0x4(%eax),%eax
    183f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1842:	72 4d                	jb     1891 <malloc+0xa6>
      if(p->s.size == nunits)
    1844:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1847:	8b 40 04             	mov    0x4(%eax),%eax
    184a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    184d:	75 0c                	jne    185b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    184f:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1852:	8b 10                	mov    (%eax),%edx
    1854:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1857:	89 10                	mov    %edx,(%eax)
    1859:	eb 26                	jmp    1881 <malloc+0x96>
      else {
        p->s.size -= nunits;
    185b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    185e:	8b 40 04             	mov    0x4(%eax),%eax
    1861:	89 c2                	mov    %eax,%edx
    1863:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1866:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1869:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    186c:	8b 45 ec             	mov    -0x14(%ebp),%eax
    186f:	8b 40 04             	mov    0x4(%eax),%eax
    1872:	c1 e0 03             	shl    $0x3,%eax
    1875:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    1878:	8b 45 ec             	mov    -0x14(%ebp),%eax
    187b:	8b 55 f4             	mov    -0xc(%ebp),%edx
    187e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    1881:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1884:	a3 88 1c 00 00       	mov    %eax,0x1c88
      return (void*)(p + 1);
    1889:	8b 45 ec             	mov    -0x14(%ebp),%eax
    188c:	83 c0 08             	add    $0x8,%eax
    188f:	eb 38                	jmp    18c9 <malloc+0xde>
    }
    if(p == freep)
    1891:	a1 88 1c 00 00       	mov    0x1c88,%eax
    1896:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    1899:	75 1b                	jne    18b6 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    189b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    189e:	89 04 24             	mov    %eax,(%esp)
    18a1:	e8 ed fe ff ff       	call   1793 <morecore>
    18a6:	89 45 ec             	mov    %eax,-0x14(%ebp)
    18a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18ad:	75 07                	jne    18b6 <malloc+0xcb>
        return 0;
    18af:	b8 00 00 00 00       	mov    $0x0,%eax
    18b4:	eb 13                	jmp    18c9 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    18b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
    18bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
    18bf:	8b 00                	mov    (%eax),%eax
    18c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    18c4:	e9 70 ff ff ff       	jmp    1839 <malloc+0x4e>
}
    18c9:	c9                   	leave  
    18ca:	c3                   	ret    
    18cb:	90                   	nop

000018cc <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    18cc:	55                   	push   %ebp
    18cd:	89 e5                	mov    %esp,%ebp
    18cf:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    18d2:	8b 55 08             	mov    0x8(%ebp),%edx
    18d5:	8b 45 0c             	mov    0xc(%ebp),%eax
    18d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
    18db:	f0 87 02             	lock xchg %eax,(%edx)
    18de:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    18e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    18e4:	c9                   	leave  
    18e5:	c3                   	ret    

000018e6 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    18e6:	55                   	push   %ebp
    18e7:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    18e9:	8b 45 08             	mov    0x8(%ebp),%eax
    18ec:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    18f2:	5d                   	pop    %ebp
    18f3:	c3                   	ret    

000018f4 <lock_acquire>:
void lock_acquire(lock_t *lock){
    18f4:	55                   	push   %ebp
    18f5:	89 e5                	mov    %esp,%ebp
    18f7:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    18fa:	8b 45 08             	mov    0x8(%ebp),%eax
    18fd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1904:	00 
    1905:	89 04 24             	mov    %eax,(%esp)
    1908:	e8 bf ff ff ff       	call   18cc <xchg>
    190d:	85 c0                	test   %eax,%eax
    190f:	75 e9                	jne    18fa <lock_acquire+0x6>
}
    1911:	c9                   	leave  
    1912:	c3                   	ret    

00001913 <lock_release>:
void lock_release(lock_t *lock){
    1913:	55                   	push   %ebp
    1914:	89 e5                	mov    %esp,%ebp
    1916:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1919:	8b 45 08             	mov    0x8(%ebp),%eax
    191c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1923:	00 
    1924:	89 04 24             	mov    %eax,(%esp)
    1927:	e8 a0 ff ff ff       	call   18cc <xchg>
}
    192c:	c9                   	leave  
    192d:	c3                   	ret    

0000192e <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    192e:	55                   	push   %ebp
    192f:	89 e5                	mov    %esp,%ebp
    1931:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1934:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    193b:	e8 ab fe ff ff       	call   17eb <malloc>
    1940:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    1943:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1946:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1949:	8b 45 f0             	mov    -0x10(%ebp),%eax
    194c:	25 ff 0f 00 00       	and    $0xfff,%eax
    1951:	85 c0                	test   %eax,%eax
    1953:	74 15                	je     196a <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1955:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1958:	89 c2                	mov    %eax,%edx
    195a:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    1960:	b8 00 10 00 00       	mov    $0x1000,%eax
    1965:	29 d0                	sub    %edx,%eax
    1967:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    196a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    196e:	75 1b                	jne    198b <thread_create+0x5d>

        printf(1,"malloc fail \n");
    1970:	c7 44 24 04 33 1c 00 	movl   $0x1c33,0x4(%esp)
    1977:	00 
    1978:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    197f:	e8 81 fb ff ff       	call   1505 <printf>
        return 0;
    1984:	b8 00 00 00 00       	mov    $0x0,%eax
    1989:	eb 6f                	jmp    19fa <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    198b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    198e:	8b 55 08             	mov    0x8(%ebp),%edx
    1991:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1994:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    1998:	89 54 24 08          	mov    %edx,0x8(%esp)
    199c:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    19a3:	00 
    19a4:	89 04 24             	mov    %eax,(%esp)
    19a7:	e8 58 fa ff ff       	call   1404 <clone>
    19ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    19af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19b3:	79 1b                	jns    19d0 <thread_create+0xa2>
        printf(1,"clone fails\n");
    19b5:	c7 44 24 04 41 1c 00 	movl   $0x1c41,0x4(%esp)
    19bc:	00 
    19bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19c4:	e8 3c fb ff ff       	call   1505 <printf>
        return 0;
    19c9:	b8 00 00 00 00       	mov    $0x0,%eax
    19ce:	eb 2a                	jmp    19fa <thread_create+0xcc>
    }
    if(tid > 0){
    19d0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19d4:	7e 05                	jle    19db <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    19d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    19d9:	eb 1f                	jmp    19fa <thread_create+0xcc>
    }
    if(tid == 0){
    19db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19df:	75 14                	jne    19f5 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    19e1:	c7 44 24 04 4e 1c 00 	movl   $0x1c4e,0x4(%esp)
    19e8:	00 
    19e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    19f0:	e8 10 fb ff ff       	call   1505 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    19f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
    19fa:	c9                   	leave  
    19fb:	c3                   	ret    

000019fc <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    19fc:	55                   	push   %ebp
    19fd:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    19ff:	a1 7c 1c 00 00       	mov    0x1c7c,%eax
    1a04:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1a0a:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    1a0f:	a3 7c 1c 00 00       	mov    %eax,0x1c7c
    return (int)(rands % max);
    1a14:	a1 7c 1c 00 00       	mov    0x1c7c,%eax
    1a19:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1a1c:	ba 00 00 00 00       	mov    $0x0,%edx
    1a21:	f7 f1                	div    %ecx
    1a23:	89 d0                	mov    %edx,%eax
}
    1a25:	5d                   	pop    %ebp
    1a26:	c3                   	ret    
    1a27:	90                   	nop

00001a28 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1a28:	55                   	push   %ebp
    1a29:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1a2b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a2e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1a34:	8b 45 08             	mov    0x8(%ebp),%eax
    1a37:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    1a3e:	8b 45 08             	mov    0x8(%ebp),%eax
    1a41:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1a48:	5d                   	pop    %ebp
    1a49:	c3                   	ret    

00001a4a <add_q>:

void add_q(struct queue *q, int v){
    1a4a:	55                   	push   %ebp
    1a4b:	89 e5                	mov    %esp,%ebp
    1a4d:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    1a50:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1a57:	e8 8f fd ff ff       	call   17eb <malloc>
    1a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    1a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a62:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a6c:	8b 55 0c             	mov    0xc(%ebp),%edx
    1a6f:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    1a71:	8b 45 08             	mov    0x8(%ebp),%eax
    1a74:	8b 40 04             	mov    0x4(%eax),%eax
    1a77:	85 c0                	test   %eax,%eax
    1a79:	75 0b                	jne    1a86 <add_q+0x3c>
        q->head = n;
    1a7b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a81:	89 50 04             	mov    %edx,0x4(%eax)
    1a84:	eb 0c                	jmp    1a92 <add_q+0x48>
    }else{
        q->tail->next = n;
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	8b 40 08             	mov    0x8(%eax),%eax
    1a8c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a8f:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    1a92:	8b 45 08             	mov    0x8(%ebp),%eax
    1a95:	8b 55 f4             	mov    -0xc(%ebp),%edx
    1a98:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    1a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a9e:	8b 00                	mov    (%eax),%eax
    1aa0:	8d 50 01             	lea    0x1(%eax),%edx
    1aa3:	8b 45 08             	mov    0x8(%ebp),%eax
    1aa6:	89 10                	mov    %edx,(%eax)
}
    1aa8:	c9                   	leave  
    1aa9:	c3                   	ret    

00001aaa <empty_q>:

int empty_q(struct queue *q){
    1aaa:	55                   	push   %ebp
    1aab:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    1aad:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab0:	8b 00                	mov    (%eax),%eax
    1ab2:	85 c0                	test   %eax,%eax
    1ab4:	75 07                	jne    1abd <empty_q+0x13>
        return 1;
    1ab6:	b8 01 00 00 00       	mov    $0x1,%eax
    1abb:	eb 05                	jmp    1ac2 <empty_q+0x18>
    else
        return 0;
    1abd:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    1ac2:	5d                   	pop    %ebp
    1ac3:	c3                   	ret    

00001ac4 <pop_q>:
int pop_q(struct queue *q){
    1ac4:	55                   	push   %ebp
    1ac5:	89 e5                	mov    %esp,%ebp
    1ac7:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    1aca:	8b 45 08             	mov    0x8(%ebp),%eax
    1acd:	89 04 24             	mov    %eax,(%esp)
    1ad0:	e8 d5 ff ff ff       	call   1aaa <empty_q>
    1ad5:	85 c0                	test   %eax,%eax
    1ad7:	75 5d                	jne    1b36 <pop_q+0x72>
       val = q->head->value; 
    1ad9:	8b 45 08             	mov    0x8(%ebp),%eax
    1adc:	8b 40 04             	mov    0x4(%eax),%eax
    1adf:	8b 00                	mov    (%eax),%eax
    1ae1:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae7:	8b 40 04             	mov    0x4(%eax),%eax
    1aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1aed:	8b 45 08             	mov    0x8(%ebp),%eax
    1af0:	8b 40 04             	mov    0x4(%eax),%eax
    1af3:	8b 50 04             	mov    0x4(%eax),%edx
    1af6:	8b 45 08             	mov    0x8(%ebp),%eax
    1af9:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1aff:	89 04 24             	mov    %eax,(%esp)
    1b02:	e8 b5 fb ff ff       	call   16bc <free>
       q->size--;
    1b07:	8b 45 08             	mov    0x8(%ebp),%eax
    1b0a:	8b 00                	mov    (%eax),%eax
    1b0c:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b0f:	8b 45 08             	mov    0x8(%ebp),%eax
    1b12:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1b14:	8b 45 08             	mov    0x8(%ebp),%eax
    1b17:	8b 00                	mov    (%eax),%eax
    1b19:	85 c0                	test   %eax,%eax
    1b1b:	75 14                	jne    1b31 <pop_q+0x6d>
            q->head = 0;
    1b1d:	8b 45 08             	mov    0x8(%ebp),%eax
    1b20:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1b27:	8b 45 08             	mov    0x8(%ebp),%eax
    1b2a:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1b31:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1b34:	eb 05                	jmp    1b3b <pop_q+0x77>
    }
    return -1;
    1b36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1b3b:	c9                   	leave  
    1b3c:	c3                   	ret    
    1b3d:	90                   	nop
    1b3e:	90                   	nop
    1b3f:	90                   	nop

00001b40 <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1b40:	55                   	push   %ebp
    1b41:	89 e5                	mov    %esp,%ebp
    1b43:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1b46:	8b 45 08             	mov    0x8(%ebp),%eax
    1b49:	89 04 24             	mov    %eax,(%esp)
    1b4c:	e8 a3 fd ff ff       	call   18f4 <lock_acquire>
	s->count--; 
    1b51:	8b 45 08             	mov    0x8(%ebp),%eax
    1b54:	8b 40 04             	mov    0x4(%eax),%eax
    1b57:	8d 50 ff             	lea    -0x1(%eax),%edx
    1b5a:	8b 45 08             	mov    0x8(%ebp),%eax
    1b5d:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1b60:	8b 45 08             	mov    0x8(%ebp),%eax
    1b63:	8b 40 04             	mov    0x4(%eax),%eax
    1b66:	85 c0                	test   %eax,%eax
    1b68:	79 27                	jns    1b91 <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1b6a:	e8 75 f8 ff ff       	call   13e4 <getpid>
    1b6f:	8b 55 08             	mov    0x8(%ebp),%edx
    1b72:	83 c2 08             	add    $0x8,%edx
    1b75:	89 44 24 04          	mov    %eax,0x4(%esp)
    1b79:	89 14 24             	mov    %edx,(%esp)
    1b7c:	e8 c9 fe ff ff       	call   1a4a <add_q>
		lock_release(&s->lock); 
    1b81:	8b 45 08             	mov    0x8(%ebp),%eax
    1b84:	89 04 24             	mov    %eax,(%esp)
    1b87:	e8 87 fd ff ff       	call   1913 <lock_release>
		tsleep(); 
    1b8c:	e8 83 f8 ff ff       	call   1414 <tsleep>
	} 
	lock_release(&s->lock); 
    1b91:	8b 45 08             	mov    0x8(%ebp),%eax
    1b94:	89 04 24             	mov    %eax,(%esp)
    1b97:	e8 77 fd ff ff       	call   1913 <lock_release>
}
    1b9c:	c9                   	leave  
    1b9d:	c3                   	ret    

00001b9e <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1b9e:	55                   	push   %ebp
    1b9f:	89 e5                	mov    %esp,%ebp
    1ba1:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1ba4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ba7:	89 04 24             	mov    %eax,(%esp)
    1baa:	e8 45 fd ff ff       	call   18f4 <lock_acquire>
	s->count++; 
    1baf:	8b 45 08             	mov    0x8(%ebp),%eax
    1bb2:	8b 40 04             	mov    0x4(%eax),%eax
    1bb5:	8d 50 01             	lea    0x1(%eax),%edx
    1bb8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bbb:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1bbe:	8b 45 08             	mov    0x8(%ebp),%eax
    1bc1:	8b 40 04             	mov    0x4(%eax),%eax
    1bc4:	85 c0                	test   %eax,%eax
    1bc6:	7f 1c                	jg     1be4 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1bc8:	8b 45 08             	mov    0x8(%ebp),%eax
    1bcb:	83 c0 08             	add    $0x8,%eax
    1bce:	89 04 24             	mov    %eax,(%esp)
    1bd1:	e8 ee fe ff ff       	call   1ac4 <pop_q>
    1bd6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1bd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bdc:	89 04 24             	mov    %eax,(%esp)
    1bdf:	e8 38 f8 ff ff       	call   141c <twakeup>
	}
	lock_release(&s->lock); 
    1be4:	8b 45 08             	mov    0x8(%ebp),%eax
    1be7:	89 04 24             	mov    %eax,(%esp)
    1bea:	e8 24 fd ff ff       	call   1913 <lock_release>
} 
    1bef:	c9                   	leave  
    1bf0:	c3                   	ret    

00001bf1 <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1bf1:	55                   	push   %ebp
    1bf2:	89 e5                	mov    %esp,%ebp
    1bf4:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1bf7:	8b 45 08             	mov    0x8(%ebp),%eax
    1bfa:	89 04 24             	mov    %eax,(%esp)
    1bfd:	e8 e4 fc ff ff       	call   18e6 <lock_init>
	s->count = size; 
    1c02:	8b 45 08             	mov    0x8(%ebp),%eax
    1c05:	8b 55 0c             	mov    0xc(%ebp),%edx
    1c08:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1c0b:	8b 45 08             	mov    0x8(%ebp),%eax
    1c0e:	83 c0 08             	add    $0x8,%eax
    1c11:	89 04 24             	mov    %eax,(%esp)
    1c14:	e8 0f fe ff ff       	call   1a28 <init_q>
}
    1c19:	c9                   	leave  
    1c1a:	c3                   	ret    
