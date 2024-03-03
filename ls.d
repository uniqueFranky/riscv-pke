
hostfs_root/bin/app_ls:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <main>:
   100b0:	711d                	addi	sp,sp,-96
   100b2:	ec86                	sd	ra,88(sp)
   100b4:	e8a2                	sd	s0,80(sp)
   100b6:	e4a6                	sd	s1,72(sp)
   100b8:	e0ca                	sd	s2,64(sp)
   100ba:	1080                	addi	s0,sp,96
   100bc:	0005b903          	ld	s2,0(a1)
   100c0:	854a                	mv	a0,s2
   100c2:	2a0000ef          	jal	ra,10362 <opendir_u>
   100c6:	84aa                	mv	s1,a0
   100c8:	00000517          	auipc	a0,0x0
   100cc:	7f050513          	addi	a0,a0,2032 # 108b8 <safestrcpy+0x2e>
   100d0:	0d0000ef          	jal	ra,101a0 <printu>
   100d4:	85ca                	mv	a1,s2
   100d6:	00001517          	auipc	a0,0x1
   100da:	80a50513          	addi	a0,a0,-2038 # 108e0 <safestrcpy+0x56>
   100de:	0c2000ef          	jal	ra,101a0 <printu>
   100e2:	00001517          	auipc	a0,0x1
   100e6:	80e50513          	addi	a0,a0,-2034 # 108f0 <safestrcpy+0x66>
   100ea:	0b6000ef          	jal	ra,101a0 <printu>
   100ee:	a821                	j	10106 <main+0x56>
   100f0:	fc042603          	lw	a2,-64(s0)
   100f4:	fa040593          	addi	a1,s0,-96
   100f8:	00001517          	auipc	a0,0x1
   100fc:	82050513          	addi	a0,a0,-2016 # 10918 <safestrcpy+0x8e>
   10100:	0a0000ef          	jal	ra,101a0 <printu>
   10104:	814a                	mv	sp,s2
   10106:	fa040593          	addi	a1,s0,-96
   1010a:	8526                	mv	a0,s1
   1010c:	278000ef          	jal	ra,10384 <readdir_u>
   10110:	ed31                	bnez	a0,1016c <main+0xbc>
   10112:	890a                	mv	s2,sp
   10114:	4655                	li	a2,21
   10116:	02000593          	li	a1,32
   1011a:	fc840513          	addi	a0,s0,-56
   1011e:	590000ef          	jal	ra,106ae <memset>
   10122:	fc040e23          	sb	zero,-36(s0)
   10126:	fa040513          	addi	a0,s0,-96
   1012a:	5c8000ef          	jal	ra,106f2 <strlen>
   1012e:	47cd                	li	a5,19
   10130:	fca7e0e3          	bltu	a5,a0,100f0 <main+0x40>
   10134:	fa040593          	addi	a1,s0,-96
   10138:	fc840513          	addi	a0,s0,-56
   1013c:	5e0000ef          	jal	ra,1071c <strcpy>
   10140:	fa040513          	addi	a0,s0,-96
   10144:	5ae000ef          	jal	ra,106f2 <strlen>
   10148:	fe050793          	addi	a5,a0,-32
   1014c:	97a2                	add	a5,a5,s0
   1014e:	02000713          	li	a4,32
   10152:	fee78423          	sb	a4,-24(a5)
   10156:	fc042603          	lw	a2,-64(s0)
   1015a:	fc840593          	addi	a1,s0,-56
   1015e:	00000517          	auipc	a0,0x0
   10162:	7ba50513          	addi	a0,a0,1978 # 10918 <safestrcpy+0x8e>
   10166:	03a000ef          	jal	ra,101a0 <printu>
   1016a:	bf69                	j	10104 <main+0x54>
   1016c:	00000517          	auipc	a0,0x0
   10170:	7b450513          	addi	a0,a0,1972 # 10920 <safestrcpy+0x96>
   10174:	02c000ef          	jal	ra,101a0 <printu>
   10178:	8526                	mv	a0,s1
   1017a:	24e000ef          	jal	ra,103c8 <closedir_u>
   1017e:	4501                	li	a0,0
   10180:	072000ef          	jal	ra,101f2 <exit>
   10184:	4501                	li	a0,0
   10186:	60e6                	ld	ra,88(sp)
   10188:	6446                	ld	s0,80(sp)
   1018a:	64a6                	ld	s1,72(sp)
   1018c:	6906                	ld	s2,64(sp)
   1018e:	6125                	addi	sp,sp,96
   10190:	8082                	ret

0000000000010192 <do_user_call>:
   10192:	1141                	addi	sp,sp,-16
   10194:	00000073          	ecall
   10198:	c62a                	sw	a0,12(sp)
   1019a:	4532                	lw	a0,12(sp)
   1019c:	0141                	addi	sp,sp,16
   1019e:	8082                	ret

