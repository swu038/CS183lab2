
_NULL:     file format elf32-i386


Disassembly of section .text:

00001000 <main>:


int main () {
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	83 ec 10             	sub    $0x10,%esp

	int *a = 0;
    1006:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	int b = *a; 
    100d:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1010:	8b 00                	mov    (%eax),%eax
    1012:	89 45 fc             	mov    %eax,-0x4(%ebp)

	if( b == 10) 
    1015:	83 7d fc 0a          	cmpl   $0xa,-0x4(%ebp)
    1019:	75 07                	jne    1022 <main+0x22>
	{
		return 0;  
    101b:	b8 00 00 00 00       	mov    $0x0,%eax
    1020:	eb 05                	jmp    1027 <main+0x27>
	}  
	return 0; 
    1022:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1027:	c9                   	leave  
    1028:	c3                   	ret    
    1029:	90                   	nop
    102a:	90                   	nop
    102b:	90                   	nop

0000102c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    102c:	55                   	push   %ebp
    102d:	89 e5                	mov    %esp,%ebp
    102f:	57                   	push   %edi
    1030:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    1031:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1034:	8b 55 10             	mov    0x10(%ebp),%edx
    1037:	8b 45 0c             	mov    0xc(%ebp),%eax
    103a:	89 cb                	mov    %ecx,%ebx
    103c:	89 df                	mov    %ebx,%edi
    103e:	89 d1                	mov    %edx,%ecx
    1040:	fc                   	cld    
    1041:	f3 aa                	rep stos %al,%es:(%edi)
    1043:	89 ca                	mov    %ecx,%edx
    1045:	89 fb                	mov    %edi,%ebx
    1047:	89 5d 08             	mov    %ebx,0x8(%ebp)
    104a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    104d:	5b                   	pop    %ebx
    104e:	5f                   	pop    %edi
    104f:	5d                   	pop    %ebp
    1050:	c3                   	ret    

00001051 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    1051:	55                   	push   %ebp
    1052:	89 e5                	mov    %esp,%ebp
    1054:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    1057:	8b 45 08             	mov    0x8(%ebp),%eax
    105a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    105d:	8b 45 0c             	mov    0xc(%ebp),%eax
    1060:	0f b6 10             	movzbl (%eax),%edx
    1063:	8b 45 08             	mov    0x8(%ebp),%eax
    1066:	88 10                	mov    %dl,(%eax)
    1068:	8b 45 08             	mov    0x8(%ebp),%eax
    106b:	0f b6 00             	movzbl (%eax),%eax
    106e:	84 c0                	test   %al,%al
    1070:	0f 95 c0             	setne  %al
    1073:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1077:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    107b:	84 c0                	test   %al,%al
    107d:	75 de                	jne    105d <strcpy+0xc>
    ;
  return os;
    107f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1082:	c9                   	leave  
    1083:	c3                   	ret    

00001084 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1084:	55                   	push   %ebp
    1085:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    1087:	eb 08                	jmp    1091 <strcmp+0xd>
    p++, q++;
    1089:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    108d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    1091:	8b 45 08             	mov    0x8(%ebp),%eax
    1094:	0f b6 00             	movzbl (%eax),%eax
    1097:	84 c0                	test   %al,%al
    1099:	74 10                	je     10ab <strcmp+0x27>
    109b:	8b 45 08             	mov    0x8(%ebp),%eax
    109e:	0f b6 10             	movzbl (%eax),%edx
    10a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    10a4:	0f b6 00             	movzbl (%eax),%eax
    10a7:	38 c2                	cmp    %al,%dl
    10a9:	74 de                	je     1089 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    10ab:	8b 45 08             	mov    0x8(%ebp),%eax
    10ae:	0f b6 00             	movzbl (%eax),%eax
    10b1:	0f b6 d0             	movzbl %al,%edx
    10b4:	8b 45 0c             	mov    0xc(%ebp),%eax
    10b7:	0f b6 00             	movzbl (%eax),%eax
    10ba:	0f b6 c0             	movzbl %al,%eax
    10bd:	89 d1                	mov    %edx,%ecx
    10bf:	29 c1                	sub    %eax,%ecx
    10c1:	89 c8                	mov    %ecx,%eax
}
    10c3:	5d                   	pop    %ebp
    10c4:	c3                   	ret    

000010c5 <strlen>:

