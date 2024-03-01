
obj/app_cow:     file format elf64-littleriscv


Disassembly of section .text:

0000000000010078 <main>:
   10078:	1141                	addi	sp,sp,-16
   1007a:	e406                	sd	ra,8(sp)
   1007c:	e022                	sd	s0,0(sp)
   1007e:	0da000ef          	jal	ra,10158 <naive_malloc>
   10082:	842a                	mv	s0,a0
   10084:	00000517          	auipc	a0,0x0
   10088:	35c50513          	addi	a0,a0,860 # 103e0 <vsnprintf+0x1e6>
   1008c:	058000ef          	jal	ra,100e4 <printu>
   10090:	8522                	mv	a0,s0
   10092:	148000ef          	jal	ra,101da <printpa>
   10096:	102000ef          	jal	ra,10198 <fork>
   1009a:	c909                	beqz	a0,100ac <main+0x34>
   1009c:	4501                	li	a0,0
   1009e:	098000ef          	jal	ra,10136 <exit>
   100a2:	4501                	li	a0,0
   100a4:	60a2                	ld	ra,8(sp)
   100a6:	6402                	ld	s0,0(sp)
   100a8:	0141                	addi	sp,sp,16
   100aa:	8082                	ret
   100ac:	00000517          	auipc	a0,0x0
   100b0:	36c50513          	addi	a0,a0,876 # 10418 <vsnprintf+0x21e>
   100b4:	030000ef          	jal	ra,100e4 <printu>
   100b8:	8522                	mv	a0,s0
   100ba:	120000ef          	jal	ra,101da <printpa>
   100be:	00042023          	sw	zero,0(s0)
   100c2:	00000517          	auipc	a0,0x0
   100c6:	39e50513          	addi	a0,a0,926 # 10460 <vsnprintf+0x266>
   100ca:	01a000ef          	jal	ra,100e4 <printu>
   100ce:	8522                	mv	a0,s0
   100d0:	10a000ef          	jal	ra,101da <printpa>
   100d4:	b7e1                	j	1009c <main+0x24>

00000000000100d6 <do_user_call>:
   100d6:	1141                	addi	sp,sp,-16
   100d8:	00000073          	ecall
   100dc:	c62a                	sw	a0,12(sp)
   100de:	4532                	lw	a0,12(sp)
   100e0:	0141                	addi	sp,sp,16
   100e2:	8082                	ret

00000000000100e4 <printu>:
   100e4:	710d                	addi	sp,sp,-352
   100e6:	ee06                	sd	ra,280(sp)
   100e8:	f62e                	sd	a1,296(sp)
   100ea:	fa32                	sd	a2,304(sp)
   100ec:	fe36                	sd	a3,312(sp)
   100ee:	e2ba                	sd	a4,320(sp)
   100f0:	e6be                	sd	a5,328(sp)
   100f2:	eac2                	sd	a6,336(sp)
   100f4:	eec6                	sd	a7,344(sp)
   100f6:	1234                	addi	a3,sp,296
   100f8:	e636                	sd	a3,264(sp)
   100fa:	862a                	mv	a2,a0
   100fc:	10000593          	li	a1,256
   10100:	0028                	addi	a0,sp,8
   10102:	0f8000ef          	jal	ra,101fa <vsnprintf>
   10106:	0005071b          	sext.w	a4,a0
   1010a:	0ff00793          	li	a5,255
   1010e:	02e7e163          	bltu	a5,a4,10130 <printu+0x4c>
   10112:	862a                	mv	a2,a0
   10114:	4881                	li	a7,0
   10116:	4801                	li	a6,0
   10118:	4781                	li	a5,0
   1011a:	4701                	li	a4,0
   1011c:	4681                	li	a3,0
   1011e:	002c                	addi	a1,sp,8
   10120:	04000513          	li	a0,64
   10124:	fb3ff0ef          	jal	ra,100d6 <do_user_call>
   10128:	2501                	sext.w	a0,a0
   1012a:	60f2                	ld	ra,280(sp)
   1012c:	6135                	addi	sp,sp,352
   1012e:	8082                	ret
   10130:	10000613          	li	a2,256
   10134:	b7c5                	j	10114 <printu+0x30>

0000000000010136 <exit>:
   10136:	1141                	addi	sp,sp,-16
   10138:	e406                	sd	ra,8(sp)
   1013a:	85aa                	mv	a1,a0
   1013c:	4881                	li	a7,0
   1013e:	4801                	li	a6,0
   10140:	4781                	li	a5,0
   10142:	4701                	li	a4,0
   10144:	4681                	li	a3,0
   10146:	4601                	li	a2,0
   10148:	04100513          	li	a0,65
   1014c:	f8bff0ef          	jal	ra,100d6 <do_user_call>
   10150:	2501                	sext.w	a0,a0
   10152:	60a2                	ld	ra,8(sp)
   10154:	0141                	addi	sp,sp,16
   10156:	8082                	ret

