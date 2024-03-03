
hostfs_root/bin/app_shell:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <main>:
   100b0:	7139                	addi	sp,sp,-64
   100b2:	fc06                	sd	ra,56(sp)
   100b4:	f822                	sd	s0,48(sp)
   100b6:	f426                	sd	s1,40(sp)
   100b8:	f04a                	sd	s2,32(sp)
   100ba:	ec4e                	sd	s3,24(sp)
   100bc:	e852                	sd	s4,16(sp)
   100be:	0080                	addi	s0,sp,64
   100c0:	00001517          	auipc	a0,0x1
   100c4:	83850513          	addi	a0,a0,-1992 # 108f8 <safestrcpy+0x2e>
   100c8:	118000ef          	jal	ra,101e0 <printu>
   100cc:	c0010113          	addi	sp,sp,-1024
   100d0:	8a0a                	mv	s4,sp
   100d2:	6785                	lui	a5,0x1
   100d4:	a2078793          	addi	a5,a5,-1504 # a20 <main-0xf690>
   100d8:	fcf41423          	sh	a5,-56(s0)
   100dc:	fc040523          	sb	zero,-54(s0)
   100e0:	4581                	li	a1,0
   100e2:	00001517          	auipc	a0,0x1
   100e6:	83e50513          	addi	a0,a0,-1986 # 10920 <safestrcpy+0x56>
   100ea:	1ec000ef          	jal	ra,102d6 <open>
   100ee:	84aa                	mv	s1,a0
   100f0:	40000613          	li	a2,1024
   100f4:	858a                	mv	a1,sp
   100f6:	202000ef          	jal	ra,102f8 <read_u>
   100fa:	8526                	mv	a0,s1
   100fc:	372000ef          	jal	ra,1046e <close>
   10100:	154000ef          	jal	ra,10254 <naive_malloc>
   10104:	84aa                	mv	s1,a0
   10106:	14e000ef          	jal	ra,10254 <naive_malloc>
   1010a:	892a                	mv	s2,a0
   1010c:	4981                	li	s3,0
   1010e:	a005                	j	1012e <main+0x7e>
   10110:	fc840593          	addi	a1,s0,-56
   10114:	4501                	li	a0,0
   10116:	66e000ef          	jal	ra,10784 <strtok>
   1011a:	85aa                	mv	a1,a0
   1011c:	a015                	j	10140 <main+0x90>
   1011e:	372000ef          	jal	ra,10490 <wait>
   10122:	00001517          	auipc	a0,0x1
   10126:	86650513          	addi	a0,a0,-1946 # 10988 <safestrcpy+0xbe>
   1012a:	0b6000ef          	jal	ra,101e0 <printu>
   1012e:	fe0991e3          	bnez	s3,10110 <main+0x60>
   10132:	fc840593          	addi	a1,s0,-56
   10136:	8552                	mv	a0,s4
   10138:	64c000ef          	jal	ra,10784 <strtok>
   1013c:	85aa                	mv	a1,a0
   1013e:	4985                	li	s3,1
   10140:	8526                	mv	a0,s1
   10142:	61a000ef          	jal	ra,1075c <strcpy>
   10146:	fc840593          	addi	a1,s0,-56
   1014a:	4501                	li	a0,0
   1014c:	638000ef          	jal	ra,10784 <strtok>
   10150:	85aa                	mv	a1,a0
   10152:	854a                	mv	a0,s2
   10154:	608000ef          	jal	ra,1075c <strcpy>
   10158:	00000597          	auipc	a1,0x0
   1015c:	7d858593          	addi	a1,a1,2008 # 10930 <safestrcpy+0x66>
   10160:	8526                	mv	a0,s1
   10162:	5e2000ef          	jal	ra,10744 <strcmp>
   10166:	e909                	bnez	a0,10178 <main+0xc8>
   10168:	00000597          	auipc	a1,0x0
   1016c:	7c858593          	addi	a1,a1,1992 # 10930 <safestrcpy+0x66>
   10170:	854a                	mv	a0,s2
   10172:	5d2000ef          	jal	ra,10744 <strcmp>
   10176:	c121                	beqz	a0,101b6 <main+0x106>
   10178:	864a                	mv	a2,s2
   1017a:	85a6                	mv	a1,s1
   1017c:	00000517          	auipc	a0,0x0
   10180:	7bc50513          	addi	a0,a0,1980 # 10938 <safestrcpy+0x6e>
   10184:	05c000ef          	jal	ra,101e0 <printu>
   10188:	00000517          	auipc	a0,0x0
   1018c:	7c850513          	addi	a0,a0,1992 # 10950 <safestrcpy+0x86>
   10190:	050000ef          	jal	ra,101e0 <printu>
   10194:	100000ef          	jal	ra,10294 <fork>
   10198:	f159                	bnez	a0,1011e <main+0x6e>
   1019a:	85ca                	mv	a1,s2
   1019c:	8526                	mv	a0,s1
   1019e:	314000ef          	jal	ra,104b2 <exec>
   101a2:	57fd                	li	a5,-1
   101a4:	f8f515e3          	bne	a0,a5,1012e <main+0x7e>
   101a8:	00000517          	auipc	a0,0x0
   101ac:	7d050513          	addi	a0,a0,2000 # 10978 <safestrcpy+0xae>
   101b0:	030000ef          	jal	ra,101e0 <printu>
   101b4:	bfad                	j	1012e <main+0x7e>
   101b6:	4501                	li	a0,0
   101b8:	07a000ef          	jal	ra,10232 <exit>
   101bc:	4501                	li	a0,0
   101be:	fc040113          	addi	sp,s0,-64
   101c2:	70e2                	ld	ra,56(sp)
   101c4:	7442                	ld	s0,48(sp)
   101c6:	74a2                	ld	s1,40(sp)
   101c8:	7902                	ld	s2,32(sp)
   101ca:	69e2                	ld	s3,24(sp)
   101cc:	6a42                	ld	s4,16(sp)
   101ce:	6121                	addi	sp,sp,64
   101d0:	8082                	ret