uint
strlen(char *s)
{
    10c5:	55                   	push   %ebp
    10c6:	89 e5                	mov    %esp,%ebp
    10c8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    10cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    10d2:	eb 04                	jmp    10d8 <strlen+0x13>
    10d4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    10d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
    10db:	03 45 08             	add    0x8(%ebp),%eax
    10de:	0f b6 00             	movzbl (%eax),%eax
    10e1:	84 c0                	test   %al,%al
    10e3:	75 ef                	jne    10d4 <strlen+0xf>
    ;
  return n;
    10e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    10e8:	c9                   	leave  
    10e9:	c3                   	ret    

000010ea <memset>:

void*
memset(void *dst, int c, uint n)
{
    10ea:	55                   	push   %ebp
    10eb:	89 e5                	mov    %esp,%ebp
    10ed:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
    10f0:	8b 45 10             	mov    0x10(%ebp),%eax
    10f3:	89 44 24 08          	mov    %eax,0x8(%esp)
    10f7:	8b 45 0c             	mov    0xc(%ebp),%eax
    10fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    10fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1101:	89 04 24             	mov    %eax,(%esp)
    1104:	e8 23 ff ff ff       	call   102c <stosb>
  return dst;
    1109:	8b 45 08             	mov    0x8(%ebp),%eax
}
    110c:	c9                   	leave  
    110d:	c3                   	ret    

0000110e <strchr>:

char*
strchr(const char *s, char c)
{
    110e:	55                   	push   %ebp
    110f:	89 e5                	mov    %esp,%ebp
    1111:	83 ec 04             	sub    $0x4,%esp
    1114:	8b 45 0c             	mov    0xc(%ebp),%eax
    1117:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    111a:	eb 14                	jmp    1130 <strchr+0x22>
    if(*s == c)
    111c:	8b 45 08             	mov    0x8(%ebp),%eax
    111f:	0f b6 00             	movzbl (%eax),%eax
    1122:	3a 45 fc             	cmp    -0x4(%ebp),%al
    1125:	75 05                	jne    112c <strchr+0x1e>
      return (char*)s;
    1127:	8b 45 08             	mov    0x8(%ebp),%eax
    112a:	eb 13                	jmp    113f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    112c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    1130:	8b 45 08             	mov    0x8(%ebp),%eax
    1133:	0f b6 00             	movzbl (%eax),%eax
    1136:	84 c0                	test   %al,%al
    1138:	75 e2                	jne    111c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    113a:	b8 00 00 00 00       	mov    $0x0,%eax
}
    113f:	c9                   	leave  
    1140:	c3                   	ret    

00001141 <gets>:

char*
gets(char *buf, int max)
{
    1141:	55                   	push   %ebp
    1142:	89 e5                	mov    %esp,%ebp
    1144:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1147:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    114e:	eb 44                	jmp    1194 <gets+0x53>
    cc = read(0, &c, 1);
    1150:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1157:	00 
    1158:	8d 45 ef             	lea    -0x11(%ebp),%eax
    115b:	89 44 24 04          	mov    %eax,0x4(%esp)
    115f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1166:	e8 3d 01 00 00       	call   12a8 <read>
    116b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(cc < 1)
    116e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1172:	7e 2d                	jle    11a1 <gets+0x60>
      break;
    buf[i++] = c;
    1174:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1177:	03 45 08             	add    0x8(%ebp),%eax
    117a:	0f b6 55 ef          	movzbl -0x11(%ebp),%edx
    117e:	88 10                	mov    %dl,(%eax)
    1180:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    if(c == '\n' || c == '\r')
    1184:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1188:	3c 0a                	cmp    $0xa,%al
    118a:	74 16                	je     11a2 <gets+0x61>
    118c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    1190:	3c 0d                	cmp    $0xd,%al
    1192:	74 0e                	je     11a2 <gets+0x61>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1194:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1197:	83 c0 01             	add    $0x1,%eax
    119a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    119d:	7c b1                	jl     1150 <gets+0xf>
    119f:	eb 01                	jmp    11a2 <gets+0x61>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    11a1:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    11a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11a5:	03 45 08             	add    0x8(%ebp),%eax
    11a8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    11ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
    11ae:	c9                   	leave  
    11af:	c3                   	ret    

000011b0 <stat>:

int
stat(char *n, struct stat *st)
{
    11b0:	55                   	push   %ebp
    11b1:	89 e5                	mov    %esp,%ebp
    11b3:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    11b6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    11bd:	00 
    11be:	8b 45 08             	mov    0x8(%ebp),%eax
    11c1:	89 04 24             	mov    %eax,(%esp)
    11c4:	e8 07 01 00 00       	call   12d0 <open>
    11c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0)
    11cc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    11d0:	79 07                	jns    11d9 <stat+0x29>
    return -1;
    11d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    11d7:	eb 23                	jmp    11fc <stat+0x4c>
  r = fstat(fd, st);
    11d9:	8b 45 0c             	mov    0xc(%ebp),%eax
    11dc:	89 44 24 04          	mov    %eax,0x4(%esp)
    11e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e3:	89 04 24             	mov    %eax,(%esp)
    11e6:	e8 fd 00 00 00       	call   12e8 <fstat>
    11eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  close(fd);
    11ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11f1:	89 04 24             	mov    %eax,(%esp)
    11f4:	e8 bf 00 00 00       	call   12b8 <close>
  return r;
    11f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
    11fc:	c9                   	leave  
    11fd:	c3                   	ret    

000011fe <atoi>:

int
atoi(const char *s)
{
    11fe:	55                   	push   %ebp
    11ff:	89 e5                	mov    %esp,%ebp
    1201:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    1204:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    120b:	eb 24                	jmp    1231 <atoi+0x33>
    n = n*10 + *s++ - '0';
    120d:	8b 55 fc             	mov    -0x4(%ebp),%edx
    1210:	89 d0                	mov    %edx,%eax
    1212:	c1 e0 02             	shl    $0x2,%eax
    1215:	01 d0                	add    %edx,%eax
    1217:	01 c0                	add    %eax,%eax
    1219:	89 c2                	mov    %eax,%edx
    121b:	8b 45 08             	mov    0x8(%ebp),%eax
    121e:	0f b6 00             	movzbl (%eax),%eax
    1221:	0f be c0             	movsbl %al,%eax
    1224:	8d 04 02             	lea    (%edx,%eax,1),%eax
    1227:	83 e8 30             	sub    $0x30,%eax
    122a:	89 45 fc             	mov    %eax,-0x4(%ebp)
    122d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1231:	8b 45 08             	mov    0x8(%ebp),%eax
    1234:	0f b6 00             	movzbl (%eax),%eax
    1237:	3c 2f                	cmp    $0x2f,%al
    1239:	7e 0a                	jle    1245 <atoi+0x47>
    123b:	8b 45 08             	mov    0x8(%ebp),%eax
    123e:	0f b6 00             	movzbl (%eax),%eax
    1241:	3c 39                	cmp    $0x39,%al
    1243:	7e c8                	jle    120d <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    1245:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1248:	c9                   	leave  
    1249:	c3                   	ret    

0000124a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    124a:	55                   	push   %ebp
    124b:	89 e5                	mov    %esp,%ebp
    124d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
    1250:	8b 45 08             	mov    0x8(%ebp),%eax
    1253:	89 45 f8             	mov    %eax,-0x8(%ebp)
  src = vsrc;
    1256:	8b 45 0c             	mov    0xc(%ebp),%eax
    1259:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0)
    125c:	eb 13                	jmp    1271 <memmove+0x27>
    *dst++ = *src++;
    125e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1261:	0f b6 10             	movzbl (%eax),%edx
    1264:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1267:	88 10                	mov    %dl,(%eax)
    1269:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    126d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    1271:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
    1275:	0f 9f c0             	setg   %al
    1278:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    127c:	84 c0                	test   %al,%al
    127e:	75 de                	jne    125e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    1280:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1283:	c9                   	leave  
    1284:	c3                   	ret    
    1285:	90                   	nop
    1286:	90                   	nop
    1287:	90                   	nop

00001288 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    1288:	b8 01 00 00 00       	mov    $0x1,%eax
    128d:	cd 40                	int    $0x40
    128f:	c3                   	ret    

00001290 <exit>:
SYSCALL(exit)
    1290:	b8 02 00 00 00       	mov    $0x2,%eax
    1295:	cd 40                	int    $0x40
    1297:	c3                   	ret    

00001298 <wait>:
SYSCALL(wait)
    1298:	b8 03 00 00 00       	mov    $0x3,%eax
    129d:	cd 40                	int    $0x40
    129f:	c3                   	ret    

000012a0 <pipe>:
SYSCALL(pipe)
    12a0:	b8 04 00 00 00       	mov    $0x4,%eax
    12a5:	cd 40                	int    $0x40
    12a7:	c3                   	ret    

000012a8 <read>:
SYSCALL(read)
    12a8:	b8 05 00 00 00       	mov    $0x5,%eax
    12ad:	cd 40                	int    $0x40
    12af:	c3                   	ret    

000012b0 <write>:
SYSCALL(write)
    12b0:	b8 10 00 00 00       	mov    $0x10,%eax
    12b5:	cd 40                	int    $0x40
    12b7:	c3                   	ret    

000012b8 <close>:
SYSCALL(close)
    12b8:	b8 15 00 00 00       	mov    $0x15,%eax
    12bd:	cd 40                	int    $0x40
    12bf:	c3                   	ret    

000012c0 <kill>:
SYSCALL(kill)
    12c0:	b8 06 00 00 00       	mov    $0x6,%eax
    12c5:	cd 40                	int    $0x40
    12c7:	c3                   	ret    

000012c8 <exec>:
SYSCALL(exec)
    12c8:	b8 07 00 00 00       	mov    $0x7,%eax
    12cd:	cd 40                	int    $0x40
    12cf:	c3                   	ret    

000012d0 <open>:
SYSCALL(open)
    12d0:	b8 0f 00 00 00       	mov    $0xf,%eax
    12d5:	cd 40                	int    $0x40
    12d7:	c3                   	ret    

000012d8 <mknod>:
SYSCALL(mknod)
    12d8:	b8 11 00 00 00       	mov    $0x11,%eax
    12dd:	cd 40                	int    $0x40
    12df:	c3                   	ret    

000012e0 <unlink>:
SYSCALL(unlink)
    12e0:	b8 12 00 00 00       	mov    $0x12,%eax
    12e5:	cd 40                	int    $0x40
    12e7:	c3                   	ret    

000012e8 <fstat>:
SYSCALL(fstat)
    12e8:	b8 08 00 00 00       	mov    $0x8,%eax
    12ed:	cd 40                	int    $0x40
    12ef:	c3                   	ret    

000012f0 <link>:
SYSCALL(link)
    12f0:	b8 13 00 00 00       	mov    $0x13,%eax
    12f5:	cd 40                	int    $0x40
    12f7:	c3                   	ret    

000012f8 <mkdir>:
SYSCALL(mkdir)
    12f8:	b8 14 00 00 00       	mov    $0x14,%eax
    12fd:	cd 40                	int    $0x40
    12ff:	c3                   	ret    

00001300 <chdir>:
SYSCALL(chdir)
    1300:	b8 09 00 00 00       	mov    $0x9,%eax
    1305:	cd 40                	int    $0x40
    1307:	c3                   	ret    

00001308 <dup>:
SYSCALL(dup)
    1308:	b8 0a 00 00 00       	mov    $0xa,%eax
    130d:	cd 40                	int    $0x40
    130f:	c3                   	ret    

00001310 <getpid>:
SYSCALL(getpid)
    1310:	b8 0b 00 00 00       	mov    $0xb,%eax
    1315:	cd 40                	int    $0x40
    1317:	c3                   	ret    

00001318 <sbrk>:
SYSCALL(sbrk)
    1318:	b8 0c 00 00 00       	mov    $0xc,%eax
    131d:	cd 40                	int    $0x40
    131f:	c3                   	ret    

00001320 <sleep>:
SYSCALL(sleep)
    1320:	b8 0d 00 00 00       	mov    $0xd,%eax
    1325:	cd 40                	int    $0x40
    1327:	c3                   	ret    

00001328 <uptime>:
SYSCALL(uptime)
    1328:	b8 0e 00 00 00       	mov    $0xe,%eax
    132d:	cd 40                	int    $0x40
    132f:	c3                   	ret    

00001330 <clone>:
SYSCALL(clone)
    1330:	b8 16 00 00 00       	mov    $0x16,%eax
    1335:	cd 40                	int    $0x40
    1337:	c3                   	ret    

00001338 <texit>:
SYSCALL(texit)
    1338:	b8 17 00 00 00       	mov    $0x17,%eax
    133d:	cd 40                	int    $0x40
    133f:	c3                   	ret    

00001340 <tsleep>:
SYSCALL(tsleep)
    1340:	b8 18 00 00 00       	mov    $0x18,%eax
    1345:	cd 40                	int    $0x40
    1347:	c3                   	ret    

00001348 <twakeup>:
SYSCALL(twakeup)
    1348:	b8 19 00 00 00       	mov    $0x19,%eax
    134d:	cd 40                	int    $0x40
    134f:	c3                   	ret    

00001350 <thread_yield>:
SYSCALL(thread_yield) 
    1350:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1355:	cd 40                	int    $0x40
    1357:	c3                   	ret    

00001358 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1358:	55                   	push   %ebp
    1359:	89 e5                	mov    %esp,%ebp
    135b:	83 ec 28             	sub    $0x28,%esp
    135e:	8b 45 0c             	mov    0xc(%ebp),%eax
    1361:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    1364:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    136b:	00 
    136c:	8d 45 f4             	lea    -0xc(%ebp),%eax
    136f:	89 44 24 04          	mov    %eax,0x4(%esp)
    1373:	8b 45 08             	mov    0x8(%ebp),%eax
    1376:	89 04 24             	mov    %eax,(%esp)
    1379:	e8 32 ff ff ff       	call   12b0 <write>
}
    137e:	c9                   	leave  
    137f:	c3                   	ret    

00001380 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1380:	55                   	push   %ebp
    1381:	89 e5                	mov    %esp,%ebp
    1383:	53                   	push   %ebx
    1384:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    1387:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    138e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    1392:	74 17                	je     13ab <printint+0x2b>
    1394:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    1398:	79 11                	jns    13ab <printint+0x2b>
    neg = 1;
    139a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    13a1:	8b 45 0c             	mov    0xc(%ebp),%eax
    13a4:	f7 d8                	neg    %eax
    13a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13a9:	eb 06                	jmp    13b1 <printint+0x31>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    13ab:	8b 45 0c             	mov    0xc(%ebp),%eax
    13ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
  }

  i = 0;
    13b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  do{
    buf[i++] = digits[x % base];
    13b8:	8b 4d ec             	mov    -0x14(%ebp),%ecx
    13bb:	8b 5d 10             	mov    0x10(%ebp),%ebx
    13be:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13c1:	ba 00 00 00 00       	mov    $0x0,%edx
    13c6:	f7 f3                	div    %ebx
    13c8:	89 d0                	mov    %edx,%eax
    13ca:	0f b6 80 7c 1b 00 00 	movzbl 0x1b7c(%eax),%eax
    13d1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
    13d5:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  }while((x /= base) != 0);
    13d9:	8b 45 10             	mov    0x10(%ebp),%eax
    13dc:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    13df:	8b 45 f4             	mov    -0xc(%ebp),%eax
    13e2:	ba 00 00 00 00       	mov    $0x0,%edx
    13e7:	f7 75 d4             	divl   -0x2c(%ebp)
    13ea:	89 45 f4             	mov    %eax,-0xc(%ebp)
    13ed:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    13f1:	75 c5                	jne    13b8 <printint+0x38>
  if(neg)
    13f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    13f7:	74 28                	je     1421 <printint+0xa1>
    buf[i++] = '-';
    13f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
    13fc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)
    1401:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)

  while(--i >= 0)
    1405:	eb 1a                	jmp    1421 <printint+0xa1>
    putc(fd, buf[i]);
    1407:	8b 45 ec             	mov    -0x14(%ebp),%eax
    140a:	0f b6 44 05 dc       	movzbl -0x24(%ebp,%eax,1),%eax
    140f:	0f be c0             	movsbl %al,%eax
    1412:	89 44 24 04          	mov    %eax,0x4(%esp)
    1416:	8b 45 08             	mov    0x8(%ebp),%eax
    1419:	89 04 24             	mov    %eax,(%esp)
    141c:	e8 37 ff ff ff       	call   1358 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    1421:	83 6d ec 01          	subl   $0x1,-0x14(%ebp)
    1425:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1429:	79 dc                	jns    1407 <printint+0x87>
    putc(fd, buf[i]);
}
    142b:	83 c4 44             	add    $0x44,%esp
    142e:	5b                   	pop    %ebx
    142f:	5d                   	pop    %ebp
    1430:	c3                   	ret    