0000000000010158 <naive_malloc>:
   10158:	1141                	addi	sp,sp,-16
   1015a:	e406                	sd	ra,8(sp)
   1015c:	4881                	li	a7,0
   1015e:	4801                	li	a6,0
   10160:	4781                	li	a5,0
   10162:	4701                	li	a4,0
   10164:	4681                	li	a3,0
   10166:	4601                	li	a2,0
   10168:	4581                	li	a1,0
   1016a:	04200513          	li	a0,66
   1016e:	f69ff0ef          	jal	ra,100d6 <do_user_call>
   10172:	60a2                	ld	ra,8(sp)
   10174:	0141                	addi	sp,sp,16
   10176:	8082                	ret

0000000000010178 <naive_free>:
   10178:	1141                	addi	sp,sp,-16
   1017a:	e406                	sd	ra,8(sp)
   1017c:	85aa                	mv	a1,a0
   1017e:	4881                	li	a7,0
   10180:	4801                	li	a6,0
   10182:	4781                	li	a5,0
   10184:	4701                	li	a4,0
   10186:	4681                	li	a3,0
   10188:	4601                	li	a2,0
   1018a:	04300513          	li	a0,67
   1018e:	f49ff0ef          	jal	ra,100d6 <do_user_call>
   10192:	60a2                	ld	ra,8(sp)
   10194:	0141                	addi	sp,sp,16
   10196:	8082                	ret

0000000000010198 <fork>:
   10198:	1141                	addi	sp,sp,-16
   1019a:	e406                	sd	ra,8(sp)
   1019c:	4881                	li	a7,0
   1019e:	4801                	li	a6,0
   101a0:	4781                	li	a5,0
   101a2:	4701                	li	a4,0
   101a4:	4681                	li	a3,0
   101a6:	4601                	li	a2,0
   101a8:	4581                	li	a1,0
   101aa:	04400513          	li	a0,68
   101ae:	f29ff0ef          	jal	ra,100d6 <do_user_call>
   101b2:	2501                	sext.w	a0,a0
   101b4:	60a2                	ld	ra,8(sp)
   101b6:	0141                	addi	sp,sp,16
   101b8:	8082                	ret

00000000000101ba <yield>:
   101ba:	1141                	addi	sp,sp,-16
   101bc:	e406                	sd	ra,8(sp)
   101be:	4881                	li	a7,0
   101c0:	4801                	li	a6,0
   101c2:	4781                	li	a5,0
   101c4:	4701                	li	a4,0
   101c6:	4681                	li	a3,0
   101c8:	4601                	li	a2,0
   101ca:	4581                	li	a1,0
   101cc:	04500513          	li	a0,69
   101d0:	f07ff0ef          	jal	ra,100d6 <do_user_call>
   101d4:	60a2                	ld	ra,8(sp)
   101d6:	0141                	addi	sp,sp,16
   101d8:	8082                	ret

00000000000101da <printpa>:
   101da:	1141                	addi	sp,sp,-16
   101dc:	e406                	sd	ra,8(sp)
   101de:	85aa                	mv	a1,a0
   101e0:	4881                	li	a7,0
   101e2:	4801                	li	a6,0
   101e4:	4781                	li	a5,0
   101e6:	4701                	li	a4,0
   101e8:	4681                	li	a3,0
   101ea:	4601                	li	a2,0
   101ec:	04600513          	li	a0,70
   101f0:	ee7ff0ef          	jal	ra,100d6 <do_user_call>
   101f4:	60a2                	ld	ra,8(sp)
   101f6:	0141                	addi	sp,sp,16
   101f8:	8082                	ret

