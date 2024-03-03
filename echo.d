
hostfs_root/bin/app_echo:     file format elf64-littleriscv


Disassembly of section .text:

00000000000100b0 <main>:
   100b0:	1101                	addi	sp,sp,-32
   100b2:	ec06                	sd	ra,24(sp)
   100b4:	e822                	sd	s0,16(sp)
   100b6:	00001797          	auipc	a5,0x1
   100ba:	80a78793          	addi	a5,a5,-2038 # 108c0 <safestrcpy+0x98>
   100be:	6398                	ld	a4,0(a5)
   100c0:	e03a                	sd	a4,0(sp)
   100c2:	479c                	lw	a5,8(a5)
   100c4:	c43e                	sw	a5,8(sp)
   100c6:	6180                	ld	s0,0(a1)
   100c8:	00000517          	auipc	a0,0x0
   100cc:	79050513          	addi	a0,a0,1936 # 10858 <safestrcpy+0x30>
   100d0:	06e000ef          	jal	ra,1013e <printu>
   100d4:	85a2                	mv	a1,s0
   100d6:	00000517          	auipc	a0,0x0
   100da:	7aa50513          	addi	a0,a0,1962 # 10880 <safestrcpy+0x58>
   100de:	060000ef          	jal	ra,1013e <printu>
   100e2:	04200593          	li	a1,66
   100e6:	8522                	mv	a0,s0
   100e8:	14c000ef          	jal	ra,10234 <open>
   100ec:	842a                	mv	s0,a0
   100ee:	85aa                	mv	a1,a0
   100f0:	00000517          	auipc	a0,0x0
   100f4:	7a050513          	addi	a0,a0,1952 # 10890 <safestrcpy+0x68>
   100f8:	046000ef          	jal	ra,1013e <printu>
   100fc:	850a                	mv	a0,sp
   100fe:	592000ef          	jal	ra,10690 <strlen>
   10102:	862a                	mv	a2,a0
   10104:	858a                	mv	a1,sp
   10106:	8522                	mv	a0,s0
   10108:	170000ef          	jal	ra,10278 <write_u>
   1010c:	858a                	mv	a1,sp
   1010e:	00000517          	auipc	a0,0x0
   10112:	79a50513          	addi	a0,a0,1946 # 108a8 <safestrcpy+0x80>
   10116:	028000ef          	jal	ra,1013e <printu>
   1011a:	8522                	mv	a0,s0
   1011c:	2b0000ef          	jal	ra,103cc <close>
   10120:	4501                	li	a0,0
   10122:	06e000ef          	jal	ra,10190 <exit>
   10126:	4501                	li	a0,0
   10128:	60e2                	ld	ra,24(sp)
   1012a:	6442                	ld	s0,16(sp)
   1012c:	6105                	addi	sp,sp,32
   1012e:	8082                	ret

0000000000010130 <do_user_call>:
   10130:	1141                	addi	sp,sp,-16
   10132:	00000073          	ecall
   10136:	c62a                	sw	a0,12(sp)
   10138:	4532                	lw	a0,12(sp)
   1013a:	0141                	addi	sp,sp,16
   1013c:	8082                	ret

000000000001013e <printu>:
   1013e:	710d                	addi	sp,sp,-352
   10140:	ee06                	sd	ra,280(sp)
   10142:	f62e                	sd	a1,296(sp)
   10144:	fa32                	sd	a2,304(sp)
   10146:	fe36                	sd	a3,312(sp)
   10148:	e2ba                	sd	a4,320(sp)
   1014a:	e6be                	sd	a5,328(sp)
   1014c:	eac2                	sd	a6,336(sp)
   1014e:	eec6                	sd	a7,344(sp)
   10150:	1234                	addi	a3,sp,296
   10152:	e636                	sd	a3,264(sp)
   10154:	862a                	mv	a2,a0
   10156:	10000593          	li	a1,256
   1015a:	0028                	addi	a0,sp,8
   1015c:	2d6000ef          	jal	ra,10432 <vsnprintf>
   10160:	0005071b          	sext.w	a4,a0
   10164:	0ff00793          	li	a5,255
   10168:	02e7e163          	bltu	a5,a4,1018a <printu+0x4c>
   1016c:	862a                	mv	a2,a0
   1016e:	4881                	li	a7,0
   10170:	4801                	li	a6,0
   10172:	4781                	li	a5,0
   10174:	4701                	li	a4,0
   10176:	4681                	li	a3,0
   10178:	002c                	addi	a1,sp,8
   1017a:	04000513          	li	a0,64
   1017e:	fb3ff0ef          	jal	ra,10130 <do_user_call>
   10182:	2501                	sext.w	a0,a0
   10184:	60f2                	ld	ra,280(sp)
   10186:	6135                	addi	sp,sp,352
   10188:	8082                	ret
   1018a:	10000613          	li	a2,256
   1018e:	b7c5                	j	1016e <printu+0x30>

0000000000010190 <exit>:
   10190:	1141                	addi	sp,sp,-16
   10192:	e406                	sd	ra,8(sp)
   10194:	85aa                	mv	a1,a0
   10196:	4881                	li	a7,0
   10198:	4801                	li	a6,0
   1019a:	4781                	li	a5,0
   1019c:	4701                	li	a4,0
   1019e:	4681                	li	a3,0
   101a0:	4601                	li	a2,0
   101a2:	04100513          	li	a0,65
   101a6:	f8bff0ef          	jal	ra,10130 <do_user_call>
   101aa:	2501                	sext.w	a0,a0
   101ac:	60a2                	ld	ra,8(sp)
   101ae:	0141                	addi	sp,sp,16
   101b0:	8082                	ret