00001431 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    1431:	55                   	push   %ebp
    1432:	89 e5                	mov    %esp,%ebp
    1434:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    1437:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    143e:	8d 45 0c             	lea    0xc(%ebp),%eax
    1441:	83 c0 04             	add    $0x4,%eax
    1444:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; fmt[i]; i++){
    1447:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    144e:	e9 7e 01 00 00       	jmp    15d1 <printf+0x1a0>
    c = fmt[i] & 0xff;
    1453:	8b 55 0c             	mov    0xc(%ebp),%edx
    1456:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1459:	8d 04 02             	lea    (%edx,%eax,1),%eax
    145c:	0f b6 00             	movzbl (%eax),%eax
    145f:	0f be c0             	movsbl %al,%eax
    1462:	25 ff 00 00 00       	and    $0xff,%eax
    1467:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(state == 0){
    146a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    146e:	75 2c                	jne    149c <printf+0x6b>
      if(c == '%'){
    1470:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1474:	75 0c                	jne    1482 <printf+0x51>
        state = '%';
    1476:	c7 45 f0 25 00 00 00 	movl   $0x25,-0x10(%ebp)
    147d:	e9 4b 01 00 00       	jmp    15cd <printf+0x19c>
      } else {
        putc(fd, c);
    1482:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1485:	0f be c0             	movsbl %al,%eax
    1488:	89 44 24 04          	mov    %eax,0x4(%esp)
    148c:	8b 45 08             	mov    0x8(%ebp),%eax
    148f:	89 04 24             	mov    %eax,(%esp)
    1492:	e8 c1 fe ff ff       	call   1358 <putc>
    1497:	e9 31 01 00 00       	jmp    15cd <printf+0x19c>
      }
    } else if(state == '%'){
    149c:	83 7d f0 25          	cmpl   $0x25,-0x10(%ebp)
    14a0:	0f 85 27 01 00 00    	jne    15cd <printf+0x19c>
      if(c == 'd'){
    14a6:	83 7d e8 64          	cmpl   $0x64,-0x18(%ebp)
    14aa:	75 2d                	jne    14d9 <printf+0xa8>
        printint(fd, *ap, 10, 1);
    14ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14af:	8b 00                	mov    (%eax),%eax
    14b1:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
    14b8:	00 
    14b9:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    14c0:	00 
    14c1:	89 44 24 04          	mov    %eax,0x4(%esp)
    14c5:	8b 45 08             	mov    0x8(%ebp),%eax
    14c8:	89 04 24             	mov    %eax,(%esp)
    14cb:	e8 b0 fe ff ff       	call   1380 <printint>
        ap++;
    14d0:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    14d4:	e9 ed 00 00 00       	jmp    15c6 <printf+0x195>
      } else if(c == 'x' || c == 'p'){
    14d9:	83 7d e8 78          	cmpl   $0x78,-0x18(%ebp)
    14dd:	74 06                	je     14e5 <printf+0xb4>
    14df:	83 7d e8 70          	cmpl   $0x70,-0x18(%ebp)
    14e3:	75 2d                	jne    1512 <printf+0xe1>
        printint(fd, *ap, 16, 0);
    14e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14e8:	8b 00                	mov    (%eax),%eax
    14ea:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
    14f1:	00 
    14f2:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    14f9:	00 
    14fa:	89 44 24 04          	mov    %eax,0x4(%esp)
    14fe:	8b 45 08             	mov    0x8(%ebp),%eax
    1501:	89 04 24             	mov    %eax,(%esp)
    1504:	e8 77 fe ff ff       	call   1380 <printint>
        ap++;
    1509:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    150d:	e9 b4 00 00 00       	jmp    15c6 <printf+0x195>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1512:	83 7d e8 73          	cmpl   $0x73,-0x18(%ebp)
    1516:	75 46                	jne    155e <printf+0x12d>
        s = (char*)*ap;
    1518:	8b 45 f4             	mov    -0xc(%ebp),%eax
    151b:	8b 00                	mov    (%eax),%eax
    151d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        ap++;
    1520:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
        if(s == 0)
    1524:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    1528:	75 27                	jne    1551 <printf+0x120>
          s = "(null)";
    152a:	c7 45 e4 47 1b 00 00 	movl   $0x1b47,-0x1c(%ebp)
        while(*s != 0){
    1531:	eb 1f                	jmp    1552 <printf+0x121>
          putc(fd, *s);
    1533:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1536:	0f b6 00             	movzbl (%eax),%eax
    1539:	0f be c0             	movsbl %al,%eax
    153c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1540:	8b 45 08             	mov    0x8(%ebp),%eax
    1543:	89 04 24             	mov    %eax,(%esp)
    1546:	e8 0d fe ff ff       	call   1358 <putc>
          s++;
    154b:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
    154f:	eb 01                	jmp    1552 <printf+0x121>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    1551:	90                   	nop
    1552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1555:	0f b6 00             	movzbl (%eax),%eax
    1558:	84 c0                	test   %al,%al
    155a:	75 d7                	jne    1533 <printf+0x102>
    155c:	eb 68                	jmp    15c6 <printf+0x195>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    155e:	83 7d e8 63          	cmpl   $0x63,-0x18(%ebp)
    1562:	75 1d                	jne    1581 <printf+0x150>
        putc(fd, *ap);
    1564:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1567:	8b 00                	mov    (%eax),%eax
    1569:	0f be c0             	movsbl %al,%eax
    156c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1570:	8b 45 08             	mov    0x8(%ebp),%eax
    1573:	89 04 24             	mov    %eax,(%esp)
    1576:	e8 dd fd ff ff       	call   1358 <putc>
        ap++;
    157b:	83 45 f4 04          	addl   $0x4,-0xc(%ebp)
    157f:	eb 45                	jmp    15c6 <printf+0x195>
      } else if(c == '%'){
    1581:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
    1585:	75 17                	jne    159e <printf+0x16d>
        putc(fd, c);
    1587:	8b 45 e8             	mov    -0x18(%ebp),%eax
    158a:	0f be c0             	movsbl %al,%eax
    158d:	89 44 24 04          	mov    %eax,0x4(%esp)
    1591:	8b 45 08             	mov    0x8(%ebp),%eax
    1594:	89 04 24             	mov    %eax,(%esp)
    1597:	e8 bc fd ff ff       	call   1358 <putc>
    159c:	eb 28                	jmp    15c6 <printf+0x195>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    159e:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
    15a5:	00 
    15a6:	8b 45 08             	mov    0x8(%ebp),%eax
    15a9:	89 04 24             	mov    %eax,(%esp)
    15ac:	e8 a7 fd ff ff       	call   1358 <putc>
        putc(fd, c);
    15b1:	8b 45 e8             	mov    -0x18(%ebp),%eax
    15b4:	0f be c0             	movsbl %al,%eax
    15b7:	89 44 24 04          	mov    %eax,0x4(%esp)
    15bb:	8b 45 08             	mov    0x8(%ebp),%eax
    15be:	89 04 24             	mov    %eax,(%esp)
    15c1:	e8 92 fd ff ff       	call   1358 <putc>
      }
      state = 0;
    15c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    15cd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    15d1:	8b 55 0c             	mov    0xc(%ebp),%edx
    15d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    15d7:	8d 04 02             	lea    (%edx,%eax,1),%eax
    15da:	0f b6 00             	movzbl (%eax),%eax
    15dd:	84 c0                	test   %al,%al
    15df:	0f 85 6e fe ff ff    	jne    1453 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    15e5:	c9                   	leave  
    15e6:	c3                   	ret    
    15e7:	90                   	nop

000015e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    15e8:	55                   	push   %ebp
    15e9:	89 e5                	mov    %esp,%ebp
    15eb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    15ee:	8b 45 08             	mov    0x8(%ebp),%eax
    15f1:	83 e8 08             	sub    $0x8,%eax
    15f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    15f7:	a1 9c 1b 00 00       	mov    0x1b9c,%eax
    15fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
    15ff:	eb 24                	jmp    1625 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1601:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1604:	8b 00                	mov    (%eax),%eax
    1606:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1609:	77 12                	ja     161d <free+0x35>
    160b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    160e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    1611:	77 24                	ja     1637 <free+0x4f>
    1613:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1616:	8b 00                	mov    (%eax),%eax
    1618:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    161b:	77 1a                	ja     1637 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    161d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1620:	8b 00                	mov    (%eax),%eax
    1622:	89 45 fc             	mov    %eax,-0x4(%ebp)
    1625:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1628:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    162b:	76 d4                	jbe    1601 <free+0x19>
    162d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1630:	8b 00                	mov    (%eax),%eax
    1632:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    1635:	76 ca                	jbe    1601 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    1637:	8b 45 f8             	mov    -0x8(%ebp),%eax
    163a:	8b 40 04             	mov    0x4(%eax),%eax
    163d:	c1 e0 03             	shl    $0x3,%eax
    1640:	89 c2                	mov    %eax,%edx
    1642:	03 55 f8             	add    -0x8(%ebp),%edx
    1645:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1648:	8b 00                	mov    (%eax),%eax
    164a:	39 c2                	cmp    %eax,%edx
    164c:	75 24                	jne    1672 <free+0x8a>
    bp->s.size += p->s.ptr->s.size;
    164e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1651:	8b 50 04             	mov    0x4(%eax),%edx
    1654:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1657:	8b 00                	mov    (%eax),%eax
    1659:	8b 40 04             	mov    0x4(%eax),%eax
    165c:	01 c2                	add    %eax,%edx
    165e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1661:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    1664:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1667:	8b 00                	mov    (%eax),%eax
    1669:	8b 10                	mov    (%eax),%edx
    166b:	8b 45 f8             	mov    -0x8(%ebp),%eax
    166e:	89 10                	mov    %edx,(%eax)
    1670:	eb 0a                	jmp    167c <free+0x94>
  } else
    bp->s.ptr = p->s.ptr;
    1672:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1675:	8b 10                	mov    (%eax),%edx
    1677:	8b 45 f8             	mov    -0x8(%ebp),%eax
    167a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    167c:	8b 45 fc             	mov    -0x4(%ebp),%eax
    167f:	8b 40 04             	mov    0x4(%eax),%eax
    1682:	c1 e0 03             	shl    $0x3,%eax
    1685:	03 45 fc             	add    -0x4(%ebp),%eax
    1688:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    168b:	75 20                	jne    16ad <free+0xc5>
    p->s.size += bp->s.size;
    168d:	8b 45 fc             	mov    -0x4(%ebp),%eax
    1690:	8b 50 04             	mov    0x4(%eax),%edx
    1693:	8b 45 f8             	mov    -0x8(%ebp),%eax
    1696:	8b 40 04             	mov    0x4(%eax),%eax
    1699:	01 c2                	add    %eax,%edx
    169b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    169e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
    16a4:	8b 10                	mov    (%eax),%edx
    16a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16a9:	89 10                	mov    %edx,(%eax)
    16ab:	eb 08                	jmp    16b5 <free+0xcd>
  } else
    p->s.ptr = bp;
    16ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b0:	8b 55 f8             	mov    -0x8(%ebp),%edx
    16b3:	89 10                	mov    %edx,(%eax)
  freep = p;
    16b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
    16b8:	a3 9c 1b 00 00       	mov    %eax,0x1b9c
}
    16bd:	c9                   	leave  
    16be:	c3                   	ret    

