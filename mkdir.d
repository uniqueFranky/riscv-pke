
hostfs_root/bin/app_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000010078 <main>:
   10078:	1141                	addi	sp,sp,-16
   1007a:	e406                	sd	ra,8(sp)
   1007c:	e022                	sd	s0,0(sp)
   1007e:	6180                	ld	s0,0(a1)
   10080:	00000517          	auipc	a0,0x0
   10084:	51850513          	addi	a0,a0,1304 # 10598 <vsnprintf+0x1e6>
   10088:	036000ef          	jal	ra,100be <printu>
   1008c:	8522                	mv	a0,s0
   1008e:	236000ef          	jal	ra,102c4 <mkdir_u>
   10092:	85a2                	mv	a1,s0
   10094:	00000517          	auipc	a0,0x0
   10098:	52c50513          	addi	a0,a0,1324 # 105c0 <vsnprintf+0x20e>
   1009c:	022000ef          	jal	ra,100be <printu>
   100a0:	4501                	li	a0,0
   100a2:	06e000ef          	jal	ra,10110 <exit>
   100a6:	4501                	li	a0,0
   100a8:	60a2                	ld	ra,8(sp)
   100aa:	6402                	ld	s0,0(sp)
   100ac:	0141                	addi	sp,sp,16
   100ae:	8082                	ret

00000000000100b0 <do_user_call>:
   100b0:	1141                	addi	sp,sp,-16
   100b2:	00000073          	ecall
   100b6:	c62a                	sw	a0,12(sp)
   100b8:	4532                	lw	a0,12(sp)
   100ba:	0141                	addi	sp,sp,16
   100bc:	8082                	ret

00000000000100be <printu>:
   100be:	710d                	addi	sp,sp,-352
   100c0:	ee06                	sd	ra,280(sp)
   100c2:	f62e                	sd	a1,296(sp)
   100c4:	fa32                	sd	a2,304(sp)
   100c6:	fe36                	sd	a3,312(sp)
   100c8:	e2ba                	sd	a4,320(sp)
   100ca:	e6be                	sd	a5,328(sp)
   100cc:	eac2                	sd	a6,336(sp)
   100ce:	eec6                	sd	a7,344(sp)
   100d0:	1234                	addi	a3,sp,296
   100d2:	e636                	sd	a3,264(sp)
   100d4:	862a                	mv	a2,a0
   100d6:	10000593          	li	a1,256
   100da:	0028                	addi	a0,sp,8
   100dc:	2d6000ef          	jal	ra,103b2 <vsnprintf>
   100e0:	0005071b          	sext.w	a4,a0
   100e4:	0ff00793          	li	a5,255
   100e8:	02e7e163          	bltu	a5,a4,1010a <printu+0x4c>
   100ec:	862a                	mv	a2,a0
   100ee:	4881                	li	a7,0
   100f0:	4801                	li	a6,0
   100f2:	4781                	li	a5,0
   100f4:	4701                	li	a4,0
   100f6:	4681                	li	a3,0
   100f8:	002c                	addi	a1,sp,8
   100fa:	04000513          	li	a0,64
   100fe:	fb3ff0ef          	jal	ra,100b0 <do_user_call>
   10102:	2501                	sext.w	a0,a0
   10104:	60f2                	ld	ra,280(sp)
   10106:	6135                	addi	sp,sp,352
   10108:	8082                	ret
   1010a:	10000613          	li	a2,256
   1010e:	b7c5                	j	100ee <printu+0x30>

0000000000010110 <exit>:
   10110:	1141                	addi	sp,sp,-16
   10112:	e406                	sd	ra,8(sp)
   10114:	85aa                	mv	a1,a0
   10116:	4881                	li	a7,0
   10118:	4801                	li	a6,0
   1011a:	4781                	li	a5,0
   1011c:	4701                	li	a4,0
   1011e:	4681                	li	a3,0
   10120:	4601                	li	a2,0
   10122:	04100513          	li	a0,65
   10126:	f8bff0ef          	jal	ra,100b0 <do_user_call>
   1012a:	2501                	sext.w	a0,a0
   1012c:	60a2                	ld	ra,8(sp)
   1012e:	0141                	addi	sp,sp,16
   10130:	8082                	ret

