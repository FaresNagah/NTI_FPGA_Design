module stream_parity_gen (
    input  wire clk,
    input  wire reset,
    input  wire serial_in,
    output reg  parity_out,
    output reg  valid       
);

    reg [7:0] shift_reg;
    reg [3:0] count;         
    
    function calc_even_parity;
        input [7:0] data;
        integer i;
        begin
            calc_even_parity = 1'b0;
            for (i = 0; i < 8; i = i + 1) begin
                calc_even_parity = calc_even_parity ^ data[i];
            end
        end
    endfunction

    always @(posedge clk) begin
        if (reset) begin
            shift_reg  <= 8'b0;
            count      <= 4'd0;
            parity_out <= 1'b0;
            valid      <= 1'b0;
        end else begin
           
            shift_reg <= {shift_reg[6:0], serial_in};

            parity_out <= calc_even_parity({shift_reg[6:0], serial_in});

            
            if (count < 4'd8) begin
                count <= count + 1'b1;
                if (count == 4'd7) begin
                    valid <= 1'b1;
                end
            end
        end
    end

endmodule