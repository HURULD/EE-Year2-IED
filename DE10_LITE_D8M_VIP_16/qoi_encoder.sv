module qoi_encoder(
	// global clock & reset
	clk,
	reset_n,

	
	// streaming sink
	sink_data,
	sink_valid,
	sink_ready,
	sink_sop,
	sink_eop,

	// streaming source
	source_data,
	source_valid,
	source_ready,
	source_sop,
	source_eop,

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

// streaming source
output	[47:0]			  	   source_data;
output								source_valid;
input									source_ready;
output								source_sop;
output								source_eop;


////////////////////////////////////////////////////////////////////////

parameter IMAGE_W = 11'd640;
parameter IMAGE_H = 11'd480;
parameter MESSAGE_BUF_MAX = 256;
parameter MSG_INTERVAL = 6;
parameter BB_COL_DEFAULT = 24'h00ff00;

`define QOI_OP_INDEX  2'b00       /* 0x00 */
`define QOI_OP_DIFF   2'b01       /* 0x40 */
`define QOI_OP_LUMA   2'b10       /* 0x80 */
`define QOI_OP_RUN    2'b11       /* 0xc0 */
`define QOI_OP_RGB    8'b11111110 /* 0xfe */


//Input and output colour channels
wire [7:0]   red, green, blue, grey;
wire [7:0]   red_out, green_out, blue_out;
wire[31:0] pixel = {red, green, blue, 8'hff}; //Combine into one pixel with an alpha channel of 0xff
wire   sop, eop, in_valid, out_ready;

// Output chunk 
reg[7:0] chunk[4:0];
reg[2:0] chunk_len;

//	QOI_OP_DIFF
reg[7:0] prev_red, prev_blue, prev_green;
wire signed[7:0] vred = red - prev_red;
wire signed[7:0] vgreen = green - prev_green;
wire signed[7:0] vblue = blue - prev_blue;

// QOI_OP_LUMA
wire signed[7:0] vg_red = vred - vgreen;
wire signed[7:0] vg_blue = vblue - vgreen;

// QOI_OP_RUN
reg prev_finish; // aka past-end
wire is_repeating = ({prev_red, prev_green, prev_blue, 8'hff} == pixel) && !eop; //Alpha channel is still ff as input is RGB
reg[7:0] next_chunk[4:0];
reg[2:0] next_chunk_len;
reg[5:0] run;

// QOI_OP_INDEX
reg[31:0] array[63:0]; // array of previously seen pixels
wire[5:0] array_pos = {red * 3 + green * 5 + blue * 7 + 8'hff * 11}; //Hash function to assign 


////////////////////////////////////////////////////////////////////////

//Compress next pixel

always@(posedge clk) begin
	if (is_repeating) begin : start_and_midde_OP_RUN
		next_chunk[0] <= {`QOI_OP_RUN, run}; // Dummy
		// This chunk is not over, let output know not to expect anything yet
		next_chunk_len <= 0;
		run <= run + 1;
	end 
	//QOI_OP_INDEX
	else if (array[array_pos] == pixel) begin
		next_chunk[0] <= {`QOI_OP_INDEX, array_pos};
		next_chunk_len <= 1;
	end 
	//QOI_OP_DIFF
	else if (
		vred > -3 && vred < 2 &&
		vgreen > -3 && vgreen < 2 &&
		vblue > -3 && vblue < 2
	) begin
		next_chunk[0] <= {`QOI_OP_DIFF, 2'(vred + 2), 2'(vgreen + 2), 2'(vblue + 2)};
		next_chunk_len <= 1;
	end 
	//QOI_OP_LUMA
	else if (
		vg_red >  -9 && vg_red <  8 &&
		vgreen   > -33 && vgreen   < 32 &&
		vg_blue >  -9 && vg_blue <  8
	) begin
		next_chunk[0] <= {`QOI_OP_LUMA, 6'(vgreen + 32)};
		next_chunk[1] <= {4'(vg_red + 8), 4'(vg_blue + 8)};
		next_chunk_len <= 2;
	end 
	//QOI_OP_RGB
	else begin
		next_chunk[0] <= `QOI_OP_RGB;
		next_chunk[1] <= red;
		next_chunk[2] <= green;
		next_chunk[3] <= blue;
		next_chunk_len <= 4;
	end

	//Update previous pixels
	prev_red <= red;
	prev_green <= green;
	prev_blue <= blue;
	prev_finish <= eop;

	//Assign to array
	array[array_pos] <= pixel;

	chunk <= next_chunk;
	chunk_len <= next_chunk_len;
	if (((run > 0) && !is_repeating) || (run == 62)) begin : commit_OP_RUN
		run <= is_repeating; // count the current repeat, otherwise start from 0
		chunk[0] <= {`QOI_OP_RUN, 6'(run - 1)};
		chunk_len <= 1;
	end : commit_OP_RUN

	if (prev_finish) begin
		// to be nice, make sure we don't output extra bogus chunks after we
		// emitted the last real chunk shortly after the last pixel in the stream
		chunk_len <= 0;
	end

	if (reset_n) begin
		prev_red <= 0;
		prev_green <= 0;
		prev_blue <= 0;

		chunk <= '{default: '0};
		chunk_len <= 0;

		next_chunk <= '{default: '0};
		next_chunk_len <= 0;

		run <= 0;

		array <= '{default: '0};
	end
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

STREAM_REG #(.DATA_WIDTH(48)) out_reg (
	.clk(clk),
	.rst_n(reset_n),	
	.ready_out(out_ready),
	.valid_out(source_valid),
	.data_out({source_data,source_sop,source_eop}),
	.ready_in(source_ready),
	.valid_in(in_valid),
	.data_in({chunk[0],chunk[1],chunk[2],chunk[3],chunk[4], sop, eop})
);



endmodule