00000000000101b2 <naive_malloc>:
   101b2:	1141                	addi	sp,sp,-16
   101b4:	e406                	sd	ra,8(sp)
   101b6:	4881                	li	a7,0
   101b8:	4801                	li	a6,0
   101ba:	4781                	li	a5,0
   101bc:	4701                	li	a4,0
   101be:	4681                	li	a3,0
   101c0:	4601                	li	a2,0
   101c2:	4581                	li	a1,0
   101c4:	04200513          	li	a0,66
   101c8:	f69ff0ef          	jal	ra,10130 <do_user_call>
   101cc:	60a2                	ld	ra,8(sp)
   101ce:	0141                	addi	sp,sp,16
   101d0:	8082                	ret

00000000000101d2 <naive_free>:
   101d2:	1141                	addi	sp,sp,-16
   101d4:	e406                	sd	ra,8(sp)
   101d6:	85aa                	mv	a1,a0
   101d8:	4881                	li	a7,0
   101da:	4801                	li	a6,0
   101dc:	4781                	li	a5,0
   101de:	4701                	li	a4,0
   101e0:	4681                	li	a3,0
   101e2:	4601                	li	a2,0
   101e4:	04300513          	li	a0,67
   101e8:	f49ff0ef          	jal	ra,10130 <do_user_call>
   101ec:	60a2                	ld	ra,8(sp)
   101ee:	0141                	addi	sp,sp,16
   101f0:	8082                	ret

00000000000101f2 <fork>:
   101f2:	1141                	addi	sp,sp,-16
   101f4:	e406                	sd	ra,8(sp)
   101f6:	4881                	li	a7,0
   101f8:	4801                	li	a6,0
   101fa:	4781                	li	a5,0
   101fc:	4701                	li	a4,0
   101fe:	4681                	li	a3,0
   10200:	4601                	li	a2,0
   10202:	4581                	li	a1,0
   10204:	04400513          	li	a0,68
   10208:	f29ff0ef          	jal	ra,10130 <do_user_call>
   1020c:	2501                	sext.w	a0,a0
   1020e:	60a2                	ld	ra,8(sp)
   10210:	0141                	addi	sp,sp,16
   10212:	8082                	ret

0000000000010214 <yield>:
   10214:	1141                	addi	sp,sp,-16
   10216:	e406                	sd	ra,8(sp)
   10218:	4881                	li	a7,0
   1021a:	4801                	li	a6,0
   1021c:	4781                	li	a5,0
   1021e:	4701                	li	a4,0
   10220:	4681                	li	a3,0
   10222:	4601                	li	a2,0
   10224:	4581                	li	a1,0
   10226:	04500513          	li	a0,69
   1022a:	f07ff0ef          	jal	ra,10130 <do_user_call>
   1022e:	60a2                	ld	ra,8(sp)
   10230:	0141                	addi	sp,sp,16
   10232:	8082                	ret

0000000000010234 <open>:
   10234:	1141                	addi	sp,sp,-16
   10236:	e406                	sd	ra,8(sp)
   10238:	862e                	mv	a2,a1
   1023a:	4881                	li	a7,0
   1023c:	4801                	li	a6,0
   1023e:	4781                	li	a5,0
   10240:	4701                	li	a4,0
   10242:	4681                	li	a3,0
   10244:	85aa                	mv	a1,a0
   10246:	05100513          	li	a0,81
   1024a:	ee7ff0ef          	jal	ra,10130 <do_user_call>
   1024e:	2501                	sext.w	a0,a0
   10250:	60a2                	ld	ra,8(sp)
   10252:	0141                	addi	sp,sp,16
   10254:	8082                	ret

0000000000010256 <read_u>:
   10256:	1141                	addi	sp,sp,-16
   10258:	e406                	sd	ra,8(sp)
   1025a:	86b2                	mv	a3,a2
   1025c:	4881                	li	a7,0
   1025e:	4801                	li	a6,0
   10260:	4781                	li	a5,0
   10262:	4701                	li	a4,0
   10264:	862e                	mv	a2,a1
   10266:	85aa                	mv	a1,a0
   10268:	05200513          	li	a0,82
   1026c:	ec5ff0ef          	jal	ra,10130 <do_user_call>
   10270:	2501                	sext.w	a0,a0
   10272:	60a2                	ld	ra,8(sp)
   10274:	0141                	addi	sp,sp,16
   10276:	8082                	ret

0000000000010278 <write_u>:
   10278:	1141                	addi	sp,sp,-16
   1027a:	e406                	sd	ra,8(sp)
   1027c:	86b2                	mv	a3,a2
   1027e:	4881                	li	a7,0
   10280:	4801                	li	a6,0
   10282:	4781                	li	a5,0
   10284:	4701                	li	a4,0
   10286:	862e                	mv	a2,a1
   10288:	85aa                	mv	a1,a0
   1028a:	05300513          	li	a0,83
   1028e:	ea3ff0ef          	jal	ra,10130 <do_user_call>
   10292:	2501                	sext.w	a0,a0
   10294:	60a2                	ld	ra,8(sp)
   10296:	0141                	addi	sp,sp,16
   10298:	8082                	ret