00000000000101a0 <printu>:
   101a0:	710d                	addi	sp,sp,-352
   101a2:	ee06                	sd	ra,280(sp)
   101a4:	f62e                	sd	a1,296(sp)
   101a6:	fa32                	sd	a2,304(sp)
   101a8:	fe36                	sd	a3,312(sp)
   101aa:	e2ba                	sd	a4,320(sp)
   101ac:	e6be                	sd	a5,328(sp)
   101ae:	eac2                	sd	a6,336(sp)
   101b0:	eec6                	sd	a7,344(sp)
   101b2:	1234                	addi	a3,sp,296
   101b4:	e636                	sd	a3,264(sp)
   101b6:	862a                	mv	a2,a0
   101b8:	10000593          	li	a1,256
   101bc:	0028                	addi	a0,sp,8
   101be:	2d6000ef          	jal	ra,10494 <vsnprintf>
   101c2:	0005071b          	sext.w	a4,a0
   101c6:	0ff00793          	li	a5,255
   101ca:	02e7e163          	bltu	a5,a4,101ec <printu+0x4c>
   101ce:	862a                	mv	a2,a0
   101d0:	4881                	li	a7,0
   101d2:	4801                	li	a6,0
   101d4:	4781                	li	a5,0
   101d6:	4701                	li	a4,0
   101d8:	4681                	li	a3,0
   101da:	002c                	addi	a1,sp,8
   101dc:	04000513          	li	a0,64
   101e0:	fb3ff0ef          	jal	ra,10192 <do_user_call>
   101e4:	2501                	sext.w	a0,a0
   101e6:	60f2                	ld	ra,280(sp)
   101e8:	6135                	addi	sp,sp,352
   101ea:	8082                	ret
   101ec:	10000613          	li	a2,256
   101f0:	b7c5                	j	101d0 <printu+0x30>

00000000000101f2 <exit>:
   101f2:	1141                	addi	sp,sp,-16
   101f4:	e406                	sd	ra,8(sp)
   101f6:	85aa                	mv	a1,a0
   101f8:	4881                	li	a7,0
   101fa:	4801                	li	a6,0
   101fc:	4781                	li	a5,0
   101fe:	4701                	li	a4,0
   10200:	4681                	li	a3,0
   10202:	4601                	li	a2,0
   10204:	04100513          	li	a0,65
   10208:	f8bff0ef          	jal	ra,10192 <do_user_call>
   1020c:	2501                	sext.w	a0,a0
   1020e:	60a2                	ld	ra,8(sp)
   10210:	0141                	addi	sp,sp,16
   10212:	8082                	ret

0000000000010214 <naive_malloc>:
   10214:	1141                	addi	sp,sp,-16
   10216:	e406                	sd	ra,8(sp)
   10218:	4881                	li	a7,0
   1021a:	4801                	li	a6,0
   1021c:	4781                	li	a5,0
   1021e:	4701                	li	a4,0
   10220:	4681                	li	a3,0
   10222:	4601                	li	a2,0
   10224:	4581                	li	a1,0
   10226:	04200513          	li	a0,66
   1022a:	f69ff0ef          	jal	ra,10192 <do_user_call>
   1022e:	60a2                	ld	ra,8(sp)
   10230:	0141                	addi	sp,sp,16
   10232:	8082                	ret

0000000000010234 <naive_free>:
   10234:	1141                	addi	sp,sp,-16
   10236:	e406                	sd	ra,8(sp)
   10238:	85aa                	mv	a1,a0
   1023a:	4881                	li	a7,0
   1023c:	4801                	li	a6,0
   1023e:	4781                	li	a5,0
   10240:	4701                	li	a4,0
   10242:	4681                	li	a3,0
   10244:	4601                	li	a2,0
   10246:	04300513          	li	a0,67
   1024a:	f49ff0ef          	jal	ra,10192 <do_user_call>
   1024e:	60a2                	ld	ra,8(sp)
   10250:	0141                	addi	sp,sp,16
   10252:	8082                	ret

0000000000010254 <fork>:
   10254:	1141                	addi	sp,sp,-16
   10256:	e406                	sd	ra,8(sp)
   10258:	4881                	li	a7,0
   1025a:	4801                	li	a6,0
   1025c:	4781                	li	a5,0
   1025e:	4701                	li	a4,0
   10260:	4681                	li	a3,0
   10262:	4601                	li	a2,0
   10264:	4581                	li	a1,0
   10266:	04400513          	li	a0,68
   1026a:	f29ff0ef          	jal	ra,10192 <do_user_call>
   1026e:	2501                	sext.w	a0,a0
   10270:	60a2                	ld	ra,8(sp)
   10272:	0141                	addi	sp,sp,16
   10274:	8082                	ret

0000000000010276 <yield>:
   10276:	1141                	addi	sp,sp,-16
   10278:	e406                	sd	ra,8(sp)
   1027a:	4881                	li	a7,0
   1027c:	4801                	li	a6,0
   1027e:	4781                	li	a5,0
   10280:	4701                	li	a4,0
   10282:	4681                	li	a3,0
   10284:	4601                	li	a2,0
   10286:	4581                	li	a1,0
   10288:	04500513          	li	a0,69
   1028c:	f07ff0ef          	jal	ra,10192 <do_user_call>
   10290:	60a2                	ld	ra,8(sp)
   10292:	0141                	addi	sp,sp,16
   10294:	8082                	ret

0000000000010296 <open>:
   10296:	1141                	addi	sp,sp,-16
   10298:	e406                	sd	ra,8(sp)
   1029a:	862e                	mv	a2,a1
   1029c:	4881                	li	a7,0
   1029e:	4801                	li	a6,0
   102a0:	4781                	li	a5,0
   102a2:	4701                	li	a4,0
   102a4:	4681                	li	a3,0
   102a6:	85aa                	mv	a1,a0
   102a8:	05100513          	li	a0,81
   102ac:	ee7ff0ef          	jal	ra,10192 <do_user_call>
   102b0:	2501                	sext.w	a0,a0
   102b2:	60a2                	ld	ra,8(sp)
   102b4:	0141                	addi	sp,sp,16
   102b6:	8082                	ret

