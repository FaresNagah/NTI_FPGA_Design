module bin_to_seg (
    input  wire [3:0] Bin_in,
    output reg  [6:0] Seg_out
);

    localparam [6:0]
        SEG_0 = 7'b1000000, // 0
        SEG_1 = 7'b1111001, // 1
        SEG_2 = 7'b0100100, // 2
        SEG_3 = 7'b0110000, // 3
        SEG_4 = 7'b0011001, // 4
        SEG_5 = 7'b0010010, // 5
        SEG_6 = 7'b0000010, // 6
        SEG_7 = 7'b1111000, // 7
        SEG_8 = 7'b0000000, // 8
        SEG_9 = 7'b0010000, // 9
        SEG_A = 7'b0001000, // A
        SEG_B = 7'b0000011, // b
        SEG_C = 7'b1000110, // C
        SEG_D = 7'b0100001, // d
        SEG_E = 7'b0000110, // E
        SEG_F = 7'b0001110; // F

    always @(*) begin
        case (Bin_in)
            4'h0: Seg_out = SEG_0;
            4'h1: Seg_out = SEG_1;
            4'h2: Seg_out = SEG_2;
            4'h3: Seg_out = SEG_3;
            4'h4: Seg_out = SEG_4;
            4'h5: Seg_out = SEG_5;
            4'h6: Seg_out = SEG_6;
            4'h7: Seg_out = SEG_7;
            4'h8: Seg_out = SEG_8;
            4'h9: Seg_out = SEG_9;
            4'hA: Seg_out = SEG_A;
            4'hB: Seg_out = SEG_B;
            4'hC: Seg_out = SEG_C;
            4'hD: Seg_out = SEG_D;
            4'hE: Seg_out = SEG_E;
            4'hF: Seg_out = SEG_F;
            default: Seg_out = 7'b1111111; 
        endcase
    end

endmodule