000000000001029a <lseek_u>:
   1029a:	1141                	addi	sp,sp,-16
   1029c:	e406                	sd	ra,8(sp)
   1029e:	86b2                	mv	a3,a2
   102a0:	4881                	li	a7,0
   102a2:	4801                	li	a6,0
   102a4:	4781                	li	a5,0
   102a6:	4701                	li	a4,0
   102a8:	862e                	mv	a2,a1
   102aa:	85aa                	mv	a1,a0
   102ac:	05400513          	li	a0,84
   102b0:	e81ff0ef          	jal	ra,10130 <do_user_call>
   102b4:	2501                	sext.w	a0,a0
   102b6:	60a2                	ld	ra,8(sp)
   102b8:	0141                	addi	sp,sp,16
   102ba:	8082                	ret

00000000000102bc <stat_u>:
   102bc:	1141                	addi	sp,sp,-16
   102be:	e406                	sd	ra,8(sp)
   102c0:	862e                	mv	a2,a1
   102c2:	4881                	li	a7,0
   102c4:	4801                	li	a6,0
   102c6:	4781                	li	a5,0
   102c8:	4701                	li	a4,0
   102ca:	4681                	li	a3,0
   102cc:	85aa                	mv	a1,a0
   102ce:	05500513          	li	a0,85
   102d2:	e5fff0ef          	jal	ra,10130 <do_user_call>
   102d6:	2501                	sext.w	a0,a0
   102d8:	60a2                	ld	ra,8(sp)
   102da:	0141                	addi	sp,sp,16
   102dc:	8082                	ret

00000000000102de <disk_stat_u>:
   102de:	1141                	addi	sp,sp,-16
   102e0:	e406                	sd	ra,8(sp)
   102e2:	862e                	mv	a2,a1
   102e4:	4881                	li	a7,0
   102e6:	4801                	li	a6,0
   102e8:	4781                	li	a5,0
   102ea:	4701                	li	a4,0
   102ec:	4681                	li	a3,0
   102ee:	85aa                	mv	a1,a0
   102f0:	05600513          	li	a0,86
   102f4:	e3dff0ef          	jal	ra,10130 <do_user_call>
   102f8:	2501                	sext.w	a0,a0
   102fa:	60a2                	ld	ra,8(sp)
   102fc:	0141                	addi	sp,sp,16
   102fe:	8082                	ret

0000000000010300 <opendir_u>:
   10300:	1141                	addi	sp,sp,-16
   10302:	e406                	sd	ra,8(sp)
   10304:	85aa                	mv	a1,a0
   10306:	4881                	li	a7,0
   10308:	4801                	li	a6,0
   1030a:	4781                	li	a5,0
   1030c:	4701                	li	a4,0
   1030e:	4681                	li	a3,0
   10310:	4601                	li	a2,0
   10312:	05800513          	li	a0,88
   10316:	e1bff0ef          	jal	ra,10130 <do_user_call>
   1031a:	2501                	sext.w	a0,a0
   1031c:	60a2                	ld	ra,8(sp)
   1031e:	0141                	addi	sp,sp,16
   10320:	8082                	ret

0000000000010322 <readdir_u>:
   10322:	1141                	addi	sp,sp,-16
   10324:	e406                	sd	ra,8(sp)
   10326:	862e                	mv	a2,a1
   10328:	4881                	li	a7,0
   1032a:	4801                	li	a6,0
   1032c:	4781                	li	a5,0
   1032e:	4701                	li	a4,0
   10330:	4681                	li	a3,0
   10332:	85aa                	mv	a1,a0
   10334:	05900513          	li	a0,89
   10338:	df9ff0ef          	jal	ra,10130 <do_user_call>
   1033c:	2501                	sext.w	a0,a0
   1033e:	60a2                	ld	ra,8(sp)
   10340:	0141                	addi	sp,sp,16
   10342:	8082                	ret

0000000000010344 <mkdir_u>:
   10344:	1141                	addi	sp,sp,-16
   10346:	e406                	sd	ra,8(sp)
   10348:	85aa                	mv	a1,a0
   1034a:	4881                	li	a7,0
   1034c:	4801                	li	a6,0
   1034e:	4781                	li	a5,0
   10350:	4701                	li	a4,0
   10352:	4681                	li	a3,0
   10354:	4601                	li	a2,0
   10356:	05a00513          	li	a0,90
   1035a:	dd7ff0ef          	jal	ra,10130 <do_user_call>
   1035e:	2501                	sext.w	a0,a0
   10360:	60a2                	ld	ra,8(sp)
   10362:	0141                	addi	sp,sp,16
   10364:	8082                	ret

0000000000010366 <closedir_u>:
   10366:	1141                	addi	sp,sp,-16
   10368:	e406                	sd	ra,8(sp)
   1036a:	85aa                	mv	a1,a0
   1036c:	4881                	li	a7,0
   1036e:	4801                	li	a6,0
   10370:	4781                	li	a5,0
   10372:	4701                	li	a4,0
   10374:	4681                	li	a3,0
   10376:	4601                	li	a2,0
   10378:	05b00513          	li	a0,91
   1037c:	db5ff0ef          	jal	ra,10130 <do_user_call>
   10380:	2501                	sext.w	a0,a0
   10382:	60a2                	ld	ra,8(sp)
   10384:	0141                	addi	sp,sp,16
   10386:	8082                	ret

