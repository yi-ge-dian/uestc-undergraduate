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
    work_m_00000000001137239481_2009983731_init();
    work_m_00000000000108867082_4062847055_init();
    work_m_00000000003305179316_0267516215_init();
    work_m_00000000004134133675_1307194410_init();
    work_m_00000000003024068576_0894457032_init();
    work_m_00000000004273465065_2058220583_init();
    work_m_00000000001523151090_2762404611_init();
    work_m_00000000002112780494_3901337038_init();
    work_m_00000000003305179316_1106303070_init();
    work_m_00000000000156543715_0254784918_init();
    work_m_00000000001137239481_0276880790_init();
    work_m_00000000002174442682_0886308060_init();
    work_m_00000000002065329345_1939551284_init();
    work_m_00000000004099279469_4074116714_init();
    work_m_00000000002305428850_1212827383_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002305428850_1212827383");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