00000000000102b8 <read_u>:
   102b8:	1141                	addi	sp,sp,-16
   102ba:	e406                	sd	ra,8(sp)
   102bc:	86b2                	mv	a3,a2
   102be:	4881                	li	a7,0
   102c0:	4801                	li	a6,0
   102c2:	4781                	li	a5,0
   102c4:	4701                	li	a4,0
   102c6:	862e                	mv	a2,a1
   102c8:	85aa                	mv	a1,a0
   102ca:	05200513          	li	a0,82
   102ce:	ec5ff0ef          	jal	ra,10192 <do_user_call>
   102d2:	2501                	sext.w	a0,a0
   102d4:	60a2                	ld	ra,8(sp)
   102d6:	0141                	addi	sp,sp,16
   102d8:	8082                	ret

00000000000102da <write_u>:
   102da:	1141                	addi	sp,sp,-16
   102dc:	e406                	sd	ra,8(sp)
   102de:	86b2                	mv	a3,a2
   102e0:	4881                	li	a7,0
   102e2:	4801                	li	a6,0
   102e4:	4781                	li	a5,0
   102e6:	4701                	li	a4,0
   102e8:	862e                	mv	a2,a1
   102ea:	85aa                	mv	a1,a0
   102ec:	05300513          	li	a0,83
   102f0:	ea3ff0ef          	jal	ra,10192 <do_user_call>
   102f4:	2501                	sext.w	a0,a0
   102f6:	60a2                	ld	ra,8(sp)
   102f8:	0141                	addi	sp,sp,16
   102fa:	8082                	ret

00000000000102fc <lseek_u>:
   102fc:	1141                	addi	sp,sp,-16
   102fe:	e406                	sd	ra,8(sp)
   10300:	86b2                	mv	a3,a2
   10302:	4881                	li	a7,0
   10304:	4801                	li	a6,0
   10306:	4781                	li	a5,0
   10308:	4701                	li	a4,0
   1030a:	862e                	mv	a2,a1
   1030c:	85aa                	mv	a1,a0
   1030e:	05400513          	li	a0,84
   10312:	e81ff0ef          	jal	ra,10192 <do_user_call>
   10316:	2501                	sext.w	a0,a0
   10318:	60a2                	ld	ra,8(sp)
   1031a:	0141                	addi	sp,sp,16
   1031c:	8082                	ret

000000000001031e <stat_u>:
   1031e:	1141                	addi	sp,sp,-16
   10320:	e406                	sd	ra,8(sp)
   10322:	862e                	mv	a2,a1
   10324:	4881                	li	a7,0
   10326:	4801                	li	a6,0
   10328:	4781                	li	a5,0
   1032a:	4701                	li	a4,0
   1032c:	4681                	li	a3,0
   1032e:	85aa                	mv	a1,a0
   10330:	05500513          	li	a0,85
   10334:	e5fff0ef          	jal	ra,10192 <do_user_call>
   10338:	2501                	sext.w	a0,a0
   1033a:	60a2                	ld	ra,8(sp)
   1033c:	0141                	addi	sp,sp,16
   1033e:	8082                	ret

0000000000010340 <disk_stat_u>:
   10340:	1141                	addi	sp,sp,-16
   10342:	e406                	sd	ra,8(sp)
   10344:	862e                	mv	a2,a1
   10346:	4881                	li	a7,0
   10348:	4801                	li	a6,0
   1034a:	4781                	li	a5,0
   1034c:	4701                	li	a4,0
   1034e:	4681                	li	a3,0
   10350:	85aa                	mv	a1,a0
   10352:	05600513          	li	a0,86
   10356:	e3dff0ef          	jal	ra,10192 <do_user_call>
   1035a:	2501                	sext.w	a0,a0
   1035c:	60a2                	ld	ra,8(sp)
   1035e:	0141                	addi	sp,sp,16
   10360:	8082                	ret

0000000000010362 <opendir_u>:
   10362:	1141                	addi	sp,sp,-16
   10364:	e406                	sd	ra,8(sp)
   10366:	85aa                	mv	a1,a0
   10368:	4881                	li	a7,0
   1036a:	4801                	li	a6,0
   1036c:	4781                	li	a5,0
   1036e:	4701                	li	a4,0
   10370:	4681                	li	a3,0
   10372:	4601                	li	a2,0
   10374:	05800513          	li	a0,88
   10378:	e1bff0ef          	jal	ra,10192 <do_user_call>
   1037c:	2501                	sext.w	a0,a0
   1037e:	60a2                	ld	ra,8(sp)
   10380:	0141                	addi	sp,sp,16
   10382:	8082                	ret

0000000000010384 <readdir_u>:
   10384:	1141                	addi	sp,sp,-16
   10386:	e406                	sd	ra,8(sp)
   10388:	862e                	mv	a2,a1
   1038a:	4881                	li	a7,0
   1038c:	4801                	li	a6,0
   1038e:	4781                	li	a5,0
   10390:	4701                	li	a4,0
   10392:	4681                	li	a3,0
   10394:	85aa                	mv	a1,a0
   10396:	05900513          	li	a0,89
   1039a:	df9ff0ef          	jal	ra,10192 <do_user_call>
   1039e:	2501                	sext.w	a0,a0
   103a0:	60a2                	ld	ra,8(sp)
   103a2:	0141                	addi	sp,sp,16
   103a4:	8082                	ret

00000000000103a6 <mkdir_u>:
   103a6:	1141                	addi	sp,sp,-16
   103a8:	e406                	sd	ra,8(sp)
   103aa:	85aa                	mv	a1,a0
   103ac:	4881                	li	a7,0
   103ae:	4801                	li	a6,0
   103b0:	4781                	li	a5,0
   103b2:	4701                	li	a4,0
   103b4:	4681                	li	a3,0
   103b6:	4601                	li	a2,0
   103b8:	05a00513          	li	a0,90
   103bc:	dd7ff0ef          	jal	ra,10192 <do_user_call>
   103c0:	2501                	sext.w	a0,a0
   103c2:	60a2                	ld	ra,8(sp)
   103c4:	0141                	addi	sp,sp,16
   103c6:	8082                	ret