0000000000010388 <link_u>:
   10388:	1141                	addi	sp,sp,-16
   1038a:	e406                	sd	ra,8(sp)
   1038c:	862e                	mv	a2,a1
   1038e:	4881                	li	a7,0
   10390:	4801                	li	a6,0
   10392:	4781                	li	a5,0
   10394:	4701                	li	a4,0
   10396:	4681                	li	a3,0
   10398:	85aa                	mv	a1,a0
   1039a:	05c00513          	li	a0,92
   1039e:	d93ff0ef          	jal	ra,10130 <do_user_call>
   103a2:	2501                	sext.w	a0,a0
   103a4:	60a2                	ld	ra,8(sp)
   103a6:	0141                	addi	sp,sp,16
   103a8:	8082                	ret

00000000000103aa <unlink_u>:
   103aa:	1141                	addi	sp,sp,-16
   103ac:	e406                	sd	ra,8(sp)
   103ae:	85aa                	mv	a1,a0
   103b0:	4881                	li	a7,0
   103b2:	4801                	li	a6,0
   103b4:	4781                	li	a5,0
   103b6:	4701                	li	a4,0
   103b8:	4681                	li	a3,0
   103ba:	4601                	li	a2,0
   103bc:	05d00513          	li	a0,93
   103c0:	d71ff0ef          	jal	ra,10130 <do_user_call>
   103c4:	2501                	sext.w	a0,a0
   103c6:	60a2                	ld	ra,8(sp)
   103c8:	0141                	addi	sp,sp,16
   103ca:	8082                	ret

00000000000103cc <close>:
   103cc:	1141                	addi	sp,sp,-16
   103ce:	e406                	sd	ra,8(sp)
   103d0:	85aa                	mv	a1,a0
   103d2:	4881                	li	a7,0
   103d4:	4801                	li	a6,0
   103d6:	4781                	li	a5,0
   103d8:	4701                	li	a4,0
   103da:	4681                	li	a3,0
   103dc:	4601                	li	a2,0
   103de:	05700513          	li	a0,87
   103e2:	d4fff0ef          	jal	ra,10130 <do_user_call>
   103e6:	2501                	sext.w	a0,a0
   103e8:	60a2                	ld	ra,8(sp)
   103ea:	0141                	addi	sp,sp,16
   103ec:	8082                	ret

00000000000103ee <wait>:
   103ee:	1141                	addi	sp,sp,-16
   103f0:	e406                	sd	ra,8(sp)
   103f2:	85aa                	mv	a1,a0
   103f4:	4881                	li	a7,0
   103f6:	4801                	li	a6,0
   103f8:	4781                	li	a5,0
   103fa:	4701                	li	a4,0
   103fc:	4681                	li	a3,0
   103fe:	4601                	li	a2,0
   10400:	04600513          	li	a0,70
   10404:	d2dff0ef          	jal	ra,10130 <do_user_call>
   10408:	2501                	sext.w	a0,a0
   1040a:	60a2                	ld	ra,8(sp)
   1040c:	0141                	addi	sp,sp,16
   1040e:	8082                	ret

0000000000010410 <exec>:
   10410:	1141                	addi	sp,sp,-16
   10412:	e406                	sd	ra,8(sp)
   10414:	862e                	mv	a2,a1
   10416:	4881                	li	a7,0
   10418:	4801                	li	a6,0
   1041a:	4781                	li	a5,0
   1041c:	4701                	li	a4,0
   1041e:	4681                	li	a3,0
   10420:	85aa                	mv	a1,a0
   10422:	05e00513          	li	a0,94
   10426:	d0bff0ef          	jal	ra,10130 <do_user_call>
   1042a:	2501                	sext.w	a0,a0
   1042c:	60a2                	ld	ra,8(sp)
   1042e:	0141                	addi	sp,sp,16
   10430:	8082                	ret