00000000000101fa <vsnprintf>:
   101fa:	1141                	addi	sp,sp,-16
   101fc:	e436                	sd	a3,8(sp)
   101fe:	4781                	li	a5,0
   10200:	4301                	li	t1,0
   10202:	4681                	li	a3,0
   10204:	a271                	j	10390 <vsnprintf+0x196>
   10206:	00178713          	addi	a4,a5,1
   1020a:	00b77863          	bgeu	a4,a1,1021a <vsnprintf+0x20>
   1020e:	00f50833          	add	a6,a0,a5
   10212:	03000893          	li	a7,48
   10216:	01180023          	sb	a7,0(a6)
   1021a:	0789                	addi	a5,a5,2
   1021c:	00b7f763          	bgeu	a5,a1,1022a <vsnprintf+0x30>
   10220:	972a                	add	a4,a4,a0
   10222:	07800813          	li	a6,120
   10226:	01070023          	sb	a6,0(a4)
   1022a:	6722                	ld	a4,8(sp)
   1022c:	00870813          	addi	a6,a4,8
   10230:	e442                	sd	a6,8(sp)
   10232:	00073883          	ld	a7,0(a4)
   10236:	e6b9                	bnez	a3,10284 <vsnprintf+0x8a>
   10238:	469d                	li	a3,7
   1023a:	a025                	j	10262 <vsnprintf+0x68>
   1023c:	00030463          	beqz	t1,10244 <vsnprintf+0x4a>
   10240:	869a                	mv	a3,t1
   10242:	b7e5                	j	1022a <vsnprintf+0x30>
   10244:	6722                	ld	a4,8(sp)
   10246:	00870693          	addi	a3,a4,8
   1024a:	e436                	sd	a3,8(sp)
   1024c:	00072883          	lw	a7,0(a4)
   10250:	869a                	mv	a3,t1
   10252:	b7d5                	j	10236 <vsnprintf+0x3c>
   10254:	05770713          	addi	a4,a4,87
   10258:	97aa                	add	a5,a5,a0
   1025a:	00e78023          	sb	a4,0(a5)
   1025e:	36fd                	addiw	a3,a3,-1
   10260:	87c2                	mv	a5,a6
   10262:	0206c363          	bltz	a3,10288 <vsnprintf+0x8e>
   10266:	0026971b          	slliw	a4,a3,0x2
   1026a:	40e8d733          	sra	a4,a7,a4
   1026e:	8b3d                	andi	a4,a4,15
   10270:	00178813          	addi	a6,a5,1
   10274:	feb875e3          	bgeu	a6,a1,1025e <vsnprintf+0x64>
   10278:	4325                	li	t1,9
   1027a:	fce34de3          	blt	t1,a4,10254 <vsnprintf+0x5a>
   1027e:	03070713          	addi	a4,a4,48
   10282:	bfd9                	j	10258 <vsnprintf+0x5e>
   10284:	46bd                	li	a3,15
   10286:	bff1                	j	10262 <vsnprintf+0x68>
   10288:	4301                	li	t1,0
   1028a:	4681                	li	a3,0
   1028c:	a209                	j	1038e <vsnprintf+0x194>
   1028e:	00030d63          	beqz	t1,102a8 <vsnprintf+0xae>
   10292:	6722                	ld	a4,8(sp)
   10294:	00870693          	addi	a3,a4,8
   10298:	e436                	sd	a3,8(sp)
   1029a:	00073883          	ld	a7,0(a4)
   1029e:	0008cc63          	bltz	a7,102b6 <vsnprintf+0xbc>
   102a2:	8746                	mv	a4,a7
   102a4:	4305                	li	t1,1
   102a6:	a805                	j	102d6 <vsnprintf+0xdc>
   102a8:	6722                	ld	a4,8(sp)
   102aa:	00870693          	addi	a3,a4,8
   102ae:	e436                	sd	a3,8(sp)
   102b0:	00072883          	lw	a7,0(a4)
   102b4:	b7ed                	j	1029e <vsnprintf+0xa4>
   102b6:	411008b3          	neg	a7,a7
   102ba:	00178713          	addi	a4,a5,1
   102be:	00b77963          	bgeu	a4,a1,102d0 <vsnprintf+0xd6>
   102c2:	97aa                	add	a5,a5,a0
   102c4:	02d00693          	li	a3,45
   102c8:	00d78023          	sb	a3,0(a5)
   102cc:	87ba                	mv	a5,a4
   102ce:	bfd1                	j	102a2 <vsnprintf+0xa8>
   102d0:	87ba                	mv	a5,a4
   102d2:	bfc1                	j	102a2 <vsnprintf+0xa8>
   102d4:	0305                	addi	t1,t1,1
   102d6:	46a9                	li	a3,10
   102d8:	02d74733          	div	a4,a4,a3
   102dc:	ff65                	bnez	a4,102d4 <vsnprintf+0xda>
   102de:	fff3071b          	addiw	a4,t1,-1
   102e2:	a029                	j	102ec <vsnprintf+0xf2>
   102e4:	46a9                	li	a3,10
   102e6:	02d8c8b3          	div	a7,a7,a3
   102ea:	377d                	addiw	a4,a4,-1
   102ec:	02074163          	bltz	a4,1030e <vsnprintf+0x114>
   102f0:	00f706b3          	add	a3,a4,a5
   102f4:	00168813          	addi	a6,a3,1
   102f8:	feb876e3          	bgeu	a6,a1,102e4 <vsnprintf+0xea>
   102fc:	4829                	li	a6,10
   102fe:	0308e833          	rem	a6,a7,a6
   10302:	96aa                	add	a3,a3,a0
   10304:	0308081b          	addiw	a6,a6,48
   10308:	01068023          	sb	a6,0(a3)
   1030c:	bfe1                	j	102e4 <vsnprintf+0xea>
   1030e:	979a                	add	a5,a5,t1
   10310:	4301                	li	t1,0
   10312:	4681                	li	a3,0
   10314:	a8ad                	j	1038e <vsnprintf+0x194>
   10316:	6722                	ld	a4,8(sp)
   10318:	00870693          	addi	a3,a4,8
   1031c:	e436                	sd	a3,8(sp)
   1031e:	6318                	ld	a4,0(a4)
   10320:	a019                	j	10326 <vsnprintf+0x12c>
   10322:	0705                	addi	a4,a4,1
   10324:	87b6                	mv	a5,a3
   10326:	00074803          	lbu	a6,0(a4)
   1032a:	00080a63          	beqz	a6,1033e <vsnprintf+0x144>
   1032e:	00178693          	addi	a3,a5,1
   10332:	feb6f8e3          	bgeu	a3,a1,10322 <vsnprintf+0x128>
   10336:	97aa                	add	a5,a5,a0
   10338:	01078023          	sb	a6,0(a5)
   1033c:	b7dd                	j	10322 <vsnprintf+0x128>
   1033e:	4301                	li	t1,0
   10340:	4681                	li	a3,0
   10342:	a0b1                	j	1038e <vsnprintf+0x194>
   10344:	00178713          	addi	a4,a5,1
   10348:	02b77e63          	bgeu	a4,a1,10384 <vsnprintf+0x18a>
   1034c:	66a2                	ld	a3,8(sp)
   1034e:	00868813          	addi	a6,a3,8
   10352:	e442                	sd	a6,8(sp)
   10354:	97aa                	add	a5,a5,a0
   10356:	0006c683          	lbu	a3,0(a3)
   1035a:	00d78023          	sb	a3,0(a5)
   1035e:	87ba                	mv	a5,a4
   10360:	4301                	li	t1,0
   10362:	4681                	li	a3,0
   10364:	a02d                	j	1038e <vsnprintf+0x194>
   10366:	02500813          	li	a6,37
   1036a:	03070163          	beq	a4,a6,1038c <vsnprintf+0x192>
   1036e:	00178813          	addi	a6,a5,1
   10372:	04b87463          	bgeu	a6,a1,103ba <vsnprintf+0x1c0>
   10376:	97aa                	add	a5,a5,a0
   10378:	00e78023          	sb	a4,0(a5)
   1037c:	87c2                	mv	a5,a6
   1037e:	a801                	j	1038e <vsnprintf+0x194>
   10380:	8336                	mv	t1,a3
   10382:	a031                	j	1038e <vsnprintf+0x194>
   10384:	87ba                	mv	a5,a4
   10386:	4301                	li	t1,0
   10388:	4681                	li	a3,0
   1038a:	a011                	j	1038e <vsnprintf+0x194>
   1038c:	4685                	li	a3,1
   1038e:	0605                	addi	a2,a2,1
   10390:	00064703          	lbu	a4,0(a2)
   10394:	c70d                	beqz	a4,103be <vsnprintf+0x1c4>
   10396:	dae1                	beqz	a3,10366 <vsnprintf+0x16c>
   10398:	f9d7071b          	addiw	a4,a4,-99
   1039c:	0ff77893          	zext.b	a7,a4
   103a0:	4855                	li	a6,21
   103a2:	ff1866e3          	bltu	a6,a7,1038e <vsnprintf+0x194>
   103a6:	00289713          	slli	a4,a7,0x2
   103aa:	00000817          	auipc	a6,0x0
   103ae:	0fa80813          	addi	a6,a6,250 # 104a4 <vsnprintf+0x2aa>
   103b2:	9742                	add	a4,a4,a6
   103b4:	4318                	lw	a4,0(a4)
   103b6:	9742                	add	a4,a4,a6
   103b8:	8702                	jr	a4
   103ba:	87c2                	mv	a5,a6
   103bc:	bfc9                	j	1038e <vsnprintf+0x194>
   103be:	00b7f963          	bgeu	a5,a1,103d0 <vsnprintf+0x1d6>
   103c2:	953e                	add	a0,a0,a5
   103c4:	00050023          	sb	zero,0(a0)
   103c8:	0007851b          	sext.w	a0,a5
   103cc:	0141                	addi	sp,sp,16
   103ce:	8082                	ret
   103d0:	dde5                	beqz	a1,103c8 <vsnprintf+0x1ce>
   103d2:	15fd                	addi	a1,a1,-1
   103d4:	952e                	add	a0,a0,a1
   103d6:	00050023          	sb	zero,0(a0)
   103da:	b7fd                	j	103c8 <vsnprintf+0x1ce>