00000000000103c8 <closedir_u>:
   103c8:	1141                	addi	sp,sp,-16
   103ca:	e406                	sd	ra,8(sp)
   103cc:	85aa                	mv	a1,a0
   103ce:	4881                	li	a7,0
   103d0:	4801                	li	a6,0
   103d2:	4781                	li	a5,0
   103d4:	4701                	li	a4,0
   103d6:	4681                	li	a3,0
   103d8:	4601                	li	a2,0
   103da:	05b00513          	li	a0,91
   103de:	db5ff0ef          	jal	ra,10192 <do_user_call>
   103e2:	2501                	sext.w	a0,a0
   103e4:	60a2                	ld	ra,8(sp)
   103e6:	0141                	addi	sp,sp,16
   103e8:	8082                	ret

00000000000103ea <link_u>:
   103ea:	1141                	addi	sp,sp,-16
   103ec:	e406                	sd	ra,8(sp)
   103ee:	862e                	mv	a2,a1
   103f0:	4881                	li	a7,0
   103f2:	4801                	li	a6,0
   103f4:	4781                	li	a5,0
   103f6:	4701                	li	a4,0
   103f8:	4681                	li	a3,0
   103fa:	85aa                	mv	a1,a0
   103fc:	05c00513          	li	a0,92
   10400:	d93ff0ef          	jal	ra,10192 <do_user_call>
   10404:	2501                	sext.w	a0,a0
   10406:	60a2                	ld	ra,8(sp)
   10408:	0141                	addi	sp,sp,16
   1040a:	8082                	ret

000000000001040c <unlink_u>:
   1040c:	1141                	addi	sp,sp,-16
   1040e:	e406                	sd	ra,8(sp)
   10410:	85aa                	mv	a1,a0
   10412:	4881                	li	a7,0
   10414:	4801                	li	a6,0
   10416:	4781                	li	a5,0
   10418:	4701                	li	a4,0
   1041a:	4681                	li	a3,0
   1041c:	4601                	li	a2,0
   1041e:	05d00513          	li	a0,93
   10422:	d71ff0ef          	jal	ra,10192 <do_user_call>
   10426:	2501                	sext.w	a0,a0
   10428:	60a2                	ld	ra,8(sp)
   1042a:	0141                	addi	sp,sp,16
   1042c:	8082                	ret

000000000001042e <close>:
   1042e:	1141                	addi	sp,sp,-16
   10430:	e406                	sd	ra,8(sp)
   10432:	85aa                	mv	a1,a0
   10434:	4881                	li	a7,0
   10436:	4801                	li	a6,0
   10438:	4781                	li	a5,0
   1043a:	4701                	li	a4,0
   1043c:	4681                	li	a3,0
   1043e:	4601                	li	a2,0
   10440:	05700513          	li	a0,87
   10444:	d4fff0ef          	jal	ra,10192 <do_user_call>
   10448:	2501                	sext.w	a0,a0
   1044a:	60a2                	ld	ra,8(sp)
   1044c:	0141                	addi	sp,sp,16
   1044e:	8082                	ret

0000000000010450 <wait>:
   10450:	1141                	addi	sp,sp,-16
   10452:	e406                	sd	ra,8(sp)
   10454:	85aa                	mv	a1,a0
   10456:	4881                	li	a7,0
   10458:	4801                	li	a6,0
   1045a:	4781                	li	a5,0
   1045c:	4701                	li	a4,0
   1045e:	4681                	li	a3,0
   10460:	4601                	li	a2,0
   10462:	04600513          	li	a0,70
   10466:	d2dff0ef          	jal	ra,10192 <do_user_call>
   1046a:	2501                	sext.w	a0,a0
   1046c:	60a2                	ld	ra,8(sp)
   1046e:	0141                	addi	sp,sp,16
   10470:	8082                	ret

0000000000010472 <exec>:
   10472:	1141                	addi	sp,sp,-16
   10474:	e406                	sd	ra,8(sp)
   10476:	862e                	mv	a2,a1
   10478:	4881                	li	a7,0
   1047a:	4801                	li	a6,0
   1047c:	4781                	li	a5,0
   1047e:	4701                	li	a4,0
   10480:	4681                	li	a3,0
   10482:	85aa                	mv	a1,a0
   10484:	05e00513          	li	a0,94
   10488:	d0bff0ef          	jal	ra,10192 <do_user_call>
   1048c:	2501                	sext.w	a0,a0
   1048e:	60a2                	ld	ra,8(sp)
   10490:	0141                	addi	sp,sp,16
   10492:	8082                	ret