0000000000010432 <vsnprintf>:
   10432:	1141                	addi	sp,sp,-16
   10434:	e436                	sd	a3,8(sp)
   10436:	4781                	li	a5,0
   10438:	4301                	li	t1,0
   1043a:	4681                	li	a3,0
   1043c:	a271                	j	105c8 <vsnprintf+0x196>
   1043e:	00178713          	addi	a4,a5,1
   10442:	00b77863          	bgeu	a4,a1,10452 <vsnprintf+0x20>
   10446:	00f50833          	add	a6,a0,a5
   1044a:	03000893          	li	a7,48
   1044e:	01180023          	sb	a7,0(a6)
   10452:	0789                	addi	a5,a5,2
   10454:	00b7f763          	bgeu	a5,a1,10462 <vsnprintf+0x30>
   10458:	972a                	add	a4,a4,a0
   1045a:	07800813          	li	a6,120
   1045e:	01070023          	sb	a6,0(a4)
   10462:	6722                	ld	a4,8(sp)
   10464:	00870813          	addi	a6,a4,8
   10468:	e442                	sd	a6,8(sp)
   1046a:	00073883          	ld	a7,0(a4)
   1046e:	e6b9                	bnez	a3,104bc <vsnprintf+0x8a>
   10470:	469d                	li	a3,7
   10472:	a025                	j	1049a <vsnprintf+0x68>
   10474:	00030463          	beqz	t1,1047c <vsnprintf+0x4a>
   10478:	869a                	mv	a3,t1
   1047a:	b7e5                	j	10462 <vsnprintf+0x30>
   1047c:	6722                	ld	a4,8(sp)
   1047e:	00870693          	addi	a3,a4,8
   10482:	e436                	sd	a3,8(sp)
   10484:	00072883          	lw	a7,0(a4)
   10488:	869a                	mv	a3,t1
   1048a:	b7d5                	j	1046e <vsnprintf+0x3c>
   1048c:	05770713          	addi	a4,a4,87
   10490:	97aa                	add	a5,a5,a0
   10492:	00e78023          	sb	a4,0(a5)
   10496:	36fd                	addiw	a3,a3,-1
   10498:	87c2                	mv	a5,a6
   1049a:	0206c363          	bltz	a3,104c0 <vsnprintf+0x8e>
   1049e:	0026971b          	slliw	a4,a3,0x2
   104a2:	40e8d733          	sra	a4,a7,a4
   104a6:	8b3d                	andi	a4,a4,15
   104a8:	00178813          	addi	a6,a5,1
   104ac:	feb875e3          	bgeu	a6,a1,10496 <vsnprintf+0x64>
   104b0:	4325                	li	t1,9
   104b2:	fce34de3          	blt	t1,a4,1048c <vsnprintf+0x5a>
   104b6:	03070713          	addi	a4,a4,48
   104ba:	bfd9                	j	10490 <vsnprintf+0x5e>
   104bc:	46bd                	li	a3,15
   104be:	bff1                	j	1049a <vsnprintf+0x68>
   104c0:	4301                	li	t1,0
   104c2:	4681                	li	a3,0
   104c4:	a209                	j	105c6 <vsnprintf+0x194>
   104c6:	00030d63          	beqz	t1,104e0 <vsnprintf+0xae>
   104ca:	6722                	ld	a4,8(sp)
   104cc:	00870693          	addi	a3,a4,8
   104d0:	e436                	sd	a3,8(sp)
   104d2:	00073883          	ld	a7,0(a4)
   104d6:	0008cc63          	bltz	a7,104ee <vsnprintf+0xbc>
   104da:	8746                	mv	a4,a7
   104dc:	4305                	li	t1,1
   104de:	a805                	j	1050e <vsnprintf+0xdc>
   104e0:	6722                	ld	a4,8(sp)
   104e2:	00870693          	addi	a3,a4,8
   104e6:	e436                	sd	a3,8(sp)
   104e8:	00072883          	lw	a7,0(a4)
   104ec:	b7ed                	j	104d6 <vsnprintf+0xa4>
   104ee:	411008b3          	neg	a7,a7
   104f2:	00178713          	addi	a4,a5,1
   104f6:	00b77963          	bgeu	a4,a1,10508 <vsnprintf+0xd6>
   104fa:	97aa                	add	a5,a5,a0
   104fc:	02d00693          	li	a3,45
   10500:	00d78023          	sb	a3,0(a5)
   10504:	87ba                	mv	a5,a4
   10506:	bfd1                	j	104da <vsnprintf+0xa8>
   10508:	87ba                	mv	a5,a4
   1050a:	bfc1                	j	104da <vsnprintf+0xa8>
   1050c:	0305                	addi	t1,t1,1
   1050e:	46a9                	li	a3,10
   10510:	02d74733          	div	a4,a4,a3
   10514:	ff65                	bnez	a4,1050c <vsnprintf+0xda>
   10516:	fff3071b          	addiw	a4,t1,-1
   1051a:	a029                	j	10524 <vsnprintf+0xf2>
   1051c:	46a9                	li	a3,10
   1051e:	02d8c8b3          	div	a7,a7,a3
   10522:	377d                	addiw	a4,a4,-1
   10524:	02074163          	bltz	a4,10546 <vsnprintf+0x114>
   10528:	00f706b3          	add	a3,a4,a5
   1052c:	00168813          	addi	a6,a3,1
   10530:	feb876e3          	bgeu	a6,a1,1051c <vsnprintf+0xea>
   10534:	4829                	li	a6,10
   10536:	0308e833          	rem	a6,a7,a6
   1053a:	96aa                	add	a3,a3,a0
   1053c:	0308081b          	addiw	a6,a6,48
   10540:	01068023          	sb	a6,0(a3)
   10544:	bfe1                	j	1051c <vsnprintf+0xea>
   10546:	979a                	add	a5,a5,t1
   10548:	4301                	li	t1,0
   1054a:	4681                	li	a3,0
   1054c:	a8ad                	j	105c6 <vsnprintf+0x194>
   1054e:	6722                	ld	a4,8(sp)
   10550:	00870693          	addi	a3,a4,8
   10554:	e436                	sd	a3,8(sp)
   10556:	6318                	ld	a4,0(a4)
   10558:	a019                	j	1055e <vsnprintf+0x12c>
   1055a:	0705                	addi	a4,a4,1
   1055c:	87b6                	mv	a5,a3
   1055e:	00074803          	lbu	a6,0(a4)
   10562:	00080a63          	beqz	a6,10576 <vsnprintf+0x144>
   10566:	00178693          	addi	a3,a5,1
   1056a:	feb6f8e3          	bgeu	a3,a1,1055a <vsnprintf+0x128>
   1056e:	97aa                	add	a5,a5,a0
   10570:	01078023          	sb	a6,0(a5)
   10574:	b7dd                	j	1055a <vsnprintf+0x128>
   10576:	4301                	li	t1,0
   10578:	4681                	li	a3,0
   1057a:	a0b1                	j	105c6 <vsnprintf+0x194>
   1057c:	00178713          	addi	a4,a5,1
   10580:	02b77e63          	bgeu	a4,a1,105bc <vsnprintf+0x18a>
   10584:	66a2                	ld	a3,8(sp)
   10586:	00868813          	addi	a6,a3,8
   1058a:	e442                	sd	a6,8(sp)
   1058c:	97aa                	add	a5,a5,a0
   1058e:	0006c683          	lbu	a3,0(a3)
   10592:	00d78023          	sb	a3,0(a5)
   10596:	87ba                	mv	a5,a4
   10598:	4301                	li	t1,0
   1059a:	4681                	li	a3,0
   1059c:	a02d                	j	105c6 <vsnprintf+0x194>
   1059e:	02500813          	li	a6,37
   105a2:	03070163          	beq	a4,a6,105c4 <vsnprintf+0x192>
   105a6:	00178813          	addi	a6,a5,1
   105aa:	04b87463          	bgeu	a6,a1,105f2 <vsnprintf+0x1c0>
   105ae:	97aa                	add	a5,a5,a0
   105b0:	00e78023          	sb	a4,0(a5)
   105b4:	87c2                	mv	a5,a6
   105b6:	a801                	j	105c6 <vsnprintf+0x194>
   105b8:	8336                	mv	t1,a3
   105ba:	a031                	j	105c6 <vsnprintf+0x194>
   105bc:	87ba                	mv	a5,a4
   105be:	4301                	li	t1,0
   105c0:	4681                	li	a3,0
   105c2:	a011                	j	105c6 <vsnprintf+0x194>
   105c4:	4685                	li	a3,1
   105c6:	0605                	addi	a2,a2,1
   105c8:	00064703          	lbu	a4,0(a2)
   105cc:	c70d                	beqz	a4,105f6 <vsnprintf+0x1c4>
   105ce:	dae1                	beqz	a3,1059e <vsnprintf+0x16c>
   105d0:	f9d7071b          	addiw	a4,a4,-99
   105d4:	0ff77893          	zext.b	a7,a4
   105d8:	4855                	li	a6,21
   105da:	ff1866e3          	bltu	a6,a7,105c6 <vsnprintf+0x194>
   105de:	00289713          	slli	a4,a7,0x2
   105e2:	00000817          	auipc	a6,0x0
   105e6:	2ea80813          	addi	a6,a6,746 # 108cc <safestrcpy+0xa4>
   105ea:	9742                	add	a4,a4,a6
   105ec:	4318                	lw	a4,0(a4)
   105ee:	9742                	add	a4,a4,a6
   105f0:	8702                	jr	a4
   105f2:	87c2                	mv	a5,a6
   105f4:	bfc9                	j	105c6 <vsnprintf+0x194>
   105f6:	00b7f963          	bgeu	a5,a1,10608 <vsnprintf+0x1d6>
   105fa:	953e                	add	a0,a0,a5
   105fc:	00050023          	sb	zero,0(a0)
   10600:	0007851b          	sext.w	a0,a5
   10604:	0141                	addi	sp,sp,16
   10606:	8082                	ret
   10608:	dde5                	beqz	a1,10600 <vsnprintf+0x1ce>
   1060a:	15fd                	addi	a1,a1,-1
   1060c:	952e                	add	a0,a0,a1
   1060e:	00050023          	sb	zero,0(a0)
   10612:	b7fd                	j	10600 <vsnprintf+0x1ce>

