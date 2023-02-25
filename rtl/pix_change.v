`timescale  1ns/1ns
////////////////////////////////////////////////////////////////////////
// Author        : zzg
// Create Date   : 2021/12/20
// Module Name   : pix_change
// Project Name  : hdmi_colorbar
// Target Devices: Altera EP4CE10F17C8N
// Description   : pix切换(1080p)
// Revision      : V1.0
////////////////////////////////////////////////////////////////////////
module pix_change
(
	input   wire            sys_clk     ,   //输入工作时钟,频率MHz
   input   wire            sys_rst_n ,//输入复位信号,低电平有效
	input   wire 			   key_in,
	output  reg    [3:0]	   pix_num
);
//parameter   pixtime 	= 	22'd2475000;//一帧的clk
//parameter	FrameMax	=	10'd300;

//reg [21:0] cnt;
//reg [9:0]	frame;

reg [19:0] cnt_20ms;
reg  key_flag;

//对vga_clk的计数
/*always@(posedge vga_clk or negedge sys_rst_n)
	if(sys_rst_n == 1'd0)
		cnt <= 22'd0;
	else if(cnt == pixtime - 1'd1)
		cnt <= 22'd0; 
	else 
		cnt <= cnt + 1'd1;
*/
//对帧数的计数
/*		
always@(posedge vga_clk or negedge sys_rst_n)	
	if(sys_rst_n == 1'd0)
		frame 	<= 1'd0;
	else   if(frame == FrameMax - 1'd1)
		frame <= 1'd0;
	else	if(cnt == pixtime - 1'd1)
		frame <=	frame + 1'd1;
	else
		frame <=	frame;
*/
//pix_num
/*
always@(posedge vga_clk or negedge sys_rst_n)	
	if(sys_rst_n == 1'd0 && pix_num==4'd10)
		pix_num <= 4'd0;
	else if(frame == FrameMax - 1'd1)
		pix_num <= pix_num + 1'd1;
	else 
		pix_num <= pix_num;
*/
always@(posedge sys_clk or negedge sys_rst_n)	
	if(sys_rst_n==1'b0)
		cnt_20ms<=1'b0;
	else if(key_in==1'b1)
		cnt_20ms<=1'b0;
	else if(key_in==1'b0 && cnt_20ms==20'd999999)
		cnt_20ms<=cnt_20ms;
	else
		cnt_20ms<=cnt_20ms+1;
		
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n==1'b0)
		key_flag<=1'b0;
	else if(cnt_20ms==20'd999998)
		key_flag<=1'b1;
	else
		key_flag<=1'b0;
	
	
always@(posedge sys_clk or negedge sys_rst_n)
	if(sys_rst_n==1'b0)
		pix_num<=1'b0;
	else if(key_flag==1'b1&&pix_num==4'd4)
		pix_num<=1'b1;
	else if(key_flag==1'b1&&pix_num<4'd4)
		pix_num<=pix_num+1;
	else
		pix_num<=pix_num;
		
endmodule	
	
	
	
	