00000000000101d2 <do_user_call>:
   101d2:	1141                	addi	sp,sp,-16
   101d4:	00000073          	ecall
   101d8:	c62a                	sw	a0,12(sp)
   101da:	4532                	lw	a0,12(sp)
   101dc:	0141                	addi	sp,sp,16
   101de:	8082                	ret

00000000000101e0 <printu>:
   101e0:	710d                	addi	sp,sp,-352
   101e2:	ee06                	sd	ra,280(sp)
   101e4:	f62e                	sd	a1,296(sp)
   101e6:	fa32                	sd	a2,304(sp)
   101e8:	fe36                	sd	a3,312(sp)
   101ea:	e2ba                	sd	a4,320(sp)
   101ec:	e6be                	sd	a5,328(sp)
   101ee:	eac2                	sd	a6,336(sp)
   101f0:	eec6                	sd	a7,344(sp)
   101f2:	1234                	addi	a3,sp,296
   101f4:	e636                	sd	a3,264(sp)
   101f6:	862a                	mv	a2,a0
   101f8:	10000593          	li	a1,256
   101fc:	0028                	addi	a0,sp,8
   101fe:	2d6000ef          	jal	ra,104d4 <vsnprintf>
   10202:	0005071b          	sext.w	a4,a0
   10206:	0ff00793          	li	a5,255
   1020a:	02e7e163          	bltu	a5,a4,1022c <printu+0x4c>
   1020e:	862a                	mv	a2,a0
   10210:	4881                	li	a7,0
   10212:	4801                	li	a6,0
   10214:	4781                	li	a5,0
   10216:	4701                	li	a4,0
   10218:	4681                	li	a3,0
   1021a:	002c                	addi	a1,sp,8
   1021c:	04000513          	li	a0,64
   10220:	fb3ff0ef          	jal	ra,101d2 <do_user_call>
   10224:	2501                	sext.w	a0,a0
   10226:	60f2                	ld	ra,280(sp)
   10228:	6135                	addi	sp,sp,352
   1022a:	8082                	ret
   1022c:	10000613          	li	a2,256
   10230:	b7c5                	j	10210 <printu+0x30>

0000000000010232 <exit>:
   10232:	1141                	addi	sp,sp,-16
   10234:	e406                	sd	ra,8(sp)
   10236:	85aa                	mv	a1,a0
   10238:	4881                	li	a7,0
   1023a:	4801                	li	a6,0
   1023c:	4781                	li	a5,0
   1023e:	4701                	li	a4,0
   10240:	4681                	li	a3,0
   10242:	4601                	li	a2,0
   10244:	04100513          	li	a0,65
   10248:	f8bff0ef          	jal	ra,101d2 <do_user_call>
   1024c:	2501                	sext.w	a0,a0
   1024e:	60a2                	ld	ra,8(sp)
   10250:	0141                	addi	sp,sp,16
   10252:	8082                	ret

0000000000010254 <naive_malloc>:
   10254:	1141                	addi	sp,sp,-16
   10256:	e406                	sd	ra,8(sp)
   10258:	4881                	li	a7,0
   1025a:	4801                	li	a6,0
   1025c:	4781                	li	a5,0
   1025e:	4701                	li	a4,0
   10260:	4681                	li	a3,0
   10262:	4601                	li	a2,0
   10264:	4581                	li	a1,0
   10266:	04200513          	li	a0,66
   1026a:	f69ff0ef          	jal	ra,101d2 <do_user_call>
   1026e:	60a2                	ld	ra,8(sp)
   10270:	0141                	addi	sp,sp,16
   10272:	8082                	ret

0000000000010274 <naive_free>:
   10274:	1141                	addi	sp,sp,-16
   10276:	e406                	sd	ra,8(sp)
   10278:	85aa                	mv	a1,a0
   1027a:	4881                	li	a7,0
   1027c:	4801                	li	a6,0
   1027e:	4781                	li	a5,0
   10280:	4701                	li	a4,0
   10282:	4681                	li	a3,0
   10284:	4601                	li	a2,0
   10286:	04300513          	li	a0,67
   1028a:	f49ff0ef          	jal	ra,101d2 <do_user_call>
   1028e:	60a2                	ld	ra,8(sp)
   10290:	0141                	addi	sp,sp,16
   10292:	8082                	ret

0000000000010294 <fork>:
   10294:	1141                	addi	sp,sp,-16
   10296:	e406                	sd	ra,8(sp)
   10298:	4881                	li	a7,0
   1029a:	4801                	li	a6,0
   1029c:	4781                	li	a5,0
   1029e:	4701                	li	a4,0
   102a0:	4681                	li	a3,0
   102a2:	4601                	li	a2,0
   102a4:	4581                	li	a1,0
   102a6:	04400513          	li	a0,68
   102aa:	f29ff0ef          	jal	ra,101d2 <do_user_call>
   102ae:	2501                	sext.w	a0,a0
   102b0:	60a2                	ld	ra,8(sp)
   102b2:	0141                	addi	sp,sp,16
   102b4:	8082                	ret

00000000000102b6 <yield>:
   102b6:	1141                	addi	sp,sp,-16
   102b8:	e406                	sd	ra,8(sp)
   102ba:	4881                	li	a7,0
   102bc:	4801                	li	a6,0
   102be:	4781                	li	a5,0
   102c0:	4701                	li	a4,0
   102c2:	4681                	li	a3,0
   102c4:	4601                	li	a2,0
   102c6:	4581                	li	a1,0
   102c8:	04500513          	li	a0,69
   102cc:	f07ff0ef          	jal	ra,101d2 <do_user_call>
   102d0:	60a2                	ld	ra,8(sp)
   102d2:	0141                	addi	sp,sp,16
   102d4:	8082                	ret