0000000000010494 <vsnprintf>:
   10494:	1141                	addi	sp,sp,-16
   10496:	e436                	sd	a3,8(sp)
   10498:	4781                	li	a5,0
   1049a:	4301                	li	t1,0
   1049c:	4681                	li	a3,0
   1049e:	a271                	j	1062a <vsnprintf+0x196>
   104a0:	00178713          	addi	a4,a5,1
   104a4:	00b77863          	bgeu	a4,a1,104b4 <vsnprintf+0x20>
   104a8:	00f50833          	add	a6,a0,a5
   104ac:	03000893          	li	a7,48
   104b0:	01180023          	sb	a7,0(a6)
   104b4:	0789                	addi	a5,a5,2
   104b6:	00b7f763          	bgeu	a5,a1,104c4 <vsnprintf+0x30>
   104ba:	972a                	add	a4,a4,a0
   104bc:	07800813          	li	a6,120
   104c0:	01070023          	sb	a6,0(a4)
   104c4:	6722                	ld	a4,8(sp)
   104c6:	00870813          	addi	a6,a4,8
   104ca:	e442                	sd	a6,8(sp)
   104cc:	00073883          	ld	a7,0(a4)
   104d0:	e6b9                	bnez	a3,1051e <vsnprintf+0x8a>
   104d2:	469d                	li	a3,7
   104d4:	a025                	j	104fc <vsnprintf+0x68>
   104d6:	00030463          	beqz	t1,104de <vsnprintf+0x4a>
   104da:	869a                	mv	a3,t1
   104dc:	b7e5                	j	104c4 <vsnprintf+0x30>
   104de:	6722                	ld	a4,8(sp)
   104e0:	00870693          	addi	a3,a4,8
   104e4:	e436                	sd	a3,8(sp)
   104e6:	00072883          	lw	a7,0(a4)
   104ea:	869a                	mv	a3,t1
   104ec:	b7d5                	j	104d0 <vsnprintf+0x3c>
   104ee:	05770713          	addi	a4,a4,87
   104f2:	97aa                	add	a5,a5,a0
   104f4:	00e78023          	sb	a4,0(a5)
   104f8:	36fd                	addiw	a3,a3,-1
   104fa:	87c2                	mv	a5,a6
   104fc:	0206c363          	bltz	a3,10522 <vsnprintf+0x8e>
   10500:	0026971b          	slliw	a4,a3,0x2
   10504:	40e8d733          	sra	a4,a7,a4
   10508:	8b3d                	andi	a4,a4,15
   1050a:	00178813          	addi	a6,a5,1
   1050e:	feb875e3          	bgeu	a6,a1,104f8 <vsnprintf+0x64>
   10512:	4325                	li	t1,9
   10514:	fce34de3          	blt	t1,a4,104ee <vsnprintf+0x5a>
   10518:	03070713          	addi	a4,a4,48
   1051c:	bfd9                	j	104f2 <vsnprintf+0x5e>
   1051e:	46bd                	li	a3,15
   10520:	bff1                	j	104fc <vsnprintf+0x68>
   10522:	4301                	li	t1,0
   10524:	4681                	li	a3,0
   10526:	a209                	j	10628 <vsnprintf+0x194>
   10528:	00030d63          	beqz	t1,10542 <vsnprintf+0xae>
   1052c:	6722                	ld	a4,8(sp)
   1052e:	00870693          	addi	a3,a4,8
   10532:	e436                	sd	a3,8(sp)
   10534:	00073883          	ld	a7,0(a4)
   10538:	0008cc63          	bltz	a7,10550 <vsnprintf+0xbc>
   1053c:	8746                	mv	a4,a7
   1053e:	4305                	li	t1,1
   10540:	a805                	j	10570 <vsnprintf+0xdc>
   10542:	6722                	ld	a4,8(sp)
   10544:	00870693          	addi	a3,a4,8
   10548:	e436                	sd	a3,8(sp)
   1054a:	00072883          	lw	a7,0(a4)
   1054e:	b7ed                	j	10538 <vsnprintf+0xa4>
   10550:	411008b3          	neg	a7,a7
   10554:	00178713          	addi	a4,a5,1
   10558:	00b77963          	bgeu	a4,a1,1056a <vsnprintf+0xd6>
   1055c:	97aa                	add	a5,a5,a0
   1055e:	02d00693          	li	a3,45
   10562:	00d78023          	sb	a3,0(a5)
   10566:	87ba                	mv	a5,a4
   10568:	bfd1                	j	1053c <vsnprintf+0xa8>
   1056a:	87ba                	mv	a5,a4
   1056c:	bfc1                	j	1053c <vsnprintf+0xa8>
   1056e:	0305                	addi	t1,t1,1
   10570:	46a9                	li	a3,10
   10572:	02d74733          	div	a4,a4,a3
   10576:	ff65                	bnez	a4,1056e <vsnprintf+0xda>
   10578:	fff3071b          	addiw	a4,t1,-1
   1057c:	a029                	j	10586 <vsnprintf+0xf2>
   1057e:	46a9                	li	a3,10
   10580:	02d8c8b3          	div	a7,a7,a3
   10584:	377d                	addiw	a4,a4,-1
   10586:	02074163          	bltz	a4,105a8 <vsnprintf+0x114>
   1058a:	00f706b3          	add	a3,a4,a5
   1058e:	00168813          	addi	a6,a3,1
   10592:	feb876e3          	bgeu	a6,a1,1057e <vsnprintf+0xea>
   10596:	4829                	li	a6,10
   10598:	0308e833          	rem	a6,a7,a6
   1059c:	96aa                	add	a3,a3,a0
   1059e:	0308081b          	addiw	a6,a6,48
   105a2:	01068023          	sb	a6,0(a3)
   105a6:	bfe1                	j	1057e <vsnprintf+0xea>
   105a8:	979a                	add	a5,a5,t1
   105aa:	4301                	li	t1,0
   105ac:	4681                	li	a3,0
   105ae:	a8ad                	j	10628 <vsnprintf+0x194>
   105b0:	6722                	ld	a4,8(sp)
   105b2:	00870693          	addi	a3,a4,8
   105b6:	e436                	sd	a3,8(sp)
   105b8:	6318                	ld	a4,0(a4)
   105ba:	a019                	j	105c0 <vsnprintf+0x12c>
   105bc:	0705                	addi	a4,a4,1
   105be:	87b6                	mv	a5,a3
   105c0:	00074803          	lbu	a6,0(a4)
   105c4:	00080a63          	beqz	a6,105d8 <vsnprintf+0x144>
   105c8:	00178693          	addi	a3,a5,1
   105cc:	feb6f8e3          	bgeu	a3,a1,105bc <vsnprintf+0x128>
   105d0:	97aa                	add	a5,a5,a0
   105d2:	01078023          	sb	a6,0(a5)
   105d6:	b7dd                	j	105bc <vsnprintf+0x128>
   105d8:	4301                	li	t1,0
   105da:	4681                	li	a3,0
   105dc:	a0b1                	j	10628 <vsnprintf+0x194>
   105de:	00178713          	addi	a4,a5,1
   105e2:	02b77e63          	bgeu	a4,a1,1061e <vsnprintf+0x18a>
   105e6:	66a2                	ld	a3,8(sp)
   105e8:	00868813          	addi	a6,a3,8
   105ec:	e442                	sd	a6,8(sp)
   105ee:	97aa                	add	a5,a5,a0
   105f0:	0006c683          	lbu	a3,0(a3)
   105f4:	00d78023          	sb	a3,0(a5)
   105f8:	87ba                	mv	a5,a4
   105fa:	4301                	li	t1,0
   105fc:	4681                	li	a3,0
   105fe:	a02d                	j	10628 <vsnprintf+0x194>
   10600:	02500813          	li	a6,37
   10604:	03070163          	beq	a4,a6,10626 <vsnprintf+0x192>
   10608:	00178813          	addi	a6,a5,1
   1060c:	04b87463          	bgeu	a6,a1,10654 <vsnprintf+0x1c0>
   10610:	97aa                	add	a5,a5,a0
   10612:	00e78023          	sb	a4,0(a5)
   10616:	87c2                	mv	a5,a6
   10618:	a801                	j	10628 <vsnprintf+0x194>
   1061a:	8336                	mv	t1,a3
   1061c:	a031                	j	10628 <vsnprintf+0x194>
   1061e:	87ba                	mv	a5,a4
   10620:	4301                	li	t1,0
   10622:	4681                	li	a3,0
   10624:	a011                	j	10628 <vsnprintf+0x194>
   10626:	4685                	li	a3,1
   10628:	0605                	addi	a2,a2,1
   1062a:	00064703          	lbu	a4,0(a2)
   1062e:	c70d                	beqz	a4,10658 <vsnprintf+0x1c4>
   10630:	dae1                	beqz	a3,10600 <vsnprintf+0x16c>
   10632:	f9d7071b          	addiw	a4,a4,-99
   10636:	0ff77893          	zext.b	a7,a4
   1063a:	4855                	li	a6,21
   1063c:	ff1866e3          	bltu	a6,a7,10628 <vsnprintf+0x194>
   10640:	00289713          	slli	a4,a7,0x2
   10644:	00000817          	auipc	a6,0x0
   10648:	2fc80813          	addi	a6,a6,764 # 10940 <safestrcpy+0xb6>
   1064c:	9742                	add	a4,a4,a6
   1064e:	4318                	lw	a4,0(a4)
   10650:	9742                	add	a4,a4,a6
   10652:	8702                	jr	a4
   10654:	87c2                	mv	a5,a6
   10656:	bfc9                	j	10628 <vsnprintf+0x194>
   10658:	00b7f963          	bgeu	a5,a1,1066a <vsnprintf+0x1d6>
   1065c:	953e                	add	a0,a0,a5
   1065e:	00050023          	sb	zero,0(a0)
   10662:	0007851b          	sext.w	a0,a5
   10666:	0141                	addi	sp,sp,16
   10668:	8082                	ret
   1066a:	dde5                	beqz	a1,10662 <vsnprintf+0x1ce>
   1066c:	15fd                	addi	a1,a1,-1
   1066e:	952e                	add	a0,a0,a1
   10670:	00050023          	sb	zero,0(a0)
   10674:	b7fd                	j	10662 <vsnprintf+0x1ce>

