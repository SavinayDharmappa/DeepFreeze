module line_buffer_array_k5
#(
    parameter KER_SIZE = 5,
    parameter BITWIDTH = 8,
    parameter AW = 8
)
(
    input logic clk,
    input logic rstn,
    input logic [BITWIDTH*KER_SIZE-1:0] pixel_in,
    input logic [3-1:0] col_ptr,
    input logic [3-1:0] init_col_ptr,
    output logic [BITWIDTH*KER_SIZE*KER_SIZE-1:0] pixel_out   
);

// wires
logic [KER_SIZE*BITWIDTH-1:0] pixel_col [KER_SIZE-1:0];
logic [KER_SIZE*KER_SIZE*BITWIDTH-1:0] pixel_out_wire;
logic ready;

// reg array
genvar i;
generate
for (i = 0; i < KER_SIZE; i++) begin
    dff #(
        .BITWIDTH (BITWIDTH*KER_SIZE)
    ) reg_inst (
        .clk (clk),
        .rstn (rstn),
        .valid (col_ptr == i),
        .D (pixel_in),
        .Q (pixel_col[i])
    ); // each dff stores a column of data
end
endgenerate

// reshape
always_comb begin
    case (1'b1)
        (col_ptr == 'd0): pixel_out_wire = {pixel_in[5*BITWIDTH-1:4*BITWIDTH],pixel_col[4][5*BITWIDTH-1:4*BITWIDTH],pixel_col[3][5*BITWIDTH-1:4*BITWIDTH],pixel_col[2][5*BITWIDTH-1:4*BITWIDTH],pixel_col[1][5*BITWIDTH-1:4*BITWIDTH],pixel_in[4*BITWIDTH-1:3*BITWIDTH],pixel_col[4][4*BITWIDTH-1:3*BITWIDTH],pixel_col[3][4*BITWIDTH-1:3*BITWIDTH],pixel_col[2][4*BITWIDTH-1:3*BITWIDTH],pixel_col[1][4*BITWIDTH-1:3*BITWIDTH],pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[4][3*BITWIDTH-1:2*BITWIDTH],pixel_col[3][3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[4][2*BITWIDTH-1:BITWIDTH],pixel_col[3][2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[4][BITWIDTH-1:0],pixel_col[3][BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0]};
        (col_ptr == 'd1): pixel_out_wire = {pixel_in[5*BITWIDTH-1:4*BITWIDTH],pixel_col[0][5*BITWIDTH-1:4*BITWIDTH],pixel_col[4][5*BITWIDTH-1:4*BITWIDTH],pixel_col[3][5*BITWIDTH-1:4*BITWIDTH],pixel_col[2][5*BITWIDTH-1:4*BITWIDTH],pixel_in[4*BITWIDTH-1:3*BITWIDTH],pixel_col[0][4*BITWIDTH-1:3*BITWIDTH],pixel_col[4][4*BITWIDTH-1:3*BITWIDTH],pixel_col[3][4*BITWIDTH-1:3*BITWIDTH],pixel_col[2][4*BITWIDTH-1:3*BITWIDTH],pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_col[4][3*BITWIDTH-1:2*BITWIDTH],pixel_col[3][3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_col[4][2*BITWIDTH-1:BITWIDTH],pixel_col[3][2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0],pixel_col[4][BITWIDTH-1:0],pixel_col[3][BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0]};
        (col_ptr == 'd2): pixel_out_wire = {pixel_in[5*BITWIDTH-1:4*BITWIDTH],pixel_col[1][5*BITWIDTH-1:4*BITWIDTH],pixel_col[0][5*BITWIDTH-1:4*BITWIDTH],pixel_col[4][5*BITWIDTH-1:4*BITWIDTH],pixel_col[3][5*BITWIDTH-1:4*BITWIDTH],pixel_in[4*BITWIDTH-1:3*BITWIDTH],pixel_col[1][4*BITWIDTH-1:3*BITWIDTH],pixel_col[0][4*BITWIDTH-1:3*BITWIDTH],pixel_col[4][4*BITWIDTH-1:3*BITWIDTH],pixel_col[3][4*BITWIDTH-1:3*BITWIDTH],pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_col[4][3*BITWIDTH-1:2*BITWIDTH],pixel_col[3][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_col[4][2*BITWIDTH-1:BITWIDTH],pixel_col[3][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0],pixel_col[4][BITWIDTH-1:0],pixel_col[3][BITWIDTH-1:0]};
        (col_ptr == 'd3): pixel_out_wire = {pixel_in[5*BITWIDTH-1:4*BITWIDTH],pixel_col[2][5*BITWIDTH-1:4*BITWIDTH],pixel_col[1][5*BITWIDTH-1:4*BITWIDTH],pixel_col[0][5*BITWIDTH-1:4*BITWIDTH],pixel_col[4][5*BITWIDTH-1:4*BITWIDTH],pixel_in[4*BITWIDTH-1:3*BITWIDTH],pixel_col[2][4*BITWIDTH-1:3*BITWIDTH],pixel_col[1][4*BITWIDTH-1:3*BITWIDTH],pixel_col[0][4*BITWIDTH-1:3*BITWIDTH],pixel_col[4][4*BITWIDTH-1:3*BITWIDTH],pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_col[4][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_col[4][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0],pixel_col[4][BITWIDTH-1:0]};
        (col_ptr == 'd4): pixel_out_wire = {pixel_in[5*BITWIDTH-1:4*BITWIDTH],pixel_col[3][5*BITWIDTH-1:4*BITWIDTH],pixel_col[2][5*BITWIDTH-1:4*BITWIDTH],pixel_col[1][5*BITWIDTH-1:4*BITWIDTH],pixel_col[0][5*BITWIDTH-1:4*BITWIDTH],pixel_in[4*BITWIDTH-1:3*BITWIDTH],pixel_col[3][4*BITWIDTH-1:3*BITWIDTH],pixel_col[2][4*BITWIDTH-1:3*BITWIDTH],pixel_col[1][4*BITWIDTH-1:3*BITWIDTH],pixel_col[0][4*BITWIDTH-1:3*BITWIDTH],pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[3][3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[3][2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[3][BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0]};
        default:          pixel_out_wire = '0;
    endcase
end



// output flop
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        pixel_out <= '0;
    end
    else if (ready) begin
        pixel_out <= pixel_out_wire;
    end
    else begin
        pixel_out <= pixel_out;
    end
end

assign ready = (init_col_ptr == KER_SIZE-1);

endmodule

module line_buffer_array_k3
#(
    parameter   KER_SIZE    = 3,
    parameter BITWIDTH  = 8,
    parameter AW                = 8
)
(
    input logic clk,
    input logic rstn,
    input logic [BITWIDTH*KER_SIZE-1:0] pixel_in,
    input logic [3-1:0] col_ptr,
    input logic [3-1:0] init_col_ptr,
    output logic [BITWIDTH*KER_SIZE*KER_SIZE-1:0] pixel_out   
);

// wires
logic [KER_SIZE*BITWIDTH-1:0] pixel_col [KER_SIZE-1:0];
logic [KER_SIZE*KER_SIZE*BITWIDTH-1:0] pixel_out_wire;
logic ready;

// reg array
genvar i;
generate
for (i = 0; i < KER_SIZE; i++) begin
    dff #(
        .BITWIDTH (BITWIDTH*KER_SIZE)
    ) reg_inst (
        .clk (clk),
        .rstn (rstn),
        .valid (col_ptr == i),
        .D (pixel_in),
        .Q (pixel_col[i])
    ); // each dff stores a column of data
end
endgenerate

// reshape
always_comb begin
    case (1'b1)
        (col_ptr == 'd0): pixel_out_wire = {pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0]};
        (col_ptr == 'd1): pixel_out_wire = {pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_col[2][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_col[2][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0],pixel_col[2][BITWIDTH-1:0]};
        (col_ptr == 'd2): pixel_out_wire = {pixel_in[3*BITWIDTH-1:2*BITWIDTH],pixel_col[1][3*BITWIDTH-1:2*BITWIDTH],pixel_col[0][3*BITWIDTH-1:2*BITWIDTH],pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0]};
        default:          pixel_out_wire = '0;
    endcase
end

// output flop
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        pixel_out <= '0;
    end
    else if (ready) begin
        pixel_out <= pixel_out_wire;
    end
    else begin
        pixel_out <= pixel_out;
    end
end

assign ready = (init_col_ptr == KER_SIZE-1);

endmodule

module line_buffer_array_k2
#(
    parameter KER_SIZE = 3,
    parameter BITWIDTH = 8,
    parameter AW = 8
)
(
    input logic clk,
    input logic rstn,
    input logic [BITWIDTH*KER_SIZE-1:0] pixel_in,
    input logic [3-1:0] col_ptr,
    input logic [3-1:0] init_col_ptr,
    output logic [BITWIDTH*KER_SIZE*KER_SIZE-1:0] pixel_out
);

// wires
logic [KER_SIZE*BITWIDTH-1:0] pixel_col [KER_SIZE-1:0];
logic [KER_SIZE*KER_SIZE*BITWIDTH-1:0] pixel_out_wire;
logic ready;

// reg array
genvar i;
generate
for (i=0;i<KER_SIZE;i++) begin
    dff #(
        .BITWIDTH (BITWIDTH*KER_SIZE)
    ) reg_inst (
        .clk (clk),
        .rstn (rstn),
        .valid (col_ptr == i),
        .D (pixel_in),
        .Q (pixel_col[i])
    ); // each dff stores a column of data
end
endgenerate

// reshape
always_comb begin
    case (1'b1)
        (col_ptr == 'd0): pixel_out_wire = {pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[1][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[1][BITWIDTH-1:0]};
        (col_ptr == 'd1): pixel_out_wire = {pixel_in[2*BITWIDTH-1:BITWIDTH],pixel_col[0][2*BITWIDTH-1:BITWIDTH],pixel_in[BITWIDTH-1:0],pixel_col[0][BITWIDTH-1:0]};
        default:          pixel_out_wire = '0;
    endcase
end

// output flop
always_ff @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        pixel_out <= '0;
    end
    else if (ready) begin
        pixel_out <= pixel_out_wire;
    end
    else begin
        pixel_out <= pixel_out;
    end
end

assign ready = (init_col_ptr == KER_SIZE-1);

endmodule

// dff
module dff
#(
    parameter BITWIDTH = 8
)
(
    input logic clk,
    input logic rstn,
    input logic valid,
    input logic [BITWIDTH-1:0] D,
    output logic [BITWIDTH-1:0] Q
);

always_ff @(posedge clk or negedge rstn) begin
    if (rstn == 0) begin
        Q <= '0;
    end
    else if (valid == 1) begin
        Q <= D;
    end
    else begin
        Q <= Q;
    end     
end

endmodule