00000000000102d6 <open>:
   102d6:	1141                	addi	sp,sp,-16
   102d8:	e406                	sd	ra,8(sp)
   102da:	862e                	mv	a2,a1
   102dc:	4881                	li	a7,0
   102de:	4801                	li	a6,0
   102e0:	4781                	li	a5,0
   102e2:	4701                	li	a4,0
   102e4:	4681                	li	a3,0
   102e6:	85aa                	mv	a1,a0
   102e8:	05100513          	li	a0,81
   102ec:	ee7ff0ef          	jal	ra,101d2 <do_user_call>
   102f0:	2501                	sext.w	a0,a0
   102f2:	60a2                	ld	ra,8(sp)
   102f4:	0141                	addi	sp,sp,16
   102f6:	8082                	ret

00000000000102f8 <read_u>:
   102f8:	1141                	addi	sp,sp,-16
   102fa:	e406                	sd	ra,8(sp)
   102fc:	86b2                	mv	a3,a2
   102fe:	4881                	li	a7,0
   10300:	4801                	li	a6,0
   10302:	4781                	li	a5,0
   10304:	4701                	li	a4,0
   10306:	862e                	mv	a2,a1
   10308:	85aa                	mv	a1,a0
   1030a:	05200513          	li	a0,82
   1030e:	ec5ff0ef          	jal	ra,101d2 <do_user_call>
   10312:	2501                	sext.w	a0,a0
   10314:	60a2                	ld	ra,8(sp)
   10316:	0141                	addi	sp,sp,16
   10318:	8082                	ret

000000000001031a <write_u>:
   1031a:	1141                	addi	sp,sp,-16
   1031c:	e406                	sd	ra,8(sp)
   1031e:	86b2                	mv	a3,a2
   10320:	4881                	li	a7,0
   10322:	4801                	li	a6,0
   10324:	4781                	li	a5,0
   10326:	4701                	li	a4,0
   10328:	862e                	mv	a2,a1
   1032a:	85aa                	mv	a1,a0
   1032c:	05300513          	li	a0,83
   10330:	ea3ff0ef          	jal	ra,101d2 <do_user_call>
   10334:	2501                	sext.w	a0,a0
   10336:	60a2                	ld	ra,8(sp)
   10338:	0141                	addi	sp,sp,16
   1033a:	8082                	ret

000000000001033c <lseek_u>:
   1033c:	1141                	addi	sp,sp,-16
   1033e:	e406                	sd	ra,8(sp)
   10340:	86b2                	mv	a3,a2
   10342:	4881                	li	a7,0
   10344:	4801                	li	a6,0
   10346:	4781                	li	a5,0
   10348:	4701                	li	a4,0
   1034a:	862e                	mv	a2,a1
   1034c:	85aa                	mv	a1,a0
   1034e:	05400513          	li	a0,84
   10352:	e81ff0ef          	jal	ra,101d2 <do_user_call>
   10356:	2501                	sext.w	a0,a0
   10358:	60a2                	ld	ra,8(sp)
   1035a:	0141                	addi	sp,sp,16
   1035c:	8082                	ret

000000000001035e <stat_u>:
   1035e:	1141                	addi	sp,sp,-16
   10360:	e406                	sd	ra,8(sp)
   10362:	862e                	mv	a2,a1
   10364:	4881                	li	a7,0
   10366:	4801                	li	a6,0
   10368:	4781                	li	a5,0
   1036a:	4701                	li	a4,0
   1036c:	4681                	li	a3,0
   1036e:	85aa                	mv	a1,a0
   10370:	05500513          	li	a0,85
   10374:	e5fff0ef          	jal	ra,101d2 <do_user_call>
   10378:	2501                	sext.w	a0,a0
   1037a:	60a2                	ld	ra,8(sp)
   1037c:	0141                	addi	sp,sp,16
   1037e:	8082                	ret

0000000000010380 <disk_stat_u>:
   10380:	1141                	addi	sp,sp,-16
   10382:	e406                	sd	ra,8(sp)
   10384:	862e                	mv	a2,a1
   10386:	4881                	li	a7,0
   10388:	4801                	li	a6,0
   1038a:	4781                	li	a5,0
   1038c:	4701                	li	a4,0
   1038e:	4681                	li	a3,0
   10390:	85aa                	mv	a1,a0
   10392:	05600513          	li	a0,86
   10396:	e3dff0ef          	jal	ra,101d2 <do_user_call>
   1039a:	2501                	sext.w	a0,a0
   1039c:	60a2                	ld	ra,8(sp)
   1039e:	0141                	addi	sp,sp,16
   103a0:	8082                	ret

00000000000103a2 <opendir_u>:
   103a2:	1141                	addi	sp,sp,-16
   103a4:	e406                	sd	ra,8(sp)
   103a6:	85aa                	mv	a1,a0
   103a8:	4881                	li	a7,0
   103aa:	4801                	li	a6,0
   103ac:	4781                	li	a5,0
   103ae:	4701                	li	a4,0
   103b0:	4681                	li	a3,0
   103b2:	4601                	li	a2,0
   103b4:	05800513          	li	a0,88
   103b8:	e1bff0ef          	jal	ra,101d2 <do_user_call>
   103bc:	2501                	sext.w	a0,a0
   103be:	60a2                	ld	ra,8(sp)
   103c0:	0141                	addi	sp,sp,16
   103c2:	8082                	ret