0000000000010614 <memcpy>:
   10614:	00a5e7b3          	or	a5,a1,a0
   10618:	8b9d                	andi	a5,a5,7
   1061a:	c399                	beqz	a5,10620 <memcpy+0xc>
   1061c:	87aa                	mv	a5,a0
   1061e:	a015                	j	10642 <memcpy+0x2e>
   10620:	87aa                	mv	a5,a0
   10622:	ff960713          	addi	a4,a2,-7
   10626:	972a                	add	a4,a4,a0
   10628:	00e7fd63          	bgeu	a5,a4,10642 <memcpy+0x2e>
   1062c:	6198                	ld	a4,0(a1)
   1062e:	e398                	sd	a4,0(a5)
   10630:	07a1                	addi	a5,a5,8
   10632:	05a1                	addi	a1,a1,8
   10634:	b7fd                	j	10622 <memcpy+0xe>
   10636:	0005c703          	lbu	a4,0(a1)
   1063a:	00e78023          	sb	a4,0(a5)
   1063e:	0785                	addi	a5,a5,1
   10640:	0585                	addi	a1,a1,1
   10642:	00c50733          	add	a4,a0,a2
   10646:	fee7e8e3          	bltu	a5,a4,10636 <memcpy+0x22>
   1064a:	8082                	ret