0000000000010676 <memcpy>:
   10676:	00a5e7b3          	or	a5,a1,a0
   1067a:	8b9d                	andi	a5,a5,7
   1067c:	c399                	beqz	a5,10682 <memcpy+0xc>
   1067e:	87aa                	mv	a5,a0
   10680:	a015                	j	106a4 <memcpy+0x2e>
   10682:	87aa                	mv	a5,a0
   10684:	ff960713          	addi	a4,a2,-7
   10688:	972a                	add	a4,a4,a0
   1068a:	00e7fd63          	bgeu	a5,a4,106a4 <memcpy+0x2e>
   1068e:	6198                	ld	a4,0(a1)
   10690:	e398                	sd	a4,0(a5)
   10692:	07a1                	addi	a5,a5,8
   10694:	05a1                	addi	a1,a1,8
   10696:	b7fd                	j	10684 <memcpy+0xe>
   10698:	0005c703          	lbu	a4,0(a1)
   1069c:	00e78023          	sb	a4,0(a5)
   106a0:	0785                	addi	a5,a5,1
   106a2:	0585                	addi	a1,a1,1
   106a4:	00c50733          	add	a4,a0,a2
   106a8:	fee7e8e3          	bltu	a5,a4,10698 <memcpy+0x22>
   106ac:	8082                	ret