000016bf <morecore>:

static Header*
morecore(uint nu)
{
    16bf:	55                   	push   %ebp
    16c0:	89 e5                	mov    %esp,%ebp
    16c2:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    16c5:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    16cc:	77 07                	ja     16d5 <morecore+0x16>
    nu = 4096;
    16ce:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    16d5:	8b 45 08             	mov    0x8(%ebp),%eax
    16d8:	c1 e0 03             	shl    $0x3,%eax
    16db:	89 04 24             	mov    %eax,(%esp)
    16de:	e8 35 fc ff ff       	call   1318 <sbrk>
    16e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(p == (char*)-1)
    16e6:	83 7d f0 ff          	cmpl   $0xffffffff,-0x10(%ebp)
    16ea:	75 07                	jne    16f3 <morecore+0x34>
    return 0;
    16ec:	b8 00 00 00 00       	mov    $0x0,%eax
    16f1:	eb 22                	jmp    1715 <morecore+0x56>
  hp = (Header*)p;
    16f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    16f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  hp->s.size = nu;
    16f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
    16fc:	8b 55 08             	mov    0x8(%ebp),%edx
    16ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    1702:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1705:	83 c0 08             	add    $0x8,%eax
    1708:	89 04 24             	mov    %eax,(%esp)
    170b:	e8 d8 fe ff ff       	call   15e8 <free>
  return freep;
    1710:	a1 9c 1b 00 00       	mov    0x1b9c,%eax
}
    1715:	c9                   	leave  
    1716:	c3                   	ret    