00000000000103c4 <readdir_u>:
   103c4:	1141                	addi	sp,sp,-16
   103c6:	e406                	sd	ra,8(sp)
   103c8:	862e                	mv	a2,a1
   103ca:	4881                	li	a7,0
   103cc:	4801                	li	a6,0
   103ce:	4781                	li	a5,0
   103d0:	4701                	li	a4,0
   103d2:	4681                	li	a3,0
   103d4:	85aa                	mv	a1,a0
   103d6:	05900513          	li	a0,89
   103da:	df9ff0ef          	jal	ra,101d2 <do_user_call>
   103de:	2501                	sext.w	a0,a0
   103e0:	60a2                	ld	ra,8(sp)
   103e2:	0141                	addi	sp,sp,16
   103e4:	8082                	ret

00000000000103e6 <mkdir_u>:
   103e6:	1141                	addi	sp,sp,-16
   103e8:	e406                	sd	ra,8(sp)
   103ea:	85aa                	mv	a1,a0
   103ec:	4881                	li	a7,0
   103ee:	4801                	li	a6,0
   103f0:	4781                	li	a5,0
   103f2:	4701                	li	a4,0
   103f4:	4681                	li	a3,0
   103f6:	4601                	li	a2,0
   103f8:	05a00513          	li	a0,90
   103fc:	dd7ff0ef          	jal	ra,101d2 <do_user_call>
   10400:	2501                	sext.w	a0,a0
   10402:	60a2                	ld	ra,8(sp)
   10404:	0141                	addi	sp,sp,16
   10406:	8082                	ret

0000000000010408 <closedir_u>:
   10408:	1141                	addi	sp,sp,-16
   1040a:	e406                	sd	ra,8(sp)
   1040c:	85aa                	mv	a1,a0
   1040e:	4881                	li	a7,0
   10410:	4801                	li	a6,0
   10412:	4781                	li	a5,0
   10414:	4701                	li	a4,0
   10416:	4681                	li	a3,0
   10418:	4601                	li	a2,0
   1041a:	05b00513          	li	a0,91
   1041e:	db5ff0ef          	jal	ra,101d2 <do_user_call>
   10422:	2501                	sext.w	a0,a0
   10424:	60a2                	ld	ra,8(sp)
   10426:	0141                	addi	sp,sp,16
   10428:	8082                	ret

000000000001042a <link_u>:
   1042a:	1141                	addi	sp,sp,-16
   1042c:	e406                	sd	ra,8(sp)
   1042e:	862e                	mv	a2,a1
   10430:	4881                	li	a7,0
   10432:	4801                	li	a6,0
   10434:	4781                	li	a5,0
   10436:	4701                	li	a4,0
   10438:	4681                	li	a3,0
   1043a:	85aa                	mv	a1,a0
   1043c:	05c00513          	li	a0,92
   10440:	d93ff0ef          	jal	ra,101d2 <do_user_call>
   10444:	2501                	sext.w	a0,a0
   10446:	60a2                	ld	ra,8(sp)
   10448:	0141                	addi	sp,sp,16
   1044a:	8082                	ret

000000000001044c <unlink_u>:
   1044c:	1141                	addi	sp,sp,-16
   1044e:	e406                	sd	ra,8(sp)
   10450:	85aa                	mv	a1,a0
   10452:	4881                	li	a7,0
   10454:	4801                	li	a6,0
   10456:	4781                	li	a5,0
   10458:	4701                	li	a4,0
   1045a:	4681                	li	a3,0
   1045c:	4601                	li	a2,0
   1045e:	05d00513          	li	a0,93
   10462:	d71ff0ef          	jal	ra,101d2 <do_user_call>
   10466:	2501                	sext.w	a0,a0
   10468:	60a2                	ld	ra,8(sp)
   1046a:	0141                	addi	sp,sp,16
   1046c:	8082                	ret

000000000001046e <close>:
   1046e:	1141                	addi	sp,sp,-16
   10470:	e406                	sd	ra,8(sp)
   10472:	85aa                	mv	a1,a0
   10474:	4881                	li	a7,0
   10476:	4801                	li	a6,0
   10478:	4781                	li	a5,0
   1047a:	4701                	li	a4,0
   1047c:	4681                	li	a3,0
   1047e:	4601                	li	a2,0
   10480:	05700513          	li	a0,87
   10484:	d4fff0ef          	jal	ra,101d2 <do_user_call>
   10488:	2501                	sext.w	a0,a0
   1048a:	60a2                	ld	ra,8(sp)
   1048c:	0141                	addi	sp,sp,16
   1048e:	8082                	ret

0000000000010490 <wait>:
   10490:	1141                	addi	sp,sp,-16
   10492:	e406                	sd	ra,8(sp)
   10494:	85aa                	mv	a1,a0
   10496:	4881                	li	a7,0
   10498:	4801                	li	a6,0
   1049a:	4781                	li	a5,0
   1049c:	4701                	li	a4,0
   1049e:	4681                	li	a3,0
   104a0:	4601                	li	a2,0
   104a2:	04600513          	li	a0,70
   104a6:	d2dff0ef          	jal	ra,101d2 <do_user_call>
   104aa:	2501                	sext.w	a0,a0
   104ac:	60a2                	ld	ra,8(sp)
   104ae:	0141                	addi	sp,sp,16
   104b0:	8082                	ret

00000000000104b2 <exec>:
   104b2:	1141                	addi	sp,sp,-16
   104b4:	e406                	sd	ra,8(sp)
   104b6:	862e                	mv	a2,a1
   104b8:	4881                	li	a7,0
   104ba:	4801                	li	a6,0
   104bc:	4781                	li	a5,0
   104be:	4701                	li	a4,0
   104c0:	4681                	li	a3,0
   104c2:	85aa                	mv	a1,a0
   104c4:	05e00513          	li	a0,94
   104c8:	d0bff0ef          	jal	ra,101d2 <do_user_call>
   104cc:	2501                	sext.w	a0,a0
   104ce:	60a2                	ld	ra,8(sp)
   104d0:	0141                	addi	sp,sp,16
   104d2:	8082                	ret

