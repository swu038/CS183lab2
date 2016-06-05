
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 f0 33 10 80       	mov    $0x801033f0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	c7 44 24 04 fc 85 10 	movl   $0x801085fc,0x4(%esp)
80100041:	80 
80100042:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
80100049:	e8 e0 4e 00 00       	call   80104f2e <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004e:	c7 05 b0 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb0
80100055:	db 10 80 
  bcache.head.next = &bcache.head;
80100058:	c7 05 b4 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb4
8010005f:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100062:	c7 45 f4 b4 c6 10 80 	movl   $0x8010c6b4,-0xc(%ebp)
80100069:	eb 3a                	jmp    801000a5 <binit+0x71>
    b->next = bcache.head.next;
8010006b:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100074:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100077:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007a:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
    b->dev = -1;
80100081:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100084:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008b:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100090:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100093:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100096:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100099:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009e:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a5:	b8 a4 db 10 80       	mov    $0x8010dba4,%eax
801000aa:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ad:	72 bc                	jb     8010006b <binit+0x37>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000af:	c9                   	leave  
801000b0:	c3                   	ret    

801000b1 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b1:	55                   	push   %ebp
801000b2:	89 e5                	mov    %esp,%ebp
801000b4:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b7:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
801000be:	e8 8c 4e 00 00       	call   80104f4f <acquire>

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c3:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
801000c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000cb:	eb 63                	jmp    80100130 <bget+0x7f>
    if(b->dev == dev && b->sector == sector){
801000cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d0:	8b 40 04             	mov    0x4(%eax),%eax
801000d3:	3b 45 08             	cmp    0x8(%ebp),%eax
801000d6:	75 4f                	jne    80100127 <bget+0x76>
801000d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000db:	8b 40 08             	mov    0x8(%eax),%eax
801000de:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e1:	75 44                	jne    80100127 <bget+0x76>
      if(!(b->flags & B_BUSY)){
801000e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e6:	8b 00                	mov    (%eax),%eax
801000e8:	83 e0 01             	and    $0x1,%eax
801000eb:	85 c0                	test   %eax,%eax
801000ed:	75 23                	jne    80100112 <bget+0x61>
        b->flags |= B_BUSY;
801000ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f2:	8b 00                	mov    (%eax),%eax
801000f4:	89 c2                	mov    %eax,%edx
801000f6:	83 ca 01             	or     $0x1,%edx
801000f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fc:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
801000fe:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
80100105:	e8 a6 4e 00 00       	call   80104fb0 <release>
        return b;
8010010a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010010d:	e9 93 00 00 00       	jmp    801001a5 <bget+0xf4>
      }
      sleep(b, &bcache.lock);
80100112:	c7 44 24 04 80 c6 10 	movl   $0x8010c680,0x4(%esp)
80100119:	80 
8010011a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010011d:	89 04 24             	mov    %eax,(%esp)
80100120:	e8 b1 4a 00 00       	call   80104bd6 <sleep>
      goto loop;
80100125:	eb 9c                	jmp    801000c3 <bget+0x12>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100127:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012a:	8b 40 10             	mov    0x10(%eax),%eax
8010012d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100130:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
80100137:	75 94                	jne    801000cd <bget+0x1c>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100139:	a1 b0 db 10 80       	mov    0x8010dbb0,%eax
8010013e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100141:	eb 4d                	jmp    80100190 <bget+0xdf>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
80100143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100146:	8b 00                	mov    (%eax),%eax
80100148:	83 e0 01             	and    $0x1,%eax
8010014b:	85 c0                	test   %eax,%eax
8010014d:	75 38                	jne    80100187 <bget+0xd6>
8010014f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100152:	8b 00                	mov    (%eax),%eax
80100154:	83 e0 04             	and    $0x4,%eax
80100157:	85 c0                	test   %eax,%eax
80100159:	75 2c                	jne    80100187 <bget+0xd6>
      b->dev = dev;
8010015b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015e:	8b 55 08             	mov    0x8(%ebp),%edx
80100161:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
80100164:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100167:	8b 55 0c             	mov    0xc(%ebp),%edx
8010016a:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
8010016d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100170:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100176:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010017d:	e8 2e 4e 00 00       	call   80104fb0 <release>
      return b;
80100182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100185:	eb 1e                	jmp    801001a5 <bget+0xf4>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100187:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010018a:	8b 40 0c             	mov    0xc(%eax),%eax
8010018d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100190:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
80100197:	75 aa                	jne    80100143 <bget+0x92>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100199:	c7 04 24 03 86 10 80 	movl   $0x80108603,(%esp)
801001a0:	e8 95 03 00 00       	call   8010053a <panic>
}
801001a5:	c9                   	leave  
801001a6:	c3                   	ret    

801001a7 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001a7:	55                   	push   %ebp
801001a8:	89 e5                	mov    %esp,%ebp
801001aa:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  b = bget(dev, sector);
801001ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801001b0:	89 44 24 04          	mov    %eax,0x4(%esp)
801001b4:	8b 45 08             	mov    0x8(%ebp),%eax
801001b7:	89 04 24             	mov    %eax,(%esp)
801001ba:	e8 f2 fe ff ff       	call   801000b1 <bget>
801001bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001c5:	8b 00                	mov    (%eax),%eax
801001c7:	83 e0 02             	and    $0x2,%eax
801001ca:	85 c0                	test   %eax,%eax
801001cc:	75 0b                	jne    801001d9 <bread+0x32>
    iderw(b);
801001ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d1:	89 04 24             	mov    %eax,(%esp)
801001d4:	e8 e5 25 00 00       	call   801027be <iderw>
  return b;
801001d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001dc:	c9                   	leave  
801001dd:	c3                   	ret    

801001de <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001de:	55                   	push   %ebp
801001df:	89 e5                	mov    %esp,%ebp
801001e1:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
801001e4:	8b 45 08             	mov    0x8(%ebp),%eax
801001e7:	8b 00                	mov    (%eax),%eax
801001e9:	83 e0 01             	and    $0x1,%eax
801001ec:	85 c0                	test   %eax,%eax
801001ee:	75 0c                	jne    801001fc <bwrite+0x1e>
    panic("bwrite");
801001f0:	c7 04 24 14 86 10 80 	movl   $0x80108614,(%esp)
801001f7:	e8 3e 03 00 00       	call   8010053a <panic>
  b->flags |= B_DIRTY;
801001fc:	8b 45 08             	mov    0x8(%ebp),%eax
801001ff:	8b 00                	mov    (%eax),%eax
80100201:	89 c2                	mov    %eax,%edx
80100203:	83 ca 04             	or     $0x4,%edx
80100206:	8b 45 08             	mov    0x8(%ebp),%eax
80100209:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010020b:	8b 45 08             	mov    0x8(%ebp),%eax
8010020e:	89 04 24             	mov    %eax,(%esp)
80100211:	e8 a8 25 00 00       	call   801027be <iderw>
}
80100216:	c9                   	leave  
80100217:	c3                   	ret    

80100218 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100218:	55                   	push   %ebp
80100219:	89 e5                	mov    %esp,%ebp
8010021b:	83 ec 18             	sub    $0x18,%esp
  if((b->flags & B_BUSY) == 0)
8010021e:	8b 45 08             	mov    0x8(%ebp),%eax
80100221:	8b 00                	mov    (%eax),%eax
80100223:	83 e0 01             	and    $0x1,%eax
80100226:	85 c0                	test   %eax,%eax
80100228:	75 0c                	jne    80100236 <brelse+0x1e>
    panic("brelse");
8010022a:	c7 04 24 1b 86 10 80 	movl   $0x8010861b,(%esp)
80100231:	e8 04 03 00 00       	call   8010053a <panic>

  acquire(&bcache.lock);
80100236:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010023d:	e8 0d 4d 00 00       	call   80104f4f <acquire>

  b->next->prev = b->prev;
80100242:	8b 45 08             	mov    0x8(%ebp),%eax
80100245:	8b 40 10             	mov    0x10(%eax),%eax
80100248:	8b 55 08             	mov    0x8(%ebp),%edx
8010024b:	8b 52 0c             	mov    0xc(%edx),%edx
8010024e:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
80100251:	8b 45 08             	mov    0x8(%ebp),%eax
80100254:	8b 40 0c             	mov    0xc(%eax),%eax
80100257:	8b 55 08             	mov    0x8(%ebp),%edx
8010025a:	8b 52 10             	mov    0x10(%edx),%edx
8010025d:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
80100260:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100266:	8b 45 08             	mov    0x8(%ebp),%eax
80100269:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
  bcache.head.next->prev = b;
80100276:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
8010027b:	8b 55 08             	mov    0x8(%ebp),%edx
8010027e:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

  b->flags &= ~B_BUSY;
80100289:	8b 45 08             	mov    0x8(%ebp),%eax
8010028c:	8b 00                	mov    (%eax),%eax
8010028e:	89 c2                	mov    %eax,%edx
80100290:	83 e2 fe             	and    $0xfffffffe,%edx
80100293:	8b 45 08             	mov    0x8(%ebp),%eax
80100296:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80100298:	8b 45 08             	mov    0x8(%ebp),%eax
8010029b:	89 04 24             	mov    %eax,(%esp)
8010029e:	e8 79 4a 00 00       	call   80104d1c <wakeup>

  release(&bcache.lock);
801002a3:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
801002aa:	e8 01 4d 00 00       	call   80104fb0 <release>
}
801002af:	c9                   	leave  
801002b0:	c3                   	ret    
801002b1:	00 00                	add    %al,(%eax)
	...

801002b4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002b4:	55                   	push   %ebp
801002b5:	89 e5                	mov    %esp,%ebp
801002b7:	83 ec 14             	sub    $0x14,%esp
801002ba:	8b 45 08             	mov    0x8(%ebp),%eax
801002bd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002c1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002c5:	89 c2                	mov    %eax,%edx
801002c7:	ec                   	in     (%dx),%al
801002c8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002cb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002cf:	c9                   	leave  
801002d0:	c3                   	ret    

801002d1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002d1:	55                   	push   %ebp
801002d2:	89 e5                	mov    %esp,%ebp
801002d4:	83 ec 08             	sub    $0x8,%esp
801002d7:	8b 55 08             	mov    0x8(%ebp),%edx
801002da:	8b 45 0c             	mov    0xc(%ebp),%eax
801002dd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801002e1:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801002e4:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801002e8:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801002ec:	ee                   	out    %al,(%dx)
}
801002ed:	c9                   	leave  
801002ee:	c3                   	ret    

801002ef <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
801002ef:	55                   	push   %ebp
801002f0:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
801002f2:	fa                   	cli    
}
801002f3:	5d                   	pop    %ebp
801002f4:	c3                   	ret    

801002f5 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801002f5:	55                   	push   %ebp
801002f6:	89 e5                	mov    %esp,%ebp
801002f8:	53                   	push   %ebx
801002f9:	83 ec 44             	sub    $0x44,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801002fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100300:	74 19                	je     8010031b <printint+0x26>
80100302:	8b 45 08             	mov    0x8(%ebp),%eax
80100305:	c1 e8 1f             	shr    $0x1f,%eax
80100308:	89 45 10             	mov    %eax,0x10(%ebp)
8010030b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010030f:	74 0a                	je     8010031b <printint+0x26>
    x = -xx;
80100311:	8b 45 08             	mov    0x8(%ebp),%eax
80100314:	f7 d8                	neg    %eax
80100316:	89 45 f4             	mov    %eax,-0xc(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100319:	eb 06                	jmp    80100321 <printint+0x2c>
    x = -xx;
  else
    x = xx;
8010031b:	8b 45 08             	mov    0x8(%ebp),%eax
8010031e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  i = 0;
80100321:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  do{
    buf[i++] = digits[x % base];
80100328:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010032b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100331:	ba 00 00 00 00       	mov    $0x0,%edx
80100336:	f7 f3                	div    %ebx
80100338:	89 d0                	mov    %edx,%eax
8010033a:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
80100341:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
80100345:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }while((x /= base) != 0);
80100349:	8b 45 0c             	mov    0xc(%ebp),%eax
8010034c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010034f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100352:	ba 00 00 00 00       	mov    $0x0,%edx
80100357:	f7 75 d4             	divl   -0x2c(%ebp)
8010035a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010035d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100361:	75 c5                	jne    80100328 <printint+0x33>

  if(sign)
80100363:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100367:	74 21                	je     8010038a <printint+0x95>
    buf[i++] = '-';
80100369:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010036c:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)
80100371:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)

  while(--i >= 0)
80100375:	eb 13                	jmp    8010038a <printint+0x95>
    consputc(buf[i]);
80100377:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010037a:	0f b6 44 05 e0       	movzbl -0x20(%ebp,%eax,1),%eax
8010037f:	0f be c0             	movsbl %al,%eax
80100382:	89 04 24             	mov    %eax,(%esp)
80100385:	e8 c4 03 00 00       	call   8010074e <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010038a:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
8010038e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100392:	79 e3                	jns    80100377 <printint+0x82>
    consputc(buf[i]);
}
80100394:	83 c4 44             	add    $0x44,%esp
80100397:	5b                   	pop    %ebx
80100398:	5d                   	pop    %ebp
80100399:	c3                   	ret    

8010039a <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
8010039a:	55                   	push   %ebp
8010039b:	89 e5                	mov    %esp,%ebp
8010039d:	83 ec 38             	sub    $0x38,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003a0:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(locking)
801003a8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801003ac:	74 0c                	je     801003ba <cprintf+0x20>
    acquire(&cons.lock);
801003ae:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
801003b5:	e8 95 4b 00 00       	call   80104f4f <acquire>

  if (fmt == 0)
801003ba:	8b 45 08             	mov    0x8(%ebp),%eax
801003bd:	85 c0                	test   %eax,%eax
801003bf:	75 0c                	jne    801003cd <cprintf+0x33>
    panic("null fmt");
801003c1:	c7 04 24 22 86 10 80 	movl   $0x80108622,(%esp)
801003c8:	e8 6d 01 00 00       	call   8010053a <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003cd:	8d 45 08             	lea    0x8(%ebp),%eax
801003d0:	83 c0 04             	add    $0x4,%eax
801003d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801003d6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801003dd:	e9 20 01 00 00       	jmp    80100502 <cprintf+0x168>
    if(c != '%'){
801003e2:	83 7d e8 25          	cmpl   $0x25,-0x18(%ebp)
801003e6:	74 10                	je     801003f8 <cprintf+0x5e>
      consputc(c);
801003e8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801003eb:	89 04 24             	mov    %eax,(%esp)
801003ee:	e8 5b 03 00 00       	call   8010074e <consputc>
      continue;
801003f3:	e9 06 01 00 00       	jmp    801004fe <cprintf+0x164>
    }
    c = fmt[++i] & 0xff;
801003f8:	8b 55 08             	mov    0x8(%ebp),%edx
801003fb:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801003ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100402:	8d 04 02             	lea    (%edx,%eax,1),%eax
80100405:	0f b6 00             	movzbl (%eax),%eax
80100408:	0f be c0             	movsbl %al,%eax
8010040b:	25 ff 00 00 00       	and    $0xff,%eax
80100410:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(c == 0)
80100413:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100417:	0f 84 08 01 00 00    	je     80100525 <cprintf+0x18b>
      break;
    switch(c){
8010041d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100420:	83 f8 70             	cmp    $0x70,%eax
80100423:	74 4d                	je     80100472 <cprintf+0xd8>
80100425:	83 f8 70             	cmp    $0x70,%eax
80100428:	7f 13                	jg     8010043d <cprintf+0xa3>
8010042a:	83 f8 25             	cmp    $0x25,%eax
8010042d:	0f 84 a6 00 00 00    	je     801004d9 <cprintf+0x13f>
80100433:	83 f8 64             	cmp    $0x64,%eax
80100436:	74 14                	je     8010044c <cprintf+0xb2>
80100438:	e9 aa 00 00 00       	jmp    801004e7 <cprintf+0x14d>
8010043d:	83 f8 73             	cmp    $0x73,%eax
80100440:	74 53                	je     80100495 <cprintf+0xfb>
80100442:	83 f8 78             	cmp    $0x78,%eax
80100445:	74 2b                	je     80100472 <cprintf+0xd8>
80100447:	e9 9b 00 00 00       	jmp    801004e7 <cprintf+0x14d>
    case 'd':
      printint(*argp++, 10, 1);
8010044c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010044f:	8b 00                	mov    (%eax),%eax
80100451:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
80100455:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
8010045c:	00 
8010045d:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80100464:	00 
80100465:	89 04 24             	mov    %eax,(%esp)
80100468:	e8 88 fe ff ff       	call   801002f5 <printint>
      break;
8010046d:	e9 8c 00 00 00       	jmp    801004fe <cprintf+0x164>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
80100472:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100475:	8b 00                	mov    (%eax),%eax
80100477:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
8010047b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100482:	00 
80100483:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
8010048a:	00 
8010048b:	89 04 24             	mov    %eax,(%esp)
8010048e:	e8 62 fe ff ff       	call   801002f5 <printint>
      break;
80100493:	eb 69                	jmp    801004fe <cprintf+0x164>
    case 's':
      if((s = (char*)*argp++) == 0)
80100495:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100498:	8b 00                	mov    (%eax),%eax
8010049a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010049d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801004a1:	0f 94 c0             	sete   %al
801004a4:	83 45 f0 04          	addl   $0x4,-0x10(%ebp)
801004a8:	84 c0                	test   %al,%al
801004aa:	74 20                	je     801004cc <cprintf+0x132>
        s = "(null)";
801004ac:	c7 45 f4 2b 86 10 80 	movl   $0x8010862b,-0xc(%ebp)
      for(; *s; s++)
801004b3:	eb 18                	jmp    801004cd <cprintf+0x133>
        consputc(*s);
801004b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801004b8:	0f b6 00             	movzbl (%eax),%eax
801004bb:	0f be c0             	movsbl %al,%eax
801004be:	89 04 24             	mov    %eax,(%esp)
801004c1:	e8 88 02 00 00       	call   8010074e <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801004ca:	eb 01                	jmp    801004cd <cprintf+0x133>
801004cc:	90                   	nop
801004cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801004d0:	0f b6 00             	movzbl (%eax),%eax
801004d3:	84 c0                	test   %al,%al
801004d5:	75 de                	jne    801004b5 <cprintf+0x11b>
        consputc(*s);
      break;
801004d7:	eb 25                	jmp    801004fe <cprintf+0x164>
    case '%':
      consputc('%');
801004d9:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004e0:	e8 69 02 00 00       	call   8010074e <consputc>
      break;
801004e5:	eb 17                	jmp    801004fe <cprintf+0x164>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
801004e7:	c7 04 24 25 00 00 00 	movl   $0x25,(%esp)
801004ee:	e8 5b 02 00 00       	call   8010074e <consputc>
      consputc(c);
801004f3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801004f6:	89 04 24             	mov    %eax,(%esp)
801004f9:	e8 50 02 00 00       	call   8010074e <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801004fe:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100502:	8b 55 08             	mov    0x8(%ebp),%edx
80100505:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100508:	8d 04 02             	lea    (%edx,%eax,1),%eax
8010050b:	0f b6 00             	movzbl (%eax),%eax
8010050e:	0f be c0             	movsbl %al,%eax
80100511:	25 ff 00 00 00       	and    $0xff,%eax
80100516:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100519:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010051d:	0f 85 bf fe ff ff    	jne    801003e2 <cprintf+0x48>
80100523:	eb 01                	jmp    80100526 <cprintf+0x18c>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
80100525:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
80100526:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010052a:	74 0c                	je     80100538 <cprintf+0x19e>
    release(&cons.lock);
8010052c:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100533:	e8 78 4a 00 00       	call   80104fb0 <release>
}
80100538:	c9                   	leave  
80100539:	c3                   	ret    

8010053a <panic>:

void
panic(char *s)
{
8010053a:	55                   	push   %ebp
8010053b:	89 e5                	mov    %esp,%ebp
8010053d:	83 ec 48             	sub    $0x48,%esp
  int i;
  uint pcs[10];
  
  cli();
80100540:	e8 aa fd ff ff       	call   801002ef <cli>
  cons.locking = 0;
80100545:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
8010054c:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010054f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100555:	0f b6 00             	movzbl (%eax),%eax
80100558:	0f b6 c0             	movzbl %al,%eax
8010055b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010055f:	c7 04 24 32 86 10 80 	movl   $0x80108632,(%esp)
80100566:	e8 2f fe ff ff       	call   8010039a <cprintf>
  cprintf(s);
8010056b:	8b 45 08             	mov    0x8(%ebp),%eax
8010056e:	89 04 24             	mov    %eax,(%esp)
80100571:	e8 24 fe ff ff       	call   8010039a <cprintf>
  cprintf("\n");
80100576:	c7 04 24 41 86 10 80 	movl   $0x80108641,(%esp)
8010057d:	e8 18 fe ff ff       	call   8010039a <cprintf>
  getcallerpcs(&s, pcs);
80100582:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100585:	89 44 24 04          	mov    %eax,0x4(%esp)
80100589:	8d 45 08             	lea    0x8(%ebp),%eax
8010058c:	89 04 24             	mov    %eax,(%esp)
8010058f:	e8 6b 4a 00 00       	call   80104fff <getcallerpcs>
  for(i=0; i<10; i++)
80100594:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010059b:	eb 1b                	jmp    801005b8 <panic+0x7e>
    cprintf(" %p", pcs[i]);
8010059d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005a0:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005a4:	89 44 24 04          	mov    %eax,0x4(%esp)
801005a8:	c7 04 24 43 86 10 80 	movl   $0x80108643,(%esp)
801005af:	e8 e6 fd ff ff       	call   8010039a <cprintf>
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005b8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005bc:	7e df                	jle    8010059d <panic+0x63>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005be:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005c5:	00 00 00 
  for(;;)
    ;
801005c8:	eb fe                	jmp    801005c8 <panic+0x8e>

801005ca <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
801005ca:	55                   	push   %ebp
801005cb:	89 e5                	mov    %esp,%ebp
801005cd:	83 ec 28             	sub    $0x28,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
801005d0:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801005d7:	00 
801005d8:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801005df:	e8 ed fc ff ff       	call   801002d1 <outb>
  pos = inb(CRTPORT+1) << 8;
801005e4:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
801005eb:	e8 c4 fc ff ff       	call   801002b4 <inb>
801005f0:	0f b6 c0             	movzbl %al,%eax
801005f3:	c1 e0 08             	shl    $0x8,%eax
801005f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
801005f9:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100600:	00 
80100601:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100608:	e8 c4 fc ff ff       	call   801002d1 <outb>
  pos |= inb(CRTPORT+1);
8010060d:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100614:	e8 9b fc ff ff       	call   801002b4 <inb>
80100619:	0f b6 c0             	movzbl %al,%eax
8010061c:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010061f:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100623:	75 30                	jne    80100655 <cgaputc+0x8b>
    pos += 80 - pos%80;
80100625:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100628:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010062d:	89 c8                	mov    %ecx,%eax
8010062f:	f7 ea                	imul   %edx
80100631:	c1 fa 05             	sar    $0x5,%edx
80100634:	89 c8                	mov    %ecx,%eax
80100636:	c1 f8 1f             	sar    $0x1f,%eax
80100639:	29 c2                	sub    %eax,%edx
8010063b:	89 d0                	mov    %edx,%eax
8010063d:	c1 e0 02             	shl    $0x2,%eax
80100640:	01 d0                	add    %edx,%eax
80100642:	c1 e0 04             	shl    $0x4,%eax
80100645:	89 ca                	mov    %ecx,%edx
80100647:	29 c2                	sub    %eax,%edx
80100649:	b8 50 00 00 00       	mov    $0x50,%eax
8010064e:	29 d0                	sub    %edx,%eax
80100650:	01 45 f4             	add    %eax,-0xc(%ebp)
80100653:	eb 33                	jmp    80100688 <cgaputc+0xbe>
  else if(c == BACKSPACE){
80100655:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010065c:	75 0c                	jne    8010066a <cgaputc+0xa0>
    if(pos > 0) --pos;
8010065e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100662:	7e 24                	jle    80100688 <cgaputc+0xbe>
80100664:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100668:	eb 1e                	jmp    80100688 <cgaputc+0xbe>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010066a:	a1 00 90 10 80       	mov    0x80109000,%eax
8010066f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100672:	01 d2                	add    %edx,%edx
80100674:	8d 14 10             	lea    (%eax,%edx,1),%edx
80100677:	8b 45 08             	mov    0x8(%ebp),%eax
8010067a:	66 25 ff 00          	and    $0xff,%ax
8010067e:	80 cc 07             	or     $0x7,%ah
80100681:	66 89 02             	mov    %ax,(%edx)
80100684:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  if((pos/80) >= 24){  // Scroll up.
80100688:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
8010068f:	7e 53                	jle    801006e4 <cgaputc+0x11a>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100691:	a1 00 90 10 80       	mov    0x80109000,%eax
80100696:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
8010069c:	a1 00 90 10 80       	mov    0x80109000,%eax
801006a1:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801006a8:	00 
801006a9:	89 54 24 04          	mov    %edx,0x4(%esp)
801006ad:	89 04 24             	mov    %eax,(%esp)
801006b0:	e8 bc 4b 00 00       	call   80105271 <memmove>
    pos -= 80;
801006b5:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006b9:	b8 80 07 00 00       	mov    $0x780,%eax
801006be:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006c1:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006c4:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006cc:	01 c9                	add    %ecx,%ecx
801006ce:	01 c8                	add    %ecx,%eax
801006d0:	89 54 24 08          	mov    %edx,0x8(%esp)
801006d4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801006db:	00 
801006dc:	89 04 24             	mov    %eax,(%esp)
801006df:	e8 ba 4a 00 00       	call   8010519e <memset>
  }
  
  outb(CRTPORT, 14);
801006e4:	c7 44 24 04 0e 00 00 	movl   $0xe,0x4(%esp)
801006eb:	00 
801006ec:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
801006f3:	e8 d9 fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT+1, pos>>8);
801006f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006fb:	c1 f8 08             	sar    $0x8,%eax
801006fe:	0f b6 c0             	movzbl %al,%eax
80100701:	89 44 24 04          	mov    %eax,0x4(%esp)
80100705:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
8010070c:	e8 c0 fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT, 15);
80100711:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80100718:	00 
80100719:	c7 04 24 d4 03 00 00 	movl   $0x3d4,(%esp)
80100720:	e8 ac fb ff ff       	call   801002d1 <outb>
  outb(CRTPORT+1, pos);
80100725:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100728:	0f b6 c0             	movzbl %al,%eax
8010072b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010072f:	c7 04 24 d5 03 00 00 	movl   $0x3d5,(%esp)
80100736:	e8 96 fb ff ff       	call   801002d1 <outb>
  crt[pos] = ' ' | 0x0700;
8010073b:	a1 00 90 10 80       	mov    0x80109000,%eax
80100740:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100743:	01 d2                	add    %edx,%edx
80100745:	01 d0                	add    %edx,%eax
80100747:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
8010074c:	c9                   	leave  
8010074d:	c3                   	ret    

8010074e <consputc>:

void
consputc(int c)
{
8010074e:	55                   	push   %ebp
8010074f:	89 e5                	mov    %esp,%ebp
80100751:	83 ec 18             	sub    $0x18,%esp
  if(panicked){
80100754:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80100759:	85 c0                	test   %eax,%eax
8010075b:	74 07                	je     80100764 <consputc+0x16>
    cli();
8010075d:	e8 8d fb ff ff       	call   801002ef <cli>
    for(;;)
      ;
80100762:	eb fe                	jmp    80100762 <consputc+0x14>
  }

  if(c == BACKSPACE){
80100764:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010076b:	75 26                	jne    80100793 <consputc+0x45>
    uartputc('\b'); uartputc(' '); uartputc('\b');
8010076d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100774:	e8 d3 64 00 00       	call   80106c4c <uartputc>
80100779:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100780:	e8 c7 64 00 00       	call   80106c4c <uartputc>
80100785:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010078c:	e8 bb 64 00 00       	call   80106c4c <uartputc>
80100791:	eb 0b                	jmp    8010079e <consputc+0x50>
  } else
    uartputc(c);
80100793:	8b 45 08             	mov    0x8(%ebp),%eax
80100796:	89 04 24             	mov    %eax,(%esp)
80100799:	e8 ae 64 00 00       	call   80106c4c <uartputc>
  cgaputc(c);
8010079e:	8b 45 08             	mov    0x8(%ebp),%eax
801007a1:	89 04 24             	mov    %eax,(%esp)
801007a4:	e8 21 fe ff ff       	call   801005ca <cgaputc>
}
801007a9:	c9                   	leave  
801007aa:	c3                   	ret    

801007ab <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007ab:	55                   	push   %ebp
801007ac:	89 e5                	mov    %esp,%ebp
801007ae:	83 ec 28             	sub    $0x28,%esp
  int c;

  acquire(&input.lock);
801007b1:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
801007b8:	e8 92 47 00 00       	call   80104f4f <acquire>
  while((c = getc()) >= 0){
801007bd:	e9 3e 01 00 00       	jmp    80100900 <consoleintr+0x155>
    switch(c){
801007c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007c5:	83 f8 10             	cmp    $0x10,%eax
801007c8:	74 1e                	je     801007e8 <consoleintr+0x3d>
801007ca:	83 f8 10             	cmp    $0x10,%eax
801007cd:	7f 0a                	jg     801007d9 <consoleintr+0x2e>
801007cf:	83 f8 08             	cmp    $0x8,%eax
801007d2:	74 68                	je     8010083c <consoleintr+0x91>
801007d4:	e9 94 00 00 00       	jmp    8010086d <consoleintr+0xc2>
801007d9:	83 f8 15             	cmp    $0x15,%eax
801007dc:	74 2f                	je     8010080d <consoleintr+0x62>
801007de:	83 f8 7f             	cmp    $0x7f,%eax
801007e1:	74 59                	je     8010083c <consoleintr+0x91>
801007e3:	e9 85 00 00 00       	jmp    8010086d <consoleintr+0xc2>
    case C('P'):  // Process listing.
      procdump();
801007e8:	e8 d6 45 00 00       	call   80104dc3 <procdump>
      break;
801007ed:	e9 0e 01 00 00       	jmp    80100900 <consoleintr+0x155>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801007f2:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801007f7:	83 e8 01             	sub    $0x1,%eax
801007fa:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
801007ff:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100806:	e8 43 ff ff ff       	call   8010074e <consputc>
8010080b:	eb 01                	jmp    8010080e <consoleintr+0x63>
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010080d:	90                   	nop
8010080e:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
80100814:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100819:	39 c2                	cmp    %eax,%edx
8010081b:	0f 84 db 00 00 00    	je     801008fc <consoleintr+0x151>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100821:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100826:	83 e8 01             	sub    $0x1,%eax
80100829:	83 e0 7f             	and    $0x7f,%eax
8010082c:	0f b6 80 f4 dd 10 80 	movzbl -0x7fef220c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100833:	3c 0a                	cmp    $0xa,%al
80100835:	75 bb                	jne    801007f2 <consoleintr+0x47>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
80100837:	e9 c4 00 00 00       	jmp    80100900 <consoleintr+0x155>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
8010083c:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
80100842:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100847:	39 c2                	cmp    %eax,%edx
80100849:	0f 84 b0 00 00 00    	je     801008ff <consoleintr+0x154>
        input.e--;
8010084f:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100854:	83 e8 01             	sub    $0x1,%eax
80100857:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
8010085c:	c7 04 24 00 01 00 00 	movl   $0x100,(%esp)
80100863:	e8 e6 fe ff ff       	call   8010074e <consputc>
      }
      break;
80100868:	e9 93 00 00 00       	jmp    80100900 <consoleintr+0x155>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010086d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100871:	0f 84 89 00 00 00    	je     80100900 <consoleintr+0x155>
80100877:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
8010087d:	a1 74 de 10 80       	mov    0x8010de74,%eax
80100882:	89 d1                	mov    %edx,%ecx
80100884:	29 c1                	sub    %eax,%ecx
80100886:	89 c8                	mov    %ecx,%eax
80100888:	83 f8 7f             	cmp    $0x7f,%eax
8010088b:	77 73                	ja     80100900 <consoleintr+0x155>
        c = (c == '\r') ? '\n' : c;
8010088d:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
80100891:	74 05                	je     80100898 <consoleintr+0xed>
80100893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100896:	eb 05                	jmp    8010089d <consoleintr+0xf2>
80100898:	b8 0a 00 00 00       	mov    $0xa,%eax
8010089d:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008a0:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008a5:	89 c1                	mov    %eax,%ecx
801008a7:	83 e1 7f             	and    $0x7f,%ecx
801008aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008ad:	88 91 f4 dd 10 80    	mov    %dl,-0x7fef220c(%ecx)
801008b3:	83 c0 01             	add    $0x1,%eax
801008b6:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(c);
801008bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008be:	89 04 24             	mov    %eax,(%esp)
801008c1:	e8 88 fe ff ff       	call   8010074e <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c6:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801008ca:	74 18                	je     801008e4 <consoleintr+0x139>
801008cc:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801008d0:	74 12                	je     801008e4 <consoleintr+0x139>
801008d2:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008d7:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
801008dd:	83 ea 80             	sub    $0xffffff80,%edx
801008e0:	39 d0                	cmp    %edx,%eax
801008e2:	75 1c                	jne    80100900 <consoleintr+0x155>
          input.w = input.e;
801008e4:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008e9:	a3 78 de 10 80       	mov    %eax,0x8010de78
          wakeup(&input.r);
801008ee:	c7 04 24 74 de 10 80 	movl   $0x8010de74,(%esp)
801008f5:	e8 22 44 00 00       	call   80104d1c <wakeup>
801008fa:	eb 04                	jmp    80100900 <consoleintr+0x155>
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008fc:	90                   	nop
801008fd:	eb 01                	jmp    80100900 <consoleintr+0x155>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
801008ff:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
80100900:	8b 45 08             	mov    0x8(%ebp),%eax
80100903:	ff d0                	call   *%eax
80100905:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100908:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010090c:	0f 89 b0 fe ff ff    	jns    801007c2 <consoleintr+0x17>
        }
      }
      break;
    }
  }
  release(&input.lock);
80100912:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100919:	e8 92 46 00 00       	call   80104fb0 <release>
}
8010091e:	c9                   	leave  
8010091f:	c3                   	ret    

80100920 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
80100920:	55                   	push   %ebp
80100921:	89 e5                	mov    %esp,%ebp
80100923:	83 ec 28             	sub    $0x28,%esp
  uint target;
  int c;

  iunlock(ip);
80100926:	8b 45 08             	mov    0x8(%ebp),%eax
80100929:	89 04 24             	mov    %eax,(%esp)
8010092c:	e8 9b 10 00 00       	call   801019cc <iunlock>
  target = n;
80100931:	8b 45 10             	mov    0x10(%ebp),%eax
80100934:	89 45 f0             	mov    %eax,-0x10(%ebp)
  acquire(&input.lock);
80100937:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
8010093e:	e8 0c 46 00 00       	call   80104f4f <acquire>
  while(n > 0){
80100943:	e9 a8 00 00 00       	jmp    801009f0 <consoleread+0xd0>
    while(input.r == input.w){
      if(proc->killed){
80100948:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010094e:	8b 40 24             	mov    0x24(%eax),%eax
80100951:	85 c0                	test   %eax,%eax
80100953:	74 21                	je     80100976 <consoleread+0x56>
        release(&input.lock);
80100955:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
8010095c:	e8 4f 46 00 00       	call   80104fb0 <release>
        ilock(ip);
80100961:	8b 45 08             	mov    0x8(%ebp),%eax
80100964:	89 04 24             	mov    %eax,(%esp)
80100967:	e8 0f 0f 00 00       	call   8010187b <ilock>
        return -1;
8010096c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100971:	e9 a9 00 00 00       	jmp    80100a1f <consoleread+0xff>
      }
      sleep(&input.r, &input.lock);
80100976:	c7 44 24 04 c0 dd 10 	movl   $0x8010ddc0,0x4(%esp)
8010097d:	80 
8010097e:	c7 04 24 74 de 10 80 	movl   $0x8010de74,(%esp)
80100985:	e8 4c 42 00 00       	call   80104bd6 <sleep>
8010098a:	eb 01                	jmp    8010098d <consoleread+0x6d>

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
8010098c:	90                   	nop
8010098d:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
80100993:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100998:	39 c2                	cmp    %eax,%edx
8010099a:	74 ac                	je     80100948 <consoleread+0x28>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
8010099c:	a1 74 de 10 80       	mov    0x8010de74,%eax
801009a1:	89 c2                	mov    %eax,%edx
801009a3:	83 e2 7f             	and    $0x7f,%edx
801009a6:	0f b6 92 f4 dd 10 80 	movzbl -0x7fef220c(%edx),%edx
801009ad:	0f be d2             	movsbl %dl,%edx
801009b0:	89 55 f4             	mov    %edx,-0xc(%ebp)
801009b3:	83 c0 01             	add    $0x1,%eax
801009b6:	a3 74 de 10 80       	mov    %eax,0x8010de74
    if(c == C('D')){  // EOF
801009bb:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
801009bf:	75 17                	jne    801009d8 <consoleread+0xb8>
      if(n < target){
801009c1:	8b 45 10             	mov    0x10(%ebp),%eax
801009c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801009c7:	73 2f                	jae    801009f8 <consoleread+0xd8>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
801009c9:	a1 74 de 10 80       	mov    0x8010de74,%eax
801009ce:	83 e8 01             	sub    $0x1,%eax
801009d1:	a3 74 de 10 80       	mov    %eax,0x8010de74
      }
      break;
801009d6:	eb 24                	jmp    801009fc <consoleread+0xdc>
    }
    *dst++ = c;
801009d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801009db:	89 c2                	mov    %eax,%edx
801009dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801009e0:	88 10                	mov    %dl,(%eax)
801009e2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    --n;
801009e6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
801009ea:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
801009ee:	74 0b                	je     801009fb <consoleread+0xdb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
801009f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801009f4:	7f 96                	jg     8010098c <consoleread+0x6c>
801009f6:	eb 04                	jmp    801009fc <consoleread+0xdc>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
801009f8:	90                   	nop
801009f9:	eb 01                	jmp    801009fc <consoleread+0xdc>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
801009fb:	90                   	nop
  }
  release(&input.lock);
801009fc:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100a03:	e8 a8 45 00 00       	call   80104fb0 <release>
  ilock(ip);
80100a08:	8b 45 08             	mov    0x8(%ebp),%eax
80100a0b:	89 04 24             	mov    %eax,(%esp)
80100a0e:	e8 68 0e 00 00       	call   8010187b <ilock>

  return target - n;
80100a13:	8b 45 10             	mov    0x10(%ebp),%eax
80100a16:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a19:	89 d1                	mov    %edx,%ecx
80100a1b:	29 c1                	sub    %eax,%ecx
80100a1d:	89 c8                	mov    %ecx,%eax
}
80100a1f:	c9                   	leave  
80100a20:	c3                   	ret    

80100a21 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a21:	55                   	push   %ebp
80100a22:	89 e5                	mov    %esp,%ebp
80100a24:	83 ec 28             	sub    $0x28,%esp
  int i;

  iunlock(ip);
80100a27:	8b 45 08             	mov    0x8(%ebp),%eax
80100a2a:	89 04 24             	mov    %eax,(%esp)
80100a2d:	e8 9a 0f 00 00       	call   801019cc <iunlock>
  acquire(&cons.lock);
80100a32:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a39:	e8 11 45 00 00       	call   80104f4f <acquire>
  for(i = 0; i < n; i++)
80100a3e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a45:	eb 1d                	jmp    80100a64 <consolewrite+0x43>
    consputc(buf[i] & 0xff);
80100a47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a4a:	03 45 0c             	add    0xc(%ebp),%eax
80100a4d:	0f b6 00             	movzbl (%eax),%eax
80100a50:	0f be c0             	movsbl %al,%eax
80100a53:	25 ff 00 00 00       	and    $0xff,%eax
80100a58:	89 04 24             	mov    %eax,(%esp)
80100a5b:	e8 ee fc ff ff       	call   8010074e <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100a60:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100a64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100a67:	3b 45 10             	cmp    0x10(%ebp),%eax
80100a6a:	7c db                	jl     80100a47 <consolewrite+0x26>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100a6c:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a73:	e8 38 45 00 00       	call   80104fb0 <release>
  ilock(ip);
80100a78:	8b 45 08             	mov    0x8(%ebp),%eax
80100a7b:	89 04 24             	mov    %eax,(%esp)
80100a7e:	e8 f8 0d 00 00       	call   8010187b <ilock>

  return n;
80100a83:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100a86:	c9                   	leave  
80100a87:	c3                   	ret    

80100a88 <consoleinit>:

void
consoleinit(void)
{
80100a88:	55                   	push   %ebp
80100a89:	89 e5                	mov    %esp,%ebp
80100a8b:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100a8e:	c7 44 24 04 47 86 10 	movl   $0x80108647,0x4(%esp)
80100a95:	80 
80100a96:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100a9d:	e8 8c 44 00 00       	call   80104f2e <initlock>
  initlock(&input.lock, "input");
80100aa2:	c7 44 24 04 4f 86 10 	movl   $0x8010864f,0x4(%esp)
80100aa9:	80 
80100aaa:	c7 04 24 c0 dd 10 80 	movl   $0x8010ddc0,(%esp)
80100ab1:	e8 78 44 00 00       	call   80104f2e <initlock>

  devsw[CONSOLE].write = consolewrite;
80100ab6:	c7 05 2c e8 10 80 21 	movl   $0x80100a21,0x8010e82c
80100abd:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100ac0:	c7 05 28 e8 10 80 20 	movl   $0x80100920,0x8010e828
80100ac7:	09 10 80 
  cons.locking = 1;
80100aca:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100ad1:	00 00 00 

  picenable(IRQ_KBD);
80100ad4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100adb:	e8 ad 2f 00 00       	call   80103a8d <picenable>
  ioapicenable(IRQ_KBD, 0);
80100ae0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100ae7:	00 
80100ae8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80100aef:	e8 8a 1e 00 00       	call   8010297e <ioapicenable>
}
80100af4:	c9                   	leave  
80100af5:	c3                   	ret    
	...

80100af8 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100af8:	55                   	push   %ebp
80100af9:	89 e5                	mov    %esp,%ebp
80100afb:	81 ec 38 01 00 00    	sub    $0x138,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100b01:	8b 45 08             	mov    0x8(%ebp),%eax
80100b04:	89 04 24             	mov    %eax,(%esp)
80100b07:	e8 17 19 00 00       	call   80102423 <namei>
80100b0c:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100b0f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100b13:	75 0a                	jne    80100b1f <exec+0x27>
    return -1;
80100b15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b1a:	e9 e4 03 00 00       	jmp    80100f03 <exec+0x40b>
  ilock(ip);
80100b1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b22:	89 04 24             	mov    %eax,(%esp)
80100b25:	e8 51 0d 00 00       	call   8010187b <ilock>
  pgdir = 0;
80100b2a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b31:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b37:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100b3e:	00 
80100b3f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100b46:	00 
80100b47:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b4b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100b4e:	89 04 24             	mov    %eax,(%esp)
80100b51:	e8 1e 12 00 00       	call   80101d74 <readi>
80100b56:	83 f8 33             	cmp    $0x33,%eax
80100b59:	0f 86 5e 03 00 00    	jbe    80100ebd <exec+0x3c5>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100b5f:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b65:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100b6a:	0f 85 50 03 00 00    	jne    80100ec0 <exec+0x3c8>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100b70:	e8 1c 72 00 00       	call   80107d91 <setupkvm>
80100b75:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100b78:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100b7c:	0f 84 41 03 00 00    	je     80100ec3 <exec+0x3cb>
    goto bad;

  // Load program into memory.
  sz = PGSIZE;
80100b82:	c7 45 e4 00 10 00 00 	movl   $0x1000,-0x1c(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b89:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
80100b90:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100b96:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100b99:	e9 ca 00 00 00       	jmp    80100c68 <exec+0x170>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b9e:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ba1:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100ba7:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100bae:	00 
80100baf:	89 54 24 08          	mov    %edx,0x8(%esp)
80100bb3:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100bba:	89 04 24             	mov    %eax,(%esp)
80100bbd:	e8 b2 11 00 00       	call   80101d74 <readi>
80100bc2:	83 f8 20             	cmp    $0x20,%eax
80100bc5:	0f 85 fb 02 00 00    	jne    80100ec6 <exec+0x3ce>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100bcb:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100bd1:	83 f8 01             	cmp    $0x1,%eax
80100bd4:	0f 85 80 00 00 00    	jne    80100c5a <exec+0x162>
      continue;
    if(ph.memsz < ph.filesz)
80100bda:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100be0:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100be6:	39 c2                	cmp    %eax,%edx
80100be8:	0f 82 db 02 00 00    	jb     80100ec9 <exec+0x3d1>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100bee:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100bf4:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100bfa:	8d 04 02             	lea    (%edx,%eax,1),%eax
80100bfd:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c01:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c04:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c0b:	89 04 24             	mov    %eax,(%esp)
80100c0e:	e8 52 75 00 00       	call   80108165 <allocuvm>
80100c13:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100c16:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100c1a:	0f 84 ac 02 00 00    	je     80100ecc <exec+0x3d4>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c20:	8b 8d fc fe ff ff    	mov    -0x104(%ebp),%ecx
80100c26:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100c2c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100c32:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80100c36:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100c3a:	8b 55 ec             	mov    -0x14(%ebp),%edx
80100c3d:	89 54 24 08          	mov    %edx,0x8(%esp)
80100c41:	89 44 24 04          	mov    %eax,0x4(%esp)
80100c45:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100c48:	89 04 24             	mov    %eax,(%esp)
80100c4b:	e8 25 74 00 00       	call   80108075 <loaduvm>
80100c50:	85 c0                	test   %eax,%eax
80100c52:	0f 88 77 02 00 00    	js     80100ecf <exec+0x3d7>
80100c58:	eb 01                	jmp    80100c5b <exec+0x163>
  sz = PGSIZE;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c5a:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = PGSIZE;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c5b:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
80100c5f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100c62:	83 c0 20             	add    $0x20,%eax
80100c65:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100c68:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100c6f:	0f b7 c0             	movzwl %ax,%eax
80100c72:	3b 45 d8             	cmp    -0x28(%ebp),%eax
80100c75:	0f 8f 23 ff ff ff    	jg     80100b9e <exec+0xa6>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100c7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100c7e:	89 04 24             	mov    %eax,(%esp)
80100c81:	e8 7c 0e 00 00       	call   80101b02 <iunlockput>
  ip = 0;
80100c86:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100c8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c90:	05 ff 0f 00 00       	add    $0xfff,%eax
80100c95:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100c9a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ca0:	05 00 20 00 00       	add    $0x2000,%eax
80100ca5:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ca9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cac:	89 44 24 04          	mov    %eax,0x4(%esp)
80100cb0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100cb3:	89 04 24             	mov    %eax,(%esp)
80100cb6:	e8 aa 74 00 00       	call   80108165 <allocuvm>
80100cbb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100cbe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100cc2:	0f 84 0a 02 00 00    	je     80100ed2 <exec+0x3da>
    goto bad;
  proc->pstack = (uint *)sz;
80100cc8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100cd1:	89 50 7c             	mov    %edx,0x7c(%eax)

  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cd4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cd7:	2d 00 20 00 00       	sub    $0x2000,%eax
80100cdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ce3:	89 04 24             	mov    %eax,(%esp)
80100ce6:	e8 9e 76 00 00       	call   80108389 <clearpteu>

  sp = sz;
80100ceb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100cee:	89 45 e8             	mov    %eax,-0x18(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100cf1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80100cf8:	e9 81 00 00 00       	jmp    80100d7e <exec+0x286>
    if(argc >= MAXARG)
80100cfd:	83 7d e0 1f          	cmpl   $0x1f,-0x20(%ebp)
80100d01:	0f 87 ce 01 00 00    	ja     80100ed5 <exec+0x3dd>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d07:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d0a:	c1 e0 02             	shl    $0x2,%eax
80100d0d:	03 45 0c             	add    0xc(%ebp),%eax
80100d10:	8b 00                	mov    (%eax),%eax
80100d12:	89 04 24             	mov    %eax,(%esp)
80100d15:	e8 05 47 00 00       	call   8010541f <strlen>
80100d1a:	f7 d0                	not    %eax
80100d1c:	03 45 e8             	add    -0x18(%ebp),%eax
80100d1f:	83 e0 fc             	and    $0xfffffffc,%eax
80100d22:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d25:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d28:	c1 e0 02             	shl    $0x2,%eax
80100d2b:	03 45 0c             	add    0xc(%ebp),%eax
80100d2e:	8b 00                	mov    (%eax),%eax
80100d30:	89 04 24             	mov    %eax,(%esp)
80100d33:	e8 e7 46 00 00       	call   8010541f <strlen>
80100d38:	83 c0 01             	add    $0x1,%eax
80100d3b:	89 c2                	mov    %eax,%edx
80100d3d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d40:	c1 e0 02             	shl    $0x2,%eax
80100d43:	03 45 0c             	add    0xc(%ebp),%eax
80100d46:	8b 00                	mov    (%eax),%eax
80100d48:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100d4c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100d50:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d53:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100d5a:	89 04 24             	mov    %eax,(%esp)
80100d5d:	e8 ec 77 00 00       	call   8010854e <copyout>
80100d62:	85 c0                	test   %eax,%eax
80100d64:	0f 88 6e 01 00 00    	js     80100ed8 <exec+0x3e0>
      goto bad;
    ustack[3+argc] = sp;
80100d6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d6d:	8d 50 03             	lea    0x3(%eax),%edx
80100d70:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d73:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));

  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d7a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80100d7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d81:	c1 e0 02             	shl    $0x2,%eax
80100d84:	03 45 0c             	add    0xc(%ebp),%eax
80100d87:	8b 00                	mov    (%eax),%eax
80100d89:	85 c0                	test   %eax,%eax
80100d8b:	0f 85 6c ff ff ff    	jne    80100cfd <exec+0x205>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100d91:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d94:	83 c0 03             	add    $0x3,%eax
80100d97:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100d9e:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100da2:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100da9:	ff ff ff 
  ustack[1] = argc;
80100dac:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100daf:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100db5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100db8:	83 c0 01             	add    $0x1,%eax
80100dbb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc2:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100dc5:	29 d0                	sub    %edx,%eax
80100dc7:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100dcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dd0:	83 c0 04             	add    $0x4,%eax
80100dd3:	c1 e0 02             	shl    $0x2,%eax
80100dd6:	29 45 e8             	sub    %eax,-0x18(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100dd9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ddc:	83 c0 04             	add    $0x4,%eax
80100ddf:	c1 e0 02             	shl    $0x2,%eax
80100de2:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100de6:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100dec:	89 44 24 08          	mov    %eax,0x8(%esp)
80100df0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100df3:	89 44 24 04          	mov    %eax,0x4(%esp)
80100df7:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100dfa:	89 04 24             	mov    %eax,(%esp)
80100dfd:	e8 4c 77 00 00       	call   8010854e <copyout>
80100e02:	85 c0                	test   %eax,%eax
80100e04:	0f 88 d1 00 00 00    	js     80100edb <exec+0x3e3>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e0a:	8b 45 08             	mov    0x8(%ebp),%eax
80100e0d:	89 45 d0             	mov    %eax,-0x30(%ebp)
80100e10:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e13:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100e16:	eb 17                	jmp    80100e2f <exec+0x337>
    if(*s == '/')
80100e18:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e1b:	0f b6 00             	movzbl (%eax),%eax
80100e1e:	3c 2f                	cmp    $0x2f,%al
80100e20:	75 09                	jne    80100e2b <exec+0x333>
      last = s+1;
80100e22:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e25:	83 c0 01             	add    $0x1,%eax
80100e28:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e2b:	83 45 d0 01          	addl   $0x1,-0x30(%ebp)
80100e2f:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e32:	0f b6 00             	movzbl (%eax),%eax
80100e35:	84 c0                	test   %al,%al
80100e37:	75 df                	jne    80100e18 <exec+0x320>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e39:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e3f:	8d 50 6c             	lea    0x6c(%eax),%edx
80100e42:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100e49:	00 
80100e4a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100e4d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100e51:	89 14 24             	mov    %edx,(%esp)
80100e54:	e8 78 45 00 00       	call   801053d1 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e5f:	8b 40 04             	mov    0x4(%eax),%eax
80100e62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  proc->pgdir = pgdir;
80100e65:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e6b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100e6e:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100e71:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e77:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100e7a:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100e7c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e82:	8b 40 18             	mov    0x18(%eax),%eax
80100e85:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100e8b:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100e8e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e94:	8b 40 18             	mov    0x18(%eax),%eax
80100e97:	8b 55 e8             	mov    -0x18(%ebp),%edx
80100e9a:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100e9d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ea3:	89 04 24             	mov    %eax,(%esp)
80100ea6:	e8 d8 6f 00 00       	call   80107e83 <switchuvm>
  freevm(oldpgdir);
80100eab:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100eae:	89 04 24             	mov    %eax,(%esp)
80100eb1:	e8 45 74 00 00       	call   801082fb <freevm>
  return 0;
80100eb6:	b8 00 00 00 00       	mov    $0x0,%eax
80100ebb:	eb 46                	jmp    80100f03 <exec+0x40b>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100ebd:	90                   	nop
80100ebe:	eb 1c                	jmp    80100edc <exec+0x3e4>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100ec0:	90                   	nop
80100ec1:	eb 19                	jmp    80100edc <exec+0x3e4>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100ec3:	90                   	nop
80100ec4:	eb 16                	jmp    80100edc <exec+0x3e4>

  // Load program into memory.
  sz = PGSIZE;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100ec6:	90                   	nop
80100ec7:	eb 13                	jmp    80100edc <exec+0x3e4>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100ec9:	90                   	nop
80100eca:	eb 10                	jmp    80100edc <exec+0x3e4>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100ecc:	90                   	nop
80100ecd:	eb 0d                	jmp    80100edc <exec+0x3e4>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100ecf:	90                   	nop
80100ed0:	eb 0a                	jmp    80100edc <exec+0x3e4>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100ed2:	90                   	nop
80100ed3:	eb 07                	jmp    80100edc <exec+0x3e4>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100ed5:	90                   	nop
80100ed6:	eb 04                	jmp    80100edc <exec+0x3e4>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100ed8:	90                   	nop
80100ed9:	eb 01                	jmp    80100edc <exec+0x3e4>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100edb:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100edc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100ee0:	74 0b                	je     80100eed <exec+0x3f5>
    freevm(pgdir);
80100ee2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100ee5:	89 04 24             	mov    %eax,(%esp)
80100ee8:	e8 0e 74 00 00       	call   801082fb <freevm>
  if(ip)
80100eed:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80100ef1:	74 0b                	je     80100efe <exec+0x406>
    iunlockput(ip);
80100ef3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100ef6:	89 04 24             	mov    %eax,(%esp)
80100ef9:	e8 04 0c 00 00       	call   80101b02 <iunlockput>
  return -1;
80100efe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f03:	c9                   	leave  
80100f04:	c3                   	ret    
80100f05:	00 00                	add    %al,(%eax)
	...

80100f08 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f08:	55                   	push   %ebp
80100f09:	89 e5                	mov    %esp,%ebp
80100f0b:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100f0e:	c7 44 24 04 55 86 10 	movl   $0x80108655,0x4(%esp)
80100f15:	80 
80100f16:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f1d:	e8 0c 40 00 00       	call   80104f2e <initlock>
}
80100f22:	c9                   	leave  
80100f23:	c3                   	ret    

80100f24 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f24:	55                   	push   %ebp
80100f25:	89 e5                	mov    %esp,%ebp
80100f27:	83 ec 28             	sub    $0x28,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f2a:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f31:	e8 19 40 00 00       	call   80104f4f <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f36:	c7 45 f4 b4 de 10 80 	movl   $0x8010deb4,-0xc(%ebp)
80100f3d:	eb 29                	jmp    80100f68 <filealloc+0x44>
    if(f->ref == 0){
80100f3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f42:	8b 40 04             	mov    0x4(%eax),%eax
80100f45:	85 c0                	test   %eax,%eax
80100f47:	75 1b                	jne    80100f64 <filealloc+0x40>
      f->ref = 1;
80100f49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f4c:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f53:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f5a:	e8 51 40 00 00       	call   80104fb0 <release>
      return f;
80100f5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f62:	eb 1f                	jmp    80100f83 <filealloc+0x5f>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f64:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100f68:	b8 14 e8 10 80       	mov    $0x8010e814,%eax
80100f6d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100f70:	72 cd                	jb     80100f3f <filealloc+0x1b>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100f72:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f79:	e8 32 40 00 00       	call   80104fb0 <release>
  return 0;
80100f7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100f83:	c9                   	leave  
80100f84:	c3                   	ret    

80100f85 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f85:	55                   	push   %ebp
80100f86:	89 e5                	mov    %esp,%ebp
80100f88:	83 ec 18             	sub    $0x18,%esp
  acquire(&ftable.lock);
80100f8b:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100f92:	e8 b8 3f 00 00       	call   80104f4f <acquire>
  if(f->ref < 1)
80100f97:	8b 45 08             	mov    0x8(%ebp),%eax
80100f9a:	8b 40 04             	mov    0x4(%eax),%eax
80100f9d:	85 c0                	test   %eax,%eax
80100f9f:	7f 0c                	jg     80100fad <filedup+0x28>
    panic("filedup");
80100fa1:	c7 04 24 5c 86 10 80 	movl   $0x8010865c,(%esp)
80100fa8:	e8 8d f5 ff ff       	call   8010053a <panic>
  f->ref++;
80100fad:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb0:	8b 40 04             	mov    0x4(%eax),%eax
80100fb3:	8d 50 01             	lea    0x1(%eax),%edx
80100fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80100fb9:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
80100fbc:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100fc3:	e8 e8 3f 00 00       	call   80104fb0 <release>
  return f;
80100fc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100fcb:	c9                   	leave  
80100fcc:	c3                   	ret    

80100fcd <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fcd:	55                   	push   %ebp
80100fce:	89 e5                	mov    %esp,%ebp
80100fd0:	83 ec 38             	sub    $0x38,%esp
  struct file ff;

  acquire(&ftable.lock);
80100fd3:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80100fda:	e8 70 3f 00 00       	call   80104f4f <acquire>
  if(f->ref < 1)
80100fdf:	8b 45 08             	mov    0x8(%ebp),%eax
80100fe2:	8b 40 04             	mov    0x4(%eax),%eax
80100fe5:	85 c0                	test   %eax,%eax
80100fe7:	7f 0c                	jg     80100ff5 <fileclose+0x28>
    panic("fileclose");
80100fe9:	c7 04 24 64 86 10 80 	movl   $0x80108664,(%esp)
80100ff0:	e8 45 f5 ff ff       	call   8010053a <panic>
  if(--f->ref > 0){
80100ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80100ff8:	8b 40 04             	mov    0x4(%eax),%eax
80100ffb:	8d 50 ff             	lea    -0x1(%eax),%edx
80100ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80101001:	89 50 04             	mov    %edx,0x4(%eax)
80101004:	8b 45 08             	mov    0x8(%ebp),%eax
80101007:	8b 40 04             	mov    0x4(%eax),%eax
8010100a:	85 c0                	test   %eax,%eax
8010100c:	7e 11                	jle    8010101f <fileclose+0x52>
    release(&ftable.lock);
8010100e:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
80101015:	e8 96 3f 00 00       	call   80104fb0 <release>
    return;
8010101a:	e9 82 00 00 00       	jmp    801010a1 <fileclose+0xd4>
  }
  ff = *f;
8010101f:	8b 45 08             	mov    0x8(%ebp),%eax
80101022:	8b 10                	mov    (%eax),%edx
80101024:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101027:	8b 50 04             	mov    0x4(%eax),%edx
8010102a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010102d:	8b 50 08             	mov    0x8(%eax),%edx
80101030:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101033:	8b 50 0c             	mov    0xc(%eax),%edx
80101036:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101039:	8b 50 10             	mov    0x10(%eax),%edx
8010103c:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010103f:	8b 40 14             	mov    0x14(%eax),%eax
80101042:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
80101045:	8b 45 08             	mov    0x8(%ebp),%eax
80101048:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
8010104f:	8b 45 08             	mov    0x8(%ebp),%eax
80101052:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101058:	c7 04 24 80 de 10 80 	movl   $0x8010de80,(%esp)
8010105f:	e8 4c 3f 00 00       	call   80104fb0 <release>
  
  if(ff.type == FD_PIPE)
80101064:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101067:	83 f8 01             	cmp    $0x1,%eax
8010106a:	75 18                	jne    80101084 <fileclose+0xb7>
    pipeclose(ff.pipe, ff.writable);
8010106c:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
80101070:	0f be d0             	movsbl %al,%edx
80101073:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101076:	89 54 24 04          	mov    %edx,0x4(%esp)
8010107a:	89 04 24             	mov    %eax,(%esp)
8010107d:	e8 c5 2c 00 00       	call   80103d47 <pipeclose>
80101082:	eb 1d                	jmp    801010a1 <fileclose+0xd4>
  else if(ff.type == FD_INODE){
80101084:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101087:	83 f8 02             	cmp    $0x2,%eax
8010108a:	75 15                	jne    801010a1 <fileclose+0xd4>
    begin_trans();
8010108c:	e8 81 21 00 00       	call   80103212 <begin_trans>
    iput(ff.ip);
80101091:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101094:	89 04 24             	mov    %eax,(%esp)
80101097:	e8 95 09 00 00       	call   80101a31 <iput>
    commit_trans();
8010109c:	e8 ba 21 00 00       	call   8010325b <commit_trans>
  }
}
801010a1:	c9                   	leave  
801010a2:	c3                   	ret    

801010a3 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010a3:	55                   	push   %ebp
801010a4:	89 e5                	mov    %esp,%ebp
801010a6:	83 ec 18             	sub    $0x18,%esp
  if(f->type == FD_INODE){
801010a9:	8b 45 08             	mov    0x8(%ebp),%eax
801010ac:	8b 00                	mov    (%eax),%eax
801010ae:	83 f8 02             	cmp    $0x2,%eax
801010b1:	75 38                	jne    801010eb <filestat+0x48>
    ilock(f->ip);
801010b3:	8b 45 08             	mov    0x8(%ebp),%eax
801010b6:	8b 40 10             	mov    0x10(%eax),%eax
801010b9:	89 04 24             	mov    %eax,(%esp)
801010bc:	e8 ba 07 00 00       	call   8010187b <ilock>
    stati(f->ip, st);
801010c1:	8b 45 08             	mov    0x8(%ebp),%eax
801010c4:	8b 40 10             	mov    0x10(%eax),%eax
801010c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801010ca:	89 54 24 04          	mov    %edx,0x4(%esp)
801010ce:	89 04 24             	mov    %eax,(%esp)
801010d1:	e8 59 0c 00 00       	call   80101d2f <stati>
    iunlock(f->ip);
801010d6:	8b 45 08             	mov    0x8(%ebp),%eax
801010d9:	8b 40 10             	mov    0x10(%eax),%eax
801010dc:	89 04 24             	mov    %eax,(%esp)
801010df:	e8 e8 08 00 00       	call   801019cc <iunlock>
    return 0;
801010e4:	b8 00 00 00 00       	mov    $0x0,%eax
801010e9:	eb 05                	jmp    801010f0 <filestat+0x4d>
  }
  return -1;
801010eb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010f0:	c9                   	leave  
801010f1:	c3                   	ret    

801010f2 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801010f2:	55                   	push   %ebp
801010f3:	89 e5                	mov    %esp,%ebp
801010f5:	83 ec 28             	sub    $0x28,%esp
  int r;

  if(f->readable == 0)
801010f8:	8b 45 08             	mov    0x8(%ebp),%eax
801010fb:	0f b6 40 08          	movzbl 0x8(%eax),%eax
801010ff:	84 c0                	test   %al,%al
80101101:	75 0a                	jne    8010110d <fileread+0x1b>
    return -1;
80101103:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101108:	e9 9f 00 00 00       	jmp    801011ac <fileread+0xba>
  if(f->type == FD_PIPE)
8010110d:	8b 45 08             	mov    0x8(%ebp),%eax
80101110:	8b 00                	mov    (%eax),%eax
80101112:	83 f8 01             	cmp    $0x1,%eax
80101115:	75 1e                	jne    80101135 <fileread+0x43>
    return piperead(f->pipe, addr, n);
80101117:	8b 45 08             	mov    0x8(%ebp),%eax
8010111a:	8b 40 0c             	mov    0xc(%eax),%eax
8010111d:	8b 55 10             	mov    0x10(%ebp),%edx
80101120:	89 54 24 08          	mov    %edx,0x8(%esp)
80101124:	8b 55 0c             	mov    0xc(%ebp),%edx
80101127:	89 54 24 04          	mov    %edx,0x4(%esp)
8010112b:	89 04 24             	mov    %eax,(%esp)
8010112e:	e8 96 2d 00 00       	call   80103ec9 <piperead>
80101133:	eb 77                	jmp    801011ac <fileread+0xba>
  if(f->type == FD_INODE){
80101135:	8b 45 08             	mov    0x8(%ebp),%eax
80101138:	8b 00                	mov    (%eax),%eax
8010113a:	83 f8 02             	cmp    $0x2,%eax
8010113d:	75 61                	jne    801011a0 <fileread+0xae>
    ilock(f->ip);
8010113f:	8b 45 08             	mov    0x8(%ebp),%eax
80101142:	8b 40 10             	mov    0x10(%eax),%eax
80101145:	89 04 24             	mov    %eax,(%esp)
80101148:	e8 2e 07 00 00       	call   8010187b <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010114d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80101150:	8b 45 08             	mov    0x8(%ebp),%eax
80101153:	8b 50 14             	mov    0x14(%eax),%edx
80101156:	8b 45 08             	mov    0x8(%ebp),%eax
80101159:	8b 40 10             	mov    0x10(%eax),%eax
8010115c:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80101160:	89 54 24 08          	mov    %edx,0x8(%esp)
80101164:	8b 55 0c             	mov    0xc(%ebp),%edx
80101167:	89 54 24 04          	mov    %edx,0x4(%esp)
8010116b:	89 04 24             	mov    %eax,(%esp)
8010116e:	e8 01 0c 00 00       	call   80101d74 <readi>
80101173:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101176:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010117a:	7e 11                	jle    8010118d <fileread+0x9b>
      f->off += r;
8010117c:	8b 45 08             	mov    0x8(%ebp),%eax
8010117f:	8b 50 14             	mov    0x14(%eax),%edx
80101182:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101185:	01 c2                	add    %eax,%edx
80101187:	8b 45 08             	mov    0x8(%ebp),%eax
8010118a:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
8010118d:	8b 45 08             	mov    0x8(%ebp),%eax
80101190:	8b 40 10             	mov    0x10(%eax),%eax
80101193:	89 04 24             	mov    %eax,(%esp)
80101196:	e8 31 08 00 00       	call   801019cc <iunlock>
    return r;
8010119b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010119e:	eb 0c                	jmp    801011ac <fileread+0xba>
  }
  panic("fileread");
801011a0:	c7 04 24 6e 86 10 80 	movl   $0x8010866e,(%esp)
801011a7:	e8 8e f3 ff ff       	call   8010053a <panic>
}
801011ac:	c9                   	leave  
801011ad:	c3                   	ret    

801011ae <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011ae:	55                   	push   %ebp
801011af:	89 e5                	mov    %esp,%ebp
801011b1:	53                   	push   %ebx
801011b2:	83 ec 24             	sub    $0x24,%esp
  int r;

  if(f->writable == 0)
801011b5:	8b 45 08             	mov    0x8(%ebp),%eax
801011b8:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801011bc:	84 c0                	test   %al,%al
801011be:	75 0a                	jne    801011ca <filewrite+0x1c>
    return -1;
801011c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011c5:	e9 23 01 00 00       	jmp    801012ed <filewrite+0x13f>
  if(f->type == FD_PIPE)
801011ca:	8b 45 08             	mov    0x8(%ebp),%eax
801011cd:	8b 00                	mov    (%eax),%eax
801011cf:	83 f8 01             	cmp    $0x1,%eax
801011d2:	75 21                	jne    801011f5 <filewrite+0x47>
    return pipewrite(f->pipe, addr, n);
801011d4:	8b 45 08             	mov    0x8(%ebp),%eax
801011d7:	8b 40 0c             	mov    0xc(%eax),%eax
801011da:	8b 55 10             	mov    0x10(%ebp),%edx
801011dd:	89 54 24 08          	mov    %edx,0x8(%esp)
801011e1:	8b 55 0c             	mov    0xc(%ebp),%edx
801011e4:	89 54 24 04          	mov    %edx,0x4(%esp)
801011e8:	89 04 24             	mov    %eax,(%esp)
801011eb:	e8 e9 2b 00 00       	call   80103dd9 <pipewrite>
801011f0:	e9 f8 00 00 00       	jmp    801012ed <filewrite+0x13f>
  if(f->type == FD_INODE){
801011f5:	8b 45 08             	mov    0x8(%ebp),%eax
801011f8:	8b 00                	mov    (%eax),%eax
801011fa:	83 f8 02             	cmp    $0x2,%eax
801011fd:	0f 85 de 00 00 00    	jne    801012e1 <filewrite+0x133>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
80101203:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
8010120a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    while(i < n){
80101211:	e9 a8 00 00 00       	jmp    801012be <filewrite+0x110>
      int n1 = n - i;
80101216:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101219:	8b 55 10             	mov    0x10(%ebp),%edx
8010121c:	89 d1                	mov    %edx,%ecx
8010121e:	29 c1                	sub    %eax,%ecx
80101220:	89 c8                	mov    %ecx,%eax
80101222:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(n1 > max)
80101225:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101228:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010122b:	7e 06                	jle    80101233 <filewrite+0x85>
        n1 = max;
8010122d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101230:	89 45 f4             	mov    %eax,-0xc(%ebp)

      begin_trans();
80101233:	e8 da 1f 00 00       	call   80103212 <begin_trans>
      ilock(f->ip);
80101238:	8b 45 08             	mov    0x8(%ebp),%eax
8010123b:	8b 40 10             	mov    0x10(%eax),%eax
8010123e:	89 04 24             	mov    %eax,(%esp)
80101241:	e8 35 06 00 00       	call   8010187b <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101246:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101249:	8b 45 08             	mov    0x8(%ebp),%eax
8010124c:	8b 48 14             	mov    0x14(%eax),%ecx
8010124f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101252:	89 c2                	mov    %eax,%edx
80101254:	03 55 0c             	add    0xc(%ebp),%edx
80101257:	8b 45 08             	mov    0x8(%ebp),%eax
8010125a:	8b 40 10             	mov    0x10(%eax),%eax
8010125d:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80101261:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101265:	89 54 24 04          	mov    %edx,0x4(%esp)
80101269:	89 04 24             	mov    %eax,(%esp)
8010126c:	e8 6f 0c 00 00       	call   80101ee0 <writei>
80101271:	89 45 e8             	mov    %eax,-0x18(%ebp)
80101274:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101278:	7e 11                	jle    8010128b <filewrite+0xdd>
        f->off += r;
8010127a:	8b 45 08             	mov    0x8(%ebp),%eax
8010127d:	8b 50 14             	mov    0x14(%eax),%edx
80101280:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101283:	01 c2                	add    %eax,%edx
80101285:	8b 45 08             	mov    0x8(%ebp),%eax
80101288:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
8010128b:	8b 45 08             	mov    0x8(%ebp),%eax
8010128e:	8b 40 10             	mov    0x10(%eax),%eax
80101291:	89 04 24             	mov    %eax,(%esp)
80101294:	e8 33 07 00 00       	call   801019cc <iunlock>
      commit_trans();
80101299:	e8 bd 1f 00 00       	call   8010325b <commit_trans>

      if(r < 0)
8010129e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012a2:	78 28                	js     801012cc <filewrite+0x11e>
        break;
      if(r != n1)
801012a4:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012a7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801012aa:	74 0c                	je     801012b8 <filewrite+0x10a>
        panic("short filewrite");
801012ac:	c7 04 24 77 86 10 80 	movl   $0x80108677,(%esp)
801012b3:	e8 82 f2 ff ff       	call   8010053a <panic>
      i += r;
801012b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012bb:	01 45 f0             	add    %eax,-0x10(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012c1:	3b 45 10             	cmp    0x10(%ebp),%eax
801012c4:	0f 8c 4c ff ff ff    	jl     80101216 <filewrite+0x68>
801012ca:	eb 01                	jmp    801012cd <filewrite+0x11f>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
801012cc:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801012cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801012d0:	3b 45 10             	cmp    0x10(%ebp),%eax
801012d3:	75 05                	jne    801012da <filewrite+0x12c>
801012d5:	8b 45 10             	mov    0x10(%ebp),%eax
801012d8:	eb 05                	jmp    801012df <filewrite+0x131>
801012da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012df:	eb 0c                	jmp    801012ed <filewrite+0x13f>
  }
  panic("filewrite");
801012e1:	c7 04 24 87 86 10 80 	movl   $0x80108687,(%esp)
801012e8:	e8 4d f2 ff ff       	call   8010053a <panic>
}
801012ed:	83 c4 24             	add    $0x24,%esp
801012f0:	5b                   	pop    %ebx
801012f1:	5d                   	pop    %ebp
801012f2:	c3                   	ret    
	...

801012f4 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
801012f4:	55                   	push   %ebp
801012f5:	89 e5                	mov    %esp,%ebp
801012f7:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
801012fa:	8b 45 08             	mov    0x8(%ebp),%eax
801012fd:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101304:	00 
80101305:	89 04 24             	mov    %eax,(%esp)
80101308:	e8 9a ee ff ff       	call   801001a7 <bread>
8010130d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
80101310:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101313:	83 c0 18             	add    $0x18,%eax
80101316:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
8010131d:	00 
8010131e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101322:	8b 45 0c             	mov    0xc(%ebp),%eax
80101325:	89 04 24             	mov    %eax,(%esp)
80101328:	e8 44 3f 00 00       	call   80105271 <memmove>
  brelse(bp);
8010132d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101330:	89 04 24             	mov    %eax,(%esp)
80101333:	e8 e0 ee ff ff       	call   80100218 <brelse>
}
80101338:	c9                   	leave  
80101339:	c3                   	ret    

8010133a <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
8010133a:	55                   	push   %ebp
8010133b:	89 e5                	mov    %esp,%ebp
8010133d:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
80101340:	8b 55 0c             	mov    0xc(%ebp),%edx
80101343:	8b 45 08             	mov    0x8(%ebp),%eax
80101346:	89 54 24 04          	mov    %edx,0x4(%esp)
8010134a:	89 04 24             	mov    %eax,(%esp)
8010134d:	e8 55 ee ff ff       	call   801001a7 <bread>
80101352:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
80101355:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101358:	83 c0 18             	add    $0x18,%eax
8010135b:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101362:	00 
80101363:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010136a:	00 
8010136b:	89 04 24             	mov    %eax,(%esp)
8010136e:	e8 2b 3e 00 00       	call   8010519e <memset>
  log_write(bp);
80101373:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101376:	89 04 24             	mov    %eax,(%esp)
80101379:	e8 35 1f 00 00       	call   801032b3 <log_write>
  brelse(bp);
8010137e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101381:	89 04 24             	mov    %eax,(%esp)
80101384:	e8 8f ee ff ff       	call   80100218 <brelse>
}
80101389:	c9                   	leave  
8010138a:	c3                   	ret    

8010138b <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
8010138b:	55                   	push   %ebp
8010138c:	89 e5                	mov    %esp,%ebp
8010138e:	53                   	push   %ebx
8010138f:	83 ec 34             	sub    $0x34,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
80101392:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  readsb(dev, &sb);
80101399:	8b 45 08             	mov    0x8(%ebp),%eax
8010139c:	8d 55 d8             	lea    -0x28(%ebp),%edx
8010139f:	89 54 24 04          	mov    %edx,0x4(%esp)
801013a3:	89 04 24             	mov    %eax,(%esp)
801013a6:	e8 49 ff ff ff       	call   801012f4 <readsb>
  for(b = 0; b < sb.size; b += BPB){
801013ab:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
801013b2:	e9 15 01 00 00       	jmp    801014cc <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
801013b7:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013ba:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801013c0:	85 c0                	test   %eax,%eax
801013c2:	0f 48 c2             	cmovs  %edx,%eax
801013c5:	c1 f8 0c             	sar    $0xc,%eax
801013c8:	8b 55 e0             	mov    -0x20(%ebp),%edx
801013cb:	c1 ea 03             	shr    $0x3,%edx
801013ce:	01 d0                	add    %edx,%eax
801013d0:	83 c0 03             	add    $0x3,%eax
801013d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801013d7:	8b 45 08             	mov    0x8(%ebp),%eax
801013da:	89 04 24             	mov    %eax,(%esp)
801013dd:	e8 c5 ed ff ff       	call   801001a7 <bread>
801013e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013e5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
801013ec:	e9 aa 00 00 00       	jmp    8010149b <balloc+0x110>
      m = 1 << (bi % 8);
801013f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801013f4:	89 c2                	mov    %eax,%edx
801013f6:	c1 fa 1f             	sar    $0x1f,%edx
801013f9:	c1 ea 1d             	shr    $0x1d,%edx
801013fc:	01 d0                	add    %edx,%eax
801013fe:	83 e0 07             	and    $0x7,%eax
80101401:	29 d0                	sub    %edx,%eax
80101403:	ba 01 00 00 00       	mov    $0x1,%edx
80101408:	89 d3                	mov    %edx,%ebx
8010140a:	89 c1                	mov    %eax,%ecx
8010140c:	d3 e3                	shl    %cl,%ebx
8010140e:	89 d8                	mov    %ebx,%eax
80101410:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101413:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101416:	8d 50 07             	lea    0x7(%eax),%edx
80101419:	85 c0                	test   %eax,%eax
8010141b:	0f 48 c2             	cmovs  %edx,%eax
8010141e:	c1 f8 03             	sar    $0x3,%eax
80101421:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101424:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101429:	0f b6 c0             	movzbl %al,%eax
8010142c:	23 45 f0             	and    -0x10(%ebp),%eax
8010142f:	85 c0                	test   %eax,%eax
80101431:	75 64                	jne    80101497 <balloc+0x10c>
        bp->data[bi/8] |= m;  // Mark block in use.
80101433:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101436:	8d 50 07             	lea    0x7(%eax),%edx
80101439:	85 c0                	test   %eax,%eax
8010143b:	0f 48 c2             	cmovs  %edx,%eax
8010143e:	c1 f8 03             	sar    $0x3,%eax
80101441:	89 c2                	mov    %eax,%edx
80101443:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80101446:	0f b6 44 01 18       	movzbl 0x18(%ecx,%eax,1),%eax
8010144b:	89 c1                	mov    %eax,%ecx
8010144d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101450:	09 c8                	or     %ecx,%eax
80101452:	89 c1                	mov    %eax,%ecx
80101454:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101457:	88 4c 10 18          	mov    %cl,0x18(%eax,%edx,1)
        log_write(bp);
8010145b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010145e:	89 04 24             	mov    %eax,(%esp)
80101461:	e8 4d 1e 00 00       	call   801032b3 <log_write>
        brelse(bp);
80101466:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101469:	89 04 24             	mov    %eax,(%esp)
8010146c:	e8 a7 ed ff ff       	call   80100218 <brelse>
        bzero(dev, b + bi);
80101471:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101474:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101477:	01 c2                	add    %eax,%edx
80101479:	8b 45 08             	mov    0x8(%ebp),%eax
8010147c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101480:	89 04 24             	mov    %eax,(%esp)
80101483:	e8 b2 fe ff ff       	call   8010133a <bzero>
        return b + bi;
80101488:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010148b:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010148e:	8d 04 02             	lea    (%edx,%eax,1),%eax
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
80101491:	83 c4 34             	add    $0x34,%esp
80101494:	5b                   	pop    %ebx
80101495:	5d                   	pop    %ebp
80101496:	c3                   	ret    

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101497:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010149b:	81 7d ec ff 0f 00 00 	cmpl   $0xfff,-0x14(%ebp)
801014a2:	7f 16                	jg     801014ba <balloc+0x12f>
801014a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801014a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014aa:	8d 04 02             	lea    (%edx,%eax,1),%eax
801014ad:	89 c2                	mov    %eax,%edx
801014af:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014b2:	39 c2                	cmp    %eax,%edx
801014b4:	0f 82 37 ff ff ff    	jb     801013f1 <balloc+0x66>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014bd:	89 04 24             	mov    %eax,(%esp)
801014c0:	e8 53 ed ff ff       	call   80100218 <brelse>
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
801014c5:	81 45 e8 00 10 00 00 	addl   $0x1000,-0x18(%ebp)
801014cc:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014cf:	8b 45 d8             	mov    -0x28(%ebp),%eax
801014d2:	39 c2                	cmp    %eax,%edx
801014d4:	0f 82 dd fe ff ff    	jb     801013b7 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
801014da:	c7 04 24 91 86 10 80 	movl   $0x80108691,(%esp)
801014e1:	e8 54 f0 ff ff       	call   8010053a <panic>

801014e6 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801014e6:	55                   	push   %ebp
801014e7:	89 e5                	mov    %esp,%ebp
801014e9:	53                   	push   %ebx
801014ea:	83 ec 34             	sub    $0x34,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
801014ed:	8d 45 dc             	lea    -0x24(%ebp),%eax
801014f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801014f4:	8b 45 08             	mov    0x8(%ebp),%eax
801014f7:	89 04 24             	mov    %eax,(%esp)
801014fa:	e8 f5 fd ff ff       	call   801012f4 <readsb>
  bp = bread(dev, BBLOCK(b, sb.ninodes));
801014ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80101502:	89 c2                	mov    %eax,%edx
80101504:	c1 ea 0c             	shr    $0xc,%edx
80101507:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010150a:	c1 e8 03             	shr    $0x3,%eax
8010150d:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101510:	8d 50 03             	lea    0x3(%eax),%edx
80101513:	8b 45 08             	mov    0x8(%ebp),%eax
80101516:	89 54 24 04          	mov    %edx,0x4(%esp)
8010151a:	89 04 24             	mov    %eax,(%esp)
8010151d:	e8 85 ec ff ff       	call   801001a7 <bread>
80101522:	89 45 ec             	mov    %eax,-0x14(%ebp)
  bi = b % BPB;
80101525:	8b 45 0c             	mov    0xc(%ebp),%eax
80101528:	25 ff 0f 00 00       	and    $0xfff,%eax
8010152d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101530:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101533:	89 c2                	mov    %eax,%edx
80101535:	c1 fa 1f             	sar    $0x1f,%edx
80101538:	c1 ea 1d             	shr    $0x1d,%edx
8010153b:	01 d0                	add    %edx,%eax
8010153d:	83 e0 07             	and    $0x7,%eax
80101540:	29 d0                	sub    %edx,%eax
80101542:	ba 01 00 00 00       	mov    $0x1,%edx
80101547:	89 d3                	mov    %edx,%ebx
80101549:	89 c1                	mov    %eax,%ecx
8010154b:	d3 e3                	shl    %cl,%ebx
8010154d:	89 d8                	mov    %ebx,%eax
8010154f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101552:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101555:	8d 50 07             	lea    0x7(%eax),%edx
80101558:	85 c0                	test   %eax,%eax
8010155a:	0f 48 c2             	cmovs  %edx,%eax
8010155d:	c1 f8 03             	sar    $0x3,%eax
80101560:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101563:	0f b6 44 02 18       	movzbl 0x18(%edx,%eax,1),%eax
80101568:	0f b6 c0             	movzbl %al,%eax
8010156b:	23 45 f4             	and    -0xc(%ebp),%eax
8010156e:	85 c0                	test   %eax,%eax
80101570:	75 0c                	jne    8010157e <bfree+0x98>
    panic("freeing free block");
80101572:	c7 04 24 a7 86 10 80 	movl   $0x801086a7,(%esp)
80101579:	e8 bc ef ff ff       	call   8010053a <panic>
  bp->data[bi/8] &= ~m;
8010157e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101581:	8d 50 07             	lea    0x7(%eax),%edx
80101584:	85 c0                	test   %eax,%eax
80101586:	0f 48 c2             	cmovs  %edx,%eax
80101589:	c1 f8 03             	sar    $0x3,%eax
8010158c:	89 c2                	mov    %eax,%edx
8010158e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80101591:	0f b6 44 01 18       	movzbl 0x18(%ecx,%eax,1),%eax
80101596:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80101599:	f7 d1                	not    %ecx
8010159b:	21 c8                	and    %ecx,%eax
8010159d:	89 c1                	mov    %eax,%ecx
8010159f:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015a2:	88 4c 10 18          	mov    %cl,0x18(%eax,%edx,1)
  log_write(bp);
801015a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015a9:	89 04 24             	mov    %eax,(%esp)
801015ac:	e8 02 1d 00 00       	call   801032b3 <log_write>
  brelse(bp);
801015b1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801015b4:	89 04 24             	mov    %eax,(%esp)
801015b7:	e8 5c ec ff ff       	call   80100218 <brelse>
}
801015bc:	83 c4 34             	add    $0x34,%esp
801015bf:	5b                   	pop    %ebx
801015c0:	5d                   	pop    %ebp
801015c1:	c3                   	ret    

801015c2 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
801015c2:	55                   	push   %ebp
801015c3:	89 e5                	mov    %esp,%ebp
801015c5:	83 ec 18             	sub    $0x18,%esp
  initlock(&icache.lock, "icache");
801015c8:	c7 44 24 04 ba 86 10 	movl   $0x801086ba,0x4(%esp)
801015cf:	80 
801015d0:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801015d7:	e8 52 39 00 00       	call   80104f2e <initlock>
}
801015dc:	c9                   	leave  
801015dd:	c3                   	ret    

801015de <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801015de:	55                   	push   %ebp
801015df:	89 e5                	mov    %esp,%ebp
801015e1:	83 ec 48             	sub    $0x48,%esp
801015e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801015e7:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
801015eb:	8b 45 08             	mov    0x8(%ebp),%eax
801015ee:	8d 55 dc             	lea    -0x24(%ebp),%edx
801015f1:	89 54 24 04          	mov    %edx,0x4(%esp)
801015f5:	89 04 24             	mov    %eax,(%esp)
801015f8:	e8 f7 fc ff ff       	call   801012f4 <readsb>

  for(inum = 1; inum < sb.ninodes; inum++){
801015fd:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
80101604:	e9 98 00 00 00       	jmp    801016a1 <ialloc+0xc3>
    bp = bread(dev, IBLOCK(inum));
80101609:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010160c:	c1 e8 03             	shr    $0x3,%eax
8010160f:	83 c0 02             	add    $0x2,%eax
80101612:	89 44 24 04          	mov    %eax,0x4(%esp)
80101616:	8b 45 08             	mov    0x8(%ebp),%eax
80101619:	89 04 24             	mov    %eax,(%esp)
8010161c:	e8 86 eb ff ff       	call   801001a7 <bread>
80101621:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101624:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101627:	83 c0 18             	add    $0x18,%eax
8010162a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010162d:	83 e2 07             	and    $0x7,%edx
80101630:	c1 e2 06             	shl    $0x6,%edx
80101633:	01 d0                	add    %edx,%eax
80101635:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(dip->type == 0){  // a free inode
80101638:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010163b:	0f b7 00             	movzwl (%eax),%eax
8010163e:	66 85 c0             	test   %ax,%ax
80101641:	75 4f                	jne    80101692 <ialloc+0xb4>
      memset(dip, 0, sizeof(*dip));
80101643:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010164a:	00 
8010164b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80101652:	00 
80101653:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101656:	89 04 24             	mov    %eax,(%esp)
80101659:	e8 40 3b 00 00       	call   8010519e <memset>
      dip->type = type;
8010165e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101661:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
80101665:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
80101668:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010166b:	89 04 24             	mov    %eax,(%esp)
8010166e:	e8 40 1c 00 00       	call   801032b3 <log_write>
      brelse(bp);
80101673:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101676:	89 04 24             	mov    %eax,(%esp)
80101679:	e8 9a eb ff ff       	call   80100218 <brelse>
      return iget(dev, inum);
8010167e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101681:	89 44 24 04          	mov    %eax,0x4(%esp)
80101685:	8b 45 08             	mov    0x8(%ebp),%eax
80101688:	89 04 24             	mov    %eax,(%esp)
8010168b:	e8 e6 00 00 00       	call   80101776 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101690:	c9                   	leave  
80101691:	c3                   	ret    
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101692:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101695:	89 04 24             	mov    %eax,(%esp)
80101698:	e8 7b eb ff ff       	call   80100218 <brelse>
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
8010169d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801016a1:	8b 55 ec             	mov    -0x14(%ebp),%edx
801016a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801016a7:	39 c2                	cmp    %eax,%edx
801016a9:	0f 82 5a ff ff ff    	jb     80101609 <ialloc+0x2b>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801016af:	c7 04 24 c1 86 10 80 	movl   $0x801086c1,(%esp)
801016b6:	e8 7f ee ff ff       	call   8010053a <panic>

801016bb <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801016bb:	55                   	push   %ebp
801016bc:	89 e5                	mov    %esp,%ebp
801016be:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
801016c1:	8b 45 08             	mov    0x8(%ebp),%eax
801016c4:	8b 40 04             	mov    0x4(%eax),%eax
801016c7:	c1 e8 03             	shr    $0x3,%eax
801016ca:	8d 50 02             	lea    0x2(%eax),%edx
801016cd:	8b 45 08             	mov    0x8(%ebp),%eax
801016d0:	8b 00                	mov    (%eax),%eax
801016d2:	89 54 24 04          	mov    %edx,0x4(%esp)
801016d6:	89 04 24             	mov    %eax,(%esp)
801016d9:	e8 c9 ea ff ff       	call   801001a7 <bread>
801016de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801016e4:	83 c0 18             	add    $0x18,%eax
801016e7:	89 c2                	mov    %eax,%edx
801016e9:	8b 45 08             	mov    0x8(%ebp),%eax
801016ec:	8b 40 04             	mov    0x4(%eax),%eax
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 04 02             	lea    (%edx,%eax,1),%eax
801016f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip->type = ip->type;
801016fb:	8b 45 08             	mov    0x8(%ebp),%eax
801016fe:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101702:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101705:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101708:	8b 45 08             	mov    0x8(%ebp),%eax
8010170b:	0f b7 50 12          	movzwl 0x12(%eax),%edx
8010170f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101712:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101716:	8b 45 08             	mov    0x8(%ebp),%eax
80101719:	0f b7 50 14          	movzwl 0x14(%eax),%edx
8010171d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101720:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
80101724:	8b 45 08             	mov    0x8(%ebp),%eax
80101727:	0f b7 50 16          	movzwl 0x16(%eax),%edx
8010172b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010172e:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101732:	8b 45 08             	mov    0x8(%ebp),%eax
80101735:	8b 50 18             	mov    0x18(%eax),%edx
80101738:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010173b:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010173e:	8b 45 08             	mov    0x8(%ebp),%eax
80101741:	8d 50 1c             	lea    0x1c(%eax),%edx
80101744:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101747:	83 c0 0c             	add    $0xc,%eax
8010174a:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101751:	00 
80101752:	89 54 24 04          	mov    %edx,0x4(%esp)
80101756:	89 04 24             	mov    %eax,(%esp)
80101759:	e8 13 3b 00 00       	call   80105271 <memmove>
  log_write(bp);
8010175e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101761:	89 04 24             	mov    %eax,(%esp)
80101764:	e8 4a 1b 00 00       	call   801032b3 <log_write>
  brelse(bp);
80101769:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010176c:	89 04 24             	mov    %eax,(%esp)
8010176f:	e8 a4 ea ff ff       	call   80100218 <brelse>
}
80101774:	c9                   	leave  
80101775:	c3                   	ret    

80101776 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101776:	55                   	push   %ebp
80101777:	89 e5                	mov    %esp,%ebp
80101779:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010177c:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101783:	e8 c7 37 00 00       	call   80104f4f <acquire>

  // Is the inode already cached?
  empty = 0;
80101788:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010178f:	c7 45 f0 b4 e8 10 80 	movl   $0x8010e8b4,-0x10(%ebp)
80101796:	eb 59                	jmp    801017f1 <iget+0x7b>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101798:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010179b:	8b 40 08             	mov    0x8(%eax),%eax
8010179e:	85 c0                	test   %eax,%eax
801017a0:	7e 35                	jle    801017d7 <iget+0x61>
801017a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a5:	8b 00                	mov    (%eax),%eax
801017a7:	3b 45 08             	cmp    0x8(%ebp),%eax
801017aa:	75 2b                	jne    801017d7 <iget+0x61>
801017ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017af:	8b 40 04             	mov    0x4(%eax),%eax
801017b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
801017b5:	75 20                	jne    801017d7 <iget+0x61>
      ip->ref++;
801017b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ba:	8b 40 08             	mov    0x8(%eax),%eax
801017bd:	8d 50 01             	lea    0x1(%eax),%edx
801017c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017c3:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
801017c6:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801017cd:	e8 de 37 00 00       	call   80104fb0 <release>
      return ip;
801017d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017d5:	eb 70                	jmp    80101847 <iget+0xd1>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801017d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801017db:	75 10                	jne    801017ed <iget+0x77>
801017dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017e0:	8b 40 08             	mov    0x8(%eax),%eax
801017e3:	85 c0                	test   %eax,%eax
801017e5:	75 06                	jne    801017ed <iget+0x77>
      empty = ip;
801017e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ea:	89 45 f4             	mov    %eax,-0xc(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017ed:	83 45 f0 50          	addl   $0x50,-0x10(%ebp)
801017f1:	b8 54 f8 10 80       	mov    $0x8010f854,%eax
801017f6:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801017f9:	72 9d                	jb     80101798 <iget+0x22>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801017fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801017ff:	75 0c                	jne    8010180d <iget+0x97>
    panic("iget: no inodes");
80101801:	c7 04 24 d3 86 10 80 	movl   $0x801086d3,(%esp)
80101808:	e8 2d ed ff ff       	call   8010053a <panic>

  ip = empty;
8010180d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101810:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ip->dev = dev;
80101813:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101816:	8b 55 08             	mov    0x8(%ebp),%edx
80101819:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010181b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010181e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101821:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101824:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101827:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010182e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101831:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
80101838:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
8010183f:	e8 6c 37 00 00       	call   80104fb0 <release>

  return ip;
80101844:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80101847:	c9                   	leave  
80101848:	c3                   	ret    

80101849 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101849:	55                   	push   %ebp
8010184a:	89 e5                	mov    %esp,%ebp
8010184c:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
8010184f:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101856:	e8 f4 36 00 00       	call   80104f4f <acquire>
  ip->ref++;
8010185b:	8b 45 08             	mov    0x8(%ebp),%eax
8010185e:	8b 40 08             	mov    0x8(%eax),%eax
80101861:	8d 50 01             	lea    0x1(%eax),%edx
80101864:	8b 45 08             	mov    0x8(%ebp),%eax
80101867:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
8010186a:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101871:	e8 3a 37 00 00       	call   80104fb0 <release>
  return ip;
80101876:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101879:	c9                   	leave  
8010187a:	c3                   	ret    

8010187b <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
8010187b:	55                   	push   %ebp
8010187c:	89 e5                	mov    %esp,%ebp
8010187e:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101881:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101885:	74 0a                	je     80101891 <ilock+0x16>
80101887:	8b 45 08             	mov    0x8(%ebp),%eax
8010188a:	8b 40 08             	mov    0x8(%eax),%eax
8010188d:	85 c0                	test   %eax,%eax
8010188f:	7f 0c                	jg     8010189d <ilock+0x22>
    panic("ilock");
80101891:	c7 04 24 e3 86 10 80 	movl   $0x801086e3,(%esp)
80101898:	e8 9d ec ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
8010189d:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801018a4:	e8 a6 36 00 00       	call   80104f4f <acquire>
  while(ip->flags & I_BUSY)
801018a9:	eb 13                	jmp    801018be <ilock+0x43>
    sleep(ip, &icache.lock);
801018ab:	c7 44 24 04 80 e8 10 	movl   $0x8010e880,0x4(%esp)
801018b2:	80 
801018b3:	8b 45 08             	mov    0x8(%ebp),%eax
801018b6:	89 04 24             	mov    %eax,(%esp)
801018b9:	e8 18 33 00 00       	call   80104bd6 <sleep>

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
801018be:	8b 45 08             	mov    0x8(%ebp),%eax
801018c1:	8b 40 0c             	mov    0xc(%eax),%eax
801018c4:	83 e0 01             	and    $0x1,%eax
801018c7:	84 c0                	test   %al,%al
801018c9:	75 e0                	jne    801018ab <ilock+0x30>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
801018cb:	8b 45 08             	mov    0x8(%ebp),%eax
801018ce:	8b 40 0c             	mov    0xc(%eax),%eax
801018d1:	89 c2                	mov    %eax,%edx
801018d3:	83 ca 01             	or     $0x1,%edx
801018d6:	8b 45 08             	mov    0x8(%ebp),%eax
801018d9:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
801018dc:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
801018e3:	e8 c8 36 00 00       	call   80104fb0 <release>

  if(!(ip->flags & I_VALID)){
801018e8:	8b 45 08             	mov    0x8(%ebp),%eax
801018eb:	8b 40 0c             	mov    0xc(%eax),%eax
801018ee:	83 e0 02             	and    $0x2,%eax
801018f1:	85 c0                	test   %eax,%eax
801018f3:	0f 85 d1 00 00 00    	jne    801019ca <ilock+0x14f>
    bp = bread(ip->dev, IBLOCK(ip->inum));
801018f9:	8b 45 08             	mov    0x8(%ebp),%eax
801018fc:	8b 40 04             	mov    0x4(%eax),%eax
801018ff:	c1 e8 03             	shr    $0x3,%eax
80101902:	8d 50 02             	lea    0x2(%eax),%edx
80101905:	8b 45 08             	mov    0x8(%ebp),%eax
80101908:	8b 00                	mov    (%eax),%eax
8010190a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010190e:	89 04 24             	mov    %eax,(%esp)
80101911:	e8 91 e8 ff ff       	call   801001a7 <bread>
80101916:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101919:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010191c:	83 c0 18             	add    $0x18,%eax
8010191f:	89 c2                	mov    %eax,%edx
80101921:	8b 45 08             	mov    0x8(%ebp),%eax
80101924:	8b 40 04             	mov    0x4(%eax),%eax
80101927:	83 e0 07             	and    $0x7,%eax
8010192a:	c1 e0 06             	shl    $0x6,%eax
8010192d:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101930:	89 45 f4             	mov    %eax,-0xc(%ebp)
    ip->type = dip->type;
80101933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101936:	0f b7 10             	movzwl (%eax),%edx
80101939:	8b 45 08             	mov    0x8(%ebp),%eax
8010193c:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
80101940:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101943:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101947:	8b 45 08             	mov    0x8(%ebp),%eax
8010194a:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
8010194e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101951:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101955:	8b 45 08             	mov    0x8(%ebp),%eax
80101958:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
8010195c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010195f:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101963:	8b 45 08             	mov    0x8(%ebp),%eax
80101966:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
8010196a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010196d:	8b 50 08             	mov    0x8(%eax),%edx
80101970:	8b 45 08             	mov    0x8(%ebp),%eax
80101973:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101976:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101979:	8d 50 0c             	lea    0xc(%eax),%edx
8010197c:	8b 45 08             	mov    0x8(%ebp),%eax
8010197f:	83 c0 1c             	add    $0x1c,%eax
80101982:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101989:	00 
8010198a:	89 54 24 04          	mov    %edx,0x4(%esp)
8010198e:	89 04 24             	mov    %eax,(%esp)
80101991:	e8 db 38 00 00       	call   80105271 <memmove>
    brelse(bp);
80101996:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101999:	89 04 24             	mov    %eax,(%esp)
8010199c:	e8 77 e8 ff ff       	call   80100218 <brelse>
    ip->flags |= I_VALID;
801019a1:	8b 45 08             	mov    0x8(%ebp),%eax
801019a4:	8b 40 0c             	mov    0xc(%eax),%eax
801019a7:	89 c2                	mov    %eax,%edx
801019a9:	83 ca 02             	or     $0x2,%edx
801019ac:	8b 45 08             	mov    0x8(%ebp),%eax
801019af:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
801019b2:	8b 45 08             	mov    0x8(%ebp),%eax
801019b5:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801019b9:	66 85 c0             	test   %ax,%ax
801019bc:	75 0c                	jne    801019ca <ilock+0x14f>
      panic("ilock: no type");
801019be:	c7 04 24 e9 86 10 80 	movl   $0x801086e9,(%esp)
801019c5:	e8 70 eb ff ff       	call   8010053a <panic>
  }
}
801019ca:	c9                   	leave  
801019cb:	c3                   	ret    

801019cc <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801019cc:	55                   	push   %ebp
801019cd:	89 e5                	mov    %esp,%ebp
801019cf:	83 ec 18             	sub    $0x18,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
801019d2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801019d6:	74 17                	je     801019ef <iunlock+0x23>
801019d8:	8b 45 08             	mov    0x8(%ebp),%eax
801019db:	8b 40 0c             	mov    0xc(%eax),%eax
801019de:	83 e0 01             	and    $0x1,%eax
801019e1:	85 c0                	test   %eax,%eax
801019e3:	74 0a                	je     801019ef <iunlock+0x23>
801019e5:	8b 45 08             	mov    0x8(%ebp),%eax
801019e8:	8b 40 08             	mov    0x8(%eax),%eax
801019eb:	85 c0                	test   %eax,%eax
801019ed:	7f 0c                	jg     801019fb <iunlock+0x2f>
    panic("iunlock");
801019ef:	c7 04 24 f8 86 10 80 	movl   $0x801086f8,(%esp)
801019f6:	e8 3f eb ff ff       	call   8010053a <panic>

  acquire(&icache.lock);
801019fb:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a02:	e8 48 35 00 00       	call   80104f4f <acquire>
  ip->flags &= ~I_BUSY;
80101a07:	8b 45 08             	mov    0x8(%ebp),%eax
80101a0a:	8b 40 0c             	mov    0xc(%eax),%eax
80101a0d:	89 c2                	mov    %eax,%edx
80101a0f:	83 e2 fe             	and    $0xfffffffe,%edx
80101a12:	8b 45 08             	mov    0x8(%ebp),%eax
80101a15:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101a18:	8b 45 08             	mov    0x8(%ebp),%eax
80101a1b:	89 04 24             	mov    %eax,(%esp)
80101a1e:	e8 f9 32 00 00       	call   80104d1c <wakeup>
  release(&icache.lock);
80101a23:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a2a:	e8 81 35 00 00       	call   80104fb0 <release>
}
80101a2f:	c9                   	leave  
80101a30:	c3                   	ret    

80101a31 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101a31:	55                   	push   %ebp
80101a32:	89 e5                	mov    %esp,%ebp
80101a34:	83 ec 18             	sub    $0x18,%esp
  acquire(&icache.lock);
80101a37:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101a3e:	e8 0c 35 00 00       	call   80104f4f <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101a43:	8b 45 08             	mov    0x8(%ebp),%eax
80101a46:	8b 40 08             	mov    0x8(%eax),%eax
80101a49:	83 f8 01             	cmp    $0x1,%eax
80101a4c:	0f 85 93 00 00 00    	jne    80101ae5 <iput+0xb4>
80101a52:	8b 45 08             	mov    0x8(%ebp),%eax
80101a55:	8b 40 0c             	mov    0xc(%eax),%eax
80101a58:	83 e0 02             	and    $0x2,%eax
80101a5b:	85 c0                	test   %eax,%eax
80101a5d:	0f 84 82 00 00 00    	je     80101ae5 <iput+0xb4>
80101a63:	8b 45 08             	mov    0x8(%ebp),%eax
80101a66:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101a6a:	66 85 c0             	test   %ax,%ax
80101a6d:	75 76                	jne    80101ae5 <iput+0xb4>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a72:	8b 40 0c             	mov    0xc(%eax),%eax
80101a75:	83 e0 01             	and    $0x1,%eax
80101a78:	84 c0                	test   %al,%al
80101a7a:	74 0c                	je     80101a88 <iput+0x57>
      panic("iput busy");
80101a7c:	c7 04 24 00 87 10 80 	movl   $0x80108700,(%esp)
80101a83:	e8 b2 ea ff ff       	call   8010053a <panic>
    ip->flags |= I_BUSY;
80101a88:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8b:	8b 40 0c             	mov    0xc(%eax),%eax
80101a8e:	89 c2                	mov    %eax,%edx
80101a90:	83 ca 01             	or     $0x1,%edx
80101a93:	8b 45 08             	mov    0x8(%ebp),%eax
80101a96:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101a99:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101aa0:	e8 0b 35 00 00       	call   80104fb0 <release>
    itrunc(ip);
80101aa5:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa8:	89 04 24             	mov    %eax,(%esp)
80101aab:	e8 72 01 00 00       	call   80101c22 <itrunc>
    ip->type = 0;
80101ab0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab3:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101ab9:	8b 45 08             	mov    0x8(%ebp),%eax
80101abc:	89 04 24             	mov    %eax,(%esp)
80101abf:	e8 f7 fb ff ff       	call   801016bb <iupdate>
    acquire(&icache.lock);
80101ac4:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101acb:	e8 7f 34 00 00       	call   80104f4f <acquire>
    ip->flags = 0;
80101ad0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ad3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101ada:	8b 45 08             	mov    0x8(%ebp),%eax
80101add:	89 04 24             	mov    %eax,(%esp)
80101ae0:	e8 37 32 00 00       	call   80104d1c <wakeup>
  }
  ip->ref--;
80101ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae8:	8b 40 08             	mov    0x8(%eax),%eax
80101aeb:	8d 50 ff             	lea    -0x1(%eax),%edx
80101aee:	8b 45 08             	mov    0x8(%ebp),%eax
80101af1:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101af4:	c7 04 24 80 e8 10 80 	movl   $0x8010e880,(%esp)
80101afb:	e8 b0 34 00 00       	call   80104fb0 <release>
}
80101b00:	c9                   	leave  
80101b01:	c3                   	ret    

80101b02 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101b02:	55                   	push   %ebp
80101b03:	89 e5                	mov    %esp,%ebp
80101b05:	83 ec 18             	sub    $0x18,%esp
  iunlock(ip);
80101b08:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0b:	89 04 24             	mov    %eax,(%esp)
80101b0e:	e8 b9 fe ff ff       	call   801019cc <iunlock>
  iput(ip);
80101b13:	8b 45 08             	mov    0x8(%ebp),%eax
80101b16:	89 04 24             	mov    %eax,(%esp)
80101b19:	e8 13 ff ff ff       	call   80101a31 <iput>
}
80101b1e:	c9                   	leave  
80101b1f:	c3                   	ret    

80101b20 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	53                   	push   %ebx
80101b24:	83 ec 24             	sub    $0x24,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101b27:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101b2b:	77 3e                	ja     80101b6b <bmap+0x4b>
    if((addr = ip->addrs[bn]) == 0)
80101b2d:	8b 55 0c             	mov    0xc(%ebp),%edx
80101b30:	8b 45 08             	mov    0x8(%ebp),%eax
80101b33:	83 c2 04             	add    $0x4,%edx
80101b36:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101b3a:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b3d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101b41:	75 20                	jne    80101b63 <bmap+0x43>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101b43:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80101b46:	8b 45 08             	mov    0x8(%ebp),%eax
80101b49:	8b 00                	mov    (%eax),%eax
80101b4b:	89 04 24             	mov    %eax,(%esp)
80101b4e:	e8 38 f8 ff ff       	call   8010138b <balloc>
80101b53:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b56:	8b 45 08             	mov    0x8(%ebp),%eax
80101b59:	8d 4b 04             	lea    0x4(%ebx),%ecx
80101b5c:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b5f:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101b63:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101b66:	e9 b1 00 00 00       	jmp    80101c1c <bmap+0xfc>
  }
  bn -= NDIRECT;
80101b6b:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101b6f:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101b73:	0f 87 97 00 00 00    	ja     80101c10 <bmap+0xf0>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101b79:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7c:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b7f:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b82:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101b86:	75 19                	jne    80101ba1 <bmap+0x81>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101b88:	8b 45 08             	mov    0x8(%ebp),%eax
80101b8b:	8b 00                	mov    (%eax),%eax
80101b8d:	89 04 24             	mov    %eax,(%esp)
80101b90:	e8 f6 f7 ff ff       	call   8010138b <balloc>
80101b95:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101b98:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9b:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101b9e:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101ba1:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba4:	8b 00                	mov    (%eax),%eax
80101ba6:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101ba9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101bad:	89 04 24             	mov    %eax,(%esp)
80101bb0:	e8 f2 e5 ff ff       	call   801001a7 <bread>
80101bb5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    a = (uint*)bp->data;
80101bb8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bbb:	83 c0 18             	add    $0x18,%eax
80101bbe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((addr = a[bn]) == 0){
80101bc1:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bc4:	c1 e0 02             	shl    $0x2,%eax
80101bc7:	03 45 f0             	add    -0x10(%ebp),%eax
80101bca:	8b 00                	mov    (%eax),%eax
80101bcc:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101bcf:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80101bd3:	75 2b                	jne    80101c00 <bmap+0xe0>
      a[bn] = addr = balloc(ip->dev);
80101bd5:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bd8:	c1 e0 02             	shl    $0x2,%eax
80101bdb:	89 c3                	mov    %eax,%ebx
80101bdd:	03 5d f0             	add    -0x10(%ebp),%ebx
80101be0:	8b 45 08             	mov    0x8(%ebp),%eax
80101be3:	8b 00                	mov    (%eax),%eax
80101be5:	89 04 24             	mov    %eax,(%esp)
80101be8:	e8 9e f7 ff ff       	call   8010138b <balloc>
80101bed:	89 45 ec             	mov    %eax,-0x14(%ebp)
80101bf0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101bf3:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101bf5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101bf8:	89 04 24             	mov    %eax,(%esp)
80101bfb:	e8 b3 16 00 00       	call   801032b3 <log_write>
    }
    brelse(bp);
80101c00:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c03:	89 04 24             	mov    %eax,(%esp)
80101c06:	e8 0d e6 ff ff       	call   80100218 <brelse>
    return addr;
80101c0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c0e:	eb 0c                	jmp    80101c1c <bmap+0xfc>
  }

  panic("bmap: out of range");
80101c10:	c7 04 24 0a 87 10 80 	movl   $0x8010870a,(%esp)
80101c17:	e8 1e e9 ff ff       	call   8010053a <panic>
}
80101c1c:	83 c4 24             	add    $0x24,%esp
80101c1f:	5b                   	pop    %ebx
80101c20:	5d                   	pop    %ebp
80101c21:	c3                   	ret    

80101c22 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101c22:	55                   	push   %ebp
80101c23:	89 e5                	mov    %esp,%ebp
80101c25:	83 ec 28             	sub    $0x28,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c28:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
80101c2f:	eb 44                	jmp    80101c75 <itrunc+0x53>
    if(ip->addrs[i]){
80101c31:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c34:	8b 45 08             	mov    0x8(%ebp),%eax
80101c37:	83 c2 04             	add    $0x4,%edx
80101c3a:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c3e:	85 c0                	test   %eax,%eax
80101c40:	74 2f                	je     80101c71 <itrunc+0x4f>
      bfree(ip->dev, ip->addrs[i]);
80101c42:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c45:	8b 45 08             	mov    0x8(%ebp),%eax
80101c48:	83 c2 04             	add    $0x4,%edx
80101c4b:	8b 54 90 0c          	mov    0xc(%eax,%edx,4),%edx
80101c4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c52:	8b 00                	mov    (%eax),%eax
80101c54:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c58:	89 04 24             	mov    %eax,(%esp)
80101c5b:	e8 86 f8 ff ff       	call   801014e6 <bfree>
      ip->addrs[i] = 0;
80101c60:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101c63:	8b 45 08             	mov    0x8(%ebp),%eax
80101c66:	83 c2 04             	add    $0x4,%edx
80101c69:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101c70:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101c71:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
80101c75:	83 7d e8 0b          	cmpl   $0xb,-0x18(%ebp)
80101c79:	7e b6                	jle    80101c31 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101c7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7e:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c81:	85 c0                	test   %eax,%eax
80101c83:	0f 84 8f 00 00 00    	je     80101d18 <itrunc+0xf6>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c89:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8c:	8b 50 4c             	mov    0x4c(%eax),%edx
80101c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c92:	8b 00                	mov    (%eax),%eax
80101c94:	89 54 24 04          	mov    %edx,0x4(%esp)
80101c98:	89 04 24             	mov    %eax,(%esp)
80101c9b:	e8 07 e5 ff ff       	call   801001a7 <bread>
80101ca0:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101ca3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ca6:	83 c0 18             	add    $0x18,%eax
80101ca9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101cac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101cb3:	eb 2f                	jmp    80101ce4 <itrunc+0xc2>
      if(a[j])
80101cb5:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cb8:	c1 e0 02             	shl    $0x2,%eax
80101cbb:	03 45 f4             	add    -0xc(%ebp),%eax
80101cbe:	8b 00                	mov    (%eax),%eax
80101cc0:	85 c0                	test   %eax,%eax
80101cc2:	74 1c                	je     80101ce0 <itrunc+0xbe>
        bfree(ip->dev, a[j]);
80101cc4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101cc7:	c1 e0 02             	shl    $0x2,%eax
80101cca:	03 45 f4             	add    -0xc(%ebp),%eax
80101ccd:	8b 10                	mov    (%eax),%edx
80101ccf:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd2:	8b 00                	mov    (%eax),%eax
80101cd4:	89 54 24 04          	mov    %edx,0x4(%esp)
80101cd8:	89 04 24             	mov    %eax,(%esp)
80101cdb:	e8 06 f8 ff ff       	call   801014e6 <bfree>
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101ce0:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80101ce4:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ce7:	83 f8 7f             	cmp    $0x7f,%eax
80101cea:	76 c9                	jbe    80101cb5 <itrunc+0x93>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101cec:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101cef:	89 04 24             	mov    %eax,(%esp)
80101cf2:	e8 21 e5 ff ff       	call   80100218 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101cf7:	8b 45 08             	mov    0x8(%ebp),%eax
80101cfa:	8b 50 4c             	mov    0x4c(%eax),%edx
80101cfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101d00:	8b 00                	mov    (%eax),%eax
80101d02:	89 54 24 04          	mov    %edx,0x4(%esp)
80101d06:	89 04 24             	mov    %eax,(%esp)
80101d09:	e8 d8 f7 ff ff       	call   801014e6 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d0e:	8b 45 08             	mov    0x8(%ebp),%eax
80101d11:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101d18:	8b 45 08             	mov    0x8(%ebp),%eax
80101d1b:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101d22:	8b 45 08             	mov    0x8(%ebp),%eax
80101d25:	89 04 24             	mov    %eax,(%esp)
80101d28:	e8 8e f9 ff ff       	call   801016bb <iupdate>
}
80101d2d:	c9                   	leave  
80101d2e:	c3                   	ret    

80101d2f <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101d2f:	55                   	push   %ebp
80101d30:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101d32:	8b 45 08             	mov    0x8(%ebp),%eax
80101d35:	8b 00                	mov    (%eax),%eax
80101d37:	89 c2                	mov    %eax,%edx
80101d39:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d3c:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d42:	8b 50 04             	mov    0x4(%eax),%edx
80101d45:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d48:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101d4b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d4e:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101d52:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d55:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101d58:	8b 45 08             	mov    0x8(%ebp),%eax
80101d5b:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101d5f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d62:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101d66:	8b 45 08             	mov    0x8(%ebp),%eax
80101d69:	8b 50 18             	mov    0x18(%eax),%edx
80101d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d6f:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d72:	5d                   	pop    %ebp
80101d73:	c3                   	ret    

80101d74 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d74:	55                   	push   %ebp
80101d75:	89 e5                	mov    %esp,%ebp
80101d77:	53                   	push   %ebx
80101d78:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80101d7e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101d82:	66 83 f8 03          	cmp    $0x3,%ax
80101d86:	75 60                	jne    80101de8 <readi+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d88:	8b 45 08             	mov    0x8(%ebp),%eax
80101d8b:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d8f:	66 85 c0             	test   %ax,%ax
80101d92:	78 20                	js     80101db4 <readi+0x40>
80101d94:	8b 45 08             	mov    0x8(%ebp),%eax
80101d97:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101d9b:	66 83 f8 09          	cmp    $0x9,%ax
80101d9f:	7f 13                	jg     80101db4 <readi+0x40>
80101da1:	8b 45 08             	mov    0x8(%ebp),%eax
80101da4:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101da8:	98                   	cwtl   
80101da9:	8b 04 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%eax
80101db0:	85 c0                	test   %eax,%eax
80101db2:	75 0a                	jne    80101dbe <readi+0x4a>
      return -1;
80101db4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101db9:	e9 1c 01 00 00       	jmp    80101eda <readi+0x166>
    return devsw[ip->major].read(ip, dst, n);
80101dbe:	8b 45 08             	mov    0x8(%ebp),%eax
80101dc1:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101dc5:	98                   	cwtl   
80101dc6:	8b 14 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%edx
80101dcd:	8b 45 14             	mov    0x14(%ebp),%eax
80101dd0:	89 44 24 08          	mov    %eax,0x8(%esp)
80101dd4:	8b 45 0c             	mov    0xc(%ebp),%eax
80101dd7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dde:	89 04 24             	mov    %eax,(%esp)
80101de1:	ff d2                	call   *%edx
80101de3:	e9 f2 00 00 00       	jmp    80101eda <readi+0x166>
  }

  if(off > ip->size || off + n < off)
80101de8:	8b 45 08             	mov    0x8(%ebp),%eax
80101deb:	8b 40 18             	mov    0x18(%eax),%eax
80101dee:	3b 45 10             	cmp    0x10(%ebp),%eax
80101df1:	72 0e                	jb     80101e01 <readi+0x8d>
80101df3:	8b 45 14             	mov    0x14(%ebp),%eax
80101df6:	8b 55 10             	mov    0x10(%ebp),%edx
80101df9:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101dfc:	3b 45 10             	cmp    0x10(%ebp),%eax
80101dff:	73 0a                	jae    80101e0b <readi+0x97>
    return -1;
80101e01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e06:	e9 cf 00 00 00       	jmp    80101eda <readi+0x166>
  if(off + n > ip->size)
80101e0b:	8b 45 14             	mov    0x14(%ebp),%eax
80101e0e:	8b 55 10             	mov    0x10(%ebp),%edx
80101e11:	01 c2                	add    %eax,%edx
80101e13:	8b 45 08             	mov    0x8(%ebp),%eax
80101e16:	8b 40 18             	mov    0x18(%eax),%eax
80101e19:	39 c2                	cmp    %eax,%edx
80101e1b:	76 0c                	jbe    80101e29 <readi+0xb5>
    n = ip->size - off;
80101e1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e20:	8b 40 18             	mov    0x18(%eax),%eax
80101e23:	2b 45 10             	sub    0x10(%ebp),%eax
80101e26:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e29:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101e30:	e9 96 00 00 00       	jmp    80101ecb <readi+0x157>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e35:	8b 45 10             	mov    0x10(%ebp),%eax
80101e38:	c1 e8 09             	shr    $0x9,%eax
80101e3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e3f:	8b 45 08             	mov    0x8(%ebp),%eax
80101e42:	89 04 24             	mov    %eax,(%esp)
80101e45:	e8 d6 fc ff ff       	call   80101b20 <bmap>
80101e4a:	8b 55 08             	mov    0x8(%ebp),%edx
80101e4d:	8b 12                	mov    (%edx),%edx
80101e4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e53:	89 14 24             	mov    %edx,(%esp)
80101e56:	e8 4c e3 ff ff       	call   801001a7 <bread>
80101e5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101e5e:	8b 45 10             	mov    0x10(%ebp),%eax
80101e61:	89 c2                	mov    %eax,%edx
80101e63:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101e69:	b8 00 02 00 00       	mov    $0x200,%eax
80101e6e:	89 c1                	mov    %eax,%ecx
80101e70:	29 d1                	sub    %edx,%ecx
80101e72:	89 ca                	mov    %ecx,%edx
80101e74:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e77:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101e7a:	89 cb                	mov    %ecx,%ebx
80101e7c:	29 c3                	sub    %eax,%ebx
80101e7e:	89 d8                	mov    %ebx,%eax
80101e80:	39 c2                	cmp    %eax,%edx
80101e82:	0f 46 c2             	cmovbe %edx,%eax
80101e85:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101e88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101e8b:	8d 50 18             	lea    0x18(%eax),%edx
80101e8e:	8b 45 10             	mov    0x10(%ebp),%eax
80101e91:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e96:	01 c2                	add    %eax,%edx
80101e98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e9b:	89 44 24 08          	mov    %eax,0x8(%esp)
80101e9f:	89 54 24 04          	mov    %edx,0x4(%esp)
80101ea3:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ea6:	89 04 24             	mov    %eax,(%esp)
80101ea9:	e8 c3 33 00 00       	call   80105271 <memmove>
    brelse(bp);
80101eae:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101eb1:	89 04 24             	mov    %eax,(%esp)
80101eb4:	e8 5f e3 ff ff       	call   80100218 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eb9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ebc:	01 45 ec             	add    %eax,-0x14(%ebp)
80101ebf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ec2:	01 45 10             	add    %eax,0x10(%ebp)
80101ec5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ec8:	01 45 0c             	add    %eax,0xc(%ebp)
80101ecb:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ece:	3b 45 14             	cmp    0x14(%ebp),%eax
80101ed1:	0f 82 5e ff ff ff    	jb     80101e35 <readi+0xc1>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101ed7:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101eda:	83 c4 24             	add    $0x24,%esp
80101edd:	5b                   	pop    %ebx
80101ede:	5d                   	pop    %ebp
80101edf:	c3                   	ret    

80101ee0 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101ee0:	55                   	push   %ebp
80101ee1:	89 e5                	mov    %esp,%ebp
80101ee3:	53                   	push   %ebx
80101ee4:	83 ec 24             	sub    $0x24,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ee7:	8b 45 08             	mov    0x8(%ebp),%eax
80101eea:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101eee:	66 83 f8 03          	cmp    $0x3,%ax
80101ef2:	75 60                	jne    80101f54 <writei+0x74>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ef7:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101efb:	66 85 c0             	test   %ax,%ax
80101efe:	78 20                	js     80101f20 <writei+0x40>
80101f00:	8b 45 08             	mov    0x8(%ebp),%eax
80101f03:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f07:	66 83 f8 09          	cmp    $0x9,%ax
80101f0b:	7f 13                	jg     80101f20 <writei+0x40>
80101f0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f10:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f14:	98                   	cwtl   
80101f15:	8b 04 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%eax
80101f1c:	85 c0                	test   %eax,%eax
80101f1e:	75 0a                	jne    80101f2a <writei+0x4a>
      return -1;
80101f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f25:	e9 48 01 00 00       	jmp    80102072 <writei+0x192>
    return devsw[ip->major].write(ip, src, n);
80101f2a:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2d:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101f31:	98                   	cwtl   
80101f32:	8b 14 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%edx
80101f39:	8b 45 14             	mov    0x14(%ebp),%eax
80101f3c:	89 44 24 08          	mov    %eax,0x8(%esp)
80101f40:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f43:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f47:	8b 45 08             	mov    0x8(%ebp),%eax
80101f4a:	89 04 24             	mov    %eax,(%esp)
80101f4d:	ff d2                	call   *%edx
80101f4f:	e9 1e 01 00 00       	jmp    80102072 <writei+0x192>
  }

  if(off > ip->size || off + n < off)
80101f54:	8b 45 08             	mov    0x8(%ebp),%eax
80101f57:	8b 40 18             	mov    0x18(%eax),%eax
80101f5a:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f5d:	72 0e                	jb     80101f6d <writei+0x8d>
80101f5f:	8b 45 14             	mov    0x14(%ebp),%eax
80101f62:	8b 55 10             	mov    0x10(%ebp),%edx
80101f65:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101f68:	3b 45 10             	cmp    0x10(%ebp),%eax
80101f6b:	73 0a                	jae    80101f77 <writei+0x97>
    return -1;
80101f6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f72:	e9 fb 00 00 00       	jmp    80102072 <writei+0x192>
  if(off + n > MAXFILE*BSIZE)
80101f77:	8b 45 14             	mov    0x14(%ebp),%eax
80101f7a:	8b 55 10             	mov    0x10(%ebp),%edx
80101f7d:	8d 04 02             	lea    (%edx,%eax,1),%eax
80101f80:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f85:	76 0a                	jbe    80101f91 <writei+0xb1>
    return -1;
80101f87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f8c:	e9 e1 00 00 00       	jmp    80102072 <writei+0x192>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f91:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80101f98:	e9 a1 00 00 00       	jmp    8010203e <writei+0x15e>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f9d:	8b 45 10             	mov    0x10(%ebp),%eax
80101fa0:	c1 e8 09             	shr    $0x9,%eax
80101fa3:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80101faa:	89 04 24             	mov    %eax,(%esp)
80101fad:	e8 6e fb ff ff       	call   80101b20 <bmap>
80101fb2:	8b 55 08             	mov    0x8(%ebp),%edx
80101fb5:	8b 12                	mov    (%edx),%edx
80101fb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fbb:	89 14 24             	mov    %edx,(%esp)
80101fbe:	e8 e4 e1 ff ff       	call   801001a7 <bread>
80101fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fc6:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc9:	89 c2                	mov    %eax,%edx
80101fcb:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101fd1:	b8 00 02 00 00       	mov    $0x200,%eax
80101fd6:	89 c1                	mov    %eax,%ecx
80101fd8:	29 d1                	sub    %edx,%ecx
80101fda:	89 ca                	mov    %ecx,%edx
80101fdc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fdf:	8b 4d 14             	mov    0x14(%ebp),%ecx
80101fe2:	89 cb                	mov    %ecx,%ebx
80101fe4:	29 c3                	sub    %eax,%ebx
80101fe6:	89 d8                	mov    %ebx,%eax
80101fe8:	39 c2                	cmp    %eax,%edx
80101fea:	0f 46 c2             	cmovbe %edx,%eax
80101fed:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80101ff0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ff3:	8d 50 18             	lea    0x18(%eax),%edx
80101ff6:	8b 45 10             	mov    0x10(%ebp),%eax
80101ff9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ffe:	01 c2                	add    %eax,%edx
80102000:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102003:	89 44 24 08          	mov    %eax,0x8(%esp)
80102007:	8b 45 0c             	mov    0xc(%ebp),%eax
8010200a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010200e:	89 14 24             	mov    %edx,(%esp)
80102011:	e8 5b 32 00 00       	call   80105271 <memmove>
    log_write(bp);
80102016:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102019:	89 04 24             	mov    %eax,(%esp)
8010201c:	e8 92 12 00 00       	call   801032b3 <log_write>
    brelse(bp);
80102021:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102024:	89 04 24             	mov    %eax,(%esp)
80102027:	e8 ec e1 ff ff       	call   80100218 <brelse>
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
8010202c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010202f:	01 45 ec             	add    %eax,-0x14(%ebp)
80102032:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102035:	01 45 10             	add    %eax,0x10(%ebp)
80102038:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010203b:	01 45 0c             	add    %eax,0xc(%ebp)
8010203e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102041:	3b 45 14             	cmp    0x14(%ebp),%eax
80102044:	0f 82 53 ff ff ff    	jb     80101f9d <writei+0xbd>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
8010204a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010204e:	74 1f                	je     8010206f <writei+0x18f>
80102050:	8b 45 08             	mov    0x8(%ebp),%eax
80102053:	8b 40 18             	mov    0x18(%eax),%eax
80102056:	3b 45 10             	cmp    0x10(%ebp),%eax
80102059:	73 14                	jae    8010206f <writei+0x18f>
    ip->size = off;
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
8010205e:	8b 55 10             	mov    0x10(%ebp),%edx
80102061:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
80102064:	8b 45 08             	mov    0x8(%ebp),%eax
80102067:	89 04 24             	mov    %eax,(%esp)
8010206a:	e8 4c f6 ff ff       	call   801016bb <iupdate>
  }
  return n;
8010206f:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102072:	83 c4 24             	add    $0x24,%esp
80102075:	5b                   	pop    %ebx
80102076:	5d                   	pop    %ebp
80102077:	c3                   	ret    

80102078 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102078:	55                   	push   %ebp
80102079:	89 e5                	mov    %esp,%ebp
8010207b:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
8010207e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102085:	00 
80102086:	8b 45 0c             	mov    0xc(%ebp),%eax
80102089:	89 44 24 04          	mov    %eax,0x4(%esp)
8010208d:	8b 45 08             	mov    0x8(%ebp),%eax
80102090:	89 04 24             	mov    %eax,(%esp)
80102093:	e8 81 32 00 00       	call   80105319 <strncmp>
}
80102098:	c9                   	leave  
80102099:	c3                   	ret    

8010209a <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
8010209a:	55                   	push   %ebp
8010209b:	89 e5                	mov    %esp,%ebp
8010209d:	83 ec 38             	sub    $0x38,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801020a0:	8b 45 08             	mov    0x8(%ebp),%eax
801020a3:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801020a7:	66 83 f8 01          	cmp    $0x1,%ax
801020ab:	74 0c                	je     801020b9 <dirlookup+0x1f>
    panic("dirlookup not DIR");
801020ad:	c7 04 24 1d 87 10 80 	movl   $0x8010871d,(%esp)
801020b4:	e8 81 e4 ff ff       	call   8010053a <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
801020b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801020c0:	e9 87 00 00 00       	jmp    8010214c <dirlookup+0xb2>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c5:	8d 45 e0             	lea    -0x20(%ebp),%eax
801020c8:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801020cf:	00 
801020d0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801020d3:	89 54 24 08          	mov    %edx,0x8(%esp)
801020d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801020db:	8b 45 08             	mov    0x8(%ebp),%eax
801020de:	89 04 24             	mov    %eax,(%esp)
801020e1:	e8 8e fc ff ff       	call   80101d74 <readi>
801020e6:	83 f8 10             	cmp    $0x10,%eax
801020e9:	74 0c                	je     801020f7 <dirlookup+0x5d>
      panic("dirlink read");
801020eb:	c7 04 24 2f 87 10 80 	movl   $0x8010872f,(%esp)
801020f2:	e8 43 e4 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801020f7:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801020fb:	66 85 c0             	test   %ax,%ax
801020fe:	74 47                	je     80102147 <dirlookup+0xad>
      continue;
    if(namecmp(name, de.name) == 0){
80102100:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102103:	83 c0 02             	add    $0x2,%eax
80102106:	89 44 24 04          	mov    %eax,0x4(%esp)
8010210a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010210d:	89 04 24             	mov    %eax,(%esp)
80102110:	e8 63 ff ff ff       	call   80102078 <namecmp>
80102115:	85 c0                	test   %eax,%eax
80102117:	75 2f                	jne    80102148 <dirlookup+0xae>
      // entry matches path element
      if(poff)
80102119:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010211d:	74 08                	je     80102127 <dirlookup+0x8d>
        *poff = off;
8010211f:	8b 45 10             	mov    0x10(%ebp),%eax
80102122:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102125:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
80102127:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010212b:	0f b7 c0             	movzwl %ax,%eax
8010212e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return iget(dp->dev, inum);
80102131:	8b 45 08             	mov    0x8(%ebp),%eax
80102134:	8b 00                	mov    (%eax),%eax
80102136:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102139:	89 54 24 04          	mov    %edx,0x4(%esp)
8010213d:	89 04 24             	mov    %eax,(%esp)
80102140:	e8 31 f6 ff ff       	call   80101776 <iget>
80102145:	eb 19                	jmp    80102160 <dirlookup+0xc6>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
80102147:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102148:	83 45 f0 10          	addl   $0x10,-0x10(%ebp)
8010214c:	8b 45 08             	mov    0x8(%ebp),%eax
8010214f:	8b 40 18             	mov    0x18(%eax),%eax
80102152:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102155:	0f 87 6a ff ff ff    	ja     801020c5 <dirlookup+0x2b>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010215b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102160:	c9                   	leave  
80102161:	c3                   	ret    

80102162 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102162:	55                   	push   %ebp
80102163:	89 e5                	mov    %esp,%ebp
80102165:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102168:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010216f:	00 
80102170:	8b 45 0c             	mov    0xc(%ebp),%eax
80102173:	89 44 24 04          	mov    %eax,0x4(%esp)
80102177:	8b 45 08             	mov    0x8(%ebp),%eax
8010217a:	89 04 24             	mov    %eax,(%esp)
8010217d:	e8 18 ff ff ff       	call   8010209a <dirlookup>
80102182:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102185:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102189:	74 15                	je     801021a0 <dirlink+0x3e>
    iput(ip);
8010218b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010218e:	89 04 24             	mov    %eax,(%esp)
80102191:	e8 9b f8 ff ff       	call   80101a31 <iput>
    return -1;
80102196:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010219b:	e9 b8 00 00 00       	jmp    80102258 <dirlink+0xf6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801021a7:	eb 44                	jmp    801021ed <dirlink+0x8b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021ac:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021af:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801021b6:	00 
801021b7:	89 54 24 08          	mov    %edx,0x8(%esp)
801021bb:	89 44 24 04          	mov    %eax,0x4(%esp)
801021bf:	8b 45 08             	mov    0x8(%ebp),%eax
801021c2:	89 04 24             	mov    %eax,(%esp)
801021c5:	e8 aa fb ff ff       	call   80101d74 <readi>
801021ca:	83 f8 10             	cmp    $0x10,%eax
801021cd:	74 0c                	je     801021db <dirlink+0x79>
      panic("dirlink read");
801021cf:	c7 04 24 2f 87 10 80 	movl   $0x8010872f,(%esp)
801021d6:	e8 5f e3 ff ff       	call   8010053a <panic>
    if(de.inum == 0)
801021db:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021df:	66 85 c0             	test   %ax,%ax
801021e2:	74 18                	je     801021fc <dirlink+0x9a>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801021e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801021e7:	83 c0 10             	add    $0x10,%eax
801021ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
801021ed:	8b 55 f0             	mov    -0x10(%ebp),%edx
801021f0:	8b 45 08             	mov    0x8(%ebp),%eax
801021f3:	8b 40 18             	mov    0x18(%eax),%eax
801021f6:	39 c2                	cmp    %eax,%edx
801021f8:	72 af                	jb     801021a9 <dirlink+0x47>
801021fa:	eb 01                	jmp    801021fd <dirlink+0x9b>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
801021fc:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
801021fd:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80102204:	00 
80102205:	8b 45 0c             	mov    0xc(%ebp),%eax
80102208:	89 44 24 04          	mov    %eax,0x4(%esp)
8010220c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010220f:	83 c0 02             	add    $0x2,%eax
80102212:	89 04 24             	mov    %eax,(%esp)
80102215:	e8 57 31 00 00       	call   80105371 <strncpy>
  de.inum = inum;
8010221a:	8b 45 10             	mov    0x10(%ebp),%eax
8010221d:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102221:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102224:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102227:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
8010222e:	00 
8010222f:	89 54 24 08          	mov    %edx,0x8(%esp)
80102233:	89 44 24 04          	mov    %eax,0x4(%esp)
80102237:	8b 45 08             	mov    0x8(%ebp),%eax
8010223a:	89 04 24             	mov    %eax,(%esp)
8010223d:	e8 9e fc ff ff       	call   80101ee0 <writei>
80102242:	83 f8 10             	cmp    $0x10,%eax
80102245:	74 0c                	je     80102253 <dirlink+0xf1>
    panic("dirlink");
80102247:	c7 04 24 3c 87 10 80 	movl   $0x8010873c,(%esp)
8010224e:	e8 e7 e2 ff ff       	call   8010053a <panic>
  
  return 0;
80102253:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102258:	c9                   	leave  
80102259:	c3                   	ret    

8010225a <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010225a:	55                   	push   %ebp
8010225b:	89 e5                	mov    %esp,%ebp
8010225d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int len;

  while(*path == '/')
80102260:	eb 04                	jmp    80102266 <skipelem+0xc>
    path++;
80102262:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80102266:	8b 45 08             	mov    0x8(%ebp),%eax
80102269:	0f b6 00             	movzbl (%eax),%eax
8010226c:	3c 2f                	cmp    $0x2f,%al
8010226e:	74 f2                	je     80102262 <skipelem+0x8>
    path++;
  if(*path == 0)
80102270:	8b 45 08             	mov    0x8(%ebp),%eax
80102273:	0f b6 00             	movzbl (%eax),%eax
80102276:	84 c0                	test   %al,%al
80102278:	75 0a                	jne    80102284 <skipelem+0x2a>
    return 0;
8010227a:	b8 00 00 00 00       	mov    $0x0,%eax
8010227f:	e9 86 00 00 00       	jmp    8010230a <skipelem+0xb0>
  s = path;
80102284:	8b 45 08             	mov    0x8(%ebp),%eax
80102287:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while(*path != '/' && *path != 0)
8010228a:	eb 04                	jmp    80102290 <skipelem+0x36>
    path++;
8010228c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80102290:	8b 45 08             	mov    0x8(%ebp),%eax
80102293:	0f b6 00             	movzbl (%eax),%eax
80102296:	3c 2f                	cmp    $0x2f,%al
80102298:	74 0a                	je     801022a4 <skipelem+0x4a>
8010229a:	8b 45 08             	mov    0x8(%ebp),%eax
8010229d:	0f b6 00             	movzbl (%eax),%eax
801022a0:	84 c0                	test   %al,%al
801022a2:	75 e8                	jne    8010228c <skipelem+0x32>
    path++;
  len = path - s;
801022a4:	8b 55 08             	mov    0x8(%ebp),%edx
801022a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022aa:	89 d1                	mov    %edx,%ecx
801022ac:	29 c1                	sub    %eax,%ecx
801022ae:	89 c8                	mov    %ecx,%eax
801022b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(len >= DIRSIZ)
801022b3:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801022b7:	7e 1c                	jle    801022d5 <skipelem+0x7b>
    memmove(name, s, DIRSIZ);
801022b9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
801022c0:	00 
801022c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801022c8:	8b 45 0c             	mov    0xc(%ebp),%eax
801022cb:	89 04 24             	mov    %eax,(%esp)
801022ce:	e8 9e 2f 00 00       	call   80105271 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022d3:	eb 28                	jmp    801022fd <skipelem+0xa3>
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
801022d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022d8:	89 44 24 08          	mov    %eax,0x8(%esp)
801022dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801022df:	89 44 24 04          	mov    %eax,0x4(%esp)
801022e3:	8b 45 0c             	mov    0xc(%ebp),%eax
801022e6:	89 04 24             	mov    %eax,(%esp)
801022e9:	e8 83 2f 00 00       	call   80105271 <memmove>
    name[len] = 0;
801022ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022f1:	03 45 0c             	add    0xc(%ebp),%eax
801022f4:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
801022f7:	eb 04                	jmp    801022fd <skipelem+0xa3>
    path++;
801022f9:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
801022fd:	8b 45 08             	mov    0x8(%ebp),%eax
80102300:	0f b6 00             	movzbl (%eax),%eax
80102303:	3c 2f                	cmp    $0x2f,%al
80102305:	74 f2                	je     801022f9 <skipelem+0x9f>
    path++;
  return path;
80102307:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010230a:	c9                   	leave  
8010230b:	c3                   	ret    

8010230c <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010230c:	55                   	push   %ebp
8010230d:	89 e5                	mov    %esp,%ebp
8010230f:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102312:	8b 45 08             	mov    0x8(%ebp),%eax
80102315:	0f b6 00             	movzbl (%eax),%eax
80102318:	3c 2f                	cmp    $0x2f,%al
8010231a:	75 1c                	jne    80102338 <namex+0x2c>
    ip = iget(ROOTDEV, ROOTINO);
8010231c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102323:	00 
80102324:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010232b:	e8 46 f4 ff ff       	call   80101776 <iget>
80102330:	89 45 f0             	mov    %eax,-0x10(%ebp)
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102333:	e9 af 00 00 00       	jmp    801023e7 <namex+0xdb>
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80102338:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010233e:	8b 40 68             	mov    0x68(%eax),%eax
80102341:	89 04 24             	mov    %eax,(%esp)
80102344:	e8 00 f5 ff ff       	call   80101849 <idup>
80102349:	89 45 f0             	mov    %eax,-0x10(%ebp)

  while((path = skipelem(path, name)) != 0){
8010234c:	e9 96 00 00 00       	jmp    801023e7 <namex+0xdb>
    ilock(ip);
80102351:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102354:	89 04 24             	mov    %eax,(%esp)
80102357:	e8 1f f5 ff ff       	call   8010187b <ilock>
    if(ip->type != T_DIR){
8010235c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010235f:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102363:	66 83 f8 01          	cmp    $0x1,%ax
80102367:	74 15                	je     8010237e <namex+0x72>
      iunlockput(ip);
80102369:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010236c:	89 04 24             	mov    %eax,(%esp)
8010236f:	e8 8e f7 ff ff       	call   80101b02 <iunlockput>
      return 0;
80102374:	b8 00 00 00 00       	mov    $0x0,%eax
80102379:	e9 a3 00 00 00       	jmp    80102421 <namex+0x115>
    }
    if(nameiparent && *path == '\0'){
8010237e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102382:	74 1d                	je     801023a1 <namex+0x95>
80102384:	8b 45 08             	mov    0x8(%ebp),%eax
80102387:	0f b6 00             	movzbl (%eax),%eax
8010238a:	84 c0                	test   %al,%al
8010238c:	75 13                	jne    801023a1 <namex+0x95>
      // Stop one level early.
      iunlock(ip);
8010238e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80102391:	89 04 24             	mov    %eax,(%esp)
80102394:	e8 33 f6 ff ff       	call   801019cc <iunlock>
      return ip;
80102399:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010239c:	e9 80 00 00 00       	jmp    80102421 <namex+0x115>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801023a1:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801023a8:	00 
801023a9:	8b 45 10             	mov    0x10(%ebp),%eax
801023ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801023b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023b3:	89 04 24             	mov    %eax,(%esp)
801023b6:	e8 df fc ff ff       	call   8010209a <dirlookup>
801023bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801023c2:	75 12                	jne    801023d6 <namex+0xca>
      iunlockput(ip);
801023c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023c7:	89 04 24             	mov    %eax,(%esp)
801023ca:	e8 33 f7 ff ff       	call   80101b02 <iunlockput>
      return 0;
801023cf:	b8 00 00 00 00       	mov    $0x0,%eax
801023d4:	eb 4b                	jmp    80102421 <namex+0x115>
    }
    iunlockput(ip);
801023d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023d9:	89 04 24             	mov    %eax,(%esp)
801023dc:	e8 21 f7 ff ff       	call   80101b02 <iunlockput>
    ip = next;
801023e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
801023e7:	8b 45 10             	mov    0x10(%ebp),%eax
801023ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801023ee:	8b 45 08             	mov    0x8(%ebp),%eax
801023f1:	89 04 24             	mov    %eax,(%esp)
801023f4:	e8 61 fe ff ff       	call   8010225a <skipelem>
801023f9:	89 45 08             	mov    %eax,0x8(%ebp)
801023fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102400:	0f 85 4b ff ff ff    	jne    80102351 <namex+0x45>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102406:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010240a:	74 12                	je     8010241e <namex+0x112>
    iput(ip);
8010240c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010240f:	89 04 24             	mov    %eax,(%esp)
80102412:	e8 1a f6 ff ff       	call   80101a31 <iput>
    return 0;
80102417:	b8 00 00 00 00       	mov    $0x0,%eax
8010241c:	eb 03                	jmp    80102421 <namex+0x115>
  }
  return ip;
8010241e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80102421:	c9                   	leave  
80102422:	c3                   	ret    

80102423 <namei>:

struct inode*
namei(char *path)
{
80102423:	55                   	push   %ebp
80102424:	89 e5                	mov    %esp,%ebp
80102426:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102429:	8d 45 ea             	lea    -0x16(%ebp),%eax
8010242c:	89 44 24 08          	mov    %eax,0x8(%esp)
80102430:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102437:	00 
80102438:	8b 45 08             	mov    0x8(%ebp),%eax
8010243b:	89 04 24             	mov    %eax,(%esp)
8010243e:	e8 c9 fe ff ff       	call   8010230c <namex>
}
80102443:	c9                   	leave  
80102444:	c3                   	ret    

80102445 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102445:	55                   	push   %ebp
80102446:	89 e5                	mov    %esp,%ebp
80102448:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 1, name);
8010244b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010244e:	89 44 24 08          	mov    %eax,0x8(%esp)
80102452:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102459:	00 
8010245a:	8b 45 08             	mov    0x8(%ebp),%eax
8010245d:	89 04 24             	mov    %eax,(%esp)
80102460:	e8 a7 fe ff ff       	call   8010230c <namex>
}
80102465:	c9                   	leave  
80102466:	c3                   	ret    
	...

80102468 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102468:	55                   	push   %ebp
80102469:	89 e5                	mov    %esp,%ebp
8010246b:	83 ec 14             	sub    $0x14,%esp
8010246e:	8b 45 08             	mov    0x8(%ebp),%eax
80102471:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102475:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102479:	89 c2                	mov    %eax,%edx
8010247b:	ec                   	in     (%dx),%al
8010247c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010247f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102483:	c9                   	leave  
80102484:	c3                   	ret    

80102485 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102485:	55                   	push   %ebp
80102486:	89 e5                	mov    %esp,%ebp
80102488:	57                   	push   %edi
80102489:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
8010248a:	8b 55 08             	mov    0x8(%ebp),%edx
8010248d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102490:	8b 45 10             	mov    0x10(%ebp),%eax
80102493:	89 cb                	mov    %ecx,%ebx
80102495:	89 df                	mov    %ebx,%edi
80102497:	89 c1                	mov    %eax,%ecx
80102499:	fc                   	cld    
8010249a:	f3 6d                	rep insl (%dx),%es:(%edi)
8010249c:	89 c8                	mov    %ecx,%eax
8010249e:	89 fb                	mov    %edi,%ebx
801024a0:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024a3:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
801024a6:	5b                   	pop    %ebx
801024a7:	5f                   	pop    %edi
801024a8:	5d                   	pop    %ebp
801024a9:	c3                   	ret    

801024aa <outb>:

static inline void
outb(ushort port, uchar data)
{
801024aa:	55                   	push   %ebp
801024ab:	89 e5                	mov    %esp,%ebp
801024ad:	83 ec 08             	sub    $0x8,%esp
801024b0:	8b 55 08             	mov    0x8(%ebp),%edx
801024b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801024b6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801024ba:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801024bd:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801024c1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801024c5:	ee                   	out    %al,(%dx)
}
801024c6:	c9                   	leave  
801024c7:	c3                   	ret    

801024c8 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
801024c8:	55                   	push   %ebp
801024c9:	89 e5                	mov    %esp,%ebp
801024cb:	56                   	push   %esi
801024cc:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801024cd:	8b 55 08             	mov    0x8(%ebp),%edx
801024d0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801024d3:	8b 45 10             	mov    0x10(%ebp),%eax
801024d6:	89 cb                	mov    %ecx,%ebx
801024d8:	89 de                	mov    %ebx,%esi
801024da:	89 c1                	mov    %eax,%ecx
801024dc:	fc                   	cld    
801024dd:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801024df:	89 c8                	mov    %ecx,%eax
801024e1:	89 f3                	mov    %esi,%ebx
801024e3:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801024e6:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
801024e9:	5b                   	pop    %ebx
801024ea:	5e                   	pop    %esi
801024eb:	5d                   	pop    %ebp
801024ec:	c3                   	ret    

801024ed <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
801024ed:	55                   	push   %ebp
801024ee:	89 e5                	mov    %esp,%ebp
801024f0:	83 ec 14             	sub    $0x14,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
801024f3:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801024fa:	e8 69 ff ff ff       	call   80102468 <inb>
801024ff:	0f b6 c0             	movzbl %al,%eax
80102502:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102505:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102508:	25 c0 00 00 00       	and    $0xc0,%eax
8010250d:	83 f8 40             	cmp    $0x40,%eax
80102510:	75 e1                	jne    801024f3 <idewait+0x6>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102512:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102516:	74 11                	je     80102529 <idewait+0x3c>
80102518:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010251b:	83 e0 21             	and    $0x21,%eax
8010251e:	85 c0                	test   %eax,%eax
80102520:	74 07                	je     80102529 <idewait+0x3c>
    return -1;
80102522:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102527:	eb 05                	jmp    8010252e <idewait+0x41>
  return 0;
80102529:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010252e:	c9                   	leave  
8010252f:	c3                   	ret    

80102530 <ideinit>:

void
ideinit(void)
{
80102530:	55                   	push   %ebp
80102531:	89 e5                	mov    %esp,%ebp
80102533:	83 ec 28             	sub    $0x28,%esp
  int i;

  initlock(&idelock, "ide");
80102536:	c7 44 24 04 44 87 10 	movl   $0x80108744,0x4(%esp)
8010253d:	80 
8010253e:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102545:	e8 e4 29 00 00       	call   80104f2e <initlock>
  picenable(IRQ_IDE);
8010254a:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102551:	e8 37 15 00 00       	call   80103a8d <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102556:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
8010255b:	83 e8 01             	sub    $0x1,%eax
8010255e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102562:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102569:	e8 10 04 00 00       	call   8010297e <ioapicenable>
  idewait(0);
8010256e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102575:	e8 73 ff ff ff       	call   801024ed <idewait>
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
8010257a:	c7 44 24 04 f0 00 00 	movl   $0xf0,0x4(%esp)
80102581:	00 
80102582:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
80102589:	e8 1c ff ff ff       	call   801024aa <outb>
  for(i=0; i<1000; i++){
8010258e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102595:	eb 20                	jmp    801025b7 <ideinit+0x87>
    if(inb(0x1f7) != 0){
80102597:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
8010259e:	e8 c5 fe ff ff       	call   80102468 <inb>
801025a3:	84 c0                	test   %al,%al
801025a5:	74 0c                	je     801025b3 <ideinit+0x83>
      havedisk1 = 1;
801025a7:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
801025ae:	00 00 00 
      break;
801025b1:	eb 0d                	jmp    801025c0 <ideinit+0x90>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
801025b3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801025b7:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801025be:	7e d7                	jle    80102597 <ideinit+0x67>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801025c0:	c7 44 24 04 e0 00 00 	movl   $0xe0,0x4(%esp)
801025c7:	00 
801025c8:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801025cf:	e8 d6 fe ff ff       	call   801024aa <outb>
}
801025d4:	c9                   	leave  
801025d5:	c3                   	ret    

801025d6 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025d6:	55                   	push   %ebp
801025d7:	89 e5                	mov    %esp,%ebp
801025d9:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801025dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801025e0:	75 0c                	jne    801025ee <idestart+0x18>
    panic("idestart");
801025e2:	c7 04 24 48 87 10 80 	movl   $0x80108748,(%esp)
801025e9:	e8 4c df ff ff       	call   8010053a <panic>

  idewait(0);
801025ee:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801025f5:	e8 f3 fe ff ff       	call   801024ed <idewait>
  outb(0x3f6, 0);  // generate interrupt
801025fa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102601:	00 
80102602:	c7 04 24 f6 03 00 00 	movl   $0x3f6,(%esp)
80102609:	e8 9c fe ff ff       	call   801024aa <outb>
  outb(0x1f2, 1);  // number of sectors
8010260e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102615:	00 
80102616:	c7 04 24 f2 01 00 00 	movl   $0x1f2,(%esp)
8010261d:	e8 88 fe ff ff       	call   801024aa <outb>
  outb(0x1f3, b->sector & 0xff);
80102622:	8b 45 08             	mov    0x8(%ebp),%eax
80102625:	8b 40 08             	mov    0x8(%eax),%eax
80102628:	0f b6 c0             	movzbl %al,%eax
8010262b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010262f:	c7 04 24 f3 01 00 00 	movl   $0x1f3,(%esp)
80102636:	e8 6f fe ff ff       	call   801024aa <outb>
  outb(0x1f4, (b->sector >> 8) & 0xff);
8010263b:	8b 45 08             	mov    0x8(%ebp),%eax
8010263e:	8b 40 08             	mov    0x8(%eax),%eax
80102641:	c1 e8 08             	shr    $0x8,%eax
80102644:	0f b6 c0             	movzbl %al,%eax
80102647:	89 44 24 04          	mov    %eax,0x4(%esp)
8010264b:	c7 04 24 f4 01 00 00 	movl   $0x1f4,(%esp)
80102652:	e8 53 fe ff ff       	call   801024aa <outb>
  outb(0x1f5, (b->sector >> 16) & 0xff);
80102657:	8b 45 08             	mov    0x8(%ebp),%eax
8010265a:	8b 40 08             	mov    0x8(%eax),%eax
8010265d:	c1 e8 10             	shr    $0x10,%eax
80102660:	0f b6 c0             	movzbl %al,%eax
80102663:	89 44 24 04          	mov    %eax,0x4(%esp)
80102667:	c7 04 24 f5 01 00 00 	movl   $0x1f5,(%esp)
8010266e:	e8 37 fe ff ff       	call   801024aa <outb>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
80102673:	8b 45 08             	mov    0x8(%ebp),%eax
80102676:	8b 40 04             	mov    0x4(%eax),%eax
80102679:	83 e0 01             	and    $0x1,%eax
8010267c:	89 c2                	mov    %eax,%edx
8010267e:	c1 e2 04             	shl    $0x4,%edx
80102681:	8b 45 08             	mov    0x8(%ebp),%eax
80102684:	8b 40 08             	mov    0x8(%eax),%eax
80102687:	c1 e8 18             	shr    $0x18,%eax
8010268a:	83 e0 0f             	and    $0xf,%eax
8010268d:	09 d0                	or     %edx,%eax
8010268f:	83 c8 e0             	or     $0xffffffe0,%eax
80102692:	0f b6 c0             	movzbl %al,%eax
80102695:	89 44 24 04          	mov    %eax,0x4(%esp)
80102699:	c7 04 24 f6 01 00 00 	movl   $0x1f6,(%esp)
801026a0:	e8 05 fe ff ff       	call   801024aa <outb>
  if(b->flags & B_DIRTY){
801026a5:	8b 45 08             	mov    0x8(%ebp),%eax
801026a8:	8b 00                	mov    (%eax),%eax
801026aa:	83 e0 04             	and    $0x4,%eax
801026ad:	85 c0                	test   %eax,%eax
801026af:	74 34                	je     801026e5 <idestart+0x10f>
    outb(0x1f7, IDE_CMD_WRITE);
801026b1:	c7 44 24 04 30 00 00 	movl   $0x30,0x4(%esp)
801026b8:	00 
801026b9:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026c0:	e8 e5 fd ff ff       	call   801024aa <outb>
    outsl(0x1f0, b->data, 512/4);
801026c5:	8b 45 08             	mov    0x8(%ebp),%eax
801026c8:	83 c0 18             	add    $0x18,%eax
801026cb:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801026d2:	00 
801026d3:	89 44 24 04          	mov    %eax,0x4(%esp)
801026d7:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
801026de:	e8 e5 fd ff ff       	call   801024c8 <outsl>
801026e3:	eb 14                	jmp    801026f9 <idestart+0x123>
  } else {
    outb(0x1f7, IDE_CMD_READ);
801026e5:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
801026ec:	00 
801026ed:	c7 04 24 f7 01 00 00 	movl   $0x1f7,(%esp)
801026f4:	e8 b1 fd ff ff       	call   801024aa <outb>
  }
}
801026f9:	c9                   	leave  
801026fa:	c3                   	ret    

801026fb <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026fb:	55                   	push   %ebp
801026fc:	89 e5                	mov    %esp,%ebp
801026fe:	83 ec 28             	sub    $0x28,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102701:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102708:	e8 42 28 00 00       	call   80104f4f <acquire>
  if((b = idequeue) == 0){
8010270d:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102712:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102715:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102719:	75 11                	jne    8010272c <ideintr+0x31>
    release(&idelock);
8010271b:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102722:	e8 89 28 00 00       	call   80104fb0 <release>
    // cprintf("spurious IDE interrupt\n");
    return;
80102727:	e9 90 00 00 00       	jmp    801027bc <ideintr+0xc1>
  }
  idequeue = b->qnext;
8010272c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010272f:	8b 40 14             	mov    0x14(%eax),%eax
80102732:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102737:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010273a:	8b 00                	mov    (%eax),%eax
8010273c:	83 e0 04             	and    $0x4,%eax
8010273f:	85 c0                	test   %eax,%eax
80102741:	75 2e                	jne    80102771 <ideintr+0x76>
80102743:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010274a:	e8 9e fd ff ff       	call   801024ed <idewait>
8010274f:	85 c0                	test   %eax,%eax
80102751:	78 1e                	js     80102771 <ideintr+0x76>
    insl(0x1f0, b->data, 512/4);
80102753:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102756:	83 c0 18             	add    $0x18,%eax
80102759:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80102760:	00 
80102761:	89 44 24 04          	mov    %eax,0x4(%esp)
80102765:	c7 04 24 f0 01 00 00 	movl   $0x1f0,(%esp)
8010276c:	e8 14 fd ff ff       	call   80102485 <insl>
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102771:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102774:	8b 00                	mov    (%eax),%eax
80102776:	89 c2                	mov    %eax,%edx
80102778:	83 ca 02             	or     $0x2,%edx
8010277b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010277e:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102780:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102783:	8b 00                	mov    (%eax),%eax
80102785:	89 c2                	mov    %eax,%edx
80102787:	83 e2 fb             	and    $0xfffffffb,%edx
8010278a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010278d:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010278f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102792:	89 04 24             	mov    %eax,(%esp)
80102795:	e8 82 25 00 00       	call   80104d1c <wakeup>
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010279a:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010279f:	85 c0                	test   %eax,%eax
801027a1:	74 0d                	je     801027b0 <ideintr+0xb5>
    idestart(idequeue);
801027a3:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801027a8:	89 04 24             	mov    %eax,(%esp)
801027ab:	e8 26 fe ff ff       	call   801025d6 <idestart>

  release(&idelock);
801027b0:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
801027b7:	e8 f4 27 00 00       	call   80104fb0 <release>
}
801027bc:	c9                   	leave  
801027bd:	c3                   	ret    

801027be <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801027be:	55                   	push   %ebp
801027bf:	89 e5                	mov    %esp,%ebp
801027c1:	83 ec 28             	sub    $0x28,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
801027c4:	8b 45 08             	mov    0x8(%ebp),%eax
801027c7:	8b 00                	mov    (%eax),%eax
801027c9:	83 e0 01             	and    $0x1,%eax
801027cc:	85 c0                	test   %eax,%eax
801027ce:	75 0c                	jne    801027dc <iderw+0x1e>
    panic("iderw: buf not busy");
801027d0:	c7 04 24 51 87 10 80 	movl   $0x80108751,(%esp)
801027d7:	e8 5e dd ff ff       	call   8010053a <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027dc:	8b 45 08             	mov    0x8(%ebp),%eax
801027df:	8b 00                	mov    (%eax),%eax
801027e1:	83 e0 06             	and    $0x6,%eax
801027e4:	83 f8 02             	cmp    $0x2,%eax
801027e7:	75 0c                	jne    801027f5 <iderw+0x37>
    panic("iderw: nothing to do");
801027e9:	c7 04 24 65 87 10 80 	movl   $0x80108765,(%esp)
801027f0:	e8 45 dd ff ff       	call   8010053a <panic>
  if(b->dev != 0 && !havedisk1)
801027f5:	8b 45 08             	mov    0x8(%ebp),%eax
801027f8:	8b 40 04             	mov    0x4(%eax),%eax
801027fb:	85 c0                	test   %eax,%eax
801027fd:	74 15                	je     80102814 <iderw+0x56>
801027ff:	a1 58 b6 10 80       	mov    0x8010b658,%eax
80102804:	85 c0                	test   %eax,%eax
80102806:	75 0c                	jne    80102814 <iderw+0x56>
    panic("iderw: ide disk 1 not present");
80102808:	c7 04 24 7a 87 10 80 	movl   $0x8010877a,(%esp)
8010280f:	e8 26 dd ff ff       	call   8010053a <panic>

  acquire(&idelock);  //DOC:acquire-lock
80102814:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
8010281b:	e8 2f 27 00 00       	call   80104f4f <acquire>

  // Append b to idequeue.
  b->qnext = 0;
80102820:	8b 45 08             	mov    0x8(%ebp),%eax
80102823:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010282a:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
80102831:	eb 0b                	jmp    8010283e <iderw+0x80>
80102833:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102836:	8b 00                	mov    (%eax),%eax
80102838:	83 c0 14             	add    $0x14,%eax
8010283b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010283e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102841:	8b 00                	mov    (%eax),%eax
80102843:	85 c0                	test   %eax,%eax
80102845:	75 ec                	jne    80102833 <iderw+0x75>
    ;
  *pp = b;
80102847:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010284a:	8b 55 08             	mov    0x8(%ebp),%edx
8010284d:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
8010284f:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102854:	3b 45 08             	cmp    0x8(%ebp),%eax
80102857:	75 22                	jne    8010287b <iderw+0xbd>
    idestart(b);
80102859:	8b 45 08             	mov    0x8(%ebp),%eax
8010285c:	89 04 24             	mov    %eax,(%esp)
8010285f:	e8 72 fd ff ff       	call   801025d6 <idestart>
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102864:	eb 16                	jmp    8010287c <iderw+0xbe>
    sleep(b, &idelock);
80102866:	c7 44 24 04 20 b6 10 	movl   $0x8010b620,0x4(%esp)
8010286d:	80 
8010286e:	8b 45 08             	mov    0x8(%ebp),%eax
80102871:	89 04 24             	mov    %eax,(%esp)
80102874:	e8 5d 23 00 00       	call   80104bd6 <sleep>
80102879:	eb 01                	jmp    8010287c <iderw+0xbe>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010287b:	90                   	nop
8010287c:	8b 45 08             	mov    0x8(%ebp),%eax
8010287f:	8b 00                	mov    (%eax),%eax
80102881:	83 e0 06             	and    $0x6,%eax
80102884:	83 f8 02             	cmp    $0x2,%eax
80102887:	75 dd                	jne    80102866 <iderw+0xa8>
    sleep(b, &idelock);
  }

  release(&idelock);
80102889:	c7 04 24 20 b6 10 80 	movl   $0x8010b620,(%esp)
80102890:	e8 1b 27 00 00       	call   80104fb0 <release>
}
80102895:	c9                   	leave  
80102896:	c3                   	ret    
	...

80102898 <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102898:	55                   	push   %ebp
80102899:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
8010289b:	a1 54 f8 10 80       	mov    0x8010f854,%eax
801028a0:	8b 55 08             	mov    0x8(%ebp),%edx
801028a3:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
801028a5:	a1 54 f8 10 80       	mov    0x8010f854,%eax
801028aa:	8b 40 10             	mov    0x10(%eax),%eax
}
801028ad:	5d                   	pop    %ebp
801028ae:	c3                   	ret    

801028af <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
801028af:	55                   	push   %ebp
801028b0:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
801028b2:	a1 54 f8 10 80       	mov    0x8010f854,%eax
801028b7:	8b 55 08             	mov    0x8(%ebp),%edx
801028ba:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
801028bc:	a1 54 f8 10 80       	mov    0x8010f854,%eax
801028c1:	8b 55 0c             	mov    0xc(%ebp),%edx
801028c4:	89 50 10             	mov    %edx,0x10(%eax)
}
801028c7:	5d                   	pop    %ebp
801028c8:	c3                   	ret    

801028c9 <ioapicinit>:

void
ioapicinit(void)
{
801028c9:	55                   	push   %ebp
801028ca:	89 e5                	mov    %esp,%ebp
801028cc:	83 ec 28             	sub    $0x28,%esp
  int i, id, maxintr;

  if(!ismp)
801028cf:	a1 24 f9 10 80       	mov    0x8010f924,%eax
801028d4:	85 c0                	test   %eax,%eax
801028d6:	0f 84 9f 00 00 00    	je     8010297b <ioapicinit+0xb2>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
801028dc:	c7 05 54 f8 10 80 00 	movl   $0xfec00000,0x8010f854
801028e3:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028e6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801028ed:	e8 a6 ff ff ff       	call   80102898 <ioapicread>
801028f2:	c1 e8 10             	shr    $0x10,%eax
801028f5:	25 ff 00 00 00       	and    $0xff,%eax
801028fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  id = ioapicread(REG_ID) >> 24;
801028fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80102904:	e8 8f ff ff ff       	call   80102898 <ioapicread>
80102909:	c1 e8 18             	shr    $0x18,%eax
8010290c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(id != ioapicid)
8010290f:	0f b6 05 20 f9 10 80 	movzbl 0x8010f920,%eax
80102916:	0f b6 c0             	movzbl %al,%eax
80102919:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010291c:	74 0c                	je     8010292a <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010291e:	c7 04 24 98 87 10 80 	movl   $0x80108798,(%esp)
80102925:	e8 70 da ff ff       	call   8010039a <cprintf>

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010292a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80102931:	eb 3e                	jmp    80102971 <ioapicinit+0xa8>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102933:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102936:	83 c0 20             	add    $0x20,%eax
80102939:	0d 00 00 01 00       	or     $0x10000,%eax
8010293e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80102941:	83 c2 08             	add    $0x8,%edx
80102944:	01 d2                	add    %edx,%edx
80102946:	89 44 24 04          	mov    %eax,0x4(%esp)
8010294a:	89 14 24             	mov    %edx,(%esp)
8010294d:	e8 5d ff ff ff       	call   801028af <ioapicwrite>
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102952:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102955:	83 c0 08             	add    $0x8,%eax
80102958:	01 c0                	add    %eax,%eax
8010295a:	83 c0 01             	add    $0x1,%eax
8010295d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102964:	00 
80102965:	89 04 24             	mov    %eax,(%esp)
80102968:	e8 42 ff ff ff       	call   801028af <ioapicwrite>
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010296d:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80102971:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102974:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102977:	7e ba                	jle    80102933 <ioapicinit+0x6a>
80102979:	eb 01                	jmp    8010297c <ioapicinit+0xb3>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
8010297b:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010297c:	c9                   	leave  
8010297d:	c3                   	ret    

8010297e <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
8010297e:	55                   	push   %ebp
8010297f:	89 e5                	mov    %esp,%ebp
80102981:	83 ec 08             	sub    $0x8,%esp
  if(!ismp)
80102984:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80102989:	85 c0                	test   %eax,%eax
8010298b:	74 39                	je     801029c6 <ioapicenable+0x48>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010298d:	8b 45 08             	mov    0x8(%ebp),%eax
80102990:	83 c0 20             	add    $0x20,%eax
80102993:	8b 55 08             	mov    0x8(%ebp),%edx
80102996:	83 c2 08             	add    $0x8,%edx
80102999:	01 d2                	add    %edx,%edx
8010299b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010299f:	89 14 24             	mov    %edx,(%esp)
801029a2:	e8 08 ff ff ff       	call   801028af <ioapicwrite>
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801029a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801029aa:	c1 e0 18             	shl    $0x18,%eax
801029ad:	8b 55 08             	mov    0x8(%ebp),%edx
801029b0:	83 c2 08             	add    $0x8,%edx
801029b3:	01 d2                	add    %edx,%edx
801029b5:	83 c2 01             	add    $0x1,%edx
801029b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801029bc:	89 14 24             	mov    %edx,(%esp)
801029bf:	e8 eb fe ff ff       	call   801028af <ioapicwrite>
801029c4:	eb 01                	jmp    801029c7 <ioapicenable+0x49>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
801029c6:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801029c7:	c9                   	leave  
801029c8:	c3                   	ret    
801029c9:	00 00                	add    %al,(%eax)
	...

801029cc <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801029cc:	55                   	push   %ebp
801029cd:	89 e5                	mov    %esp,%ebp
801029cf:	8b 45 08             	mov    0x8(%ebp),%eax
801029d2:	2d 00 00 00 80       	sub    $0x80000000,%eax
801029d7:	5d                   	pop    %ebp
801029d8:	c3                   	ret    

801029d9 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
801029d9:	55                   	push   %ebp
801029da:	89 e5                	mov    %esp,%ebp
801029dc:	83 ec 18             	sub    $0x18,%esp
  initlock(&kmem.lock, "kmem");
801029df:	c7 44 24 04 ca 87 10 	movl   $0x801087ca,0x4(%esp)
801029e6:	80 
801029e7:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
801029ee:	e8 3b 25 00 00       	call   80104f2e <initlock>
  kmem.use_lock = 0;
801029f3:	c7 05 94 f8 10 80 00 	movl   $0x0,0x8010f894
801029fa:	00 00 00 
  freerange(vstart, vend);
801029fd:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a00:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a04:	8b 45 08             	mov    0x8(%ebp),%eax
80102a07:	89 04 24             	mov    %eax,(%esp)
80102a0a:	e8 26 00 00 00       	call   80102a35 <freerange>
}
80102a0f:	c9                   	leave  
80102a10:	c3                   	ret    

80102a11 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102a11:	55                   	push   %ebp
80102a12:	89 e5                	mov    %esp,%ebp
80102a14:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
80102a17:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a1e:	8b 45 08             	mov    0x8(%ebp),%eax
80102a21:	89 04 24             	mov    %eax,(%esp)
80102a24:	e8 0c 00 00 00       	call   80102a35 <freerange>
  kmem.use_lock = 1;
80102a29:	c7 05 94 f8 10 80 01 	movl   $0x1,0x8010f894
80102a30:	00 00 00 
}
80102a33:	c9                   	leave  
80102a34:	c3                   	ret    

80102a35 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102a35:	55                   	push   %ebp
80102a36:	89 e5                	mov    %esp,%ebp
80102a38:	83 ec 28             	sub    $0x28,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102a3b:	8b 45 08             	mov    0x8(%ebp),%eax
80102a3e:	05 ff 0f 00 00       	add    $0xfff,%eax
80102a43:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102a48:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a4b:	eb 12                	jmp    80102a5f <freerange+0x2a>
    kfree(p);
80102a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a50:	89 04 24             	mov    %eax,(%esp)
80102a53:	e8 19 00 00 00       	call   80102a71 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a58:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102a5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a62:	8d 90 00 10 00 00    	lea    0x1000(%eax),%edx
80102a68:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a6b:	39 c2                	cmp    %eax,%edx
80102a6d:	76 de                	jbe    80102a4d <freerange+0x18>
    kfree(p);
}
80102a6f:	c9                   	leave  
80102a70:	c3                   	ret    

80102a71 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102a71:	55                   	push   %ebp
80102a72:	89 e5                	mov    %esp,%ebp
80102a74:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102a77:	8b 45 08             	mov    0x8(%ebp),%eax
80102a7a:	25 ff 0f 00 00       	and    $0xfff,%eax
80102a7f:	85 c0                	test   %eax,%eax
80102a81:	75 1b                	jne    80102a9e <kfree+0x2d>
80102a83:	81 7d 08 1c 29 11 80 	cmpl   $0x8011291c,0x8(%ebp)
80102a8a:	72 12                	jb     80102a9e <kfree+0x2d>
80102a8c:	8b 45 08             	mov    0x8(%ebp),%eax
80102a8f:	89 04 24             	mov    %eax,(%esp)
80102a92:	e8 35 ff ff ff       	call   801029cc <v2p>
80102a97:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102a9c:	76 0c                	jbe    80102aaa <kfree+0x39>
    panic("kfree");
80102a9e:	c7 04 24 cf 87 10 80 	movl   $0x801087cf,(%esp)
80102aa5:	e8 90 da ff ff       	call   8010053a <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102aaa:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80102ab1:	00 
80102ab2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102ab9:	00 
80102aba:	8b 45 08             	mov    0x8(%ebp),%eax
80102abd:	89 04 24             	mov    %eax,(%esp)
80102ac0:	e8 d9 26 00 00       	call   8010519e <memset>

  if(kmem.use_lock)
80102ac5:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102aca:	85 c0                	test   %eax,%eax
80102acc:	74 0c                	je     80102ada <kfree+0x69>
    acquire(&kmem.lock);
80102ace:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102ad5:	e8 75 24 00 00       	call   80104f4f <acquire>
  r = (struct run*)v;
80102ada:	8b 45 08             	mov    0x8(%ebp),%eax
80102add:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102ae0:	8b 15 98 f8 10 80    	mov    0x8010f898,%edx
80102ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ae9:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102aee:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102af3:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102af8:	85 c0                	test   %eax,%eax
80102afa:	74 0c                	je     80102b08 <kfree+0x97>
    release(&kmem.lock);
80102afc:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102b03:	e8 a8 24 00 00       	call   80104fb0 <release>
}
80102b08:	c9                   	leave  
80102b09:	c3                   	ret    

80102b0a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b0a:	55                   	push   %ebp
80102b0b:	89 e5                	mov    %esp,%ebp
80102b0d:	83 ec 28             	sub    $0x28,%esp
  struct run *r;

  if(kmem.use_lock)
80102b10:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102b15:	85 c0                	test   %eax,%eax
80102b17:	74 0c                	je     80102b25 <kalloc+0x1b>
    acquire(&kmem.lock);
80102b19:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102b20:	e8 2a 24 00 00       	call   80104f4f <acquire>
  r = kmem.freelist;
80102b25:	a1 98 f8 10 80       	mov    0x8010f898,%eax
80102b2a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102b2d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102b31:	74 0a                	je     80102b3d <kalloc+0x33>
    kmem.freelist = r->next;
80102b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b36:	8b 00                	mov    (%eax),%eax
80102b38:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102b3d:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102b42:	85 c0                	test   %eax,%eax
80102b44:	74 0c                	je     80102b52 <kalloc+0x48>
    release(&kmem.lock);
80102b46:	c7 04 24 60 f8 10 80 	movl   $0x8010f860,(%esp)
80102b4d:	e8 5e 24 00 00       	call   80104fb0 <release>
  return (char*)r;
80102b52:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102b55:	c9                   	leave  
80102b56:	c3                   	ret    
	...

80102b58 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102b58:	55                   	push   %ebp
80102b59:	89 e5                	mov    %esp,%ebp
80102b5b:	83 ec 14             	sub    $0x14,%esp
80102b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80102b61:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b65:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102b69:	89 c2                	mov    %eax,%edx
80102b6b:	ec                   	in     (%dx),%al
80102b6c:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102b6f:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102b73:	c9                   	leave  
80102b74:	c3                   	ret    

80102b75 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b75:	55                   	push   %ebp
80102b76:	89 e5                	mov    %esp,%ebp
80102b78:	83 ec 14             	sub    $0x14,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102b7b:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102b82:	e8 d1 ff ff ff       	call   80102b58 <inb>
80102b87:	0f b6 c0             	movzbl %al,%eax
80102b8a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b90:	83 e0 01             	and    $0x1,%eax
80102b93:	85 c0                	test   %eax,%eax
80102b95:	75 0a                	jne    80102ba1 <kbdgetc+0x2c>
    return -1;
80102b97:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b9c:	e9 20 01 00 00       	jmp    80102cc1 <kbdgetc+0x14c>
  data = inb(KBDATAP);
80102ba1:	c7 04 24 60 00 00 00 	movl   $0x60,(%esp)
80102ba8:	e8 ab ff ff ff       	call   80102b58 <inb>
80102bad:	0f b6 c0             	movzbl %al,%eax
80102bb0:	89 45 f8             	mov    %eax,-0x8(%ebp)

  if(data == 0xE0){
80102bb3:	81 7d f8 e0 00 00 00 	cmpl   $0xe0,-0x8(%ebp)
80102bba:	75 17                	jne    80102bd3 <kbdgetc+0x5e>
    shift |= E0ESC;
80102bbc:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102bc1:	83 c8 40             	or     $0x40,%eax
80102bc4:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102bc9:	b8 00 00 00 00       	mov    $0x0,%eax
80102bce:	e9 ee 00 00 00       	jmp    80102cc1 <kbdgetc+0x14c>
  } else if(data & 0x80){
80102bd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bd6:	25 80 00 00 00       	and    $0x80,%eax
80102bdb:	85 c0                	test   %eax,%eax
80102bdd:	74 44                	je     80102c23 <kbdgetc+0xae>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102bdf:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102be4:	83 e0 40             	and    $0x40,%eax
80102be7:	85 c0                	test   %eax,%eax
80102be9:	75 08                	jne    80102bf3 <kbdgetc+0x7e>
80102beb:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bee:	83 e0 7f             	and    $0x7f,%eax
80102bf1:	eb 03                	jmp    80102bf6 <kbdgetc+0x81>
80102bf3:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bf6:	89 45 f8             	mov    %eax,-0x8(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102bf9:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102bfc:	0f b6 80 20 90 10 80 	movzbl -0x7fef6fe0(%eax),%eax
80102c03:	83 c8 40             	or     $0x40,%eax
80102c06:	0f b6 c0             	movzbl %al,%eax
80102c09:	f7 d0                	not    %eax
80102c0b:	89 c2                	mov    %eax,%edx
80102c0d:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c12:	21 d0                	and    %edx,%eax
80102c14:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102c19:	b8 00 00 00 00       	mov    $0x0,%eax
80102c1e:	e9 9e 00 00 00       	jmp    80102cc1 <kbdgetc+0x14c>
  } else if(shift & E0ESC){
80102c23:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c28:	83 e0 40             	and    $0x40,%eax
80102c2b:	85 c0                	test   %eax,%eax
80102c2d:	74 14                	je     80102c43 <kbdgetc+0xce>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102c2f:	81 4d f8 80 00 00 00 	orl    $0x80,-0x8(%ebp)
    shift &= ~E0ESC;
80102c36:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c3b:	83 e0 bf             	and    $0xffffffbf,%eax
80102c3e:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102c43:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102c46:	0f b6 80 20 90 10 80 	movzbl -0x7fef6fe0(%eax),%eax
80102c4d:	0f b6 d0             	movzbl %al,%edx
80102c50:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c55:	09 d0                	or     %edx,%eax
80102c57:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102c5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102c5f:	0f b6 80 20 91 10 80 	movzbl -0x7fef6ee0(%eax),%eax
80102c66:	0f b6 d0             	movzbl %al,%edx
80102c69:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c6e:	31 d0                	xor    %edx,%eax
80102c70:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c75:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c7a:	83 e0 03             	and    $0x3,%eax
80102c7d:	8b 04 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%eax
80102c84:	03 45 f8             	add    -0x8(%ebp),%eax
80102c87:	0f b6 00             	movzbl (%eax),%eax
80102c8a:	0f b6 c0             	movzbl %al,%eax
80102c8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(shift & CAPSLOCK){
80102c90:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c95:	83 e0 08             	and    $0x8,%eax
80102c98:	85 c0                	test   %eax,%eax
80102c9a:	74 22                	je     80102cbe <kbdgetc+0x149>
    if('a' <= c && c <= 'z')
80102c9c:	83 7d fc 60          	cmpl   $0x60,-0x4(%ebp)
80102ca0:	76 0c                	jbe    80102cae <kbdgetc+0x139>
80102ca2:	83 7d fc 7a          	cmpl   $0x7a,-0x4(%ebp)
80102ca6:	77 06                	ja     80102cae <kbdgetc+0x139>
      c += 'A' - 'a';
80102ca8:	83 6d fc 20          	subl   $0x20,-0x4(%ebp)

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
80102cac:	eb 10                	jmp    80102cbe <kbdgetc+0x149>
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102cae:	83 7d fc 40          	cmpl   $0x40,-0x4(%ebp)
80102cb2:	76 0a                	jbe    80102cbe <kbdgetc+0x149>
80102cb4:	83 7d fc 5a          	cmpl   $0x5a,-0x4(%ebp)
80102cb8:	77 04                	ja     80102cbe <kbdgetc+0x149>
      c += 'a' - 'A';
80102cba:	83 45 fc 20          	addl   $0x20,-0x4(%ebp)
  }
  return c;
80102cbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102cc1:	c9                   	leave  
80102cc2:	c3                   	ret    

80102cc3 <kbdintr>:

void
kbdintr(void)
{
80102cc3:	55                   	push   %ebp
80102cc4:	89 e5                	mov    %esp,%ebp
80102cc6:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102cc9:	c7 04 24 75 2b 10 80 	movl   $0x80102b75,(%esp)
80102cd0:	e8 d6 da ff ff       	call   801007ab <consoleintr>
}
80102cd5:	c9                   	leave  
80102cd6:	c3                   	ret    
	...

80102cd8 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102cd8:	55                   	push   %ebp
80102cd9:	89 e5                	mov    %esp,%ebp
80102cdb:	83 ec 08             	sub    $0x8,%esp
80102cde:	8b 55 08             	mov    0x8(%ebp),%edx
80102ce1:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ce4:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102ce8:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ceb:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102cef:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102cf3:	ee                   	out    %al,(%dx)
}
80102cf4:	c9                   	leave  
80102cf5:	c3                   	ret    

80102cf6 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102cf6:	55                   	push   %ebp
80102cf7:	89 e5                	mov    %esp,%ebp
80102cf9:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102cfc:	9c                   	pushf  
80102cfd:	58                   	pop    %eax
80102cfe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102d01:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102d04:	c9                   	leave  
80102d05:	c3                   	ret    

80102d06 <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102d06:	55                   	push   %ebp
80102d07:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102d09:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102d0e:	8b 55 08             	mov    0x8(%ebp),%edx
80102d11:	c1 e2 02             	shl    $0x2,%edx
80102d14:	8d 14 10             	lea    (%eax,%edx,1),%edx
80102d17:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d1a:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102d1c:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102d21:	83 c0 20             	add    $0x20,%eax
80102d24:	8b 00                	mov    (%eax),%eax
}
80102d26:	5d                   	pop    %ebp
80102d27:	c3                   	ret    

80102d28 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102d28:	55                   	push   %ebp
80102d29:	89 e5                	mov    %esp,%ebp
80102d2b:	83 ec 08             	sub    $0x8,%esp
  if(!lapic) 
80102d2e:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102d33:	85 c0                	test   %eax,%eax
80102d35:	0f 84 46 01 00 00    	je     80102e81 <lapicinit+0x159>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102d3b:	c7 44 24 04 3f 01 00 	movl   $0x13f,0x4(%esp)
80102d42:	00 
80102d43:	c7 04 24 3c 00 00 00 	movl   $0x3c,(%esp)
80102d4a:	e8 b7 ff ff ff       	call   80102d06 <lapicw>

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102d4f:	c7 44 24 04 0b 00 00 	movl   $0xb,0x4(%esp)
80102d56:	00 
80102d57:	c7 04 24 f8 00 00 00 	movl   $0xf8,(%esp)
80102d5e:	e8 a3 ff ff ff       	call   80102d06 <lapicw>
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102d63:	c7 44 24 04 20 00 02 	movl   $0x20020,0x4(%esp)
80102d6a:	00 
80102d6b:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102d72:	e8 8f ff ff ff       	call   80102d06 <lapicw>
  lapicw(TICR, 10000000); 
80102d77:	c7 44 24 04 80 96 98 	movl   $0x989680,0x4(%esp)
80102d7e:	00 
80102d7f:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
80102d86:	e8 7b ff ff ff       	call   80102d06 <lapicw>

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102d8b:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102d92:	00 
80102d93:	c7 04 24 d4 00 00 00 	movl   $0xd4,(%esp)
80102d9a:	e8 67 ff ff ff       	call   80102d06 <lapicw>
  lapicw(LINT1, MASKED);
80102d9f:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102da6:	00 
80102da7:	c7 04 24 d8 00 00 00 	movl   $0xd8,(%esp)
80102dae:	e8 53 ff ff ff       	call   80102d06 <lapicw>

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102db3:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102db8:	83 c0 30             	add    $0x30,%eax
80102dbb:	8b 00                	mov    (%eax),%eax
80102dbd:	c1 e8 10             	shr    $0x10,%eax
80102dc0:	25 ff 00 00 00       	and    $0xff,%eax
80102dc5:	83 f8 03             	cmp    $0x3,%eax
80102dc8:	76 14                	jbe    80102dde <lapicinit+0xb6>
    lapicw(PCINT, MASKED);
80102dca:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
80102dd1:	00 
80102dd2:	c7 04 24 d0 00 00 00 	movl   $0xd0,(%esp)
80102dd9:	e8 28 ff ff ff       	call   80102d06 <lapicw>

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102dde:	c7 44 24 04 33 00 00 	movl   $0x33,0x4(%esp)
80102de5:	00 
80102de6:	c7 04 24 dc 00 00 00 	movl   $0xdc,(%esp)
80102ded:	e8 14 ff ff ff       	call   80102d06 <lapicw>

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102df2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102df9:	00 
80102dfa:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102e01:	e8 00 ff ff ff       	call   80102d06 <lapicw>
  lapicw(ESR, 0);
80102e06:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e0d:	00 
80102e0e:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80102e15:	e8 ec fe ff ff       	call   80102d06 <lapicw>

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102e1a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e21:	00 
80102e22:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102e29:	e8 d8 fe ff ff       	call   80102d06 <lapicw>

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102e2e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e35:	00 
80102e36:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102e3d:	e8 c4 fe ff ff       	call   80102d06 <lapicw>
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102e42:	c7 44 24 04 00 85 08 	movl   $0x88500,0x4(%esp)
80102e49:	00 
80102e4a:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102e51:	e8 b0 fe ff ff       	call   80102d06 <lapicw>
  while(lapic[ICRLO] & DELIVS)
80102e56:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102e5b:	05 00 03 00 00       	add    $0x300,%eax
80102e60:	8b 00                	mov    (%eax),%eax
80102e62:	25 00 10 00 00       	and    $0x1000,%eax
80102e67:	85 c0                	test   %eax,%eax
80102e69:	75 eb                	jne    80102e56 <lapicinit+0x12e>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102e6b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102e72:	00 
80102e73:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80102e7a:	e8 87 fe ff ff       	call   80102d06 <lapicw>
80102e7f:	eb 01                	jmp    80102e82 <lapicinit+0x15a>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80102e81:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102e82:	c9                   	leave  
80102e83:	c3                   	ret    

80102e84 <cpunum>:

int
cpunum(void)
{
80102e84:	55                   	push   %ebp
80102e85:	89 e5                	mov    %esp,%ebp
80102e87:	83 ec 18             	sub    $0x18,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102e8a:	e8 67 fe ff ff       	call   80102cf6 <readeflags>
80102e8f:	25 00 02 00 00       	and    $0x200,%eax
80102e94:	85 c0                	test   %eax,%eax
80102e96:	74 29                	je     80102ec1 <cpunum+0x3d>
    static int n;
    if(n++ == 0)
80102e98:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102e9d:	85 c0                	test   %eax,%eax
80102e9f:	0f 94 c2             	sete   %dl
80102ea2:	83 c0 01             	add    $0x1,%eax
80102ea5:	a3 60 b6 10 80       	mov    %eax,0x8010b660
80102eaa:	84 d2                	test   %dl,%dl
80102eac:	74 13                	je     80102ec1 <cpunum+0x3d>
      cprintf("cpu called from %x with interrupts enabled\n",
80102eae:	8b 45 04             	mov    0x4(%ebp),%eax
80102eb1:	89 44 24 04          	mov    %eax,0x4(%esp)
80102eb5:	c7 04 24 d8 87 10 80 	movl   $0x801087d8,(%esp)
80102ebc:	e8 d9 d4 ff ff       	call   8010039a <cprintf>
        __builtin_return_address(0));
  }

  if(lapic)
80102ec1:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102ec6:	85 c0                	test   %eax,%eax
80102ec8:	74 0f                	je     80102ed9 <cpunum+0x55>
    return lapic[ID]>>24;
80102eca:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102ecf:	83 c0 20             	add    $0x20,%eax
80102ed2:	8b 00                	mov    (%eax),%eax
80102ed4:	c1 e8 18             	shr    $0x18,%eax
80102ed7:	eb 05                	jmp    80102ede <cpunum+0x5a>
  return 0;
80102ed9:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102ede:	c9                   	leave  
80102edf:	c3                   	ret    

80102ee0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 08             	sub    $0x8,%esp
  if(lapic)
80102ee6:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102eeb:	85 c0                	test   %eax,%eax
80102eed:	74 14                	je     80102f03 <lapiceoi+0x23>
    lapicw(EOI, 0);
80102eef:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80102ef6:	00 
80102ef7:	c7 04 24 2c 00 00 00 	movl   $0x2c,(%esp)
80102efe:	e8 03 fe ff ff       	call   80102d06 <lapicw>
}
80102f03:	c9                   	leave  
80102f04:	c3                   	ret    

80102f05 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f05:	55                   	push   %ebp
80102f06:	89 e5                	mov    %esp,%ebp
}
80102f08:	5d                   	pop    %ebp
80102f09:	c3                   	ret    

80102f0a <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f0a:	55                   	push   %ebp
80102f0b:	89 e5                	mov    %esp,%ebp
80102f0d:	83 ec 1c             	sub    $0x1c,%esp
80102f10:	8b 45 08             	mov    0x8(%ebp),%eax
80102f13:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102f16:	c7 44 24 04 0f 00 00 	movl   $0xf,0x4(%esp)
80102f1d:	00 
80102f1e:	c7 04 24 70 00 00 00 	movl   $0x70,(%esp)
80102f25:	e8 ae fd ff ff       	call   80102cd8 <outb>
  outb(IO_RTC+1, 0x0A);
80102f2a:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80102f31:	00 
80102f32:	c7 04 24 71 00 00 00 	movl   $0x71,(%esp)
80102f39:	e8 9a fd ff ff       	call   80102cd8 <outb>
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f3e:	c7 45 fc 67 04 00 80 	movl   $0x80000467,-0x4(%ebp)
  wrv[0] = 0;
80102f45:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f48:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102f4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102f50:	8d 50 02             	lea    0x2(%eax),%edx
80102f53:	8b 45 0c             	mov    0xc(%ebp),%eax
80102f56:	c1 e8 04             	shr    $0x4,%eax
80102f59:	66 89 02             	mov    %ax,(%edx)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102f5c:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102f60:	c1 e0 18             	shl    $0x18,%eax
80102f63:	89 44 24 04          	mov    %eax,0x4(%esp)
80102f67:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102f6e:	e8 93 fd ff ff       	call   80102d06 <lapicw>
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102f73:	c7 44 24 04 00 c5 00 	movl   $0xc500,0x4(%esp)
80102f7a:	00 
80102f7b:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102f82:	e8 7f fd ff ff       	call   80102d06 <lapicw>
  microdelay(200);
80102f87:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102f8e:	e8 72 ff ff ff       	call   80102f05 <microdelay>
  lapicw(ICRLO, INIT | LEVEL);
80102f93:	c7 44 24 04 00 85 00 	movl   $0x8500,0x4(%esp)
80102f9a:	00 
80102f9b:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fa2:	e8 5f fd ff ff       	call   80102d06 <lapicw>
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102fa7:	c7 04 24 64 00 00 00 	movl   $0x64,(%esp)
80102fae:	e8 52 ff ff ff       	call   80102f05 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102fb3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80102fba:	eb 40                	jmp    80102ffc <lapicstartap+0xf2>
    lapicw(ICRHI, apicid<<24);
80102fbc:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fc0:	c1 e0 18             	shl    $0x18,%eax
80102fc3:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fc7:	c7 04 24 c4 00 00 00 	movl   $0xc4,(%esp)
80102fce:	e8 33 fd ff ff       	call   80102d06 <lapicw>
    lapicw(ICRLO, STARTUP | (addr>>12));
80102fd3:	8b 45 0c             	mov    0xc(%ebp),%eax
80102fd6:	c1 e8 0c             	shr    $0xc,%eax
80102fd9:	80 cc 06             	or     $0x6,%ah
80102fdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80102fe0:	c7 04 24 c0 00 00 00 	movl   $0xc0,(%esp)
80102fe7:	e8 1a fd ff ff       	call   80102d06 <lapicw>
    microdelay(200);
80102fec:	c7 04 24 c8 00 00 00 	movl   $0xc8,(%esp)
80102ff3:	e8 0d ff ff ff       	call   80102f05 <microdelay>
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80102ff8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80102ffc:	83 7d f8 01          	cmpl   $0x1,-0x8(%ebp)
80103000:	7e ba                	jle    80102fbc <lapicstartap+0xb2>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103002:	c9                   	leave  
80103003:	c3                   	ret    

80103004 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103004:	55                   	push   %ebp
80103005:	89 e5                	mov    %esp,%ebp
80103007:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
8010300a:	90                   	nop
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010300b:	c7 44 24 04 04 88 10 	movl   $0x80108804,0x4(%esp)
80103012:	80 
80103013:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
8010301a:	e8 0f 1f 00 00       	call   80104f2e <initlock>
  readsb(ROOTDEV, &sb);
8010301f:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103022:	89 44 24 04          	mov    %eax,0x4(%esp)
80103026:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010302d:	e8 c2 e2 ff ff       	call   801012f4 <readsb>
  log.start = sb.size - sb.nlog;
80103032:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103035:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103038:	89 d1                	mov    %edx,%ecx
8010303a:	29 c1                	sub    %eax,%ecx
8010303c:	89 c8                	mov    %ecx,%eax
8010303e:	a3 d4 f8 10 80       	mov    %eax,0x8010f8d4
  log.size = sb.nlog;
80103043:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103046:	a3 d8 f8 10 80       	mov    %eax,0x8010f8d8
  log.dev = ROOTDEV;
8010304b:	c7 05 e0 f8 10 80 01 	movl   $0x1,0x8010f8e0
80103052:	00 00 00 
  recover_from_log();
80103055:	e8 97 01 00 00       	call   801031f1 <recover_from_log>
}
8010305a:	c9                   	leave  
8010305b:	c3                   	ret    

8010305c <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
8010305c:	55                   	push   %ebp
8010305d:	89 e5                	mov    %esp,%ebp
8010305f:	83 ec 28             	sub    $0x28,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103062:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80103069:	e9 89 00 00 00       	jmp    801030f7 <install_trans+0x9b>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
8010306e:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80103073:	03 45 ec             	add    -0x14(%ebp),%eax
80103076:	83 c0 01             	add    $0x1,%eax
80103079:	89 c2                	mov    %eax,%edx
8010307b:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103080:	89 54 24 04          	mov    %edx,0x4(%esp)
80103084:	89 04 24             	mov    %eax,(%esp)
80103087:	e8 1b d1 ff ff       	call   801001a7 <bread>
8010308c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
8010308f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103092:	83 c0 10             	add    $0x10,%eax
80103095:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
8010309c:	89 c2                	mov    %eax,%edx
8010309e:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
801030a3:	89 54 24 04          	mov    %edx,0x4(%esp)
801030a7:	89 04 24             	mov    %eax,(%esp)
801030aa:	e8 f8 d0 ff ff       	call   801001a7 <bread>
801030af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030b5:	8d 50 18             	lea    0x18(%eax),%edx
801030b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030bb:	83 c0 18             	add    $0x18,%eax
801030be:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801030c5:	00 
801030c6:	89 54 24 04          	mov    %edx,0x4(%esp)
801030ca:	89 04 24             	mov    %eax,(%esp)
801030cd:	e8 9f 21 00 00       	call   80105271 <memmove>
    bwrite(dbuf);  // write dst to disk
801030d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030d5:	89 04 24             	mov    %eax,(%esp)
801030d8:	e8 01 d1 ff ff       	call   801001de <bwrite>
    brelse(lbuf); 
801030dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801030e0:	89 04 24             	mov    %eax,(%esp)
801030e3:	e8 30 d1 ff ff       	call   80100218 <brelse>
    brelse(dbuf);
801030e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030eb:	89 04 24             	mov    %eax,(%esp)
801030ee:	e8 25 d1 ff ff       	call   80100218 <brelse>
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030f3:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801030f7:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801030fc:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801030ff:	0f 8f 69 ff ff ff    	jg     8010306e <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
80103105:	c9                   	leave  
80103106:	c3                   	ret    

80103107 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103107:	55                   	push   %ebp
80103108:	89 e5                	mov    %esp,%ebp
8010310a:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
8010310d:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80103112:	89 c2                	mov    %eax,%edx
80103114:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103119:	89 54 24 04          	mov    %edx,0x4(%esp)
8010311d:	89 04 24             	mov    %eax,(%esp)
80103120:	e8 82 d0 ff ff       	call   801001a7 <bread>
80103125:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103128:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010312b:	83 c0 18             	add    $0x18,%eax
8010312e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int i;
  log.lh.n = lh->n;
80103131:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103134:	8b 00                	mov    (%eax),%eax
80103136:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  for (i = 0; i < log.lh.n; i++) {
8010313b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103142:	eb 1b                	jmp    8010315f <read_head+0x58>
    log.lh.sector[i] = lh->sector[i];
80103144:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80103147:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010314a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010314d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103151:	8d 51 10             	lea    0x10(%ecx),%edx
80103154:	89 04 95 a8 f8 10 80 	mov    %eax,-0x7fef0758(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
8010315b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010315f:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103164:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103167:	7f db                	jg     80103144 <read_head+0x3d>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
80103169:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010316c:	89 04 24             	mov    %eax,(%esp)
8010316f:	e8 a4 d0 ff ff       	call   80100218 <brelse>
}
80103174:	c9                   	leave  
80103175:	c3                   	ret    

80103176 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103176:	55                   	push   %ebp
80103177:	89 e5                	mov    %esp,%ebp
80103179:	83 ec 28             	sub    $0x28,%esp
  struct buf *buf = bread(log.dev, log.start);
8010317c:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80103181:	89 c2                	mov    %eax,%edx
80103183:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103188:	89 54 24 04          	mov    %edx,0x4(%esp)
8010318c:	89 04 24             	mov    %eax,(%esp)
8010318f:	e8 13 d0 ff ff       	call   801001a7 <bread>
80103194:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
80103197:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010319a:	83 c0 18             	add    $0x18,%eax
8010319d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int i;
  hb->n = log.lh.n;
801031a0:	8b 15 e4 f8 10 80    	mov    0x8010f8e4,%edx
801031a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031a9:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801031ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801031b2:	eb 1b                	jmp    801031cf <write_head+0x59>
    hb->sector[i] = log.lh.sector[i];
801031b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031ba:	83 c0 10             	add    $0x10,%eax
801031bd:	8b 0c 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%ecx
801031c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031c7:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
801031cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031cf:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801031d4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031d7:	7f db                	jg     801031b4 <write_head+0x3e>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
801031d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031dc:	89 04 24             	mov    %eax,(%esp)
801031df:	e8 fa cf ff ff       	call   801001de <bwrite>
  brelse(buf);
801031e4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031e7:	89 04 24             	mov    %eax,(%esp)
801031ea:	e8 29 d0 ff ff       	call   80100218 <brelse>
}
801031ef:	c9                   	leave  
801031f0:	c3                   	ret    

801031f1 <recover_from_log>:

static void
recover_from_log(void)
{
801031f1:	55                   	push   %ebp
801031f2:	89 e5                	mov    %esp,%ebp
801031f4:	83 ec 08             	sub    $0x8,%esp
  read_head();      
801031f7:	e8 0b ff ff ff       	call   80103107 <read_head>
  install_trans(); // if committed, copy from log to disk
801031fc:	e8 5b fe ff ff       	call   8010305c <install_trans>
  log.lh.n = 0;
80103201:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
80103208:	00 00 00 
  write_head(); // clear the log
8010320b:	e8 66 ff ff ff       	call   80103176 <write_head>
}
80103210:	c9                   	leave  
80103211:	c3                   	ret    

80103212 <begin_trans>:

void
begin_trans(void)
{
80103212:	55                   	push   %ebp
80103213:	89 e5                	mov    %esp,%ebp
80103215:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80103218:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
8010321f:	e8 2b 1d 00 00       	call   80104f4f <acquire>
  while (log.busy) {
80103224:	eb 14                	jmp    8010323a <begin_trans+0x28>
    sleep(&log, &log.lock);
80103226:	c7 44 24 04 a0 f8 10 	movl   $0x8010f8a0,0x4(%esp)
8010322d:	80 
8010322e:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103235:	e8 9c 19 00 00       	call   80104bd6 <sleep>

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
8010323a:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
8010323f:	85 c0                	test   %eax,%eax
80103241:	75 e3                	jne    80103226 <begin_trans+0x14>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
80103243:	c7 05 dc f8 10 80 01 	movl   $0x1,0x8010f8dc
8010324a:	00 00 00 
  release(&log.lock);
8010324d:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
80103254:	e8 57 1d 00 00       	call   80104fb0 <release>
}
80103259:	c9                   	leave  
8010325a:	c3                   	ret    

8010325b <commit_trans>:

void
commit_trans(void)
{
8010325b:	55                   	push   %ebp
8010325c:	89 e5                	mov    %esp,%ebp
8010325e:	83 ec 18             	sub    $0x18,%esp
  if (log.lh.n > 0) {
80103261:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103266:	85 c0                	test   %eax,%eax
80103268:	7e 19                	jle    80103283 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
8010326a:	e8 07 ff ff ff       	call   80103176 <write_head>
    install_trans(); // Now install writes to home locations
8010326f:	e8 e8 fd ff ff       	call   8010305c <install_trans>
    log.lh.n = 0; 
80103274:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
8010327b:	00 00 00 
    write_head();    // Erase the transaction from the log
8010327e:	e8 f3 fe ff ff       	call   80103176 <write_head>
  }
  
  acquire(&log.lock);
80103283:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
8010328a:	e8 c0 1c 00 00       	call   80104f4f <acquire>
  log.busy = 0;
8010328f:	c7 05 dc f8 10 80 00 	movl   $0x0,0x8010f8dc
80103296:	00 00 00 
  wakeup(&log);
80103299:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
801032a0:	e8 77 1a 00 00       	call   80104d1c <wakeup>
  release(&log.lock);
801032a5:	c7 04 24 a0 f8 10 80 	movl   $0x8010f8a0,(%esp)
801032ac:	e8 ff 1c 00 00       	call   80104fb0 <release>
}
801032b1:	c9                   	leave  
801032b2:	c3                   	ret    

801032b3 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801032b3:	55                   	push   %ebp
801032b4:	89 e5                	mov    %esp,%ebp
801032b6:	83 ec 28             	sub    $0x28,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801032b9:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801032be:	83 f8 09             	cmp    $0x9,%eax
801032c1:	7f 12                	jg     801032d5 <log_write+0x22>
801032c3:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801032c8:	8b 15 d8 f8 10 80    	mov    0x8010f8d8,%edx
801032ce:	83 ea 01             	sub    $0x1,%edx
801032d1:	39 d0                	cmp    %edx,%eax
801032d3:	7c 0c                	jl     801032e1 <log_write+0x2e>
    panic("too big a transaction");
801032d5:	c7 04 24 08 88 10 80 	movl   $0x80108808,(%esp)
801032dc:	e8 59 d2 ff ff       	call   8010053a <panic>
  if (!log.busy)
801032e1:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
801032e6:	85 c0                	test   %eax,%eax
801032e8:	75 0c                	jne    801032f6 <log_write+0x43>
    panic("write outside of trans");
801032ea:	c7 04 24 1e 88 10 80 	movl   $0x8010881e,(%esp)
801032f1:	e8 44 d2 ff ff       	call   8010053a <panic>

  for (i = 0; i < log.lh.n; i++) {
801032f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801032fd:	eb 1d                	jmp    8010331c <log_write+0x69>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
801032ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103302:	83 c0 10             	add    $0x10,%eax
80103305:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
8010330c:	89 c2                	mov    %eax,%edx
8010330e:	8b 45 08             	mov    0x8(%ebp),%eax
80103311:	8b 40 08             	mov    0x8(%eax),%eax
80103314:	39 c2                	cmp    %eax,%edx
80103316:	74 10                	je     80103328 <log_write+0x75>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
80103318:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010331c:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103321:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80103324:	7f d9                	jg     801032ff <log_write+0x4c>
80103326:	eb 01                	jmp    80103329 <log_write+0x76>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
80103328:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
80103329:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010332c:	8b 45 08             	mov    0x8(%ebp),%eax
8010332f:	8b 40 08             	mov    0x8(%eax),%eax
80103332:	83 c2 10             	add    $0x10,%edx
80103335:	89 04 95 a8 f8 10 80 	mov    %eax,-0x7fef0758(,%edx,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
8010333c:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
80103341:	03 45 f0             	add    -0x10(%ebp),%eax
80103344:	83 c0 01             	add    $0x1,%eax
80103347:	89 c2                	mov    %eax,%edx
80103349:	8b 45 08             	mov    0x8(%ebp),%eax
8010334c:	8b 40 04             	mov    0x4(%eax),%eax
8010334f:	89 54 24 04          	mov    %edx,0x4(%esp)
80103353:	89 04 24             	mov    %eax,(%esp)
80103356:	e8 4c ce ff ff       	call   801001a7 <bread>
8010335b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
8010335e:	8b 45 08             	mov    0x8(%ebp),%eax
80103361:	8d 50 18             	lea    0x18(%eax),%edx
80103364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103367:	83 c0 18             	add    $0x18,%eax
8010336a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80103371:	00 
80103372:	89 54 24 04          	mov    %edx,0x4(%esp)
80103376:	89 04 24             	mov    %eax,(%esp)
80103379:	e8 f3 1e 00 00       	call   80105271 <memmove>
  bwrite(lbuf);
8010337e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103381:	89 04 24             	mov    %eax,(%esp)
80103384:	e8 55 ce ff ff       	call   801001de <bwrite>
  brelse(lbuf);
80103389:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010338c:	89 04 24             	mov    %eax,(%esp)
8010338f:	e8 84 ce ff ff       	call   80100218 <brelse>
  if (i == log.lh.n)
80103394:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103399:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010339c:	75 0d                	jne    801033ab <log_write+0xf8>
    log.lh.n++;
8010339e:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801033a3:	83 c0 01             	add    $0x1,%eax
801033a6:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  b->flags |= B_DIRTY; // XXX prevent eviction
801033ab:	8b 45 08             	mov    0x8(%ebp),%eax
801033ae:	8b 00                	mov    (%eax),%eax
801033b0:	89 c2                	mov    %eax,%edx
801033b2:	83 ca 04             	or     $0x4,%edx
801033b5:	8b 45 08             	mov    0x8(%ebp),%eax
801033b8:	89 10                	mov    %edx,(%eax)
}
801033ba:	c9                   	leave  
801033bb:	c3                   	ret    

801033bc <v2p>:
801033bc:	55                   	push   %ebp
801033bd:	89 e5                	mov    %esp,%ebp
801033bf:	8b 45 08             	mov    0x8(%ebp),%eax
801033c2:	2d 00 00 00 80       	sub    $0x80000000,%eax
801033c7:	5d                   	pop    %ebp
801033c8:	c3                   	ret    

801033c9 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801033c9:	55                   	push   %ebp
801033ca:	89 e5                	mov    %esp,%ebp
801033cc:	8b 45 08             	mov    0x8(%ebp),%eax
801033cf:	2d 00 00 00 80       	sub    $0x80000000,%eax
801033d4:	5d                   	pop    %ebp
801033d5:	c3                   	ret    

801033d6 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
801033d6:	55                   	push   %ebp
801033d7:	89 e5                	mov    %esp,%ebp
801033d9:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801033dc:	8b 55 08             	mov    0x8(%ebp),%edx
801033df:	8b 45 0c             	mov    0xc(%ebp),%eax
801033e2:	8b 4d 08             	mov    0x8(%ebp),%ecx
801033e5:	f0 87 02             	lock xchg %eax,(%edx)
801033e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
801033eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801033ee:	c9                   	leave  
801033ef:	c3                   	ret    

801033f0 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	83 e4 f0             	and    $0xfffffff0,%esp
801033f6:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801033f9:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80103400:	80 
80103401:	c7 04 24 1c 29 11 80 	movl   $0x8011291c,(%esp)
80103408:	e8 cc f5 ff ff       	call   801029d9 <kinit1>
  kvmalloc();      // kernel page table
8010340d:	e8 3d 4a 00 00       	call   80107e4f <kvmalloc>
  mpinit();        // collect info about this machine
80103412:	e8 45 04 00 00       	call   8010385c <mpinit>
  lapicinit();
80103417:	e8 0c f9 ff ff       	call   80102d28 <lapicinit>
  seginit();       // set up segments
8010341c:	e8 d0 43 00 00       	call   801077f1 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
80103421:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103427:	0f b6 00             	movzbl (%eax),%eax
8010342a:	0f b6 c0             	movzbl %al,%eax
8010342d:	89 44 24 04          	mov    %eax,0x4(%esp)
80103431:	c7 04 24 35 88 10 80 	movl   $0x80108835,(%esp)
80103438:	e8 5d cf ff ff       	call   8010039a <cprintf>
  picinit();       // interrupt controller
8010343d:	e8 80 06 00 00       	call   80103ac2 <picinit>
  ioapicinit();    // another interrupt controller
80103442:	e8 82 f4 ff ff       	call   801028c9 <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
80103447:	e8 3c d6 ff ff       	call   80100a88 <consoleinit>
  uartinit();      // serial port
8010344c:	e8 ea 36 00 00       	call   80106b3b <uartinit>
  pinit();         // process table
80103451:	e8 03 0c 00 00       	call   80104059 <pinit>
  tvinit();        // trap vectors
80103456:	e8 93 32 00 00       	call   801066ee <tvinit>
  binit();         // buffer cache
8010345b:	e8 d4 cb ff ff       	call   80100034 <binit>
  fileinit();      // file table
80103460:	e8 a3 da ff ff       	call   80100f08 <fileinit>
  iinit();         // inode cache
80103465:	e8 58 e1 ff ff       	call   801015c2 <iinit>
  ideinit();       // disk
8010346a:	e8 c1 f0 ff ff       	call   80102530 <ideinit>
  if(!ismp)
8010346f:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80103474:	85 c0                	test   %eax,%eax
80103476:	75 05                	jne    8010347d <main+0x8d>
    timerinit();   // uniprocessor timer
80103478:	e8 b9 31 00 00       	call   80106636 <timerinit>
  startothers();   // start other processors
8010347d:	e8 7f 00 00 00       	call   80103501 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103482:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80103489:	8e 
8010348a:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103491:	e8 7b f5 ff ff       	call   80102a11 <kinit2>
  userinit();      // first user process
80103496:	e8 dd 0c 00 00       	call   80104178 <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
8010349b:	e8 1a 00 00 00       	call   801034ba <mpmain>

801034a0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801034a0:	55                   	push   %ebp
801034a1:	89 e5                	mov    %esp,%ebp
801034a3:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
801034a6:	e8 bb 49 00 00       	call   80107e66 <switchkvm>
  seginit();
801034ab:	e8 41 43 00 00       	call   801077f1 <seginit>
  lapicinit();
801034b0:	e8 73 f8 ff ff       	call   80102d28 <lapicinit>
  mpmain();
801034b5:	e8 00 00 00 00       	call   801034ba <mpmain>

801034ba <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801034ba:	55                   	push   %ebp
801034bb:	89 e5                	mov    %esp,%ebp
801034bd:	83 ec 18             	sub    $0x18,%esp
  cprintf("cpu%d: starting\n", cpu->id);
801034c0:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034c6:	0f b6 00             	movzbl (%eax),%eax
801034c9:	0f b6 c0             	movzbl %al,%eax
801034cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801034d0:	c7 04 24 4c 88 10 80 	movl   $0x8010884c,(%esp)
801034d7:	e8 be ce ff ff       	call   8010039a <cprintf>
  idtinit();       // load idt register
801034dc:	e8 7d 33 00 00       	call   8010685e <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
801034e1:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034e7:	05 a8 00 00 00       	add    $0xa8,%eax
801034ec:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801034f3:	00 
801034f4:	89 04 24             	mov    %eax,(%esp)
801034f7:	e8 da fe ff ff       	call   801033d6 <xchg>
  scheduler();     // start running processes
801034fc:	e8 da 14 00 00       	call   801049db <scheduler>

80103501 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103501:	55                   	push   %ebp
80103502:	89 e5                	mov    %esp,%ebp
80103504:	53                   	push   %ebx
80103505:	83 ec 24             	sub    $0x24,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
80103508:	c7 04 24 00 70 00 00 	movl   $0x7000,(%esp)
8010350f:	e8 b5 fe ff ff       	call   801033c9 <p2v>
80103514:	89 45 ec             	mov    %eax,-0x14(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103517:	b8 8a 00 00 00       	mov    $0x8a,%eax
8010351c:	89 44 24 08          	mov    %eax,0x8(%esp)
80103520:	c7 44 24 04 2c b5 10 	movl   $0x8010b52c,0x4(%esp)
80103527:	80 
80103528:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010352b:	89 04 24             	mov    %eax,(%esp)
8010352e:	e8 3e 1d 00 00       	call   80105271 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103533:	c7 45 f0 40 f9 10 80 	movl   $0x8010f940,-0x10(%ebp)
8010353a:	e9 85 00 00 00       	jmp    801035c4 <startothers+0xc3>
    if(c == cpus+cpunum())  // We've started already.
8010353f:	e8 40 f9 ff ff       	call   80102e84 <cpunum>
80103544:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010354a:	05 40 f9 10 80       	add    $0x8010f940,%eax
8010354f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80103552:	74 68                	je     801035bc <startothers+0xbb>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103554:	e8 b1 f5 ff ff       	call   80102b0a <kalloc>
80103559:	89 45 f4             	mov    %eax,-0xc(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
8010355c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010355f:	83 e8 04             	sub    $0x4,%eax
80103562:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103565:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010356b:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
8010356d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103570:	83 e8 08             	sub    $0x8,%eax
80103573:	c7 00 a0 34 10 80    	movl   $0x801034a0,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
80103579:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010357c:	8d 58 f4             	lea    -0xc(%eax),%ebx
8010357f:	c7 04 24 00 a0 10 80 	movl   $0x8010a000,(%esp)
80103586:	e8 31 fe ff ff       	call   801033bc <v2p>
8010358b:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
8010358d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103590:	89 04 24             	mov    %eax,(%esp)
80103593:	e8 24 fe ff ff       	call   801033bc <v2p>
80103598:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010359b:	0f b6 12             	movzbl (%edx),%edx
8010359e:	0f b6 d2             	movzbl %dl,%edx
801035a1:	89 44 24 04          	mov    %eax,0x4(%esp)
801035a5:	89 14 24             	mov    %edx,(%esp)
801035a8:	e8 5d f9 ff ff       	call   80102f0a <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801035ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035b0:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801035b6:	85 c0                	test   %eax,%eax
801035b8:	74 f3                	je     801035ad <startothers+0xac>
801035ba:	eb 01                	jmp    801035bd <startothers+0xbc>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
801035bc:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
801035bd:	81 45 f0 bc 00 00 00 	addl   $0xbc,-0x10(%ebp)
801035c4:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801035c9:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801035cf:	05 40 f9 10 80       	add    $0x8010f940,%eax
801035d4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801035d7:	0f 87 62 ff ff ff    	ja     8010353f <startothers+0x3e>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
801035dd:	83 c4 24             	add    $0x24,%esp
801035e0:	5b                   	pop    %ebx
801035e1:	5d                   	pop    %ebp
801035e2:	c3                   	ret    
	...

801035e4 <p2v>:
801035e4:	55                   	push   %ebp
801035e5:	89 e5                	mov    %esp,%ebp
801035e7:	8b 45 08             	mov    0x8(%ebp),%eax
801035ea:	2d 00 00 00 80       	sub    $0x80000000,%eax
801035ef:	5d                   	pop    %ebp
801035f0:	c3                   	ret    

801035f1 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801035f1:	55                   	push   %ebp
801035f2:	89 e5                	mov    %esp,%ebp
801035f4:	83 ec 14             	sub    $0x14,%esp
801035f7:	8b 45 08             	mov    0x8(%ebp),%eax
801035fa:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801035fe:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103602:	89 c2                	mov    %eax,%edx
80103604:	ec                   	in     (%dx),%al
80103605:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103608:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010360c:	c9                   	leave  
8010360d:	c3                   	ret    

8010360e <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010360e:	55                   	push   %ebp
8010360f:	89 e5                	mov    %esp,%ebp
80103611:	83 ec 08             	sub    $0x8,%esp
80103614:	8b 55 08             	mov    0x8(%ebp),%edx
80103617:	8b 45 0c             	mov    0xc(%ebp),%eax
8010361a:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010361e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103621:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103625:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103629:	ee                   	out    %al,(%dx)
}
8010362a:	c9                   	leave  
8010362b:	c3                   	ret    

8010362c <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
8010362c:	55                   	push   %ebp
8010362d:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
8010362f:	a1 64 b6 10 80       	mov    0x8010b664,%eax
80103634:	89 c2                	mov    %eax,%edx
80103636:	b8 40 f9 10 80       	mov    $0x8010f940,%eax
8010363b:	89 d1                	mov    %edx,%ecx
8010363d:	29 c1                	sub    %eax,%ecx
8010363f:	89 c8                	mov    %ecx,%eax
80103641:	c1 f8 02             	sar    $0x2,%eax
80103644:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
8010364a:	5d                   	pop    %ebp
8010364b:	c3                   	ret    

8010364c <sum>:

static uchar
sum(uchar *addr, int len)
{
8010364c:	55                   	push   %ebp
8010364d:	89 e5                	mov    %esp,%ebp
8010364f:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
80103652:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  for(i=0; i<len; i++)
80103659:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80103660:	eb 13                	jmp    80103675 <sum+0x29>
    sum += addr[i];
80103662:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103665:	03 45 08             	add    0x8(%ebp),%eax
80103668:	0f b6 00             	movzbl (%eax),%eax
8010366b:	0f b6 c0             	movzbl %al,%eax
8010366e:	01 45 fc             	add    %eax,-0x4(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103671:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80103675:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103678:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010367b:	7c e5                	jl     80103662 <sum+0x16>
    sum += addr[i];
  return sum;
8010367d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103680:	c9                   	leave  
80103681:	c3                   	ret    

80103682 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103682:	55                   	push   %ebp
80103683:	89 e5                	mov    %esp,%ebp
80103685:	83 ec 28             	sub    $0x28,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103688:	8b 45 08             	mov    0x8(%ebp),%eax
8010368b:	89 04 24             	mov    %eax,(%esp)
8010368e:	e8 51 ff ff ff       	call   801035e4 <p2v>
80103693:	89 45 f4             	mov    %eax,-0xc(%ebp)
  e = addr+len;
80103696:	8b 45 0c             	mov    0xc(%ebp),%eax
80103699:	03 45 f4             	add    -0xc(%ebp),%eax
8010369c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
8010369f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
801036a5:	eb 3f                	jmp    801036e6 <mpsearch1+0x64>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036a7:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801036ae:	00 
801036af:	c7 44 24 04 60 88 10 	movl   $0x80108860,0x4(%esp)
801036b6:	80 
801036b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036ba:	89 04 24             	mov    %eax,(%esp)
801036bd:	e8 53 1b 00 00       	call   80105215 <memcmp>
801036c2:	85 c0                	test   %eax,%eax
801036c4:	75 1c                	jne    801036e2 <mpsearch1+0x60>
801036c6:	c7 44 24 04 10 00 00 	movl   $0x10,0x4(%esp)
801036cd:	00 
801036ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036d1:	89 04 24             	mov    %eax,(%esp)
801036d4:	e8 73 ff ff ff       	call   8010364c <sum>
801036d9:	84 c0                	test   %al,%al
801036db:	75 05                	jne    801036e2 <mpsearch1+0x60>
      return (struct mp*)p;
801036dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e0:	eb 11                	jmp    801036f3 <mpsearch1+0x71>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801036e2:	83 45 f0 10          	addl   $0x10,-0x10(%ebp)
801036e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801036ec:	72 b9                	jb     801036a7 <mpsearch1+0x25>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
801036ee:	b8 00 00 00 00       	mov    $0x0,%eax
}
801036f3:	c9                   	leave  
801036f4:	c3                   	ret    

801036f5 <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
801036f5:	55                   	push   %ebp
801036f6:	89 e5                	mov    %esp,%ebp
801036f8:	83 ec 28             	sub    $0x28,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
801036fb:	c7 45 ec 00 04 00 80 	movl   $0x80000400,-0x14(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103702:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103705:	83 c0 0f             	add    $0xf,%eax
80103708:	0f b6 00             	movzbl (%eax),%eax
8010370b:	0f b6 c0             	movzbl %al,%eax
8010370e:	89 c2                	mov    %eax,%edx
80103710:	c1 e2 08             	shl    $0x8,%edx
80103713:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103716:	83 c0 0e             	add    $0xe,%eax
80103719:	0f b6 00             	movzbl (%eax),%eax
8010371c:	0f b6 c0             	movzbl %al,%eax
8010371f:	09 d0                	or     %edx,%eax
80103721:	c1 e0 04             	shl    $0x4,%eax
80103724:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103727:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010372b:	74 21                	je     8010374e <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
8010372d:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103734:	00 
80103735:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103738:	89 04 24             	mov    %eax,(%esp)
8010373b:	e8 42 ff ff ff       	call   80103682 <mpsearch1>
80103740:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103743:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103747:	74 50                	je     80103799 <mpsearch+0xa4>
      return mp;
80103749:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010374c:	eb 5f                	jmp    801037ad <mpsearch+0xb8>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
8010374e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103751:	83 c0 14             	add    $0x14,%eax
80103754:	0f b6 00             	movzbl (%eax),%eax
80103757:	0f b6 c0             	movzbl %al,%eax
8010375a:	89 c2                	mov    %eax,%edx
8010375c:	c1 e2 08             	shl    $0x8,%edx
8010375f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103762:	83 c0 13             	add    $0x13,%eax
80103765:	0f b6 00             	movzbl (%eax),%eax
80103768:	0f b6 c0             	movzbl %al,%eax
8010376b:	09 d0                	or     %edx,%eax
8010376d:	c1 e0 0a             	shl    $0xa,%eax
80103770:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103773:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103776:	2d 00 04 00 00       	sub    $0x400,%eax
8010377b:	c7 44 24 04 00 04 00 	movl   $0x400,0x4(%esp)
80103782:	00 
80103783:	89 04 24             	mov    %eax,(%esp)
80103786:	e8 f7 fe ff ff       	call   80103682 <mpsearch1>
8010378b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010378e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103792:	74 05                	je     80103799 <mpsearch+0xa4>
      return mp;
80103794:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103797:	eb 14                	jmp    801037ad <mpsearch+0xb8>
  }
  return mpsearch1(0xF0000, 0x10000);
80103799:	c7 44 24 04 00 00 01 	movl   $0x10000,0x4(%esp)
801037a0:	00 
801037a1:	c7 04 24 00 00 0f 00 	movl   $0xf0000,(%esp)
801037a8:	e8 d5 fe ff ff       	call   80103682 <mpsearch1>
}
801037ad:	c9                   	leave  
801037ae:	c3                   	ret    

801037af <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
801037af:	55                   	push   %ebp
801037b0:	89 e5                	mov    %esp,%ebp
801037b2:	83 ec 28             	sub    $0x28,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037b5:	e8 3b ff ff ff       	call   801036f5 <mpsearch>
801037ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
801037bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801037c1:	74 0a                	je     801037cd <mpconfig+0x1e>
801037c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037c6:	8b 40 04             	mov    0x4(%eax),%eax
801037c9:	85 c0                	test   %eax,%eax
801037cb:	75 0a                	jne    801037d7 <mpconfig+0x28>
    return 0;
801037cd:	b8 00 00 00 00       	mov    $0x0,%eax
801037d2:	e9 83 00 00 00       	jmp    8010385a <mpconfig+0xab>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
801037d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037da:	8b 40 04             	mov    0x4(%eax),%eax
801037dd:	89 04 24             	mov    %eax,(%esp)
801037e0:	e8 ff fd ff ff       	call   801035e4 <p2v>
801037e5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801037e8:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801037ef:	00 
801037f0:	c7 44 24 04 65 88 10 	movl   $0x80108865,0x4(%esp)
801037f7:	80 
801037f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801037fb:	89 04 24             	mov    %eax,(%esp)
801037fe:	e8 12 1a 00 00       	call   80105215 <memcmp>
80103803:	85 c0                	test   %eax,%eax
80103805:	74 07                	je     8010380e <mpconfig+0x5f>
    return 0;
80103807:	b8 00 00 00 00       	mov    $0x0,%eax
8010380c:	eb 4c                	jmp    8010385a <mpconfig+0xab>
  if(conf->version != 1 && conf->version != 4)
8010380e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103811:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103815:	3c 01                	cmp    $0x1,%al
80103817:	74 12                	je     8010382b <mpconfig+0x7c>
80103819:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010381c:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103820:	3c 04                	cmp    $0x4,%al
80103822:	74 07                	je     8010382b <mpconfig+0x7c>
    return 0;
80103824:	b8 00 00 00 00       	mov    $0x0,%eax
80103829:	eb 2f                	jmp    8010385a <mpconfig+0xab>
  if(sum((uchar*)conf, conf->length) != 0)
8010382b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010382e:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103832:	0f b7 d0             	movzwl %ax,%edx
80103835:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103838:	89 54 24 04          	mov    %edx,0x4(%esp)
8010383c:	89 04 24             	mov    %eax,(%esp)
8010383f:	e8 08 fe ff ff       	call   8010364c <sum>
80103844:	84 c0                	test   %al,%al
80103846:	74 07                	je     8010384f <mpconfig+0xa0>
    return 0;
80103848:	b8 00 00 00 00       	mov    $0x0,%eax
8010384d:	eb 0b                	jmp    8010385a <mpconfig+0xab>
  *pmp = mp;
8010384f:	8b 45 08             	mov    0x8(%ebp),%eax
80103852:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103855:	89 10                	mov    %edx,(%eax)
  return conf;
80103857:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
8010385a:	c9                   	leave  
8010385b:	c3                   	ret    

8010385c <mpinit>:

void
mpinit(void)
{
8010385c:	55                   	push   %ebp
8010385d:	89 e5                	mov    %esp,%ebp
8010385f:	83 ec 38             	sub    $0x38,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
80103862:	c7 05 64 b6 10 80 40 	movl   $0x8010f940,0x8010b664
80103869:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
8010386c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010386f:	89 04 24             	mov    %eax,(%esp)
80103872:	e8 38 ff ff ff       	call   801037af <mpconfig>
80103877:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010387a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010387e:	0f 84 9d 01 00 00    	je     80103a21 <mpinit+0x1c5>
    return;
  ismp = 1;
80103884:	c7 05 24 f9 10 80 01 	movl   $0x1,0x8010f924
8010388b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010388e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103891:	8b 40 24             	mov    0x24(%eax),%eax
80103894:	a3 9c f8 10 80       	mov    %eax,0x8010f89c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103899:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010389c:	83 c0 2c             	add    $0x2c,%eax
8010389f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038a2:	8b 55 ec             	mov    -0x14(%ebp),%edx
801038a5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801038a8:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801038ac:	0f b7 c0             	movzwl %ax,%eax
801038af:	8d 04 02             	lea    (%edx,%eax,1),%eax
801038b2:	89 45 e8             	mov    %eax,-0x18(%ebp)
801038b5:	e9 f2 00 00 00       	jmp    801039ac <mpinit+0x150>
    switch(*p){
801038ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801038bd:	0f b6 00             	movzbl (%eax),%eax
801038c0:	0f b6 c0             	movzbl %al,%eax
801038c3:	83 f8 04             	cmp    $0x4,%eax
801038c6:	0f 87 bd 00 00 00    	ja     80103989 <mpinit+0x12d>
801038cc:	8b 04 85 a8 88 10 80 	mov    -0x7fef7758(,%eax,4),%eax
801038d3:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
801038d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801038d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(ncpu != proc->apicid){
801038db:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038de:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038e2:	0f b6 d0             	movzbl %al,%edx
801038e5:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801038ea:	39 c2                	cmp    %eax,%edx
801038ec:	74 2d                	je     8010391b <mpinit+0xbf>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
801038ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038f1:	0f b6 40 01          	movzbl 0x1(%eax),%eax
801038f5:	0f b6 d0             	movzbl %al,%edx
801038f8:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801038fd:	89 54 24 08          	mov    %edx,0x8(%esp)
80103901:	89 44 24 04          	mov    %eax,0x4(%esp)
80103905:	c7 04 24 6a 88 10 80 	movl   $0x8010886a,(%esp)
8010390c:	e8 89 ca ff ff       	call   8010039a <cprintf>
        ismp = 0;
80103911:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
80103918:	00 00 00 
      }
      if(proc->flags & MPBOOT)
8010391b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010391e:	0f b6 40 03          	movzbl 0x3(%eax),%eax
80103922:	0f b6 c0             	movzbl %al,%eax
80103925:	83 e0 02             	and    $0x2,%eax
80103928:	85 c0                	test   %eax,%eax
8010392a:	74 15                	je     80103941 <mpinit+0xe5>
        bcpu = &cpus[ncpu];
8010392c:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103931:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103937:	05 40 f9 10 80       	add    $0x8010f940,%eax
8010393c:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
80103941:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103946:	8b 15 20 ff 10 80    	mov    0x8010ff20,%edx
8010394c:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80103952:	88 90 40 f9 10 80    	mov    %dl,-0x7fef06c0(%eax)
      ncpu++;
80103958:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
8010395d:	83 c0 01             	add    $0x1,%eax
80103960:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
      p += sizeof(struct mpproc);
80103965:	83 45 e4 14          	addl   $0x14,-0x1c(%ebp)
      continue;
80103969:	eb 41                	jmp    801039ac <mpinit+0x150>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
8010396b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010396e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      ioapicid = ioapic->apicno;
80103971:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103974:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103978:	a2 20 f9 10 80       	mov    %al,0x8010f920
      p += sizeof(struct mpioapic);
8010397d:	83 45 e4 08          	addl   $0x8,-0x1c(%ebp)
      continue;
80103981:	eb 29                	jmp    801039ac <mpinit+0x150>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103983:	83 45 e4 08          	addl   $0x8,-0x1c(%ebp)
      continue;
80103987:	eb 23                	jmp    801039ac <mpinit+0x150>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103989:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010398c:	0f b6 00             	movzbl (%eax),%eax
8010398f:	0f b6 c0             	movzbl %al,%eax
80103992:	89 44 24 04          	mov    %eax,0x4(%esp)
80103996:	c7 04 24 88 88 10 80 	movl   $0x80108888,(%esp)
8010399d:	e8 f8 c9 ff ff       	call   8010039a <cprintf>
      ismp = 0;
801039a2:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
801039a9:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801039ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801039af:	3b 45 e8             	cmp    -0x18(%ebp),%eax
801039b2:	0f 82 02 ff ff ff    	jb     801038ba <mpinit+0x5e>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
801039b8:	a1 24 f9 10 80       	mov    0x8010f924,%eax
801039bd:	85 c0                	test   %eax,%eax
801039bf:	75 1d                	jne    801039de <mpinit+0x182>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
801039c1:	c7 05 20 ff 10 80 01 	movl   $0x1,0x8010ff20
801039c8:	00 00 00 
    lapic = 0;
801039cb:	c7 05 9c f8 10 80 00 	movl   $0x0,0x8010f89c
801039d2:	00 00 00 
    ioapicid = 0;
801039d5:	c6 05 20 f9 10 80 00 	movb   $0x0,0x8010f920
    return;
801039dc:	eb 44                	jmp    80103a22 <mpinit+0x1c6>
  }

  if(mp->imcrp){
801039de:	8b 45 e0             	mov    -0x20(%ebp),%eax
801039e1:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
801039e5:	84 c0                	test   %al,%al
801039e7:	74 39                	je     80103a22 <mpinit+0x1c6>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
801039e9:	c7 44 24 04 70 00 00 	movl   $0x70,0x4(%esp)
801039f0:	00 
801039f1:	c7 04 24 22 00 00 00 	movl   $0x22,(%esp)
801039f8:	e8 11 fc ff ff       	call   8010360e <outb>
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801039fd:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103a04:	e8 e8 fb ff ff       	call   801035f1 <inb>
80103a09:	83 c8 01             	or     $0x1,%eax
80103a0c:	0f b6 c0             	movzbl %al,%eax
80103a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a13:	c7 04 24 23 00 00 00 	movl   $0x23,(%esp)
80103a1a:	e8 ef fb ff ff       	call   8010360e <outb>
80103a1f:	eb 01                	jmp    80103a22 <mpinit+0x1c6>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103a21:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103a22:	c9                   	leave  
80103a23:	c3                   	ret    

80103a24 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103a24:	55                   	push   %ebp
80103a25:	89 e5                	mov    %esp,%ebp
80103a27:	83 ec 08             	sub    $0x8,%esp
80103a2a:	8b 55 08             	mov    0x8(%ebp),%edx
80103a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
80103a30:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103a34:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a37:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a3b:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a3f:	ee                   	out    %al,(%dx)
}
80103a40:	c9                   	leave  
80103a41:	c3                   	ret    

80103a42 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103a42:	55                   	push   %ebp
80103a43:	89 e5                	mov    %esp,%ebp
80103a45:	83 ec 0c             	sub    $0xc,%esp
80103a48:	8b 45 08             	mov    0x8(%ebp),%eax
80103a4b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103a4f:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a53:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103a59:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a5d:	0f b6 c0             	movzbl %al,%eax
80103a60:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a64:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103a6b:	e8 b4 ff ff ff       	call   80103a24 <outb>
  outb(IO_PIC2+1, mask >> 8);
80103a70:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103a74:	66 c1 e8 08          	shr    $0x8,%ax
80103a78:	0f b6 c0             	movzbl %al,%eax
80103a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a7f:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103a86:	e8 99 ff ff ff       	call   80103a24 <outb>
}
80103a8b:	c9                   	leave  
80103a8c:	c3                   	ret    

80103a8d <picenable>:

void
picenable(int irq)
{
80103a8d:	55                   	push   %ebp
80103a8e:	89 e5                	mov    %esp,%ebp
80103a90:	53                   	push   %ebx
80103a91:	83 ec 04             	sub    $0x4,%esp
  picsetmask(irqmask & ~(1<<irq));
80103a94:	8b 45 08             	mov    0x8(%ebp),%eax
80103a97:	ba 01 00 00 00       	mov    $0x1,%edx
80103a9c:	89 d3                	mov    %edx,%ebx
80103a9e:	89 c1                	mov    %eax,%ecx
80103aa0:	d3 e3                	shl    %cl,%ebx
80103aa2:	89 d8                	mov    %ebx,%eax
80103aa4:	89 c2                	mov    %eax,%edx
80103aa6:	f7 d2                	not    %edx
80103aa8:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103aaf:	21 d0                	and    %edx,%eax
80103ab1:	0f b7 c0             	movzwl %ax,%eax
80103ab4:	89 04 24             	mov    %eax,(%esp)
80103ab7:	e8 86 ff ff ff       	call   80103a42 <picsetmask>
}
80103abc:	83 c4 04             	add    $0x4,%esp
80103abf:	5b                   	pop    %ebx
80103ac0:	5d                   	pop    %ebp
80103ac1:	c3                   	ret    

80103ac2 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103ac2:	55                   	push   %ebp
80103ac3:	89 e5                	mov    %esp,%ebp
80103ac5:	83 ec 08             	sub    $0x8,%esp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103ac8:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103acf:	00 
80103ad0:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103ad7:	e8 48 ff ff ff       	call   80103a24 <outb>
  outb(IO_PIC2+1, 0xFF);
80103adc:	c7 44 24 04 ff 00 00 	movl   $0xff,0x4(%esp)
80103ae3:	00 
80103ae4:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103aeb:	e8 34 ff ff ff       	call   80103a24 <outb>

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103af0:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103af7:	00 
80103af8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103aff:	e8 20 ff ff ff       	call   80103a24 <outb>

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103b04:	c7 44 24 04 20 00 00 	movl   $0x20,0x4(%esp)
80103b0b:	00 
80103b0c:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b13:	e8 0c ff ff ff       	call   80103a24 <outb>

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103b18:	c7 44 24 04 04 00 00 	movl   $0x4,0x4(%esp)
80103b1f:	00 
80103b20:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b27:	e8 f8 fe ff ff       	call   80103a24 <outb>
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103b2c:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b33:	00 
80103b34:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
80103b3b:	e8 e4 fe ff ff       	call   80103a24 <outb>

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103b40:	c7 44 24 04 11 00 00 	movl   $0x11,0x4(%esp)
80103b47:	00 
80103b48:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103b4f:	e8 d0 fe ff ff       	call   80103a24 <outb>
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103b54:	c7 44 24 04 28 00 00 	movl   $0x28,0x4(%esp)
80103b5b:	00 
80103b5c:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b63:	e8 bc fe ff ff       	call   80103a24 <outb>
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103b68:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80103b6f:	00 
80103b70:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b77:	e8 a8 fe ff ff       	call   80103a24 <outb>
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103b7c:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80103b83:	00 
80103b84:	c7 04 24 a1 00 00 00 	movl   $0xa1,(%esp)
80103b8b:	e8 94 fe ff ff       	call   80103a24 <outb>

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103b90:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103b97:	00 
80103b98:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103b9f:	e8 80 fe ff ff       	call   80103a24 <outb>
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103ba4:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103bab:	00 
80103bac:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80103bb3:	e8 6c fe ff ff       	call   80103a24 <outb>

  outb(IO_PIC2, 0x68);             // OCW3
80103bb8:	c7 44 24 04 68 00 00 	movl   $0x68,0x4(%esp)
80103bbf:	00 
80103bc0:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103bc7:	e8 58 fe ff ff       	call   80103a24 <outb>
  outb(IO_PIC2, 0x0a);             // OCW3
80103bcc:	c7 44 24 04 0a 00 00 	movl   $0xa,0x4(%esp)
80103bd3:	00 
80103bd4:	c7 04 24 a0 00 00 00 	movl   $0xa0,(%esp)
80103bdb:	e8 44 fe ff ff       	call   80103a24 <outb>

  if(irqmask != 0xFFFF)
80103be0:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103be7:	66 83 f8 ff          	cmp    $0xffffffff,%ax
80103beb:	74 12                	je     80103bff <picinit+0x13d>
    picsetmask(irqmask);
80103bed:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103bf4:	0f b7 c0             	movzwl %ax,%eax
80103bf7:	89 04 24             	mov    %eax,(%esp)
80103bfa:	e8 43 fe ff ff       	call   80103a42 <picsetmask>
}
80103bff:	c9                   	leave  
80103c00:	c3                   	ret    
80103c01:	00 00                	add    %al,(%eax)
	...

80103c04 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103c04:	55                   	push   %ebp
80103c05:	89 e5                	mov    %esp,%ebp
80103c07:	83 ec 28             	sub    $0x28,%esp
  struct pipe *p;

  p = 0;
80103c0a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103c11:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c14:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103c1a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c1d:	8b 10                	mov    (%eax),%edx
80103c1f:	8b 45 08             	mov    0x8(%ebp),%eax
80103c22:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103c24:	e8 fb d2 ff ff       	call   80100f24 <filealloc>
80103c29:	8b 55 08             	mov    0x8(%ebp),%edx
80103c2c:	89 02                	mov    %eax,(%edx)
80103c2e:	8b 45 08             	mov    0x8(%ebp),%eax
80103c31:	8b 00                	mov    (%eax),%eax
80103c33:	85 c0                	test   %eax,%eax
80103c35:	0f 84 c8 00 00 00    	je     80103d03 <pipealloc+0xff>
80103c3b:	e8 e4 d2 ff ff       	call   80100f24 <filealloc>
80103c40:	8b 55 0c             	mov    0xc(%ebp),%edx
80103c43:	89 02                	mov    %eax,(%edx)
80103c45:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c48:	8b 00                	mov    (%eax),%eax
80103c4a:	85 c0                	test   %eax,%eax
80103c4c:	0f 84 b1 00 00 00    	je     80103d03 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103c52:	e8 b3 ee ff ff       	call   80102b0a <kalloc>
80103c57:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c5e:	0f 84 9e 00 00 00    	je     80103d02 <pipealloc+0xfe>
    goto bad;
  p->readopen = 1;
80103c64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c67:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103c6e:	00 00 00 
  p->writeopen = 1;
80103c71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c74:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103c7b:	00 00 00 
  p->nwrite = 0;
80103c7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c81:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103c88:	00 00 00 
  p->nread = 0;
80103c8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c8e:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103c95:	00 00 00 
  initlock(&p->lock, "pipe");
80103c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c9b:	c7 44 24 04 bc 88 10 	movl   $0x801088bc,0x4(%esp)
80103ca2:	80 
80103ca3:	89 04 24             	mov    %eax,(%esp)
80103ca6:	e8 83 12 00 00       	call   80104f2e <initlock>
  (*f0)->type = FD_PIPE;
80103cab:	8b 45 08             	mov    0x8(%ebp),%eax
80103cae:	8b 00                	mov    (%eax),%eax
80103cb0:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103cb6:	8b 45 08             	mov    0x8(%ebp),%eax
80103cb9:	8b 00                	mov    (%eax),%eax
80103cbb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103cbf:	8b 45 08             	mov    0x8(%ebp),%eax
80103cc2:	8b 00                	mov    (%eax),%eax
80103cc4:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103cc8:	8b 45 08             	mov    0x8(%ebp),%eax
80103ccb:	8b 00                	mov    (%eax),%eax
80103ccd:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cd0:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103cd3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cd6:	8b 00                	mov    (%eax),%eax
80103cd8:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103cde:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ce1:	8b 00                	mov    (%eax),%eax
80103ce3:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cea:	8b 00                	mov    (%eax),%eax
80103cec:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80103cf3:	8b 00                	mov    (%eax),%eax
80103cf5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103cf8:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103cfb:	b8 00 00 00 00       	mov    $0x0,%eax
80103d00:	eb 43                	jmp    80103d45 <pipealloc+0x141>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103d02:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103d03:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103d07:	74 0b                	je     80103d14 <pipealloc+0x110>
    kfree((char*)p);
80103d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d0c:	89 04 24             	mov    %eax,(%esp)
80103d0f:	e8 5d ed ff ff       	call   80102a71 <kfree>
  if(*f0)
80103d14:	8b 45 08             	mov    0x8(%ebp),%eax
80103d17:	8b 00                	mov    (%eax),%eax
80103d19:	85 c0                	test   %eax,%eax
80103d1b:	74 0d                	je     80103d2a <pipealloc+0x126>
    fileclose(*f0);
80103d1d:	8b 45 08             	mov    0x8(%ebp),%eax
80103d20:	8b 00                	mov    (%eax),%eax
80103d22:	89 04 24             	mov    %eax,(%esp)
80103d25:	e8 a3 d2 ff ff       	call   80100fcd <fileclose>
  if(*f1)
80103d2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d2d:	8b 00                	mov    (%eax),%eax
80103d2f:	85 c0                	test   %eax,%eax
80103d31:	74 0d                	je     80103d40 <pipealloc+0x13c>
    fileclose(*f1);
80103d33:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d36:	8b 00                	mov    (%eax),%eax
80103d38:	89 04 24             	mov    %eax,(%esp)
80103d3b:	e8 8d d2 ff ff       	call   80100fcd <fileclose>
  return -1;
80103d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d45:	c9                   	leave  
80103d46:	c3                   	ret    

80103d47 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103d47:	55                   	push   %ebp
80103d48:	89 e5                	mov    %esp,%ebp
80103d4a:	83 ec 18             	sub    $0x18,%esp
  acquire(&p->lock);
80103d4d:	8b 45 08             	mov    0x8(%ebp),%eax
80103d50:	89 04 24             	mov    %eax,(%esp)
80103d53:	e8 f7 11 00 00       	call   80104f4f <acquire>
  if(writable){
80103d58:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103d5c:	74 1f                	je     80103d7d <pipeclose+0x36>
    p->writeopen = 0;
80103d5e:	8b 45 08             	mov    0x8(%ebp),%eax
80103d61:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103d68:	00 00 00 
    wakeup(&p->nread);
80103d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80103d6e:	05 34 02 00 00       	add    $0x234,%eax
80103d73:	89 04 24             	mov    %eax,(%esp)
80103d76:	e8 a1 0f 00 00       	call   80104d1c <wakeup>
80103d7b:	eb 1d                	jmp    80103d9a <pipeclose+0x53>
  } else {
    p->readopen = 0;
80103d7d:	8b 45 08             	mov    0x8(%ebp),%eax
80103d80:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103d87:	00 00 00 
    wakeup(&p->nwrite);
80103d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80103d8d:	05 38 02 00 00       	add    $0x238,%eax
80103d92:	89 04 24             	mov    %eax,(%esp)
80103d95:	e8 82 0f 00 00       	call   80104d1c <wakeup>
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103d9a:	8b 45 08             	mov    0x8(%ebp),%eax
80103d9d:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103da3:	85 c0                	test   %eax,%eax
80103da5:	75 25                	jne    80103dcc <pipeclose+0x85>
80103da7:	8b 45 08             	mov    0x8(%ebp),%eax
80103daa:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103db0:	85 c0                	test   %eax,%eax
80103db2:	75 18                	jne    80103dcc <pipeclose+0x85>
    release(&p->lock);
80103db4:	8b 45 08             	mov    0x8(%ebp),%eax
80103db7:	89 04 24             	mov    %eax,(%esp)
80103dba:	e8 f1 11 00 00       	call   80104fb0 <release>
    kfree((char*)p);
80103dbf:	8b 45 08             	mov    0x8(%ebp),%eax
80103dc2:	89 04 24             	mov    %eax,(%esp)
80103dc5:	e8 a7 ec ff ff       	call   80102a71 <kfree>
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103dca:	eb 0b                	jmp    80103dd7 <pipeclose+0x90>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103dcc:	8b 45 08             	mov    0x8(%ebp),%eax
80103dcf:	89 04 24             	mov    %eax,(%esp)
80103dd2:	e8 d9 11 00 00       	call   80104fb0 <release>
}
80103dd7:	c9                   	leave  
80103dd8:	c3                   	ret    

80103dd9 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103dd9:	55                   	push   %ebp
80103dda:	89 e5                	mov    %esp,%ebp
80103ddc:	53                   	push   %ebx
80103ddd:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103de0:	8b 45 08             	mov    0x8(%ebp),%eax
80103de3:	89 04 24             	mov    %eax,(%esp)
80103de6:	e8 64 11 00 00       	call   80104f4f <acquire>
  for(i = 0; i < n; i++){
80103deb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103df2:	e9 a6 00 00 00       	jmp    80103e9d <pipewrite+0xc4>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80103df7:	8b 45 08             	mov    0x8(%ebp),%eax
80103dfa:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103e00:	85 c0                	test   %eax,%eax
80103e02:	74 0d                	je     80103e11 <pipewrite+0x38>
80103e04:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e0a:	8b 40 24             	mov    0x24(%eax),%eax
80103e0d:	85 c0                	test   %eax,%eax
80103e0f:	74 15                	je     80103e26 <pipewrite+0x4d>
        release(&p->lock);
80103e11:	8b 45 08             	mov    0x8(%ebp),%eax
80103e14:	89 04 24             	mov    %eax,(%esp)
80103e17:	e8 94 11 00 00       	call   80104fb0 <release>
        return -1;
80103e1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e21:	e9 9d 00 00 00       	jmp    80103ec3 <pipewrite+0xea>
      }
      wakeup(&p->nread);
80103e26:	8b 45 08             	mov    0x8(%ebp),%eax
80103e29:	05 34 02 00 00       	add    $0x234,%eax
80103e2e:	89 04 24             	mov    %eax,(%esp)
80103e31:	e8 e6 0e 00 00       	call   80104d1c <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e36:	8b 45 08             	mov    0x8(%ebp),%eax
80103e39:	8b 55 08             	mov    0x8(%ebp),%edx
80103e3c:	81 c2 38 02 00 00    	add    $0x238,%edx
80103e42:	89 44 24 04          	mov    %eax,0x4(%esp)
80103e46:	89 14 24             	mov    %edx,(%esp)
80103e49:	e8 88 0d 00 00       	call   80104bd6 <sleep>
80103e4e:	eb 01                	jmp    80103e51 <pipewrite+0x78>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103e50:	90                   	nop
80103e51:	8b 45 08             	mov    0x8(%ebp),%eax
80103e54:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103e5a:	8b 45 08             	mov    0x8(%ebp),%eax
80103e5d:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103e63:	05 00 02 00 00       	add    $0x200,%eax
80103e68:	39 c2                	cmp    %eax,%edx
80103e6a:	74 8b                	je     80103df7 <pipewrite+0x1e>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103e6c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e6f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103e75:	89 c3                	mov    %eax,%ebx
80103e77:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80103e7d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103e80:	03 55 0c             	add    0xc(%ebp),%edx
80103e83:	0f b6 0a             	movzbl (%edx),%ecx
80103e86:	8b 55 08             	mov    0x8(%ebp),%edx
80103e89:	88 4c 1a 34          	mov    %cl,0x34(%edx,%ebx,1)
80103e8d:	8d 50 01             	lea    0x1(%eax),%edx
80103e90:	8b 45 08             	mov    0x8(%ebp),%eax
80103e93:	89 90 38 02 00 00    	mov    %edx,0x238(%eax)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103e99:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103e9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ea0:	3b 45 10             	cmp    0x10(%ebp),%eax
80103ea3:	7c ab                	jl     80103e50 <pipewrite+0x77>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103ea5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ea8:	05 34 02 00 00       	add    $0x234,%eax
80103ead:	89 04 24             	mov    %eax,(%esp)
80103eb0:	e8 67 0e 00 00       	call   80104d1c <wakeup>
  release(&p->lock);
80103eb5:	8b 45 08             	mov    0x8(%ebp),%eax
80103eb8:	89 04 24             	mov    %eax,(%esp)
80103ebb:	e8 f0 10 00 00       	call   80104fb0 <release>
  return n;
80103ec0:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103ec3:	83 c4 24             	add    $0x24,%esp
80103ec6:	5b                   	pop    %ebx
80103ec7:	5d                   	pop    %ebp
80103ec8:	c3                   	ret    

80103ec9 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103ec9:	55                   	push   %ebp
80103eca:	89 e5                	mov    %esp,%ebp
80103ecc:	53                   	push   %ebx
80103ecd:	83 ec 24             	sub    $0x24,%esp
  int i;

  acquire(&p->lock);
80103ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed3:	89 04 24             	mov    %eax,(%esp)
80103ed6:	e8 74 10 00 00       	call   80104f4f <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103edb:	eb 3a                	jmp    80103f17 <piperead+0x4e>
    if(proc->killed){
80103edd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ee3:	8b 40 24             	mov    0x24(%eax),%eax
80103ee6:	85 c0                	test   %eax,%eax
80103ee8:	74 15                	je     80103eff <piperead+0x36>
      release(&p->lock);
80103eea:	8b 45 08             	mov    0x8(%ebp),%eax
80103eed:	89 04 24             	mov    %eax,(%esp)
80103ef0:	e8 bb 10 00 00       	call   80104fb0 <release>
      return -1;
80103ef5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103efa:	e9 b6 00 00 00       	jmp    80103fb5 <piperead+0xec>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103eff:	8b 45 08             	mov    0x8(%ebp),%eax
80103f02:	8b 55 08             	mov    0x8(%ebp),%edx
80103f05:	81 c2 34 02 00 00    	add    $0x234,%edx
80103f0b:	89 44 24 04          	mov    %eax,0x4(%esp)
80103f0f:	89 14 24             	mov    %edx,(%esp)
80103f12:	e8 bf 0c 00 00       	call   80104bd6 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103f17:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1a:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f20:	8b 45 08             	mov    0x8(%ebp),%eax
80103f23:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f29:	39 c2                	cmp    %eax,%edx
80103f2b:	75 0d                	jne    80103f3a <piperead+0x71>
80103f2d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f30:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103f36:	85 c0                	test   %eax,%eax
80103f38:	75 a3                	jne    80103edd <piperead+0x14>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103f41:	eb 49                	jmp    80103f8c <piperead+0xc3>
    if(p->nread == p->nwrite)
80103f43:	8b 45 08             	mov    0x8(%ebp),%eax
80103f46:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f4c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f4f:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f55:	39 c2                	cmp    %eax,%edx
80103f57:	74 3d                	je     80103f96 <piperead+0xcd>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103f59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f5c:	89 c2                	mov    %eax,%edx
80103f5e:	03 55 0c             	add    0xc(%ebp),%edx
80103f61:	8b 45 08             	mov    0x8(%ebp),%eax
80103f64:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103f6a:	89 c3                	mov    %eax,%ebx
80103f6c:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80103f72:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103f75:	0f b6 4c 19 34       	movzbl 0x34(%ecx,%ebx,1),%ecx
80103f7a:	88 0a                	mov    %cl,(%edx)
80103f7c:	8d 50 01             	lea    0x1(%eax),%edx
80103f7f:	8b 45 08             	mov    0x8(%ebp),%eax
80103f82:	89 90 34 02 00 00    	mov    %edx,0x234(%eax)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103f88:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103f8c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f8f:	3b 45 10             	cmp    0x10(%ebp),%eax
80103f92:	7c af                	jl     80103f43 <piperead+0x7a>
80103f94:	eb 01                	jmp    80103f97 <piperead+0xce>
    if(p->nread == p->nwrite)
      break;
80103f96:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103f97:	8b 45 08             	mov    0x8(%ebp),%eax
80103f9a:	05 38 02 00 00       	add    $0x238,%eax
80103f9f:	89 04 24             	mov    %eax,(%esp)
80103fa2:	e8 75 0d 00 00       	call   80104d1c <wakeup>
  release(&p->lock);
80103fa7:	8b 45 08             	mov    0x8(%ebp),%eax
80103faa:	89 04 24             	mov    %eax,(%esp)
80103fad:	e8 fe 0f 00 00       	call   80104fb0 <release>
  return i;
80103fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80103fb5:	83 c4 24             	add    $0x24,%esp
80103fb8:	5b                   	pop    %ebx
80103fb9:	5d                   	pop    %ebp
80103fba:	c3                   	ret    
	...

80103fbc <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80103fbc:	55                   	push   %ebp
80103fbd:	89 e5                	mov    %esp,%ebp
80103fbf:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103fc2:	9c                   	pushf  
80103fc3:	58                   	pop    %eax
80103fc4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80103fc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103fca:	c9                   	leave  
80103fcb:	c3                   	ret    

80103fcc <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80103fcc:	55                   	push   %ebp
80103fcd:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80103fcf:	fb                   	sti    
}
80103fd0:	5d                   	pop    %ebp
80103fd1:	c3                   	ret    

80103fd2 <memcop>:

static void wakeup1(void *chan);

    void*
memcop(void *dst, void *src, uint n)
{
80103fd2:	55                   	push   %ebp
80103fd3:	89 e5                	mov    %esp,%ebp
80103fd5:	83 ec 10             	sub    $0x10,%esp
    const char *s;
    char *d;

    s = src;
80103fd8:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fdb:	89 45 f8             	mov    %eax,-0x8(%ebp)
    d = dst;
80103fde:	8b 45 08             	mov    0x8(%ebp),%eax
80103fe1:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if(s < d && s + n > d){
80103fe4:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103fe7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80103fea:	73 55                	jae    80104041 <memcop+0x6f>
80103fec:	8b 45 10             	mov    0x10(%ebp),%eax
80103fef:	8b 55 f8             	mov    -0x8(%ebp),%edx
80103ff2:	8d 04 02             	lea    (%edx,%eax,1),%eax
80103ff5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80103ff8:	76 4a                	jbe    80104044 <memcop+0x72>
        s += n;
80103ffa:	8b 45 10             	mov    0x10(%ebp),%eax
80103ffd:	01 45 f8             	add    %eax,-0x8(%ebp)
        d += n;
80104000:	8b 45 10             	mov    0x10(%ebp),%eax
80104003:	01 45 fc             	add    %eax,-0x4(%ebp)
        while(n-- > 0)
80104006:	eb 13                	jmp    8010401b <memcop+0x49>
            *--d = *--s;
80104008:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010400c:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80104010:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104013:	0f b6 10             	movzbl (%eax),%edx
80104016:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104019:	88 10                	mov    %dl,(%eax)
    s = src;
    d = dst;
    if(s < d && s + n > d){
        s += n;
        d += n;
        while(n-- > 0)
8010401b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010401f:	0f 95 c0             	setne  %al
80104022:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104026:	84 c0                	test   %al,%al
80104028:	75 de                	jne    80104008 <memcop+0x36>
    const char *s;
    char *d;

    s = src;
    d = dst;
    if(s < d && s + n > d){
8010402a:	eb 28                	jmp    80104054 <memcop+0x82>
        d += n;
        while(n-- > 0)
            *--d = *--s;
    } else
        while(n-- > 0)
            *d++ = *s++;
8010402c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010402f:	0f b6 10             	movzbl (%eax),%edx
80104032:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104035:	88 10                	mov    %dl,(%eax)
80104037:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010403b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010403f:	eb 04                	jmp    80104045 <memcop+0x73>
        s += n;
        d += n;
        while(n-- > 0)
            *--d = *--s;
    } else
        while(n-- > 0)
80104041:	90                   	nop
80104042:	eb 01                	jmp    80104045 <memcop+0x73>
80104044:	90                   	nop
80104045:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104049:	0f 95 c0             	setne  %al
8010404c:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104050:	84 c0                	test   %al,%al
80104052:	75 d8                	jne    8010402c <memcop+0x5a>
            *d++ = *s++;

    return dst;
80104054:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104057:	c9                   	leave  
80104058:	c3                   	ret    

80104059 <pinit>:


    void
pinit(void)
{
80104059:	55                   	push   %ebp
8010405a:	89 e5                	mov    %esp,%ebp
8010405c:	83 ec 18             	sub    $0x18,%esp
    initlock(&ptable.lock, "ptable");
8010405f:	c7 44 24 04 c4 88 10 	movl   $0x801088c4,0x4(%esp)
80104066:	80 
80104067:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
8010406e:	e8 bb 0e 00 00       	call   80104f2e <initlock>
}
80104073:	c9                   	leave  
80104074:	c3                   	ret    

80104075 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
    static struct proc*
allocproc(void)
{
80104075:	55                   	push   %ebp
80104076:	89 e5                	mov    %esp,%ebp
80104078:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
8010407b:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104082:	e8 c8 0e 00 00       	call   80104f4f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104087:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
8010408e:	eb 11                	jmp    801040a1 <allocproc+0x2c>
        if(p->state == UNUSED)
80104090:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104093:	8b 40 0c             	mov    0xc(%eax),%eax
80104096:	85 c0                	test   %eax,%eax
80104098:	74 27                	je     801040c1 <allocproc+0x4c>
{
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010409a:	81 45 f0 84 00 00 00 	addl   $0x84,-0x10(%ebp)
801040a1:	b8 74 20 11 80       	mov    $0x80112074,%eax
801040a6:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801040a9:	72 e5                	jb     80104090 <allocproc+0x1b>
        if(p->state == UNUSED)
            goto found;
    release(&ptable.lock);
801040ab:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801040b2:	e8 f9 0e 00 00       	call   80104fb0 <release>
    return 0;
801040b7:	b8 00 00 00 00       	mov    $0x0,%eax
801040bc:	e9 b5 00 00 00       	jmp    80104176 <allocproc+0x101>
    char *sp;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
        if(p->state == UNUSED)
            goto found;
801040c1:	90                   	nop
    release(&ptable.lock);
    return 0;

found:
    p->state = EMBRYO;
801040c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040c5:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
    p->pid = nextpid++;
801040cc:	a1 04 b0 10 80       	mov    0x8010b004,%eax
801040d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040d4:	89 42 10             	mov    %eax,0x10(%edx)
801040d7:	83 c0 01             	add    $0x1,%eax
801040da:	a3 04 b0 10 80       	mov    %eax,0x8010b004
    release(&ptable.lock);
801040df:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801040e6:	e8 c5 0e 00 00       	call   80104fb0 <release>

    // Allocate kernel stack.
    if((p->kstack = kalloc()) == 0){
801040eb:	e8 1a ea ff ff       	call   80102b0a <kalloc>
801040f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
801040f3:	89 42 08             	mov    %eax,0x8(%edx)
801040f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801040f9:	8b 40 08             	mov    0x8(%eax),%eax
801040fc:	85 c0                	test   %eax,%eax
801040fe:	75 11                	jne    80104111 <allocproc+0x9c>
        p->state = UNUSED;
80104100:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104103:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return 0;
8010410a:	b8 00 00 00 00       	mov    $0x0,%eax
8010410f:	eb 65                	jmp    80104176 <allocproc+0x101>
    }
    sp = p->kstack + KSTACKSIZE;
80104111:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104114:	8b 40 08             	mov    0x8(%eax),%eax
80104117:	05 00 10 00 00       	add    $0x1000,%eax
8010411c:	89 45 f4             	mov    %eax,-0xc(%ebp)

    // Leave room for trap frame.
    sp -= sizeof *p->tf;
8010411f:	83 6d f4 4c          	subl   $0x4c,-0xc(%ebp)
    p->tf = (struct trapframe*)sp;
80104123:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104126:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104129:	89 50 18             	mov    %edx,0x18(%eax)

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 4;
8010412c:	83 6d f4 04          	subl   $0x4,-0xc(%ebp)
    *(uint*)sp = (uint)trapret;
80104130:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104133:	ba a8 66 10 80       	mov    $0x801066a8,%edx
80104138:	89 10                	mov    %edx,(%eax)

    sp -= sizeof *p->context;
8010413a:	83 6d f4 14          	subl   $0x14,-0xc(%ebp)
    p->context = (struct context*)sp;
8010413e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104141:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104144:	89 50 1c             	mov    %edx,0x1c(%eax)
    memset(p->context, 0, sizeof *p->context);
80104147:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010414a:	8b 40 1c             	mov    0x1c(%eax),%eax
8010414d:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104154:	00 
80104155:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010415c:	00 
8010415d:	89 04 24             	mov    %eax,(%esp)
80104160:	e8 39 10 00 00       	call   8010519e <memset>
    p->context->eip = (uint)forkret;
80104165:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104168:	8b 40 1c             	mov    0x1c(%eax),%eax
8010416b:	ba aa 4b 10 80       	mov    $0x80104baa,%edx
80104170:	89 50 10             	mov    %edx,0x10(%eax)

    return p;
80104173:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104176:	c9                   	leave  
80104177:	c3                   	ret    

80104178 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
    void
userinit(void)
{
80104178:	55                   	push   %ebp
80104179:	89 e5                	mov    %esp,%ebp
8010417b:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
8010417e:	e8 f2 fe ff ff       	call   80104075 <allocproc>
80104183:	89 45 f4             	mov    %eax,-0xc(%ebp)
    initproc = p;
80104186:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104189:	a3 68 b6 10 80       	mov    %eax,0x8010b668
    if((p->pgdir = setupkvm()) == 0)
8010418e:	e8 fe 3b 00 00       	call   80107d91 <setupkvm>
80104193:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104196:	89 42 04             	mov    %eax,0x4(%edx)
80104199:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010419c:	8b 40 04             	mov    0x4(%eax),%eax
8010419f:	85 c0                	test   %eax,%eax
801041a1:	75 0c                	jne    801041af <userinit+0x37>
        panic("userinit: out of memory?");
801041a3:	c7 04 24 cb 88 10 80 	movl   $0x801088cb,(%esp)
801041aa:	e8 8b c3 ff ff       	call   8010053a <panic>
    inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801041af:	ba 2c 00 00 00       	mov    $0x2c,%edx
801041b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041b7:	8b 40 04             	mov    0x4(%eax),%eax
801041ba:	89 54 24 08          	mov    %edx,0x8(%esp)
801041be:	c7 44 24 04 00 b5 10 	movl   $0x8010b500,0x4(%esp)
801041c5:	80 
801041c6:	89 04 24             	mov    %eax,(%esp)
801041c9:	e8 1c 3e 00 00       	call   80107fea <inituvm>
    p->sz = PGSIZE;
801041ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041d1:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
    memset(p->tf, 0, sizeof(*p->tf));
801041d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041da:	8b 40 18             	mov    0x18(%eax),%eax
801041dd:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
801041e4:	00 
801041e5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801041ec:	00 
801041ed:	89 04 24             	mov    %eax,(%esp)
801041f0:	e8 a9 0f 00 00       	call   8010519e <memset>
    p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f8:	8b 40 18             	mov    0x18(%eax),%eax
801041fb:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
    p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104201:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104204:	8b 40 18             	mov    0x18(%eax),%eax
80104207:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
    p->tf->es = p->tf->ds;
8010420d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104210:	8b 40 18             	mov    0x18(%eax),%eax
80104213:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104216:	8b 52 18             	mov    0x18(%edx),%edx
80104219:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010421d:	66 89 50 28          	mov    %dx,0x28(%eax)
    p->tf->ss = p->tf->ds;
80104221:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104224:	8b 40 18             	mov    0x18(%eax),%eax
80104227:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010422a:	8b 52 18             	mov    0x18(%edx),%edx
8010422d:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104231:	66 89 50 48          	mov    %dx,0x48(%eax)
    p->tf->eflags = FL_IF;
80104235:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104238:	8b 40 18             	mov    0x18(%eax),%eax
8010423b:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
    p->tf->esp = PGSIZE;
80104242:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104245:	8b 40 18             	mov    0x18(%eax),%eax
80104248:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
    p->tf->eip = 0;  // beginning of initcode.S
8010424f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104252:	8b 40 18             	mov    0x18(%eax),%eax
80104255:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

    safestrcpy(p->name, "initcode", sizeof(p->name));
8010425c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010425f:	83 c0 6c             	add    $0x6c,%eax
80104262:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104269:	00 
8010426a:	c7 44 24 04 e4 88 10 	movl   $0x801088e4,0x4(%esp)
80104271:	80 
80104272:	89 04 24             	mov    %eax,(%esp)
80104275:	e8 57 11 00 00       	call   801053d1 <safestrcpy>
    p->cwd = namei("/");
8010427a:	c7 04 24 ed 88 10 80 	movl   $0x801088ed,(%esp)
80104281:	e8 9d e1 ff ff       	call   80102423 <namei>
80104286:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104289:	89 42 68             	mov    %eax,0x68(%edx)

    p->state = RUNNABLE;
8010428c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010428f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104296:	c9                   	leave  
80104297:	c3                   	ret    

80104298 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
    int
growproc(int n)
{
80104298:	55                   	push   %ebp
80104299:	89 e5                	mov    %esp,%ebp
8010429b:	83 ec 28             	sub    $0x28,%esp
    uint sz;

    sz = proc->sz;
8010429e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042a4:	8b 00                	mov    (%eax),%eax
801042a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(n > 0){
801042a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801042ad:	7e 34                	jle    801042e3 <growproc+0x4b>
        if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801042af:	8b 45 08             	mov    0x8(%ebp),%eax
801042b2:	89 c2                	mov    %eax,%edx
801042b4:	03 55 f4             	add    -0xc(%ebp),%edx
801042b7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042bd:	8b 40 04             	mov    0x4(%eax),%eax
801042c0:	89 54 24 08          	mov    %edx,0x8(%esp)
801042c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801042c7:	89 54 24 04          	mov    %edx,0x4(%esp)
801042cb:	89 04 24             	mov    %eax,(%esp)
801042ce:	e8 92 3e 00 00       	call   80108165 <allocuvm>
801042d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042d6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042da:	75 41                	jne    8010431d <growproc+0x85>
            return -1;
801042dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042e1:	eb 58                	jmp    8010433b <growproc+0xa3>
    } else if(n < 0){
801042e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801042e7:	79 34                	jns    8010431d <growproc+0x85>
        if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801042e9:	8b 45 08             	mov    0x8(%ebp),%eax
801042ec:	89 c2                	mov    %eax,%edx
801042ee:	03 55 f4             	add    -0xc(%ebp),%edx
801042f1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042f7:	8b 40 04             	mov    0x4(%eax),%eax
801042fa:	89 54 24 08          	mov    %edx,0x8(%esp)
801042fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104301:	89 54 24 04          	mov    %edx,0x4(%esp)
80104305:	89 04 24             	mov    %eax,(%esp)
80104308:	e8 32 3f 00 00       	call   8010823f <deallocuvm>
8010430d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104310:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104314:	75 07                	jne    8010431d <growproc+0x85>
            return -1;
80104316:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010431b:	eb 1e                	jmp    8010433b <growproc+0xa3>
    }
    proc->sz = sz;
8010431d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104323:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104326:	89 10                	mov    %edx,(%eax)
    switchuvm(proc);
80104328:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010432e:	89 04 24             	mov    %eax,(%esp)
80104331:	e8 4d 3b 00 00       	call   80107e83 <switchuvm>
    return 0;
80104336:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010433b:	c9                   	leave  
8010433c:	c3                   	ret    

8010433d <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
    int
fork(void)
{
8010433d:	55                   	push   %ebp
8010433e:	89 e5                	mov    %esp,%ebp
80104340:	57                   	push   %edi
80104341:	56                   	push   %esi
80104342:	53                   	push   %ebx
80104343:	83 ec 2c             	sub    $0x2c,%esp
    int i, pid;
    struct proc *np;

    // Allocate process.
    if((np = allocproc()) == 0)
80104346:	e8 2a fd ff ff       	call   80104075 <allocproc>
8010434b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010434e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80104352:	75 0a                	jne    8010435e <fork+0x21>
        return -1;
80104354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104359:	e9 47 01 00 00       	jmp    801044a5 <fork+0x168>

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010435e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104364:	8b 10                	mov    (%eax),%edx
80104366:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010436c:	8b 40 04             	mov    0x4(%eax),%eax
8010436f:	89 54 24 04          	mov    %edx,0x4(%esp)
80104373:	89 04 24             	mov    %eax,(%esp)
80104376:	e8 54 40 00 00       	call   801083cf <copyuvm>
8010437b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010437e:	89 42 04             	mov    %eax,0x4(%edx)
80104381:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104384:	8b 40 04             	mov    0x4(%eax),%eax
80104387:	85 c0                	test   %eax,%eax
80104389:	75 2c                	jne    801043b7 <fork+0x7a>
        kfree(np->kstack);
8010438b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010438e:	8b 40 08             	mov    0x8(%eax),%eax
80104391:	89 04 24             	mov    %eax,(%esp)
80104394:	e8 d8 e6 ff ff       	call   80102a71 <kfree>
        np->kstack = 0;
80104399:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010439c:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        np->state = UNUSED;
801043a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043a6:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        return -1;
801043ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043b2:	e9 ee 00 00 00       	jmp    801044a5 <fork+0x168>
    }
    np->sz = proc->sz;
801043b7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043bd:	8b 10                	mov    (%eax),%edx
801043bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043c2:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
801043c4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801043cb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043ce:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
801043d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043d4:	8b 50 18             	mov    0x18(%eax),%edx
801043d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043dd:	8b 40 18             	mov    0x18(%eax),%eax
801043e0:	89 c3                	mov    %eax,%ebx
801043e2:	b8 13 00 00 00       	mov    $0x13,%eax
801043e7:	89 d7                	mov    %edx,%edi
801043e9:	89 de                	mov    %ebx,%esi
801043eb:	89 c1                	mov    %eax,%ecx
801043ed:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 0;
801043ef:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043f2:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801043f9:	00 00 00 

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
801043fc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801043ff:	8b 40 18             	mov    0x18(%eax),%eax
80104402:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

    for(i = 0; i < NOFILE; i++)
80104409:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80104410:	eb 3d                	jmp    8010444f <fork+0x112>
        if(proc->ofile[i])
80104412:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104418:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010441b:	83 c2 08             	add    $0x8,%edx
8010441e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104422:	85 c0                	test   %eax,%eax
80104424:	74 25                	je     8010444b <fork+0x10e>
            np->ofile[i] = filedup(proc->ofile[i]);
80104426:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80104429:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010442f:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104432:	83 c2 08             	add    $0x8,%edx
80104435:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104439:	89 04 24             	mov    %eax,(%esp)
8010443c:	e8 44 cb ff ff       	call   80100f85 <filedup>
80104441:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104444:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104447:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
    np->isthread = 0;

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;

    for(i = 0; i < NOFILE; i++)
8010444b:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
8010444f:	83 7d dc 0f          	cmpl   $0xf,-0x24(%ebp)
80104453:	7e bd                	jle    80104412 <fork+0xd5>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);
    np->cwd = idup(proc->cwd);
80104455:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010445b:	8b 40 68             	mov    0x68(%eax),%eax
8010445e:	89 04 24             	mov    %eax,(%esp)
80104461:	e8 e3 d3 ff ff       	call   80101849 <idup>
80104466:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104469:	89 42 68             	mov    %eax,0x68(%edx)

    pid = np->pid;
8010446c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010446f:	8b 40 10             	mov    0x10(%eax),%eax
80104472:	89 45 e0             	mov    %eax,-0x20(%ebp)
    np->state = RUNNABLE;
80104475:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104478:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    safestrcpy(np->name, proc->name, sizeof(proc->name));
8010447f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104485:	8d 50 6c             	lea    0x6c(%eax),%edx
80104488:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010448b:	83 c0 6c             	add    $0x6c,%eax
8010448e:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104495:	00 
80104496:	89 54 24 04          	mov    %edx,0x4(%esp)
8010449a:	89 04 24             	mov    %eax,(%esp)
8010449d:	e8 2f 0f 00 00       	call   801053d1 <safestrcpy>
    return pid;
801044a2:	8b 45 e0             	mov    -0x20(%ebp),%eax

}
801044a5:	83 c4 2c             	add    $0x2c,%esp
801044a8:	5b                   	pop    %ebx
801044a9:	5e                   	pop    %esi
801044aa:	5f                   	pop    %edi
801044ab:	5d                   	pop    %ebp
801044ac:	c3                   	ret    

801044ad <clone>:

//creat a new process but used parent pgdir. 
int clone(int stack, int size, int routine, int arg){ 
801044ad:	55                   	push   %ebp
801044ae:	89 e5                	mov    %esp,%ebp
801044b0:	57                   	push   %edi
801044b1:	56                   	push   %esi
801044b2:	53                   	push   %ebx
801044b3:	81 ec bc 00 00 00    	sub    $0xbc,%esp
    int i, pid;
    struct proc *np;

    //cprintf("in clone\n");
    // Allocate process.
    if((np = allocproc()) == 0)
801044b9:	e8 b7 fb ff ff       	call   80104075 <allocproc>
801044be:	89 45 dc             	mov    %eax,-0x24(%ebp)
801044c1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
801044c5:	75 0a                	jne    801044d1 <clone+0x24>
        return -1;
801044c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044cc:	e9 f4 01 00 00       	jmp    801046c5 <clone+0x218>
    if((stack % PGSIZE) != 0 || stack == 0 || routine == 0)
801044d1:	8b 45 08             	mov    0x8(%ebp),%eax
801044d4:	25 ff 0f 00 00       	and    $0xfff,%eax
801044d9:	85 c0                	test   %eax,%eax
801044db:	75 0c                	jne    801044e9 <clone+0x3c>
801044dd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801044e1:	74 06                	je     801044e9 <clone+0x3c>
801044e3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801044e7:	75 0a                	jne    801044f3 <clone+0x46>
        return -1;
801044e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044ee:	e9 d2 01 00 00       	jmp    801046c5 <clone+0x218>

    np->pgdir = proc->pgdir;
801044f3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044f9:	8b 50 04             	mov    0x4(%eax),%edx
801044fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801044ff:	89 50 04             	mov    %edx,0x4(%eax)
    np->sz = proc->sz;
80104502:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104508:	8b 10                	mov    (%eax),%edx
8010450a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010450d:	89 10                	mov    %edx,(%eax)
    np->parent = proc;
8010450f:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104516:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104519:	89 50 14             	mov    %edx,0x14(%eax)
    *np->tf = *proc->tf;
8010451c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010451f:	8b 50 18             	mov    0x18(%eax),%edx
80104522:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104528:	8b 40 18             	mov    0x18(%eax),%eax
8010452b:	89 c3                	mov    %eax,%ebx
8010452d:	b8 13 00 00 00       	mov    $0x13,%eax
80104532:	89 d7                	mov    %edx,%edi
80104534:	89 de                	mov    %ebx,%esi
80104536:	89 c1                	mov    %eax,%ecx
80104538:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
    np->isthread = 1;
8010453a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010453d:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
80104544:	00 00 00 
    pid = np->pid;
80104547:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010454a:	8b 40 10             	mov    0x10(%eax),%eax
8010454d:	89 45 d8             	mov    %eax,-0x28(%ebp)

    struct proc *pp;
    pp = proc;
80104550:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104556:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(pp->isthread == 1){
80104559:	eb 09                	jmp    80104564 <clone+0xb7>
        pp = pp->parent;
8010455b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010455e:	8b 40 14             	mov    0x14(%eax),%eax
80104561:	89 45 e0             	mov    %eax,-0x20(%ebp)
    np->isthread = 1;
    pid = np->pid;

    struct proc *pp;
    pp = proc;
    while(pp->isthread == 1){
80104564:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104567:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010456d:	83 f8 01             	cmp    $0x1,%eax
80104570:	74 e9                	je     8010455b <clone+0xae>
        pp = pp->parent;
    }
    np->parent = pp;
80104572:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104575:	8b 55 e0             	mov    -0x20(%ebp),%edx
80104578:	89 50 14             	mov    %edx,0x14(%eax)
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
8010457b:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
80104582:	eb 3d                	jmp    801045c1 <clone+0x114>
        if(proc->ofile[i])
80104584:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010458a:	8b 55 d4             	mov    -0x2c(%ebp),%edx
8010458d:	83 c2 08             	add    $0x8,%edx
80104590:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104594:	85 c0                	test   %eax,%eax
80104596:	74 25                	je     801045bd <clone+0x110>
            np->ofile[i] = filedup(proc->ofile[i]);
80104598:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
8010459b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045a1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801045a4:	83 c2 08             	add    $0x8,%edx
801045a7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801045ab:	89 04 24             	mov    %eax,(%esp)
801045ae:	e8 d2 c9 ff ff       	call   80100f85 <filedup>
801045b3:	8b 55 dc             	mov    -0x24(%ebp),%edx
801045b6:	8d 4b 08             	lea    0x8(%ebx),%ecx
801045b9:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
        pp = pp->parent;
    }
    np->parent = pp;
    //need to be modified as point to the same address
    //*np->ofile = *proc->ofile;
    for(i = 0; i < NOFILE; i++)
801045bd:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
801045c1:	83 7d d4 0f          	cmpl   $0xf,-0x2c(%ebp)
801045c5:	7e bd                	jle    80104584 <clone+0xd7>
        if(proc->ofile[i])
            np->ofile[i] = filedup(proc->ofile[i]);

    // Clear %eax so that fork returns 0 in the child.
    np->tf->eax = 0;
801045c7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045ca:	8b 40 18             	mov    0x18(%eax),%eax
801045cd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

   
    uint ustack[MAXARG];
    uint sp = stack + PGSIZE;
801045d4:	8b 45 08             	mov    0x8(%ebp),%eax
801045d7:	05 00 10 00 00       	add    $0x1000,%eax
801045dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
//


//modify here <<<<<

    np->tf->ebp = sp;
801045df:	8b 45 dc             	mov    -0x24(%ebp),%eax
801045e2:	8b 40 18             	mov    0x18(%eax),%eax
801045e5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801045e8:	89 50 08             	mov    %edx,0x8(%eax)
    ustack[0] = 0xffffffff;
801045eb:	c7 85 54 ff ff ff ff 	movl   $0xffffffff,-0xac(%ebp)
801045f2:	ff ff ff 
    ustack[1] = arg;
801045f5:	8b 45 14             	mov    0x14(%ebp),%eax
801045f8:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
    sp -= 8;
801045fe:	83 6d e4 08          	subl   $0x8,-0x1c(%ebp)
    if(copyout(np->pgdir,sp,ustack,8)<0){
80104602:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104605:	8b 40 04             	mov    0x4(%eax),%eax
80104608:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
8010460f:	00 
80104610:	8d 95 54 ff ff ff    	lea    -0xac(%ebp),%edx
80104616:	89 54 24 08          	mov    %edx,0x8(%esp)
8010461a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010461d:	89 54 24 04          	mov    %edx,0x4(%esp)
80104621:	89 04 24             	mov    %eax,(%esp)
80104624:	e8 25 3f 00 00       	call   8010854e <copyout>
80104629:	85 c0                	test   %eax,%eax
8010462b:	79 16                	jns    80104643 <clone+0x196>
        cprintf("push arg fails\n");
8010462d:	c7 04 24 ef 88 10 80 	movl   $0x801088ef,(%esp)
80104634:	e8 61 bd ff ff       	call   8010039a <cprintf>
        return -1;
80104639:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010463e:	e9 82 00 00 00       	jmp    801046c5 <clone+0x218>
    }

    np->tf->eip = routine;
80104643:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104646:	8b 40 18             	mov    0x18(%eax),%eax
80104649:	8b 55 10             	mov    0x10(%ebp),%edx
8010464c:	89 50 38             	mov    %edx,0x38(%eax)
    np->tf->esp = sp;
8010464f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104652:	8b 40 18             	mov    0x18(%eax),%eax
80104655:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104658:	89 50 44             	mov    %edx,0x44(%eax)
    np->cwd = idup(proc->cwd);
8010465b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104661:	8b 40 68             	mov    0x68(%eax),%eax
80104664:	89 04 24             	mov    %eax,(%esp)
80104667:	e8 dd d1 ff ff       	call   80101849 <idup>
8010466c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010466f:	89 42 68             	mov    %eax,0x68(%edx)

    switchuvm(np);
80104672:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104675:	89 04 24             	mov    %eax,(%esp)
80104678:	e8 06 38 00 00       	call   80107e83 <switchuvm>

     acquire(&ptable.lock);
8010467d:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104684:	e8 c6 08 00 00       	call   80104f4f <acquire>
    np->state = RUNNABLE;
80104689:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010468c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
     release(&ptable.lock);
80104693:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
8010469a:	e8 11 09 00 00       	call   80104fb0 <release>
    safestrcpy(np->name, proc->name, sizeof(proc->name));
8010469f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046a5:	8d 50 6c             	lea    0x6c(%eax),%edx
801046a8:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046ab:	83 c0 6c             	add    $0x6c,%eax
801046ae:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801046b5:	00 
801046b6:	89 54 24 04          	mov    %edx,0x4(%esp)
801046ba:	89 04 24             	mov    %eax,(%esp)
801046bd:	e8 0f 0d 00 00       	call   801053d1 <safestrcpy>


    return pid;
801046c2:	8b 45 d8             	mov    -0x28(%ebp),%eax

}
801046c5:	81 c4 bc 00 00 00    	add    $0xbc,%esp
801046cb:	5b                   	pop    %ebx
801046cc:	5e                   	pop    %esi
801046cd:	5f                   	pop    %edi
801046ce:	5d                   	pop    %ebp
801046cf:	c3                   	ret    

801046d0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
    void
exit(void)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int fd;

    if(proc == initproc)
801046d6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801046dd:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801046e2:	39 c2                	cmp    %eax,%edx
801046e4:	75 0c                	jne    801046f2 <exit+0x22>
        panic("init exiting");
801046e6:	c7 04 24 ff 88 10 80 	movl   $0x801088ff,(%esp)
801046ed:	e8 48 be ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
801046f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801046f9:	eb 44                	jmp    8010473f <exit+0x6f>
        if(proc->ofile[fd]){
801046fb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104701:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104704:	83 c2 08             	add    $0x8,%edx
80104707:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010470b:	85 c0                	test   %eax,%eax
8010470d:	74 2c                	je     8010473b <exit+0x6b>
            fileclose(proc->ofile[fd]);
8010470f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104715:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104718:	83 c2 08             	add    $0x8,%edx
8010471b:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010471f:	89 04 24             	mov    %eax,(%esp)
80104722:	e8 a6 c8 ff ff       	call   80100fcd <fileclose>
            proc->ofile[fd] = 0;
80104727:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010472d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104730:	83 c2 08             	add    $0x8,%edx
80104733:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010473a:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
8010473b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010473f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104743:	7e b6                	jle    801046fb <exit+0x2b>
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }

    iput(proc->cwd);
80104745:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010474b:	8b 40 68             	mov    0x68(%eax),%eax
8010474e:	89 04 24             	mov    %eax,(%esp)
80104751:	e8 db d2 ff ff       	call   80101a31 <iput>
    proc->cwd = 0;
80104756:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010475c:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
80104763:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
8010476a:	e8 e0 07 00 00       	call   80104f4f <acquire>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
8010476f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104775:	8b 40 14             	mov    0x14(%eax),%eax
80104778:	89 04 24             	mov    %eax,(%esp)
8010477b:	e8 f1 04 00 00       	call   80104c71 <wakeup1>

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104780:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
80104787:	eb 3b                	jmp    801047c4 <exit+0xf4>
        if(p->parent == proc){
80104789:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010478c:	8b 50 14             	mov    0x14(%eax),%edx
8010478f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104795:	39 c2                	cmp    %eax,%edx
80104797:	75 24                	jne    801047bd <exit+0xed>
            p->parent = initproc;
80104799:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
8010479f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801047a2:	89 50 14             	mov    %edx,0x14(%eax)
            if(p->state == ZOMBIE)
801047a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801047a8:	8b 40 0c             	mov    0xc(%eax),%eax
801047ab:	83 f8 05             	cmp    $0x5,%eax
801047ae:	75 0d                	jne    801047bd <exit+0xed>
                wakeup1(initproc);
801047b0:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801047b5:	89 04 24             	mov    %eax,(%esp)
801047b8:	e8 b4 04 00 00       	call   80104c71 <wakeup1>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801047bd:	81 45 f0 84 00 00 00 	addl   $0x84,-0x10(%ebp)
801047c4:	b8 74 20 11 80       	mov    $0x80112074,%eax
801047c9:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801047cc:	72 bb                	jb     80104789 <exit+0xb9>
                wakeup1(initproc);
        }
    }

    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
801047ce:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047d4:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
801047db:	e8 98 02 00 00       	call   80104a78 <sched>
    panic("zombie exit");
801047e0:	c7 04 24 0c 89 10 80 	movl   $0x8010890c,(%esp)
801047e7:	e8 4e bd ff ff       	call   8010053a <panic>

801047ec <texit>:
}
    void
texit(void)
{
801047ec:	55                   	push   %ebp
801047ed:	89 e5                	mov    %esp,%ebp
801047ef:	83 ec 28             	sub    $0x28,%esp
    //  struct proc *p;
    int fd;

    if(proc == initproc)
801047f2:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047f9:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801047fe:	39 c2                	cmp    %eax,%edx
80104800:	75 0c                	jne    8010480e <texit+0x22>
        panic("init exiting");
80104802:	c7 04 24 ff 88 10 80 	movl   $0x801088ff,(%esp)
80104809:	e8 2c bd ff ff       	call   8010053a <panic>

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
8010480e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104815:	eb 44                	jmp    8010485b <texit+0x6f>
        if(proc->ofile[fd]){
80104817:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010481d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104820:	83 c2 08             	add    $0x8,%edx
80104823:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104827:	85 c0                	test   %eax,%eax
80104829:	74 2c                	je     80104857 <texit+0x6b>
            fileclose(proc->ofile[fd]);
8010482b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104831:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104834:	83 c2 08             	add    $0x8,%edx
80104837:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010483b:	89 04 24             	mov    %eax,(%esp)
8010483e:	e8 8a c7 ff ff       	call   80100fcd <fileclose>
            proc->ofile[fd] = 0;
80104843:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104849:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010484c:	83 c2 08             	add    $0x8,%edx
8010484f:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104856:	00 

    if(proc == initproc)
        panic("init exiting");

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
80104857:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010485b:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010485f:	7e b6                	jle    80104817 <texit+0x2b>
        if(proc->ofile[fd]){
            fileclose(proc->ofile[fd]);
            proc->ofile[fd] = 0;
        }
    }
    iput(proc->cwd);
80104861:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104867:	8b 40 68             	mov    0x68(%eax),%eax
8010486a:	89 04 24             	mov    %eax,(%esp)
8010486d:	e8 bf d1 ff ff       	call   80101a31 <iput>
    proc->cwd = 0;
80104872:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104878:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

    acquire(&ptable.lock);
8010487f:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104886:	e8 c4 06 00 00       	call   80104f4f <acquire>
    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
8010488b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104891:	8b 40 14             	mov    0x14(%eax),%eax
80104894:	89 04 24             	mov    %eax,(%esp)
80104897:	e8 d5 03 00 00       	call   80104c71 <wakeup1>
    //      if(p->state == ZOMBIE)
    //        wakeup1(initproc);
    //    }
    //  }
    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
8010489c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048a2:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
    sched();
801048a9:	e8 ca 01 00 00       	call   80104a78 <sched>
    panic("zombie exit");
801048ae:	c7 04 24 0c 89 10 80 	movl   $0x8010890c,(%esp)
801048b5:	e8 80 bc ff ff       	call   8010053a <panic>

801048ba <wait>:
}
// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
    int
wait(void)
{
801048ba:	55                   	push   %ebp
801048bb:	89 e5                	mov    %esp,%ebp
801048bd:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
801048c0:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801048c7:	e8 83 06 00 00       	call   80104f4f <acquire>
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
801048cc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801048d3:	c7 45 ec 74 ff 10 80 	movl   $0x8010ff74,-0x14(%ebp)
801048da:	e9 ab 00 00 00       	jmp    8010498a <wait+0xd0>
        //    if(p->parent != proc && p->isthread ==1)
            if(p->parent != proc) 
801048df:	8b 45 ec             	mov    -0x14(%ebp),%eax
801048e2:	8b 50 14             	mov    0x14(%eax),%edx
801048e5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048eb:	39 c2                	cmp    %eax,%edx
801048ed:	0f 85 8f 00 00 00    	jne    80104982 <wait+0xc8>
                continue;
            havekids = 1;
801048f3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            if(p->state == ZOMBIE){
801048fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801048fd:	8b 40 0c             	mov    0xc(%eax),%eax
80104900:	83 f8 05             	cmp    $0x5,%eax
80104903:	75 7e                	jne    80104983 <wait+0xc9>
                // Found one.
                pid = p->pid;
80104905:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104908:	8b 40 10             	mov    0x10(%eax),%eax
8010490b:	89 45 f4             	mov    %eax,-0xc(%ebp)
                kfree(p->kstack);
8010490e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104911:	8b 40 08             	mov    0x8(%eax),%eax
80104914:	89 04 24             	mov    %eax,(%esp)
80104917:	e8 55 e1 ff ff       	call   80102a71 <kfree>
                p->kstack = 0;
8010491c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010491f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
                if(p->isthread != 1){
80104926:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104929:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
8010492f:	83 f8 01             	cmp    $0x1,%eax
80104932:	74 0e                	je     80104942 <wait+0x88>
                    freevm(p->pgdir);
80104934:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104937:	8b 40 04             	mov    0x4(%eax),%eax
8010493a:	89 04 24             	mov    %eax,(%esp)
8010493d:	e8 b9 39 00 00       	call   801082fb <freevm>
                }
                p->state = UNUSED;
80104942:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104945:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
                p->pid = 0;
8010494c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010494f:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
                p->parent = 0;
80104956:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104959:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
                p->name[0] = 0;
80104960:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104963:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
                p->killed = 0;
80104967:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010496a:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
                release(&ptable.lock);
80104971:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104978:	e8 33 06 00 00       	call   80104fb0 <release>
                return pid;
8010497d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104980:	eb 57                	jmp    801049d9 <wait+0x11f>
        // Scan through table looking for zombie children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        //    if(p->parent != proc && p->isthread ==1)
            if(p->parent != proc) 
                continue;
80104982:	90                   	nop

    acquire(&ptable.lock);
    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104983:	81 45 ec 84 00 00 00 	addl   $0x84,-0x14(%ebp)
8010498a:	b8 74 20 11 80       	mov    $0x80112074,%eax
8010498f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104992:	0f 82 47 ff ff ff    	jb     801048df <wait+0x25>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || proc->killed){
80104998:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010499c:	74 0d                	je     801049ab <wait+0xf1>
8010499e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049a4:	8b 40 24             	mov    0x24(%eax),%eax
801049a7:	85 c0                	test   %eax,%eax
801049a9:	74 13                	je     801049be <wait+0x104>
            release(&ptable.lock);
801049ab:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801049b2:	e8 f9 05 00 00       	call   80104fb0 <release>
            return -1;
801049b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049bc:	eb 1b                	jmp    801049d9 <wait+0x11f>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(proc, &ptable.lock);  //DOC: wait-sleep
801049be:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049c4:	c7 44 24 04 40 ff 10 	movl   $0x8010ff40,0x4(%esp)
801049cb:	80 
801049cc:	89 04 24             	mov    %eax,(%esp)
801049cf:	e8 02 02 00 00       	call   80104bd6 <sleep>
    }
801049d4:	e9 f3 fe ff ff       	jmp    801048cc <wait+0x12>
}
801049d9:	c9                   	leave  
801049da:	c3                   	ret    

801049db <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
    void
scheduler(void)
{
801049db:	55                   	push   %ebp
801049dc:	89 e5                	mov    %esp,%ebp
801049de:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    for(;;){
        // Enable interrupts on this processor.
        sti();
801049e1:	e8 e6 f5 ff ff       	call   80103fcc <sti>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
801049e6:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
801049ed:	e8 5d 05 00 00       	call   80104f4f <acquire>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049f2:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
801049f9:	eb 62                	jmp    80104a5d <scheduler+0x82>
            if(p->state != RUNNABLE)
801049fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049fe:	8b 40 0c             	mov    0xc(%eax),%eax
80104a01:	83 f8 03             	cmp    $0x3,%eax
80104a04:	75 4f                	jne    80104a55 <scheduler+0x7a>
                continue;

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            proc = p;
80104a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a09:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
            switchuvm(p);
80104a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a12:	89 04 24             	mov    %eax,(%esp)
80104a15:	e8 69 34 00 00       	call   80107e83 <switchuvm>
            p->state = RUNNING;
80104a1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a1d:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
            swtch(&cpu->scheduler, proc->context);
80104a24:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104a2a:	8b 40 1c             	mov    0x1c(%eax),%eax
80104a2d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104a34:	83 c2 04             	add    $0x4,%edx
80104a37:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a3b:	89 14 24             	mov    %edx,(%esp)
80104a3e:	e8 01 0a 00 00       	call   80105444 <swtch>
            switchkvm();
80104a43:	e8 1e 34 00 00       	call   80107e66 <switchkvm>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
80104a48:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104a4f:	00 00 00 00 
80104a53:	eb 01                	jmp    80104a56 <scheduler+0x7b>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
            if(p->state != RUNNABLE)
                continue;
80104a55:	90                   	nop
        // Enable interrupts on this processor.
        sti();

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a56:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104a5d:	b8 74 20 11 80       	mov    $0x80112074,%eax
80104a62:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104a65:	72 94                	jb     801049fb <scheduler+0x20>

            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
        }
        release(&ptable.lock);
80104a67:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104a6e:	e8 3d 05 00 00       	call   80104fb0 <release>

    }
80104a73:	e9 69 ff ff ff       	jmp    801049e1 <scheduler+0x6>

80104a78 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
    void
sched(void)
{
80104a78:	55                   	push   %ebp
80104a79:	89 e5                	mov    %esp,%ebp
80104a7b:	83 ec 28             	sub    $0x28,%esp
    int intena;

    if(!holding(&ptable.lock))
80104a7e:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104a85:	e8 e4 05 00 00       	call   8010506e <holding>
80104a8a:	85 c0                	test   %eax,%eax
80104a8c:	75 0c                	jne    80104a9a <sched+0x22>
        panic("sched ptable.lock");
80104a8e:	c7 04 24 18 89 10 80 	movl   $0x80108918,(%esp)
80104a95:	e8 a0 ba ff ff       	call   8010053a <panic>
    if(cpu->ncli != 1){
80104a9a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104aa0:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104aa6:	83 f8 01             	cmp    $0x1,%eax
80104aa9:	74 35                	je     80104ae0 <sched+0x68>
        cprintf("current proc %d\n cpu->ncli %d\n",proc->pid,cpu->ncli);
80104aab:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104ab1:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104ab7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104abd:	8b 40 10             	mov    0x10(%eax),%eax
80104ac0:	89 54 24 08          	mov    %edx,0x8(%esp)
80104ac4:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ac8:	c7 04 24 2c 89 10 80 	movl   $0x8010892c,(%esp)
80104acf:	e8 c6 b8 ff ff       	call   8010039a <cprintf>
        panic("sched locks");
80104ad4:	c7 04 24 4b 89 10 80 	movl   $0x8010894b,(%esp)
80104adb:	e8 5a ba ff ff       	call   8010053a <panic>
    }
    if(proc->state == RUNNING)
80104ae0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ae6:	8b 40 0c             	mov    0xc(%eax),%eax
80104ae9:	83 f8 04             	cmp    $0x4,%eax
80104aec:	75 0c                	jne    80104afa <sched+0x82>
        panic("sched running");
80104aee:	c7 04 24 57 89 10 80 	movl   $0x80108957,(%esp)
80104af5:	e8 40 ba ff ff       	call   8010053a <panic>
    if(readeflags()&FL_IF)
80104afa:	e8 bd f4 ff ff       	call   80103fbc <readeflags>
80104aff:	25 00 02 00 00       	and    $0x200,%eax
80104b04:	85 c0                	test   %eax,%eax
80104b06:	74 0c                	je     80104b14 <sched+0x9c>
        panic("sched interruptible");
80104b08:	c7 04 24 65 89 10 80 	movl   $0x80108965,(%esp)
80104b0f:	e8 26 ba ff ff       	call   8010053a <panic>
    intena = cpu->intena;
80104b14:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b1a:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104b20:	89 45 f4             	mov    %eax,-0xc(%ebp)
    swtch(&proc->context, cpu->scheduler);
80104b23:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b29:	8b 40 04             	mov    0x4(%eax),%eax
80104b2c:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104b33:	83 c2 1c             	add    $0x1c,%edx
80104b36:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b3a:	89 14 24             	mov    %edx,(%esp)
80104b3d:	e8 02 09 00 00       	call   80105444 <swtch>
    cpu->intena = intena;
80104b42:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104b48:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104b4b:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104b51:	c9                   	leave  
80104b52:	c3                   	ret    

80104b53 <yield>:

// Give up the CPU for one scheduling round.
    void
yield(void)
{
80104b53:	55                   	push   %ebp
80104b54:	89 e5                	mov    %esp,%ebp
80104b56:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);  //DOC: yieldlock
80104b59:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104b60:	e8 ea 03 00 00       	call   80104f4f <acquire>
    proc->state = RUNNABLE;
80104b65:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104b6b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    sched();
80104b72:	e8 01 ff ff ff       	call   80104a78 <sched>
    release(&ptable.lock);
80104b77:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104b7e:	e8 2d 04 00 00       	call   80104fb0 <release>
}
80104b83:	c9                   	leave  
80104b84:	c3                   	ret    

80104b85 <thread_yield>:

void
thread_yield(void)
{
80104b85:	55                   	push   %ebp
80104b86:	89 e5                	mov    %esp,%ebp
80104b88:	83 ec 18             	sub    $0x18,%esp
	acquire(&ptable.lock); 
80104b8b:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104b92:	e8 b8 03 00 00       	call   80104f4f <acquire>
	yield();
80104b97:	e8 b7 ff ff ff       	call   80104b53 <yield>
	release(&ptable.lock); 
80104b9c:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104ba3:	e8 08 04 00 00       	call   80104fb0 <release>
}
80104ba8:	c9                   	leave  
80104ba9:	c3                   	ret    

80104baa <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
    void
forkret(void)
{
80104baa:	55                   	push   %ebp
80104bab:	89 e5                	mov    %esp,%ebp
80104bad:	83 ec 18             	sub    $0x18,%esp
    static int first = 1;
    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
80104bb0:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104bb7:	e8 f4 03 00 00       	call   80104fb0 <release>

    if (first) {
80104bbc:	a1 20 b0 10 80       	mov    0x8010b020,%eax
80104bc1:	85 c0                	test   %eax,%eax
80104bc3:	74 0f                	je     80104bd4 <forkret+0x2a>
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot 
        // be run from main().
        first = 0;
80104bc5:	c7 05 20 b0 10 80 00 	movl   $0x0,0x8010b020
80104bcc:	00 00 00 
        initlog();
80104bcf:	e8 30 e4 ff ff       	call   80103004 <initlog>
    }

    // Return to "caller", actually trapret (see allocproc).
}
80104bd4:	c9                   	leave  
80104bd5:	c3                   	ret    

80104bd6 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
    void
sleep(void *chan, struct spinlock *lk)
{
80104bd6:	55                   	push   %ebp
80104bd7:	89 e5                	mov    %esp,%ebp
80104bd9:	83 ec 18             	sub    $0x18,%esp
    if(proc == 0)
80104bdc:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104be2:	85 c0                	test   %eax,%eax
80104be4:	75 0c                	jne    80104bf2 <sleep+0x1c>
        panic("sleep");
80104be6:	c7 04 24 79 89 10 80 	movl   $0x80108979,(%esp)
80104bed:	e8 48 b9 ff ff       	call   8010053a <panic>

    if(lk == 0)
80104bf2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80104bf6:	75 0c                	jne    80104c04 <sleep+0x2e>
        panic("sleep without lk");
80104bf8:	c7 04 24 7f 89 10 80 	movl   $0x8010897f,(%esp)
80104bff:	e8 36 b9 ff ff       	call   8010053a <panic>
    // change p->state and then call sched.
    // Once we hold ptable.lock, we can be
    // guaranteed that we won't miss any wakeup
    // (wakeup runs with ptable.lock locked),
    // so it's okay to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
80104c04:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
80104c0b:	74 17                	je     80104c24 <sleep+0x4e>
        acquire(&ptable.lock);  //DOC: sleeplock1
80104c0d:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104c14:	e8 36 03 00 00       	call   80104f4f <acquire>
        release(lk);
80104c19:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c1c:	89 04 24             	mov    %eax,(%esp)
80104c1f:	e8 8c 03 00 00       	call   80104fb0 <release>
    }

    // Go to sleep.
    proc->chan = chan;
80104c24:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104c2d:	89 50 20             	mov    %edx,0x20(%eax)
    proc->state = SLEEPING;
80104c30:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c36:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
    sched();
80104c3d:	e8 36 fe ff ff       	call   80104a78 <sched>

    // Tidy up.
    proc->chan = 0;
80104c42:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104c48:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
80104c4f:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
80104c56:	74 17                	je     80104c6f <sleep+0x99>
        release(&ptable.lock);
80104c58:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104c5f:	e8 4c 03 00 00       	call   80104fb0 <release>
        acquire(lk);
80104c64:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c67:	89 04 24             	mov    %eax,(%esp)
80104c6a:	e8 e0 02 00 00       	call   80104f4f <acquire>
    }
}
80104c6f:	c9                   	leave  
80104c70:	c3                   	ret    

80104c71 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
    static void
wakeup1(void *chan)
{
80104c71:	55                   	push   %ebp
80104c72:	89 e5                	mov    %esp,%ebp
80104c74:	83 ec 10             	sub    $0x10,%esp
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c77:	c7 45 fc 74 ff 10 80 	movl   $0x8010ff74,-0x4(%ebp)
80104c7e:	eb 27                	jmp    80104ca7 <wakeup1+0x36>
        if(p->state == SLEEPING && p->chan == chan)
80104c80:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c83:	8b 40 0c             	mov    0xc(%eax),%eax
80104c86:	83 f8 02             	cmp    $0x2,%eax
80104c89:	75 15                	jne    80104ca0 <wakeup1+0x2f>
80104c8b:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c8e:	8b 40 20             	mov    0x20(%eax),%eax
80104c91:	3b 45 08             	cmp    0x8(%ebp),%eax
80104c94:	75 0a                	jne    80104ca0 <wakeup1+0x2f>
            p->state = RUNNABLE;
80104c96:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104c99:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
    static void
wakeup1(void *chan)
{
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ca0:	81 45 fc 84 00 00 00 	addl   $0x84,-0x4(%ebp)
80104ca7:	b8 74 20 11 80       	mov    $0x80112074,%eax
80104cac:	39 45 fc             	cmp    %eax,-0x4(%ebp)
80104caf:	72 cf                	jb     80104c80 <wakeup1+0xf>
        if(p->state == SLEEPING && p->chan == chan)
            p->state = RUNNABLE;
}
80104cb1:	c9                   	leave  
80104cb2:	c3                   	ret    

80104cb3 <twakeup>:

void 
twakeup(int tid){
80104cb3:	55                   	push   %ebp
80104cb4:	89 e5                	mov    %esp,%ebp
80104cb6:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;
    acquire(&ptable.lock);
80104cb9:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104cc0:	e8 8a 02 00 00       	call   80104f4f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cc5:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104ccc:	eb 36                	jmp    80104d04 <twakeup+0x51>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
80104cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd1:	8b 40 0c             	mov    0xc(%eax),%eax
80104cd4:	83 f8 02             	cmp    $0x2,%eax
80104cd7:	75 24                	jne    80104cfd <twakeup+0x4a>
80104cd9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cdc:	8b 40 10             	mov    0x10(%eax),%eax
80104cdf:	3b 45 08             	cmp    0x8(%ebp),%eax
80104ce2:	75 19                	jne    80104cfd <twakeup+0x4a>
80104ce4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ce7:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104ced:	83 f8 01             	cmp    $0x1,%eax
80104cf0:	75 0b                	jne    80104cfd <twakeup+0x4a>
            wakeup1(p);
80104cf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cf5:	89 04 24             	mov    %eax,(%esp)
80104cf8:	e8 74 ff ff ff       	call   80104c71 <wakeup1>

void 
twakeup(int tid){
    struct proc *p;
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cfd:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104d04:	b8 74 20 11 80       	mov    $0x80112074,%eax
80104d09:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104d0c:	72 c0                	jb     80104cce <twakeup+0x1b>
        if(p->state == SLEEPING && p->pid == tid && p->isthread == 1){
            wakeup1(p);
        }
    }
    release(&ptable.lock);
80104d0e:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d15:	e8 96 02 00 00       	call   80104fb0 <release>
}
80104d1a:	c9                   	leave  
80104d1b:	c3                   	ret    

80104d1c <wakeup>:

// Wake up all processes sleeping on chan.
    void
wakeup(void *chan)
{
80104d1c:	55                   	push   %ebp
80104d1d:	89 e5                	mov    %esp,%ebp
80104d1f:	83 ec 18             	sub    $0x18,%esp
    acquire(&ptable.lock);
80104d22:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d29:	e8 21 02 00 00       	call   80104f4f <acquire>
    wakeup1(chan);
80104d2e:	8b 45 08             	mov    0x8(%ebp),%eax
80104d31:	89 04 24             	mov    %eax,(%esp)
80104d34:	e8 38 ff ff ff       	call   80104c71 <wakeup1>
    release(&ptable.lock);
80104d39:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d40:	e8 6b 02 00 00       	call   80104fb0 <release>
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    

80104d47 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
    int
kill(int pid)
{
80104d47:	55                   	push   %ebp
80104d48:	89 e5                	mov    %esp,%ebp
80104d4a:	83 ec 28             	sub    $0x28,%esp
    struct proc *p;

    acquire(&ptable.lock);
80104d4d:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d54:	e8 f6 01 00 00       	call   80104f4f <acquire>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d59:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104d60:	eb 44                	jmp    80104da6 <kill+0x5f>
        if(p->pid == pid){
80104d62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d65:	8b 40 10             	mov    0x10(%eax),%eax
80104d68:	3b 45 08             	cmp    0x8(%ebp),%eax
80104d6b:	75 32                	jne    80104d9f <kill+0x58>
            p->killed = 1;
80104d6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d70:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
            // Wake process from sleep if necessary.
            if(p->state == SLEEPING)
80104d77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d7a:	8b 40 0c             	mov    0xc(%eax),%eax
80104d7d:	83 f8 02             	cmp    $0x2,%eax
80104d80:	75 0a                	jne    80104d8c <kill+0x45>
                p->state = RUNNABLE;
80104d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
            release(&ptable.lock);
80104d8c:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104d93:	e8 18 02 00 00       	call   80104fb0 <release>
            return 0;
80104d98:	b8 00 00 00 00       	mov    $0x0,%eax
80104d9d:	eb 22                	jmp    80104dc1 <kill+0x7a>
kill(int pid)
{
    struct proc *p;

    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d9f:	81 45 f4 84 00 00 00 	addl   $0x84,-0xc(%ebp)
80104da6:	b8 74 20 11 80       	mov    $0x80112074,%eax
80104dab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104dae:	72 b2                	jb     80104d62 <kill+0x1b>
                p->state = RUNNABLE;
            release(&ptable.lock);
            return 0;
        }
    }
    release(&ptable.lock);
80104db0:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104db7:	e8 f4 01 00 00       	call   80104fb0 <release>
    return -1;
80104dbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dc1:	c9                   	leave  
80104dc2:	c3                   	ret    

80104dc3 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
    void
procdump(void)
{
80104dc3:	55                   	push   %ebp
80104dc4:	89 e5                	mov    %esp,%ebp
80104dc6:	83 ec 58             	sub    $0x58,%esp
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104dc9:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
80104dd0:	e9 db 00 00 00       	jmp    80104eb0 <procdump+0xed>
        if(p->state == UNUSED)
80104dd5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104dd8:	8b 40 0c             	mov    0xc(%eax),%eax
80104ddb:	85 c0                	test   %eax,%eax
80104ddd:	0f 84 c5 00 00 00    	je     80104ea8 <procdump+0xe5>
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104de3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104de6:	8b 40 0c             	mov    0xc(%eax),%eax
80104de9:	83 f8 05             	cmp    $0x5,%eax
80104dec:	77 23                	ja     80104e11 <procdump+0x4e>
80104dee:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104df1:	8b 40 0c             	mov    0xc(%eax),%eax
80104df4:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104dfb:	85 c0                	test   %eax,%eax
80104dfd:	74 12                	je     80104e11 <procdump+0x4e>
            state = states[p->state];
80104dff:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e02:	8b 40 0c             	mov    0xc(%eax),%eax
80104e05:	8b 04 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%eax
80104e0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == UNUSED)
            continue;
        if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104e0f:	eb 07                	jmp    80104e18 <procdump+0x55>
            state = states[p->state];
        else
            state = "???";
80104e11:	c7 45 f4 90 89 10 80 	movl   $0x80108990,-0xc(%ebp)
        cprintf("%d %s %s", p->pid, state, p->name);
80104e18:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e1b:	8d 50 6c             	lea    0x6c(%eax),%edx
80104e1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e21:	8b 40 10             	mov    0x10(%eax),%eax
80104e24:	89 54 24 0c          	mov    %edx,0xc(%esp)
80104e28:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e2b:	89 54 24 08          	mov    %edx,0x8(%esp)
80104e2f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e33:	c7 04 24 94 89 10 80 	movl   $0x80108994,(%esp)
80104e3a:	e8 5b b5 ff ff       	call   8010039a <cprintf>
        if(p->state == SLEEPING){
80104e3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e42:	8b 40 0c             	mov    0xc(%eax),%eax
80104e45:	83 f8 02             	cmp    $0x2,%eax
80104e48:	75 50                	jne    80104e9a <procdump+0xd7>
            getcallerpcs((uint*)p->context->ebp+2, pc);
80104e4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104e4d:	8b 40 1c             	mov    0x1c(%eax),%eax
80104e50:	8b 40 0c             	mov    0xc(%eax),%eax
80104e53:	83 c0 08             	add    $0x8,%eax
80104e56:	8d 55 c4             	lea    -0x3c(%ebp),%edx
80104e59:	89 54 24 04          	mov    %edx,0x4(%esp)
80104e5d:	89 04 24             	mov    %eax,(%esp)
80104e60:	e8 9a 01 00 00       	call   80104fff <getcallerpcs>
            for(i=0; i<10 && pc[i] != 0; i++)
80104e65:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104e6c:	eb 1b                	jmp    80104e89 <procdump+0xc6>
                cprintf(" %p", pc[i]);
80104e6e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104e71:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104e75:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e79:	c7 04 24 9d 89 10 80 	movl   $0x8010899d,(%esp)
80104e80:	e8 15 b5 ff ff       	call   8010039a <cprintf>
        else
            state = "???";
        cprintf("%d %s %s", p->pid, state, p->name);
        if(p->state == SLEEPING){
            getcallerpcs((uint*)p->context->ebp+2, pc);
            for(i=0; i<10 && pc[i] != 0; i++)
80104e85:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80104e89:	83 7d ec 09          	cmpl   $0x9,-0x14(%ebp)
80104e8d:	7f 0b                	jg     80104e9a <procdump+0xd7>
80104e8f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104e92:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104e96:	85 c0                	test   %eax,%eax
80104e98:	75 d4                	jne    80104e6e <procdump+0xab>
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
80104e9a:	c7 04 24 a1 89 10 80 	movl   $0x801089a1,(%esp)
80104ea1:	e8 f4 b4 ff ff       	call   8010039a <cprintf>
80104ea6:	eb 01                	jmp    80104ea9 <procdump+0xe6>
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
        if(p->state == UNUSED)
            continue;
80104ea8:	90                   	nop
    int i;
    struct proc *p;
    char *state;
    uint pc[10];

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ea9:	81 45 f0 84 00 00 00 	addl   $0x84,-0x10(%ebp)
80104eb0:	b8 74 20 11 80       	mov    $0x80112074,%eax
80104eb5:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80104eb8:	0f 82 17 ff ff ff    	jb     80104dd5 <procdump+0x12>
            for(i=0; i<10 && pc[i] != 0; i++)
                cprintf(" %p", pc[i]);
        }
        cprintf("\n");
    }
}
80104ebe:	c9                   	leave  
80104ebf:	c3                   	ret    

80104ec0 <tsleep>:

void tsleep(void){
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	83 ec 18             	sub    $0x18,%esp
    
    acquire(&ptable.lock); 
80104ec6:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104ecd:	e8 7d 00 00 00       	call   80104f4f <acquire>
    sleep(proc, &ptable.lock);
80104ed2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104ed8:	c7 44 24 04 40 ff 10 	movl   $0x8010ff40,0x4(%esp)
80104edf:	80 
80104ee0:	89 04 24             	mov    %eax,(%esp)
80104ee3:	e8 ee fc ff ff       	call   80104bd6 <sleep>
    release(&ptable.lock);
80104ee8:	c7 04 24 40 ff 10 80 	movl   $0x8010ff40,(%esp)
80104eef:	e8 bc 00 00 00       	call   80104fb0 <release>

}
80104ef4:	c9                   	leave  
80104ef5:	c3                   	ret    
	...

80104ef8 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104ef8:	55                   	push   %ebp
80104ef9:	89 e5                	mov    %esp,%ebp
80104efb:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104efe:	9c                   	pushf  
80104eff:	58                   	pop    %eax
80104f00:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104f03:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104f06:	c9                   	leave  
80104f07:	c3                   	ret    

80104f08 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104f08:	55                   	push   %ebp
80104f09:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104f0b:	fa                   	cli    
}
80104f0c:	5d                   	pop    %ebp
80104f0d:	c3                   	ret    

80104f0e <sti>:

static inline void
sti(void)
{
80104f0e:	55                   	push   %ebp
80104f0f:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104f11:	fb                   	sti    
}
80104f12:	5d                   	pop    %ebp
80104f13:	c3                   	ret    

80104f14 <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104f14:	55                   	push   %ebp
80104f15:	89 e5                	mov    %esp,%ebp
80104f17:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104f1a:	8b 55 08             	mov    0x8(%ebp),%edx
80104f1d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f20:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104f23:	f0 87 02             	lock xchg %eax,(%edx)
80104f26:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104f29:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104f2c:	c9                   	leave  
80104f2d:	c3                   	ret    

80104f2e <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f2e:	55                   	push   %ebp
80104f2f:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104f31:	8b 45 08             	mov    0x8(%ebp),%eax
80104f34:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f37:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104f3a:	8b 45 08             	mov    0x8(%ebp),%eax
80104f3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104f43:	8b 45 08             	mov    0x8(%ebp),%eax
80104f46:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    

80104f4f <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104f4f:	55                   	push   %ebp
80104f50:	89 e5                	mov    %esp,%ebp
80104f52:	83 ec 18             	sub    $0x18,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104f55:	e8 3e 01 00 00       	call   80105098 <pushcli>
  if(holding(lk))
80104f5a:	8b 45 08             	mov    0x8(%ebp),%eax
80104f5d:	89 04 24             	mov    %eax,(%esp)
80104f60:	e8 09 01 00 00       	call   8010506e <holding>
80104f65:	85 c0                	test   %eax,%eax
80104f67:	74 0c                	je     80104f75 <acquire+0x26>
    panic("acquire");
80104f69:	c7 04 24 cd 89 10 80 	movl   $0x801089cd,(%esp)
80104f70:	e8 c5 b5 ff ff       	call   8010053a <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104f75:	8b 45 08             	mov    0x8(%ebp),%eax
80104f78:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80104f7f:	00 
80104f80:	89 04 24             	mov    %eax,(%esp)
80104f83:	e8 8c ff ff ff       	call   80104f14 <xchg>
80104f88:	85 c0                	test   %eax,%eax
80104f8a:	75 e9                	jne    80104f75 <acquire+0x26>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104f8c:	8b 45 08             	mov    0x8(%ebp),%eax
80104f8f:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104f96:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104f99:	8b 45 08             	mov    0x8(%ebp),%eax
80104f9c:	83 c0 0c             	add    $0xc,%eax
80104f9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fa3:	8d 45 08             	lea    0x8(%ebp),%eax
80104fa6:	89 04 24             	mov    %eax,(%esp)
80104fa9:	e8 51 00 00 00       	call   80104fff <getcallerpcs>
}
80104fae:	c9                   	leave  
80104faf:	c3                   	ret    

80104fb0 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	83 ec 18             	sub    $0x18,%esp
  if(!holding(lk))
80104fb6:	8b 45 08             	mov    0x8(%ebp),%eax
80104fb9:	89 04 24             	mov    %eax,(%esp)
80104fbc:	e8 ad 00 00 00       	call   8010506e <holding>
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	75 0c                	jne    80104fd1 <release+0x21>
    panic("release");
80104fc5:	c7 04 24 d5 89 10 80 	movl   $0x801089d5,(%esp)
80104fcc:	e8 69 b5 ff ff       	call   8010053a <panic>

  lk->pcs[0] = 0;
80104fd1:	8b 45 08             	mov    0x8(%ebp),%eax
80104fd4:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80104fde:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104fe5:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104fef:	00 
80104ff0:	89 04 24             	mov    %eax,(%esp)
80104ff3:	e8 1c ff ff ff       	call   80104f14 <xchg>

  popcli();
80104ff8:	e8 e3 00 00 00       	call   801050e0 <popcli>
}
80104ffd:	c9                   	leave  
80104ffe:	c3                   	ret    

80104fff <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104fff:	55                   	push   %ebp
80105000:	89 e5                	mov    %esp,%ebp
80105002:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80105005:	8b 45 08             	mov    0x8(%ebp),%eax
80105008:	83 e8 08             	sub    $0x8,%eax
8010500b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(i = 0; i < 10; i++){
8010500e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80105015:	eb 34                	jmp    8010504b <getcallerpcs+0x4c>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105017:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
8010501b:	74 49                	je     80105066 <getcallerpcs+0x67>
8010501d:	81 7d f8 ff ff ff 7f 	cmpl   $0x7fffffff,-0x8(%ebp)
80105024:	76 40                	jbe    80105066 <getcallerpcs+0x67>
80105026:	83 7d f8 ff          	cmpl   $0xffffffff,-0x8(%ebp)
8010502a:	74 3a                	je     80105066 <getcallerpcs+0x67>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010502c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010502f:	c1 e0 02             	shl    $0x2,%eax
80105032:	03 45 0c             	add    0xc(%ebp),%eax
80105035:	8b 55 f8             	mov    -0x8(%ebp),%edx
80105038:	83 c2 04             	add    $0x4,%edx
8010503b:	8b 12                	mov    (%edx),%edx
8010503d:	89 10                	mov    %edx,(%eax)
    ebp = (uint*)ebp[0]; // saved %ebp
8010503f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105042:	8b 00                	mov    (%eax),%eax
80105044:	89 45 f8             	mov    %eax,-0x8(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80105047:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010504b:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
8010504f:	7e c6                	jle    80105017 <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105051:	eb 13                	jmp    80105066 <getcallerpcs+0x67>
    pcs[i] = 0;
80105053:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105056:	c1 e0 02             	shl    $0x2,%eax
80105059:	03 45 0c             	add    0xc(%ebp),%eax
8010505c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80105062:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105066:	83 7d fc 09          	cmpl   $0x9,-0x4(%ebp)
8010506a:	7e e7                	jle    80105053 <getcallerpcs+0x54>
    pcs[i] = 0;
}
8010506c:	c9                   	leave  
8010506d:	c3                   	ret    

8010506e <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
8010506e:	55                   	push   %ebp
8010506f:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80105071:	8b 45 08             	mov    0x8(%ebp),%eax
80105074:	8b 00                	mov    (%eax),%eax
80105076:	85 c0                	test   %eax,%eax
80105078:	74 17                	je     80105091 <holding+0x23>
8010507a:	8b 45 08             	mov    0x8(%ebp),%eax
8010507d:	8b 50 08             	mov    0x8(%eax),%edx
80105080:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105086:	39 c2                	cmp    %eax,%edx
80105088:	75 07                	jne    80105091 <holding+0x23>
8010508a:	b8 01 00 00 00       	mov    $0x1,%eax
8010508f:	eb 05                	jmp    80105096 <holding+0x28>
80105091:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105096:	5d                   	pop    %ebp
80105097:	c3                   	ret    

80105098 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105098:	55                   	push   %ebp
80105099:	89 e5                	mov    %esp,%ebp
8010509b:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
8010509e:	e8 55 fe ff ff       	call   80104ef8 <readeflags>
801050a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
801050a6:	e8 5d fe ff ff       	call   80104f08 <cli>
  if(cpu->ncli++ == 0)
801050ab:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050b1:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
801050b7:	85 d2                	test   %edx,%edx
801050b9:	0f 94 c1             	sete   %cl
801050bc:	83 c2 01             	add    $0x1,%edx
801050bf:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
801050c5:	84 c9                	test   %cl,%cl
801050c7:	74 15                	je     801050de <pushcli+0x46>
    cpu->intena = eflags & FL_IF;
801050c9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801050cf:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050d2:	81 e2 00 02 00 00    	and    $0x200,%edx
801050d8:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
801050de:	c9                   	leave  
801050df:	c3                   	ret    

801050e0 <popcli>:

void
popcli(void)
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	83 ec 18             	sub    $0x18,%esp
  if(readeflags()&FL_IF)
801050e6:	e8 0d fe ff ff       	call   80104ef8 <readeflags>
801050eb:	25 00 02 00 00       	and    $0x200,%eax
801050f0:	85 c0                	test   %eax,%eax
801050f2:	74 0c                	je     80105100 <popcli+0x20>
    panic("popcli - interruptible");
801050f4:	c7 04 24 dd 89 10 80 	movl   $0x801089dd,(%esp)
801050fb:	e8 3a b4 ff ff       	call   8010053a <panic>
  if(--cpu->ncli < 0)
80105100:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105106:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
8010510c:	83 ea 01             	sub    $0x1,%edx
8010510f:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80105115:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
8010511b:	85 c0                	test   %eax,%eax
8010511d:	79 0c                	jns    8010512b <popcli+0x4b>
    panic("popcli");
8010511f:	c7 04 24 f4 89 10 80 	movl   $0x801089f4,(%esp)
80105126:	e8 0f b4 ff ff       	call   8010053a <panic>
  if(cpu->ncli == 0 && cpu->intena)
8010512b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105131:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80105137:	85 c0                	test   %eax,%eax
80105139:	75 15                	jne    80105150 <popcli+0x70>
8010513b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80105141:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80105147:	85 c0                	test   %eax,%eax
80105149:	74 05                	je     80105150 <popcli+0x70>
    sti();
8010514b:	e8 be fd ff ff       	call   80104f0e <sti>
}
80105150:	c9                   	leave  
80105151:	c3                   	ret    
	...

80105154 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80105154:	55                   	push   %ebp
80105155:	89 e5                	mov    %esp,%ebp
80105157:	57                   	push   %edi
80105158:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80105159:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010515c:	8b 55 10             	mov    0x10(%ebp),%edx
8010515f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105162:	89 cb                	mov    %ecx,%ebx
80105164:	89 df                	mov    %ebx,%edi
80105166:	89 d1                	mov    %edx,%ecx
80105168:	fc                   	cld    
80105169:	f3 aa                	rep stos %al,%es:(%edi)
8010516b:	89 ca                	mov    %ecx,%edx
8010516d:	89 fb                	mov    %edi,%ebx
8010516f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105172:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80105175:	5b                   	pop    %ebx
80105176:	5f                   	pop    %edi
80105177:	5d                   	pop    %ebp
80105178:	c3                   	ret    

80105179 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80105179:	55                   	push   %ebp
8010517a:	89 e5                	mov    %esp,%ebp
8010517c:	57                   	push   %edi
8010517d:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
8010517e:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105181:	8b 55 10             	mov    0x10(%ebp),%edx
80105184:	8b 45 0c             	mov    0xc(%ebp),%eax
80105187:	89 cb                	mov    %ecx,%ebx
80105189:	89 df                	mov    %ebx,%edi
8010518b:	89 d1                	mov    %edx,%ecx
8010518d:	fc                   	cld    
8010518e:	f3 ab                	rep stos %eax,%es:(%edi)
80105190:	89 ca                	mov    %ecx,%edx
80105192:	89 fb                	mov    %edi,%ebx
80105194:	89 5d 08             	mov    %ebx,0x8(%ebp)
80105197:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
8010519a:	5b                   	pop    %ebx
8010519b:	5f                   	pop    %edi
8010519c:	5d                   	pop    %ebp
8010519d:	c3                   	ret    

8010519e <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
8010519e:	55                   	push   %ebp
8010519f:	89 e5                	mov    %esp,%ebp
801051a1:	83 ec 0c             	sub    $0xc,%esp
  if ((int)dst%4 == 0 && n%4 == 0){
801051a4:	8b 45 08             	mov    0x8(%ebp),%eax
801051a7:	83 e0 03             	and    $0x3,%eax
801051aa:	85 c0                	test   %eax,%eax
801051ac:	75 49                	jne    801051f7 <memset+0x59>
801051ae:	8b 45 10             	mov    0x10(%ebp),%eax
801051b1:	83 e0 03             	and    $0x3,%eax
801051b4:	85 c0                	test   %eax,%eax
801051b6:	75 3f                	jne    801051f7 <memset+0x59>
    c &= 0xFF;
801051b8:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051bf:	8b 45 10             	mov    0x10(%ebp),%eax
801051c2:	c1 e8 02             	shr    $0x2,%eax
801051c5:	89 c2                	mov    %eax,%edx
801051c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ca:	89 c1                	mov    %eax,%ecx
801051cc:	c1 e1 18             	shl    $0x18,%ecx
801051cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801051d2:	c1 e0 10             	shl    $0x10,%eax
801051d5:	09 c1                	or     %eax,%ecx
801051d7:	8b 45 0c             	mov    0xc(%ebp),%eax
801051da:	c1 e0 08             	shl    $0x8,%eax
801051dd:	09 c8                	or     %ecx,%eax
801051df:	0b 45 0c             	or     0xc(%ebp),%eax
801051e2:	89 54 24 08          	mov    %edx,0x8(%esp)
801051e6:	89 44 24 04          	mov    %eax,0x4(%esp)
801051ea:	8b 45 08             	mov    0x8(%ebp),%eax
801051ed:	89 04 24             	mov    %eax,(%esp)
801051f0:	e8 84 ff ff ff       	call   80105179 <stosl>
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
801051f5:	eb 19                	jmp    80105210 <memset+0x72>
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
801051f7:	8b 45 10             	mov    0x10(%ebp),%eax
801051fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801051fe:	8b 45 0c             	mov    0xc(%ebp),%eax
80105201:	89 44 24 04          	mov    %eax,0x4(%esp)
80105205:	8b 45 08             	mov    0x8(%ebp),%eax
80105208:	89 04 24             	mov    %eax,(%esp)
8010520b:	e8 44 ff ff ff       	call   80105154 <stosb>
  return dst;
80105210:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105213:	c9                   	leave  
80105214:	c3                   	ret    

80105215 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105215:	55                   	push   %ebp
80105216:	89 e5                	mov    %esp,%ebp
80105218:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
8010521b:	8b 45 08             	mov    0x8(%ebp),%eax
8010521e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  s2 = v2;
80105221:	8b 45 0c             	mov    0xc(%ebp),%eax
80105224:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0){
80105227:	eb 32                	jmp    8010525b <memcmp+0x46>
    if(*s1 != *s2)
80105229:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010522c:	0f b6 10             	movzbl (%eax),%edx
8010522f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105232:	0f b6 00             	movzbl (%eax),%eax
80105235:	38 c2                	cmp    %al,%dl
80105237:	74 1a                	je     80105253 <memcmp+0x3e>
      return *s1 - *s2;
80105239:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010523c:	0f b6 00             	movzbl (%eax),%eax
8010523f:	0f b6 d0             	movzbl %al,%edx
80105242:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105245:	0f b6 00             	movzbl (%eax),%eax
80105248:	0f b6 c0             	movzbl %al,%eax
8010524b:	89 d1                	mov    %edx,%ecx
8010524d:	29 c1                	sub    %eax,%ecx
8010524f:	89 c8                	mov    %ecx,%eax
80105251:	eb 1c                	jmp    8010526f <memcmp+0x5a>
    s1++, s2++;
80105253:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80105257:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010525b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010525f:	0f 95 c0             	setne  %al
80105262:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105266:	84 c0                	test   %al,%al
80105268:	75 bf                	jne    80105229 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010526a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010526f:	c9                   	leave  
80105270:	c3                   	ret    

80105271 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105271:	55                   	push   %ebp
80105272:	89 e5                	mov    %esp,%ebp
80105274:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80105277:	8b 45 0c             	mov    0xc(%ebp),%eax
8010527a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  d = dst;
8010527d:	8b 45 08             	mov    0x8(%ebp),%eax
80105280:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(s < d && s + n > d){
80105283:	8b 45 f8             	mov    -0x8(%ebp),%eax
80105286:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80105289:	73 55                	jae    801052e0 <memmove+0x6f>
8010528b:	8b 45 10             	mov    0x10(%ebp),%eax
8010528e:	8b 55 f8             	mov    -0x8(%ebp),%edx
80105291:	8d 04 02             	lea    (%edx,%eax,1),%eax
80105294:	3b 45 fc             	cmp    -0x4(%ebp),%eax
80105297:	76 4a                	jbe    801052e3 <memmove+0x72>
    s += n;
80105299:	8b 45 10             	mov    0x10(%ebp),%eax
8010529c:	01 45 f8             	add    %eax,-0x8(%ebp)
    d += n;
8010529f:	8b 45 10             	mov    0x10(%ebp),%eax
801052a2:	01 45 fc             	add    %eax,-0x4(%ebp)
    while(n-- > 0)
801052a5:	eb 13                	jmp    801052ba <memmove+0x49>
      *--d = *--s;
801052a7:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801052ab:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801052af:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052b2:	0f b6 10             	movzbl (%eax),%edx
801052b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052b8:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801052ba:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052be:	0f 95 c0             	setne  %al
801052c1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052c5:	84 c0                	test   %al,%al
801052c7:	75 de                	jne    801052a7 <memmove+0x36>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801052c9:	eb 28                	jmp    801052f3 <memmove+0x82>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
801052cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
801052ce:	0f b6 10             	movzbl (%eax),%edx
801052d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
801052d4:	88 10                	mov    %dl,(%eax)
801052d6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801052da:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801052de:	eb 04                	jmp    801052e4 <memmove+0x73>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801052e0:	90                   	nop
801052e1:	eb 01                	jmp    801052e4 <memmove+0x73>
801052e3:	90                   	nop
801052e4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801052e8:	0f 95 c0             	setne  %al
801052eb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801052ef:	84 c0                	test   %al,%al
801052f1:	75 d8                	jne    801052cb <memmove+0x5a>
      *d++ = *s++;

  return dst;
801052f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801052f6:	c9                   	leave  
801052f7:	c3                   	ret    

801052f8 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801052f8:	55                   	push   %ebp
801052f9:	89 e5                	mov    %esp,%ebp
801052fb:	83 ec 0c             	sub    $0xc,%esp
  return memmove(dst, src, n);
801052fe:	8b 45 10             	mov    0x10(%ebp),%eax
80105301:	89 44 24 08          	mov    %eax,0x8(%esp)
80105305:	8b 45 0c             	mov    0xc(%ebp),%eax
80105308:	89 44 24 04          	mov    %eax,0x4(%esp)
8010530c:	8b 45 08             	mov    0x8(%ebp),%eax
8010530f:	89 04 24             	mov    %eax,(%esp)
80105312:	e8 5a ff ff ff       	call   80105271 <memmove>
}
80105317:	c9                   	leave  
80105318:	c3                   	ret    

80105319 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80105319:	55                   	push   %ebp
8010531a:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010531c:	eb 0c                	jmp    8010532a <strncmp+0x11>
    n--, p++, q++;
8010531e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105322:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80105326:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010532a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010532e:	74 1a                	je     8010534a <strncmp+0x31>
80105330:	8b 45 08             	mov    0x8(%ebp),%eax
80105333:	0f b6 00             	movzbl (%eax),%eax
80105336:	84 c0                	test   %al,%al
80105338:	74 10                	je     8010534a <strncmp+0x31>
8010533a:	8b 45 08             	mov    0x8(%ebp),%eax
8010533d:	0f b6 10             	movzbl (%eax),%edx
80105340:	8b 45 0c             	mov    0xc(%ebp),%eax
80105343:	0f b6 00             	movzbl (%eax),%eax
80105346:	38 c2                	cmp    %al,%dl
80105348:	74 d4                	je     8010531e <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
8010534a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010534e:	75 07                	jne    80105357 <strncmp+0x3e>
    return 0;
80105350:	b8 00 00 00 00       	mov    $0x0,%eax
80105355:	eb 18                	jmp    8010536f <strncmp+0x56>
  return (uchar)*p - (uchar)*q;
80105357:	8b 45 08             	mov    0x8(%ebp),%eax
8010535a:	0f b6 00             	movzbl (%eax),%eax
8010535d:	0f b6 d0             	movzbl %al,%edx
80105360:	8b 45 0c             	mov    0xc(%ebp),%eax
80105363:	0f b6 00             	movzbl (%eax),%eax
80105366:	0f b6 c0             	movzbl %al,%eax
80105369:	89 d1                	mov    %edx,%ecx
8010536b:	29 c1                	sub    %eax,%ecx
8010536d:	89 c8                	mov    %ecx,%eax
}
8010536f:	5d                   	pop    %ebp
80105370:	c3                   	ret    

80105371 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105371:	55                   	push   %ebp
80105372:	89 e5                	mov    %esp,%ebp
80105374:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105377:	8b 45 08             	mov    0x8(%ebp),%eax
8010537a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010537d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105381:	0f 9f c0             	setg   %al
80105384:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80105388:	84 c0                	test   %al,%al
8010538a:	74 30                	je     801053bc <strncpy+0x4b>
8010538c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010538f:	0f b6 10             	movzbl (%eax),%edx
80105392:	8b 45 08             	mov    0x8(%ebp),%eax
80105395:	88 10                	mov    %dl,(%eax)
80105397:	8b 45 08             	mov    0x8(%ebp),%eax
8010539a:	0f b6 00             	movzbl (%eax),%eax
8010539d:	84 c0                	test   %al,%al
8010539f:	0f 95 c0             	setne  %al
801053a2:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801053a6:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801053aa:	84 c0                	test   %al,%al
801053ac:	75 cf                	jne    8010537d <strncpy+0xc>
    ;
  while(n-- > 0)
801053ae:	eb 0d                	jmp    801053bd <strncpy+0x4c>
    *s++ = 0;
801053b0:	8b 45 08             	mov    0x8(%ebp),%eax
801053b3:	c6 00 00             	movb   $0x0,(%eax)
801053b6:	83 45 08 01          	addl   $0x1,0x8(%ebp)
801053ba:	eb 01                	jmp    801053bd <strncpy+0x4c>
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801053bc:	90                   	nop
801053bd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053c1:	0f 9f c0             	setg   %al
801053c4:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053c8:	84 c0                	test   %al,%al
801053ca:	75 e4                	jne    801053b0 <strncpy+0x3f>
    *s++ = 0;
  return os;
801053cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801053cf:	c9                   	leave  
801053d0:	c3                   	ret    

801053d1 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801053d1:	55                   	push   %ebp
801053d2:	89 e5                	mov    %esp,%ebp
801053d4:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
801053d7:	8b 45 08             	mov    0x8(%ebp),%eax
801053da:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801053dd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053e1:	7f 05                	jg     801053e8 <safestrcpy+0x17>
    return os;
801053e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053e6:	eb 35                	jmp    8010541d <safestrcpy+0x4c>
  while(--n > 0 && (*s++ = *t++) != 0)
801053e8:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801053ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801053f0:	7e 22                	jle    80105414 <safestrcpy+0x43>
801053f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f5:	0f b6 10             	movzbl (%eax),%edx
801053f8:	8b 45 08             	mov    0x8(%ebp),%eax
801053fb:	88 10                	mov    %dl,(%eax)
801053fd:	8b 45 08             	mov    0x8(%ebp),%eax
80105400:	0f b6 00             	movzbl (%eax),%eax
80105403:	84 c0                	test   %al,%al
80105405:	0f 95 c0             	setne  %al
80105408:	83 45 08 01          	addl   $0x1,0x8(%ebp)
8010540c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105410:	84 c0                	test   %al,%al
80105412:	75 d4                	jne    801053e8 <safestrcpy+0x17>
    ;
  *s = 0;
80105414:	8b 45 08             	mov    0x8(%ebp),%eax
80105417:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010541a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010541d:	c9                   	leave  
8010541e:	c3                   	ret    

8010541f <strlen>:

int
strlen(const char *s)
{
8010541f:	55                   	push   %ebp
80105420:	89 e5                	mov    %esp,%ebp
80105422:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80105425:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010542c:	eb 04                	jmp    80105432 <strlen+0x13>
8010542e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105432:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105435:	03 45 08             	add    0x8(%ebp),%eax
80105438:	0f b6 00             	movzbl (%eax),%eax
8010543b:	84 c0                	test   %al,%al
8010543d:	75 ef                	jne    8010542e <strlen+0xf>
    ;
  return n;
8010543f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105442:	c9                   	leave  
80105443:	c3                   	ret    

80105444 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
80105444:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80105448:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
8010544c:	55                   	push   %ebp
  pushl %ebx
8010544d:	53                   	push   %ebx
  pushl %esi
8010544e:	56                   	push   %esi
  pushl %edi
8010544f:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80105450:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80105452:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
80105454:	5f                   	pop    %edi
  popl %esi
80105455:	5e                   	pop    %esi
  popl %ebx
80105456:	5b                   	pop    %ebx
  popl %ebp
80105457:	5d                   	pop    %ebp
  ret
80105458:	c3                   	ret    
80105459:	00 00                	add    %al,(%eax)
	...

8010545c <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010545c:	55                   	push   %ebp
8010545d:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
8010545f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105465:	8b 00                	mov    (%eax),%eax
80105467:	3b 45 08             	cmp    0x8(%ebp),%eax
8010546a:	76 12                	jbe    8010547e <fetchint+0x22>
8010546c:	8b 45 08             	mov    0x8(%ebp),%eax
8010546f:	8d 50 04             	lea    0x4(%eax),%edx
80105472:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105478:	8b 00                	mov    (%eax),%eax
8010547a:	39 c2                	cmp    %eax,%edx
8010547c:	76 07                	jbe    80105485 <fetchint+0x29>
    return -1;
8010547e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105483:	eb 0f                	jmp    80105494 <fetchint+0x38>
  *ip = *(int*)(addr);
80105485:	8b 45 08             	mov    0x8(%ebp),%eax
80105488:	8b 10                	mov    (%eax),%edx
8010548a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010548d:	89 10                	mov    %edx,(%eax)
  return 0;
8010548f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105494:	5d                   	pop    %ebp
80105495:	c3                   	ret    

80105496 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105496:	55                   	push   %ebp
80105497:	89 e5                	mov    %esp,%ebp
80105499:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
8010549c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054a2:	8b 00                	mov    (%eax),%eax
801054a4:	3b 45 08             	cmp    0x8(%ebp),%eax
801054a7:	77 07                	ja     801054b0 <fetchstr+0x1a>
    return -1;
801054a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ae:	eb 48                	jmp    801054f8 <fetchstr+0x62>
  *pp = (char*)addr;
801054b0:	8b 55 08             	mov    0x8(%ebp),%edx
801054b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801054b6:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
801054b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054be:	8b 00                	mov    (%eax),%eax
801054c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(s = *pp; s < ep; s++)
801054c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801054c6:	8b 00                	mov    (%eax),%eax
801054c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
801054cb:	eb 1e                	jmp    801054eb <fetchstr+0x55>
    if(*s == 0)
801054cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
801054d0:	0f b6 00             	movzbl (%eax),%eax
801054d3:	84 c0                	test   %al,%al
801054d5:	75 10                	jne    801054e7 <fetchstr+0x51>
      return s - *pp;
801054d7:	8b 55 f8             	mov    -0x8(%ebp),%edx
801054da:	8b 45 0c             	mov    0xc(%ebp),%eax
801054dd:	8b 00                	mov    (%eax),%eax
801054df:	89 d1                	mov    %edx,%ecx
801054e1:	29 c1                	sub    %eax,%ecx
801054e3:	89 c8                	mov    %ecx,%eax
801054e5:	eb 11                	jmp    801054f8 <fetchstr+0x62>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801054e7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801054eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
801054ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
801054f1:	72 da                	jb     801054cd <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
801054f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054f8:	c9                   	leave  
801054f9:	c3                   	ret    

801054fa <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801054fa:	55                   	push   %ebp
801054fb:	89 e5                	mov    %esp,%ebp
801054fd:	83 ec 08             	sub    $0x8,%esp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105500:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105506:	8b 40 18             	mov    0x18(%eax),%eax
80105509:	8b 50 44             	mov    0x44(%eax),%edx
8010550c:	8b 45 08             	mov    0x8(%ebp),%eax
8010550f:	c1 e0 02             	shl    $0x2,%eax
80105512:	8d 04 02             	lea    (%edx,%eax,1),%eax
80105515:	8d 50 04             	lea    0x4(%eax),%edx
80105518:	8b 45 0c             	mov    0xc(%ebp),%eax
8010551b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010551f:	89 14 24             	mov    %edx,(%esp)
80105522:	e8 35 ff ff ff       	call   8010545c <fetchint>
}
80105527:	c9                   	leave  
80105528:	c3                   	ret    

80105529 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105529:	55                   	push   %ebp
8010552a:	89 e5                	mov    %esp,%ebp
8010552c:	83 ec 18             	sub    $0x18,%esp
  int i;
  
  if(argint(n, &i) < 0)
8010552f:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105532:	89 44 24 04          	mov    %eax,0x4(%esp)
80105536:	8b 45 08             	mov    0x8(%ebp),%eax
80105539:	89 04 24             	mov    %eax,(%esp)
8010553c:	e8 b9 ff ff ff       	call   801054fa <argint>
80105541:	85 c0                	test   %eax,%eax
80105543:	79 07                	jns    8010554c <argptr+0x23>
    return -1;
80105545:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010554a:	eb 3d                	jmp    80105589 <argptr+0x60>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
8010554c:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010554f:	89 c2                	mov    %eax,%edx
80105551:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105557:	8b 00                	mov    (%eax),%eax
80105559:	39 c2                	cmp    %eax,%edx
8010555b:	73 16                	jae    80105573 <argptr+0x4a>
8010555d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105560:	89 c2                	mov    %eax,%edx
80105562:	8b 45 10             	mov    0x10(%ebp),%eax
80105565:	01 c2                	add    %eax,%edx
80105567:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010556d:	8b 00                	mov    (%eax),%eax
8010556f:	39 c2                	cmp    %eax,%edx
80105571:	76 07                	jbe    8010557a <argptr+0x51>
    return -1;
80105573:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105578:	eb 0f                	jmp    80105589 <argptr+0x60>
  *pp = (char*)i;
8010557a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010557d:	89 c2                	mov    %eax,%edx
8010557f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105582:	89 10                	mov    %edx,(%eax)
  return 0;
80105584:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105589:	c9                   	leave  
8010558a:	c3                   	ret    

8010558b <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
8010558b:	55                   	push   %ebp
8010558c:	89 e5                	mov    %esp,%ebp
8010558e:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80105591:	8d 45 fc             	lea    -0x4(%ebp),%eax
80105594:	89 44 24 04          	mov    %eax,0x4(%esp)
80105598:	8b 45 08             	mov    0x8(%ebp),%eax
8010559b:	89 04 24             	mov    %eax,(%esp)
8010559e:	e8 57 ff ff ff       	call   801054fa <argint>
801055a3:	85 c0                	test   %eax,%eax
801055a5:	79 07                	jns    801055ae <argstr+0x23>
    return -1;
801055a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ac:	eb 12                	jmp    801055c0 <argstr+0x35>
  return fetchstr(addr, pp);
801055ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
801055b1:	8b 55 0c             	mov    0xc(%ebp),%edx
801055b4:	89 54 24 04          	mov    %edx,0x4(%esp)
801055b8:	89 04 24             	mov    %eax,(%esp)
801055bb:	e8 d6 fe ff ff       	call   80105496 <fetchstr>
}
801055c0:	c9                   	leave  
801055c1:	c3                   	ret    

801055c2 <syscall>:
[SYS_thread_yield] sys_thread_yield, 
};

void
syscall(void)
{
801055c2:	55                   	push   %ebp
801055c3:	89 e5                	mov    %esp,%ebp
801055c5:	53                   	push   %ebx
801055c6:	83 ec 24             	sub    $0x24,%esp
  int num;

  num = proc->tf->eax;
801055c9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055cf:	8b 40 18             	mov    0x18(%eax),%eax
801055d2:	8b 40 1c             	mov    0x1c(%eax),%eax
801055d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801055d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801055dc:	7e 30                	jle    8010560e <syscall+0x4c>
801055de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e1:	83 f8 1a             	cmp    $0x1a,%eax
801055e4:	77 28                	ja     8010560e <syscall+0x4c>
801055e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e9:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
801055f0:	85 c0                	test   %eax,%eax
801055f2:	74 1a                	je     8010560e <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
801055f4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801055fa:	8b 58 18             	mov    0x18(%eax),%ebx
801055fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105600:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105607:	ff d0                	call   *%eax
80105609:	89 43 1c             	mov    %eax,0x1c(%ebx)
syscall(void)
{
  int num;

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010560c:	eb 3d                	jmp    8010564b <syscall+0x89>
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
8010560e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105614:	8d 48 6c             	lea    0x6c(%eax),%ecx
            proc->pid, proc->name, num);
80105617:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010561d:	8b 40 10             	mov    0x10(%eax),%eax
80105620:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105623:	89 54 24 0c          	mov    %edx,0xc(%esp)
80105627:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010562b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010562f:	c7 04 24 fb 89 10 80 	movl   $0x801089fb,(%esp)
80105636:	e8 5f ad ff ff       	call   8010039a <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
8010563b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105641:	8b 40 18             	mov    0x18(%eax),%eax
80105644:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
8010564b:	83 c4 24             	add    $0x24,%esp
8010564e:	5b                   	pop    %ebx
8010564f:	5d                   	pop    %ebp
80105650:	c3                   	ret    
80105651:	00 00                	add    %al,(%eax)
	...

80105654 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80105654:	55                   	push   %ebp
80105655:	89 e5                	mov    %esp,%ebp
80105657:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010565a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010565d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105661:	8b 45 08             	mov    0x8(%ebp),%eax
80105664:	89 04 24             	mov    %eax,(%esp)
80105667:	e8 8e fe ff ff       	call   801054fa <argint>
8010566c:	85 c0                	test   %eax,%eax
8010566e:	79 07                	jns    80105677 <argfd+0x23>
    return -1;
80105670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105675:	eb 50                	jmp    801056c7 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80105677:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010567a:	85 c0                	test   %eax,%eax
8010567c:	78 21                	js     8010569f <argfd+0x4b>
8010567e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105681:	83 f8 0f             	cmp    $0xf,%eax
80105684:	7f 19                	jg     8010569f <argfd+0x4b>
80105686:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010568c:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010568f:	83 c2 08             	add    $0x8,%edx
80105692:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105696:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105699:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010569d:	75 07                	jne    801056a6 <argfd+0x52>
    return -1;
8010569f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056a4:	eb 21                	jmp    801056c7 <argfd+0x73>
  if(pfd)
801056a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801056aa:	74 08                	je     801056b4 <argfd+0x60>
    *pfd = fd;
801056ac:	8b 55 f0             	mov    -0x10(%ebp),%edx
801056af:	8b 45 0c             	mov    0xc(%ebp),%eax
801056b2:	89 10                	mov    %edx,(%eax)
  if(pf)
801056b4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801056b8:	74 08                	je     801056c2 <argfd+0x6e>
    *pf = f;
801056ba:	8b 45 10             	mov    0x10(%ebp),%eax
801056bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c0:	89 10                	mov    %edx,(%eax)
  return 0;
801056c2:	b8 00 00 00 00       	mov    $0x0,%eax
}
801056c7:	c9                   	leave  
801056c8:	c3                   	ret    

801056c9 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
801056c9:	55                   	push   %ebp
801056ca:	89 e5                	mov    %esp,%ebp
801056cc:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801056cf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801056d6:	eb 30                	jmp    80105708 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
801056d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056de:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056e1:	83 c2 08             	add    $0x8,%edx
801056e4:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801056e8:	85 c0                	test   %eax,%eax
801056ea:	75 18                	jne    80105704 <fdalloc+0x3b>
      proc->ofile[fd] = f;
801056ec:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801056f2:	8b 55 fc             	mov    -0x4(%ebp),%edx
801056f5:	8d 4a 08             	lea    0x8(%edx),%ecx
801056f8:	8b 55 08             	mov    0x8(%ebp),%edx
801056fb:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801056ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105702:	eb 0f                	jmp    80105713 <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105704:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105708:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
8010570c:	7e ca                	jle    801056d8 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
8010570e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105713:	c9                   	leave  
80105714:	c3                   	ret    

80105715 <sys_dup>:

int
sys_dup(void)
{
80105715:	55                   	push   %ebp
80105716:	89 e5                	mov    %esp,%ebp
80105718:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
8010571b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010571e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105722:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105729:	00 
8010572a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105731:	e8 1e ff ff ff       	call   80105654 <argfd>
80105736:	85 c0                	test   %eax,%eax
80105738:	79 07                	jns    80105741 <sys_dup+0x2c>
    return -1;
8010573a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010573f:	eb 29                	jmp    8010576a <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105741:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105744:	89 04 24             	mov    %eax,(%esp)
80105747:	e8 7d ff ff ff       	call   801056c9 <fdalloc>
8010574c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010574f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105753:	79 07                	jns    8010575c <sys_dup+0x47>
    return -1;
80105755:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010575a:	eb 0e                	jmp    8010576a <sys_dup+0x55>
  filedup(f);
8010575c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010575f:	89 04 24             	mov    %eax,(%esp)
80105762:	e8 1e b8 ff ff       	call   80100f85 <filedup>
  return fd;
80105767:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010576a:	c9                   	leave  
8010576b:	c3                   	ret    

8010576c <sys_read>:

int
sys_read(void)
{
8010576c:	55                   	push   %ebp
8010576d:	89 e5                	mov    %esp,%ebp
8010576f:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105772:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105775:	89 44 24 08          	mov    %eax,0x8(%esp)
80105779:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105780:	00 
80105781:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105788:	e8 c7 fe ff ff       	call   80105654 <argfd>
8010578d:	85 c0                	test   %eax,%eax
8010578f:	78 35                	js     801057c6 <sys_read+0x5a>
80105791:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105794:	89 44 24 04          	mov    %eax,0x4(%esp)
80105798:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010579f:	e8 56 fd ff ff       	call   801054fa <argint>
801057a4:	85 c0                	test   %eax,%eax
801057a6:	78 1e                	js     801057c6 <sys_read+0x5a>
801057a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057ab:	89 44 24 08          	mov    %eax,0x8(%esp)
801057af:	8d 45 ec             	lea    -0x14(%ebp),%eax
801057b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801057b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801057bd:	e8 67 fd ff ff       	call   80105529 <argptr>
801057c2:	85 c0                	test   %eax,%eax
801057c4:	79 07                	jns    801057cd <sys_read+0x61>
    return -1;
801057c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057cb:	eb 19                	jmp    801057e6 <sys_read+0x7a>
  return fileread(f, p, n);
801057cd:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801057d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057d6:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801057da:	89 54 24 04          	mov    %edx,0x4(%esp)
801057de:	89 04 24             	mov    %eax,(%esp)
801057e1:	e8 0c b9 ff ff       	call   801010f2 <fileread>
}
801057e6:	c9                   	leave  
801057e7:	c3                   	ret    

801057e8 <sys_write>:

int
sys_write(void)
{
801057e8:	55                   	push   %ebp
801057e9:	89 e5                	mov    %esp,%ebp
801057eb:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801057ee:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057f1:	89 44 24 08          	mov    %eax,0x8(%esp)
801057f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801057fc:	00 
801057fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105804:	e8 4b fe ff ff       	call   80105654 <argfd>
80105809:	85 c0                	test   %eax,%eax
8010580b:	78 35                	js     80105842 <sys_write+0x5a>
8010580d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105810:	89 44 24 04          	mov    %eax,0x4(%esp)
80105814:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
8010581b:	e8 da fc ff ff       	call   801054fa <argint>
80105820:	85 c0                	test   %eax,%eax
80105822:	78 1e                	js     80105842 <sys_write+0x5a>
80105824:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105827:	89 44 24 08          	mov    %eax,0x8(%esp)
8010582b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010582e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105832:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105839:	e8 eb fc ff ff       	call   80105529 <argptr>
8010583e:	85 c0                	test   %eax,%eax
80105840:	79 07                	jns    80105849 <sys_write+0x61>
    return -1;
80105842:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105847:	eb 19                	jmp    80105862 <sys_write+0x7a>
  return filewrite(f, p, n);
80105849:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010584c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010584f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105852:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80105856:	89 54 24 04          	mov    %edx,0x4(%esp)
8010585a:	89 04 24             	mov    %eax,(%esp)
8010585d:	e8 4c b9 ff ff       	call   801011ae <filewrite>
}
80105862:	c9                   	leave  
80105863:	c3                   	ret    

80105864 <sys_close>:

int
sys_close(void)
{
80105864:	55                   	push   %ebp
80105865:	89 e5                	mov    %esp,%ebp
80105867:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
8010586a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010586d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105871:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105874:	89 44 24 04          	mov    %eax,0x4(%esp)
80105878:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010587f:	e8 d0 fd ff ff       	call   80105654 <argfd>
80105884:	85 c0                	test   %eax,%eax
80105886:	79 07                	jns    8010588f <sys_close+0x2b>
    return -1;
80105888:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010588d:	eb 24                	jmp    801058b3 <sys_close+0x4f>
  proc->ofile[fd] = 0;
8010588f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105895:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105898:	83 c2 08             	add    $0x8,%edx
8010589b:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801058a2:	00 
  fileclose(f);
801058a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058a6:	89 04 24             	mov    %eax,(%esp)
801058a9:	e8 1f b7 ff ff       	call   80100fcd <fileclose>
  return 0;
801058ae:	b8 00 00 00 00       	mov    $0x0,%eax
}
801058b3:	c9                   	leave  
801058b4:	c3                   	ret    

801058b5 <sys_fstat>:

int
sys_fstat(void)
{
801058b5:	55                   	push   %ebp
801058b6:	89 e5                	mov    %esp,%ebp
801058b8:	83 ec 28             	sub    $0x28,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801058bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058be:	89 44 24 08          	mov    %eax,0x8(%esp)
801058c2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801058c9:	00 
801058ca:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058d1:	e8 7e fd ff ff       	call   80105654 <argfd>
801058d6:	85 c0                	test   %eax,%eax
801058d8:	78 1f                	js     801058f9 <sys_fstat+0x44>
801058da:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058dd:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
801058e4:	00 
801058e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801058e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801058f0:	e8 34 fc ff ff       	call   80105529 <argptr>
801058f5:	85 c0                	test   %eax,%eax
801058f7:	79 07                	jns    80105900 <sys_fstat+0x4b>
    return -1;
801058f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058fe:	eb 12                	jmp    80105912 <sys_fstat+0x5d>
  return filestat(f, st);
80105900:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105903:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105906:	89 54 24 04          	mov    %edx,0x4(%esp)
8010590a:	89 04 24             	mov    %eax,(%esp)
8010590d:	e8 91 b7 ff ff       	call   801010a3 <filestat>
}
80105912:	c9                   	leave  
80105913:	c3                   	ret    

80105914 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80105914:	55                   	push   %ebp
80105915:	89 e5                	mov    %esp,%ebp
80105917:	83 ec 38             	sub    $0x38,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010591a:	8d 45 d8             	lea    -0x28(%ebp),%eax
8010591d:	89 44 24 04          	mov    %eax,0x4(%esp)
80105921:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105928:	e8 5e fc ff ff       	call   8010558b <argstr>
8010592d:	85 c0                	test   %eax,%eax
8010592f:	78 17                	js     80105948 <sys_link+0x34>
80105931:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105934:	89 44 24 04          	mov    %eax,0x4(%esp)
80105938:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010593f:	e8 47 fc ff ff       	call   8010558b <argstr>
80105944:	85 c0                	test   %eax,%eax
80105946:	79 0a                	jns    80105952 <sys_link+0x3e>
    return -1;
80105948:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010594d:	e9 3c 01 00 00       	jmp    80105a8e <sys_link+0x17a>
  if((ip = namei(old)) == 0)
80105952:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105955:	89 04 24             	mov    %eax,(%esp)
80105958:	e8 c6 ca ff ff       	call   80102423 <namei>
8010595d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105960:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105964:	75 0a                	jne    80105970 <sys_link+0x5c>
    return -1;
80105966:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010596b:	e9 1e 01 00 00       	jmp    80105a8e <sys_link+0x17a>

  begin_trans();
80105970:	e8 9d d8 ff ff       	call   80103212 <begin_trans>

  ilock(ip);
80105975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105978:	89 04 24             	mov    %eax,(%esp)
8010597b:	e8 fb be ff ff       	call   8010187b <ilock>
  if(ip->type == T_DIR){
80105980:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105983:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105987:	66 83 f8 01          	cmp    $0x1,%ax
8010598b:	75 1a                	jne    801059a7 <sys_link+0x93>
    iunlockput(ip);
8010598d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105990:	89 04 24             	mov    %eax,(%esp)
80105993:	e8 6a c1 ff ff       	call   80101b02 <iunlockput>
    commit_trans();
80105998:	e8 be d8 ff ff       	call   8010325b <commit_trans>
    return -1;
8010599d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059a2:	e9 e7 00 00 00       	jmp    80105a8e <sys_link+0x17a>
  }

  ip->nlink++;
801059a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059aa:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801059ae:	8d 50 01             	lea    0x1(%eax),%edx
801059b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059b4:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801059b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059bb:	89 04 24             	mov    %eax,(%esp)
801059be:	e8 f8 bc ff ff       	call   801016bb <iupdate>
  iunlock(ip);
801059c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059c6:	89 04 24             	mov    %eax,(%esp)
801059c9:	e8 fe bf ff ff       	call   801019cc <iunlock>

  if((dp = nameiparent(new, name)) == 0)
801059ce:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059d1:	8d 55 e2             	lea    -0x1e(%ebp),%edx
801059d4:	89 54 24 04          	mov    %edx,0x4(%esp)
801059d8:	89 04 24             	mov    %eax,(%esp)
801059db:	e8 65 ca ff ff       	call   80102445 <nameiparent>
801059e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059e7:	74 68                	je     80105a51 <sys_link+0x13d>
    goto bad;
  ilock(dp);
801059e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059ec:	89 04 24             	mov    %eax,(%esp)
801059ef:	e8 87 be ff ff       	call   8010187b <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801059f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059f7:	8b 10                	mov    (%eax),%edx
801059f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059fc:	8b 00                	mov    (%eax),%eax
801059fe:	39 c2                	cmp    %eax,%edx
80105a00:	75 20                	jne    80105a22 <sys_link+0x10e>
80105a02:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a05:	8b 40 04             	mov    0x4(%eax),%eax
80105a08:	89 44 24 08          	mov    %eax,0x8(%esp)
80105a0c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a13:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a16:	89 04 24             	mov    %eax,(%esp)
80105a19:	e8 44 c7 ff ff       	call   80102162 <dirlink>
80105a1e:	85 c0                	test   %eax,%eax
80105a20:	79 0d                	jns    80105a2f <sys_link+0x11b>
    iunlockput(dp);
80105a22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a25:	89 04 24             	mov    %eax,(%esp)
80105a28:	e8 d5 c0 ff ff       	call   80101b02 <iunlockput>
    goto bad;
80105a2d:	eb 23                	jmp    80105a52 <sys_link+0x13e>
  }
  iunlockput(dp);
80105a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a32:	89 04 24             	mov    %eax,(%esp)
80105a35:	e8 c8 c0 ff ff       	call   80101b02 <iunlockput>
  iput(ip);
80105a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a3d:	89 04 24             	mov    %eax,(%esp)
80105a40:	e8 ec bf ff ff       	call   80101a31 <iput>

  commit_trans();
80105a45:	e8 11 d8 ff ff       	call   8010325b <commit_trans>

  return 0;
80105a4a:	b8 00 00 00 00       	mov    $0x0,%eax
80105a4f:	eb 3d                	jmp    80105a8e <sys_link+0x17a>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105a51:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80105a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a55:	89 04 24             	mov    %eax,(%esp)
80105a58:	e8 1e be ff ff       	call   8010187b <ilock>
  ip->nlink--;
80105a5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a60:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a64:	8d 50 ff             	lea    -0x1(%eax),%edx
80105a67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a6a:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a71:	89 04 24             	mov    %eax,(%esp)
80105a74:	e8 42 bc ff ff       	call   801016bb <iupdate>
  iunlockput(ip);
80105a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a7c:	89 04 24             	mov    %eax,(%esp)
80105a7f:	e8 7e c0 ff ff       	call   80101b02 <iunlockput>
  commit_trans();
80105a84:	e8 d2 d7 ff ff       	call   8010325b <commit_trans>
  return -1;
80105a89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a8e:	c9                   	leave  
80105a8f:	c3                   	ret    

80105a90 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 38             	sub    $0x38,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a96:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80105a9d:	eb 4b                	jmp    80105aea <isdirempty+0x5a>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a9f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aa2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105aa5:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105aac:	00 
80105aad:	89 54 24 08          	mov    %edx,0x8(%esp)
80105ab1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ab5:	8b 45 08             	mov    0x8(%ebp),%eax
80105ab8:	89 04 24             	mov    %eax,(%esp)
80105abb:	e8 b4 c2 ff ff       	call   80101d74 <readi>
80105ac0:	83 f8 10             	cmp    $0x10,%eax
80105ac3:	74 0c                	je     80105ad1 <isdirempty+0x41>
      panic("isdirempty: readi");
80105ac5:	c7 04 24 17 8a 10 80 	movl   $0x80108a17,(%esp)
80105acc:	e8 69 aa ff ff       	call   8010053a <panic>
    if(de.inum != 0)
80105ad1:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105ad5:	66 85 c0             	test   %ax,%ax
80105ad8:	74 07                	je     80105ae1 <isdirempty+0x51>
      return 0;
80105ada:	b8 00 00 00 00       	mov    $0x0,%eax
80105adf:	eb 1b                	jmp    80105afc <isdirempty+0x6c>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae4:	83 c0 10             	add    $0x10,%eax
80105ae7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105aea:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105aed:	8b 45 08             	mov    0x8(%ebp),%eax
80105af0:	8b 40 18             	mov    0x18(%eax),%eax
80105af3:	39 c2                	cmp    %eax,%edx
80105af5:	72 a8                	jb     80105a9f <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105af7:	b8 01 00 00 00       	mov    $0x1,%eax
}
80105afc:	c9                   	leave  
80105afd:	c3                   	ret    

80105afe <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80105afe:	55                   	push   %ebp
80105aff:	89 e5                	mov    %esp,%ebp
80105b01:	83 ec 48             	sub    $0x48,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105b04:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105b07:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b0b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105b12:	e8 74 fa ff ff       	call   8010558b <argstr>
80105b17:	85 c0                	test   %eax,%eax
80105b19:	79 0a                	jns    80105b25 <sys_unlink+0x27>
    return -1;
80105b1b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b20:	e9 aa 01 00 00       	jmp    80105ccf <sys_unlink+0x1d1>
  if((dp = nameiparent(path, name)) == 0)
80105b25:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105b28:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80105b2b:	89 54 24 04          	mov    %edx,0x4(%esp)
80105b2f:	89 04 24             	mov    %eax,(%esp)
80105b32:	e8 0e c9 ff ff       	call   80102445 <nameiparent>
80105b37:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b3a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b3e:	75 0a                	jne    80105b4a <sys_unlink+0x4c>
    return -1;
80105b40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b45:	e9 85 01 00 00       	jmp    80105ccf <sys_unlink+0x1d1>

  begin_trans();
80105b4a:	e8 c3 d6 ff ff       	call   80103212 <begin_trans>

  ilock(dp);
80105b4f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b52:	89 04 24             	mov    %eax,(%esp)
80105b55:	e8 21 bd ff ff       	call   8010187b <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b5a:	c7 44 24 04 29 8a 10 	movl   $0x80108a29,0x4(%esp)
80105b61:	80 
80105b62:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b65:	89 04 24             	mov    %eax,(%esp)
80105b68:	e8 0b c5 ff ff       	call   80102078 <namecmp>
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	0f 84 45 01 00 00    	je     80105cba <sys_unlink+0x1bc>
80105b75:	c7 44 24 04 2b 8a 10 	movl   $0x80108a2b,0x4(%esp)
80105b7c:	80 
80105b7d:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b80:	89 04 24             	mov    %eax,(%esp)
80105b83:	e8 f0 c4 ff ff       	call   80102078 <namecmp>
80105b88:	85 c0                	test   %eax,%eax
80105b8a:	0f 84 2a 01 00 00    	je     80105cba <sys_unlink+0x1bc>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80105b90:	8d 45 c8             	lea    -0x38(%ebp),%eax
80105b93:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b97:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80105b9a:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ba1:	89 04 24             	mov    %eax,(%esp)
80105ba4:	e8 f1 c4 ff ff       	call   8010209a <dirlookup>
80105ba9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bac:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bb0:	0f 84 03 01 00 00    	je     80105cb9 <sys_unlink+0x1bb>
    goto bad;
  ilock(ip);
80105bb6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bb9:	89 04 24             	mov    %eax,(%esp)
80105bbc:	e8 ba bc ff ff       	call   8010187b <ilock>

  if(ip->nlink < 1)
80105bc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bc4:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105bc8:	66 85 c0             	test   %ax,%ax
80105bcb:	7f 0c                	jg     80105bd9 <sys_unlink+0xdb>
    panic("unlink: nlink < 1");
80105bcd:	c7 04 24 2e 8a 10 80 	movl   $0x80108a2e,(%esp)
80105bd4:	e8 61 a9 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105bd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bdc:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105be0:	66 83 f8 01          	cmp    $0x1,%ax
80105be4:	75 1f                	jne    80105c05 <sys_unlink+0x107>
80105be6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105be9:	89 04 24             	mov    %eax,(%esp)
80105bec:	e8 9f fe ff ff       	call   80105a90 <isdirempty>
80105bf1:	85 c0                	test   %eax,%eax
80105bf3:	75 10                	jne    80105c05 <sys_unlink+0x107>
    iunlockput(ip);
80105bf5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105bf8:	89 04 24             	mov    %eax,(%esp)
80105bfb:	e8 02 bf ff ff       	call   80101b02 <iunlockput>
    goto bad;
80105c00:	e9 b5 00 00 00       	jmp    80105cba <sys_unlink+0x1bc>
  }

  memset(&de, 0, sizeof(de));
80105c05:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80105c0c:	00 
80105c0d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105c14:	00 
80105c15:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c18:	89 04 24             	mov    %eax,(%esp)
80105c1b:	e8 7e f5 ff ff       	call   8010519e <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c20:	8b 55 c8             	mov    -0x38(%ebp),%edx
80105c23:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c26:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105c2d:	00 
80105c2e:	89 54 24 08          	mov    %edx,0x8(%esp)
80105c32:	89 44 24 04          	mov    %eax,0x4(%esp)
80105c36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c39:	89 04 24             	mov    %eax,(%esp)
80105c3c:	e8 9f c2 ff ff       	call   80101ee0 <writei>
80105c41:	83 f8 10             	cmp    $0x10,%eax
80105c44:	74 0c                	je     80105c52 <sys_unlink+0x154>
    panic("unlink: writei");
80105c46:	c7 04 24 40 8a 10 80 	movl   $0x80108a40,(%esp)
80105c4d:	e8 e8 a8 ff ff       	call   8010053a <panic>
  if(ip->type == T_DIR){
80105c52:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c55:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105c59:	66 83 f8 01          	cmp    $0x1,%ax
80105c5d:	75 1c                	jne    80105c7b <sys_unlink+0x17d>
    dp->nlink--;
80105c5f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c62:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c66:	8d 50 ff             	lea    -0x1(%eax),%edx
80105c69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c6c:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105c70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c73:	89 04 24             	mov    %eax,(%esp)
80105c76:	e8 40 ba ff ff       	call   801016bb <iupdate>
  }
  iunlockput(dp);
80105c7b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c7e:	89 04 24             	mov    %eax,(%esp)
80105c81:	e8 7c be ff ff       	call   80101b02 <iunlockput>

  ip->nlink--;
80105c86:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c89:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105c8d:	8d 50 ff             	lea    -0x1(%eax),%edx
80105c90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c93:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
80105c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c9a:	89 04 24             	mov    %eax,(%esp)
80105c9d:	e8 19 ba ff ff       	call   801016bb <iupdate>
  iunlockput(ip);
80105ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ca5:	89 04 24             	mov    %eax,(%esp)
80105ca8:	e8 55 be ff ff       	call   80101b02 <iunlockput>

  commit_trans();
80105cad:	e8 a9 d5 ff ff       	call   8010325b <commit_trans>

  return 0;
80105cb2:	b8 00 00 00 00       	mov    $0x0,%eax
80105cb7:	eb 16                	jmp    80105ccf <sys_unlink+0x1d1>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105cb9:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105cba:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cbd:	89 04 24             	mov    %eax,(%esp)
80105cc0:	e8 3d be ff ff       	call   80101b02 <iunlockput>
  commit_trans();
80105cc5:	e8 91 d5 ff ff       	call   8010325b <commit_trans>
  return -1;
80105cca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ccf:	c9                   	leave  
80105cd0:	c3                   	ret    

80105cd1 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80105cd1:	55                   	push   %ebp
80105cd2:	89 e5                	mov    %esp,%ebp
80105cd4:	83 ec 48             	sub    $0x48,%esp
80105cd7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105cda:	8b 55 10             	mov    0x10(%ebp),%edx
80105cdd:	8b 45 14             	mov    0x14(%ebp),%eax
80105ce0:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80105ce4:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105ce8:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105cec:	8d 45 de             	lea    -0x22(%ebp),%eax
80105cef:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cf3:	8b 45 08             	mov    0x8(%ebp),%eax
80105cf6:	89 04 24             	mov    %eax,(%esp)
80105cf9:	e8 47 c7 ff ff       	call   80102445 <nameiparent>
80105cfe:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d01:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d05:	75 0a                	jne    80105d11 <create+0x40>
    return 0;
80105d07:	b8 00 00 00 00       	mov    $0x0,%eax
80105d0c:	e9 7e 01 00 00       	jmp    80105e8f <create+0x1be>
  ilock(dp);
80105d11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d14:	89 04 24             	mov    %eax,(%esp)
80105d17:	e8 5f bb ff ff       	call   8010187b <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80105d1c:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105d1f:	89 44 24 08          	mov    %eax,0x8(%esp)
80105d23:	8d 45 de             	lea    -0x22(%ebp),%eax
80105d26:	89 44 24 04          	mov    %eax,0x4(%esp)
80105d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d2d:	89 04 24             	mov    %eax,(%esp)
80105d30:	e8 65 c3 ff ff       	call   8010209a <dirlookup>
80105d35:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d38:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d3c:	74 47                	je     80105d85 <create+0xb4>
    iunlockput(dp);
80105d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d41:	89 04 24             	mov    %eax,(%esp)
80105d44:	e8 b9 bd ff ff       	call   80101b02 <iunlockput>
    ilock(ip);
80105d49:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d4c:	89 04 24             	mov    %eax,(%esp)
80105d4f:	e8 27 bb ff ff       	call   8010187b <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105d54:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105d59:	75 15                	jne    80105d70 <create+0x9f>
80105d5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d5e:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105d62:	66 83 f8 02          	cmp    $0x2,%ax
80105d66:	75 08                	jne    80105d70 <create+0x9f>
      return ip;
80105d68:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d6b:	e9 1f 01 00 00       	jmp    80105e8f <create+0x1be>
    iunlockput(ip);
80105d70:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d73:	89 04 24             	mov    %eax,(%esp)
80105d76:	e8 87 bd ff ff       	call   80101b02 <iunlockput>
    return 0;
80105d7b:	b8 00 00 00 00       	mov    $0x0,%eax
80105d80:	e9 0a 01 00 00       	jmp    80105e8f <create+0x1be>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80105d85:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80105d89:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d8c:	8b 00                	mov    (%eax),%eax
80105d8e:	89 54 24 04          	mov    %edx,0x4(%esp)
80105d92:	89 04 24             	mov    %eax,(%esp)
80105d95:	e8 44 b8 ff ff       	call   801015de <ialloc>
80105d9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d9d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105da1:	75 0c                	jne    80105daf <create+0xde>
    panic("create: ialloc");
80105da3:	c7 04 24 4f 8a 10 80 	movl   $0x80108a4f,(%esp)
80105daa:	e8 8b a7 ff ff       	call   8010053a <panic>

  ilock(ip);
80105daf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105db2:	89 04 24             	mov    %eax,(%esp)
80105db5:	e8 c1 ba ff ff       	call   8010187b <ilock>
  ip->major = major;
80105dba:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dbd:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105dc1:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105dc5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dc8:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105dcc:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105dd0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105dd3:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105dd9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ddc:	89 04 24             	mov    %eax,(%esp)
80105ddf:	e8 d7 b8 ff ff       	call   801016bb <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80105de4:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105de9:	75 6a                	jne    80105e55 <create+0x184>
    dp->nlink++;  // for ".."
80105deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dee:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105df2:	8d 50 01             	lea    0x1(%eax),%edx
80105df5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df8:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105dfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dff:	89 04 24             	mov    %eax,(%esp)
80105e02:	e8 b4 b8 ff ff       	call   801016bb <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105e07:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e0a:	8b 40 04             	mov    0x4(%eax),%eax
80105e0d:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e11:	c7 44 24 04 29 8a 10 	movl   $0x80108a29,0x4(%esp)
80105e18:	80 
80105e19:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e1c:	89 04 24             	mov    %eax,(%esp)
80105e1f:	e8 3e c3 ff ff       	call   80102162 <dirlink>
80105e24:	85 c0                	test   %eax,%eax
80105e26:	78 21                	js     80105e49 <create+0x178>
80105e28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e2b:	8b 40 04             	mov    0x4(%eax),%eax
80105e2e:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e32:	c7 44 24 04 2b 8a 10 	movl   $0x80108a2b,0x4(%esp)
80105e39:	80 
80105e3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e3d:	89 04 24             	mov    %eax,(%esp)
80105e40:	e8 1d c3 ff ff       	call   80102162 <dirlink>
80105e45:	85 c0                	test   %eax,%eax
80105e47:	79 0c                	jns    80105e55 <create+0x184>
      panic("create dots");
80105e49:	c7 04 24 5e 8a 10 80 	movl   $0x80108a5e,(%esp)
80105e50:	e8 e5 a6 ff ff       	call   8010053a <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105e55:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105e58:	8b 40 04             	mov    0x4(%eax),%eax
80105e5b:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e5f:	8d 45 de             	lea    -0x22(%ebp),%eax
80105e62:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e66:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e69:	89 04 24             	mov    %eax,(%esp)
80105e6c:	e8 f1 c2 ff ff       	call   80102162 <dirlink>
80105e71:	85 c0                	test   %eax,%eax
80105e73:	79 0c                	jns    80105e81 <create+0x1b0>
    panic("create: dirlink");
80105e75:	c7 04 24 6a 8a 10 80 	movl   $0x80108a6a,(%esp)
80105e7c:	e8 b9 a6 ff ff       	call   8010053a <panic>

  iunlockput(dp);
80105e81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e84:	89 04 24             	mov    %eax,(%esp)
80105e87:	e8 76 bc ff ff       	call   80101b02 <iunlockput>

  return ip;
80105e8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105e8f:	c9                   	leave  
80105e90:	c3                   	ret    

80105e91 <sys_open>:

int
sys_open(void)
{
80105e91:	55                   	push   %ebp
80105e92:	89 e5                	mov    %esp,%ebp
80105e94:	83 ec 38             	sub    $0x38,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105e97:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105e9a:	89 44 24 04          	mov    %eax,0x4(%esp)
80105e9e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105ea5:	e8 e1 f6 ff ff       	call   8010558b <argstr>
80105eaa:	85 c0                	test   %eax,%eax
80105eac:	78 17                	js     80105ec5 <sys_open+0x34>
80105eae:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105eb1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105eb5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105ebc:	e8 39 f6 ff ff       	call   801054fa <argint>
80105ec1:	85 c0                	test   %eax,%eax
80105ec3:	79 0a                	jns    80105ecf <sys_open+0x3e>
    return -1;
80105ec5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eca:	e9 46 01 00 00       	jmp    80106015 <sys_open+0x184>
  if(omode & O_CREATE){
80105ecf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ed2:	25 00 02 00 00       	and    $0x200,%eax
80105ed7:	85 c0                	test   %eax,%eax
80105ed9:	74 40                	je     80105f1b <sys_open+0x8a>
    begin_trans();
80105edb:	e8 32 d3 ff ff       	call   80103212 <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105ee0:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105ee3:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80105eea:	00 
80105eeb:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80105ef2:	00 
80105ef3:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
80105efa:	00 
80105efb:	89 04 24             	mov    %eax,(%esp)
80105efe:	e8 ce fd ff ff       	call   80105cd1 <create>
80105f03:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105f06:	e8 50 d3 ff ff       	call   8010325b <commit_trans>
    if(ip == 0)
80105f0b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f0f:	75 5c                	jne    80105f6d <sys_open+0xdc>
      return -1;
80105f11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f16:	e9 fa 00 00 00       	jmp    80106015 <sys_open+0x184>
  } else {
    if((ip = namei(path)) == 0)
80105f1b:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f1e:	89 04 24             	mov    %eax,(%esp)
80105f21:	e8 fd c4 ff ff       	call   80102423 <namei>
80105f26:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f29:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f2d:	75 0a                	jne    80105f39 <sys_open+0xa8>
      return -1;
80105f2f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f34:	e9 dc 00 00 00       	jmp    80106015 <sys_open+0x184>
    ilock(ip);
80105f39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f3c:	89 04 24             	mov    %eax,(%esp)
80105f3f:	e8 37 b9 ff ff       	call   8010187b <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105f44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f47:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105f4b:	66 83 f8 01          	cmp    $0x1,%ax
80105f4f:	75 1c                	jne    80105f6d <sys_open+0xdc>
80105f51:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f54:	85 c0                	test   %eax,%eax
80105f56:	74 15                	je     80105f6d <sys_open+0xdc>
      iunlockput(ip);
80105f58:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105f5b:	89 04 24             	mov    %eax,(%esp)
80105f5e:	e8 9f bb ff ff       	call   80101b02 <iunlockput>
      return -1;
80105f63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f68:	e9 a8 00 00 00       	jmp    80106015 <sys_open+0x184>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105f6d:	e8 b2 af ff ff       	call   80100f24 <filealloc>
80105f72:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f75:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f79:	74 14                	je     80105f8f <sys_open+0xfe>
80105f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f7e:	89 04 24             	mov    %eax,(%esp)
80105f81:	e8 43 f7 ff ff       	call   801056c9 <fdalloc>
80105f86:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105f89:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105f8d:	79 23                	jns    80105fb2 <sys_open+0x121>
    if(f)
80105f8f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f93:	74 0b                	je     80105fa0 <sys_open+0x10f>
      fileclose(f);
80105f95:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105f98:	89 04 24             	mov    %eax,(%esp)
80105f9b:	e8 2d b0 ff ff       	call   80100fcd <fileclose>
    iunlockput(ip);
80105fa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fa3:	89 04 24             	mov    %eax,(%esp)
80105fa6:	e8 57 bb ff ff       	call   80101b02 <iunlockput>
    return -1;
80105fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fb0:	eb 63                	jmp    80106015 <sys_open+0x184>
  }
  iunlock(ip);
80105fb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105fb5:	89 04 24             	mov    %eax,(%esp)
80105fb8:	e8 0f ba ff ff       	call   801019cc <iunlock>

  f->type = FD_INODE;
80105fbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fc0:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105fc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fc9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105fcc:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105fcf:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fd2:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105fd9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fdc:	83 e0 01             	and    $0x1,%eax
80105fdf:	85 c0                	test   %eax,%eax
80105fe1:	0f 94 c2             	sete   %dl
80105fe4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe7:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105fea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fed:	83 e0 01             	and    $0x1,%eax
80105ff0:	84 c0                	test   %al,%al
80105ff2:	75 0a                	jne    80105ffe <sys_open+0x16d>
80105ff4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ff7:	83 e0 02             	and    $0x2,%eax
80105ffa:	85 c0                	test   %eax,%eax
80105ffc:	74 07                	je     80106005 <sys_open+0x174>
80105ffe:	b8 01 00 00 00       	mov    $0x1,%eax
80106003:	eb 05                	jmp    8010600a <sys_open+0x179>
80106005:	b8 00 00 00 00       	mov    $0x0,%eax
8010600a:	89 c2                	mov    %eax,%edx
8010600c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010600f:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80106012:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80106015:	c9                   	leave  
80106016:	c3                   	ret    

80106017 <sys_mkdir>:

int
sys_mkdir(void)
{
80106017:	55                   	push   %ebp
80106018:	89 e5                	mov    %esp,%ebp
8010601a:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_trans();
8010601d:	e8 f0 d1 ff ff       	call   80103212 <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80106022:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106025:	89 44 24 04          	mov    %eax,0x4(%esp)
80106029:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106030:	e8 56 f5 ff ff       	call   8010558b <argstr>
80106035:	85 c0                	test   %eax,%eax
80106037:	78 2c                	js     80106065 <sys_mkdir+0x4e>
80106039:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010603c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
80106043:	00 
80106044:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010604b:	00 
8010604c:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106053:	00 
80106054:	89 04 24             	mov    %eax,(%esp)
80106057:	e8 75 fc ff ff       	call   80105cd1 <create>
8010605c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010605f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106063:	75 0c                	jne    80106071 <sys_mkdir+0x5a>
    commit_trans();
80106065:	e8 f1 d1 ff ff       	call   8010325b <commit_trans>
    return -1;
8010606a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010606f:	eb 15                	jmp    80106086 <sys_mkdir+0x6f>
  }
  iunlockput(ip);
80106071:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106074:	89 04 24             	mov    %eax,(%esp)
80106077:	e8 86 ba ff ff       	call   80101b02 <iunlockput>
  commit_trans();
8010607c:	e8 da d1 ff ff       	call   8010325b <commit_trans>
  return 0;
80106081:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106086:	c9                   	leave  
80106087:	c3                   	ret    

80106088 <sys_mknod>:

int
sys_mknod(void)
{
80106088:	55                   	push   %ebp
80106089:	89 e5                	mov    %esp,%ebp
8010608b:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
8010608e:	e8 7f d1 ff ff       	call   80103212 <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80106093:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106096:	89 44 24 04          	mov    %eax,0x4(%esp)
8010609a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801060a1:	e8 e5 f4 ff ff       	call   8010558b <argstr>
801060a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801060a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801060ad:	78 5e                	js     8010610d <sys_mknod+0x85>
     argint(1, &major) < 0 ||
801060af:	8d 45 e8             	lea    -0x18(%ebp),%eax
801060b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801060b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801060bd:	e8 38 f4 ff ff       	call   801054fa <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
801060c2:	85 c0                	test   %eax,%eax
801060c4:	78 47                	js     8010610d <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801060c6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801060c9:	89 44 24 04          	mov    %eax,0x4(%esp)
801060cd:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801060d4:	e8 21 f4 ff ff       	call   801054fa <argint>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
801060d9:	85 c0                	test   %eax,%eax
801060db:	78 30                	js     8010610d <sys_mknod+0x85>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
801060dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801060e0:	0f bf c8             	movswl %ax,%ecx
801060e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
801060e6:	0f bf d0             	movswl %ax,%edx
801060e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801060ec:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
801060f0:	89 54 24 08          	mov    %edx,0x8(%esp)
801060f4:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
801060fb:	00 
801060fc:	89 04 24             	mov    %eax,(%esp)
801060ff:	e8 cd fb ff ff       	call   80105cd1 <create>
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80106104:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106107:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010610b:	75 0c                	jne    80106119 <sys_mknod+0x91>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
8010610d:	e8 49 d1 ff ff       	call   8010325b <commit_trans>
    return -1;
80106112:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106117:	eb 15                	jmp    8010612e <sys_mknod+0xa6>
  }
  iunlockput(ip);
80106119:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010611c:	89 04 24             	mov    %eax,(%esp)
8010611f:	e8 de b9 ff ff       	call   80101b02 <iunlockput>
  commit_trans();
80106124:	e8 32 d1 ff ff       	call   8010325b <commit_trans>
  return 0;
80106129:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010612e:	c9                   	leave  
8010612f:	c3                   	ret    

80106130 <sys_chdir>:

int
sys_chdir(void)
{
80106130:	55                   	push   %ebp
80106131:	89 e5                	mov    %esp,%ebp
80106133:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80106136:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106139:	89 44 24 04          	mov    %eax,0x4(%esp)
8010613d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106144:	e8 42 f4 ff ff       	call   8010558b <argstr>
80106149:	85 c0                	test   %eax,%eax
8010614b:	78 14                	js     80106161 <sys_chdir+0x31>
8010614d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106150:	89 04 24             	mov    %eax,(%esp)
80106153:	e8 cb c2 ff ff       	call   80102423 <namei>
80106158:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010615b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010615f:	75 07                	jne    80106168 <sys_chdir+0x38>
    return -1;
80106161:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106166:	eb 57                	jmp    801061bf <sys_chdir+0x8f>
  ilock(ip);
80106168:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010616b:	89 04 24             	mov    %eax,(%esp)
8010616e:	e8 08 b7 ff ff       	call   8010187b <ilock>
  if(ip->type != T_DIR){
80106173:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106176:	0f b7 40 10          	movzwl 0x10(%eax),%eax
8010617a:	66 83 f8 01          	cmp    $0x1,%ax
8010617e:	74 12                	je     80106192 <sys_chdir+0x62>
    iunlockput(ip);
80106180:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106183:	89 04 24             	mov    %eax,(%esp)
80106186:	e8 77 b9 ff ff       	call   80101b02 <iunlockput>
    return -1;
8010618b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106190:	eb 2d                	jmp    801061bf <sys_chdir+0x8f>
  }
  iunlock(ip);
80106192:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106195:	89 04 24             	mov    %eax,(%esp)
80106198:	e8 2f b8 ff ff       	call   801019cc <iunlock>
  iput(proc->cwd);
8010619d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061a3:	8b 40 68             	mov    0x68(%eax),%eax
801061a6:	89 04 24             	mov    %eax,(%esp)
801061a9:	e8 83 b8 ff ff       	call   80101a31 <iput>
  proc->cwd = ip;
801061ae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801061b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061b7:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801061ba:	b8 00 00 00 00       	mov    $0x0,%eax
}
801061bf:	c9                   	leave  
801061c0:	c3                   	ret    

801061c1 <sys_exec>:

int
sys_exec(void)
{
801061c1:	55                   	push   %ebp
801061c2:	89 e5                	mov    %esp,%ebp
801061c4:	81 ec a8 00 00 00    	sub    $0xa8,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801061ca:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061cd:	89 44 24 04          	mov    %eax,0x4(%esp)
801061d1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801061d8:	e8 ae f3 ff ff       	call   8010558b <argstr>
801061dd:	85 c0                	test   %eax,%eax
801061df:	78 1a                	js     801061fb <sys_exec+0x3a>
801061e1:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801061e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801061eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801061f2:	e8 03 f3 ff ff       	call   801054fa <argint>
801061f7:	85 c0                	test   %eax,%eax
801061f9:	79 0a                	jns    80106205 <sys_exec+0x44>
    return -1;
801061fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106200:	e9 cd 00 00 00       	jmp    801062d2 <sys_exec+0x111>
  }
  memset(argv, 0, sizeof(argv));
80106205:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
8010620c:	00 
8010620d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106214:	00 
80106215:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010621b:	89 04 24             	mov    %eax,(%esp)
8010621e:	e8 7b ef ff ff       	call   8010519e <memset>
  for(i=0;; i++){
80106223:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010622a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010622d:	83 f8 1f             	cmp    $0x1f,%eax
80106230:	76 0a                	jbe    8010623c <sys_exec+0x7b>
      return -1;
80106232:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106237:	e9 96 00 00 00       	jmp    801062d2 <sys_exec+0x111>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010623c:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80106242:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106245:	c1 e2 02             	shl    $0x2,%edx
80106248:	89 d1                	mov    %edx,%ecx
8010624a:	8b 95 6c ff ff ff    	mov    -0x94(%ebp),%edx
80106250:	8d 14 11             	lea    (%ecx,%edx,1),%edx
80106253:	89 44 24 04          	mov    %eax,0x4(%esp)
80106257:	89 14 24             	mov    %edx,(%esp)
8010625a:	e8 fd f1 ff ff       	call   8010545c <fetchint>
8010625f:	85 c0                	test   %eax,%eax
80106261:	79 07                	jns    8010626a <sys_exec+0xa9>
      return -1;
80106263:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106268:	eb 68                	jmp    801062d2 <sys_exec+0x111>
    if(uarg == 0){
8010626a:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80106270:	85 c0                	test   %eax,%eax
80106272:	75 26                	jne    8010629a <sys_exec+0xd9>
      argv[i] = 0;
80106274:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106277:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
8010627e:	00 00 00 00 
      break;
80106282:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80106283:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106286:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
8010628c:	89 54 24 04          	mov    %edx,0x4(%esp)
80106290:	89 04 24             	mov    %eax,(%esp)
80106293:	e8 60 a8 ff ff       	call   80100af8 <exec>
80106298:	eb 38                	jmp    801062d2 <sys_exec+0x111>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010629a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010629d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801062a4:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
801062aa:	01 d0                	add    %edx,%eax
801062ac:	8b 95 68 ff ff ff    	mov    -0x98(%ebp),%edx
801062b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801062b6:	89 14 24             	mov    %edx,(%esp)
801062b9:	e8 d8 f1 ff ff       	call   80105496 <fetchstr>
801062be:	85 c0                	test   %eax,%eax
801062c0:	79 07                	jns    801062c9 <sys_exec+0x108>
      return -1;
801062c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c7:	eb 09                	jmp    801062d2 <sys_exec+0x111>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
801062c9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
801062cd:	e9 58 ff ff ff       	jmp    8010622a <sys_exec+0x69>
  return exec(path, argv);
}
801062d2:	c9                   	leave  
801062d3:	c3                   	ret    

801062d4 <sys_pipe>:

int
sys_pipe(void)
{
801062d4:	55                   	push   %ebp
801062d5:	89 e5                	mov    %esp,%ebp
801062d7:	83 ec 38             	sub    $0x38,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801062da:	8d 45 ec             	lea    -0x14(%ebp),%eax
801062dd:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
801062e4:	00 
801062e5:	89 44 24 04          	mov    %eax,0x4(%esp)
801062e9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801062f0:	e8 34 f2 ff ff       	call   80105529 <argptr>
801062f5:	85 c0                	test   %eax,%eax
801062f7:	79 0a                	jns    80106303 <sys_pipe+0x2f>
    return -1;
801062f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062fe:	e9 9b 00 00 00       	jmp    8010639e <sys_pipe+0xca>
  if(pipealloc(&rf, &wf) < 0)
80106303:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106306:	89 44 24 04          	mov    %eax,0x4(%esp)
8010630a:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010630d:	89 04 24             	mov    %eax,(%esp)
80106310:	e8 ef d8 ff ff       	call   80103c04 <pipealloc>
80106315:	85 c0                	test   %eax,%eax
80106317:	79 07                	jns    80106320 <sys_pipe+0x4c>
    return -1;
80106319:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010631e:	eb 7e                	jmp    8010639e <sys_pipe+0xca>
  fd0 = -1;
80106320:	c7 45 f0 ff ff ff ff 	movl   $0xffffffff,-0x10(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106327:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010632a:	89 04 24             	mov    %eax,(%esp)
8010632d:	e8 97 f3 ff ff       	call   801056c9 <fdalloc>
80106332:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106335:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106339:	78 14                	js     8010634f <sys_pipe+0x7b>
8010633b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010633e:	89 04 24             	mov    %eax,(%esp)
80106341:	e8 83 f3 ff ff       	call   801056c9 <fdalloc>
80106346:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106349:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010634d:	79 37                	jns    80106386 <sys_pipe+0xb2>
    if(fd0 >= 0)
8010634f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106353:	78 14                	js     80106369 <sys_pipe+0x95>
      proc->ofile[fd0] = 0;
80106355:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010635b:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010635e:	83 c2 08             	add    $0x8,%edx
80106361:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80106368:	00 
    fileclose(rf);
80106369:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010636c:	89 04 24             	mov    %eax,(%esp)
8010636f:	e8 59 ac ff ff       	call   80100fcd <fileclose>
    fileclose(wf);
80106374:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106377:	89 04 24             	mov    %eax,(%esp)
8010637a:	e8 4e ac ff ff       	call   80100fcd <fileclose>
    return -1;
8010637f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106384:	eb 18                	jmp    8010639e <sys_pipe+0xca>
  }
  fd[0] = fd0;
80106386:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106389:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010638c:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
8010638e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80106391:	8d 50 04             	lea    0x4(%eax),%edx
80106394:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106397:	89 02                	mov    %eax,(%edx)
  return 0;
80106399:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010639e:	c9                   	leave  
8010639f:	c3                   	ret    

801063a0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	83 ec 08             	sub    $0x8,%esp
  return fork();
801063a6:	e8 92 df ff ff       	call   8010433d <fork>
}
801063ab:	c9                   	leave  
801063ac:	c3                   	ret    

801063ad <sys_clone>:

int
sys_clone(){
801063ad:	55                   	push   %ebp
801063ae:	89 e5                	mov    %esp,%ebp
801063b0:	53                   	push   %ebx
801063b1:	83 ec 24             	sub    $0x24,%esp
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
801063b4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801063bb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801063c2:	e8 33 f1 ff ff       	call   801054fa <argint>
801063c7:	85 c0                	test   %eax,%eax
801063c9:	78 4c                	js     80106417 <sys_clone+0x6a>
801063cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801063ce:	85 c0                	test   %eax,%eax
801063d0:	7e 45                	jle    80106417 <sys_clone+0x6a>
801063d2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063d5:	89 44 24 04          	mov    %eax,0x4(%esp)
801063d9:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801063e0:	e8 15 f1 ff ff       	call   801054fa <argint>
801063e5:	85 c0                	test   %eax,%eax
801063e7:	78 2e                	js     80106417 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
801063e9:	8d 45 ec             	lea    -0x14(%ebp),%eax
801063ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801063f0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801063f7:	e8 fe f0 ff ff       	call   801054fa <argint>
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
801063fc:	85 c0                	test   %eax,%eax
801063fe:	78 17                	js     80106417 <sys_clone+0x6a>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
80106400:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106403:	89 44 24 04          	mov    %eax,0x4(%esp)
80106407:	c7 04 24 03 00 00 00 	movl   $0x3,(%esp)
8010640e:	e8 e7 f0 ff ff       	call   801054fa <argint>
    int stack;
    int size;
    int routine;
    int arg;

    if(argint(1,&size) < 0 || size <=0 || argint(0,&stack) <0 ||
80106413:	85 c0                	test   %eax,%eax
80106415:	79 07                	jns    8010641e <sys_clone+0x71>
            argint(2,&routine) < 0 || argint(3,&arg)<0){
        return -1;
80106417:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010641c:	eb 20                	jmp    8010643e <sys_clone+0x91>
    }
    return clone(stack,size,routine,arg);
8010641e:	8b 5d e8             	mov    -0x18(%ebp),%ebx
80106421:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80106424:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106427:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010642a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010642e:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106432:	89 54 24 04          	mov    %edx,0x4(%esp)
80106436:	89 04 24             	mov    %eax,(%esp)
80106439:	e8 6f e0 ff ff       	call   801044ad <clone>
}
8010643e:	83 c4 24             	add    $0x24,%esp
80106441:	5b                   	pop    %ebx
80106442:	5d                   	pop    %ebp
80106443:	c3                   	ret    

80106444 <sys_exit>:

int
sys_exit(void)
{
80106444:	55                   	push   %ebp
80106445:	89 e5                	mov    %esp,%ebp
80106447:	83 ec 08             	sub    $0x8,%esp
  exit();
8010644a:	e8 81 e2 ff ff       	call   801046d0 <exit>
  return 0;  // not reached
8010644f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106454:	c9                   	leave  
80106455:	c3                   	ret    

80106456 <sys_texit>:

int
sys_texit(void)
{
80106456:	55                   	push   %ebp
80106457:	89 e5                	mov    %esp,%ebp
80106459:	83 ec 08             	sub    $0x8,%esp
    texit();
8010645c:	e8 8b e3 ff ff       	call   801047ec <texit>
    return 0;
80106461:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106466:	c9                   	leave  
80106467:	c3                   	ret    

80106468 <sys_wait>:

int
sys_wait(void)
{
80106468:	55                   	push   %ebp
80106469:	89 e5                	mov    %esp,%ebp
8010646b:	83 ec 08             	sub    $0x8,%esp
  return wait();
8010646e:	e8 47 e4 ff ff       	call   801048ba <wait>
}
80106473:	c9                   	leave  
80106474:	c3                   	ret    

80106475 <sys_kill>:

int
sys_kill(void)
{
80106475:	55                   	push   %ebp
80106476:	89 e5                	mov    %esp,%ebp
80106478:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010647b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010647e:	89 44 24 04          	mov    %eax,0x4(%esp)
80106482:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106489:	e8 6c f0 ff ff       	call   801054fa <argint>
8010648e:	85 c0                	test   %eax,%eax
80106490:	79 07                	jns    80106499 <sys_kill+0x24>
    return -1;
80106492:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106497:	eb 0b                	jmp    801064a4 <sys_kill+0x2f>
  return kill(pid);
80106499:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010649c:	89 04 24             	mov    %eax,(%esp)
8010649f:	e8 a3 e8 ff ff       	call   80104d47 <kill>
}
801064a4:	c9                   	leave  
801064a5:	c3                   	ret    

801064a6 <sys_getpid>:

int
sys_getpid(void)
{
801064a6:	55                   	push   %ebp
801064a7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801064a9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064af:	8b 40 10             	mov    0x10(%eax),%eax
}
801064b2:	5d                   	pop    %ebp
801064b3:	c3                   	ret    

801064b4 <sys_sbrk>:

int
sys_sbrk(void)
{
801064b4:	55                   	push   %ebp
801064b5:	89 e5                	mov    %esp,%ebp
801064b7:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801064ba:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064bd:	89 44 24 04          	mov    %eax,0x4(%esp)
801064c1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801064c8:	e8 2d f0 ff ff       	call   801054fa <argint>
801064cd:	85 c0                	test   %eax,%eax
801064cf:	79 07                	jns    801064d8 <sys_sbrk+0x24>
    return -1;
801064d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064d6:	eb 24                	jmp    801064fc <sys_sbrk+0x48>
  addr = proc->sz;
801064d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064de:	8b 00                	mov    (%eax),%eax
801064e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
801064e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801064e6:	89 04 24             	mov    %eax,(%esp)
801064e9:	e8 aa dd ff ff       	call   80104298 <growproc>
801064ee:	85 c0                	test   %eax,%eax
801064f0:	79 07                	jns    801064f9 <sys_sbrk+0x45>
    return -1;
801064f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064f7:	eb 03                	jmp    801064fc <sys_sbrk+0x48>
  return addr;
801064f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801064fc:	c9                   	leave  
801064fd:	c3                   	ret    

801064fe <sys_sleep>:

int
sys_sleep(void)
{
801064fe:	55                   	push   %ebp
801064ff:	89 e5                	mov    %esp,%ebp
80106501:	83 ec 28             	sub    $0x28,%esp
  int n;
  uint ticks0;
  
  if(argint(0, &n) < 0)
80106504:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106507:	89 44 24 04          	mov    %eax,0x4(%esp)
8010650b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80106512:	e8 e3 ef ff ff       	call   801054fa <argint>
80106517:	85 c0                	test   %eax,%eax
80106519:	79 07                	jns    80106522 <sys_sleep+0x24>
    return -1;
8010651b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106520:	eb 6c                	jmp    8010658e <sys_sleep+0x90>
  acquire(&tickslock);
80106522:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
80106529:	e8 21 ea ff ff       	call   80104f4f <acquire>
  ticks0 = ticks;
8010652e:	a1 c0 28 11 80       	mov    0x801128c0,%eax
80106533:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
80106536:	eb 34                	jmp    8010656c <sys_sleep+0x6e>
    if(proc->killed){
80106538:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010653e:	8b 40 24             	mov    0x24(%eax),%eax
80106541:	85 c0                	test   %eax,%eax
80106543:	74 13                	je     80106558 <sys_sleep+0x5a>
      release(&tickslock);
80106545:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
8010654c:	e8 5f ea ff ff       	call   80104fb0 <release>
      return -1;
80106551:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106556:	eb 36                	jmp    8010658e <sys_sleep+0x90>
    }
    sleep(&ticks, &tickslock);
80106558:	c7 44 24 04 80 20 11 	movl   $0x80112080,0x4(%esp)
8010655f:	80 
80106560:	c7 04 24 c0 28 11 80 	movl   $0x801128c0,(%esp)
80106567:	e8 6a e6 ff ff       	call   80104bd6 <sleep>
  
  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010656c:	a1 c0 28 11 80       	mov    0x801128c0,%eax
80106571:	89 c2                	mov    %eax,%edx
80106573:	2b 55 f4             	sub    -0xc(%ebp),%edx
80106576:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106579:	39 c2                	cmp    %eax,%edx
8010657b:	72 bb                	jb     80106538 <sys_sleep+0x3a>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010657d:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
80106584:	e8 27 ea ff ff       	call   80104fb0 <release>
  return 0;
80106589:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010658e:	c9                   	leave  
8010658f:	c3                   	ret    

80106590 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106590:	55                   	push   %ebp
80106591:	89 e5                	mov    %esp,%ebp
80106593:	83 ec 28             	sub    $0x28,%esp
  uint xticks;
  
  acquire(&tickslock);
80106596:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
8010659d:	e8 ad e9 ff ff       	call   80104f4f <acquire>
  xticks = ticks;
801065a2:	a1 c0 28 11 80       	mov    0x801128c0,%eax
801065a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
801065aa:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
801065b1:	e8 fa e9 ff ff       	call   80104fb0 <release>
  return xticks;
801065b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801065b9:	c9                   	leave  
801065ba:	c3                   	ret    

801065bb <sys_tsleep>:

int
sys_tsleep(void)
{
801065bb:	55                   	push   %ebp
801065bc:	89 e5                	mov    %esp,%ebp
801065be:	83 ec 08             	sub    $0x8,%esp
    tsleep();
801065c1:	e8 fa e8 ff ff       	call   80104ec0 <tsleep>
    return 0;
801065c6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801065cb:	c9                   	leave  
801065cc:	c3                   	ret    

801065cd <sys_twakeup>:

int 
sys_twakeup(void)
{
801065cd:	55                   	push   %ebp
801065ce:	89 e5                	mov    %esp,%ebp
801065d0:	83 ec 28             	sub    $0x28,%esp
    int tid;
    if(argint(0,&tid) < 0){
801065d3:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065d6:	89 44 24 04          	mov    %eax,0x4(%esp)
801065da:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801065e1:	e8 14 ef ff ff       	call   801054fa <argint>
801065e6:	85 c0                	test   %eax,%eax
801065e8:	79 07                	jns    801065f1 <sys_twakeup+0x24>
        return -1;
801065ea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065ef:	eb 10                	jmp    80106601 <sys_twakeup+0x34>
    }
        twakeup(tid);
801065f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065f4:	89 04 24             	mov    %eax,(%esp)
801065f7:	e8 b7 e6 ff ff       	call   80104cb3 <twakeup>
        return 0;
801065fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106601:	c9                   	leave  
80106602:	c3                   	ret    

80106603 <sys_thread_yield>:

int 
sys_thread_yield(void)
{
80106603:	55                   	push   %ebp
80106604:	89 e5                	mov    %esp,%ebp
80106606:	83 ec 08             	sub    $0x8,%esp
	thread_yield(); 
80106609:	e8 77 e5 ff ff       	call   80104b85 <thread_yield>
	return 0;
8010660e:	b8 00 00 00 00       	mov    $0x0,%eax
}  
80106613:	c9                   	leave  
80106614:	c3                   	ret    
80106615:	00 00                	add    %al,(%eax)
	...

80106618 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106618:	55                   	push   %ebp
80106619:	89 e5                	mov    %esp,%ebp
8010661b:	83 ec 08             	sub    $0x8,%esp
8010661e:	8b 55 08             	mov    0x8(%ebp),%edx
80106621:	8b 45 0c             	mov    0xc(%ebp),%eax
80106624:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106628:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010662b:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010662f:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106633:	ee                   	out    %al,(%dx)
}
80106634:	c9                   	leave  
80106635:	c3                   	ret    

80106636 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80106636:	55                   	push   %ebp
80106637:	89 e5                	mov    %esp,%ebp
80106639:	83 ec 18             	sub    $0x18,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
8010663c:	c7 44 24 04 34 00 00 	movl   $0x34,0x4(%esp)
80106643:	00 
80106644:	c7 04 24 43 00 00 00 	movl   $0x43,(%esp)
8010664b:	e8 c8 ff ff ff       	call   80106618 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
80106650:	c7 44 24 04 9c 00 00 	movl   $0x9c,0x4(%esp)
80106657:	00 
80106658:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
8010665f:	e8 b4 ff ff ff       	call   80106618 <outb>
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
80106664:	c7 44 24 04 2e 00 00 	movl   $0x2e,0x4(%esp)
8010666b:	00 
8010666c:	c7 04 24 40 00 00 00 	movl   $0x40,(%esp)
80106673:	e8 a0 ff ff ff       	call   80106618 <outb>
  picenable(IRQ_TIMER);
80106678:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010667f:	e8 09 d4 ff ff       	call   80103a8d <picenable>
}
80106684:	c9                   	leave  
80106685:	c3                   	ret    
	...

80106688 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106688:	1e                   	push   %ds
  pushl %es
80106689:	06                   	push   %es
  pushl %fs
8010668a:	0f a0                	push   %fs
  pushl %gs
8010668c:	0f a8                	push   %gs
  pushal
8010668e:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
8010668f:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106693:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106695:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106697:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010669b:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
8010669d:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
8010669f:	54                   	push   %esp
  call trap
801066a0:	e8 d5 01 00 00       	call   8010687a <trap>
  addl $4, %esp
801066a5:	83 c4 04             	add    $0x4,%esp

801066a8 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801066a8:	61                   	popa   
  popl %gs
801066a9:	0f a9                	pop    %gs
  popl %fs
801066ab:	0f a1                	pop    %fs
  popl %es
801066ad:	07                   	pop    %es
  popl %ds
801066ae:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801066af:	83 c4 08             	add    $0x8,%esp
  iret
801066b2:	cf                   	iret   
	...

801066b4 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801066b4:	55                   	push   %ebp
801066b5:	89 e5                	mov    %esp,%ebp
801066b7:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801066ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801066bd:	83 e8 01             	sub    $0x1,%eax
801066c0:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801066c4:	8b 45 08             	mov    0x8(%ebp),%eax
801066c7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801066cb:	8b 45 08             	mov    0x8(%ebp),%eax
801066ce:	c1 e8 10             	shr    $0x10,%eax
801066d1:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801066d5:	8d 45 fa             	lea    -0x6(%ebp),%eax
801066d8:	0f 01 18             	lidtl  (%eax)
}
801066db:	c9                   	leave  
801066dc:	c3                   	ret    

801066dd <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801066dd:	55                   	push   %ebp
801066de:	89 e5                	mov    %esp,%ebp
801066e0:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801066e3:	0f 20 d0             	mov    %cr2,%eax
801066e6:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801066e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801066ec:	c9                   	leave  
801066ed:	c3                   	ret    

801066ee <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801066ee:	55                   	push   %ebp
801066ef:	89 e5                	mov    %esp,%ebp
801066f1:	83 ec 28             	sub    $0x28,%esp
  int i;

  for(i = 0; i < 256; i++)
801066f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801066fb:	e9 bf 00 00 00       	jmp    801067bf <tvinit+0xd1>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106700:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106703:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106706:	8b 14 95 ac b0 10 80 	mov    -0x7fef4f54(,%edx,4),%edx
8010670d:	66 89 14 c5 c0 20 11 	mov    %dx,-0x7feedf40(,%eax,8)
80106714:	80 
80106715:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106718:	66 c7 04 c5 c2 20 11 	movw   $0x8,-0x7feedf3e(,%eax,8)
8010671f:	80 08 00 
80106722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106725:	0f b6 14 c5 c4 20 11 	movzbl -0x7feedf3c(,%eax,8),%edx
8010672c:	80 
8010672d:	83 e2 e0             	and    $0xffffffe0,%edx
80106730:	88 14 c5 c4 20 11 80 	mov    %dl,-0x7feedf3c(,%eax,8)
80106737:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010673a:	0f b6 14 c5 c4 20 11 	movzbl -0x7feedf3c(,%eax,8),%edx
80106741:	80 
80106742:	83 e2 1f             	and    $0x1f,%edx
80106745:	88 14 c5 c4 20 11 80 	mov    %dl,-0x7feedf3c(,%eax,8)
8010674c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010674f:	0f b6 14 c5 c5 20 11 	movzbl -0x7feedf3b(,%eax,8),%edx
80106756:	80 
80106757:	83 e2 f0             	and    $0xfffffff0,%edx
8010675a:	83 ca 0e             	or     $0xe,%edx
8010675d:	88 14 c5 c5 20 11 80 	mov    %dl,-0x7feedf3b(,%eax,8)
80106764:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106767:	0f b6 14 c5 c5 20 11 	movzbl -0x7feedf3b(,%eax,8),%edx
8010676e:	80 
8010676f:	83 e2 ef             	and    $0xffffffef,%edx
80106772:	88 14 c5 c5 20 11 80 	mov    %dl,-0x7feedf3b(,%eax,8)
80106779:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010677c:	0f b6 14 c5 c5 20 11 	movzbl -0x7feedf3b(,%eax,8),%edx
80106783:	80 
80106784:	83 e2 9f             	and    $0xffffff9f,%edx
80106787:	88 14 c5 c5 20 11 80 	mov    %dl,-0x7feedf3b(,%eax,8)
8010678e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106791:	0f b6 14 c5 c5 20 11 	movzbl -0x7feedf3b(,%eax,8),%edx
80106798:	80 
80106799:	83 ca 80             	or     $0xffffff80,%edx
8010679c:	88 14 c5 c5 20 11 80 	mov    %dl,-0x7feedf3b(,%eax,8)
801067a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801067a9:	8b 14 95 ac b0 10 80 	mov    -0x7fef4f54(,%edx,4),%edx
801067b0:	c1 ea 10             	shr    $0x10,%edx
801067b3:	66 89 14 c5 c6 20 11 	mov    %dx,-0x7feedf3a(,%eax,8)
801067ba:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801067bb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801067bf:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801067c6:	0f 8e 34 ff ff ff    	jle    80106700 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801067cc:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
801067d1:	66 a3 c0 22 11 80    	mov    %ax,0x801122c0
801067d7:	66 c7 05 c2 22 11 80 	movw   $0x8,0x801122c2
801067de:	08 00 
801067e0:	0f b6 05 c4 22 11 80 	movzbl 0x801122c4,%eax
801067e7:	83 e0 e0             	and    $0xffffffe0,%eax
801067ea:	a2 c4 22 11 80       	mov    %al,0x801122c4
801067ef:	0f b6 05 c4 22 11 80 	movzbl 0x801122c4,%eax
801067f6:	83 e0 1f             	and    $0x1f,%eax
801067f9:	a2 c4 22 11 80       	mov    %al,0x801122c4
801067fe:	0f b6 05 c5 22 11 80 	movzbl 0x801122c5,%eax
80106805:	83 c8 0f             	or     $0xf,%eax
80106808:	a2 c5 22 11 80       	mov    %al,0x801122c5
8010680d:	0f b6 05 c5 22 11 80 	movzbl 0x801122c5,%eax
80106814:	83 e0 ef             	and    $0xffffffef,%eax
80106817:	a2 c5 22 11 80       	mov    %al,0x801122c5
8010681c:	0f b6 05 c5 22 11 80 	movzbl 0x801122c5,%eax
80106823:	83 c8 60             	or     $0x60,%eax
80106826:	a2 c5 22 11 80       	mov    %al,0x801122c5
8010682b:	0f b6 05 c5 22 11 80 	movzbl 0x801122c5,%eax
80106832:	83 c8 80             	or     $0xffffff80,%eax
80106835:	a2 c5 22 11 80       	mov    %al,0x801122c5
8010683a:	a1 ac b1 10 80       	mov    0x8010b1ac,%eax
8010683f:	c1 e8 10             	shr    $0x10,%eax
80106842:	66 a3 c6 22 11 80    	mov    %ax,0x801122c6
  
  initlock(&tickslock, "time");
80106848:	c7 44 24 04 7c 8a 10 	movl   $0x80108a7c,0x4(%esp)
8010684f:	80 
80106850:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
80106857:	e8 d2 e6 ff ff       	call   80104f2e <initlock>
}
8010685c:	c9                   	leave  
8010685d:	c3                   	ret    

8010685e <idtinit>:

void
idtinit(void)
{
8010685e:	55                   	push   %ebp
8010685f:	89 e5                	mov    %esp,%ebp
80106861:	83 ec 08             	sub    $0x8,%esp
  lidt(idt, sizeof(idt));
80106864:	c7 44 24 04 00 08 00 	movl   $0x800,0x4(%esp)
8010686b:	00 
8010686c:	c7 04 24 c0 20 11 80 	movl   $0x801120c0,(%esp)
80106873:	e8 3c fe ff ff       	call   801066b4 <lidt>
}
80106878:	c9                   	leave  
80106879:	c3                   	ret    

8010687a <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010687a:	55                   	push   %ebp
8010687b:	89 e5                	mov    %esp,%ebp
8010687d:	57                   	push   %edi
8010687e:	56                   	push   %esi
8010687f:	53                   	push   %ebx
80106880:	83 ec 3c             	sub    $0x3c,%esp
  if(tf->trapno == T_SYSCALL){
80106883:	8b 45 08             	mov    0x8(%ebp),%eax
80106886:	8b 40 30             	mov    0x30(%eax),%eax
80106889:	83 f8 40             	cmp    $0x40,%eax
8010688c:	75 3e                	jne    801068cc <trap+0x52>
    if(proc->killed)
8010688e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106894:	8b 40 24             	mov    0x24(%eax),%eax
80106897:	85 c0                	test   %eax,%eax
80106899:	74 05                	je     801068a0 <trap+0x26>
      exit();
8010689b:	e8 30 de ff ff       	call   801046d0 <exit>
    proc->tf = tf;
801068a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068a6:	8b 55 08             	mov    0x8(%ebp),%edx
801068a9:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801068ac:	e8 11 ed ff ff       	call   801055c2 <syscall>
    if(proc->killed)
801068b1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801068b7:	8b 40 24             	mov    0x24(%eax),%eax
801068ba:	85 c0                	test   %eax,%eax
801068bc:	0f 84 34 02 00 00    	je     80106af6 <trap+0x27c>
      exit();
801068c2:	e8 09 de ff ff       	call   801046d0 <exit>
    return;
801068c7:	e9 2b 02 00 00       	jmp    80106af7 <trap+0x27d>
  }

  switch(tf->trapno){
801068cc:	8b 45 08             	mov    0x8(%ebp),%eax
801068cf:	8b 40 30             	mov    0x30(%eax),%eax
801068d2:	83 e8 20             	sub    $0x20,%eax
801068d5:	83 f8 1f             	cmp    $0x1f,%eax
801068d8:	0f 87 bc 00 00 00    	ja     8010699a <trap+0x120>
801068de:	8b 04 85 24 8b 10 80 	mov    -0x7fef74dc(,%eax,4),%eax
801068e5:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801068e7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801068ed:	0f b6 00             	movzbl (%eax),%eax
801068f0:	84 c0                	test   %al,%al
801068f2:	75 31                	jne    80106925 <trap+0xab>
      acquire(&tickslock);
801068f4:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
801068fb:	e8 4f e6 ff ff       	call   80104f4f <acquire>
      ticks++;
80106900:	a1 c0 28 11 80       	mov    0x801128c0,%eax
80106905:	83 c0 01             	add    $0x1,%eax
80106908:	a3 c0 28 11 80       	mov    %eax,0x801128c0
      wakeup(&ticks);
8010690d:	c7 04 24 c0 28 11 80 	movl   $0x801128c0,(%esp)
80106914:	e8 03 e4 ff ff       	call   80104d1c <wakeup>
      release(&tickslock);
80106919:	c7 04 24 80 20 11 80 	movl   $0x80112080,(%esp)
80106920:	e8 8b e6 ff ff       	call   80104fb0 <release>
    }
    lapiceoi();
80106925:	e8 b6 c5 ff ff       	call   80102ee0 <lapiceoi>
    break;
8010692a:	e9 41 01 00 00       	jmp    80106a70 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010692f:	e8 c7 bd ff ff       	call   801026fb <ideintr>
    lapiceoi();
80106934:	e8 a7 c5 ff ff       	call   80102ee0 <lapiceoi>
    break;
80106939:	e9 32 01 00 00       	jmp    80106a70 <trap+0x1f6>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
8010693e:	e8 80 c3 ff ff       	call   80102cc3 <kbdintr>
    lapiceoi();
80106943:	e8 98 c5 ff ff       	call   80102ee0 <lapiceoi>
    break;
80106948:	e9 23 01 00 00       	jmp    80106a70 <trap+0x1f6>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010694d:	e8 9d 03 00 00       	call   80106cef <uartintr>
    lapiceoi();
80106952:	e8 89 c5 ff ff       	call   80102ee0 <lapiceoi>
    break;
80106957:	e9 14 01 00 00       	jmp    80106a70 <trap+0x1f6>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010695c:	8b 45 08             	mov    0x8(%ebp),%eax
8010695f:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106962:	8b 45 08             	mov    0x8(%ebp),%eax
80106965:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106969:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
8010696c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106972:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106975:	0f b6 c0             	movzbl %al,%eax
80106978:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
8010697c:	89 54 24 08          	mov    %edx,0x8(%esp)
80106980:	89 44 24 04          	mov    %eax,0x4(%esp)
80106984:	c7 04 24 84 8a 10 80 	movl   $0x80108a84,(%esp)
8010698b:	e8 0a 9a ff ff       	call   8010039a <cprintf>
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106990:	e8 4b c5 ff ff       	call   80102ee0 <lapiceoi>
    break;
80106995:	e9 d6 00 00 00       	jmp    80106a70 <trap+0x1f6>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
8010699a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801069a0:	85 c0                	test   %eax,%eax
801069a2:	74 11                	je     801069b5 <trap+0x13b>
801069a4:	8b 45 08             	mov    0x8(%ebp),%eax
801069a7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801069ab:	0f b7 c0             	movzwl %ax,%eax
801069ae:	83 e0 03             	and    $0x3,%eax
801069b1:	85 c0                	test   %eax,%eax
801069b3:	75 46                	jne    801069fb <trap+0x181>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801069b5:	e8 23 fd ff ff       	call   801066dd <rcr2>
801069ba:	8b 55 08             	mov    0x8(%ebp),%edx
801069bd:	8b 5a 38             	mov    0x38(%edx),%ebx
              tf->trapno, cpu->id, tf->eip, rcr2());
801069c0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801069c7:	0f b6 12             	movzbl (%edx),%edx
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801069ca:	0f b6 ca             	movzbl %dl,%ecx
801069cd:	8b 55 08             	mov    0x8(%ebp),%edx
801069d0:	8b 52 30             	mov    0x30(%edx),%edx
801069d3:	89 44 24 10          	mov    %eax,0x10(%esp)
801069d7:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801069db:	89 4c 24 08          	mov    %ecx,0x8(%esp)
801069df:	89 54 24 04          	mov    %edx,0x4(%esp)
801069e3:	c7 04 24 a8 8a 10 80 	movl   $0x80108aa8,(%esp)
801069ea:	e8 ab 99 ff ff       	call   8010039a <cprintf>
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801069ef:	c7 04 24 da 8a 10 80 	movl   $0x80108ada,(%esp)
801069f6:	e8 3f 9b ff ff       	call   8010053a <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801069fb:	e8 dd fc ff ff       	call   801066dd <rcr2>
80106a00:	89 c2                	mov    %eax,%edx
80106a02:	8b 45 08             	mov    0x8(%ebp),%eax
80106a05:	8b 78 38             	mov    0x38(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a08:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106a0e:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a11:	0f b6 f0             	movzbl %al,%esi
80106a14:	8b 45 08             	mov    0x8(%ebp),%eax
80106a17:	8b 58 34             	mov    0x34(%eax),%ebx
80106a1a:	8b 45 08             	mov    0x8(%ebp),%eax
80106a1d:	8b 48 30             	mov    0x30(%eax),%ecx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a26:	83 c0 6c             	add    $0x6c,%eax
80106a29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106a2c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106a32:	8b 40 10             	mov    0x10(%eax),%eax
80106a35:	89 54 24 1c          	mov    %edx,0x1c(%esp)
80106a39:	89 7c 24 18          	mov    %edi,0x18(%esp)
80106a3d:	89 74 24 14          	mov    %esi,0x14(%esp)
80106a41:	89 5c 24 10          	mov    %ebx,0x10(%esp)
80106a45:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
80106a49:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106a4c:	89 54 24 08          	mov    %edx,0x8(%esp)
80106a50:	89 44 24 04          	mov    %eax,0x4(%esp)
80106a54:	c7 04 24 e0 8a 10 80 	movl   $0x80108ae0,(%esp)
80106a5b:	e8 3a 99 ff ff       	call   8010039a <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
80106a60:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a66:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106a6d:	eb 01                	jmp    80106a70 <trap+0x1f6>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106a6f:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106a70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a76:	85 c0                	test   %eax,%eax
80106a78:	74 24                	je     80106a9e <trap+0x224>
80106a7a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106a80:	8b 40 24             	mov    0x24(%eax),%eax
80106a83:	85 c0                	test   %eax,%eax
80106a85:	74 17                	je     80106a9e <trap+0x224>
80106a87:	8b 45 08             	mov    0x8(%ebp),%eax
80106a8a:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106a8e:	0f b7 c0             	movzwl %ax,%eax
80106a91:	83 e0 03             	and    $0x3,%eax
80106a94:	83 f8 03             	cmp    $0x3,%eax
80106a97:	75 05                	jne    80106a9e <trap+0x224>
    exit();
80106a99:	e8 32 dc ff ff       	call   801046d0 <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106a9e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aa4:	85 c0                	test   %eax,%eax
80106aa6:	74 1e                	je     80106ac6 <trap+0x24c>
80106aa8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106aae:	8b 40 0c             	mov    0xc(%eax),%eax
80106ab1:	83 f8 04             	cmp    $0x4,%eax
80106ab4:	75 10                	jne    80106ac6 <trap+0x24c>
80106ab6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ab9:	8b 40 30             	mov    0x30(%eax),%eax
80106abc:	83 f8 20             	cmp    $0x20,%eax
80106abf:	75 05                	jne    80106ac6 <trap+0x24c>
    yield();
80106ac1:	e8 8d e0 ff ff       	call   80104b53 <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80106ac6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106acc:	85 c0                	test   %eax,%eax
80106ace:	74 27                	je     80106af7 <trap+0x27d>
80106ad0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106ad6:	8b 40 24             	mov    0x24(%eax),%eax
80106ad9:	85 c0                	test   %eax,%eax
80106adb:	74 1a                	je     80106af7 <trap+0x27d>
80106add:	8b 45 08             	mov    0x8(%ebp),%eax
80106ae0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106ae4:	0f b7 c0             	movzwl %ax,%eax
80106ae7:	83 e0 03             	and    $0x3,%eax
80106aea:	83 f8 03             	cmp    $0x3,%eax
80106aed:	75 08                	jne    80106af7 <trap+0x27d>
    exit();
80106aef:	e8 dc db ff ff       	call   801046d0 <exit>
80106af4:	eb 01                	jmp    80106af7 <trap+0x27d>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
80106af6:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80106af7:	83 c4 3c             	add    $0x3c,%esp
80106afa:	5b                   	pop    %ebx
80106afb:	5e                   	pop    %esi
80106afc:	5f                   	pop    %edi
80106afd:	5d                   	pop    %ebp
80106afe:	c3                   	ret    
	...

80106b00 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 14             	sub    $0x14,%esp
80106b06:	8b 45 08             	mov    0x8(%ebp),%eax
80106b09:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106b0d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80106b11:	89 c2                	mov    %eax,%edx
80106b13:	ec                   	in     (%dx),%al
80106b14:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106b17:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106b1b:	c9                   	leave  
80106b1c:	c3                   	ret    

80106b1d <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106b1d:	55                   	push   %ebp
80106b1e:	89 e5                	mov    %esp,%ebp
80106b20:	83 ec 08             	sub    $0x8,%esp
80106b23:	8b 55 08             	mov    0x8(%ebp),%edx
80106b26:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b29:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106b2d:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106b30:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106b34:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106b38:	ee                   	out    %al,(%dx)
}
80106b39:	c9                   	leave  
80106b3a:	c3                   	ret    

80106b3b <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106b3b:	55                   	push   %ebp
80106b3c:	89 e5                	mov    %esp,%ebp
80106b3e:	83 ec 28             	sub    $0x28,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80106b41:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b48:	00 
80106b49:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106b50:	e8 c8 ff ff ff       	call   80106b1d <outb>
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80106b55:	c7 44 24 04 80 00 00 	movl   $0x80,0x4(%esp)
80106b5c:	00 
80106b5d:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106b64:	e8 b4 ff ff ff       	call   80106b1d <outb>
  outb(COM1+0, 115200/9600);
80106b69:	c7 44 24 04 0c 00 00 	movl   $0xc,0x4(%esp)
80106b70:	00 
80106b71:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106b78:	e8 a0 ff ff ff       	call   80106b1d <outb>
  outb(COM1+1, 0);
80106b7d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106b84:	00 
80106b85:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106b8c:	e8 8c ff ff ff       	call   80106b1d <outb>
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80106b91:	c7 44 24 04 03 00 00 	movl   $0x3,0x4(%esp)
80106b98:	00 
80106b99:	c7 04 24 fb 03 00 00 	movl   $0x3fb,(%esp)
80106ba0:	e8 78 ff ff ff       	call   80106b1d <outb>
  outb(COM1+4, 0);
80106ba5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106bac:	00 
80106bad:	c7 04 24 fc 03 00 00 	movl   $0x3fc,(%esp)
80106bb4:	e8 64 ff ff ff       	call   80106b1d <outb>
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106bb9:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80106bc0:	00 
80106bc1:	c7 04 24 f9 03 00 00 	movl   $0x3f9,(%esp)
80106bc8:	e8 50 ff ff ff       	call   80106b1d <outb>

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106bcd:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106bd4:	e8 27 ff ff ff       	call   80106b00 <inb>
80106bd9:	3c ff                	cmp    $0xff,%al
80106bdb:	74 6c                	je     80106c49 <uartinit+0x10e>
    return;
  uart = 1;
80106bdd:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
80106be4:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80106be7:	c7 04 24 fa 03 00 00 	movl   $0x3fa,(%esp)
80106bee:	e8 0d ff ff ff       	call   80106b00 <inb>
  inb(COM1+0);
80106bf3:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106bfa:	e8 01 ff ff ff       	call   80106b00 <inb>
  picenable(IRQ_COM1);
80106bff:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106c06:	e8 82 ce ff ff       	call   80103a8d <picenable>
  ioapicenable(IRQ_COM1, 0);
80106c0b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c12:	00 
80106c13:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80106c1a:	e8 5f bd ff ff       	call   8010297e <ioapicenable>
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c1f:	c7 45 f4 a4 8b 10 80 	movl   $0x80108ba4,-0xc(%ebp)
80106c26:	eb 15                	jmp    80106c3d <uartinit+0x102>
    uartputc(*p);
80106c28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c2b:	0f b6 00             	movzbl (%eax),%eax
80106c2e:	0f be c0             	movsbl %al,%eax
80106c31:	89 04 24             	mov    %eax,(%esp)
80106c34:	e8 13 00 00 00       	call   80106c4c <uartputc>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106c39:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106c40:	0f b6 00             	movzbl (%eax),%eax
80106c43:	84 c0                	test   %al,%al
80106c45:	75 e1                	jne    80106c28 <uartinit+0xed>
80106c47:	eb 01                	jmp    80106c4a <uartinit+0x10f>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106c49:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106c4a:	c9                   	leave  
80106c4b:	c3                   	ret    

80106c4c <uartputc>:

void
uartputc(int c)
{
80106c4c:	55                   	push   %ebp
80106c4d:	89 e5                	mov    %esp,%ebp
80106c4f:	83 ec 28             	sub    $0x28,%esp
  int i;

  if(!uart)
80106c52:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106c57:	85 c0                	test   %eax,%eax
80106c59:	74 4d                	je     80106ca8 <uartputc+0x5c>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c5b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106c62:	eb 10                	jmp    80106c74 <uartputc+0x28>
    microdelay(10);
80106c64:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80106c6b:	e8 95 c2 ff ff       	call   80102f05 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106c70:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106c74:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106c78:	7f 16                	jg     80106c90 <uartputc+0x44>
80106c7a:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106c81:	e8 7a fe ff ff       	call   80106b00 <inb>
80106c86:	0f b6 c0             	movzbl %al,%eax
80106c89:	83 e0 20             	and    $0x20,%eax
80106c8c:	85 c0                	test   %eax,%eax
80106c8e:	74 d4                	je     80106c64 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106c90:	8b 45 08             	mov    0x8(%ebp),%eax
80106c93:	0f b6 c0             	movzbl %al,%eax
80106c96:	89 44 24 04          	mov    %eax,0x4(%esp)
80106c9a:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106ca1:	e8 77 fe ff ff       	call   80106b1d <outb>
80106ca6:	eb 01                	jmp    80106ca9 <uartputc+0x5d>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
80106ca8:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80106ca9:	c9                   	leave  
80106caa:	c3                   	ret    

80106cab <uartgetc>:

static int
uartgetc(void)
{
80106cab:	55                   	push   %ebp
80106cac:	89 e5                	mov    %esp,%ebp
80106cae:	83 ec 04             	sub    $0x4,%esp
  if(!uart)
80106cb1:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106cb6:	85 c0                	test   %eax,%eax
80106cb8:	75 07                	jne    80106cc1 <uartgetc+0x16>
    return -1;
80106cba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cbf:	eb 2c                	jmp    80106ced <uartgetc+0x42>
  if(!(inb(COM1+5) & 0x01))
80106cc1:	c7 04 24 fd 03 00 00 	movl   $0x3fd,(%esp)
80106cc8:	e8 33 fe ff ff       	call   80106b00 <inb>
80106ccd:	0f b6 c0             	movzbl %al,%eax
80106cd0:	83 e0 01             	and    $0x1,%eax
80106cd3:	85 c0                	test   %eax,%eax
80106cd5:	75 07                	jne    80106cde <uartgetc+0x33>
    return -1;
80106cd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106cdc:	eb 0f                	jmp    80106ced <uartgetc+0x42>
  return inb(COM1+0);
80106cde:	c7 04 24 f8 03 00 00 	movl   $0x3f8,(%esp)
80106ce5:	e8 16 fe ff ff       	call   80106b00 <inb>
80106cea:	0f b6 c0             	movzbl %al,%eax
}
80106ced:	c9                   	leave  
80106cee:	c3                   	ret    

80106cef <uartintr>:

void
uartintr(void)
{
80106cef:	55                   	push   %ebp
80106cf0:	89 e5                	mov    %esp,%ebp
80106cf2:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80106cf5:	c7 04 24 ab 6c 10 80 	movl   $0x80106cab,(%esp)
80106cfc:	e8 aa 9a ff ff       	call   801007ab <consoleintr>
}
80106d01:	c9                   	leave  
80106d02:	c3                   	ret    
	...

80106d04 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $0
80106d06:	6a 00                	push   $0x0
  jmp alltraps
80106d08:	e9 7b f9 ff ff       	jmp    80106688 <alltraps>

80106d0d <vector1>:
.globl vector1
vector1:
  pushl $0
80106d0d:	6a 00                	push   $0x0
  pushl $1
80106d0f:	6a 01                	push   $0x1
  jmp alltraps
80106d11:	e9 72 f9 ff ff       	jmp    80106688 <alltraps>

80106d16 <vector2>:
.globl vector2
vector2:
  pushl $0
80106d16:	6a 00                	push   $0x0
  pushl $2
80106d18:	6a 02                	push   $0x2
  jmp alltraps
80106d1a:	e9 69 f9 ff ff       	jmp    80106688 <alltraps>

80106d1f <vector3>:
.globl vector3
vector3:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $3
80106d21:	6a 03                	push   $0x3
  jmp alltraps
80106d23:	e9 60 f9 ff ff       	jmp    80106688 <alltraps>

80106d28 <vector4>:
.globl vector4
vector4:
  pushl $0
80106d28:	6a 00                	push   $0x0
  pushl $4
80106d2a:	6a 04                	push   $0x4
  jmp alltraps
80106d2c:	e9 57 f9 ff ff       	jmp    80106688 <alltraps>

80106d31 <vector5>:
.globl vector5
vector5:
  pushl $0
80106d31:	6a 00                	push   $0x0
  pushl $5
80106d33:	6a 05                	push   $0x5
  jmp alltraps
80106d35:	e9 4e f9 ff ff       	jmp    80106688 <alltraps>

80106d3a <vector6>:
.globl vector6
vector6:
  pushl $0
80106d3a:	6a 00                	push   $0x0
  pushl $6
80106d3c:	6a 06                	push   $0x6
  jmp alltraps
80106d3e:	e9 45 f9 ff ff       	jmp    80106688 <alltraps>

80106d43 <vector7>:
.globl vector7
vector7:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $7
80106d45:	6a 07                	push   $0x7
  jmp alltraps
80106d47:	e9 3c f9 ff ff       	jmp    80106688 <alltraps>

80106d4c <vector8>:
.globl vector8
vector8:
  pushl $8
80106d4c:	6a 08                	push   $0x8
  jmp alltraps
80106d4e:	e9 35 f9 ff ff       	jmp    80106688 <alltraps>

80106d53 <vector9>:
.globl vector9
vector9:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $9
80106d55:	6a 09                	push   $0x9
  jmp alltraps
80106d57:	e9 2c f9 ff ff       	jmp    80106688 <alltraps>

80106d5c <vector10>:
.globl vector10
vector10:
  pushl $10
80106d5c:	6a 0a                	push   $0xa
  jmp alltraps
80106d5e:	e9 25 f9 ff ff       	jmp    80106688 <alltraps>

80106d63 <vector11>:
.globl vector11
vector11:
  pushl $11
80106d63:	6a 0b                	push   $0xb
  jmp alltraps
80106d65:	e9 1e f9 ff ff       	jmp    80106688 <alltraps>

80106d6a <vector12>:
.globl vector12
vector12:
  pushl $12
80106d6a:	6a 0c                	push   $0xc
  jmp alltraps
80106d6c:	e9 17 f9 ff ff       	jmp    80106688 <alltraps>

80106d71 <vector13>:
.globl vector13
vector13:
  pushl $13
80106d71:	6a 0d                	push   $0xd
  jmp alltraps
80106d73:	e9 10 f9 ff ff       	jmp    80106688 <alltraps>

80106d78 <vector14>:
.globl vector14
vector14:
  pushl $14
80106d78:	6a 0e                	push   $0xe
  jmp alltraps
80106d7a:	e9 09 f9 ff ff       	jmp    80106688 <alltraps>

80106d7f <vector15>:
.globl vector15
vector15:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $15
80106d81:	6a 0f                	push   $0xf
  jmp alltraps
80106d83:	e9 00 f9 ff ff       	jmp    80106688 <alltraps>

80106d88 <vector16>:
.globl vector16
vector16:
  pushl $0
80106d88:	6a 00                	push   $0x0
  pushl $16
80106d8a:	6a 10                	push   $0x10
  jmp alltraps
80106d8c:	e9 f7 f8 ff ff       	jmp    80106688 <alltraps>

80106d91 <vector17>:
.globl vector17
vector17:
  pushl $17
80106d91:	6a 11                	push   $0x11
  jmp alltraps
80106d93:	e9 f0 f8 ff ff       	jmp    80106688 <alltraps>

80106d98 <vector18>:
.globl vector18
vector18:
  pushl $0
80106d98:	6a 00                	push   $0x0
  pushl $18
80106d9a:	6a 12                	push   $0x12
  jmp alltraps
80106d9c:	e9 e7 f8 ff ff       	jmp    80106688 <alltraps>

80106da1 <vector19>:
.globl vector19
vector19:
  pushl $0
80106da1:	6a 00                	push   $0x0
  pushl $19
80106da3:	6a 13                	push   $0x13
  jmp alltraps
80106da5:	e9 de f8 ff ff       	jmp    80106688 <alltraps>

80106daa <vector20>:
.globl vector20
vector20:
  pushl $0
80106daa:	6a 00                	push   $0x0
  pushl $20
80106dac:	6a 14                	push   $0x14
  jmp alltraps
80106dae:	e9 d5 f8 ff ff       	jmp    80106688 <alltraps>

80106db3 <vector21>:
.globl vector21
vector21:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $21
80106db5:	6a 15                	push   $0x15
  jmp alltraps
80106db7:	e9 cc f8 ff ff       	jmp    80106688 <alltraps>

80106dbc <vector22>:
.globl vector22
vector22:
  pushl $0
80106dbc:	6a 00                	push   $0x0
  pushl $22
80106dbe:	6a 16                	push   $0x16
  jmp alltraps
80106dc0:	e9 c3 f8 ff ff       	jmp    80106688 <alltraps>

80106dc5 <vector23>:
.globl vector23
vector23:
  pushl $0
80106dc5:	6a 00                	push   $0x0
  pushl $23
80106dc7:	6a 17                	push   $0x17
  jmp alltraps
80106dc9:	e9 ba f8 ff ff       	jmp    80106688 <alltraps>

80106dce <vector24>:
.globl vector24
vector24:
  pushl $0
80106dce:	6a 00                	push   $0x0
  pushl $24
80106dd0:	6a 18                	push   $0x18
  jmp alltraps
80106dd2:	e9 b1 f8 ff ff       	jmp    80106688 <alltraps>

80106dd7 <vector25>:
.globl vector25
vector25:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $25
80106dd9:	6a 19                	push   $0x19
  jmp alltraps
80106ddb:	e9 a8 f8 ff ff       	jmp    80106688 <alltraps>

80106de0 <vector26>:
.globl vector26
vector26:
  pushl $0
80106de0:	6a 00                	push   $0x0
  pushl $26
80106de2:	6a 1a                	push   $0x1a
  jmp alltraps
80106de4:	e9 9f f8 ff ff       	jmp    80106688 <alltraps>

80106de9 <vector27>:
.globl vector27
vector27:
  pushl $0
80106de9:	6a 00                	push   $0x0
  pushl $27
80106deb:	6a 1b                	push   $0x1b
  jmp alltraps
80106ded:	e9 96 f8 ff ff       	jmp    80106688 <alltraps>

80106df2 <vector28>:
.globl vector28
vector28:
  pushl $0
80106df2:	6a 00                	push   $0x0
  pushl $28
80106df4:	6a 1c                	push   $0x1c
  jmp alltraps
80106df6:	e9 8d f8 ff ff       	jmp    80106688 <alltraps>

80106dfb <vector29>:
.globl vector29
vector29:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $29
80106dfd:	6a 1d                	push   $0x1d
  jmp alltraps
80106dff:	e9 84 f8 ff ff       	jmp    80106688 <alltraps>

80106e04 <vector30>:
.globl vector30
vector30:
  pushl $0
80106e04:	6a 00                	push   $0x0
  pushl $30
80106e06:	6a 1e                	push   $0x1e
  jmp alltraps
80106e08:	e9 7b f8 ff ff       	jmp    80106688 <alltraps>

80106e0d <vector31>:
.globl vector31
vector31:
  pushl $0
80106e0d:	6a 00                	push   $0x0
  pushl $31
80106e0f:	6a 1f                	push   $0x1f
  jmp alltraps
80106e11:	e9 72 f8 ff ff       	jmp    80106688 <alltraps>

80106e16 <vector32>:
.globl vector32
vector32:
  pushl $0
80106e16:	6a 00                	push   $0x0
  pushl $32
80106e18:	6a 20                	push   $0x20
  jmp alltraps
80106e1a:	e9 69 f8 ff ff       	jmp    80106688 <alltraps>

80106e1f <vector33>:
.globl vector33
vector33:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $33
80106e21:	6a 21                	push   $0x21
  jmp alltraps
80106e23:	e9 60 f8 ff ff       	jmp    80106688 <alltraps>

80106e28 <vector34>:
.globl vector34
vector34:
  pushl $0
80106e28:	6a 00                	push   $0x0
  pushl $34
80106e2a:	6a 22                	push   $0x22
  jmp alltraps
80106e2c:	e9 57 f8 ff ff       	jmp    80106688 <alltraps>

80106e31 <vector35>:
.globl vector35
vector35:
  pushl $0
80106e31:	6a 00                	push   $0x0
  pushl $35
80106e33:	6a 23                	push   $0x23
  jmp alltraps
80106e35:	e9 4e f8 ff ff       	jmp    80106688 <alltraps>

80106e3a <vector36>:
.globl vector36
vector36:
  pushl $0
80106e3a:	6a 00                	push   $0x0
  pushl $36
80106e3c:	6a 24                	push   $0x24
  jmp alltraps
80106e3e:	e9 45 f8 ff ff       	jmp    80106688 <alltraps>

80106e43 <vector37>:
.globl vector37
vector37:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $37
80106e45:	6a 25                	push   $0x25
  jmp alltraps
80106e47:	e9 3c f8 ff ff       	jmp    80106688 <alltraps>

80106e4c <vector38>:
.globl vector38
vector38:
  pushl $0
80106e4c:	6a 00                	push   $0x0
  pushl $38
80106e4e:	6a 26                	push   $0x26
  jmp alltraps
80106e50:	e9 33 f8 ff ff       	jmp    80106688 <alltraps>

80106e55 <vector39>:
.globl vector39
vector39:
  pushl $0
80106e55:	6a 00                	push   $0x0
  pushl $39
80106e57:	6a 27                	push   $0x27
  jmp alltraps
80106e59:	e9 2a f8 ff ff       	jmp    80106688 <alltraps>

80106e5e <vector40>:
.globl vector40
vector40:
  pushl $0
80106e5e:	6a 00                	push   $0x0
  pushl $40
80106e60:	6a 28                	push   $0x28
  jmp alltraps
80106e62:	e9 21 f8 ff ff       	jmp    80106688 <alltraps>

80106e67 <vector41>:
.globl vector41
vector41:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $41
80106e69:	6a 29                	push   $0x29
  jmp alltraps
80106e6b:	e9 18 f8 ff ff       	jmp    80106688 <alltraps>

80106e70 <vector42>:
.globl vector42
vector42:
  pushl $0
80106e70:	6a 00                	push   $0x0
  pushl $42
80106e72:	6a 2a                	push   $0x2a
  jmp alltraps
80106e74:	e9 0f f8 ff ff       	jmp    80106688 <alltraps>

80106e79 <vector43>:
.globl vector43
vector43:
  pushl $0
80106e79:	6a 00                	push   $0x0
  pushl $43
80106e7b:	6a 2b                	push   $0x2b
  jmp alltraps
80106e7d:	e9 06 f8 ff ff       	jmp    80106688 <alltraps>

80106e82 <vector44>:
.globl vector44
vector44:
  pushl $0
80106e82:	6a 00                	push   $0x0
  pushl $44
80106e84:	6a 2c                	push   $0x2c
  jmp alltraps
80106e86:	e9 fd f7 ff ff       	jmp    80106688 <alltraps>

80106e8b <vector45>:
.globl vector45
vector45:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $45
80106e8d:	6a 2d                	push   $0x2d
  jmp alltraps
80106e8f:	e9 f4 f7 ff ff       	jmp    80106688 <alltraps>

80106e94 <vector46>:
.globl vector46
vector46:
  pushl $0
80106e94:	6a 00                	push   $0x0
  pushl $46
80106e96:	6a 2e                	push   $0x2e
  jmp alltraps
80106e98:	e9 eb f7 ff ff       	jmp    80106688 <alltraps>

80106e9d <vector47>:
.globl vector47
vector47:
  pushl $0
80106e9d:	6a 00                	push   $0x0
  pushl $47
80106e9f:	6a 2f                	push   $0x2f
  jmp alltraps
80106ea1:	e9 e2 f7 ff ff       	jmp    80106688 <alltraps>

80106ea6 <vector48>:
.globl vector48
vector48:
  pushl $0
80106ea6:	6a 00                	push   $0x0
  pushl $48
80106ea8:	6a 30                	push   $0x30
  jmp alltraps
80106eaa:	e9 d9 f7 ff ff       	jmp    80106688 <alltraps>

80106eaf <vector49>:
.globl vector49
vector49:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $49
80106eb1:	6a 31                	push   $0x31
  jmp alltraps
80106eb3:	e9 d0 f7 ff ff       	jmp    80106688 <alltraps>

80106eb8 <vector50>:
.globl vector50
vector50:
  pushl $0
80106eb8:	6a 00                	push   $0x0
  pushl $50
80106eba:	6a 32                	push   $0x32
  jmp alltraps
80106ebc:	e9 c7 f7 ff ff       	jmp    80106688 <alltraps>

80106ec1 <vector51>:
.globl vector51
vector51:
  pushl $0
80106ec1:	6a 00                	push   $0x0
  pushl $51
80106ec3:	6a 33                	push   $0x33
  jmp alltraps
80106ec5:	e9 be f7 ff ff       	jmp    80106688 <alltraps>

80106eca <vector52>:
.globl vector52
vector52:
  pushl $0
80106eca:	6a 00                	push   $0x0
  pushl $52
80106ecc:	6a 34                	push   $0x34
  jmp alltraps
80106ece:	e9 b5 f7 ff ff       	jmp    80106688 <alltraps>

80106ed3 <vector53>:
.globl vector53
vector53:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $53
80106ed5:	6a 35                	push   $0x35
  jmp alltraps
80106ed7:	e9 ac f7 ff ff       	jmp    80106688 <alltraps>

80106edc <vector54>:
.globl vector54
vector54:
  pushl $0
80106edc:	6a 00                	push   $0x0
  pushl $54
80106ede:	6a 36                	push   $0x36
  jmp alltraps
80106ee0:	e9 a3 f7 ff ff       	jmp    80106688 <alltraps>

80106ee5 <vector55>:
.globl vector55
vector55:
  pushl $0
80106ee5:	6a 00                	push   $0x0
  pushl $55
80106ee7:	6a 37                	push   $0x37
  jmp alltraps
80106ee9:	e9 9a f7 ff ff       	jmp    80106688 <alltraps>

80106eee <vector56>:
.globl vector56
vector56:
  pushl $0
80106eee:	6a 00                	push   $0x0
  pushl $56
80106ef0:	6a 38                	push   $0x38
  jmp alltraps
80106ef2:	e9 91 f7 ff ff       	jmp    80106688 <alltraps>

80106ef7 <vector57>:
.globl vector57
vector57:
  pushl $0
80106ef7:	6a 00                	push   $0x0
  pushl $57
80106ef9:	6a 39                	push   $0x39
  jmp alltraps
80106efb:	e9 88 f7 ff ff       	jmp    80106688 <alltraps>

80106f00 <vector58>:
.globl vector58
vector58:
  pushl $0
80106f00:	6a 00                	push   $0x0
  pushl $58
80106f02:	6a 3a                	push   $0x3a
  jmp alltraps
80106f04:	e9 7f f7 ff ff       	jmp    80106688 <alltraps>

80106f09 <vector59>:
.globl vector59
vector59:
  pushl $0
80106f09:	6a 00                	push   $0x0
  pushl $59
80106f0b:	6a 3b                	push   $0x3b
  jmp alltraps
80106f0d:	e9 76 f7 ff ff       	jmp    80106688 <alltraps>

80106f12 <vector60>:
.globl vector60
vector60:
  pushl $0
80106f12:	6a 00                	push   $0x0
  pushl $60
80106f14:	6a 3c                	push   $0x3c
  jmp alltraps
80106f16:	e9 6d f7 ff ff       	jmp    80106688 <alltraps>

80106f1b <vector61>:
.globl vector61
vector61:
  pushl $0
80106f1b:	6a 00                	push   $0x0
  pushl $61
80106f1d:	6a 3d                	push   $0x3d
  jmp alltraps
80106f1f:	e9 64 f7 ff ff       	jmp    80106688 <alltraps>

80106f24 <vector62>:
.globl vector62
vector62:
  pushl $0
80106f24:	6a 00                	push   $0x0
  pushl $62
80106f26:	6a 3e                	push   $0x3e
  jmp alltraps
80106f28:	e9 5b f7 ff ff       	jmp    80106688 <alltraps>

80106f2d <vector63>:
.globl vector63
vector63:
  pushl $0
80106f2d:	6a 00                	push   $0x0
  pushl $63
80106f2f:	6a 3f                	push   $0x3f
  jmp alltraps
80106f31:	e9 52 f7 ff ff       	jmp    80106688 <alltraps>

80106f36 <vector64>:
.globl vector64
vector64:
  pushl $0
80106f36:	6a 00                	push   $0x0
  pushl $64
80106f38:	6a 40                	push   $0x40
  jmp alltraps
80106f3a:	e9 49 f7 ff ff       	jmp    80106688 <alltraps>

80106f3f <vector65>:
.globl vector65
vector65:
  pushl $0
80106f3f:	6a 00                	push   $0x0
  pushl $65
80106f41:	6a 41                	push   $0x41
  jmp alltraps
80106f43:	e9 40 f7 ff ff       	jmp    80106688 <alltraps>

80106f48 <vector66>:
.globl vector66
vector66:
  pushl $0
80106f48:	6a 00                	push   $0x0
  pushl $66
80106f4a:	6a 42                	push   $0x42
  jmp alltraps
80106f4c:	e9 37 f7 ff ff       	jmp    80106688 <alltraps>

80106f51 <vector67>:
.globl vector67
vector67:
  pushl $0
80106f51:	6a 00                	push   $0x0
  pushl $67
80106f53:	6a 43                	push   $0x43
  jmp alltraps
80106f55:	e9 2e f7 ff ff       	jmp    80106688 <alltraps>

80106f5a <vector68>:
.globl vector68
vector68:
  pushl $0
80106f5a:	6a 00                	push   $0x0
  pushl $68
80106f5c:	6a 44                	push   $0x44
  jmp alltraps
80106f5e:	e9 25 f7 ff ff       	jmp    80106688 <alltraps>

80106f63 <vector69>:
.globl vector69
vector69:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $69
80106f65:	6a 45                	push   $0x45
  jmp alltraps
80106f67:	e9 1c f7 ff ff       	jmp    80106688 <alltraps>

80106f6c <vector70>:
.globl vector70
vector70:
  pushl $0
80106f6c:	6a 00                	push   $0x0
  pushl $70
80106f6e:	6a 46                	push   $0x46
  jmp alltraps
80106f70:	e9 13 f7 ff ff       	jmp    80106688 <alltraps>

80106f75 <vector71>:
.globl vector71
vector71:
  pushl $0
80106f75:	6a 00                	push   $0x0
  pushl $71
80106f77:	6a 47                	push   $0x47
  jmp alltraps
80106f79:	e9 0a f7 ff ff       	jmp    80106688 <alltraps>

80106f7e <vector72>:
.globl vector72
vector72:
  pushl $0
80106f7e:	6a 00                	push   $0x0
  pushl $72
80106f80:	6a 48                	push   $0x48
  jmp alltraps
80106f82:	e9 01 f7 ff ff       	jmp    80106688 <alltraps>

80106f87 <vector73>:
.globl vector73
vector73:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $73
80106f89:	6a 49                	push   $0x49
  jmp alltraps
80106f8b:	e9 f8 f6 ff ff       	jmp    80106688 <alltraps>

80106f90 <vector74>:
.globl vector74
vector74:
  pushl $0
80106f90:	6a 00                	push   $0x0
  pushl $74
80106f92:	6a 4a                	push   $0x4a
  jmp alltraps
80106f94:	e9 ef f6 ff ff       	jmp    80106688 <alltraps>

80106f99 <vector75>:
.globl vector75
vector75:
  pushl $0
80106f99:	6a 00                	push   $0x0
  pushl $75
80106f9b:	6a 4b                	push   $0x4b
  jmp alltraps
80106f9d:	e9 e6 f6 ff ff       	jmp    80106688 <alltraps>

80106fa2 <vector76>:
.globl vector76
vector76:
  pushl $0
80106fa2:	6a 00                	push   $0x0
  pushl $76
80106fa4:	6a 4c                	push   $0x4c
  jmp alltraps
80106fa6:	e9 dd f6 ff ff       	jmp    80106688 <alltraps>

80106fab <vector77>:
.globl vector77
vector77:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $77
80106fad:	6a 4d                	push   $0x4d
  jmp alltraps
80106faf:	e9 d4 f6 ff ff       	jmp    80106688 <alltraps>

80106fb4 <vector78>:
.globl vector78
vector78:
  pushl $0
80106fb4:	6a 00                	push   $0x0
  pushl $78
80106fb6:	6a 4e                	push   $0x4e
  jmp alltraps
80106fb8:	e9 cb f6 ff ff       	jmp    80106688 <alltraps>

80106fbd <vector79>:
.globl vector79
vector79:
  pushl $0
80106fbd:	6a 00                	push   $0x0
  pushl $79
80106fbf:	6a 4f                	push   $0x4f
  jmp alltraps
80106fc1:	e9 c2 f6 ff ff       	jmp    80106688 <alltraps>

80106fc6 <vector80>:
.globl vector80
vector80:
  pushl $0
80106fc6:	6a 00                	push   $0x0
  pushl $80
80106fc8:	6a 50                	push   $0x50
  jmp alltraps
80106fca:	e9 b9 f6 ff ff       	jmp    80106688 <alltraps>

80106fcf <vector81>:
.globl vector81
vector81:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $81
80106fd1:	6a 51                	push   $0x51
  jmp alltraps
80106fd3:	e9 b0 f6 ff ff       	jmp    80106688 <alltraps>

80106fd8 <vector82>:
.globl vector82
vector82:
  pushl $0
80106fd8:	6a 00                	push   $0x0
  pushl $82
80106fda:	6a 52                	push   $0x52
  jmp alltraps
80106fdc:	e9 a7 f6 ff ff       	jmp    80106688 <alltraps>

80106fe1 <vector83>:
.globl vector83
vector83:
  pushl $0
80106fe1:	6a 00                	push   $0x0
  pushl $83
80106fe3:	6a 53                	push   $0x53
  jmp alltraps
80106fe5:	e9 9e f6 ff ff       	jmp    80106688 <alltraps>

80106fea <vector84>:
.globl vector84
vector84:
  pushl $0
80106fea:	6a 00                	push   $0x0
  pushl $84
80106fec:	6a 54                	push   $0x54
  jmp alltraps
80106fee:	e9 95 f6 ff ff       	jmp    80106688 <alltraps>

80106ff3 <vector85>:
.globl vector85
vector85:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $85
80106ff5:	6a 55                	push   $0x55
  jmp alltraps
80106ff7:	e9 8c f6 ff ff       	jmp    80106688 <alltraps>

80106ffc <vector86>:
.globl vector86
vector86:
  pushl $0
80106ffc:	6a 00                	push   $0x0
  pushl $86
80106ffe:	6a 56                	push   $0x56
  jmp alltraps
80107000:	e9 83 f6 ff ff       	jmp    80106688 <alltraps>

80107005 <vector87>:
.globl vector87
vector87:
  pushl $0
80107005:	6a 00                	push   $0x0
  pushl $87
80107007:	6a 57                	push   $0x57
  jmp alltraps
80107009:	e9 7a f6 ff ff       	jmp    80106688 <alltraps>

8010700e <vector88>:
.globl vector88
vector88:
  pushl $0
8010700e:	6a 00                	push   $0x0
  pushl $88
80107010:	6a 58                	push   $0x58
  jmp alltraps
80107012:	e9 71 f6 ff ff       	jmp    80106688 <alltraps>

80107017 <vector89>:
.globl vector89
vector89:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $89
80107019:	6a 59                	push   $0x59
  jmp alltraps
8010701b:	e9 68 f6 ff ff       	jmp    80106688 <alltraps>

80107020 <vector90>:
.globl vector90
vector90:
  pushl $0
80107020:	6a 00                	push   $0x0
  pushl $90
80107022:	6a 5a                	push   $0x5a
  jmp alltraps
80107024:	e9 5f f6 ff ff       	jmp    80106688 <alltraps>

80107029 <vector91>:
.globl vector91
vector91:
  pushl $0
80107029:	6a 00                	push   $0x0
  pushl $91
8010702b:	6a 5b                	push   $0x5b
  jmp alltraps
8010702d:	e9 56 f6 ff ff       	jmp    80106688 <alltraps>

80107032 <vector92>:
.globl vector92
vector92:
  pushl $0
80107032:	6a 00                	push   $0x0
  pushl $92
80107034:	6a 5c                	push   $0x5c
  jmp alltraps
80107036:	e9 4d f6 ff ff       	jmp    80106688 <alltraps>

8010703b <vector93>:
.globl vector93
vector93:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $93
8010703d:	6a 5d                	push   $0x5d
  jmp alltraps
8010703f:	e9 44 f6 ff ff       	jmp    80106688 <alltraps>

80107044 <vector94>:
.globl vector94
vector94:
  pushl $0
80107044:	6a 00                	push   $0x0
  pushl $94
80107046:	6a 5e                	push   $0x5e
  jmp alltraps
80107048:	e9 3b f6 ff ff       	jmp    80106688 <alltraps>

8010704d <vector95>:
.globl vector95
vector95:
  pushl $0
8010704d:	6a 00                	push   $0x0
  pushl $95
8010704f:	6a 5f                	push   $0x5f
  jmp alltraps
80107051:	e9 32 f6 ff ff       	jmp    80106688 <alltraps>

80107056 <vector96>:
.globl vector96
vector96:
  pushl $0
80107056:	6a 00                	push   $0x0
  pushl $96
80107058:	6a 60                	push   $0x60
  jmp alltraps
8010705a:	e9 29 f6 ff ff       	jmp    80106688 <alltraps>

8010705f <vector97>:
.globl vector97
vector97:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $97
80107061:	6a 61                	push   $0x61
  jmp alltraps
80107063:	e9 20 f6 ff ff       	jmp    80106688 <alltraps>

80107068 <vector98>:
.globl vector98
vector98:
  pushl $0
80107068:	6a 00                	push   $0x0
  pushl $98
8010706a:	6a 62                	push   $0x62
  jmp alltraps
8010706c:	e9 17 f6 ff ff       	jmp    80106688 <alltraps>

80107071 <vector99>:
.globl vector99
vector99:
  pushl $0
80107071:	6a 00                	push   $0x0
  pushl $99
80107073:	6a 63                	push   $0x63
  jmp alltraps
80107075:	e9 0e f6 ff ff       	jmp    80106688 <alltraps>

8010707a <vector100>:
.globl vector100
vector100:
  pushl $0
8010707a:	6a 00                	push   $0x0
  pushl $100
8010707c:	6a 64                	push   $0x64
  jmp alltraps
8010707e:	e9 05 f6 ff ff       	jmp    80106688 <alltraps>

80107083 <vector101>:
.globl vector101
vector101:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $101
80107085:	6a 65                	push   $0x65
  jmp alltraps
80107087:	e9 fc f5 ff ff       	jmp    80106688 <alltraps>

8010708c <vector102>:
.globl vector102
vector102:
  pushl $0
8010708c:	6a 00                	push   $0x0
  pushl $102
8010708e:	6a 66                	push   $0x66
  jmp alltraps
80107090:	e9 f3 f5 ff ff       	jmp    80106688 <alltraps>

80107095 <vector103>:
.globl vector103
vector103:
  pushl $0
80107095:	6a 00                	push   $0x0
  pushl $103
80107097:	6a 67                	push   $0x67
  jmp alltraps
80107099:	e9 ea f5 ff ff       	jmp    80106688 <alltraps>

8010709e <vector104>:
.globl vector104
vector104:
  pushl $0
8010709e:	6a 00                	push   $0x0
  pushl $104
801070a0:	6a 68                	push   $0x68
  jmp alltraps
801070a2:	e9 e1 f5 ff ff       	jmp    80106688 <alltraps>

801070a7 <vector105>:
.globl vector105
vector105:
  pushl $0
801070a7:	6a 00                	push   $0x0
  pushl $105
801070a9:	6a 69                	push   $0x69
  jmp alltraps
801070ab:	e9 d8 f5 ff ff       	jmp    80106688 <alltraps>

801070b0 <vector106>:
.globl vector106
vector106:
  pushl $0
801070b0:	6a 00                	push   $0x0
  pushl $106
801070b2:	6a 6a                	push   $0x6a
  jmp alltraps
801070b4:	e9 cf f5 ff ff       	jmp    80106688 <alltraps>

801070b9 <vector107>:
.globl vector107
vector107:
  pushl $0
801070b9:	6a 00                	push   $0x0
  pushl $107
801070bb:	6a 6b                	push   $0x6b
  jmp alltraps
801070bd:	e9 c6 f5 ff ff       	jmp    80106688 <alltraps>

801070c2 <vector108>:
.globl vector108
vector108:
  pushl $0
801070c2:	6a 00                	push   $0x0
  pushl $108
801070c4:	6a 6c                	push   $0x6c
  jmp alltraps
801070c6:	e9 bd f5 ff ff       	jmp    80106688 <alltraps>

801070cb <vector109>:
.globl vector109
vector109:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $109
801070cd:	6a 6d                	push   $0x6d
  jmp alltraps
801070cf:	e9 b4 f5 ff ff       	jmp    80106688 <alltraps>

801070d4 <vector110>:
.globl vector110
vector110:
  pushl $0
801070d4:	6a 00                	push   $0x0
  pushl $110
801070d6:	6a 6e                	push   $0x6e
  jmp alltraps
801070d8:	e9 ab f5 ff ff       	jmp    80106688 <alltraps>

801070dd <vector111>:
.globl vector111
vector111:
  pushl $0
801070dd:	6a 00                	push   $0x0
  pushl $111
801070df:	6a 6f                	push   $0x6f
  jmp alltraps
801070e1:	e9 a2 f5 ff ff       	jmp    80106688 <alltraps>

801070e6 <vector112>:
.globl vector112
vector112:
  pushl $0
801070e6:	6a 00                	push   $0x0
  pushl $112
801070e8:	6a 70                	push   $0x70
  jmp alltraps
801070ea:	e9 99 f5 ff ff       	jmp    80106688 <alltraps>

801070ef <vector113>:
.globl vector113
vector113:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $113
801070f1:	6a 71                	push   $0x71
  jmp alltraps
801070f3:	e9 90 f5 ff ff       	jmp    80106688 <alltraps>

801070f8 <vector114>:
.globl vector114
vector114:
  pushl $0
801070f8:	6a 00                	push   $0x0
  pushl $114
801070fa:	6a 72                	push   $0x72
  jmp alltraps
801070fc:	e9 87 f5 ff ff       	jmp    80106688 <alltraps>

80107101 <vector115>:
.globl vector115
vector115:
  pushl $0
80107101:	6a 00                	push   $0x0
  pushl $115
80107103:	6a 73                	push   $0x73
  jmp alltraps
80107105:	e9 7e f5 ff ff       	jmp    80106688 <alltraps>

8010710a <vector116>:
.globl vector116
vector116:
  pushl $0
8010710a:	6a 00                	push   $0x0
  pushl $116
8010710c:	6a 74                	push   $0x74
  jmp alltraps
8010710e:	e9 75 f5 ff ff       	jmp    80106688 <alltraps>

80107113 <vector117>:
.globl vector117
vector117:
  pushl $0
80107113:	6a 00                	push   $0x0
  pushl $117
80107115:	6a 75                	push   $0x75
  jmp alltraps
80107117:	e9 6c f5 ff ff       	jmp    80106688 <alltraps>

8010711c <vector118>:
.globl vector118
vector118:
  pushl $0
8010711c:	6a 00                	push   $0x0
  pushl $118
8010711e:	6a 76                	push   $0x76
  jmp alltraps
80107120:	e9 63 f5 ff ff       	jmp    80106688 <alltraps>

80107125 <vector119>:
.globl vector119
vector119:
  pushl $0
80107125:	6a 00                	push   $0x0
  pushl $119
80107127:	6a 77                	push   $0x77
  jmp alltraps
80107129:	e9 5a f5 ff ff       	jmp    80106688 <alltraps>

8010712e <vector120>:
.globl vector120
vector120:
  pushl $0
8010712e:	6a 00                	push   $0x0
  pushl $120
80107130:	6a 78                	push   $0x78
  jmp alltraps
80107132:	e9 51 f5 ff ff       	jmp    80106688 <alltraps>

80107137 <vector121>:
.globl vector121
vector121:
  pushl $0
80107137:	6a 00                	push   $0x0
  pushl $121
80107139:	6a 79                	push   $0x79
  jmp alltraps
8010713b:	e9 48 f5 ff ff       	jmp    80106688 <alltraps>

80107140 <vector122>:
.globl vector122
vector122:
  pushl $0
80107140:	6a 00                	push   $0x0
  pushl $122
80107142:	6a 7a                	push   $0x7a
  jmp alltraps
80107144:	e9 3f f5 ff ff       	jmp    80106688 <alltraps>

80107149 <vector123>:
.globl vector123
vector123:
  pushl $0
80107149:	6a 00                	push   $0x0
  pushl $123
8010714b:	6a 7b                	push   $0x7b
  jmp alltraps
8010714d:	e9 36 f5 ff ff       	jmp    80106688 <alltraps>

80107152 <vector124>:
.globl vector124
vector124:
  pushl $0
80107152:	6a 00                	push   $0x0
  pushl $124
80107154:	6a 7c                	push   $0x7c
  jmp alltraps
80107156:	e9 2d f5 ff ff       	jmp    80106688 <alltraps>

8010715b <vector125>:
.globl vector125
vector125:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $125
8010715d:	6a 7d                	push   $0x7d
  jmp alltraps
8010715f:	e9 24 f5 ff ff       	jmp    80106688 <alltraps>

80107164 <vector126>:
.globl vector126
vector126:
  pushl $0
80107164:	6a 00                	push   $0x0
  pushl $126
80107166:	6a 7e                	push   $0x7e
  jmp alltraps
80107168:	e9 1b f5 ff ff       	jmp    80106688 <alltraps>

8010716d <vector127>:
.globl vector127
vector127:
  pushl $0
8010716d:	6a 00                	push   $0x0
  pushl $127
8010716f:	6a 7f                	push   $0x7f
  jmp alltraps
80107171:	e9 12 f5 ff ff       	jmp    80106688 <alltraps>

80107176 <vector128>:
.globl vector128
vector128:
  pushl $0
80107176:	6a 00                	push   $0x0
  pushl $128
80107178:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010717d:	e9 06 f5 ff ff       	jmp    80106688 <alltraps>

80107182 <vector129>:
.globl vector129
vector129:
  pushl $0
80107182:	6a 00                	push   $0x0
  pushl $129
80107184:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80107189:	e9 fa f4 ff ff       	jmp    80106688 <alltraps>

8010718e <vector130>:
.globl vector130
vector130:
  pushl $0
8010718e:	6a 00                	push   $0x0
  pushl $130
80107190:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107195:	e9 ee f4 ff ff       	jmp    80106688 <alltraps>

8010719a <vector131>:
.globl vector131
vector131:
  pushl $0
8010719a:	6a 00                	push   $0x0
  pushl $131
8010719c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801071a1:	e9 e2 f4 ff ff       	jmp    80106688 <alltraps>

801071a6 <vector132>:
.globl vector132
vector132:
  pushl $0
801071a6:	6a 00                	push   $0x0
  pushl $132
801071a8:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801071ad:	e9 d6 f4 ff ff       	jmp    80106688 <alltraps>

801071b2 <vector133>:
.globl vector133
vector133:
  pushl $0
801071b2:	6a 00                	push   $0x0
  pushl $133
801071b4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801071b9:	e9 ca f4 ff ff       	jmp    80106688 <alltraps>

801071be <vector134>:
.globl vector134
vector134:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $134
801071c0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801071c5:	e9 be f4 ff ff       	jmp    80106688 <alltraps>

801071ca <vector135>:
.globl vector135
vector135:
  pushl $0
801071ca:	6a 00                	push   $0x0
  pushl $135
801071cc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801071d1:	e9 b2 f4 ff ff       	jmp    80106688 <alltraps>

801071d6 <vector136>:
.globl vector136
vector136:
  pushl $0
801071d6:	6a 00                	push   $0x0
  pushl $136
801071d8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801071dd:	e9 a6 f4 ff ff       	jmp    80106688 <alltraps>

801071e2 <vector137>:
.globl vector137
vector137:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $137
801071e4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801071e9:	e9 9a f4 ff ff       	jmp    80106688 <alltraps>

801071ee <vector138>:
.globl vector138
vector138:
  pushl $0
801071ee:	6a 00                	push   $0x0
  pushl $138
801071f0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801071f5:	e9 8e f4 ff ff       	jmp    80106688 <alltraps>

801071fa <vector139>:
.globl vector139
vector139:
  pushl $0
801071fa:	6a 00                	push   $0x0
  pushl $139
801071fc:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80107201:	e9 82 f4 ff ff       	jmp    80106688 <alltraps>

80107206 <vector140>:
.globl vector140
vector140:
  pushl $0
80107206:	6a 00                	push   $0x0
  pushl $140
80107208:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010720d:	e9 76 f4 ff ff       	jmp    80106688 <alltraps>

80107212 <vector141>:
.globl vector141
vector141:
  pushl $0
80107212:	6a 00                	push   $0x0
  pushl $141
80107214:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80107219:	e9 6a f4 ff ff       	jmp    80106688 <alltraps>

8010721e <vector142>:
.globl vector142
vector142:
  pushl $0
8010721e:	6a 00                	push   $0x0
  pushl $142
80107220:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80107225:	e9 5e f4 ff ff       	jmp    80106688 <alltraps>

8010722a <vector143>:
.globl vector143
vector143:
  pushl $0
8010722a:	6a 00                	push   $0x0
  pushl $143
8010722c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107231:	e9 52 f4 ff ff       	jmp    80106688 <alltraps>

80107236 <vector144>:
.globl vector144
vector144:
  pushl $0
80107236:	6a 00                	push   $0x0
  pushl $144
80107238:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010723d:	e9 46 f4 ff ff       	jmp    80106688 <alltraps>

80107242 <vector145>:
.globl vector145
vector145:
  pushl $0
80107242:	6a 00                	push   $0x0
  pushl $145
80107244:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80107249:	e9 3a f4 ff ff       	jmp    80106688 <alltraps>

8010724e <vector146>:
.globl vector146
vector146:
  pushl $0
8010724e:	6a 00                	push   $0x0
  pushl $146
80107250:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107255:	e9 2e f4 ff ff       	jmp    80106688 <alltraps>

8010725a <vector147>:
.globl vector147
vector147:
  pushl $0
8010725a:	6a 00                	push   $0x0
  pushl $147
8010725c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107261:	e9 22 f4 ff ff       	jmp    80106688 <alltraps>

80107266 <vector148>:
.globl vector148
vector148:
  pushl $0
80107266:	6a 00                	push   $0x0
  pushl $148
80107268:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010726d:	e9 16 f4 ff ff       	jmp    80106688 <alltraps>

80107272 <vector149>:
.globl vector149
vector149:
  pushl $0
80107272:	6a 00                	push   $0x0
  pushl $149
80107274:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80107279:	e9 0a f4 ff ff       	jmp    80106688 <alltraps>

8010727e <vector150>:
.globl vector150
vector150:
  pushl $0
8010727e:	6a 00                	push   $0x0
  pushl $150
80107280:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107285:	e9 fe f3 ff ff       	jmp    80106688 <alltraps>

8010728a <vector151>:
.globl vector151
vector151:
  pushl $0
8010728a:	6a 00                	push   $0x0
  pushl $151
8010728c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107291:	e9 f2 f3 ff ff       	jmp    80106688 <alltraps>

80107296 <vector152>:
.globl vector152
vector152:
  pushl $0
80107296:	6a 00                	push   $0x0
  pushl $152
80107298:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010729d:	e9 e6 f3 ff ff       	jmp    80106688 <alltraps>

801072a2 <vector153>:
.globl vector153
vector153:
  pushl $0
801072a2:	6a 00                	push   $0x0
  pushl $153
801072a4:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801072a9:	e9 da f3 ff ff       	jmp    80106688 <alltraps>

801072ae <vector154>:
.globl vector154
vector154:
  pushl $0
801072ae:	6a 00                	push   $0x0
  pushl $154
801072b0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801072b5:	e9 ce f3 ff ff       	jmp    80106688 <alltraps>

801072ba <vector155>:
.globl vector155
vector155:
  pushl $0
801072ba:	6a 00                	push   $0x0
  pushl $155
801072bc:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801072c1:	e9 c2 f3 ff ff       	jmp    80106688 <alltraps>

801072c6 <vector156>:
.globl vector156
vector156:
  pushl $0
801072c6:	6a 00                	push   $0x0
  pushl $156
801072c8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801072cd:	e9 b6 f3 ff ff       	jmp    80106688 <alltraps>

801072d2 <vector157>:
.globl vector157
vector157:
  pushl $0
801072d2:	6a 00                	push   $0x0
  pushl $157
801072d4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801072d9:	e9 aa f3 ff ff       	jmp    80106688 <alltraps>

801072de <vector158>:
.globl vector158
vector158:
  pushl $0
801072de:	6a 00                	push   $0x0
  pushl $158
801072e0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801072e5:	e9 9e f3 ff ff       	jmp    80106688 <alltraps>

801072ea <vector159>:
.globl vector159
vector159:
  pushl $0
801072ea:	6a 00                	push   $0x0
  pushl $159
801072ec:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801072f1:	e9 92 f3 ff ff       	jmp    80106688 <alltraps>

801072f6 <vector160>:
.globl vector160
vector160:
  pushl $0
801072f6:	6a 00                	push   $0x0
  pushl $160
801072f8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801072fd:	e9 86 f3 ff ff       	jmp    80106688 <alltraps>

80107302 <vector161>:
.globl vector161
vector161:
  pushl $0
80107302:	6a 00                	push   $0x0
  pushl $161
80107304:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80107309:	e9 7a f3 ff ff       	jmp    80106688 <alltraps>

8010730e <vector162>:
.globl vector162
vector162:
  pushl $0
8010730e:	6a 00                	push   $0x0
  pushl $162
80107310:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80107315:	e9 6e f3 ff ff       	jmp    80106688 <alltraps>

8010731a <vector163>:
.globl vector163
vector163:
  pushl $0
8010731a:	6a 00                	push   $0x0
  pushl $163
8010731c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80107321:	e9 62 f3 ff ff       	jmp    80106688 <alltraps>

80107326 <vector164>:
.globl vector164
vector164:
  pushl $0
80107326:	6a 00                	push   $0x0
  pushl $164
80107328:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010732d:	e9 56 f3 ff ff       	jmp    80106688 <alltraps>

80107332 <vector165>:
.globl vector165
vector165:
  pushl $0
80107332:	6a 00                	push   $0x0
  pushl $165
80107334:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80107339:	e9 4a f3 ff ff       	jmp    80106688 <alltraps>

8010733e <vector166>:
.globl vector166
vector166:
  pushl $0
8010733e:	6a 00                	push   $0x0
  pushl $166
80107340:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80107345:	e9 3e f3 ff ff       	jmp    80106688 <alltraps>

8010734a <vector167>:
.globl vector167
vector167:
  pushl $0
8010734a:	6a 00                	push   $0x0
  pushl $167
8010734c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107351:	e9 32 f3 ff ff       	jmp    80106688 <alltraps>

80107356 <vector168>:
.globl vector168
vector168:
  pushl $0
80107356:	6a 00                	push   $0x0
  pushl $168
80107358:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010735d:	e9 26 f3 ff ff       	jmp    80106688 <alltraps>

80107362 <vector169>:
.globl vector169
vector169:
  pushl $0
80107362:	6a 00                	push   $0x0
  pushl $169
80107364:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80107369:	e9 1a f3 ff ff       	jmp    80106688 <alltraps>

8010736e <vector170>:
.globl vector170
vector170:
  pushl $0
8010736e:	6a 00                	push   $0x0
  pushl $170
80107370:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107375:	e9 0e f3 ff ff       	jmp    80106688 <alltraps>

8010737a <vector171>:
.globl vector171
vector171:
  pushl $0
8010737a:	6a 00                	push   $0x0
  pushl $171
8010737c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107381:	e9 02 f3 ff ff       	jmp    80106688 <alltraps>

80107386 <vector172>:
.globl vector172
vector172:
  pushl $0
80107386:	6a 00                	push   $0x0
  pushl $172
80107388:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010738d:	e9 f6 f2 ff ff       	jmp    80106688 <alltraps>

80107392 <vector173>:
.globl vector173
vector173:
  pushl $0
80107392:	6a 00                	push   $0x0
  pushl $173
80107394:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80107399:	e9 ea f2 ff ff       	jmp    80106688 <alltraps>

8010739e <vector174>:
.globl vector174
vector174:
  pushl $0
8010739e:	6a 00                	push   $0x0
  pushl $174
801073a0:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801073a5:	e9 de f2 ff ff       	jmp    80106688 <alltraps>

801073aa <vector175>:
.globl vector175
vector175:
  pushl $0
801073aa:	6a 00                	push   $0x0
  pushl $175
801073ac:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801073b1:	e9 d2 f2 ff ff       	jmp    80106688 <alltraps>

801073b6 <vector176>:
.globl vector176
vector176:
  pushl $0
801073b6:	6a 00                	push   $0x0
  pushl $176
801073b8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801073bd:	e9 c6 f2 ff ff       	jmp    80106688 <alltraps>

801073c2 <vector177>:
.globl vector177
vector177:
  pushl $0
801073c2:	6a 00                	push   $0x0
  pushl $177
801073c4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801073c9:	e9 ba f2 ff ff       	jmp    80106688 <alltraps>

801073ce <vector178>:
.globl vector178
vector178:
  pushl $0
801073ce:	6a 00                	push   $0x0
  pushl $178
801073d0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801073d5:	e9 ae f2 ff ff       	jmp    80106688 <alltraps>

801073da <vector179>:
.globl vector179
vector179:
  pushl $0
801073da:	6a 00                	push   $0x0
  pushl $179
801073dc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801073e1:	e9 a2 f2 ff ff       	jmp    80106688 <alltraps>

801073e6 <vector180>:
.globl vector180
vector180:
  pushl $0
801073e6:	6a 00                	push   $0x0
  pushl $180
801073e8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801073ed:	e9 96 f2 ff ff       	jmp    80106688 <alltraps>

801073f2 <vector181>:
.globl vector181
vector181:
  pushl $0
801073f2:	6a 00                	push   $0x0
  pushl $181
801073f4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801073f9:	e9 8a f2 ff ff       	jmp    80106688 <alltraps>

801073fe <vector182>:
.globl vector182
vector182:
  pushl $0
801073fe:	6a 00                	push   $0x0
  pushl $182
80107400:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80107405:	e9 7e f2 ff ff       	jmp    80106688 <alltraps>

8010740a <vector183>:
.globl vector183
vector183:
  pushl $0
8010740a:	6a 00                	push   $0x0
  pushl $183
8010740c:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80107411:	e9 72 f2 ff ff       	jmp    80106688 <alltraps>

80107416 <vector184>:
.globl vector184
vector184:
  pushl $0
80107416:	6a 00                	push   $0x0
  pushl $184
80107418:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010741d:	e9 66 f2 ff ff       	jmp    80106688 <alltraps>

80107422 <vector185>:
.globl vector185
vector185:
  pushl $0
80107422:	6a 00                	push   $0x0
  pushl $185
80107424:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80107429:	e9 5a f2 ff ff       	jmp    80106688 <alltraps>

8010742e <vector186>:
.globl vector186
vector186:
  pushl $0
8010742e:	6a 00                	push   $0x0
  pushl $186
80107430:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80107435:	e9 4e f2 ff ff       	jmp    80106688 <alltraps>

8010743a <vector187>:
.globl vector187
vector187:
  pushl $0
8010743a:	6a 00                	push   $0x0
  pushl $187
8010743c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107441:	e9 42 f2 ff ff       	jmp    80106688 <alltraps>

80107446 <vector188>:
.globl vector188
vector188:
  pushl $0
80107446:	6a 00                	push   $0x0
  pushl $188
80107448:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010744d:	e9 36 f2 ff ff       	jmp    80106688 <alltraps>

80107452 <vector189>:
.globl vector189
vector189:
  pushl $0
80107452:	6a 00                	push   $0x0
  pushl $189
80107454:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80107459:	e9 2a f2 ff ff       	jmp    80106688 <alltraps>

8010745e <vector190>:
.globl vector190
vector190:
  pushl $0
8010745e:	6a 00                	push   $0x0
  pushl $190
80107460:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107465:	e9 1e f2 ff ff       	jmp    80106688 <alltraps>

8010746a <vector191>:
.globl vector191
vector191:
  pushl $0
8010746a:	6a 00                	push   $0x0
  pushl $191
8010746c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107471:	e9 12 f2 ff ff       	jmp    80106688 <alltraps>

80107476 <vector192>:
.globl vector192
vector192:
  pushl $0
80107476:	6a 00                	push   $0x0
  pushl $192
80107478:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010747d:	e9 06 f2 ff ff       	jmp    80106688 <alltraps>

80107482 <vector193>:
.globl vector193
vector193:
  pushl $0
80107482:	6a 00                	push   $0x0
  pushl $193
80107484:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107489:	e9 fa f1 ff ff       	jmp    80106688 <alltraps>

8010748e <vector194>:
.globl vector194
vector194:
  pushl $0
8010748e:	6a 00                	push   $0x0
  pushl $194
80107490:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107495:	e9 ee f1 ff ff       	jmp    80106688 <alltraps>

8010749a <vector195>:
.globl vector195
vector195:
  pushl $0
8010749a:	6a 00                	push   $0x0
  pushl $195
8010749c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801074a1:	e9 e2 f1 ff ff       	jmp    80106688 <alltraps>

801074a6 <vector196>:
.globl vector196
vector196:
  pushl $0
801074a6:	6a 00                	push   $0x0
  pushl $196
801074a8:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801074ad:	e9 d6 f1 ff ff       	jmp    80106688 <alltraps>

801074b2 <vector197>:
.globl vector197
vector197:
  pushl $0
801074b2:	6a 00                	push   $0x0
  pushl $197
801074b4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801074b9:	e9 ca f1 ff ff       	jmp    80106688 <alltraps>

801074be <vector198>:
.globl vector198
vector198:
  pushl $0
801074be:	6a 00                	push   $0x0
  pushl $198
801074c0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801074c5:	e9 be f1 ff ff       	jmp    80106688 <alltraps>

801074ca <vector199>:
.globl vector199
vector199:
  pushl $0
801074ca:	6a 00                	push   $0x0
  pushl $199
801074cc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801074d1:	e9 b2 f1 ff ff       	jmp    80106688 <alltraps>

801074d6 <vector200>:
.globl vector200
vector200:
  pushl $0
801074d6:	6a 00                	push   $0x0
  pushl $200
801074d8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801074dd:	e9 a6 f1 ff ff       	jmp    80106688 <alltraps>

801074e2 <vector201>:
.globl vector201
vector201:
  pushl $0
801074e2:	6a 00                	push   $0x0
  pushl $201
801074e4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801074e9:	e9 9a f1 ff ff       	jmp    80106688 <alltraps>

801074ee <vector202>:
.globl vector202
vector202:
  pushl $0
801074ee:	6a 00                	push   $0x0
  pushl $202
801074f0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801074f5:	e9 8e f1 ff ff       	jmp    80106688 <alltraps>

801074fa <vector203>:
.globl vector203
vector203:
  pushl $0
801074fa:	6a 00                	push   $0x0
  pushl $203
801074fc:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107501:	e9 82 f1 ff ff       	jmp    80106688 <alltraps>

80107506 <vector204>:
.globl vector204
vector204:
  pushl $0
80107506:	6a 00                	push   $0x0
  pushl $204
80107508:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010750d:	e9 76 f1 ff ff       	jmp    80106688 <alltraps>

80107512 <vector205>:
.globl vector205
vector205:
  pushl $0
80107512:	6a 00                	push   $0x0
  pushl $205
80107514:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107519:	e9 6a f1 ff ff       	jmp    80106688 <alltraps>

8010751e <vector206>:
.globl vector206
vector206:
  pushl $0
8010751e:	6a 00                	push   $0x0
  pushl $206
80107520:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107525:	e9 5e f1 ff ff       	jmp    80106688 <alltraps>

8010752a <vector207>:
.globl vector207
vector207:
  pushl $0
8010752a:	6a 00                	push   $0x0
  pushl $207
8010752c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107531:	e9 52 f1 ff ff       	jmp    80106688 <alltraps>

80107536 <vector208>:
.globl vector208
vector208:
  pushl $0
80107536:	6a 00                	push   $0x0
  pushl $208
80107538:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010753d:	e9 46 f1 ff ff       	jmp    80106688 <alltraps>

80107542 <vector209>:
.globl vector209
vector209:
  pushl $0
80107542:	6a 00                	push   $0x0
  pushl $209
80107544:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107549:	e9 3a f1 ff ff       	jmp    80106688 <alltraps>

8010754e <vector210>:
.globl vector210
vector210:
  pushl $0
8010754e:	6a 00                	push   $0x0
  pushl $210
80107550:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107555:	e9 2e f1 ff ff       	jmp    80106688 <alltraps>

8010755a <vector211>:
.globl vector211
vector211:
  pushl $0
8010755a:	6a 00                	push   $0x0
  pushl $211
8010755c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107561:	e9 22 f1 ff ff       	jmp    80106688 <alltraps>

80107566 <vector212>:
.globl vector212
vector212:
  pushl $0
80107566:	6a 00                	push   $0x0
  pushl $212
80107568:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010756d:	e9 16 f1 ff ff       	jmp    80106688 <alltraps>

80107572 <vector213>:
.globl vector213
vector213:
  pushl $0
80107572:	6a 00                	push   $0x0
  pushl $213
80107574:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107579:	e9 0a f1 ff ff       	jmp    80106688 <alltraps>

8010757e <vector214>:
.globl vector214
vector214:
  pushl $0
8010757e:	6a 00                	push   $0x0
  pushl $214
80107580:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107585:	e9 fe f0 ff ff       	jmp    80106688 <alltraps>

8010758a <vector215>:
.globl vector215
vector215:
  pushl $0
8010758a:	6a 00                	push   $0x0
  pushl $215
8010758c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107591:	e9 f2 f0 ff ff       	jmp    80106688 <alltraps>

80107596 <vector216>:
.globl vector216
vector216:
  pushl $0
80107596:	6a 00                	push   $0x0
  pushl $216
80107598:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010759d:	e9 e6 f0 ff ff       	jmp    80106688 <alltraps>

801075a2 <vector217>:
.globl vector217
vector217:
  pushl $0
801075a2:	6a 00                	push   $0x0
  pushl $217
801075a4:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801075a9:	e9 da f0 ff ff       	jmp    80106688 <alltraps>

801075ae <vector218>:
.globl vector218
vector218:
  pushl $0
801075ae:	6a 00                	push   $0x0
  pushl $218
801075b0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801075b5:	e9 ce f0 ff ff       	jmp    80106688 <alltraps>

801075ba <vector219>:
.globl vector219
vector219:
  pushl $0
801075ba:	6a 00                	push   $0x0
  pushl $219
801075bc:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801075c1:	e9 c2 f0 ff ff       	jmp    80106688 <alltraps>

801075c6 <vector220>:
.globl vector220
vector220:
  pushl $0
801075c6:	6a 00                	push   $0x0
  pushl $220
801075c8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801075cd:	e9 b6 f0 ff ff       	jmp    80106688 <alltraps>

801075d2 <vector221>:
.globl vector221
vector221:
  pushl $0
801075d2:	6a 00                	push   $0x0
  pushl $221
801075d4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801075d9:	e9 aa f0 ff ff       	jmp    80106688 <alltraps>

801075de <vector222>:
.globl vector222
vector222:
  pushl $0
801075de:	6a 00                	push   $0x0
  pushl $222
801075e0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801075e5:	e9 9e f0 ff ff       	jmp    80106688 <alltraps>

801075ea <vector223>:
.globl vector223
vector223:
  pushl $0
801075ea:	6a 00                	push   $0x0
  pushl $223
801075ec:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801075f1:	e9 92 f0 ff ff       	jmp    80106688 <alltraps>

801075f6 <vector224>:
.globl vector224
vector224:
  pushl $0
801075f6:	6a 00                	push   $0x0
  pushl $224
801075f8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801075fd:	e9 86 f0 ff ff       	jmp    80106688 <alltraps>

80107602 <vector225>:
.globl vector225
vector225:
  pushl $0
80107602:	6a 00                	push   $0x0
  pushl $225
80107604:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107609:	e9 7a f0 ff ff       	jmp    80106688 <alltraps>

8010760e <vector226>:
.globl vector226
vector226:
  pushl $0
8010760e:	6a 00                	push   $0x0
  pushl $226
80107610:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107615:	e9 6e f0 ff ff       	jmp    80106688 <alltraps>

8010761a <vector227>:
.globl vector227
vector227:
  pushl $0
8010761a:	6a 00                	push   $0x0
  pushl $227
8010761c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107621:	e9 62 f0 ff ff       	jmp    80106688 <alltraps>

80107626 <vector228>:
.globl vector228
vector228:
  pushl $0
80107626:	6a 00                	push   $0x0
  pushl $228
80107628:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010762d:	e9 56 f0 ff ff       	jmp    80106688 <alltraps>

80107632 <vector229>:
.globl vector229
vector229:
  pushl $0
80107632:	6a 00                	push   $0x0
  pushl $229
80107634:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107639:	e9 4a f0 ff ff       	jmp    80106688 <alltraps>

8010763e <vector230>:
.globl vector230
vector230:
  pushl $0
8010763e:	6a 00                	push   $0x0
  pushl $230
80107640:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107645:	e9 3e f0 ff ff       	jmp    80106688 <alltraps>

8010764a <vector231>:
.globl vector231
vector231:
  pushl $0
8010764a:	6a 00                	push   $0x0
  pushl $231
8010764c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107651:	e9 32 f0 ff ff       	jmp    80106688 <alltraps>

80107656 <vector232>:
.globl vector232
vector232:
  pushl $0
80107656:	6a 00                	push   $0x0
  pushl $232
80107658:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010765d:	e9 26 f0 ff ff       	jmp    80106688 <alltraps>

80107662 <vector233>:
.globl vector233
vector233:
  pushl $0
80107662:	6a 00                	push   $0x0
  pushl $233
80107664:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107669:	e9 1a f0 ff ff       	jmp    80106688 <alltraps>

8010766e <vector234>:
.globl vector234
vector234:
  pushl $0
8010766e:	6a 00                	push   $0x0
  pushl $234
80107670:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107675:	e9 0e f0 ff ff       	jmp    80106688 <alltraps>

8010767a <vector235>:
.globl vector235
vector235:
  pushl $0
8010767a:	6a 00                	push   $0x0
  pushl $235
8010767c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107681:	e9 02 f0 ff ff       	jmp    80106688 <alltraps>

80107686 <vector236>:
.globl vector236
vector236:
  pushl $0
80107686:	6a 00                	push   $0x0
  pushl $236
80107688:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010768d:	e9 f6 ef ff ff       	jmp    80106688 <alltraps>

80107692 <vector237>:
.globl vector237
vector237:
  pushl $0
80107692:	6a 00                	push   $0x0
  pushl $237
80107694:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107699:	e9 ea ef ff ff       	jmp    80106688 <alltraps>

8010769e <vector238>:
.globl vector238
vector238:
  pushl $0
8010769e:	6a 00                	push   $0x0
  pushl $238
801076a0:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801076a5:	e9 de ef ff ff       	jmp    80106688 <alltraps>

801076aa <vector239>:
.globl vector239
vector239:
  pushl $0
801076aa:	6a 00                	push   $0x0
  pushl $239
801076ac:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801076b1:	e9 d2 ef ff ff       	jmp    80106688 <alltraps>

801076b6 <vector240>:
.globl vector240
vector240:
  pushl $0
801076b6:	6a 00                	push   $0x0
  pushl $240
801076b8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801076bd:	e9 c6 ef ff ff       	jmp    80106688 <alltraps>

801076c2 <vector241>:
.globl vector241
vector241:
  pushl $0
801076c2:	6a 00                	push   $0x0
  pushl $241
801076c4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801076c9:	e9 ba ef ff ff       	jmp    80106688 <alltraps>

801076ce <vector242>:
.globl vector242
vector242:
  pushl $0
801076ce:	6a 00                	push   $0x0
  pushl $242
801076d0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801076d5:	e9 ae ef ff ff       	jmp    80106688 <alltraps>

801076da <vector243>:
.globl vector243
vector243:
  pushl $0
801076da:	6a 00                	push   $0x0
  pushl $243
801076dc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801076e1:	e9 a2 ef ff ff       	jmp    80106688 <alltraps>

801076e6 <vector244>:
.globl vector244
vector244:
  pushl $0
801076e6:	6a 00                	push   $0x0
  pushl $244
801076e8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801076ed:	e9 96 ef ff ff       	jmp    80106688 <alltraps>

801076f2 <vector245>:
.globl vector245
vector245:
  pushl $0
801076f2:	6a 00                	push   $0x0
  pushl $245
801076f4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801076f9:	e9 8a ef ff ff       	jmp    80106688 <alltraps>

801076fe <vector246>:
.globl vector246
vector246:
  pushl $0
801076fe:	6a 00                	push   $0x0
  pushl $246
80107700:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107705:	e9 7e ef ff ff       	jmp    80106688 <alltraps>

8010770a <vector247>:
.globl vector247
vector247:
  pushl $0
8010770a:	6a 00                	push   $0x0
  pushl $247
8010770c:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107711:	e9 72 ef ff ff       	jmp    80106688 <alltraps>

80107716 <vector248>:
.globl vector248
vector248:
  pushl $0
80107716:	6a 00                	push   $0x0
  pushl $248
80107718:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010771d:	e9 66 ef ff ff       	jmp    80106688 <alltraps>

80107722 <vector249>:
.globl vector249
vector249:
  pushl $0
80107722:	6a 00                	push   $0x0
  pushl $249
80107724:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107729:	e9 5a ef ff ff       	jmp    80106688 <alltraps>

8010772e <vector250>:
.globl vector250
vector250:
  pushl $0
8010772e:	6a 00                	push   $0x0
  pushl $250
80107730:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107735:	e9 4e ef ff ff       	jmp    80106688 <alltraps>

8010773a <vector251>:
.globl vector251
vector251:
  pushl $0
8010773a:	6a 00                	push   $0x0
  pushl $251
8010773c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107741:	e9 42 ef ff ff       	jmp    80106688 <alltraps>

80107746 <vector252>:
.globl vector252
vector252:
  pushl $0
80107746:	6a 00                	push   $0x0
  pushl $252
80107748:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010774d:	e9 36 ef ff ff       	jmp    80106688 <alltraps>

80107752 <vector253>:
.globl vector253
vector253:
  pushl $0
80107752:	6a 00                	push   $0x0
  pushl $253
80107754:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107759:	e9 2a ef ff ff       	jmp    80106688 <alltraps>

8010775e <vector254>:
.globl vector254
vector254:
  pushl $0
8010775e:	6a 00                	push   $0x0
  pushl $254
80107760:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107765:	e9 1e ef ff ff       	jmp    80106688 <alltraps>

8010776a <vector255>:
.globl vector255
vector255:
  pushl $0
8010776a:	6a 00                	push   $0x0
  pushl $255
8010776c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107771:	e9 12 ef ff ff       	jmp    80106688 <alltraps>
	...

80107778 <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
80107778:	55                   	push   %ebp
80107779:	89 e5                	mov    %esp,%ebp
8010777b:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
8010777e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107781:	83 e8 01             	sub    $0x1,%eax
80107784:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80107788:	8b 45 08             	mov    0x8(%ebp),%eax
8010778b:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010778f:	8b 45 08             	mov    0x8(%ebp),%eax
80107792:	c1 e8 10             	shr    $0x10,%eax
80107795:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80107799:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010779c:	0f 01 10             	lgdtl  (%eax)
}
8010779f:	c9                   	leave  
801077a0:	c3                   	ret    

801077a1 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
801077a1:	55                   	push   %ebp
801077a2:	89 e5                	mov    %esp,%ebp
801077a4:	83 ec 04             	sub    $0x4,%esp
801077a7:	8b 45 08             	mov    0x8(%ebp),%eax
801077aa:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
801077ae:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077b2:	0f 00 d8             	ltr    %ax
}
801077b5:	c9                   	leave  
801077b6:	c3                   	ret    

801077b7 <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
801077b7:	55                   	push   %ebp
801077b8:	89 e5                	mov    %esp,%ebp
801077ba:	83 ec 04             	sub    $0x4,%esp
801077bd:	8b 45 08             	mov    0x8(%ebp),%eax
801077c0:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
801077c4:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
801077c8:	8e e8                	mov    %eax,%gs
}
801077ca:	c9                   	leave  
801077cb:	c3                   	ret    

801077cc <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
801077cc:	55                   	push   %ebp
801077cd:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077cf:	8b 45 08             	mov    0x8(%ebp),%eax
801077d2:	0f 22 d8             	mov    %eax,%cr3
}
801077d5:	5d                   	pop    %ebp
801077d6:	c3                   	ret    

801077d7 <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801077d7:	55                   	push   %ebp
801077d8:	89 e5                	mov    %esp,%ebp
801077da:	8b 45 08             	mov    0x8(%ebp),%eax
801077dd:	2d 00 00 00 80       	sub    $0x80000000,%eax
801077e2:	5d                   	pop    %ebp
801077e3:	c3                   	ret    

801077e4 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801077e4:	55                   	push   %ebp
801077e5:	89 e5                	mov    %esp,%ebp
801077e7:	8b 45 08             	mov    0x8(%ebp),%eax
801077ea:	2d 00 00 00 80       	sub    $0x80000000,%eax
801077ef:	5d                   	pop    %ebp
801077f0:	c3                   	ret    

801077f1 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801077f1:	55                   	push   %ebp
801077f2:	89 e5                	mov    %esp,%ebp
801077f4:	53                   	push   %ebx
801077f5:	83 ec 24             	sub    $0x24,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801077f8:	e8 87 b6 ff ff       	call   80102e84 <cpunum>
801077fd:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80107803:	05 40 f9 10 80       	add    $0x8010f940,%eax
80107808:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010780b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010780e:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80107814:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107817:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
8010781d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107820:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80107824:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107827:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010782b:	83 e2 f0             	and    $0xfffffff0,%edx
8010782e:	83 ca 0a             	or     $0xa,%edx
80107831:	88 50 7d             	mov    %dl,0x7d(%eax)
80107834:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107837:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010783b:	83 ca 10             	or     $0x10,%edx
8010783e:	88 50 7d             	mov    %dl,0x7d(%eax)
80107841:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107844:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107848:	83 e2 9f             	and    $0xffffff9f,%edx
8010784b:	88 50 7d             	mov    %dl,0x7d(%eax)
8010784e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107851:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107855:	83 ca 80             	or     $0xffffff80,%edx
80107858:	88 50 7d             	mov    %dl,0x7d(%eax)
8010785b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010785e:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107862:	83 ca 0f             	or     $0xf,%edx
80107865:	88 50 7e             	mov    %dl,0x7e(%eax)
80107868:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010786b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010786f:	83 e2 ef             	and    $0xffffffef,%edx
80107872:	88 50 7e             	mov    %dl,0x7e(%eax)
80107875:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107878:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010787c:	83 e2 df             	and    $0xffffffdf,%edx
8010787f:	88 50 7e             	mov    %dl,0x7e(%eax)
80107882:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107885:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107889:	83 ca 40             	or     $0x40,%edx
8010788c:	88 50 7e             	mov    %dl,0x7e(%eax)
8010788f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107892:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107896:	83 ca 80             	or     $0xffffff80,%edx
80107899:	88 50 7e             	mov    %dl,0x7e(%eax)
8010789c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010789f:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801078a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078a6:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801078ad:	ff ff 
801078af:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078b2:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801078b9:	00 00 
801078bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078be:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801078c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c8:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078cf:	83 e2 f0             	and    $0xfffffff0,%edx
801078d2:	83 ca 02             	or     $0x2,%edx
801078d5:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078de:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078e5:	83 ca 10             	or     $0x10,%edx
801078e8:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801078ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078f1:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801078f8:	83 e2 9f             	and    $0xffffff9f,%edx
801078fb:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107901:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107904:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010790b:	83 ca 80             	or     $0xffffff80,%edx
8010790e:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80107914:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107917:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010791e:	83 ca 0f             	or     $0xf,%edx
80107921:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107927:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010792a:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107931:	83 e2 ef             	and    $0xffffffef,%edx
80107934:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010793a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010793d:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107944:	83 e2 df             	and    $0xffffffdf,%edx
80107947:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010794d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107950:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107957:	83 ca 40             	or     $0x40,%edx
8010795a:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107960:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107963:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010796a:	83 ca 80             	or     $0xffffff80,%edx
8010796d:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107973:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107976:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
8010797d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107980:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80107987:	ff ff 
80107989:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010798c:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80107993:	00 00 
80107995:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107998:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
8010799f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079a2:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079a9:	83 e2 f0             	and    $0xfffffff0,%edx
801079ac:	83 ca 0a             	or     $0xa,%edx
801079af:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079b8:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079bf:	83 ca 10             	or     $0x10,%edx
801079c2:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079cb:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079d2:	83 ca 60             	or     $0x60,%edx
801079d5:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079de:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801079e5:	83 ca 80             	or     $0xffffff80,%edx
801079e8:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801079ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079f1:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801079f8:	83 ca 0f             	or     $0xf,%edx
801079fb:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a04:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a0b:	83 e2 ef             	and    $0xffffffef,%edx
80107a0e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a17:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a1e:	83 e2 df             	and    $0xffffffdf,%edx
80107a21:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a2a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a31:	83 ca 40             	or     $0x40,%edx
80107a34:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a3d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107a44:	83 ca 80             	or     $0xffffff80,%edx
80107a47:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107a4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a50:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107a57:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a5a:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107a61:	ff ff 
80107a63:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a66:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107a6d:	00 00 
80107a6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a72:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107a79:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a7c:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a83:	83 e2 f0             	and    $0xfffffff0,%edx
80107a86:	83 ca 02             	or     $0x2,%edx
80107a89:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107a92:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107a99:	83 ca 10             	or     $0x10,%edx
80107a9c:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107aa5:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107aac:	83 ca 60             	or     $0x60,%edx
80107aaf:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ab8:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107abf:	83 ca 80             	or     $0xffffff80,%edx
80107ac2:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107acb:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ad2:	83 ca 0f             	or     $0xf,%edx
80107ad5:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ade:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107ae5:	83 e2 ef             	and    $0xffffffef,%edx
80107ae8:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107aee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107af1:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107af8:	83 e2 df             	and    $0xffffffdf,%edx
80107afb:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b01:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b04:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b0b:	83 ca 40             	or     $0x40,%edx
80107b0e:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b17:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
80107b1e:	83 ca 80             	or     $0xffffff80,%edx
80107b21:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
80107b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b2a:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b34:	05 b4 00 00 00       	add    $0xb4,%eax
80107b39:	89 c3                	mov    %eax,%ebx
80107b3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b3e:	05 b4 00 00 00       	add    $0xb4,%eax
80107b43:	c1 e8 10             	shr    $0x10,%eax
80107b46:	89 c1                	mov    %eax,%ecx
80107b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b4b:	05 b4 00 00 00       	add    $0xb4,%eax
80107b50:	c1 e8 18             	shr    $0x18,%eax
80107b53:	89 c2                	mov    %eax,%edx
80107b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b58:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107b5f:	00 00 
80107b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b64:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107b6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b6e:	88 88 8c 00 00 00    	mov    %cl,0x8c(%eax)
80107b74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b77:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b7e:	83 e1 f0             	and    $0xfffffff0,%ecx
80107b81:	83 c9 02             	or     $0x2,%ecx
80107b84:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107b8d:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107b94:	83 c9 10             	or     $0x10,%ecx
80107b97:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ba0:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107ba7:	83 e1 9f             	and    $0xffffff9f,%ecx
80107baa:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107bb0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bb3:	0f b6 88 8d 00 00 00 	movzbl 0x8d(%eax),%ecx
80107bba:	83 c9 80             	or     $0xffffff80,%ecx
80107bbd:	88 88 8d 00 00 00    	mov    %cl,0x8d(%eax)
80107bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bc6:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107bcd:	83 e1 f0             	and    $0xfffffff0,%ecx
80107bd0:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bd9:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107be0:	83 e1 ef             	and    $0xffffffef,%ecx
80107be3:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bec:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107bf3:	83 e1 df             	and    $0xffffffdf,%ecx
80107bf6:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bff:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107c06:	83 c9 40             	or     $0x40,%ecx
80107c09:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c12:	0f b6 88 8e 00 00 00 	movzbl 0x8e(%eax),%ecx
80107c19:	83 c9 80             	or     $0xffffff80,%ecx
80107c1c:	88 88 8e 00 00 00    	mov    %cl,0x8e(%eax)
80107c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c25:	88 90 8f 00 00 00    	mov    %dl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107c2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c2e:	83 c0 70             	add    $0x70,%eax
80107c31:	c7 44 24 04 38 00 00 	movl   $0x38,0x4(%esp)
80107c38:	00 
80107c39:	89 04 24             	mov    %eax,(%esp)
80107c3c:	e8 37 fb ff ff       	call   80107778 <lgdt>
  loadgs(SEG_KCPU << 3);
80107c41:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
80107c48:	e8 6a fb ff ff       	call   801077b7 <loadgs>
  
  // Initialize cpu-local storage.
  cpu = c;
80107c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c50:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
80107c56:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107c5d:	00 00 00 00 
}
80107c61:	83 c4 24             	add    $0x24,%esp
80107c64:	5b                   	pop    %ebx
80107c65:	5d                   	pop    %ebp
80107c66:	c3                   	ret    

80107c67 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107c67:	55                   	push   %ebp
80107c68:	89 e5                	mov    %esp,%ebp
80107c6a:	83 ec 28             	sub    $0x28,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c70:	c1 e8 16             	shr    $0x16,%eax
80107c73:	c1 e0 02             	shl    $0x2,%eax
80107c76:	03 45 08             	add    0x8(%ebp),%eax
80107c79:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107c7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c7f:	8b 00                	mov    (%eax),%eax
80107c81:	83 e0 01             	and    $0x1,%eax
80107c84:	84 c0                	test   %al,%al
80107c86:	74 17                	je     80107c9f <walkpgdir+0x38>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107c88:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107c8b:	8b 00                	mov    (%eax),%eax
80107c8d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107c92:	89 04 24             	mov    %eax,(%esp)
80107c95:	e8 4a fb ff ff       	call   801077e4 <p2v>
80107c9a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107c9d:	eb 4b                	jmp    80107cea <walkpgdir+0x83>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107c9f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107ca3:	74 0e                	je     80107cb3 <walkpgdir+0x4c>
80107ca5:	e8 60 ae ff ff       	call   80102b0a <kalloc>
80107caa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107cad:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107cb1:	75 07                	jne    80107cba <walkpgdir+0x53>
      return 0;
80107cb3:	b8 00 00 00 00       	mov    $0x0,%eax
80107cb8:	eb 41                	jmp    80107cfb <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107cba:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107cc1:	00 
80107cc2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107cc9:	00 
80107cca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ccd:	89 04 24             	mov    %eax,(%esp)
80107cd0:	e8 c9 d4 ff ff       	call   8010519e <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
80107cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107cd8:	89 04 24             	mov    %eax,(%esp)
80107cdb:	e8 f7 fa ff ff       	call   801077d7 <v2p>
80107ce0:	89 c2                	mov    %eax,%edx
80107ce2:	83 ca 07             	or     $0x7,%edx
80107ce5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107ce8:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80107cea:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ced:	c1 e8 0c             	shr    $0xc,%eax
80107cf0:	25 ff 03 00 00       	and    $0x3ff,%eax
80107cf5:	c1 e0 02             	shl    $0x2,%eax
80107cf8:	03 45 f4             	add    -0xc(%ebp),%eax
}
80107cfb:	c9                   	leave  
80107cfc:	c3                   	ret    

80107cfd <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107cfd:	55                   	push   %ebp
80107cfe:	89 e5                	mov    %esp,%ebp
80107d00:	83 ec 28             	sub    $0x28,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
80107d03:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d06:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d11:	03 45 10             	add    0x10(%ebp),%eax
80107d14:	83 e8 01             	sub    $0x1,%eax
80107d17:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d1c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d1f:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
80107d26:	00 
80107d27:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d2a:	89 44 24 04          	mov    %eax,0x4(%esp)
80107d2e:	8b 45 08             	mov    0x8(%ebp),%eax
80107d31:	89 04 24             	mov    %eax,(%esp)
80107d34:	e8 2e ff ff ff       	call   80107c67 <walkpgdir>
80107d39:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107d3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107d40:	75 07                	jne    80107d49 <mappages+0x4c>
      return -1;
80107d42:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d47:	eb 46                	jmp    80107d8f <mappages+0x92>
    if(*pte & PTE_P)
80107d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d4c:	8b 00                	mov    (%eax),%eax
80107d4e:	83 e0 01             	and    $0x1,%eax
80107d51:	84 c0                	test   %al,%al
80107d53:	74 0c                	je     80107d61 <mappages+0x64>
      panic("remap");
80107d55:	c7 04 24 ac 8b 10 80 	movl   $0x80108bac,(%esp)
80107d5c:	e8 d9 87 ff ff       	call   8010053a <panic>
    *pte = pa | perm | PTE_P;
80107d61:	8b 45 18             	mov    0x18(%ebp),%eax
80107d64:	0b 45 14             	or     0x14(%ebp),%eax
80107d67:	89 c2                	mov    %eax,%edx
80107d69:	83 ca 01             	or     $0x1,%edx
80107d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d6f:	89 10                	mov    %edx,(%eax)
    if(a == last)
80107d71:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107d74:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107d77:	74 10                	je     80107d89 <mappages+0x8c>
      break;
    a += PGSIZE;
80107d79:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
    pa += PGSIZE;
80107d80:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107d87:	eb 96                	jmp    80107d1f <mappages+0x22>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107d89:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107d8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107d8f:	c9                   	leave  
80107d90:	c3                   	ret    

80107d91 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80107d91:	55                   	push   %ebp
80107d92:	89 e5                	mov    %esp,%ebp
80107d94:	53                   	push   %ebx
80107d95:	83 ec 34             	sub    $0x34,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107d98:	e8 6d ad ff ff       	call   80102b0a <kalloc>
80107d9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107da0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107da4:	75 0a                	jne    80107db0 <setupkvm+0x1f>
    return 0;
80107da6:	b8 00 00 00 00       	mov    $0x0,%eax
80107dab:	e9 99 00 00 00       	jmp    80107e49 <setupkvm+0xb8>
  memset(pgdir, 0, PGSIZE);
80107db0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80107db7:	00 
80107db8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107dbf:	00 
80107dc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107dc3:	89 04 24             	mov    %eax,(%esp)
80107dc6:	e8 d3 d3 ff ff       	call   8010519e <memset>
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
80107dcb:	c7 04 24 00 00 00 0e 	movl   $0xe000000,(%esp)
80107dd2:	e8 0d fa ff ff       	call   801077e4 <p2v>
80107dd7:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
80107ddc:	76 0c                	jbe    80107dea <setupkvm+0x59>
    panic("PHYSTOP too high");
80107dde:	c7 04 24 b2 8b 10 80 	movl   $0x80108bb2,(%esp)
80107de5:	e8 50 87 ff ff       	call   8010053a <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107dea:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
80107df1:	eb 49                	jmp    80107e3c <setupkvm+0xab>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
80107df3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107df6:	8b 48 0c             	mov    0xc(%eax),%ecx
80107df9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dfc:	8b 50 04             	mov    0x4(%eax),%edx
80107dff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e02:	8b 58 08             	mov    0x8(%eax),%ebx
80107e05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e08:	8b 40 04             	mov    0x4(%eax),%eax
80107e0b:	29 c3                	sub    %eax,%ebx
80107e0d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e10:	8b 00                	mov    (%eax),%eax
80107e12:	89 4c 24 10          	mov    %ecx,0x10(%esp)
80107e16:	89 54 24 0c          	mov    %edx,0xc(%esp)
80107e1a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80107e1e:	89 44 24 04          	mov    %eax,0x4(%esp)
80107e22:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e25:	89 04 24             	mov    %eax,(%esp)
80107e28:	e8 d0 fe ff ff       	call   80107cfd <mappages>
80107e2d:	85 c0                	test   %eax,%eax
80107e2f:	79 07                	jns    80107e38 <setupkvm+0xa7>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107e31:	b8 00 00 00 00       	mov    $0x0,%eax
80107e36:	eb 11                	jmp    80107e49 <setupkvm+0xb8>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107e38:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107e3c:	b8 00 b5 10 80       	mov    $0x8010b500,%eax
80107e41:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80107e44:	72 ad                	jb     80107df3 <setupkvm+0x62>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107e46:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107e49:	83 c4 34             	add    $0x34,%esp
80107e4c:	5b                   	pop    %ebx
80107e4d:	5d                   	pop    %ebp
80107e4e:	c3                   	ret    

80107e4f <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107e4f:	55                   	push   %ebp
80107e50:	89 e5                	mov    %esp,%ebp
80107e52:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107e55:	e8 37 ff ff ff       	call   80107d91 <setupkvm>
80107e5a:	a3 18 29 11 80       	mov    %eax,0x80112918
  switchkvm();
80107e5f:	e8 02 00 00 00       	call   80107e66 <switchkvm>
}
80107e64:	c9                   	leave  
80107e65:	c3                   	ret    

80107e66 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107e66:	55                   	push   %ebp
80107e67:	89 e5                	mov    %esp,%ebp
80107e69:	83 ec 04             	sub    $0x4,%esp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107e6c:	a1 18 29 11 80       	mov    0x80112918,%eax
80107e71:	89 04 24             	mov    %eax,(%esp)
80107e74:	e8 5e f9 ff ff       	call   801077d7 <v2p>
80107e79:	89 04 24             	mov    %eax,(%esp)
80107e7c:	e8 4b f9 ff ff       	call   801077cc <lcr3>
}
80107e81:	c9                   	leave  
80107e82:	c3                   	ret    

80107e83 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107e83:	55                   	push   %ebp
80107e84:	89 e5                	mov    %esp,%ebp
80107e86:	53                   	push   %ebx
80107e87:	83 ec 14             	sub    $0x14,%esp
  pushcli();
80107e8a:	e8 09 d2 ff ff       	call   80105098 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107e8f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107e95:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107e9c:	83 c2 08             	add    $0x8,%edx
80107e9f:	89 d3                	mov    %edx,%ebx
80107ea1:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107ea8:	83 c2 08             	add    $0x8,%edx
80107eab:	c1 ea 10             	shr    $0x10,%edx
80107eae:	89 d1                	mov    %edx,%ecx
80107eb0:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107eb7:	83 c2 08             	add    $0x8,%edx
80107eba:	c1 ea 18             	shr    $0x18,%edx
80107ebd:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107ec4:	67 00 
80107ec6:	66 89 98 a2 00 00 00 	mov    %bx,0xa2(%eax)
80107ecd:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
80107ed3:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107eda:	83 e1 f0             	and    $0xfffffff0,%ecx
80107edd:	83 c9 09             	or     $0x9,%ecx
80107ee0:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107ee6:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107eed:	83 c9 10             	or     $0x10,%ecx
80107ef0:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107ef6:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107efd:	83 e1 9f             	and    $0xffffff9f,%ecx
80107f00:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107f06:	0f b6 88 a5 00 00 00 	movzbl 0xa5(%eax),%ecx
80107f0d:	83 c9 80             	or     $0xffffff80,%ecx
80107f10:	88 88 a5 00 00 00    	mov    %cl,0xa5(%eax)
80107f16:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f1d:	83 e1 f0             	and    $0xfffffff0,%ecx
80107f20:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f26:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f2d:	83 e1 ef             	and    $0xffffffef,%ecx
80107f30:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f36:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f3d:	83 e1 df             	and    $0xffffffdf,%ecx
80107f40:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f46:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f4d:	83 c9 40             	or     $0x40,%ecx
80107f50:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f56:	0f b6 88 a6 00 00 00 	movzbl 0xa6(%eax),%ecx
80107f5d:	83 e1 7f             	and    $0x7f,%ecx
80107f60:	88 88 a6 00 00 00    	mov    %cl,0xa6(%eax)
80107f66:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107f6c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f72:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107f79:	83 e2 ef             	and    $0xffffffef,%edx
80107f7c:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107f82:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f88:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107f8e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107f94:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107f9b:	8b 52 08             	mov    0x8(%edx),%edx
80107f9e:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107fa4:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107fa7:	c7 04 24 30 00 00 00 	movl   $0x30,(%esp)
80107fae:	e8 ee f7 ff ff       	call   801077a1 <ltr>
  if(p->pgdir == 0)
80107fb3:	8b 45 08             	mov    0x8(%ebp),%eax
80107fb6:	8b 40 04             	mov    0x4(%eax),%eax
80107fb9:	85 c0                	test   %eax,%eax
80107fbb:	75 0c                	jne    80107fc9 <switchuvm+0x146>
    panic("switchuvm: no pgdir");
80107fbd:	c7 04 24 c3 8b 10 80 	movl   $0x80108bc3,(%esp)
80107fc4:	e8 71 85 ff ff       	call   8010053a <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107fc9:	8b 45 08             	mov    0x8(%ebp),%eax
80107fcc:	8b 40 04             	mov    0x4(%eax),%eax
80107fcf:	89 04 24             	mov    %eax,(%esp)
80107fd2:	e8 00 f8 ff ff       	call   801077d7 <v2p>
80107fd7:	89 04 24             	mov    %eax,(%esp)
80107fda:	e8 ed f7 ff ff       	call   801077cc <lcr3>
  popcli();
80107fdf:	e8 fc d0 ff ff       	call   801050e0 <popcli>
}
80107fe4:	83 c4 14             	add    $0x14,%esp
80107fe7:	5b                   	pop    %ebx
80107fe8:	5d                   	pop    %ebp
80107fe9:	c3                   	ret    

80107fea <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107fea:	55                   	push   %ebp
80107feb:	89 e5                	mov    %esp,%ebp
80107fed:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107ff0:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107ff7:	76 0c                	jbe    80108005 <inituvm+0x1b>
    panic("inituvm: more than a page");
80107ff9:	c7 04 24 d7 8b 10 80 	movl   $0x80108bd7,(%esp)
80108000:	e8 35 85 ff ff       	call   8010053a <panic>
  mem = kalloc();
80108005:	e8 00 ab ff ff       	call   80102b0a <kalloc>
8010800a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010800d:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108014:	00 
80108015:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010801c:	00 
8010801d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108020:	89 04 24             	mov    %eax,(%esp)
80108023:	e8 76 d1 ff ff       	call   8010519e <memset>
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80108028:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010802b:	89 04 24             	mov    %eax,(%esp)
8010802e:	e8 a4 f7 ff ff       	call   801077d7 <v2p>
80108033:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
8010803a:	00 
8010803b:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010803f:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108046:	00 
80108047:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010804e:	00 
8010804f:	8b 45 08             	mov    0x8(%ebp),%eax
80108052:	89 04 24             	mov    %eax,(%esp)
80108055:	e8 a3 fc ff ff       	call   80107cfd <mappages>
  memmove(mem, init, sz);
8010805a:	8b 45 10             	mov    0x10(%ebp),%eax
8010805d:	89 44 24 08          	mov    %eax,0x8(%esp)
80108061:	8b 45 0c             	mov    0xc(%ebp),%eax
80108064:	89 44 24 04          	mov    %eax,0x4(%esp)
80108068:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010806b:	89 04 24             	mov    %eax,(%esp)
8010806e:	e8 fe d1 ff ff       	call   80105271 <memmove>
}
80108073:	c9                   	leave  
80108074:	c3                   	ret    

80108075 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80108075:	55                   	push   %ebp
80108076:	89 e5                	mov    %esp,%ebp
80108078:	53                   	push   %ebx
80108079:	83 ec 24             	sub    $0x24,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010807c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010807f:	25 ff 0f 00 00       	and    $0xfff,%eax
80108084:	85 c0                	test   %eax,%eax
80108086:	74 0c                	je     80108094 <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
80108088:	c7 04 24 f4 8b 10 80 	movl   $0x80108bf4,(%esp)
8010808f:	e8 a6 84 ff ff       	call   8010053a <panic>
  for(i = 0; i < sz; i += PGSIZE){
80108094:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
8010809b:	e9 ae 00 00 00       	jmp    8010814e <loaduvm+0xd9>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801080a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
801080a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801080a6:	8d 04 02             	lea    (%edx,%eax,1),%eax
801080a9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801080b0:	00 
801080b1:	89 44 24 04          	mov    %eax,0x4(%esp)
801080b5:	8b 45 08             	mov    0x8(%ebp),%eax
801080b8:	89 04 24             	mov    %eax,(%esp)
801080bb:	e8 a7 fb ff ff       	call   80107c67 <walkpgdir>
801080c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801080c3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801080c7:	75 0c                	jne    801080d5 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801080c9:	c7 04 24 17 8c 10 80 	movl   $0x80108c17,(%esp)
801080d0:	e8 65 84 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
801080d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080d8:	8b 00                	mov    (%eax),%eax
801080da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080df:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(sz - i < PGSIZE)
801080e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801080e5:	8b 55 18             	mov    0x18(%ebp),%edx
801080e8:	89 d1                	mov    %edx,%ecx
801080ea:	29 c1                	sub    %eax,%ecx
801080ec:	89 c8                	mov    %ecx,%eax
801080ee:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801080f3:	77 11                	ja     80108106 <loaduvm+0x91>
      n = sz - i;
801080f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801080f8:	8b 55 18             	mov    0x18(%ebp),%edx
801080fb:	89 d1                	mov    %edx,%ecx
801080fd:	29 c1                	sub    %eax,%ecx
801080ff:	89 c8                	mov    %ecx,%eax
80108101:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108104:	eb 07                	jmp    8010810d <loaduvm+0x98>
    else
      n = PGSIZE;
80108106:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
8010810d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108110:	8b 55 14             	mov    0x14(%ebp),%edx
80108113:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80108116:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108119:	89 04 24             	mov    %eax,(%esp)
8010811c:	e8 c3 f6 ff ff       	call   801077e4 <p2v>
80108121:	8b 55 f0             	mov    -0x10(%ebp),%edx
80108124:	89 54 24 0c          	mov    %edx,0xc(%esp)
80108128:	89 5c 24 08          	mov    %ebx,0x8(%esp)
8010812c:	89 44 24 04          	mov    %eax,0x4(%esp)
80108130:	8b 45 10             	mov    0x10(%ebp),%eax
80108133:	89 04 24             	mov    %eax,(%esp)
80108136:	e8 39 9c ff ff       	call   80101d74 <readi>
8010813b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010813e:	74 07                	je     80108147 <loaduvm+0xd2>
      return -1;
80108140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108145:	eb 18                	jmp    8010815f <loaduvm+0xea>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80108147:	81 45 e8 00 10 00 00 	addl   $0x1000,-0x18(%ebp)
8010814e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108151:	3b 45 18             	cmp    0x18(%ebp),%eax
80108154:	0f 82 46 ff ff ff    	jb     801080a0 <loaduvm+0x2b>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
8010815a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010815f:	83 c4 24             	add    $0x24,%esp
80108162:	5b                   	pop    %ebx
80108163:	5d                   	pop    %ebp
80108164:	c3                   	ret    

80108165 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80108165:	55                   	push   %ebp
80108166:	89 e5                	mov    %esp,%ebp
80108168:	83 ec 38             	sub    $0x38,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010816b:	8b 45 10             	mov    0x10(%ebp),%eax
8010816e:	85 c0                	test   %eax,%eax
80108170:	79 0a                	jns    8010817c <allocuvm+0x17>
    return 0;
80108172:	b8 00 00 00 00       	mov    $0x0,%eax
80108177:	e9 c1 00 00 00       	jmp    8010823d <allocuvm+0xd8>
  if(newsz < oldsz)
8010817c:	8b 45 10             	mov    0x10(%ebp),%eax
8010817f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108182:	73 08                	jae    8010818c <allocuvm+0x27>
    return oldsz;
80108184:	8b 45 0c             	mov    0xc(%ebp),%eax
80108187:	e9 b1 00 00 00       	jmp    8010823d <allocuvm+0xd8>

  a = PGROUNDUP(oldsz);
8010818c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010818f:	05 ff 0f 00 00       	add    $0xfff,%eax
80108194:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108199:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010819c:	e9 8d 00 00 00       	jmp    8010822e <allocuvm+0xc9>
    mem = kalloc();
801081a1:	e8 64 a9 ff ff       	call   80102b0a <kalloc>
801081a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
801081a9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801081ad:	75 2c                	jne    801081db <allocuvm+0x76>
      cprintf("allocuvm out of memory\n");
801081af:	c7 04 24 35 8c 10 80 	movl   $0x80108c35,(%esp)
801081b6:	e8 df 81 ff ff       	call   8010039a <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
801081bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801081be:	89 44 24 08          	mov    %eax,0x8(%esp)
801081c2:	8b 45 10             	mov    0x10(%ebp),%eax
801081c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801081c9:	8b 45 08             	mov    0x8(%ebp),%eax
801081cc:	89 04 24             	mov    %eax,(%esp)
801081cf:	e8 6b 00 00 00       	call   8010823f <deallocuvm>
      return 0;
801081d4:	b8 00 00 00 00       	mov    $0x0,%eax
801081d9:	eb 62                	jmp    8010823d <allocuvm+0xd8>
    }
    memset(mem, 0, PGSIZE);
801081db:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801081e2:	00 
801081e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801081ea:	00 
801081eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081ee:	89 04 24             	mov    %eax,(%esp)
801081f1:	e8 a8 cf ff ff       	call   8010519e <memset>
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
801081f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801081f9:	89 04 24             	mov    %eax,(%esp)
801081fc:	e8 d6 f5 ff ff       	call   801077d7 <v2p>
80108201:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108204:	c7 44 24 10 06 00 00 	movl   $0x6,0x10(%esp)
8010820b:	00 
8010820c:	89 44 24 0c          	mov    %eax,0xc(%esp)
80108210:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80108217:	00 
80108218:	89 54 24 04          	mov    %edx,0x4(%esp)
8010821c:	8b 45 08             	mov    0x8(%ebp),%eax
8010821f:	89 04 24             	mov    %eax,(%esp)
80108222:	e8 d6 fa ff ff       	call   80107cfd <mappages>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80108227:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010822e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108231:	3b 45 10             	cmp    0x10(%ebp),%eax
80108234:	0f 82 67 ff ff ff    	jb     801081a1 <allocuvm+0x3c>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
8010823a:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010823d:	c9                   	leave  
8010823e:	c3                   	ret    

8010823f <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010823f:	55                   	push   %ebp
80108240:	89 e5                	mov    %esp,%ebp
80108242:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80108245:	8b 45 10             	mov    0x10(%ebp),%eax
80108248:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010824b:	72 08                	jb     80108255 <deallocuvm+0x16>
    return oldsz;
8010824d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108250:	e9 a4 00 00 00       	jmp    801082f9 <deallocuvm+0xba>

  a = PGROUNDUP(newsz);
80108255:	8b 45 10             	mov    0x10(%ebp),%eax
80108258:	05 ff 0f 00 00       	add    $0xfff,%eax
8010825d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108262:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80108265:	e9 80 00 00 00       	jmp    801082ea <deallocuvm+0xab>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010826a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010826d:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108274:	00 
80108275:	89 44 24 04          	mov    %eax,0x4(%esp)
80108279:	8b 45 08             	mov    0x8(%ebp),%eax
8010827c:	89 04 24             	mov    %eax,(%esp)
8010827f:	e8 e3 f9 ff ff       	call   80107c67 <walkpgdir>
80108284:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(!pte)
80108287:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
8010828b:	75 09                	jne    80108296 <deallocuvm+0x57>
      a += (NPTENTRIES - 1) * PGSIZE;
8010828d:	81 45 ec 00 f0 3f 00 	addl   $0x3ff000,-0x14(%ebp)
80108294:	eb 4d                	jmp    801082e3 <deallocuvm+0xa4>
    else if((*pte & PTE_P) != 0){
80108296:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108299:	8b 00                	mov    (%eax),%eax
8010829b:	83 e0 01             	and    $0x1,%eax
8010829e:	84 c0                	test   %al,%al
801082a0:	74 41                	je     801082e3 <deallocuvm+0xa4>
      pa = PTE_ADDR(*pte);
801082a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
801082a5:	8b 00                	mov    (%eax),%eax
801082a7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801082ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(pa == 0)
801082af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801082b3:	75 0c                	jne    801082c1 <deallocuvm+0x82>
        panic("kfree");
801082b5:	c7 04 24 4d 8c 10 80 	movl   $0x80108c4d,(%esp)
801082bc:	e8 79 82 ff ff       	call   8010053a <panic>
      char *v = p2v(pa);
801082c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801082c4:	89 04 24             	mov    %eax,(%esp)
801082c7:	e8 18 f5 ff ff       	call   801077e4 <p2v>
801082cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
      kfree(v);
801082cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801082d2:	89 04 24             	mov    %eax,(%esp)
801082d5:	e8 97 a7 ff ff       	call   80102a71 <kfree>
      *pte = 0;
801082da:	8b 45 e8             	mov    -0x18(%ebp),%eax
801082dd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
801082e3:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
801082ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
801082ed:	3b 45 0c             	cmp    0xc(%ebp),%eax
801082f0:	0f 82 74 ff ff ff    	jb     8010826a <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
801082f6:	8b 45 10             	mov    0x10(%ebp),%eax
}
801082f9:	c9                   	leave  
801082fa:	c3                   	ret    

801082fb <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801082fb:	55                   	push   %ebp
801082fc:	89 e5                	mov    %esp,%ebp
801082fe:	83 ec 28             	sub    $0x28,%esp
  uint i;

  if(pgdir == 0)
80108301:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108305:	75 0c                	jne    80108313 <freevm+0x18>
    panic("freevm: no pgdir");
80108307:	c7 04 24 53 8c 10 80 	movl   $0x80108c53,(%esp)
8010830e:	e8 27 82 ff ff       	call   8010053a <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80108313:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
8010831a:	00 
8010831b:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80108322:	80 
80108323:	8b 45 08             	mov    0x8(%ebp),%eax
80108326:	89 04 24             	mov    %eax,(%esp)
80108329:	e8 11 ff ff ff       	call   8010823f <deallocuvm>
  for(i = 0; i < NPDENTRIES; i++){
8010832e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80108335:	eb 3c                	jmp    80108373 <freevm+0x78>
    if(pgdir[i] & PTE_P){
80108337:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010833a:	c1 e0 02             	shl    $0x2,%eax
8010833d:	03 45 08             	add    0x8(%ebp),%eax
80108340:	8b 00                	mov    (%eax),%eax
80108342:	83 e0 01             	and    $0x1,%eax
80108345:	84 c0                	test   %al,%al
80108347:	74 26                	je     8010836f <freevm+0x74>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80108349:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010834c:	c1 e0 02             	shl    $0x2,%eax
8010834f:	03 45 08             	add    0x8(%ebp),%eax
80108352:	8b 00                	mov    (%eax),%eax
80108354:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108359:	89 04 24             	mov    %eax,(%esp)
8010835c:	e8 83 f4 ff ff       	call   801077e4 <p2v>
80108361:	89 45 f4             	mov    %eax,-0xc(%ebp)
      kfree(v);
80108364:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108367:	89 04 24             	mov    %eax,(%esp)
8010836a:	e8 02 a7 ff ff       	call   80102a71 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
8010836f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80108373:	81 7d f0 ff 03 00 00 	cmpl   $0x3ff,-0x10(%ebp)
8010837a:	76 bb                	jbe    80108337 <freevm+0x3c>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
8010837c:	8b 45 08             	mov    0x8(%ebp),%eax
8010837f:	89 04 24             	mov    %eax,(%esp)
80108382:	e8 ea a6 ff ff       	call   80102a71 <kfree>
}
80108387:	c9                   	leave  
80108388:	c3                   	ret    

80108389 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108389:	55                   	push   %ebp
8010838a:	89 e5                	mov    %esp,%ebp
8010838c:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010838f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108396:	00 
80108397:	8b 45 0c             	mov    0xc(%ebp),%eax
8010839a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010839e:	8b 45 08             	mov    0x8(%ebp),%eax
801083a1:	89 04 24             	mov    %eax,(%esp)
801083a4:	e8 be f8 ff ff       	call   80107c67 <walkpgdir>
801083a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801083ac:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801083b0:	75 0c                	jne    801083be <clearpteu+0x35>
    panic("clearpteu");
801083b2:	c7 04 24 64 8c 10 80 	movl   $0x80108c64,(%esp)
801083b9:	e8 7c 81 ff ff       	call   8010053a <panic>
  *pte &= ~PTE_U;
801083be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083c1:	8b 00                	mov    (%eax),%eax
801083c3:	89 c2                	mov    %eax,%edx
801083c5:	83 e2 fb             	and    $0xfffffffb,%edx
801083c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801083cb:	89 10                	mov    %edx,(%eax)
}
801083cd:	c9                   	leave  
801083ce:	c3                   	ret    

801083cf <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801083cf:	55                   	push   %ebp
801083d0:	89 e5                	mov    %esp,%ebp
801083d2:	53                   	push   %ebx
801083d3:	83 ec 44             	sub    $0x44,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801083d6:	e8 b6 f9 ff ff       	call   80107d91 <setupkvm>
801083db:	89 45 e0             	mov    %eax,-0x20(%ebp)
801083de:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801083e2:	75 0a                	jne    801083ee <copyuvm+0x1f>
    return 0;
801083e4:	b8 00 00 00 00       	mov    $0x0,%eax
801083e9:	e9 fd 00 00 00       	jmp    801084eb <copyuvm+0x11c>
  for(i = PGSIZE; i < sz; i += PGSIZE){
801083ee:	c7 45 ec 00 10 00 00 	movl   $0x1000,-0x14(%ebp)
801083f5:	e9 cc 00 00 00       	jmp    801084c6 <copyuvm+0xf7>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801083fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
801083fd:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80108404:	00 
80108405:	89 44 24 04          	mov    %eax,0x4(%esp)
80108409:	8b 45 08             	mov    0x8(%ebp),%eax
8010840c:	89 04 24             	mov    %eax,(%esp)
8010840f:	e8 53 f8 ff ff       	call   80107c67 <walkpgdir>
80108414:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80108417:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
8010841b:	75 0c                	jne    80108429 <copyuvm+0x5a>
      panic("copyuvm: pte should exist");
8010841d:	c7 04 24 6e 8c 10 80 	movl   $0x80108c6e,(%esp)
80108424:	e8 11 81 ff ff       	call   8010053a <panic>
    if(!(*pte & PTE_P))
80108429:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010842c:	8b 00                	mov    (%eax),%eax
8010842e:	83 e0 01             	and    $0x1,%eax
80108431:	85 c0                	test   %eax,%eax
80108433:	75 0c                	jne    80108441 <copyuvm+0x72>
      panic("copyuvm: page not present");
80108435:	c7 04 24 88 8c 10 80 	movl   $0x80108c88,(%esp)
8010843c:	e8 f9 80 ff ff       	call   8010053a <panic>
    pa = PTE_ADDR(*pte);
80108441:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108444:	8b 00                	mov    (%eax),%eax
80108446:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010844b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
8010844e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80108451:	8b 00                	mov    (%eax),%eax
80108453:	25 ff 0f 00 00       	and    $0xfff,%eax
80108458:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mem = kalloc()) == 0)
8010845b:	e8 aa a6 ff ff       	call   80102b0a <kalloc>
80108460:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108467:	74 6e                	je     801084d7 <copyuvm+0x108>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108469:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010846c:	89 04 24             	mov    %eax,(%esp)
8010846f:	e8 70 f3 ff ff       	call   801077e4 <p2v>
80108474:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010847b:	00 
8010847c:	89 44 24 04          	mov    %eax,0x4(%esp)
80108480:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108483:	89 04 24             	mov    %eax,(%esp)
80108486:	e8 e6 cd ff ff       	call   80105271 <memmove>
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
8010848b:	8b 5d f0             	mov    -0x10(%ebp),%ebx
8010848e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108491:	89 04 24             	mov    %eax,(%esp)
80108494:	e8 3e f3 ff ff       	call   801077d7 <v2p>
80108499:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010849c:	89 5c 24 10          	mov    %ebx,0x10(%esp)
801084a0:	89 44 24 0c          	mov    %eax,0xc(%esp)
801084a4:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801084ab:	00 
801084ac:	89 54 24 04          	mov    %edx,0x4(%esp)
801084b0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084b3:	89 04 24             	mov    %eax,(%esp)
801084b6:	e8 42 f8 ff ff       	call   80107cfd <mappages>
801084bb:	85 c0                	test   %eax,%eax
801084bd:	78 1b                	js     801084da <copyuvm+0x10b>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = PGSIZE; i < sz; i += PGSIZE){
801084bf:	81 45 ec 00 10 00 00 	addl   $0x1000,-0x14(%ebp)
801084c6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801084c9:	3b 45 0c             	cmp    0xc(%ebp),%eax
801084cc:	0f 82 28 ff ff ff    	jb     801083fa <copyuvm+0x2b>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
  }
  return d;
801084d2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084d5:	eb 14                	jmp    801084eb <copyuvm+0x11c>
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
801084d7:	90                   	nop
801084d8:	eb 01                	jmp    801084db <copyuvm+0x10c>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), flags) < 0)
      goto bad;
801084da:	90                   	nop
  }
  return d;

bad:
  freevm(d);
801084db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084de:	89 04 24             	mov    %eax,(%esp)
801084e1:	e8 15 fe ff ff       	call   801082fb <freevm>
  return 0;
801084e6:	b8 00 00 00 00       	mov    $0x0,%eax
}
801084eb:	83 c4 44             	add    $0x44,%esp
801084ee:	5b                   	pop    %ebx
801084ef:	5d                   	pop    %ebp
801084f0:	c3                   	ret    

801084f1 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801084f1:	55                   	push   %ebp
801084f2:	89 e5                	mov    %esp,%ebp
801084f4:	83 ec 28             	sub    $0x28,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801084f7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801084fe:	00 
801084ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80108502:	89 44 24 04          	mov    %eax,0x4(%esp)
80108506:	8b 45 08             	mov    0x8(%ebp),%eax
80108509:	89 04 24             	mov    %eax,(%esp)
8010850c:	e8 56 f7 ff ff       	call   80107c67 <walkpgdir>
80108511:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
80108514:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108517:	8b 00                	mov    (%eax),%eax
80108519:	83 e0 01             	and    $0x1,%eax
8010851c:	85 c0                	test   %eax,%eax
8010851e:	75 07                	jne    80108527 <uva2ka+0x36>
    return 0;
80108520:	b8 00 00 00 00       	mov    $0x0,%eax
80108525:	eb 25                	jmp    8010854c <uva2ka+0x5b>
  if((*pte & PTE_U) == 0)
80108527:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010852a:	8b 00                	mov    (%eax),%eax
8010852c:	83 e0 04             	and    $0x4,%eax
8010852f:	85 c0                	test   %eax,%eax
80108531:	75 07                	jne    8010853a <uva2ka+0x49>
    return 0;
80108533:	b8 00 00 00 00       	mov    $0x0,%eax
80108538:	eb 12                	jmp    8010854c <uva2ka+0x5b>
  return (char*)p2v(PTE_ADDR(*pte));
8010853a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010853d:	8b 00                	mov    (%eax),%eax
8010853f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108544:	89 04 24             	mov    %eax,(%esp)
80108547:	e8 98 f2 ff ff       	call   801077e4 <p2v>
}
8010854c:	c9                   	leave  
8010854d:	c3                   	ret    

8010854e <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
8010854e:	55                   	push   %ebp
8010854f:	89 e5                	mov    %esp,%ebp
80108551:	83 ec 28             	sub    $0x28,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
80108554:	8b 45 10             	mov    0x10(%ebp),%eax
80108557:	89 45 e8             	mov    %eax,-0x18(%ebp)
  while(len > 0){
8010855a:	e9 8b 00 00 00       	jmp    801085ea <copyout+0x9c>
    va0 = (uint)PGROUNDDOWN(va);
8010855f:	8b 45 0c             	mov    0xc(%ebp),%eax
80108562:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108567:	89 45 f4             	mov    %eax,-0xc(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010856a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010856d:	89 44 24 04          	mov    %eax,0x4(%esp)
80108571:	8b 45 08             	mov    0x8(%ebp),%eax
80108574:	89 04 24             	mov    %eax,(%esp)
80108577:	e8 75 ff ff ff       	call   801084f1 <uva2ka>
8010857c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pa0 == 0)
8010857f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108583:	75 07                	jne    8010858c <copyout+0x3e>
      return -1;
80108585:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010858a:	eb 6d                	jmp    801085f9 <copyout+0xab>
    n = PGSIZE - (va - va0);
8010858c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010858f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80108592:	89 d1                	mov    %edx,%ecx
80108594:	29 c1                	sub    %eax,%ecx
80108596:	89 c8                	mov    %ecx,%eax
80108598:	05 00 10 00 00       	add    $0x1000,%eax
8010859d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
801085a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085a3:	3b 45 14             	cmp    0x14(%ebp),%eax
801085a6:	76 06                	jbe    801085ae <copyout+0x60>
      n = len;
801085a8:	8b 45 14             	mov    0x14(%ebp),%eax
801085ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801085ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085b1:	8b 55 0c             	mov    0xc(%ebp),%edx
801085b4:	89 d1                	mov    %edx,%ecx
801085b6:	29 c1                	sub    %eax,%ecx
801085b8:	89 c8                	mov    %ecx,%eax
801085ba:	03 45 ec             	add    -0x14(%ebp),%eax
801085bd:	8b 55 f0             	mov    -0x10(%ebp),%edx
801085c0:	89 54 24 08          	mov    %edx,0x8(%esp)
801085c4:	8b 55 e8             	mov    -0x18(%ebp),%edx
801085c7:	89 54 24 04          	mov    %edx,0x4(%esp)
801085cb:	89 04 24             	mov    %eax,(%esp)
801085ce:	e8 9e cc ff ff       	call   80105271 <memmove>
    len -= n;
801085d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085d6:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801085d9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801085dc:	01 45 e8             	add    %eax,-0x18(%ebp)
    va = va0 + PGSIZE;
801085df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801085e2:	05 00 10 00 00       	add    $0x1000,%eax
801085e7:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801085ea:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801085ee:	0f 85 6b ff ff ff    	jne    8010855f <copyout+0x11>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801085f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801085f9:	c9                   	leave  
801085fa:	c3                   	ret    