0000000000010132 <naive_malloc>:
   10132:	1141                	addi	sp,sp,-16
   10134:	e406                	sd	ra,8(sp)
   10136:	4881                	li	a7,0
   10138:	4801                	li	a6,0
   1013a:	4781                	li	a5,0
   1013c:	4701                	li	a4,0
   1013e:	4681                	li	a3,0
   10140:	4601                	li	a2,0
   10142:	4581                	li	a1,0
   10144:	04200513          	li	a0,66
   10148:	f69ff0ef          	jal	ra,100b0 <do_user_call>
   1014c:	60a2                	ld	ra,8(sp)
   1014e:	0141                	addi	sp,sp,16
   10150:	8082                	ret

0000000000010152 <naive_free>:
   10152:	1141                	addi	sp,sp,-16
   10154:	e406                	sd	ra,8(sp)
   10156:	85aa                	mv	a1,a0
   10158:	4881                	li	a7,0
   1015a:	4801                	li	a6,0
   1015c:	4781                	li	a5,0
   1015e:	4701                	li	a4,0
   10160:	4681                	li	a3,0
   10162:	4601                	li	a2,0
   10164:	04300513          	li	a0,67
   10168:	f49ff0ef          	jal	ra,100b0 <do_user_call>
   1016c:	60a2                	ld	ra,8(sp)
   1016e:	0141                	addi	sp,sp,16
   10170:	8082                	ret

0000000000010172 <fork>:
   10172:	1141                	addi	sp,sp,-16
   10174:	e406                	sd	ra,8(sp)
   10176:	4881                	li	a7,0
   10178:	4801                	li	a6,0
   1017a:	4781                	li	a5,0
   1017c:	4701                	li	a4,0
   1017e:	4681                	li	a3,0
   10180:	4601                	li	a2,0
   10182:	4581                	li	a1,0
   10184:	04400513          	li	a0,68
   10188:	f29ff0ef          	jal	ra,100b0 <do_user_call>
   1018c:	2501                	sext.w	a0,a0
   1018e:	60a2                	ld	ra,8(sp)
   10190:	0141                	addi	sp,sp,16
   10192:	8082                	ret

0000000000010194 <yield>:
   10194:	1141                	addi	sp,sp,-16
   10196:	e406                	sd	ra,8(sp)
   10198:	4881                	li	a7,0
   1019a:	4801                	li	a6,0
   1019c:	4781                	li	a5,0
   1019e:	4701                	li	a4,0
   101a0:	4681                	li	a3,0
   101a2:	4601                	li	a2,0
   101a4:	4581                	li	a1,0
   101a6:	04500513          	li	a0,69
   101aa:	f07ff0ef          	jal	ra,100b0 <do_user_call>
   101ae:	60a2                	ld	ra,8(sp)
   101b0:	0141                	addi	sp,sp,16
   101b2:	8082                	ret

00000000000101b4 <open>:
   101b4:	1141                	addi	sp,sp,-16
   101b6:	e406                	sd	ra,8(sp)
   101b8:	862e                	mv	a2,a1
   101ba:	4881                	li	a7,0
   101bc:	4801                	li	a6,0
   101be:	4781                	li	a5,0
   101c0:	4701                	li	a4,0
   101c2:	4681                	li	a3,0
   101c4:	85aa                	mv	a1,a0
   101c6:	05100513          	li	a0,81
   101ca:	ee7ff0ef          	jal	ra,100b0 <do_user_call>
   101ce:	2501                	sext.w	a0,a0
   101d0:	60a2                	ld	ra,8(sp)
   101d2:	0141                	addi	sp,sp,16
   101d4:	8082                	ret

00000000000101d6 <read_u>:
   101d6:	1141                	addi	sp,sp,-16
   101d8:	e406                	sd	ra,8(sp)
   101da:	86b2                	mv	a3,a2
   101dc:	4881                	li	a7,0
   101de:	4801                	li	a6,0
   101e0:	4781                	li	a5,0
   101e2:	4701                	li	a4,0
   101e4:	862e                	mv	a2,a1
   101e6:	85aa                	mv	a1,a0
   101e8:	05200513          	li	a0,82
   101ec:	ec5ff0ef          	jal	ra,100b0 <do_user_call>
   101f0:	2501                	sext.w	a0,a0
   101f2:	60a2                	ld	ra,8(sp)
   101f4:	0141                	addi	sp,sp,16
   101f6:	8082                	ret