000000000001064c <memset>:
   1064c:	00c567b3          	or	a5,a0,a2
   10650:	8b9d                	andi	a5,a5,7
   10652:	ef8d                	bnez	a5,1068c <memset+0x40>
   10654:	0ff5f593          	zext.b	a1,a1
   10658:	00859713          	slli	a4,a1,0x8
   1065c:	8f4d                	or	a4,a4,a1
   1065e:	01071793          	slli	a5,a4,0x10
   10662:	8fd9                	or	a5,a5,a4
   10664:	02079693          	slli	a3,a5,0x20
   10668:	8edd                	or	a3,a3,a5
   1066a:	87aa                	mv	a5,a0
   1066c:	a019                	j	10672 <memset+0x26>
   1066e:	e394                	sd	a3,0(a5)
   10670:	07a1                	addi	a5,a5,8
   10672:	00c50733          	add	a4,a0,a2
   10676:	fee7ece3          	bltu	a5,a4,1066e <memset+0x22>
   1067a:	8082                	ret
   1067c:	00b78023          	sb	a1,0(a5)
   10680:	0785                	addi	a5,a5,1
   10682:	00c50733          	add	a4,a0,a2
   10686:	fee7ebe3          	bltu	a5,a4,1067c <memset+0x30>
   1068a:	8082                	ret
   1068c:	87aa                	mv	a5,a0
   1068e:	bfd5                	j	10682 <memset+0x36>

0000000000010690 <strlen>:
   10690:	87aa                	mv	a5,a0
   10692:	a011                	j	10696 <strlen+0x6>
   10694:	0785                	addi	a5,a5,1
   10696:	0007c703          	lbu	a4,0(a5)
   1069a:	ff6d                	bnez	a4,10694 <strlen+0x4>
   1069c:	40a78533          	sub	a0,a5,a0
   106a0:	8082                	ret

00000000000106a2 <strcmp>:
   106a2:	00054703          	lbu	a4,0(a0)
   106a6:	0505                	addi	a0,a0,1
   106a8:	0005c783          	lbu	a5,0(a1)
   106ac:	0585                	addi	a1,a1,1
   106ae:	c319                	beqz	a4,106b4 <strcmp+0x12>
   106b0:	fef709e3          	beq	a4,a5,106a2 <strcmp>
   106b4:	40f7053b          	subw	a0,a4,a5
   106b8:	8082                	ret

00000000000106ba <strcpy>:
   106ba:	86aa                	mv	a3,a0
   106bc:	0005c703          	lbu	a4,0(a1)
   106c0:	0585                	addi	a1,a1,1
   106c2:	00e68023          	sb	a4,0(a3)
   106c6:	0685                	addi	a3,a3,1
   106c8:	fb75                	bnez	a4,106bc <strcpy+0x2>
   106ca:	8082                	ret

00000000000106cc <strchr>:
   106cc:	0ff5f593          	zext.b	a1,a1
   106d0:	a011                	j	106d4 <strchr+0x8>
   106d2:	0505                	addi	a0,a0,1
   106d4:	00054783          	lbu	a5,0(a0)
   106d8:	00b78463          	beq	a5,a1,106e0 <strchr+0x14>
   106dc:	fbfd                	bnez	a5,106d2 <strchr+0x6>
   106de:	4501                	li	a0,0
   106e0:	8082                	ret

00000000000106e2 <strtok>:
   106e2:	7179                	addi	sp,sp,-48
   106e4:	f406                	sd	ra,40(sp)
   106e6:	f022                	sd	s0,32(sp)
   106e8:	ec26                	sd	s1,24(sp)
   106ea:	e84a                	sd	s2,16(sp)
   106ec:	e44e                	sd	s3,8(sp)
   106ee:	89ae                	mv	s3,a1
   106f0:	c509                	beqz	a0,106fa <strtok+0x18>
   106f2:	00001797          	auipc	a5,0x1
   106f6:	22a7bb23          	sd	a0,566(a5) # 11928 <current.0>
   106fa:	00001417          	auipc	s0,0x1
   106fe:	22e43403          	ld	s0,558(s0) # 11928 <current.0>
   10702:	e019                	bnez	s0,10708 <strtok+0x26>
   10704:	a0b1                	j	10750 <strtok+0x6e>
   10706:	0405                	addi	s0,s0,1
   10708:	00044483          	lbu	s1,0(s0)
   1070c:	c491                	beqz	s1,10718 <strtok+0x36>
   1070e:	85a6                	mv	a1,s1
   10710:	854e                	mv	a0,s3
   10712:	fbbff0ef          	jal	ra,106cc <strchr>
   10716:	f965                	bnez	a0,10706 <strtok+0x24>
   10718:	cc89                	beqz	s1,10732 <strtok+0x50>
   1071a:	84a2                	mv	s1,s0
   1071c:	0004c903          	lbu	s2,0(s1)
   10720:	00090f63          	beqz	s2,1073e <strtok+0x5c>
   10724:	85ca                	mv	a1,s2
   10726:	854e                	mv	a0,s3
   10728:	fa5ff0ef          	jal	ra,106cc <strchr>
   1072c:	e909                	bnez	a0,1073e <strtok+0x5c>
   1072e:	0485                	addi	s1,s1,1
   10730:	b7f5                	j	1071c <strtok+0x3a>
   10732:	00001797          	auipc	a5,0x1
   10736:	1e07bb23          	sd	zero,502(a5) # 11928 <current.0>
   1073a:	4401                	li	s0,0
   1073c:	a811                	j	10750 <strtok+0x6e>
   1073e:	02090163          	beqz	s2,10760 <strtok+0x7e>
   10742:	00048023          	sb	zero,0(s1)
   10746:	0485                	addi	s1,s1,1
   10748:	00001797          	auipc	a5,0x1
   1074c:	1e97b023          	sd	s1,480(a5) # 11928 <current.0>
   10750:	8522                	mv	a0,s0
   10752:	70a2                	ld	ra,40(sp)
   10754:	7402                	ld	s0,32(sp)
   10756:	64e2                	ld	s1,24(sp)
   10758:	6942                	ld	s2,16(sp)
   1075a:	69a2                	ld	s3,8(sp)
   1075c:	6145                	addi	sp,sp,48
   1075e:	8082                	ret
   10760:	00001797          	auipc	a5,0x1
   10764:	1c07b423          	sd	zero,456(a5) # 11928 <current.0>
   10768:	b7e5                	j	10750 <strtok+0x6e>