00001717 <malloc>:

void*
malloc(uint nbytes)
{
    1717:	55                   	push   %ebp
    1718:	89 e5                	mov    %esp,%ebp
    171a:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    171d:	8b 45 08             	mov    0x8(%ebp),%eax
    1720:	83 c0 07             	add    $0x7,%eax
    1723:	c1 e8 03             	shr    $0x3,%eax
    1726:	83 c0 01             	add    $0x1,%eax
    1729:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((prevp = freep) == 0){
    172c:	a1 9c 1b 00 00       	mov    0x1b9c,%eax
    1731:	89 45 f0             	mov    %eax,-0x10(%ebp)
    1734:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1738:	75 23                	jne    175d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    173a:	c7 45 f0 94 1b 00 00 	movl   $0x1b94,-0x10(%ebp)
    1741:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1744:	a3 9c 1b 00 00       	mov    %eax,0x1b9c
    1749:	a1 9c 1b 00 00       	mov    0x1b9c,%eax
    174e:	a3 94 1b 00 00       	mov    %eax,0x1b94
    base.s.size = 0;
    1753:	c7 05 98 1b 00 00 00 	movl   $0x0,0x1b98
    175a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    175d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1760:	8b 00                	mov    (%eax),%eax
    1762:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(p->s.size >= nunits){
    1765:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1768:	8b 40 04             	mov    0x4(%eax),%eax
    176b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    176e:	72 4d                	jb     17bd <malloc+0xa6>
      if(p->s.size == nunits)
    1770:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1773:	8b 40 04             	mov    0x4(%eax),%eax
    1776:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    1779:	75 0c                	jne    1787 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    177b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    177e:	8b 10                	mov    (%eax),%edx
    1780:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1783:	89 10                	mov    %edx,(%eax)
    1785:	eb 26                	jmp    17ad <malloc+0x96>
      else {
        p->s.size -= nunits;
    1787:	8b 45 ec             	mov    -0x14(%ebp),%eax
    178a:	8b 40 04             	mov    0x4(%eax),%eax
    178d:	89 c2                	mov    %eax,%edx
    178f:	2b 55 f4             	sub    -0xc(%ebp),%edx
    1792:	8b 45 ec             	mov    -0x14(%ebp),%eax
    1795:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    1798:	8b 45 ec             	mov    -0x14(%ebp),%eax
    179b:	8b 40 04             	mov    0x4(%eax),%eax
    179e:	c1 e0 03             	shl    $0x3,%eax
    17a1:	01 45 ec             	add    %eax,-0x14(%ebp)
        p->s.size = nunits;
    17a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
    17aa:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    17ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
    17b0:	a3 9c 1b 00 00       	mov    %eax,0x1b9c
      return (void*)(p + 1);
    17b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17b8:	83 c0 08             	add    $0x8,%eax
    17bb:	eb 38                	jmp    17f5 <malloc+0xde>
    }
    if(p == freep)
    17bd:	a1 9c 1b 00 00       	mov    0x1b9c,%eax
    17c2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    17c5:	75 1b                	jne    17e2 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
    17c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17ca:	89 04 24             	mov    %eax,(%esp)
    17cd:	e8 ed fe ff ff       	call   16bf <morecore>
    17d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    17d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    17d9:	75 07                	jne    17e2 <malloc+0xcb>
        return 0;
    17db:	b8 00 00 00 00       	mov    $0x0,%eax
    17e0:	eb 13                	jmp    17f5 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    17e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
    17eb:	8b 00                	mov    (%eax),%eax
    17ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    17f0:	e9 70 ff ff ff       	jmp    1765 <malloc+0x4e>
}
    17f5:	c9                   	leave  
    17f6:	c3                   	ret    
    17f7:	90                   	nop

000017f8 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
    17f8:	55                   	push   %ebp
    17f9:	89 e5                	mov    %esp,%ebp
    17fb:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
    17fe:	8b 55 08             	mov    0x8(%ebp),%edx
    1801:	8b 45 0c             	mov    0xc(%ebp),%eax
    1804:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1807:	f0 87 02             	lock xchg %eax,(%edx)
    180a:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
    180d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    1810:	c9                   	leave  
    1811:	c3                   	ret    

00001812 <lock_init>:
#include "x86.h"
#include "proc.h"

unsigned long rands = 1;

void lock_init(lock_t *lock){
    1812:	55                   	push   %ebp
    1813:	89 e5                	mov    %esp,%ebp
    lock->locked = 0;
    1815:	8b 45 08             	mov    0x8(%ebp),%eax
    1818:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
}
    181e:	5d                   	pop    %ebp
    181f:	c3                   	ret    

00001820 <lock_acquire>:
void lock_acquire(lock_t *lock){
    1820:	55                   	push   %ebp
    1821:	89 e5                	mov    %esp,%ebp
    1823:	83 ec 08             	sub    $0x8,%esp
    while(xchg(&lock->locked,1) != 0);
    1826:	8b 45 08             	mov    0x8(%ebp),%eax
    1829:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    1830:	00 
    1831:	89 04 24             	mov    %eax,(%esp)
    1834:	e8 bf ff ff ff       	call   17f8 <xchg>
    1839:	85 c0                	test   %eax,%eax
    183b:	75 e9                	jne    1826 <lock_acquire+0x6>
}
    183d:	c9                   	leave  
    183e:	c3                   	ret    

0000183f <lock_release>:
void lock_release(lock_t *lock){
    183f:	55                   	push   %ebp
    1840:	89 e5                	mov    %esp,%ebp
    1842:	83 ec 08             	sub    $0x8,%esp
    xchg(&lock->locked,0);
    1845:	8b 45 08             	mov    0x8(%ebp),%eax
    1848:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    184f:	00 
    1850:	89 04 24             	mov    %eax,(%esp)
    1853:	e8 a0 ff ff ff       	call   17f8 <xchg>
}
    1858:	c9                   	leave  
    1859:	c3                   	ret    

0000185a <thread_create>:


void *thread_create(void(*start_routine)(void*), void *arg){
    185a:	55                   	push   %ebp
    185b:	89 e5                	mov    %esp,%ebp
    185d:	83 ec 28             	sub    $0x28,%esp
    int tid;
    void * stack = malloc(2 * 4096);
    1860:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    1867:	e8 ab fe ff ff       	call   1717 <malloc>
    186c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    void *garbage_stack = stack; 
    186f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1872:	89 45 f4             	mov    %eax,-0xc(%ebp)
   // printf(1,"start routine addr : %d\n",(uint)start_routine);


    if((uint)stack % 4096){
    1875:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1878:	25 ff 0f 00 00       	and    $0xfff,%eax
    187d:	85 c0                	test   %eax,%eax
    187f:	74 15                	je     1896 <thread_create+0x3c>
        stack = stack + (4096 - (uint)stack % 4096);
    1881:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1884:	89 c2                	mov    %eax,%edx
    1886:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
    188c:	b8 00 10 00 00       	mov    $0x1000,%eax
    1891:	29 d0                	sub    %edx,%eax
    1893:	01 45 f0             	add    %eax,-0x10(%ebp)
    }
    if (stack == 0){
    1896:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    189a:	75 1b                	jne    18b7 <thread_create+0x5d>

        printf(1,"malloc fail \n");
    189c:	c7 44 24 04 4e 1b 00 	movl   $0x1b4e,0x4(%esp)
    18a3:	00 
    18a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18ab:	e8 81 fb ff ff       	call   1431 <printf>
        return 0;
    18b0:	b8 00 00 00 00       	mov    $0x0,%eax
    18b5:	eb 6f                	jmp    1926 <thread_create+0xcc>
    }

    tid = clone((uint)stack,PSIZE,(uint)start_routine,(int)arg);
    18b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    18ba:	8b 55 08             	mov    0x8(%ebp),%edx
    18bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    18c0:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
    18c4:	89 54 24 08          	mov    %edx,0x8(%esp)
    18c8:	c7 44 24 04 00 10 00 	movl   $0x1000,0x4(%esp)
    18cf:	00 
    18d0:	89 04 24             	mov    %eax,(%esp)
    18d3:	e8 58 fa ff ff       	call   1330 <clone>
    18d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(tid < 0){
    18db:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18df:	79 1b                	jns    18fc <thread_create+0xa2>
        printf(1,"clone fails\n");
    18e1:	c7 44 24 04 5c 1b 00 	movl   $0x1b5c,0x4(%esp)
    18e8:	00 
    18e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    18f0:	e8 3c fb ff ff       	call   1431 <printf>
        return 0;
    18f5:	b8 00 00 00 00       	mov    $0x0,%eax
    18fa:	eb 2a                	jmp    1926 <thread_create+0xcc>
    }
    if(tid > 0){
    18fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1900:	7e 05                	jle    1907 <thread_create+0xad>
        //store threads on thread table
        return garbage_stack;
    1902:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1905:	eb 1f                	jmp    1926 <thread_create+0xcc>
    }
    if(tid == 0){
    1907:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    190b:	75 14                	jne    1921 <thread_create+0xc7>
        printf(1,"tid = 0 return \n");
    190d:	c7 44 24 04 69 1b 00 	movl   $0x1b69,0x4(%esp)
    1914:	00 
    1915:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    191c:	e8 10 fb ff ff       	call   1431 <printf>
    }
//    wait();
//    free(garbage_stack);

    return 0;
    1921:	b8 00 00 00 00       	mov    $0x0,%eax
}
    1926:	c9                   	leave  
    1927:	c3                   	ret    

00001928 <random>:

// generate 0 -> max random number exclude max.
int random(int max){
    1928:	55                   	push   %ebp
    1929:	89 e5                	mov    %esp,%ebp
    rands = rands * 1664525 + 1013904233;
    192b:	a1 90 1b 00 00       	mov    0x1b90,%eax
    1930:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    1936:	05 69 f3 6e 3c       	add    $0x3c6ef369,%eax
    193b:	a3 90 1b 00 00       	mov    %eax,0x1b90
    return (int)(rands % max);
    1940:	a1 90 1b 00 00       	mov    0x1b90,%eax
    1945:	8b 4d 08             	mov    0x8(%ebp),%ecx
    1948:	ba 00 00 00 00       	mov    $0x0,%edx
    194d:	f7 f1                	div    %ecx
    194f:	89 d0                	mov    %edx,%eax
}
    1951:	5d                   	pop    %ebp
    1952:	c3                   	ret    
    1953:	90                   	nop

00001954 <init_q>:
#include "queue.h"
#include "types.h"
#include "user.h"

void init_q(struct queue *q){
    1954:	55                   	push   %ebp
    1955:	89 e5                	mov    %esp,%ebp
    q->size = 0;
    1957:	8b 45 08             	mov    0x8(%ebp),%eax
    195a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    q->head = 0;
    1960:	8b 45 08             	mov    0x8(%ebp),%eax
    1963:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    q->tail = 0;
    196a:	8b 45 08             	mov    0x8(%ebp),%eax
    196d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
    1974:	5d                   	pop    %ebp
    1975:	c3                   	ret    

00001976 <add_q>:

void add_q(struct queue *q, int v){
    1976:	55                   	push   %ebp
    1977:	89 e5                	mov    %esp,%ebp
    1979:	83 ec 28             	sub    $0x28,%esp
    struct node * n = malloc(sizeof(struct node));
    197c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    1983:	e8 8f fd ff ff       	call   1717 <malloc>
    1988:	89 45 f4             	mov    %eax,-0xc(%ebp)
    n->next = 0;
    198b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    198e:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    n->value = v;
    1995:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1998:	8b 55 0c             	mov    0xc(%ebp),%edx
    199b:	89 10                	mov    %edx,(%eax)
    if(q->head == 0){
    199d:	8b 45 08             	mov    0x8(%ebp),%eax
    19a0:	8b 40 04             	mov    0x4(%eax),%eax
    19a3:	85 c0                	test   %eax,%eax
    19a5:	75 0b                	jne    19b2 <add_q+0x3c>
        q->head = n;
    19a7:	8b 45 08             	mov    0x8(%ebp),%eax
    19aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19ad:	89 50 04             	mov    %edx,0x4(%eax)
    19b0:	eb 0c                	jmp    19be <add_q+0x48>
    }else{
        q->tail->next = n;
    19b2:	8b 45 08             	mov    0x8(%ebp),%eax
    19b5:	8b 40 08             	mov    0x8(%eax),%eax
    19b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19bb:	89 50 04             	mov    %edx,0x4(%eax)
    }
    q->tail = n;
    19be:	8b 45 08             	mov    0x8(%ebp),%eax
    19c1:	8b 55 f4             	mov    -0xc(%ebp),%edx
    19c4:	89 50 08             	mov    %edx,0x8(%eax)
    q->size++;
    19c7:	8b 45 08             	mov    0x8(%ebp),%eax
    19ca:	8b 00                	mov    (%eax),%eax
    19cc:	8d 50 01             	lea    0x1(%eax),%edx
    19cf:	8b 45 08             	mov    0x8(%ebp),%eax
    19d2:	89 10                	mov    %edx,(%eax)
}
    19d4:	c9                   	leave  
    19d5:	c3                   	ret    

000019d6 <empty_q>:

int empty_q(struct queue *q){
    19d6:	55                   	push   %ebp
    19d7:	89 e5                	mov    %esp,%ebp
    if(q->size == 0)
    19d9:	8b 45 08             	mov    0x8(%ebp),%eax
    19dc:	8b 00                	mov    (%eax),%eax
    19de:	85 c0                	test   %eax,%eax
    19e0:	75 07                	jne    19e9 <empty_q+0x13>
        return 1;
    19e2:	b8 01 00 00 00       	mov    $0x1,%eax
    19e7:	eb 05                	jmp    19ee <empty_q+0x18>
    else
        return 0;
    19e9:	b8 00 00 00 00       	mov    $0x0,%eax
} 
    19ee:	5d                   	pop    %ebp
    19ef:	c3                   	ret    

000019f0 <pop_q>:
int pop_q(struct queue *q){
    19f0:	55                   	push   %ebp
    19f1:	89 e5                	mov    %esp,%ebp
    19f3:	83 ec 28             	sub    $0x28,%esp
    int val;
    struct node *destroy;
    if(!empty_q(q)){
    19f6:	8b 45 08             	mov    0x8(%ebp),%eax
    19f9:	89 04 24             	mov    %eax,(%esp)
    19fc:	e8 d5 ff ff ff       	call   19d6 <empty_q>
    1a01:	85 c0                	test   %eax,%eax
    1a03:	75 5d                	jne    1a62 <pop_q+0x72>
       val = q->head->value; 
    1a05:	8b 45 08             	mov    0x8(%ebp),%eax
    1a08:	8b 40 04             	mov    0x4(%eax),%eax
    1a0b:	8b 00                	mov    (%eax),%eax
    1a0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
       destroy = q->head;
    1a10:	8b 45 08             	mov    0x8(%ebp),%eax
    1a13:	8b 40 04             	mov    0x4(%eax),%eax
    1a16:	89 45 f4             	mov    %eax,-0xc(%ebp)
       q->head = q->head->next;
    1a19:	8b 45 08             	mov    0x8(%ebp),%eax
    1a1c:	8b 40 04             	mov    0x4(%eax),%eax
    1a1f:	8b 50 04             	mov    0x4(%eax),%edx
    1a22:	8b 45 08             	mov    0x8(%ebp),%eax
    1a25:	89 50 04             	mov    %edx,0x4(%eax)
       free(destroy);
    1a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1a2b:	89 04 24             	mov    %eax,(%esp)
    1a2e:	e8 b5 fb ff ff       	call   15e8 <free>
       q->size--;
    1a33:	8b 45 08             	mov    0x8(%ebp),%eax
    1a36:	8b 00                	mov    (%eax),%eax
    1a38:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a3b:	8b 45 08             	mov    0x8(%ebp),%eax
    1a3e:	89 10                	mov    %edx,(%eax)
       if(q->size == 0){
    1a40:	8b 45 08             	mov    0x8(%ebp),%eax
    1a43:	8b 00                	mov    (%eax),%eax
    1a45:	85 c0                	test   %eax,%eax
    1a47:	75 14                	jne    1a5d <pop_q+0x6d>
            q->head = 0;
    1a49:	8b 45 08             	mov    0x8(%ebp),%eax
    1a4c:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
            q->tail = 0;
    1a53:	8b 45 08             	mov    0x8(%ebp),%eax
    1a56:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
       }
       return val;
    1a5d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a60:	eb 05                	jmp    1a67 <pop_q+0x77>
    }
    return -1;
    1a62:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
    1a67:	c9                   	leave  
    1a68:	c3                   	ret    
    1a69:	90                   	nop
    1a6a:	90                   	nop
    1a6b:	90                   	nop

00001a6c <sem_acquire>:
#include "semaphore.h"

void sem_acquire(struct Semaphore *s) 
{
    1a6c:	55                   	push   %ebp
    1a6d:	89 e5                	mov    %esp,%ebp
    1a6f:	83 ec 18             	sub    $0x18,%esp
	lock_acquire(&s->lock);
    1a72:	8b 45 08             	mov    0x8(%ebp),%eax
    1a75:	89 04 24             	mov    %eax,(%esp)
    1a78:	e8 a3 fd ff ff       	call   1820 <lock_acquire>
	s->count--; 
    1a7d:	8b 45 08             	mov    0x8(%ebp),%eax
    1a80:	8b 40 04             	mov    0x4(%eax),%eax
    1a83:	8d 50 ff             	lea    -0x1(%eax),%edx
    1a86:	8b 45 08             	mov    0x8(%ebp),%eax
    1a89:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count < 0) 
    1a8c:	8b 45 08             	mov    0x8(%ebp),%eax
    1a8f:	8b 40 04             	mov    0x4(%eax),%eax
    1a92:	85 c0                	test   %eax,%eax
    1a94:	79 27                	jns    1abd <sem_acquire+0x51>
	{
		add_q(&s->q, getpid()); 
    1a96:	e8 75 f8 ff ff       	call   1310 <getpid>
    1a9b:	8b 55 08             	mov    0x8(%ebp),%edx
    1a9e:	83 c2 08             	add    $0x8,%edx
    1aa1:	89 44 24 04          	mov    %eax,0x4(%esp)
    1aa5:	89 14 24             	mov    %edx,(%esp)
    1aa8:	e8 c9 fe ff ff       	call   1976 <add_q>
		lock_release(&s->lock); 
    1aad:	8b 45 08             	mov    0x8(%ebp),%eax
    1ab0:	89 04 24             	mov    %eax,(%esp)
    1ab3:	e8 87 fd ff ff       	call   183f <lock_release>
		tsleep(); 
    1ab8:	e8 83 f8 ff ff       	call   1340 <tsleep>
	} 
	lock_release(&s->lock); 
    1abd:	8b 45 08             	mov    0x8(%ebp),%eax
    1ac0:	89 04 24             	mov    %eax,(%esp)
    1ac3:	e8 77 fd ff ff       	call   183f <lock_release>
}
    1ac8:	c9                   	leave  
    1ac9:	c3                   	ret    

00001aca <sem_signal>:

void sem_signal(struct Semaphore *s)
{ 
    1aca:	55                   	push   %ebp
    1acb:	89 e5                	mov    %esp,%ebp
    1acd:	83 ec 28             	sub    $0x28,%esp
	lock_acquire(&s->lock);
    1ad0:	8b 45 08             	mov    0x8(%ebp),%eax
    1ad3:	89 04 24             	mov    %eax,(%esp)
    1ad6:	e8 45 fd ff ff       	call   1820 <lock_acquire>
	s->count++; 
    1adb:	8b 45 08             	mov    0x8(%ebp),%eax
    1ade:	8b 40 04             	mov    0x4(%eax),%eax
    1ae1:	8d 50 01             	lea    0x1(%eax),%edx
    1ae4:	8b 45 08             	mov    0x8(%ebp),%eax
    1ae7:	89 50 04             	mov    %edx,0x4(%eax)
	if( s->count <= 0) 
    1aea:	8b 45 08             	mov    0x8(%ebp),%eax
    1aed:	8b 40 04             	mov    0x4(%eax),%eax
    1af0:	85 c0                	test   %eax,%eax
    1af2:	7f 1c                	jg     1b10 <sem_signal+0x46>
	{
		int tid = pop_q(&s->q); 
    1af4:	8b 45 08             	mov    0x8(%ebp),%eax
    1af7:	83 c0 08             	add    $0x8,%eax
    1afa:	89 04 24             	mov    %eax,(%esp)
    1afd:	e8 ee fe ff ff       	call   19f0 <pop_q>
    1b02:	89 45 f4             	mov    %eax,-0xc(%ebp)
		twakeup(tid); 
    1b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b08:	89 04 24             	mov    %eax,(%esp)
    1b0b:	e8 38 f8 ff ff       	call   1348 <twakeup>
	}
	lock_release(&s->lock); 
    1b10:	8b 45 08             	mov    0x8(%ebp),%eax
    1b13:	89 04 24             	mov    %eax,(%esp)
    1b16:	e8 24 fd ff ff       	call   183f <lock_release>
} 
    1b1b:	c9                   	leave  
    1b1c:	c3                   	ret    

00001b1d <sem_init>:

void sem_init(struct Semaphore *s, int size){
    1b1d:	55                   	push   %ebp
    1b1e:	89 e5                	mov    %esp,%ebp
    1b20:	83 ec 18             	sub    $0x18,%esp
	lock_init(&s->lock);
    1b23:	8b 45 08             	mov    0x8(%ebp),%eax
    1b26:	89 04 24             	mov    %eax,(%esp)
    1b29:	e8 e4 fc ff ff       	call   1812 <lock_init>
	s->count = size; 
    1b2e:	8b 45 08             	mov    0x8(%ebp),%eax
    1b31:	8b 55 0c             	mov    0xc(%ebp),%edx
    1b34:	89 50 04             	mov    %edx,0x4(%eax)
	init_q(&s->q);
    1b37:	8b 45 08             	mov    0x8(%ebp),%eax
    1b3a:	83 c0 08             	add    $0x8,%eax
    1b3d:	89 04 24             	mov    %eax,(%esp)
    1b40:	e8 0f fe ff ff       	call   1954 <init_q>
}
    1b45:	c9                   	leave  
    1b46:	c3                   	ret    