00000000000101f8 <write_u>:
   101f8:	1141                	addi	sp,sp,-16
   101fa:	e406                	sd	ra,8(sp)
   101fc:	86b2                	mv	a3,a2
   101fe:	4881                	li	a7,0
   10200:	4801                	li	a6,0
   10202:	4781                	li	a5,0
   10204:	4701                	li	a4,0
   10206:	862e                	mv	a2,a1
   10208:	85aa                	mv	a1,a0
   1020a:	05300513          	li	a0,83
   1020e:	ea3ff0ef          	jal	ra,100b0 <do_user_call>
   10212:	2501                	sext.w	a0,a0
   10214:	60a2                	ld	ra,8(sp)
   10216:	0141                	addi	sp,sp,16
   10218:	8082                	ret

000000000001021a <lseek_u>:
   1021a:	1141                	addi	sp,sp,-16
   1021c:	e406                	sd	ra,8(sp)
   1021e:	86b2                	mv	a3,a2
   10220:	4881                	li	a7,0
   10222:	4801                	li	a6,0
   10224:	4781                	li	a5,0
   10226:	4701                	li	a4,0
   10228:	862e                	mv	a2,a1
   1022a:	85aa                	mv	a1,a0
   1022c:	05400513          	li	a0,84
   10230:	e81ff0ef          	jal	ra,100b0 <do_user_call>
   10234:	2501                	sext.w	a0,a0
   10236:	60a2                	ld	ra,8(sp)
   10238:	0141                	addi	sp,sp,16
   1023a:	8082                	ret

000000000001023c <stat_u>:
   1023c:	1141                	addi	sp,sp,-16
   1023e:	e406                	sd	ra,8(sp)
   10240:	862e                	mv	a2,a1
   10242:	4881                	li	a7,0
   10244:	4801                	li	a6,0
   10246:	4781                	li	a5,0
   10248:	4701                	li	a4,0
   1024a:	4681                	li	a3,0
   1024c:	85aa                	mv	a1,a0
   1024e:	05500513          	li	a0,85
   10252:	e5fff0ef          	jal	ra,100b0 <do_user_call>
   10256:	2501                	sext.w	a0,a0
   10258:	60a2                	ld	ra,8(sp)
   1025a:	0141                	addi	sp,sp,16
   1025c:	8082                	ret

000000000001025e <disk_stat_u>:
   1025e:	1141                	addi	sp,sp,-16
   10260:	e406                	sd	ra,8(sp)
   10262:	862e                	mv	a2,a1
   10264:	4881                	li	a7,0
   10266:	4801                	li	a6,0
   10268:	4781                	li	a5,0
   1026a:	4701                	li	a4,0
   1026c:	4681                	li	a3,0
   1026e:	85aa                	mv	a1,a0
   10270:	05600513          	li	a0,86
   10274:	e3dff0ef          	jal	ra,100b0 <do_user_call>
   10278:	2501                	sext.w	a0,a0
   1027a:	60a2                	ld	ra,8(sp)
   1027c:	0141                	addi	sp,sp,16
   1027e:	8082                	ret

0000000000010280 <opendir_u>:
   10280:	1141                	addi	sp,sp,-16
   10282:	e406                	sd	ra,8(sp)
   10284:	85aa                	mv	a1,a0
   10286:	4881                	li	a7,0
   10288:	4801                	li	a6,0
   1028a:	4781                	li	a5,0
   1028c:	4701                	li	a4,0
   1028e:	4681                	li	a3,0
   10290:	4601                	li	a2,0
   10292:	05800513          	li	a0,88
   10296:	e1bff0ef          	jal	ra,100b0 <do_user_call>
   1029a:	2501                	sext.w	a0,a0
   1029c:	60a2                	ld	ra,8(sp)
   1029e:	0141                	addi	sp,sp,16
   102a0:	8082                	ret

