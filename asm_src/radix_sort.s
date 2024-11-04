        .intel_syntax noprefix
        .globl main
        .text


get_max:
    mov eax, DWORD PTR[rdi] # max = arr[0]
    mov rcx, 1 # i
    jmp max_cond

max_body:
    cmp dword ptr [rdi + rcx * 4], eax
    jle max_next
    mov eax, dword ptr [rdi + rcx * 4]
max_next:
    inc rcx

max_cond:
    cmp rcx, rsi # i < n
    jl max_body

    ret


count_sort:
    push       rbp
    mov        rbp, rsp

    mov rbx, rsi ## Lokális változók mérete
    mov r15d, edx ##                    exp
    add rbx, 11
    imul rbx, rbx, 4
    sub rsp, rbx

    mov DWORD PTR [rbp-44], 10
    mov DWORD PTR [rbp-40], 0
    mov DWORD PTR [rbp-36], 0
    mov DWORD PTR [rbp-32], 0
    mov DWORD PTR [rbp-28], 0
    mov DWORD PTR [rbp-24], 0    
    mov DWORD PTR [rbp-20], 0
    mov DWORD PTR [rbp-16], 0
    mov DWORD PTR [rbp-12], 0
    mov DWORD PTR [rbp-8], 0
    mov DWORD PTR [rbp-4], 0    

    mov r9, rbp         # count array addr
    sub r9, 40
    mov r10, rbp
    sub r10, rbx

    mov r12d, 10

    xor rcx, rcx
    jmp count_cond_1
count_body_1:
    mov eax, DWORD PTR[rdi + rcx * 4]
    mov edx, 0
    cdq
    idiv r15d
    mov edx, 0
    idiv r12d                       
    mov r8d, DWORD PTR[r9 + rdx*4] # # count[(arr[i] / exp) % 10]
    inc r8d
    mov DWORD PTR[r9 + rdx*4], r8d # count[(arr[i] / exp) % 10]++

    inc rcx

count_cond_1:
    cmp rcx, rsi
    jl count_body_1

    mov rcx, 1
    mov r14, 0
    jmp count_cond_2

count_body_2:
    mov eax, DWORD PTR [r9 + rcx * 4]
    mov r11d, DWORD PTR [r9 + r14 * 4]
    add eax, r11d
    mov DWORD PTR [r9 + rcx * 4], eax
    inc r14
    inc rcx
count_cond_2:
    cmp rcx, 10
    jl count_body_2

mov rcx, rsi
dec rcx
jmp count_cond_3

count_body_3:
    mov eax, DWORD PTR [rdi + rcx * 4]
    mov edx, 0
    cdq
    idiv r15d
    mov edx, 0
    idiv r12d 
    mov r8d, DWORD PTR[r9 + rdx*4]          # count[(arr[i] / exp) % 10]
    dec r8d
    mov eax, DWORD PTR [rdi + rcx * 4]
    mov DWORD PTR [r10 + r8 * 4], eax
    mov DWORD PTR[r9 + rdx * 4], r8d

    dec rcx

count_cond_3:
    cmp rcx, 0
    jge count_body_3

    mov rcx, 0
    jmp count_cond_4

count_body_4:
    mov eax, DWORD PTR[r10 + rcx * 4]
    mov DWORD PTR[rdi + rcx * 4], eax


    inc rcx

count_cond_4:
    cmp rcx, rsi
    jl count_body_4

    mov rsp, rbp    

    pop rbp 
    ret
    


radix_sort:
    push       rbp
    mov        rbp, rsp
    sub	rsp, 8

    call get_max # rax = m
    mov DWORD PTR[rbp-4], eax

    mov rcx, 1
    jmp radix_cond

radix_body:
    mov rdx, rcx
    mov DWORD PTR[rbp-8], ecx
    call count_sort
    mov ecx, DWORD PTR[rbp-8]
    imul rcx, 10

radix_cond:
    mov eax, DWORD PTR[rbp-4]
    mov edx, 0
    idiv ecx
    cmp eax, 0
    jg radix_body
    mov rsp, rbp    

    pop rbp 
    ret




