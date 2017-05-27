/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/sbugel/Bureau/ProjetInfo/vhdl/RISC/bancRegistres.vhd";
extern char *IEEE_P_1242562249;

int ieee_p_1242562249_sub_17802405650254020620_1035706684(char *, char *, char *);


static void work_a_2067387895_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    char *t18;
    char *t19;

LAB0:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t1 = (t0 + 1032U);
    t3 = *((char **)t1);
    t1 = (t0 + 6936U);
    t4 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t3, t1);
    t5 = (t4 - 0);
    t6 = (t5 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t4);
    t7 = (16U * t6);
    t8 = (0 + t7);
    t9 = (t2 + t8);
    t10 = (t0 + 4288);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 16U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(53, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t1 = (t0 + 6952U);
    t4 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t3, t1);
    t5 = (t4 - 0);
    t6 = (t5 * 1);
    xsi_vhdl_check_range_of_index(0, 15, 1, t4);
    t7 = (16U * t6);
    t8 = (0 + t7);
    t9 = (t2 + t8);
    t10 = (t0 + 4352);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t9, 16U);
    xsi_driver_first_trans_fast_port(t10);
    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t15 = *((unsigned char *)t2);
    t16 = (t15 == (unsigned char)3);
    if (t16 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 4192);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 1352U);
    t3 = *((char **)t1);
    t1 = (t0 + 1032U);
    t9 = *((char **)t1);
    t17 = 1;
    if (4U == 4U)
        goto LAB8;

LAB9:    t17 = 0;

LAB10:    if (t17 != 0)
        goto LAB5;

LAB7:
LAB6:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t1 = (t0 + 1192U);
    t3 = *((char **)t1);
    t15 = 1;
    if (4U == 4U)
        goto LAB17;

LAB18:    t15 = 0;

LAB19:    if (t15 != 0)
        goto LAB14;

LAB16:
LAB15:    goto LAB3;

LAB5:    xsi_set_current_line(56, ng0);
    t11 = (t0 + 1672U);
    t12 = *((char **)t11);
    t11 = (t0 + 4288);
    t13 = (t11 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t12, 16U);
    xsi_driver_first_trans_fast_port(t11);
    goto LAB6;

LAB8:    t6 = 0;

LAB11:    if (t6 < 4U)
        goto LAB12;
    else
        goto LAB10;

LAB12:    t1 = (t3 + t6);
    t10 = (t9 + t6);
    if (*((unsigned char *)t1) != *((unsigned char *)t10))
        goto LAB9;

LAB13:    t6 = (t6 + 1);
    goto LAB11;

LAB14:    xsi_set_current_line(59, ng0);
    t10 = (t0 + 1672U);
    t11 = *((char **)t10);
    t10 = (t0 + 4352);
    t12 = (t10 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t11, 16U);
    xsi_driver_first_trans_fast_port(t10);
    goto LAB15;

LAB17:    t6 = 0;

LAB20:    if (t6 < 4U)
        goto LAB21;
    else
        goto LAB19;

LAB21:    t1 = (t2 + t6);
    t9 = (t3 + t6);
    if (*((unsigned char *)t1) != *((unsigned char *)t9))
        goto LAB18;

LAB22:    t6 = (t6 + 1);
    goto LAB20;

}

static void work_a_2067387895_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    unsigned char t8;
    unsigned char t9;
    int t10;
    int t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;

LAB0:    t1 = (t0 + 3872U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(66, ng0);

LAB6:    t2 = (t0 + 4208);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t6 = (t0 + 4208);
    *((int *)t6) = 0;
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 1832U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t5 = (t3 == (unsigned char)2);
    if (t5 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 1512U);
    t4 = *((char **)t2);
    t3 = *((unsigned char *)t4);
    t5 = (t3 == (unsigned char)3);
    if (t5 != 0)
        goto LAB19;

LAB21:
LAB20:
LAB12:    goto LAB2;

LAB5:    t4 = (t0 + 1952U);
    t5 = xsi_signal_has_event(t4);
    if (t5 == 1)
        goto LAB8;

LAB9:    t3 = (unsigned char)0;

LAB10:    if (t3 == 1)
        goto LAB4;
    else
        goto LAB6;

LAB7:    goto LAB5;

LAB8:    t6 = (t0 + 1992U);
    t7 = *((char **)t6);
    t8 = *((unsigned char *)t7);
    t9 = (t8 == (unsigned char)3);
    t3 = t9;
    goto LAB10;

LAB11:    xsi_set_current_line(69, ng0);
    t2 = (t0 + 7359);
    *((int *)t2) = 0;
    t6 = (t0 + 7363);
    *((int *)t6) = 15;
    t10 = 0;
    t11 = 15;

LAB14:    if (t10 <= t11)
        goto LAB15;

LAB17:    goto LAB12;

LAB15:    xsi_set_current_line(70, ng0);
    t7 = xsi_get_transient_memory(16U);
    memset(t7, 0, 16U);
    t12 = t7;
    memset(t12, (unsigned char)2, 16U);
    t13 = (t0 + 7359);
    t14 = *((int *)t13);
    t15 = (t14 - 0);
    t16 = (t15 * 1);
    t17 = (16U * t16);
    t18 = (0U + t17);
    t19 = (t0 + 4416);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t7, 16U);
    xsi_driver_first_trans_delta(t19, t18, 16U, 0LL);

LAB16:    t2 = (t0 + 7359);
    t10 = *((int *)t2);
    t4 = (t0 + 7363);
    t11 = *((int *)t4);
    if (t10 == t11)
        goto LAB17;

LAB18:    t14 = (t10 + 1);
    t10 = t14;
    t6 = (t0 + 7359);
    *((int *)t6) = t10;
    goto LAB14;

LAB19:    xsi_set_current_line(75, ng0);
    t2 = (t0 + 1672U);
    t6 = *((char **)t2);
    t2 = (t0 + 1352U);
    t7 = *((char **)t2);
    t2 = (t0 + 6968U);
    t10 = ieee_p_1242562249_sub_17802405650254020620_1035706684(IEEE_P_1242562249, t7, t2);
    t11 = (t10 - 0);
    t16 = (t11 * 1);
    t17 = (16U * t16);
    t18 = (0U + t17);
    t12 = (t0 + 4416);
    t13 = (t12 + 56U);
    t19 = *((char **)t13);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t6, 16U);
    xsi_driver_first_trans_delta(t12, t18, 16U, 0LL);
    goto LAB20;

}


extern void work_a_2067387895_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2067387895_3212880686_p_0,(void *)work_a_2067387895_3212880686_p_1};
	xsi_register_didat("work_a_2067387895_3212880686", "isim/processeur_isim_beh.exe.sim/work/a_2067387895_3212880686.didat");
	xsi_register_executes(pe);
}
