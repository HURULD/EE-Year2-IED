module spi_stream_test(
	// global clock & reset
	clk,
	reset_n,
	spi_clock_source,

	
	// streaming sink
	sink_data,
	sink_valid,
	sink_ready,
	sink_sop,
	sink_eop,

	
	spi_clk,
	spi_ss,
	spi_mosi,
	spi_miso,

);


// global clock & reset
input	clk;
input	reset_n;


// streaming sink
input	[23:0]            	sink_data;
input								sink_valid;
output							sink_ready;
input								sink_sop;
input								sink_eop;

// SPI

input			spi_clock_source;
output		spi_clk;
output		spi_ss;
output		spi_mosi;
input			spi_miso;



////////////////////////////////////////////////////////////////////////

parameter IMAGE_W = 11'd320;
parameter IMAGE_H = 11'd240;
parameter MESSAGE_BUF_MAX = 256;
parameter MSG_INTERVAL = 6;
parameter BB_COL_DEFAULT = 24'h00ff00;

`define QOI_OP_INDEX  2'b00       /* 0x00 */
`define QOI_OP_DIFF   2'b01       /* 0x40 */
`define QOI_OP_LUMA   2'b10       /* 0x80 */
`define QOI_OP_RUN    2'b11       /* 0xc0 */
`define QOI_OP_RGB    8'b11111110 /* 0xfe */


//Input and output colour channels
wire [7:0]   red, green, blue;
wire [7:0]   red_out, green_out, blue_out;
wire [7:0] 	 maxrg, maxgb, max, minrg, mingb, min;
assign maxrg = red>=green ? red: green;
assign maxgb = green>=blue ? green: blue;
assign max = maxrg>=maxgb ? maxrg:maxgb;

assign minrg = red>=green ? red: green;
assign mingb = green>=blue ? green: blue;
assign min = minrg>=mingb ? minrg:mingb;

wire [7:0] greyscale = (max + min) >> 1;

wire sop, eop;

assign spi_clk = spi_clock_source;
reg frame_transmit, frame_buffering = 0;

reg[7:0] buffer;

////////////////////////////////////////////////////////////////////////

//transmit pixel

always@(posedge spi_clock_source) begin
	if(frame_transmit) begin
		spi_mosi <= buffer[0];
		buffer <= buffer >> 1;
	end
end

always@(posedge clk) begin
	buffer <= greyscale;
end

//Streaming registers to buffer video signal
STREAM_REG #(.DATA_WIDTH(26)) in_reg (
	.clk(clk),
	.rst_n(reset_n),
	.ready_out(sink_ready),
	.valid_out(in_valid),
	.data_out({red,green,blue,sop,eop}),
	.ready_in(out_ready),
	.valid_in(sink_valid),
	.data_in({sink_data,sink_sop,sink_eop})
);



endmodule

