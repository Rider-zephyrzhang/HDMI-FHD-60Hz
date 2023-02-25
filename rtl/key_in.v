`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : zzg
// Create Date   : 2021/12/20
// Module Name   : key_in
// Project Name  : hdmi_colorbar
// Target Devices: Altera EP4CE10F17C8N
// Description   : pix切换(1080p)
// Revision      : V1.0
////////////////////////////////////////////////////////////////////////
module key_in
(
	input   wire            vga_clk     ,   //输入工作时钟,频率MHz
  input   wire            sys_rst_n ,//输入复位信号,低电平有效
	output  reg    [3:0]	  pix_num   //pix的编号
);
parameter   pixtime 	= 	22'd2475000;//一帧图片所包含的clk数
parameter	  FrameMax	=	  10'd300;

reg [21:0] cnt_clk;
reg [9:0]	frame;

//对vga_clk的计数
always@(posedge vga_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'd0)
		cnt_clk <= 22'd0;
	else if(cnt_clk == pixtime - 1'd1)
		cnt_clk <= 22'd0; 
	else 
		cnt_clk <= cnt_clk + 1'd1;

//对帧数的计数		
always@(posedge vga_clk or negedge sys_rst_n)	
	if(sys_rst_n == 1'd0)
		frame 	<= 1'd0;
	else   if(frame == FrameMax - 1'd1)
		frame <= 1'd0;
	else	if(cnt_clk == pixtime - 1'd1)
		frame <=	frame + 1'd1;
	else
		frame <=	frame;

//pix_num
always@(posedge vga_clk or negedge sys_rst_n)	
	if(sys_rst_n == 1'd0)
		pix_num <= 4'd0;
	else if(pix_num == 4'd10)
		pix_num <= 4'd0;
	else if(frame == FrameMax - 1'd1)
		pix_num <= pix_num + 1'd1;
	else 
		pix_num <= pix_num;
		
endmodule
	
	
	
	
	
	
	
	