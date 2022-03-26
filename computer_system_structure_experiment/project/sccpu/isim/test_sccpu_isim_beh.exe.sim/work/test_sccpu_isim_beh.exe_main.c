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

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    work_m_00000000003955388688_3405346048_init();
    work_m_00000000000407460910_2878662293_init();
    work_m_00000000003005697404_3209059564_init();
    work_m_00000000002805721940_1015039846_init();
    work_m_00000000003990670868_3426655958_init();
    work_m_00000000002076970887_3901337038_init();
    work_m_00000000001125105523_2937920168_init();
    work_m_00000000003968035491_1888978594_init();
    work_m_00000000001381859348_1537314815_init();
    work_m_00000000003968035491_3150651486_init();
    work_m_00000000002169457944_2725559894_init();
    work_m_00000000002981036287_2793692760_init();
    work_m_00000000003499276030_3373111005_init();
    work_m_00000000000024547170_1363188188_init();
    work_m_00000000004183470729_3985901070_init();
    work_m_00000000001901667710_3950305895_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001901667710_3950305895");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