00000000000102a2 <readdir_u>:
   102a2:	1141                	addi	sp,sp,-16
   102a4:	e406                	sd	ra,8(sp)
   102a6:	862e                	mv	a2,a1
   102a8:	4881                	li	a7,0
   102aa:	4801                	li	a6,0
   102ac:	4781                	li	a5,0
   102ae:	4701                	li	a4,0
   102b0:	4681                	li	a3,0
   102b2:	85aa                	mv	a1,a0
   102b4:	05900513          	li	a0,89
   102b8:	df9ff0ef          	jal	ra,100b0 <do_user_call>
   102bc:	2501                	sext.w	a0,a0
   102be:	60a2                	ld	ra,8(sp)
   102c0:	0141                	addi	sp,sp,16
   102c2:	8082                	ret

00000000000102c4 <mkdir_u>:
   102c4:	1141                	addi	sp,sp,-16
   102c6:	e406                	sd	ra,8(sp)
   102c8:	85aa                	mv	a1,a0
   102ca:	4881                	li	a7,0
   102cc:	4801                	li	a6,0
   102ce:	4781                	li	a5,0
   102d0:	4701                	li	a4,0
   102d2:	4681                	li	a3,0
   102d4:	4601                	li	a2,0
   102d6:	05a00513          	li	a0,90
   102da:	dd7ff0ef          	jal	ra,100b0 <do_user_call>
   102de:	2501                	sext.w	a0,a0
   102e0:	60a2                	ld	ra,8(sp)
   102e2:	0141                	addi	sp,sp,16
   102e4:	8082                	ret

00000000000102e6 <closedir_u>:
   102e6:	1141                	addi	sp,sp,-16
   102e8:	e406                	sd	ra,8(sp)
   102ea:	85aa                	mv	a1,a0
   102ec:	4881                	li	a7,0
   102ee:	4801                	li	a6,0
   102f0:	4781                	li	a5,0
   102f2:	4701                	li	a4,0
   102f4:	4681                	li	a3,0
   102f6:	4601                	li	a2,0
   102f8:	05b00513          	li	a0,91
   102fc:	db5ff0ef          	jal	ra,100b0 <do_user_call>
   10300:	2501                	sext.w	a0,a0
   10302:	60a2                	ld	ra,8(sp)
   10304:	0141                	addi	sp,sp,16
   10306:	8082                	ret

0000000000010308 <link_u>:
   10308:	1141                	addi	sp,sp,-16
   1030a:	e406                	sd	ra,8(sp)
   1030c:	862e                	mv	a2,a1
   1030e:	4881                	li	a7,0
   10310:	4801                	li	a6,0
   10312:	4781                	li	a5,0
   10314:	4701                	li	a4,0
   10316:	4681                	li	a3,0
   10318:	85aa                	mv	a1,a0
   1031a:	05c00513          	li	a0,92
   1031e:	d93ff0ef          	jal	ra,100b0 <do_user_call>
   10322:	2501                	sext.w	a0,a0
   10324:	60a2                	ld	ra,8(sp)
   10326:	0141                	addi	sp,sp,16
   10328:	8082                	ret

000000000001032a <unlink_u>:
   1032a:	1141                	addi	sp,sp,-16
   1032c:	e406                	sd	ra,8(sp)
   1032e:	85aa                	mv	a1,a0
   10330:	4881                	li	a7,0
   10332:	4801                	li	a6,0
   10334:	4781                	li	a5,0
   10336:	4701                	li	a4,0
   10338:	4681                	li	a3,0
   1033a:	4601                	li	a2,0
   1033c:	05d00513          	li	a0,93
   10340:	d71ff0ef          	jal	ra,100b0 <do_user_call>
   10344:	2501                	sext.w	a0,a0
   10346:	60a2                	ld	ra,8(sp)
   10348:	0141                	addi	sp,sp,16
   1034a:	8082                	ret