00000000000106ae <memset>:
   106ae:	00c567b3          	or	a5,a0,a2
   106b2:	8b9d                	andi	a5,a5,7
   106b4:	ef8d                	bnez	a5,106ee <memset+0x40>
   106b6:	0ff5f593          	zext.b	a1,a1
   106ba:	00859713          	slli	a4,a1,0x8
   106be:	8f4d                	or	a4,a4,a1
   106c0:	01071793          	slli	a5,a4,0x10
   106c4:	8fd9                	or	a5,a5,a4
   106c6:	02079693          	slli	a3,a5,0x20
   106ca:	8edd                	or	a3,a3,a5
   106cc:	87aa                	mv	a5,a0
   106ce:	a019                	j	106d4 <memset+0x26>
   106d0:	e394                	sd	a3,0(a5)
   106d2:	07a1                	addi	a5,a5,8
   106d4:	00c50733          	add	a4,a0,a2
   106d8:	fee7ece3          	bltu	a5,a4,106d0 <memset+0x22>
   106dc:	8082                	ret
   106de:	00b78023          	sb	a1,0(a5)
   106e2:	0785                	addi	a5,a5,1
   106e4:	00c50733          	add	a4,a0,a2
   106e8:	fee7ebe3          	bltu	a5,a4,106de <memset+0x30>
   106ec:	8082                	ret
   106ee:	87aa                	mv	a5,a0
   106f0:	bfd5                	j	106e4 <memset+0x36>

00000000000106f2 <strlen>:
   106f2:	87aa                	mv	a5,a0
   106f4:	a011                	j	106f8 <strlen+0x6>
   106f6:	0785                	addi	a5,a5,1
   106f8:	0007c703          	lbu	a4,0(a5)
   106fc:	ff6d                	bnez	a4,106f6 <strlen+0x4>
   106fe:	40a78533          	sub	a0,a5,a0
   10702:	8082                	ret

0000000000010704 <strcmp>:
   10704:	00054703          	lbu	a4,0(a0)
   10708:	0505                	addi	a0,a0,1
   1070a:	0005c783          	lbu	a5,0(a1)
   1070e:	0585                	addi	a1,a1,1
   10710:	c319                	beqz	a4,10716 <strcmp+0x12>
   10712:	fef709e3          	beq	a4,a5,10704 <strcmp>
   10716:	40f7053b          	subw	a0,a4,a5
   1071a:	8082                	ret

000000000001071c <strcpy>:
   1071c:	86aa                	mv	a3,a0
   1071e:	0005c703          	lbu	a4,0(a1)
   10722:	0585                	addi	a1,a1,1
   10724:	00e68023          	sb	a4,0(a3)
   10728:	0685                	addi	a3,a3,1
   1072a:	fb75                	bnez	a4,1071e <strcpy+0x2>
   1072c:	8082                	ret

000000000001072e <strchr>:
   1072e:	0ff5f593          	zext.b	a1,a1
   10732:	a011                	j	10736 <strchr+0x8>
   10734:	0505                	addi	a0,a0,1
   10736:	00054783          	lbu	a5,0(a0)
   1073a:	00b78463          	beq	a5,a1,10742 <strchr+0x14>
   1073e:	fbfd                	bnez	a5,10734 <strchr+0x6>
   10740:	4501                	li	a0,0
   10742:	8082                	ret

0000000000010744 <strtok>:
   10744:	7179                	addi	sp,sp,-48
   10746:	f406                	sd	ra,40(sp)
   10748:	f022                	sd	s0,32(sp)
   1074a:	ec26                	sd	s1,24(sp)
   1074c:	e84a                	sd	s2,16(sp)
   1074e:	e44e                	sd	s3,8(sp)
   10750:	89ae                	mv	s3,a1
   10752:	c509                	beqz	a0,1075c <strtok+0x18>
   10754:	00001797          	auipc	a5,0x1
   10758:	24a7b223          	sd	a0,580(a5) # 11998 <current.0>
   1075c:	00001417          	auipc	s0,0x1
   10760:	23c43403          	ld	s0,572(s0) # 11998 <current.0>
   10764:	e019                	bnez	s0,1076a <strtok+0x26>
   10766:	a0b1                	j	107b2 <strtok+0x6e>
   10768:	0405                	addi	s0,s0,1
   1076a:	00044483          	lbu	s1,0(s0)
   1076e:	c491                	beqz	s1,1077a <strtok+0x36>
   10770:	85a6                	mv	a1,s1
   10772:	854e                	mv	a0,s3
   10774:	fbbff0ef          	jal	ra,1072e <strchr>
   10778:	f965                	bnez	a0,10768 <strtok+0x24>
   1077a:	cc89                	beqz	s1,10794 <strtok+0x50>
   1077c:	84a2                	mv	s1,s0
   1077e:	0004c903          	lbu	s2,0(s1)
   10782:	00090f63          	beqz	s2,107a0 <strtok+0x5c>
   10786:	85ca                	mv	a1,s2
   10788:	854e                	mv	a0,s3
   1078a:	fa5ff0ef          	jal	ra,1072e <strchr>
   1078e:	e909                	bnez	a0,107a0 <strtok+0x5c>
   10790:	0485                	addi	s1,s1,1
   10792:	b7f5                	j	1077e <strtok+0x3a>
   10794:	00001797          	auipc	a5,0x1
   10798:	2007b223          	sd	zero,516(a5) # 11998 <current.0>
   1079c:	4401                	li	s0,0
   1079e:	a811                	j	107b2 <strtok+0x6e>
   107a0:	02090163          	beqz	s2,107c2 <strtok+0x7e>
   107a4:	00048023          	sb	zero,0(s1)
   107a8:	0485                	addi	s1,s1,1
   107aa:	00001797          	auipc	a5,0x1
   107ae:	1e97b723          	sd	s1,494(a5) # 11998 <current.0>
   107b2:	8522                	mv	a0,s0
   107b4:	70a2                	ld	ra,40(sp)
   107b6:	7402                	ld	s0,32(sp)
   107b8:	64e2                	ld	s1,24(sp)
   107ba:	6942                	ld	s2,16(sp)
   107bc:	69a2                	ld	s3,8(sp)
   107be:	6145                	addi	sp,sp,48
   107c0:	8082                	ret
   107c2:	00001797          	auipc	a5,0x1
   107c6:	1c07bb23          	sd	zero,470(a5) # 11998 <current.0>
   107ca:	b7e5                	j	107b2 <strtok+0x6e>

