`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : zzg
// Create Date   : 2021/12/09
// Module Name   : vga_pic
// Project Name  : hdmi_colorbar
// Target Devices: Altera EP4CE10F17C8N
// Tool Versions : Quartus 13.0
// Description   : 图像数据生成模块
// 实验平台: 野火_征途Pro_FPGA开发板
////////////////////////////////////////////////////////////////////////

module  vga_pic
(
    input   wire            vga_clk     ,   //输入工作时钟,频率MHz
    input   wire            sys_rst_n   ,   //输入复位信号,低电平有效
    input   wire    [11:0]  pix_x       ,   //输入有效显示区域像素点X轴坐标
    input   wire    [11:0]  pix_y       ,   //输入有效显示区域像素点Y轴坐标
	  input	  wire	  [3:0]	  pix_num     ,	  //输入pix编号
    output  reg     [23:0]  pix_data        //输出像素点色彩信息
);

//********************************************************************//
//****************** Parameter and Internal Signal *******************//
//********************************************************************//
//parameter define
parameter   H_VALID =   12'd1920 ,   //行有效数据
            V_VALID =   12'd1080 ;   //场有效数据
//RED和BLUE最大F8,GREEN最大FC
parameter   RED     =   24'hF80000,   //红色
            //ORANGE  =   24'hFF9900,   //橙色
            //YELLOW  =   24'hFFFF00,   //黄色
            GREEN   =   24'h00FC00,   //绿色
            //CYAN    =   24'h99CC00,   //青色
            BLUE    =   24'h0000F8,   //蓝色
            //PURPPLE =   24'h990099,   //紫色
            BLACK   =   24'h000000,   //黑色
            WHITE   =   24'hF7FBF7;   //白色
            //GRAY    =   24'h999966;   //灰色

//********************************************************************//
//***************************** Main Code ****************************//
//********************************************************************//
//pix_data:输出像素点色彩信息,根据当前像素点坐标指定当前像素点颜色数据
/*
always@(posedge vga_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
        pix_data    <= 24'd0;
    else    if((pix_x >= 0) && (pix_x < (H_VALID/10)*1))
        pix_data    <=  RED;
    else    if((pix_x >= (H_VALID/10)*1) && (pix_x < (H_VALID/10)*2))
        pix_data    <=  ORANGE;
    else    if((pix_x >= (H_VALID/10)*2) && (pix_x < (H_VALID/10)*3))
        pix_data    <=  YELLOW;
    else    if((pix_x >= (H_VALID/10)*3) && (pix_x < (H_VALID/10)*4))
        pix_data    <=  GREEN;
    else    if((pix_x >= (H_VALID/10)*4) && (pix_x < (H_VALID/10)*5))
        pix_data    <=  CYAN;
    else    if((pix_x >= (H_VALID/10)*5) && (pix_x < (H_VALID/10)*6))
        pix_data    <=  BLUE;
    else    if((pix_x >= (H_VALID/10)*6) && (pix_x < (H_VALID/10)*7))
        pix_data    <=  PURPPLE;
    else    if((pix_x >= (H_VALID/10)*7) && (pix_x < (H_VALID/10)*8))
        pix_data    <=  BLACK;
    else    if((pix_x >= (H_VALID/10)*8) && (pix_x < (H_VALID/10)*9))
        pix_data    <=  WHITE;
    else    if((pix_x >= (H_VALID/10)*9) && (pix_x < H_VALID))
        pix_data    <=  GRAY;
    else
        pix_data    <=  BLACK;
*/
//显示图片
always@(posedge vga_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'b0)
      pix_data   <= 24'h000000;
	else	if(pix_num == 4'd1)
		pix_data    <= RED;
	else	if(pix_num == 4'd2)
		pix_data    <= GREEN;
	else	if(pix_num == 4'd3)
		pix_data    <= BLUE;
	else	if(pix_num == 4'd4)
		pix_data    <= BLACK;
	else
		pix_data	  <= WHITE;
endmodule