00000000000104d4 <vsnprintf>:
   104d4:	1141                	addi	sp,sp,-16
   104d6:	e436                	sd	a3,8(sp)
   104d8:	4781                	li	a5,0
   104da:	4301                	li	t1,0
   104dc:	4681                	li	a3,0
   104de:	a271                	j	1066a <vsnprintf+0x196>
   104e0:	00178713          	addi	a4,a5,1
   104e4:	00b77863          	bgeu	a4,a1,104f4 <vsnprintf+0x20>
   104e8:	00f50833          	add	a6,a0,a5
   104ec:	03000893          	li	a7,48
   104f0:	01180023          	sb	a7,0(a6)
   104f4:	0789                	addi	a5,a5,2
   104f6:	00b7f763          	bgeu	a5,a1,10504 <vsnprintf+0x30>
   104fa:	972a                	add	a4,a4,a0
   104fc:	07800813          	li	a6,120
   10500:	01070023          	sb	a6,0(a4)
   10504:	6722                	ld	a4,8(sp)
   10506:	00870813          	addi	a6,a4,8
   1050a:	e442                	sd	a6,8(sp)
   1050c:	00073883          	ld	a7,0(a4)
   10510:	e6b9                	bnez	a3,1055e <vsnprintf+0x8a>
   10512:	469d                	li	a3,7
   10514:	a025                	j	1053c <vsnprintf+0x68>
   10516:	00030463          	beqz	t1,1051e <vsnprintf+0x4a>
   1051a:	869a                	mv	a3,t1
   1051c:	b7e5                	j	10504 <vsnprintf+0x30>
   1051e:	6722                	ld	a4,8(sp)
   10520:	00870693          	addi	a3,a4,8
   10524:	e436                	sd	a3,8(sp)
   10526:	00072883          	lw	a7,0(a4)
   1052a:	869a                	mv	a3,t1
   1052c:	b7d5                	j	10510 <vsnprintf+0x3c>
   1052e:	05770713          	addi	a4,a4,87
   10532:	97aa                	add	a5,a5,a0
   10534:	00e78023          	sb	a4,0(a5)
   10538:	36fd                	addiw	a3,a3,-1
   1053a:	87c2                	mv	a5,a6
   1053c:	0206c363          	bltz	a3,10562 <vsnprintf+0x8e>
   10540:	0026971b          	slliw	a4,a3,0x2
   10544:	40e8d733          	sra	a4,a7,a4
   10548:	8b3d                	andi	a4,a4,15
   1054a:	00178813          	addi	a6,a5,1
   1054e:	feb875e3          	bgeu	a6,a1,10538 <vsnprintf+0x64>
   10552:	4325                	li	t1,9
   10554:	fce34de3          	blt	t1,a4,1052e <vsnprintf+0x5a>
   10558:	03070713          	addi	a4,a4,48
   1055c:	bfd9                	j	10532 <vsnprintf+0x5e>
   1055e:	46bd                	li	a3,15
   10560:	bff1                	j	1053c <vsnprintf+0x68>
   10562:	4301                	li	t1,0
   10564:	4681                	li	a3,0
   10566:	a209                	j	10668 <vsnprintf+0x194>
   10568:	00030d63          	beqz	t1,10582 <vsnprintf+0xae>
   1056c:	6722                	ld	a4,8(sp)
   1056e:	00870693          	addi	a3,a4,8
   10572:	e436                	sd	a3,8(sp)
   10574:	00073883          	ld	a7,0(a4)
   10578:	0008cc63          	bltz	a7,10590 <vsnprintf+0xbc>
   1057c:	8746                	mv	a4,a7
   1057e:	4305                	li	t1,1
   10580:	a805                	j	105b0 <vsnprintf+0xdc>
   10582:	6722                	ld	a4,8(sp)
   10584:	00870693          	addi	a3,a4,8
   10588:	e436                	sd	a3,8(sp)
   1058a:	00072883          	lw	a7,0(a4)
   1058e:	b7ed                	j	10578 <vsnprintf+0xa4>
   10590:	411008b3          	neg	a7,a7
   10594:	00178713          	addi	a4,a5,1
   10598:	00b77963          	bgeu	a4,a1,105aa <vsnprintf+0xd6>
   1059c:	97aa                	add	a5,a5,a0
   1059e:	02d00693          	li	a3,45
   105a2:	00d78023          	sb	a3,0(a5)
   105a6:	87ba                	mv	a5,a4
   105a8:	bfd1                	j	1057c <vsnprintf+0xa8>
   105aa:	87ba                	mv	a5,a4
   105ac:	bfc1                	j	1057c <vsnprintf+0xa8>
   105ae:	0305                	addi	t1,t1,1
   105b0:	46a9                	li	a3,10
   105b2:	02d74733          	div	a4,a4,a3
   105b6:	ff65                	bnez	a4,105ae <vsnprintf+0xda>
   105b8:	fff3071b          	addiw	a4,t1,-1
   105bc:	a029                	j	105c6 <vsnprintf+0xf2>
   105be:	46a9                	li	a3,10
   105c0:	02d8c8b3          	div	a7,a7,a3
   105c4:	377d                	addiw	a4,a4,-1
   105c6:	02074163          	bltz	a4,105e8 <vsnprintf+0x114>
   105ca:	00f706b3          	add	a3,a4,a5
   105ce:	00168813          	addi	a6,a3,1
   105d2:	feb876e3          	bgeu	a6,a1,105be <vsnprintf+0xea>
   105d6:	4829                	li	a6,10
   105d8:	0308e833          	rem	a6,a7,a6
   105dc:	96aa                	add	a3,a3,a0
   105de:	0308081b          	addiw	a6,a6,48
   105e2:	01068023          	sb	a6,0(a3)
   105e6:	bfe1                	j	105be <vsnprintf+0xea>
   105e8:	979a                	add	a5,a5,t1
   105ea:	4301                	li	t1,0
   105ec:	4681                	li	a3,0
   105ee:	a8ad                	j	10668 <vsnprintf+0x194>
   105f0:	6722                	ld	a4,8(sp)
   105f2:	00870693          	addi	a3,a4,8
   105f6:	e436                	sd	a3,8(sp)
   105f8:	6318                	ld	a4,0(a4)
   105fa:	a019                	j	10600 <vsnprintf+0x12c>
   105fc:	0705                	addi	a4,a4,1
   105fe:	87b6                	mv	a5,a3
   10600:	00074803          	lbu	a6,0(a4)
   10604:	00080a63          	beqz	a6,10618 <vsnprintf+0x144>
   10608:	00178693          	addi	a3,a5,1
   1060c:	feb6f8e3          	bgeu	a3,a1,105fc <vsnprintf+0x128>
   10610:	97aa                	add	a5,a5,a0
   10612:	01078023          	sb	a6,0(a5)
   10616:	b7dd                	j	105fc <vsnprintf+0x128>
   10618:	4301                	li	t1,0
   1061a:	4681                	li	a3,0
   1061c:	a0b1                	j	10668 <vsnprintf+0x194>
   1061e:	00178713          	addi	a4,a5,1
   10622:	02b77e63          	bgeu	a4,a1,1065e <vsnprintf+0x18a>
   10626:	66a2                	ld	a3,8(sp)
   10628:	00868813          	addi	a6,a3,8
   1062c:	e442                	sd	a6,8(sp)
   1062e:	97aa                	add	a5,a5,a0
   10630:	0006c683          	lbu	a3,0(a3)
   10634:	00d78023          	sb	a3,0(a5)
   10638:	87ba                	mv	a5,a4
   1063a:	4301                	li	t1,0
   1063c:	4681                	li	a3,0
   1063e:	a02d                	j	10668 <vsnprintf+0x194>
   10640:	02500813          	li	a6,37
   10644:	03070163          	beq	a4,a6,10666 <vsnprintf+0x192>
   10648:	00178813          	addi	a6,a5,1
   1064c:	04b87463          	bgeu	a6,a1,10694 <vsnprintf+0x1c0>
   10650:	97aa                	add	a5,a5,a0
   10652:	00e78023          	sb	a4,0(a5)
   10656:	87c2                	mv	a5,a6
   10658:	a801                	j	10668 <vsnprintf+0x194>
   1065a:	8336                	mv	t1,a3
   1065c:	a031                	j	10668 <vsnprintf+0x194>
   1065e:	87ba                	mv	a5,a4
   10660:	4301                	li	t1,0
   10662:	4681                	li	a3,0
   10664:	a011                	j	10668 <vsnprintf+0x194>
   10666:	4685                	li	a3,1
   10668:	0605                	addi	a2,a2,1
   1066a:	00064703          	lbu	a4,0(a2)
   1066e:	c70d                	beqz	a4,10698 <vsnprintf+0x1c4>
   10670:	dae1                	beqz	a3,10640 <vsnprintf+0x16c>
   10672:	f9d7071b          	addiw	a4,a4,-99
   10676:	0ff77893          	zext.b	a7,a4
   1067a:	4855                	li	a6,21
   1067c:	ff1866e3          	bltu	a6,a7,10668 <vsnprintf+0x194>
   10680:	00289713          	slli	a4,a7,0x2
   10684:	00000817          	auipc	a6,0x0
   10688:	32880813          	addi	a6,a6,808 # 109ac <safestrcpy+0xe2>
   1068c:	9742                	add	a4,a4,a6
   1068e:	4318                	lw	a4,0(a4)
   10690:	9742                	add	a4,a4,a6
   10692:	8702                	jr	a4
   10694:	87c2                	mv	a5,a6
   10696:	bfc9                	j	10668 <vsnprintf+0x194>
   10698:	00b7f963          	bgeu	a5,a1,106aa <vsnprintf+0x1d6>
   1069c:	953e                	add	a0,a0,a5
   1069e:	00050023          	sb	zero,0(a0)
   106a2:	0007851b          	sext.w	a0,a5
   106a6:	0141                	addi	sp,sp,16
   106a8:	8082                	ret
   106aa:	dde5                	beqz	a1,106a2 <vsnprintf+0x1ce>
   106ac:	15fd                	addi	a1,a1,-1
   106ae:	952e                	add	a0,a0,a1
   106b0:	00050023          	sb	zero,0(a0)
   106b4:	b7fd                	j	106a2 <vsnprintf+0x1ce>

