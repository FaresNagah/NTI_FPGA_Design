module six_digit_decoder (
    input  wire       clk,
    input  wire       rst_n,         
    input  wire       edge_detected,  
    input  wire [3:0] rise_count,     
    input  wire [3:0] fall_count,     
    input  wire [3:0] total_count,    

   
    output reg  [6:0] seg_r,          
    output reg  [6:0] seg_rc,         
    output reg  [6:0] seg_f,          
    output reg  [6:0] seg_fc,        
    output reg  [6:0] seg_t,          
    output reg  [6:0] seg_tc          
);

    
    localparam BLANK  = 7'b1111111;   
    localparam CHAR_N = 7'b0101011;   
    localparam CHAR_U = 7'b1100011;  
    localparam CHAR_L = 7'b1000111;   
    localparam CHAR_R = 7'b0101111;   
    localparam CHAR_F = 7'b0001110;   
    localparam CHAR_T = 7'b0000111;   


    
    wire [6:0] decoded_rc;
    wire [6:0] decoded_fc;
    wire [6:0] decoded_tc;

   
    bin_to_seg u_dec_rc (
        .Bin_in  (rise_count),
        .Seg_out (decoded_rc)
    );

    bin_to_seg u_dec_fc (
        .Bin_in  (fall_count),
        .Seg_out (decoded_fc)
    );

    bin_to_seg u_dec_tc (
        .Bin_in  (total_count),
        .Seg_out (decoded_tc)
    );

    
    reg started;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            started <= 1'b0;
        end else if (edge_detected) begin
            started <= 1'b1;
        end
    end

    
    
    always @(*) begin
        if (!started) begin
            
            seg_r  = BLANK;
            seg_rc = BLANK;
            seg_f  = CHAR_N; 
            seg_fc = CHAR_U; 
            seg_t  = CHAR_L; 
            seg_tc = CHAR_L; 
        end else begin
            
            seg_r  = CHAR_R;
            seg_rc = decoded_rc;
            seg_f  = CHAR_F;
            seg_fc = decoded_fc;
            seg_t  = CHAR_T;
            seg_tc = decoded_tc;
        end
    end

endmodule