main:
    push       rbp
    mov        rbp, rsp
    
   	sub	rsp, 4004

	mov	DWORD PTR [rbp-4004], 1000
	mov	DWORD PTR [rbp-4000], 1164
	mov	DWORD PTR [rbp-3996], 1843
	mov	DWORD PTR [rbp-3992], 280
	mov	DWORD PTR [rbp-3988], 449
	mov	DWORD PTR [rbp-3984], 539
	mov	DWORD PTR [rbp-3980], 1408
	mov	DWORD PTR [rbp-3976], 1279
	mov	DWORD PTR [rbp-3972], 799
	mov	DWORD PTR [rbp-3968], 576
	mov	DWORD PTR [rbp-3964], 1108
	mov	DWORD PTR [rbp-3960], 1740
	mov	DWORD PTR [rbp-3956], 1909
	mov	DWORD PTR [rbp-3952], 317
	mov	DWORD PTR [rbp-3948], 1237
	mov	DWORD PTR [rbp-3944], 1113
	mov	DWORD PTR [rbp-3940], 1430
	mov	DWORD PTR [rbp-3936], 1053
	mov	DWORD PTR [rbp-3932], 553
	mov	DWORD PTR [rbp-3928], 1389
	mov	DWORD PTR [rbp-3924], 685
	mov	DWORD PTR [rbp-3920], 698
	mov	DWORD PTR [rbp-3916], 787
	mov	DWORD PTR [rbp-3912], 1640
	mov	DWORD PTR [rbp-3908], 1346
	mov	DWORD PTR [rbp-3904], 1607
	mov	DWORD PTR [rbp-3900], 1009
	mov	DWORD PTR [rbp-3896], 1784
	mov	DWORD PTR [rbp-3892], 1783
	mov	DWORD PTR [rbp-3888], 774
	mov	DWORD PTR [rbp-3884], 943
	mov	DWORD PTR [rbp-3880], 1400
	mov	DWORD PTR [rbp-3876], 239
	mov	DWORD PTR [rbp-3872], 435
	mov	DWORD PTR [rbp-3868], 411
	mov	DWORD PTR [rbp-3864], 1833
	mov	DWORD PTR [rbp-3860], 917
	mov	DWORD PTR [rbp-3856], 1584
	mov	DWORD PTR [rbp-3852], 1419
	mov	DWORD PTR [rbp-3848], 5
	mov	DWORD PTR [rbp-3844], 1690
	mov	DWORD PTR [rbp-3840], 909
	mov	DWORD PTR [rbp-3836], 21
	mov	DWORD PTR [rbp-3832], 1393
	mov	DWORD PTR [rbp-3828], 1312
	mov	DWORD PTR [rbp-3824], 1877
	mov	DWORD PTR [rbp-3820], 160
	mov	DWORD PTR [rbp-3816], 287
	mov	DWORD PTR [rbp-3812], 160
	mov	DWORD PTR [rbp-3808], 251
	mov	DWORD PTR [rbp-3804], 722
	mov	DWORD PTR [rbp-3800], 1645
	mov	DWORD PTR [rbp-3796], 1587
	mov	DWORD PTR [rbp-3792], 1000
	mov	DWORD PTR [rbp-3788], 93
	mov	DWORD PTR [rbp-3784], 1919
	mov	DWORD PTR [rbp-3780], 830
	mov	DWORD PTR [rbp-3776], 229
	mov	DWORD PTR [rbp-3772], 7
	mov	DWORD PTR [rbp-3768], 1571
	mov	DWORD PTR [rbp-3764], 1025
	mov	DWORD PTR [rbp-3760], 1489
	mov	DWORD PTR [rbp-3756], 1160
	mov	DWORD PTR [rbp-3752], 912
	mov	DWORD PTR [rbp-3748], 1670
	mov	DWORD PTR [rbp-3744], 550
	mov	DWORD PTR [rbp-3740], 716
	mov	DWORD PTR [rbp-3736], 1354
	mov	DWORD PTR [rbp-3732], 49
	mov	DWORD PTR [rbp-3728], 481
	mov	DWORD PTR [rbp-3724], 1008
	mov	DWORD PTR [rbp-3720], 856
	mov	DWORD PTR [rbp-3716], 948
	mov	DWORD PTR [rbp-3712], 1964
	mov	DWORD PTR [rbp-3708], 1929
	mov	DWORD PTR [rbp-3704], 224
	mov	DWORD PTR [rbp-3700], 251
	mov	DWORD PTR [rbp-3696], 1287
	mov	DWORD PTR [rbp-3692], 1174
	mov	DWORD PTR [rbp-3688], 109
	mov	DWORD PTR [rbp-3684], 981
	mov	DWORD PTR [rbp-3680], 372
	mov	DWORD PTR [rbp-3676], 1606
	mov	DWORD PTR [rbp-3672], 666
	mov	DWORD PTR [rbp-3668], 195
	mov	DWORD PTR [rbp-3664], 604
	mov	DWORD PTR [rbp-3660], 1325
	mov	DWORD PTR [rbp-3656], 895
	mov	DWORD PTR [rbp-3652], 329
	mov	DWORD PTR [rbp-3648], 384
	mov	DWORD PTR [rbp-3644], 1503
	mov	DWORD PTR [rbp-3640], 1142
	mov	DWORD PTR [rbp-3636], 847
	mov	DWORD PTR [rbp-3632], 680
	mov	DWORD PTR [rbp-3628], 443
	mov	DWORD PTR [rbp-3624], 538
	mov	DWORD PTR [rbp-3620], 1389
	mov	DWORD PTR [rbp-3616], 110
	mov	DWORD PTR [rbp-3612], 1844
	mov	DWORD PTR [rbp-3608], 1726
	mov	DWORD PTR [rbp-3604], 183
	mov	DWORD PTR [rbp-3600], 470
	mov	DWORD PTR [rbp-3596], 270
	mov	DWORD PTR [rbp-3592], 932
	mov	DWORD PTR [rbp-3588], 754
	mov	DWORD PTR [rbp-3584], 539
	mov	DWORD PTR [rbp-3580], 963
	mov	DWORD PTR [rbp-3576], 808
	mov	DWORD PTR [rbp-3572], 229
	mov	DWORD PTR [rbp-3568], 1488
	mov	DWORD PTR [rbp-3564], 126
	mov	DWORD PTR [rbp-3560], 1057
	mov	DWORD PTR [rbp-3556], 1628
	mov	DWORD PTR [rbp-3552], 1185
	mov	DWORD PTR [rbp-3548], 1602
	mov	DWORD PTR [rbp-3544], 0
	mov	DWORD PTR [rbp-3540], 1540
	mov	DWORD PTR [rbp-3536], 598
	mov	DWORD PTR [rbp-3532], 1155
	mov	DWORD PTR [rbp-3528], 517
	mov	DWORD PTR [rbp-3524], 128
	mov	DWORD PTR [rbp-3520], 994
	mov	DWORD PTR [rbp-3516], 1267
	mov	DWORD PTR [rbp-3512], 487
	mov	DWORD PTR [rbp-3508], 134
	mov	DWORD PTR [rbp-3504], 201
	mov	DWORD PTR [rbp-3500], 1471
	mov	DWORD PTR [rbp-3496], 711
	mov	DWORD PTR [rbp-3492], 1515
	mov	DWORD PTR [rbp-3488], 1234
	mov	DWORD PTR [rbp-3484], 1761
	mov	DWORD PTR [rbp-3480], 672
	mov	DWORD PTR [rbp-3476], 1043
	mov	DWORD PTR [rbp-3472], 1731
	mov	DWORD PTR [rbp-3468], 85
	mov	DWORD PTR [rbp-3464], 1666
	mov	DWORD PTR [rbp-3460], 991
	mov	DWORD PTR [rbp-3456], 1886
	mov	DWORD PTR [rbp-3452], 1611
	mov	DWORD PTR [rbp-3448], 1751
	mov	DWORD PTR [rbp-3444], 186
	mov	DWORD PTR [rbp-3440], 349
	mov	DWORD PTR [rbp-3436], 998
	mov	DWORD PTR [rbp-3432], 1678
	mov	DWORD PTR [rbp-3428], 389
	mov	DWORD PTR [rbp-3424], 1582
	mov	DWORD PTR [rbp-3420], 964
	mov	DWORD PTR [rbp-3416], 1057
	mov	DWORD PTR [rbp-3412], 257
	mov	DWORD PTR [rbp-3408], 690
	mov	DWORD PTR [rbp-3404], 707
	mov	DWORD PTR [rbp-3400], 543
	mov	DWORD PTR [rbp-3396], 168
	mov	DWORD PTR [rbp-3392], 491
	mov	DWORD PTR [rbp-3388], 1955
	mov	DWORD PTR [rbp-3384], 1055
	mov	DWORD PTR [rbp-3380], 590
	mov	DWORD PTR [rbp-3376], 681
	mov	DWORD PTR [rbp-3372], 1729
	mov	DWORD PTR [rbp-3368], 1108
	mov	DWORD PTR [rbp-3364], 1759
	mov	DWORD PTR [rbp-3360], 998
	mov	DWORD PTR [rbp-3356], 690
	mov	DWORD PTR [rbp-3352], 945
	mov	DWORD PTR [rbp-3348], 757
	mov	DWORD PTR [rbp-3344], 1061
	mov	DWORD PTR [rbp-3340], 1022
	mov	DWORD PTR [rbp-3336], 1651
	mov	DWORD PTR [rbp-3332], 481
	mov	DWORD PTR [rbp-3328], 1336
	mov	DWORD PTR [rbp-3324], 173
	mov	DWORD PTR [rbp-3320], 1398
	mov	DWORD PTR [rbp-3316], 470
	mov	DWORD PTR [rbp-3312], 1716
	mov	DWORD PTR [rbp-3308], 728
	mov	DWORD PTR [rbp-3304], 1120
	mov	DWORD PTR [rbp-3300], 1860
	mov	DWORD PTR [rbp-3296], 544
	mov	DWORD PTR [rbp-3292], 476
	mov	DWORD PTR [rbp-3288], 1377
	mov	DWORD PTR [rbp-3284], 687
	mov	DWORD PTR [rbp-3280], 1290
	mov	DWORD PTR [rbp-3276], 577
	mov	DWORD PTR [rbp-3272], 1805
	mov	DWORD PTR [rbp-3268], 350
	mov	DWORD PTR [rbp-3264], 425
	mov	DWORD PTR [rbp-3260], 1589
	mov	DWORD PTR [rbp-3256], 1470
	mov	DWORD PTR [rbp-3252], 518
	mov	DWORD PTR [rbp-3248], 1665
	mov	DWORD PTR [rbp-3244], 1841
	mov	DWORD PTR [rbp-3240], 1902
	mov	DWORD PTR [rbp-3236], 88
	mov	DWORD PTR [rbp-3232], 1549
	mov	DWORD PTR [rbp-3228], 1511
	mov	DWORD PTR [rbp-3224], 1993
	mov	DWORD PTR [rbp-3220], 1634
	mov	DWORD PTR [rbp-3216], 790
	mov	DWORD PTR [rbp-3212], 1128
	mov	DWORD PTR [rbp-3208], 44
	mov	DWORD PTR [rbp-3204], 1513
	mov	DWORD PTR [rbp-3200], 291
	mov	DWORD PTR [rbp-3196], 1211
	mov	DWORD PTR [rbp-3192], 1930
	mov	DWORD PTR [rbp-3188], 1996
	mov	DWORD PTR [rbp-3184], 750
	mov	DWORD PTR [rbp-3180], 575
	mov	DWORD PTR [rbp-3176], 1784
	mov	DWORD PTR [rbp-3172], 768
	mov	DWORD PTR [rbp-3168], 1177
	mov	DWORD PTR [rbp-3164], 1926
	mov	DWORD PTR [rbp-3160], 1357
	mov	DWORD PTR [rbp-3156], 1334
	mov	DWORD PTR [rbp-3152], 751
	mov	DWORD PTR [rbp-3148], 1295
	mov	DWORD PTR [rbp-3144], 168
	mov	DWORD PTR [rbp-3140], 221
	mov	DWORD PTR [rbp-3136], 1772
	mov	DWORD PTR [rbp-3132], 287
	mov	DWORD PTR [rbp-3128], 1777
	mov	DWORD PTR [rbp-3124], 1514
	mov	DWORD PTR [rbp-3120], 1955
	mov	DWORD PTR [rbp-3116], 1304
	mov	DWORD PTR [rbp-3112], 1459
	mov	DWORD PTR [rbp-3108], 1556
	mov	DWORD PTR [rbp-3104], 947
	mov	DWORD PTR [rbp-3100], 340
	mov	DWORD PTR [rbp-3096], 242
	mov	DWORD PTR [rbp-3092], 754
	mov	DWORD PTR [rbp-3088], 1033
	mov	DWORD PTR [rbp-3084], 1981
	mov	DWORD PTR [rbp-3080], 460
	mov	DWORD PTR [rbp-3076], 704
	mov	DWORD PTR [rbp-3072], 1170
	mov	DWORD PTR [rbp-3068], 1555
	mov	DWORD PTR [rbp-3064], 396
	mov	DWORD PTR [rbp-3060], 25
	mov	DWORD PTR [rbp-3056], 429
	mov	DWORD PTR [rbp-3052], 650
	mov	DWORD PTR [rbp-3048], 613
	mov	DWORD PTR [rbp-3044], 1497
	mov	DWORD PTR [rbp-3040], 426
	mov	DWORD PTR [rbp-3036], 778
	mov	DWORD PTR [rbp-3032], 1697
	mov	DWORD PTR [rbp-3028], 1001
	mov	DWORD PTR [rbp-3024], 1616
	mov	DWORD PTR [rbp-3020], 1009
	mov	DWORD PTR [rbp-3016], 466
	mov	DWORD PTR [rbp-3012], 618
	mov	DWORD PTR [rbp-3008], 488
	mov	DWORD PTR [rbp-3004], 360
	mov	DWORD PTR [rbp-3000], 1855
	mov	DWORD PTR [rbp-2996], 1581
	mov	DWORD PTR [rbp-2992], 1143
	mov	DWORD PTR [rbp-2988], 193
	mov	DWORD PTR [rbp-2984], 924
	mov	DWORD PTR [rbp-2980], 1974
	mov	DWORD PTR [rbp-2976], 434
	mov	DWORD PTR [rbp-2972], 972
	mov	DWORD PTR [rbp-2968], 977
	mov	DWORD PTR [rbp-2964], 736
	mov	DWORD PTR [rbp-2960], 1628
	mov	DWORD PTR [rbp-2956], 231
	mov	DWORD PTR [rbp-2952], 1000
	mov	DWORD PTR [rbp-2948], 1354
	mov	DWORD PTR [rbp-2944], 1356
	mov	DWORD PTR [rbp-2940], 1482
	mov	DWORD PTR [rbp-2936], 174
	mov	DWORD PTR [rbp-2932], 1242
	mov	DWORD PTR [rbp-2928], 1028
	mov	DWORD PTR [rbp-2924], 1820
	mov	DWORD PTR [rbp-2920], 759
	mov	DWORD PTR [rbp-2916], 1532
	mov	DWORD PTR [rbp-2912], 681
	mov	DWORD PTR [rbp-2908], 138
	mov	DWORD PTR [rbp-2904], 1822
	mov	DWORD PTR [rbp-2900], 290
	mov	DWORD PTR [rbp-2896], 1297
	mov	DWORD PTR [rbp-2892], 341
	mov	DWORD PTR [rbp-2888], 700
	mov	DWORD PTR [rbp-2884], 1440
	mov	DWORD PTR [rbp-2880], 1389
	mov	DWORD PTR [rbp-2876], 211
	mov	DWORD PTR [rbp-2872], 1516
	mov	DWORD PTR [rbp-2868], 568
	mov	DWORD PTR [rbp-2864], 228
	mov	DWORD PTR [rbp-2860], 985
	mov	DWORD PTR [rbp-2856], 1354
	mov	DWORD PTR [rbp-2852], 837
	mov	DWORD PTR [rbp-2848], 1523
	mov	DWORD PTR [rbp-2844], 1287
	mov	DWORD PTR [rbp-2840], 140
	mov	DWORD PTR [rbp-2836], 1931
	mov	DWORD PTR [rbp-2832], 722
	mov	DWORD PTR [rbp-2828], 817
	mov	DWORD PTR [rbp-2824], 361
	mov	DWORD PTR [rbp-2820], 1278
	mov	DWORD PTR [rbp-2816], 1381
	mov	DWORD PTR [rbp-2812], 1400
	mov	DWORD PTR [rbp-2808], 180
	mov	DWORD PTR [rbp-2804], 1391
	mov	DWORD PTR [rbp-2800], 1859
	mov	DWORD PTR [rbp-2796], 1471
	mov	DWORD PTR [rbp-2792], 1779
	mov	DWORD PTR [rbp-2788], 1944
	mov	DWORD PTR [rbp-2784], 1377
	mov	DWORD PTR [rbp-2780], 1389
	mov	DWORD PTR [rbp-2776], 920
	mov	DWORD PTR [rbp-2772], 391
	mov	DWORD PTR [rbp-2768], 858
	mov	DWORD PTR [rbp-2764], 197
	mov	DWORD PTR [rbp-2760], 1514
	mov	DWORD PTR [rbp-2756], 1075
	mov	DWORD PTR [rbp-2752], 804
	mov	DWORD PTR [rbp-2748], 1382
	mov	DWORD PTR [rbp-2744], 277
	mov	DWORD PTR [rbp-2740], 1716
	mov	DWORD PTR [rbp-2736], 1827
	mov	DWORD PTR [rbp-2732], 77
	mov	DWORD PTR [rbp-2728], 1305
	mov	DWORD PTR [rbp-2724], 127
	mov	DWORD PTR [rbp-2720], 1049
	mov	DWORD PTR [rbp-2716], 830
	mov	DWORD PTR [rbp-2712], 448
	mov	DWORD PTR [rbp-2708], 1374
	mov	DWORD PTR [rbp-2704], 1761
	mov	DWORD PTR [rbp-2700], 200
	mov	DWORD PTR [rbp-2696], 1197
	mov	DWORD PTR [rbp-2692], 871
	mov	DWORD PTR [rbp-2688], 1861
	mov	DWORD PTR [rbp-2684], 259
	mov	DWORD PTR [rbp-2680], 1369
	mov	DWORD PTR [rbp-2676], 1058
	mov	DWORD PTR [rbp-2672], 920
	mov	DWORD PTR [rbp-2668], 175
	mov	DWORD PTR [rbp-2664], 1394
	mov	DWORD PTR [rbp-2660], 315
	mov	DWORD PTR [rbp-2656], 1198
	mov	DWORD PTR [rbp-2652], 1352
	mov	DWORD PTR [rbp-2648], 1685
	mov	DWORD PTR [rbp-2644], 811
	mov	DWORD PTR [rbp-2640], 443
	mov	DWORD PTR [rbp-2636], 424
	mov	DWORD PTR [rbp-2632], 658
	mov	DWORD PTR [rbp-2628], 1681
	mov	DWORD PTR [rbp-2624], 1095
	mov	DWORD PTR [rbp-2620], 1544
	mov	DWORD PTR [rbp-2616], 866
	mov	DWORD PTR [rbp-2612], 1541
	mov	DWORD PTR [rbp-2608], 921
	mov	DWORD PTR [rbp-2604], 1396
	mov	DWORD PTR [rbp-2600], 296
	mov	DWORD PTR [rbp-2596], 905
	mov	DWORD PTR [rbp-2592], 1026
	mov	DWORD PTR [rbp-2588], 1434
	mov	DWORD PTR [rbp-2584], 1316
	mov	DWORD PTR [rbp-2580], 1893
	mov	DWORD PTR [rbp-2576], 1316
	mov	DWORD PTR [rbp-2572], 758
	mov	DWORD PTR [rbp-2568], 1875
	mov	DWORD PTR [rbp-2564], 1902
	mov	DWORD PTR [rbp-2560], 167
	mov	DWORD PTR [rbp-2556], 1225
	mov	DWORD PTR [rbp-2552], 1521
	mov	DWORD PTR [rbp-2548], 1782
	mov	DWORD PTR [rbp-2544], 1446
	mov	DWORD PTR [rbp-2540], 799
	mov	DWORD PTR [rbp-2536], 695
	mov	DWORD PTR [rbp-2532], 1520
	mov	DWORD PTR [rbp-2528], 228
	mov	DWORD PTR [rbp-2524], 220
	mov	DWORD PTR [rbp-2520], 1153
	mov	DWORD PTR [rbp-2516], 802
	mov	DWORD PTR [rbp-2512], 1096
	mov	DWORD PTR [rbp-2508], 1923
	mov	DWORD PTR [rbp-2504], 1563
	mov	DWORD PTR [rbp-2500], 873
	mov	DWORD PTR [rbp-2496], 1245
	mov	DWORD PTR [rbp-2492], 264
	mov	DWORD PTR [rbp-2488], 1673
	mov	DWORD PTR [rbp-2484], 1981
	mov	DWORD PTR [rbp-2480], 1156
	mov	DWORD PTR [rbp-2476], 1499
	mov	DWORD PTR [rbp-2472], 549
	mov	DWORD PTR [rbp-2468], 1258
	mov	DWORD PTR [rbp-2464], 1101
	mov	DWORD PTR [rbp-2460], 1178
	mov	DWORD PTR [rbp-2456], 147
	mov	DWORD PTR [rbp-2452], 251
	mov	DWORD PTR [rbp-2448], 1207
	mov	DWORD PTR [rbp-2444], 1207
	mov	DWORD PTR [rbp-2440], 931
	mov	DWORD PTR [rbp-2436], 1780
	mov	DWORD PTR [rbp-2432], 1307
	mov	DWORD PTR [rbp-2428], 1218
	mov	DWORD PTR [rbp-2424], 1175
	mov	DWORD PTR [rbp-2420], 198
	mov	DWORD PTR [rbp-2416], 1121
	mov	DWORD PTR [rbp-2412], 1938
	mov	DWORD PTR [rbp-2408], 1235
	mov	DWORD PTR [rbp-2404], 1891
	mov	DWORD PTR [rbp-2400], 1497
	mov	DWORD PTR [rbp-2396], 1818
	mov	DWORD PTR [rbp-2392], 232
	mov	DWORD PTR [rbp-2388], 1943
	mov	DWORD PTR [rbp-2384], 234
	mov	DWORD PTR [rbp-2380], 1192
	mov	DWORD PTR [rbp-2376], 1719
	mov	DWORD PTR [rbp-2372], 1618
	mov	DWORD PTR [rbp-2368], 98
	mov	DWORD PTR [rbp-2364], 583
	mov	DWORD PTR [rbp-2360], 1737
	mov	DWORD PTR [rbp-2356], 1214
	mov	DWORD PTR [rbp-2352], 274
	mov	DWORD PTR [rbp-2348], 1120
	mov	DWORD PTR [rbp-2344], 1189
	mov	DWORD PTR [rbp-2340], 1563
	mov	DWORD PTR [rbp-2336], 896
	mov	DWORD PTR [rbp-2332], 708
	mov	DWORD PTR [rbp-2328], 565
	mov	DWORD PTR [rbp-2324], 543
	mov	DWORD PTR [rbp-2320], 555
	mov	DWORD PTR [rbp-2316], 1130
	mov	DWORD PTR [rbp-2312], 1200
	mov	DWORD PTR [rbp-2308], 1993
	mov	DWORD PTR [rbp-2304], 1188
	mov	DWORD PTR [rbp-2300], 1522
	mov	DWORD PTR [rbp-2296], 583
	mov	DWORD PTR [rbp-2292], 1490
	mov	DWORD PTR [rbp-2288], 1056
	mov	DWORD PTR [rbp-2284], 228
	mov	DWORD PTR [rbp-2280], 653
	mov	DWORD PTR [rbp-2276], 1083
	mov	DWORD PTR [rbp-2272], 1909
	mov	DWORD PTR [rbp-2268], 1288
	mov	DWORD PTR [rbp-2264], 1288
	mov	DWORD PTR [rbp-2260], 1896
	mov	DWORD PTR [rbp-2256], 621
	mov	DWORD PTR [rbp-2252], 120
	mov	DWORD PTR [rbp-2248], 1864
	mov	DWORD PTR [rbp-2244], 159
	mov	DWORD PTR [rbp-2240], 431
	mov	DWORD PTR [rbp-2236], 1725
	mov	DWORD PTR [rbp-2232], 10
	mov	DWORD PTR [rbp-2228], 1149
	mov	DWORD PTR [rbp-2224], 115
	mov	DWORD PTR [rbp-2220], 1005
	mov	DWORD PTR [rbp-2216], 1275
	mov	DWORD PTR [rbp-2212], 539
	mov	DWORD PTR [rbp-2208], 1119
	mov	DWORD PTR [rbp-2204], 238
	mov	DWORD PTR [rbp-2200], 1992
	mov	DWORD PTR [rbp-2196], 297
	mov	DWORD PTR [rbp-2192], 250
	mov	DWORD PTR [rbp-2188], 1518
	mov	DWORD PTR [rbp-2184], 1717
	mov	DWORD PTR [rbp-2180], 716
	mov	DWORD PTR [rbp-2176], 1960
	mov	DWORD PTR [rbp-2172], 1836
	mov	DWORD PTR [rbp-2168], 1113
	mov	DWORD PTR [rbp-2164], 1824
	mov	DWORD PTR [rbp-2160], 478
	mov	DWORD PTR [rbp-2156], 1423
	mov	DWORD PTR [rbp-2152], 1978
	mov	DWORD PTR [rbp-2148], 1819
	mov	DWORD PTR [rbp-2144], 278
	mov	DWORD PTR [rbp-2140], 1094
	mov	DWORD PTR [rbp-2136], 1240
	mov	DWORD PTR [rbp-2132], 589
	mov	DWORD PTR [rbp-2128], 1956
	mov	DWORD PTR [rbp-2124], 1298
	mov	DWORD PTR [rbp-2120], 1875
	mov	DWORD PTR [rbp-2116], 194
	mov	DWORD PTR [rbp-2112], 1343
	mov	DWORD PTR [rbp-2108], 1696
	mov	DWORD PTR [rbp-2104], 965
	mov	DWORD PTR [rbp-2100], 1280
	mov	DWORD PTR [rbp-2096], 1664
	mov	DWORD PTR [rbp-2092], 340
	mov	DWORD PTR [rbp-2088], 749
	mov	DWORD PTR [rbp-2084], 1714
	mov	DWORD PTR [rbp-2080], 1456
	mov	DWORD PTR [rbp-2076], 1506
	mov	DWORD PTR [rbp-2072], 337
	mov	DWORD PTR [rbp-2068], 641
	mov	DWORD PTR [rbp-2064], 492
	mov	DWORD PTR [rbp-2060], 1420
	mov	DWORD PTR [rbp-2056], 617
	mov	DWORD PTR [rbp-2052], 1201
	mov	DWORD PTR [rbp-2048], 1534
	mov	DWORD PTR [rbp-2044], 892
	mov	DWORD PTR [rbp-2040], 306
	mov	DWORD PTR [rbp-2036], 1224
	mov	DWORD PTR [rbp-2032], 282
	mov	DWORD PTR [rbp-2028], 973
	mov	DWORD PTR [rbp-2024], 1762
	mov	DWORD PTR [rbp-2020], 1250
	mov	DWORD PTR [rbp-2016], 1031
	mov	DWORD PTR [rbp-2012], 930
	mov	DWORD PTR [rbp-2008], 1534
	mov	DWORD PTR [rbp-2004], 530
	mov	DWORD PTR [rbp-2000], 341
	mov	DWORD PTR [rbp-1996], 167
	mov	DWORD PTR [rbp-1992], 1903
	mov	DWORD PTR [rbp-1988], 675
	mov	DWORD PTR [rbp-1984], 852
	mov	DWORD PTR [rbp-1980], 1735
	mov	DWORD PTR [rbp-1976], 414
	mov	DWORD PTR [rbp-1972], 609
	mov	DWORD PTR [rbp-1968], 1507
	mov	DWORD PTR [rbp-1964], 1551
	mov	DWORD PTR [rbp-1960], 25
	mov	DWORD PTR [rbp-1956], 11
	mov	DWORD PTR [rbp-1952], 1184
	mov	DWORD PTR [rbp-1948], 850
	mov	DWORD PTR [rbp-1944], 935
	mov	DWORD PTR [rbp-1940], 997
	mov	DWORD PTR [rbp-1936], 625
	mov	DWORD PTR [rbp-1932], 1087
	mov	DWORD PTR [rbp-1928], 1678
	mov	DWORD PTR [rbp-1924], 761
	mov	DWORD PTR [rbp-1920], 1228
	mov	DWORD PTR [rbp-1916], 582
	mov	DWORD PTR [rbp-1912], 1026
	mov	DWORD PTR [rbp-1908], 627
	mov	DWORD PTR [rbp-1904], 532
	mov	DWORD PTR [rbp-1900], 1274
	mov	DWORD PTR [rbp-1896], 1107
	mov	DWORD PTR [rbp-1892], 1905
	mov	DWORD PTR [rbp-1888], 1127
	mov	DWORD PTR [rbp-1884], 816
	mov	DWORD PTR [rbp-1880], 986
	mov	DWORD PTR [rbp-1876], 1617
	mov	DWORD PTR [rbp-1872], 1433
	mov	DWORD PTR [rbp-1868], 19
	mov	DWORD PTR [rbp-1864], 1672
	mov	DWORD PTR [rbp-1860], 1974
	mov	DWORD PTR [rbp-1856], 570
	mov	DWORD PTR [rbp-1852], 1540
	mov	DWORD PTR [rbp-1848], 645
	mov	DWORD PTR [rbp-1844], 1240
	mov	DWORD PTR [rbp-1840], 1641
	mov	DWORD PTR [rbp-1836], 710
	mov	DWORD PTR [rbp-1832], 1277
	mov	DWORD PTR [rbp-1828], 418
	mov	DWORD PTR [rbp-1824], 1655
	mov	DWORD PTR [rbp-1820], 1558
	mov	DWORD PTR [rbp-1816], 1989
	mov	DWORD PTR [rbp-1812], 1785
	mov	DWORD PTR [rbp-1808], 720
	mov	DWORD PTR [rbp-1804], 529
	mov	DWORD PTR [rbp-1800], 1906
	mov	DWORD PTR [rbp-1796], 471
	mov	DWORD PTR [rbp-1792], 718
	mov	DWORD PTR [rbp-1788], 1185
	mov	DWORD PTR [rbp-1784], 1348
	mov	DWORD PTR [rbp-1780], 2
	mov	DWORD PTR [rbp-1776], 637
	mov	DWORD PTR [rbp-1772], 1687
	mov	DWORD PTR [rbp-1768], 845
	mov	DWORD PTR [rbp-1764], 1319
	mov	DWORD PTR [rbp-1760], 382
	mov	DWORD PTR [rbp-1756], 1858
	mov	DWORD PTR [rbp-1752], 1102
	mov	DWORD PTR [rbp-1748], 1076
	mov	DWORD PTR [rbp-1744], 876
	mov	DWORD PTR [rbp-1740], 1251
	mov	DWORD PTR [rbp-1736], 1814
	mov	DWORD PTR [rbp-1732], 861
	mov	DWORD PTR [rbp-1728], 368
	mov	DWORD PTR [rbp-1724], 712
	mov	DWORD PTR [rbp-1720], 402
	mov	DWORD PTR [rbp-1716], 1285
	mov	DWORD PTR [rbp-1712], 1448
	mov	DWORD PTR [rbp-1708], 296
	mov	DWORD PTR [rbp-1704], 828
	mov	DWORD PTR [rbp-1700], 671
	mov	DWORD PTR [rbp-1696], 1156
	mov	DWORD PTR [rbp-1692], 424
	mov	DWORD PTR [rbp-1688], 32
	mov	DWORD PTR [rbp-1684], 1274
	mov	DWORD PTR [rbp-1680], 777
	mov	DWORD PTR [rbp-1676], 1808
	mov	DWORD PTR [rbp-1672], 1694
	mov	DWORD PTR [rbp-1668], 1189
	mov	DWORD PTR [rbp-1664], 413
	mov	DWORD PTR [rbp-1660], 86
	mov	DWORD PTR [rbp-1656], 1522
	mov	DWORD PTR [rbp-1652], 44
	mov	DWORD PTR [rbp-1648], 1497
	mov	DWORD PTR [rbp-1644], 1871
	mov	DWORD PTR [rbp-1640], 665
	mov	DWORD PTR [rbp-1636], 833
	mov	DWORD PTR [rbp-1632], 786
	mov	DWORD PTR [rbp-1628], 61
	mov	DWORD PTR [rbp-1624], 136
	mov	DWORD PTR [rbp-1620], 640
	mov	DWORD PTR [rbp-1616], 499
	mov	DWORD PTR [rbp-1612], 1315
	mov	DWORD PTR [rbp-1608], 976
	mov	DWORD PTR [rbp-1604], 261
	mov	DWORD PTR [rbp-1600], 1010
	mov	DWORD PTR [rbp-1596], 1747
	mov	DWORD PTR [rbp-1592], 354
	mov	DWORD PTR [rbp-1588], 806
	mov	DWORD PTR [rbp-1584], 1396
	mov	DWORD PTR [rbp-1580], 124
	mov	DWORD PTR [rbp-1576], 1302
	mov	DWORD PTR [rbp-1572], 1670
	mov	DWORD PTR [rbp-1568], 1278
	mov	DWORD PTR [rbp-1564], 1545
	mov	DWORD PTR [rbp-1560], 1720
	mov	DWORD PTR [rbp-1556], 215
	mov	DWORD PTR [rbp-1552], 830
	mov	DWORD PTR [rbp-1548], 1668
	mov	DWORD PTR [rbp-1544], 163
	mov	DWORD PTR [rbp-1540], 378
	mov	DWORD PTR [rbp-1536], 1905
	mov	DWORD PTR [rbp-1532], 1764
	mov	DWORD PTR [rbp-1528], 899
	mov	DWORD PTR [rbp-1524], 887
	mov	DWORD PTR [rbp-1520], 1562
	mov	DWORD PTR [rbp-1516], 337
	mov	DWORD PTR [rbp-1512], 11
	mov	DWORD PTR [rbp-1508], 1770
	mov	DWORD PTR [rbp-1504], 829
	mov	DWORD PTR [rbp-1500], 1333
	mov	DWORD PTR [rbp-1496], 400
	mov	DWORD PTR [rbp-1492], 1946
	mov	DWORD PTR [rbp-1488], 1661
	mov	DWORD PTR [rbp-1484], 53
	mov	DWORD PTR [rbp-1480], 1177
	mov	DWORD PTR [rbp-1476], 85
	mov	DWORD PTR [rbp-1472], 1425
	mov	DWORD PTR [rbp-1468], 1661
	mov	DWORD PTR [rbp-1464], 181
	mov	DWORD PTR [rbp-1460], 717
	mov	DWORD PTR [rbp-1456], 1160
	mov	DWORD PTR [rbp-1452], 778
	mov	DWORD PTR [rbp-1448], 517
	mov	DWORD PTR [rbp-1444], 1730
	mov	DWORD PTR [rbp-1440], 1380
	mov	DWORD PTR [rbp-1436], 1023
	mov	DWORD PTR [rbp-1432], 1793
	mov	DWORD PTR [rbp-1428], 392
	mov	DWORD PTR [rbp-1424], 1260
	mov	DWORD PTR [rbp-1420], 1272
	mov	DWORD PTR [rbp-1416], 498
	mov	DWORD PTR [rbp-1412], 970
	mov	DWORD PTR [rbp-1408], 242
	mov	DWORD PTR [rbp-1404], 819
	mov	DWORD PTR [rbp-1400], 221
	mov	DWORD PTR [rbp-1396], 953
	mov	DWORD PTR [rbp-1392], 393
	mov	DWORD PTR [rbp-1388], 1394
	mov	DWORD PTR [rbp-1384], 1449
	mov	DWORD PTR [rbp-1380], 495
	mov	DWORD PTR [rbp-1376], 1502
	mov	DWORD PTR [rbp-1372], 1945
	mov	DWORD PTR [rbp-1368], 265
	mov	DWORD PTR [rbp-1364], 1555
	mov	DWORD PTR [rbp-1360], 1847
	mov	DWORD PTR [rbp-1356], 1806
	mov	DWORD PTR [rbp-1352], 452
	mov	DWORD PTR [rbp-1348], 729
	mov	DWORD PTR [rbp-1344], 1733
	mov	DWORD PTR [rbp-1340], 1551
	mov	DWORD PTR [rbp-1336], 1594
	mov	DWORD PTR [rbp-1332], 1049
	mov	DWORD PTR [rbp-1328], 643
	mov	DWORD PTR [rbp-1324], 1150
	mov	DWORD PTR [rbp-1320], 1993
	mov	DWORD PTR [rbp-1316], 1392
	mov	DWORD PTR [rbp-1312], 56
	mov	DWORD PTR [rbp-1308], 142
	mov	DWORD PTR [rbp-1304], 1690
	mov	DWORD PTR [rbp-1300], 1889
	mov	DWORD PTR [rbp-1296], 819
	mov	DWORD PTR [rbp-1292], 813
	mov	DWORD PTR [rbp-1288], 128
	mov	DWORD PTR [rbp-1284], 1788
	mov	DWORD PTR [rbp-1280], 1282
	mov	DWORD PTR [rbp-1276], 1113
	mov	DWORD PTR [rbp-1272], 1710
	mov	DWORD PTR [rbp-1268], 975
	mov	DWORD PTR [rbp-1264], 873
	mov	DWORD PTR [rbp-1260], 1941
	mov	DWORD PTR [rbp-1256], 902
	mov	DWORD PTR [rbp-1252], 528
	mov	DWORD PTR [rbp-1248], 1855
	mov	DWORD PTR [rbp-1244], 1359
	mov	DWORD PTR [rbp-1240], 765
	mov	DWORD PTR [rbp-1236], 1904
	mov	DWORD PTR [rbp-1232], 1192
	mov	DWORD PTR [rbp-1228], 935
	mov	DWORD PTR [rbp-1224], 774
	mov	DWORD PTR [rbp-1220], 225
	mov	DWORD PTR [rbp-1216], 311
	mov	DWORD PTR [rbp-1212], 17
	mov	DWORD PTR [rbp-1208], 1730
	mov	DWORD PTR [rbp-1204], 173
	mov	DWORD PTR [rbp-1200], 181
	mov	DWORD PTR [rbp-1196], 1889
	mov	DWORD PTR [rbp-1192], 868
	mov	DWORD PTR [rbp-1188], 1857
	mov	DWORD PTR [rbp-1184], 36
	mov	DWORD PTR [rbp-1180], 1204
	mov	DWORD PTR [rbp-1176], 799
	mov	DWORD PTR [rbp-1172], 652
	mov	DWORD PTR [rbp-1168], 1916
	mov	DWORD PTR [rbp-1164], 414
	mov	DWORD PTR [rbp-1160], 552
	mov	DWORD PTR [rbp-1156], 371
	mov	DWORD PTR [rbp-1152], 767
	mov	DWORD PTR [rbp-1148], 12
	mov	DWORD PTR [rbp-1144], 1896
	mov	DWORD PTR [rbp-1140], 125
	mov	DWORD PTR [rbp-1136], 1957
	mov	DWORD PTR [rbp-1132], 72
	mov	DWORD PTR [rbp-1128], 1819
	mov	DWORD PTR [rbp-1124], 611
	mov	DWORD PTR [rbp-1120], 1925
	mov	DWORD PTR [rbp-1116], 1984
	mov	DWORD PTR [rbp-1112], 775
	mov	DWORD PTR [rbp-1108], 1048
	mov	DWORD PTR [rbp-1104], 1478
	mov	DWORD PTR [rbp-1100], 276
	mov	DWORD PTR [rbp-1096], 382
	mov	DWORD PTR [rbp-1092], 1735
	mov	DWORD PTR [rbp-1088], 899
	mov	DWORD PTR [rbp-1084], 1983
	mov	DWORD PTR [rbp-1080], 30
	mov	DWORD PTR [rbp-1076], 1884
	mov	DWORD PTR [rbp-1072], 621
	mov	DWORD PTR [rbp-1068], 406
	mov	DWORD PTR [rbp-1064], 1520
	mov	DWORD PTR [rbp-1060], 797
	mov	DWORD PTR [rbp-1056], 1072
	mov	DWORD PTR [rbp-1052], 290
	mov	DWORD PTR [rbp-1048], 1205
	mov	DWORD PTR [rbp-1044], 503
	mov	DWORD PTR [rbp-1040], 1719
	mov	DWORD PTR [rbp-1036], 340
	mov	DWORD PTR [rbp-1032], 865
	mov	DWORD PTR [rbp-1028], 1996
	mov	DWORD PTR [rbp-1024], 1254
	mov	DWORD PTR [rbp-1020], 1651
	mov	DWORD PTR [rbp-1016], 456
	mov	DWORD PTR [rbp-1012], 1059
	mov	DWORD PTR [rbp-1008], 576
	mov	DWORD PTR [rbp-1004], 1828
	mov	DWORD PTR [rbp-1000], 1169
	mov	DWORD PTR [rbp-996], 401
	mov	DWORD PTR [rbp-992], 1048
	mov	DWORD PTR [rbp-988], 1580
	mov	DWORD PTR [rbp-984], 1133
	mov	DWORD PTR [rbp-980], 1594
	mov	DWORD PTR [rbp-976], 575
	mov	DWORD PTR [rbp-972], 1164
	mov	DWORD PTR [rbp-968], 1231
	mov	DWORD PTR [rbp-964], 622
	mov	DWORD PTR [rbp-960], 534
	mov	DWORD PTR [rbp-956], 811
	mov	DWORD PTR [rbp-952], 979
	mov	DWORD PTR [rbp-948], 933
	mov	DWORD PTR [rbp-944], 1882
	mov	DWORD PTR [rbp-940], 200
	mov	DWORD PTR [rbp-936], 44
	mov	DWORD PTR [rbp-932], 93
	mov	DWORD PTR [rbp-928], 1526
	mov	DWORD PTR [rbp-924], 163
	mov	DWORD PTR [rbp-920], 1817
	mov	DWORD PTR [rbp-916], 1219
	mov	DWORD PTR [rbp-912], 717
	mov	DWORD PTR [rbp-908], 184
	mov	DWORD PTR [rbp-904], 307
	mov	DWORD PTR [rbp-900], 1179
	mov	DWORD PTR [rbp-896], 674
	mov	DWORD PTR [rbp-892], 1827
	mov	DWORD PTR [rbp-888], 941
	mov	DWORD PTR [rbp-884], 251
	mov	DWORD PTR [rbp-880], 915
	mov	DWORD PTR [rbp-876], 1820
	mov	DWORD PTR [rbp-872], 560
	mov	DWORD PTR [rbp-868], 18
	mov	DWORD PTR [rbp-864], 528
	mov	DWORD PTR [rbp-860], 1390
	mov	DWORD PTR [rbp-856], 431
	mov	DWORD PTR [rbp-852], 796
	mov	DWORD PTR [rbp-848], 895
	mov	DWORD PTR [rbp-844], 124
	mov	DWORD PTR [rbp-840], 989
	mov	DWORD PTR [rbp-836], 1798
	mov	DWORD PTR [rbp-832], 1405
	mov	DWORD PTR [rbp-828], 1136
	mov	DWORD PTR [rbp-824], 532
	mov	DWORD PTR [rbp-820], 157
	mov	DWORD PTR [rbp-816], 179
	mov	DWORD PTR [rbp-812], 801
	mov	DWORD PTR [rbp-808], 1774
	mov	DWORD PTR [rbp-804], 1761
	mov	DWORD PTR [rbp-800], 965
	mov	DWORD PTR [rbp-796], 606
	mov	DWORD PTR [rbp-792], 272
	mov	DWORD PTR [rbp-788], 1124
	mov	DWORD PTR [rbp-784], 1005
	mov	DWORD PTR [rbp-780], 219
	mov	DWORD PTR [rbp-776], 1227
	mov	DWORD PTR [rbp-772], 256
	mov	DWORD PTR [rbp-768], 1925
	mov	DWORD PTR [rbp-764], 1923
	mov	DWORD PTR [rbp-760], 431
	mov	DWORD PTR [rbp-756], 1652
	mov	DWORD PTR [rbp-752], 814
	mov	DWORD PTR [rbp-748], 1896
	mov	DWORD PTR [rbp-744], 316
	mov	DWORD PTR [rbp-740], 1215
	mov	DWORD PTR [rbp-736], 1748
	mov	DWORD PTR [rbp-732], 1769
	mov	DWORD PTR [rbp-728], 1685
	mov	DWORD PTR [rbp-724], 591
	mov	DWORD PTR [rbp-720], 571
	mov	DWORD PTR [rbp-716], 970
	mov	DWORD PTR [rbp-712], 786
	mov	DWORD PTR [rbp-708], 1249
	mov	DWORD PTR [rbp-704], 1578
	mov	DWORD PTR [rbp-700], 1976
	mov	DWORD PTR [rbp-696], 1220
	mov	DWORD PTR [rbp-692], 1670
	mov	DWORD PTR [rbp-688], 118
	mov	DWORD PTR [rbp-684], 1788
	mov	DWORD PTR [rbp-680], 1128
	mov	DWORD PTR [rbp-676], 1054
	mov	DWORD PTR [rbp-672], 920
	mov	DWORD PTR [rbp-668], 960
	mov	DWORD PTR [rbp-664], 1737
	mov	DWORD PTR [rbp-660], 966
	mov	DWORD PTR [rbp-656], 893
	mov	DWORD PTR [rbp-652], 111
	mov	DWORD PTR [rbp-648], 1403
	mov	DWORD PTR [rbp-644], 482
	mov	DWORD PTR [rbp-640], 1238
	mov	DWORD PTR [rbp-636], 1923
	mov	DWORD PTR [rbp-632], 754
	mov	DWORD PTR [rbp-628], 1262
	mov	DWORD PTR [rbp-624], 1878
	mov	DWORD PTR [rbp-620], 1031
	mov	DWORD PTR [rbp-616], 1267
	mov	DWORD PTR [rbp-612], 919
	mov	DWORD PTR [rbp-608], 1303
	mov	DWORD PTR [rbp-604], 1310
	mov	DWORD PTR [rbp-600], 1937
	mov	DWORD PTR [rbp-596], 1914
	mov	DWORD PTR [rbp-592], 1556
	mov	DWORD PTR [rbp-588], 41
	mov	DWORD PTR [rbp-584], 278
	mov	DWORD PTR [rbp-580], 667
	mov	DWORD PTR [rbp-576], 1164
	mov	DWORD PTR [rbp-572], 443
	mov	DWORD PTR [rbp-568], 469
	mov	DWORD PTR [rbp-564], 1907
	mov	DWORD PTR [rbp-560], 154
	mov	DWORD PTR [rbp-556], 287
	mov	DWORD PTR [rbp-552], 750
	mov	DWORD PTR [rbp-548], 677
	mov	DWORD PTR [rbp-544], 1186
	mov	DWORD PTR [rbp-540], 121
	mov	DWORD PTR [rbp-536], 1115
	mov	DWORD PTR [rbp-532], 1858
	mov	DWORD PTR [rbp-528], 118
	mov	DWORD PTR [rbp-524], 577
	mov	DWORD PTR [rbp-520], 1600
	mov	DWORD PTR [rbp-516], 80
	mov	DWORD PTR [rbp-512], 1933
	mov	DWORD PTR [rbp-508], 1212
	mov	DWORD PTR [rbp-504], 1227
	mov	DWORD PTR [rbp-500], 1711
	mov	DWORD PTR [rbp-496], 77
	mov	DWORD PTR [rbp-492], 1514
	mov	DWORD PTR [rbp-488], 1610
	mov	DWORD PTR [rbp-484], 1678
	mov	DWORD PTR [rbp-480], 1875
	mov	DWORD PTR [rbp-476], 1353
	mov	DWORD PTR [rbp-472], 854
	mov	DWORD PTR [rbp-468], 246
	mov	DWORD PTR [rbp-464], 325
	mov	DWORD PTR [rbp-460], 24
	mov	DWORD PTR [rbp-456], 1655
	mov	DWORD PTR [rbp-452], 846
	mov	DWORD PTR [rbp-448], 876
	mov	DWORD PTR [rbp-444], 259
	mov	DWORD PTR [rbp-440], 975
	mov	DWORD PTR [rbp-436], 1482
	mov	DWORD PTR [rbp-432], 1413
	mov	DWORD PTR [rbp-428], 595
	mov	DWORD PTR [rbp-424], 1155
	mov	DWORD PTR [rbp-420], 1013
	mov	DWORD PTR [rbp-416], 1022
	mov	DWORD PTR [rbp-412], 1085
	mov	DWORD PTR [rbp-408], 1695
	mov	DWORD PTR [rbp-404], 1854
	mov	DWORD PTR [rbp-400], 389
	mov	DWORD PTR [rbp-396], 1027
	mov	DWORD PTR [rbp-392], 812
	mov	DWORD PTR [rbp-388], 196
	mov	DWORD PTR [rbp-384], 481
	mov	DWORD PTR [rbp-380], 1628
	mov	DWORD PTR [rbp-376], 201
	mov	DWORD PTR [rbp-372], 1168
	mov	DWORD PTR [rbp-368], 1337
	mov	DWORD PTR [rbp-364], 88
	mov	DWORD PTR [rbp-360], 1455
	mov	DWORD PTR [rbp-356], 446
	mov	DWORD PTR [rbp-352], 497
	mov	DWORD PTR [rbp-348], 1329
	mov	DWORD PTR [rbp-344], 49
	mov	DWORD PTR [rbp-340], 731
	mov	DWORD PTR [rbp-336], 832
	mov	DWORD PTR [rbp-332], 1409
	mov	DWORD PTR [rbp-328], 201
	mov	DWORD PTR [rbp-324], 1566
	mov	DWORD PTR [rbp-320], 1059
	mov	DWORD PTR [rbp-316], 70
	mov	DWORD PTR [rbp-312], 904
	mov	DWORD PTR [rbp-308], 1431
	mov	DWORD PTR [rbp-304], 1618
	mov	DWORD PTR [rbp-300], 1091
	mov	DWORD PTR [rbp-296], 596
	mov	DWORD PTR [rbp-292], 881
	mov	DWORD PTR [rbp-288], 957
	mov	DWORD PTR [rbp-284], 1171
	mov	DWORD PTR [rbp-280], 1288
	mov	DWORD PTR [rbp-276], 17
	mov	DWORD PTR [rbp-272], 1336
	mov	DWORD PTR [rbp-268], 1215
	mov	DWORD PTR [rbp-264], 436
	mov	DWORD PTR [rbp-260], 1109
	mov	DWORD PTR [rbp-256], 1464
	mov	DWORD PTR [rbp-252], 1349
	mov	DWORD PTR [rbp-248], 168
	mov	DWORD PTR [rbp-244], 1008
	mov	DWORD PTR [rbp-240], 346
	mov	DWORD PTR [rbp-236], 869
	mov	DWORD PTR [rbp-232], 1927
	mov	DWORD PTR [rbp-228], 1998
	mov	DWORD PTR [rbp-224], 1669
	mov	DWORD PTR [rbp-220], 807
	mov	DWORD PTR [rbp-216], 1468
	mov	DWORD PTR [rbp-212], 774
	mov	DWORD PTR [rbp-208], 92
	mov	DWORD PTR [rbp-204], 1457
	mov	DWORD PTR [rbp-200], 1522
	mov	DWORD PTR [rbp-196], 976
	mov	DWORD PTR [rbp-192], 1957
	mov	DWORD PTR [rbp-188], 933
	mov	DWORD PTR [rbp-184], 862
	mov	DWORD PTR [rbp-180], 907
	mov	DWORD PTR [rbp-176], 948
	mov	DWORD PTR [rbp-172], 1999
	mov	DWORD PTR [rbp-168], 812
	mov	DWORD PTR [rbp-164], 1103
	mov	DWORD PTR [rbp-160], 428
	mov	DWORD PTR [rbp-156], 1454
	mov	DWORD PTR [rbp-152], 454
	mov	DWORD PTR [rbp-148], 716
	mov	DWORD PTR [rbp-144], 206
	mov	DWORD PTR [rbp-140], 1301
	mov	DWORD PTR [rbp-136], 1141
	mov	DWORD PTR [rbp-132], 1526
	mov	DWORD PTR [rbp-128], 1968
	mov	DWORD PTR [rbp-124], 939
	mov	DWORD PTR [rbp-120], 1148
	mov	DWORD PTR [rbp-116], 1660
	mov	DWORD PTR [rbp-112], 1545
	mov	DWORD PTR [rbp-108], 34
	mov	DWORD PTR [rbp-104], 1022
	mov	DWORD PTR [rbp-100], 1128
	mov	DWORD PTR [rbp-96], 433
	mov	DWORD PTR [rbp-92], 909
	mov	DWORD PTR [rbp-88], 234
	mov	DWORD PTR [rbp-84], 1971
	mov	DWORD PTR [rbp-80], 1539
	mov	DWORD PTR [rbp-76], 939
	mov	DWORD PTR [rbp-72], 1603
	mov	DWORD PTR [rbp-68], 1168
	mov	DWORD PTR [rbp-64], 1535
	mov	DWORD PTR [rbp-60], 156
	mov	DWORD PTR [rbp-56], 1389
	mov	DWORD PTR [rbp-52], 1647
	mov	DWORD PTR [rbp-48], 721
	mov	DWORD PTR [rbp-44], 1710
	mov	DWORD PTR [rbp-40], 656
	mov	DWORD PTR [rbp-36], 391
	mov	DWORD PTR [rbp-32], 1679
	mov	DWORD PTR [rbp-28], 1816
	mov	DWORD PTR [rbp-24], 1194
	mov	DWORD PTR [rbp-20], 1126
	mov	DWORD PTR [rbp-16], 68
	mov	DWORD PTR [rbp-12], 1447
	mov	DWORD PTR [rbp-8], 593
	mov	DWORD PTR [rbp-4], 239

	lea rdi, QWORD PTR [rbp-4000]
	mov esi, DWORD PTR [rbp-4004]


    call radix_sort
    mov eax, DWORD PTR [rbp-4]
    mov rsp, rbp    

    pop rbp 
    ret