00000000000106b6 <memcpy>:
   106b6:	00a5e7b3          	or	a5,a1,a0
   106ba:	8b9d                	andi	a5,a5,7
   106bc:	c399                	beqz	a5,106c2 <memcpy+0xc>
   106be:	87aa                	mv	a5,a0
   106c0:	a015                	j	106e4 <memcpy+0x2e>
   106c2:	87aa                	mv	a5,a0
   106c4:	ff960713          	addi	a4,a2,-7
   106c8:	972a                	add	a4,a4,a0
   106ca:	00e7fd63          	bgeu	a5,a4,106e4 <memcpy+0x2e>
   106ce:	6198                	ld	a4,0(a1)
   106d0:	e398                	sd	a4,0(a5)
   106d2:	07a1                	addi	a5,a5,8
   106d4:	05a1                	addi	a1,a1,8
   106d6:	b7fd                	j	106c4 <memcpy+0xe>
   106d8:	0005c703          	lbu	a4,0(a1)
   106dc:	00e78023          	sb	a4,0(a5)
   106e0:	0785                	addi	a5,a5,1
   106e2:	0585                	addi	a1,a1,1
   106e4:	00c50733          	add	a4,a0,a2
   106e8:	fee7e8e3          	bltu	a5,a4,106d8 <memcpy+0x22>
   106ec:	8082                	ret

