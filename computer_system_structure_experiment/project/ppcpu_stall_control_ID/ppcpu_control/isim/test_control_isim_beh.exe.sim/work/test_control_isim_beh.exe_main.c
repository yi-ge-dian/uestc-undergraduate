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
    work_m_00000000001876999766_3405346048_init();
    work_m_00000000000407460910_2878662293_init();
    work_m_00000000003005697404_3209059564_init();
    work_m_00000000002805721940_1015039846_init();
    work_m_00000000000750217755_3426655958_init();
    work_m_00000000004027017221_0345418465_init();
    work_m_00000000002076970887_3901337038_init();
    work_m_00000000001125105523_2937920168_init();
    work_m_00000000003968035491_1888978594_init();
    work_m_00000000001602802262_1537314815_init();
    work_m_00000000002945893080_3264640172_init();
    work_m_00000000003968035491_3150651486_init();
    work_m_00000000002169457944_2725559894_init();
    work_m_00000000002981036287_2793692760_init();
    work_m_00000000000317854018_3440754425_init();
    work_m_00000000003499276030_3373111005_init();
    work_m_00000000001833182487_2520395732_init();
    work_m_00000000000024547170_1363188188_init();
    work_m_00000000001563153463_3493046568_init();
    work_m_00000000001933068313_1329951597_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001933068313_1329951597");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