000000000001034c <close>:
   1034c:	1141                	addi	sp,sp,-16
   1034e:	e406                	sd	ra,8(sp)
   10350:	85aa                	mv	a1,a0
   10352:	4881                	li	a7,0
   10354:	4801                	li	a6,0
   10356:	4781                	li	a5,0
   10358:	4701                	li	a4,0
   1035a:	4681                	li	a3,0
   1035c:	4601                	li	a2,0
   1035e:	05700513          	li	a0,87
   10362:	d4fff0ef          	jal	ra,100b0 <do_user_call>
   10366:	2501                	sext.w	a0,a0
   10368:	60a2                	ld	ra,8(sp)
   1036a:	0141                	addi	sp,sp,16
   1036c:	8082                	ret

000000000001036e <wait>:
   1036e:	1141                	addi	sp,sp,-16
   10370:	e406                	sd	ra,8(sp)
   10372:	85aa                	mv	a1,a0
   10374:	4881                	li	a7,0
   10376:	4801                	li	a6,0
   10378:	4781                	li	a5,0
   1037a:	4701                	li	a4,0
   1037c:	4681                	li	a3,0
   1037e:	4601                	li	a2,0
   10380:	04600513          	li	a0,70
   10384:	d2dff0ef          	jal	ra,100b0 <do_user_call>
   10388:	2501                	sext.w	a0,a0
   1038a:	60a2                	ld	ra,8(sp)
   1038c:	0141                	addi	sp,sp,16
   1038e:	8082                	ret

0000000000010390 <exec>:
   10390:	1141                	addi	sp,sp,-16
   10392:	e406                	sd	ra,8(sp)
   10394:	862e                	mv	a2,a1
   10396:	4881                	li	a7,0
   10398:	4801                	li	a6,0
   1039a:	4781                	li	a5,0
   1039c:	4701                	li	a4,0
   1039e:	4681                	li	a3,0
   103a0:	85aa                	mv	a1,a0
   103a2:	05e00513          	li	a0,94
   103a6:	d0bff0ef          	jal	ra,100b0 <do_user_call>
   103aa:	2501                	sext.w	a0,a0
   103ac:	60a2                	ld	ra,8(sp)
   103ae:	0141                	addi	sp,sp,16
   103b0:	8082                	ret