00000000000107cc <strcat>:
   107cc:	1101                	addi	sp,sp,-32
   107ce:	ec06                	sd	ra,24(sp)
   107d0:	e822                	sd	s0,16(sp)
   107d2:	e426                	sd	s1,8(sp)
   107d4:	842a                	mv	s0,a0
   107d6:	84ae                	mv	s1,a1
   107d8:	f1bff0ef          	jal	ra,106f2 <strlen>
   107dc:	85a6                	mv	a1,s1
   107de:	9522                	add	a0,a0,s0
   107e0:	f3dff0ef          	jal	ra,1071c <strcpy>
   107e4:	8522                	mv	a0,s0
   107e6:	60e2                	ld	ra,24(sp)
   107e8:	6442                	ld	s0,16(sp)
   107ea:	64a2                	ld	s1,8(sp)
   107ec:	6105                	addi	sp,sp,32
   107ee:	8082                	ret

00000000000107f0 <atol>:
   107f0:	87aa                	mv	a5,a0
   107f2:	a011                	j	107f6 <atol+0x6>
   107f4:	0785                	addi	a5,a5,1
   107f6:	0007c703          	lbu	a4,0(a5)
   107fa:	02000693          	li	a3,32
   107fe:	fed70be3          	beq	a4,a3,107f4 <atol+0x4>
   10802:	02d00693          	li	a3,45
   10806:	00d70863          	beq	a4,a3,10816 <atol+0x26>
   1080a:	02b00693          	li	a3,43
   1080e:	00d70463          	beq	a4,a3,10816 <atol+0x26>
   10812:	4601                	li	a2,0
   10814:	a031                	j	10820 <atol+0x30>
   10816:	fd370713          	addi	a4,a4,-45
   1081a:	00173613          	seqz	a2,a4
   1081e:	0785                	addi	a5,a5,1
   10820:	4501                	li	a0,0
   10822:	a811                	j	10836 <atol+0x46>
   10824:	00251713          	slli	a4,a0,0x2
   10828:	972a                	add	a4,a4,a0
   1082a:	0706                	slli	a4,a4,0x1
   1082c:	0785                	addi	a5,a5,1
   1082e:	fd06869b          	addiw	a3,a3,-48
   10832:	00e68533          	add	a0,a3,a4
   10836:	0007c683          	lbu	a3,0(a5)
   1083a:	f6ed                	bnez	a3,10824 <atol+0x34>
   1083c:	c219                	beqz	a2,10842 <atol+0x52>
   1083e:	40a00533          	neg	a0,a0
   10842:	8082                	ret

0000000000010844 <memmove>:
   10844:	02a5ff63          	bgeu	a1,a0,10882 <memmove+0x3e>
   10848:	00c587b3          	add	a5,a1,a2
   1084c:	02f57d63          	bgeu	a0,a5,10886 <memmove+0x42>
   10850:	00c50733          	add	a4,a0,a2
   10854:	a801                	j	10864 <memmove+0x20>
   10856:	17fd                	addi	a5,a5,-1
   10858:	177d                	addi	a4,a4,-1
   1085a:	0007c603          	lbu	a2,0(a5)
   1085e:	00c70023          	sb	a2,0(a4)
   10862:	8636                	mv	a2,a3
   10864:	fff60693          	addi	a3,a2,-1
   10868:	f67d                	bnez	a2,10856 <memmove+0x12>
   1086a:	8082                	ret
   1086c:	0005c683          	lbu	a3,0(a1)
   10870:	00d78023          	sb	a3,0(a5)
   10874:	0785                	addi	a5,a5,1
   10876:	0585                	addi	a1,a1,1
   10878:	863a                	mv	a2,a4
   1087a:	fff60713          	addi	a4,a2,-1
   1087e:	f67d                	bnez	a2,1086c <memmove+0x28>
   10880:	8082                	ret
   10882:	87aa                	mv	a5,a0
   10884:	bfdd                	j	1087a <memmove+0x36>
   10886:	87aa                	mv	a5,a0
   10888:	bfcd                	j	1087a <memmove+0x36>

000000000001088a <safestrcpy>:
   1088a:	02c05563          	blez	a2,108b4 <safestrcpy+0x2a>
   1088e:	87aa                	mv	a5,a0
   10890:	a019                	j	10896 <safestrcpy+0xc>
   10892:	85c2                	mv	a1,a6
   10894:	87b6                	mv	a5,a3
   10896:	367d                	addiw	a2,a2,-1
   10898:	00c05c63          	blez	a2,108b0 <safestrcpy+0x26>
   1089c:	00158813          	addi	a6,a1,1
   108a0:	00178693          	addi	a3,a5,1
   108a4:	0005c703          	lbu	a4,0(a1)
   108a8:	00e78023          	sb	a4,0(a5)
   108ac:	f37d                	bnez	a4,10892 <safestrcpy+0x8>
   108ae:	87b6                	mv	a5,a3
   108b0:	00078023          	sb	zero,0(a5)
   108b4:	8082                	ret