00000000000106ee <memset>:
   106ee:	00c567b3          	or	a5,a0,a2
   106f2:	8b9d                	andi	a5,a5,7
   106f4:	ef8d                	bnez	a5,1072e <memset+0x40>
   106f6:	0ff5f593          	zext.b	a1,a1
   106fa:	00859713          	slli	a4,a1,0x8
   106fe:	8f4d                	or	a4,a4,a1
   10700:	01071793          	slli	a5,a4,0x10
   10704:	8fd9                	or	a5,a5,a4
   10706:	02079693          	slli	a3,a5,0x20
   1070a:	8edd                	or	a3,a3,a5
   1070c:	87aa                	mv	a5,a0
   1070e:	a019                	j	10714 <memset+0x26>
   10710:	e394                	sd	a3,0(a5)
   10712:	07a1                	addi	a5,a5,8
   10714:	00c50733          	add	a4,a0,a2
   10718:	fee7ece3          	bltu	a5,a4,10710 <memset+0x22>
   1071c:	8082                	ret
   1071e:	00b78023          	sb	a1,0(a5)
   10722:	0785                	addi	a5,a5,1
   10724:	00c50733          	add	a4,a0,a2
   10728:	fee7ebe3          	bltu	a5,a4,1071e <memset+0x30>
   1072c:	8082                	ret
   1072e:	87aa                	mv	a5,a0
   10730:	bfd5                	j	10724 <memset+0x36>

0000000000010732 <strlen>:
   10732:	87aa                	mv	a5,a0
   10734:	a011                	j	10738 <strlen+0x6>
   10736:	0785                	addi	a5,a5,1
   10738:	0007c703          	lbu	a4,0(a5)
   1073c:	ff6d                	bnez	a4,10736 <strlen+0x4>
   1073e:	40a78533          	sub	a0,a5,a0
   10742:	8082                	ret

0000000000010744 <strcmp>:
   10744:	00054703          	lbu	a4,0(a0)
   10748:	0505                	addi	a0,a0,1
   1074a:	0005c783          	lbu	a5,0(a1)
   1074e:	0585                	addi	a1,a1,1
   10750:	c319                	beqz	a4,10756 <strcmp+0x12>
   10752:	fef709e3          	beq	a4,a5,10744 <strcmp>
   10756:	40f7053b          	subw	a0,a4,a5
   1075a:	8082                	ret

000000000001075c <strcpy>:
   1075c:	86aa                	mv	a3,a0
   1075e:	0005c703          	lbu	a4,0(a1)
   10762:	0585                	addi	a1,a1,1
   10764:	00e68023          	sb	a4,0(a3)
   10768:	0685                	addi	a3,a3,1
   1076a:	fb75                	bnez	a4,1075e <strcpy+0x2>
   1076c:	8082                	ret

000000000001076e <strchr>:
   1076e:	0ff5f593          	zext.b	a1,a1
   10772:	a011                	j	10776 <strchr+0x8>
   10774:	0505                	addi	a0,a0,1
   10776:	00054783          	lbu	a5,0(a0)
   1077a:	00b78463          	beq	a5,a1,10782 <strchr+0x14>
   1077e:	fbfd                	bnez	a5,10774 <strchr+0x6>
   10780:	4501                	li	a0,0
   10782:	8082                	ret

0000000000010784 <strtok>:
   10784:	7179                	addi	sp,sp,-48
   10786:	f406                	sd	ra,40(sp)
   10788:	f022                	sd	s0,32(sp)
   1078a:	ec26                	sd	s1,24(sp)
   1078c:	e84a                	sd	s2,16(sp)
   1078e:	e44e                	sd	s3,8(sp)
   10790:	89ae                	mv	s3,a1
   10792:	c509                	beqz	a0,1079c <strtok+0x18>
   10794:	00001797          	auipc	a5,0x1
   10798:	26a7ba23          	sd	a0,628(a5) # 11a08 <current.0>
   1079c:	00001417          	auipc	s0,0x1
   107a0:	26c43403          	ld	s0,620(s0) # 11a08 <current.0>
   107a4:	e019                	bnez	s0,107aa <strtok+0x26>
   107a6:	a0b1                	j	107f2 <strtok+0x6e>
   107a8:	0405                	addi	s0,s0,1
   107aa:	00044483          	lbu	s1,0(s0)
   107ae:	c491                	beqz	s1,107ba <strtok+0x36>
   107b0:	85a6                	mv	a1,s1
   107b2:	854e                	mv	a0,s3
   107b4:	fbbff0ef          	jal	ra,1076e <strchr>
   107b8:	f965                	bnez	a0,107a8 <strtok+0x24>
   107ba:	cc89                	beqz	s1,107d4 <strtok+0x50>
   107bc:	84a2                	mv	s1,s0
   107be:	0004c903          	lbu	s2,0(s1)
   107c2:	00090f63          	beqz	s2,107e0 <strtok+0x5c>
   107c6:	85ca                	mv	a1,s2
   107c8:	854e                	mv	a0,s3
   107ca:	fa5ff0ef          	jal	ra,1076e <strchr>
   107ce:	e909                	bnez	a0,107e0 <strtok+0x5c>
   107d0:	0485                	addi	s1,s1,1
   107d2:	b7f5                	j	107be <strtok+0x3a>
   107d4:	00001797          	auipc	a5,0x1
   107d8:	2207ba23          	sd	zero,564(a5) # 11a08 <current.0>
   107dc:	4401                	li	s0,0
   107de:	a811                	j	107f2 <strtok+0x6e>
   107e0:	02090163          	beqz	s2,10802 <strtok+0x7e>
   107e4:	00048023          	sb	zero,0(s1)
   107e8:	0485                	addi	s1,s1,1
   107ea:	00001797          	auipc	a5,0x1
   107ee:	2097bf23          	sd	s1,542(a5) # 11a08 <current.0>
   107f2:	8522                	mv	a0,s0
   107f4:	70a2                	ld	ra,40(sp)
   107f6:	7402                	ld	s0,32(sp)
   107f8:	64e2                	ld	s1,24(sp)
   107fa:	6942                	ld	s2,16(sp)
   107fc:	69a2                	ld	s3,8(sp)
   107fe:	6145                	addi	sp,sp,48
   10800:	8082                	ret
   10802:	00001797          	auipc	a5,0x1
   10806:	2007b323          	sd	zero,518(a5) # 11a08 <current.0>
   1080a:	b7e5                	j	107f2 <strtok+0x6e>