00000000000103b2 <vsnprintf>:
   103b2:	1141                	addi	sp,sp,-16
   103b4:	e436                	sd	a3,8(sp)
   103b6:	4781                	li	a5,0
   103b8:	4301                	li	t1,0
   103ba:	4681                	li	a3,0
   103bc:	a271                	j	10548 <vsnprintf+0x196>
   103be:	00178713          	addi	a4,a5,1
   103c2:	00b77863          	bgeu	a4,a1,103d2 <vsnprintf+0x20>
   103c6:	00f50833          	add	a6,a0,a5
   103ca:	03000893          	li	a7,48
   103ce:	01180023          	sb	a7,0(a6)
   103d2:	0789                	addi	a5,a5,2
   103d4:	00b7f763          	bgeu	a5,a1,103e2 <vsnprintf+0x30>
   103d8:	972a                	add	a4,a4,a0
   103da:	07800813          	li	a6,120
   103de:	01070023          	sb	a6,0(a4)
   103e2:	6722                	ld	a4,8(sp)
   103e4:	00870813          	addi	a6,a4,8
   103e8:	e442                	sd	a6,8(sp)
   103ea:	00073883          	ld	a7,0(a4)
   103ee:	e6b9                	bnez	a3,1043c <vsnprintf+0x8a>
   103f0:	469d                	li	a3,7
   103f2:	a025                	j	1041a <vsnprintf+0x68>
   103f4:	00030463          	beqz	t1,103fc <vsnprintf+0x4a>
   103f8:	869a                	mv	a3,t1
   103fa:	b7e5                	j	103e2 <vsnprintf+0x30>
   103fc:	6722                	ld	a4,8(sp)
   103fe:	00870693          	addi	a3,a4,8
   10402:	e436                	sd	a3,8(sp)
   10404:	00072883          	lw	a7,0(a4)
   10408:	869a                	mv	a3,t1
   1040a:	b7d5                	j	103ee <vsnprintf+0x3c>
   1040c:	05770713          	addi	a4,a4,87
   10410:	97aa                	add	a5,a5,a0
   10412:	00e78023          	sb	a4,0(a5)
   10416:	36fd                	addiw	a3,a3,-1
   10418:	87c2                	mv	a5,a6
   1041a:	0206c363          	bltz	a3,10440 <vsnprintf+0x8e>
   1041e:	0026971b          	slliw	a4,a3,0x2
   10422:	40e8d733          	sra	a4,a7,a4
   10426:	8b3d                	andi	a4,a4,15
   10428:	00178813          	addi	a6,a5,1
   1042c:	feb875e3          	bgeu	a6,a1,10416 <vsnprintf+0x64>
   10430:	4325                	li	t1,9
   10432:	fce34de3          	blt	t1,a4,1040c <vsnprintf+0x5a>
   10436:	03070713          	addi	a4,a4,48
   1043a:	bfd9                	j	10410 <vsnprintf+0x5e>
   1043c:	46bd                	li	a3,15
   1043e:	bff1                	j	1041a <vsnprintf+0x68>
   10440:	4301                	li	t1,0
   10442:	4681                	li	a3,0
   10444:	a209                	j	10546 <vsnprintf+0x194>
   10446:	00030d63          	beqz	t1,10460 <vsnprintf+0xae>
   1044a:	6722                	ld	a4,8(sp)
   1044c:	00870693          	addi	a3,a4,8
   10450:	e436                	sd	a3,8(sp)
   10452:	00073883          	ld	a7,0(a4)
   10456:	0008cc63          	bltz	a7,1046e <vsnprintf+0xbc>
   1045a:	8746                	mv	a4,a7
   1045c:	4305                	li	t1,1
   1045e:	a805                	j	1048e <vsnprintf+0xdc>
   10460:	6722                	ld	a4,8(sp)
   10462:	00870693          	addi	a3,a4,8
   10466:	e436                	sd	a3,8(sp)
   10468:	00072883          	lw	a7,0(a4)
   1046c:	b7ed                	j	10456 <vsnprintf+0xa4>
   1046e:	411008b3          	neg	a7,a7
   10472:	00178713          	addi	a4,a5,1
   10476:	00b77963          	bgeu	a4,a1,10488 <vsnprintf+0xd6>
   1047a:	97aa                	add	a5,a5,a0
   1047c:	02d00693          	li	a3,45
   10480:	00d78023          	sb	a3,0(a5)
   10484:	87ba                	mv	a5,a4
   10486:	bfd1                	j	1045a <vsnprintf+0xa8>
   10488:	87ba                	mv	a5,a4
   1048a:	bfc1                	j	1045a <vsnprintf+0xa8>
   1048c:	0305                	addi	t1,t1,1
   1048e:	46a9                	li	a3,10
   10490:	02d74733          	div	a4,a4,a3
   10494:	ff65                	bnez	a4,1048c <vsnprintf+0xda>
   10496:	fff3071b          	addiw	a4,t1,-1
   1049a:	a029                	j	104a4 <vsnprintf+0xf2>
   1049c:	46a9                	li	a3,10
   1049e:	02d8c8b3          	div	a7,a7,a3
   104a2:	377d                	addiw	a4,a4,-1
   104a4:	02074163          	bltz	a4,104c6 <vsnprintf+0x114>
   104a8:	00f706b3          	add	a3,a4,a5
   104ac:	00168813          	addi	a6,a3,1
   104b0:	feb876e3          	bgeu	a6,a1,1049c <vsnprintf+0xea>
   104b4:	4829                	li	a6,10
   104b6:	0308e833          	rem	a6,a7,a6
   104ba:	96aa                	add	a3,a3,a0
   104bc:	0308081b          	addiw	a6,a6,48
   104c0:	01068023          	sb	a6,0(a3)
   104c4:	bfe1                	j	1049c <vsnprintf+0xea>
   104c6:	979a                	add	a5,a5,t1
   104c8:	4301                	li	t1,0
   104ca:	4681                	li	a3,0
   104cc:	a8ad                	j	10546 <vsnprintf+0x194>
   104ce:	6722                	ld	a4,8(sp)
   104d0:	00870693          	addi	a3,a4,8
   104d4:	e436                	sd	a3,8(sp)
   104d6:	6318                	ld	a4,0(a4)
   104d8:	a019                	j	104de <vsnprintf+0x12c>
   104da:	0705                	addi	a4,a4,1
   104dc:	87b6                	mv	a5,a3
   104de:	00074803          	lbu	a6,0(a4)
   104e2:	00080a63          	beqz	a6,104f6 <vsnprintf+0x144>
   104e6:	00178693          	addi	a3,a5,1
   104ea:	feb6f8e3          	bgeu	a3,a1,104da <vsnprintf+0x128>
   104ee:	97aa                	add	a5,a5,a0
   104f0:	01078023          	sb	a6,0(a5)
   104f4:	b7dd                	j	104da <vsnprintf+0x128>
   104f6:	4301                	li	t1,0
   104f8:	4681                	li	a3,0
   104fa:	a0b1                	j	10546 <vsnprintf+0x194>
   104fc:	00178713          	addi	a4,a5,1
   10500:	02b77e63          	bgeu	a4,a1,1053c <vsnprintf+0x18a>
   10504:	66a2                	ld	a3,8(sp)
   10506:	00868813          	addi	a6,a3,8
   1050a:	e442                	sd	a6,8(sp)
   1050c:	97aa                	add	a5,a5,a0
   1050e:	0006c683          	lbu	a3,0(a3)
   10512:	00d78023          	sb	a3,0(a5)
   10516:	87ba                	mv	a5,a4
   10518:	4301                	li	t1,0
   1051a:	4681                	li	a3,0
   1051c:	a02d                	j	10546 <vsnprintf+0x194>
   1051e:	02500813          	li	a6,37
   10522:	03070163          	beq	a4,a6,10544 <vsnprintf+0x192>
   10526:	00178813          	addi	a6,a5,1
   1052a:	04b87463          	bgeu	a6,a1,10572 <vsnprintf+0x1c0>
   1052e:	97aa                	add	a5,a5,a0
   10530:	00e78023          	sb	a4,0(a5)
   10534:	87c2                	mv	a5,a6
   10536:	a801                	j	10546 <vsnprintf+0x194>
   10538:	8336                	mv	t1,a3
   1053a:	a031                	j	10546 <vsnprintf+0x194>
   1053c:	87ba                	mv	a5,a4
   1053e:	4301                	li	t1,0
   10540:	4681                	li	a3,0
   10542:	a011                	j	10546 <vsnprintf+0x194>
   10544:	4685                	li	a3,1
   10546:	0605                	addi	a2,a2,1
   10548:	00064703          	lbu	a4,0(a2)
   1054c:	c70d                	beqz	a4,10576 <vsnprintf+0x1c4>
   1054e:	dae1                	beqz	a3,1051e <vsnprintf+0x16c>
   10550:	f9d7071b          	addiw	a4,a4,-99
   10554:	0ff77893          	zext.b	a7,a4
   10558:	4855                	li	a6,21
   1055a:	ff1866e3          	bltu	a6,a7,10546 <vsnprintf+0x194>
   1055e:	00289713          	slli	a4,a7,0x2
   10562:	00000817          	auipc	a6,0x0
   10566:	06a80813          	addi	a6,a6,106 # 105cc <vsnprintf+0x21a>
   1056a:	9742                	add	a4,a4,a6
   1056c:	4318                	lw	a4,0(a4)
   1056e:	9742                	add	a4,a4,a6
   10570:	8702                	jr	a4
   10572:	87c2                	mv	a5,a6
   10574:	bfc9                	j	10546 <vsnprintf+0x194>
   10576:	00b7f963          	bgeu	a5,a1,10588 <vsnprintf+0x1d6>
   1057a:	953e                	add	a0,a0,a5
   1057c:	00050023          	sb	zero,0(a0)
   10580:	0007851b          	sext.w	a0,a5
   10584:	0141                	addi	sp,sp,16
   10586:	8082                	ret
   10588:	dde5                	beqz	a1,10580 <vsnprintf+0x1ce>
   1058a:	15fd                	addi	a1,a1,-1
   1058c:	952e                	add	a0,a0,a1
   1058e:	00050023          	sb	zero,0(a0)
   10592:	b7fd                	j	10580 <vsnprintf+0x1ce>