000000000001076a <strcat>:
   1076a:	1101                	addi	sp,sp,-32
   1076c:	ec06                	sd	ra,24(sp)
   1076e:	e822                	sd	s0,16(sp)
   10770:	e426                	sd	s1,8(sp)
   10772:	842a                	mv	s0,a0
   10774:	84ae                	mv	s1,a1
   10776:	f1bff0ef          	jal	ra,10690 <strlen>
   1077a:	85a6                	mv	a1,s1
   1077c:	9522                	add	a0,a0,s0
   1077e:	f3dff0ef          	jal	ra,106ba <strcpy>
   10782:	8522                	mv	a0,s0
   10784:	60e2                	ld	ra,24(sp)
   10786:	6442                	ld	s0,16(sp)
   10788:	64a2                	ld	s1,8(sp)
   1078a:	6105                	addi	sp,sp,32
   1078c:	8082                	ret

000000000001078e <atol>:
   1078e:	87aa                	mv	a5,a0
   10790:	a011                	j	10794 <atol+0x6>
   10792:	0785                	addi	a5,a5,1
   10794:	0007c703          	lbu	a4,0(a5)
   10798:	02000693          	li	a3,32
   1079c:	fed70be3          	beq	a4,a3,10792 <atol+0x4>
   107a0:	02d00693          	li	a3,45
   107a4:	00d70863          	beq	a4,a3,107b4 <atol+0x26>
   107a8:	02b00693          	li	a3,43
   107ac:	00d70463          	beq	a4,a3,107b4 <atol+0x26>
   107b0:	4601                	li	a2,0
   107b2:	a031                	j	107be <atol+0x30>
   107b4:	fd370713          	addi	a4,a4,-45
   107b8:	00173613          	seqz	a2,a4
   107bc:	0785                	addi	a5,a5,1
   107be:	4501                	li	a0,0
   107c0:	a811                	j	107d4 <atol+0x46>
   107c2:	00251713          	slli	a4,a0,0x2
   107c6:	972a                	add	a4,a4,a0
   107c8:	0706                	slli	a4,a4,0x1
   107ca:	0785                	addi	a5,a5,1
   107cc:	fd06869b          	addiw	a3,a3,-48
   107d0:	00e68533          	add	a0,a3,a4
   107d4:	0007c683          	lbu	a3,0(a5)
   107d8:	f6ed                	bnez	a3,107c2 <atol+0x34>
   107da:	c219                	beqz	a2,107e0 <atol+0x52>
   107dc:	40a00533          	neg	a0,a0
   107e0:	8082                	ret

00000000000107e2 <memmove>:
   107e2:	02a5ff63          	bgeu	a1,a0,10820 <memmove+0x3e>
   107e6:	00c587b3          	add	a5,a1,a2
   107ea:	02f57d63          	bgeu	a0,a5,10824 <memmove+0x42>
   107ee:	00c50733          	add	a4,a0,a2
   107f2:	a801                	j	10802 <memmove+0x20>
   107f4:	17fd                	addi	a5,a5,-1
   107f6:	177d                	addi	a4,a4,-1
   107f8:	0007c603          	lbu	a2,0(a5)
   107fc:	00c70023          	sb	a2,0(a4)
   10800:	8636                	mv	a2,a3
   10802:	fff60693          	addi	a3,a2,-1
   10806:	f67d                	bnez	a2,107f4 <memmove+0x12>
   10808:	8082                	ret
   1080a:	0005c683          	lbu	a3,0(a1)
   1080e:	00d78023          	sb	a3,0(a5)
   10812:	0785                	addi	a5,a5,1
   10814:	0585                	addi	a1,a1,1
   10816:	863a                	mv	a2,a4
   10818:	fff60713          	addi	a4,a2,-1
   1081c:	f67d                	bnez	a2,1080a <memmove+0x28>
   1081e:	8082                	ret
   10820:	87aa                	mv	a5,a0
   10822:	bfdd                	j	10818 <memmove+0x36>
   10824:	87aa                	mv	a5,a0
   10826:	bfcd                	j	10818 <memmove+0x36>

0000000000010828 <safestrcpy>:
   10828:	02c05563          	blez	a2,10852 <safestrcpy+0x2a>
   1082c:	87aa                	mv	a5,a0
   1082e:	a019                	j	10834 <safestrcpy+0xc>
   10830:	85c2                	mv	a1,a6
   10832:	87b6                	mv	a5,a3
   10834:	367d                	addiw	a2,a2,-1
   10836:	00c05c63          	blez	a2,1084e <safestrcpy+0x26>
   1083a:	00158813          	addi	a6,a1,1
   1083e:	00178693          	addi	a3,a5,1
   10842:	0005c703          	lbu	a4,0(a1)
   10846:	00e78023          	sb	a4,0(a5)
   1084a:	f37d                	bnez	a4,10830 <safestrcpy+0x8>
   1084c:	87b6                	mv	a5,a3
   1084e:	00078023          	sb	zero,0(a5)
   10852:	8082                	ret