000000000001080c <strcat>:
   1080c:	1101                	addi	sp,sp,-32
   1080e:	ec06                	sd	ra,24(sp)
   10810:	e822                	sd	s0,16(sp)
   10812:	e426                	sd	s1,8(sp)
   10814:	842a                	mv	s0,a0
   10816:	84ae                	mv	s1,a1
   10818:	f1bff0ef          	jal	ra,10732 <strlen>
   1081c:	85a6                	mv	a1,s1
   1081e:	9522                	add	a0,a0,s0
   10820:	f3dff0ef          	jal	ra,1075c <strcpy>
   10824:	8522                	mv	a0,s0
   10826:	60e2                	ld	ra,24(sp)
   10828:	6442                	ld	s0,16(sp)
   1082a:	64a2                	ld	s1,8(sp)
   1082c:	6105                	addi	sp,sp,32
   1082e:	8082                	ret

0000000000010830 <atol>:
   10830:	87aa                	mv	a5,a0
   10832:	a011                	j	10836 <atol+0x6>
   10834:	0785                	addi	a5,a5,1
   10836:	0007c703          	lbu	a4,0(a5)
   1083a:	02000693          	li	a3,32
   1083e:	fed70be3          	beq	a4,a3,10834 <atol+0x4>
   10842:	02d00693          	li	a3,45
   10846:	00d70863          	beq	a4,a3,10856 <atol+0x26>
   1084a:	02b00693          	li	a3,43
   1084e:	00d70463          	beq	a4,a3,10856 <atol+0x26>
   10852:	4601                	li	a2,0
   10854:	a031                	j	10860 <atol+0x30>
   10856:	fd370713          	addi	a4,a4,-45
   1085a:	00173613          	seqz	a2,a4
   1085e:	0785                	addi	a5,a5,1
   10860:	4501                	li	a0,0
   10862:	a811                	j	10876 <atol+0x46>
   10864:	00251713          	slli	a4,a0,0x2
   10868:	972a                	add	a4,a4,a0
   1086a:	0706                	slli	a4,a4,0x1
   1086c:	0785                	addi	a5,a5,1
   1086e:	fd06869b          	addiw	a3,a3,-48
   10872:	00e68533          	add	a0,a3,a4
   10876:	0007c683          	lbu	a3,0(a5)
   1087a:	f6ed                	bnez	a3,10864 <atol+0x34>
   1087c:	c219                	beqz	a2,10882 <atol+0x52>
   1087e:	40a00533          	neg	a0,a0
   10882:	8082                	ret

0000000000010884 <memmove>:
   10884:	02a5ff63          	bgeu	a1,a0,108c2 <memmove+0x3e>
   10888:	00c587b3          	add	a5,a1,a2
   1088c:	02f57d63          	bgeu	a0,a5,108c6 <memmove+0x42>
   10890:	00c50733          	add	a4,a0,a2
   10894:	a801                	j	108a4 <memmove+0x20>
   10896:	17fd                	addi	a5,a5,-1
   10898:	177d                	addi	a4,a4,-1
   1089a:	0007c603          	lbu	a2,0(a5)
   1089e:	00c70023          	sb	a2,0(a4)
   108a2:	8636                	mv	a2,a3
   108a4:	fff60693          	addi	a3,a2,-1
   108a8:	f67d                	bnez	a2,10896 <memmove+0x12>
   108aa:	8082                	ret
   108ac:	0005c683          	lbu	a3,0(a1)
   108b0:	00d78023          	sb	a3,0(a5)
   108b4:	0785                	addi	a5,a5,1
   108b6:	0585                	addi	a1,a1,1
   108b8:	863a                	mv	a2,a4
   108ba:	fff60713          	addi	a4,a2,-1
   108be:	f67d                	bnez	a2,108ac <memmove+0x28>
   108c0:	8082                	ret
   108c2:	87aa                	mv	a5,a0
   108c4:	bfdd                	j	108ba <memmove+0x36>
   108c6:	87aa                	mv	a5,a0
   108c8:	bfcd                	j	108ba <memmove+0x36>

00000000000108ca <safestrcpy>:
   108ca:	02c05563          	blez	a2,108f4 <safestrcpy+0x2a>
   108ce:	87aa                	mv	a5,a0
   108d0:	a019                	j	108d6 <safestrcpy+0xc>
   108d2:	85c2                	mv	a1,a6
   108d4:	87b6                	mv	a5,a3
   108d6:	367d                	addiw	a2,a2,-1
   108d8:	00c05c63          	blez	a2,108f0 <safestrcpy+0x26>
   108dc:	00158813          	addi	a6,a1,1
   108e0:	00178693          	addi	a3,a5,1
   108e4:	0005c703          	lbu	a4,0(a1)
   108e8:	00e78023          	sb	a4,0(a5)
   108ec:	f37d                	bnez	a4,108d2 <safestrcpy+0x8>
   108ee:	87b6                	mv	a5,a3
   108f0:	00078023          	sb	zero,0(a5)
   108f4:	8082                	ret
