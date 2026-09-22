module RR_Arbiter(
    input clk, rst_n,
    input empty0, empty1, empty2, empty3,
    input Router_Ready,
    output grant0, grant1, grant2, grant3
);

    reg [3:0] grant_all;

    assign {grant3 , grant2 , grant1 , grant0} = grant_all;

    reg [1:0] current_state, next_state;
    localparam [1:0] S_FIFO0 = 2'b00,
                     S_FIFO1 = 2'b01,
                     S_FIFO2 = 2'b10,
                     S_FIFO3 = 2'b11;

    // current state logic
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= S_FIFO0;
        end else begin
            current_state <= next_state;
        end
    end


    // next state logic
    always @(*) begin

        next_state = current_state;

        if (Router_Ready) begin

            case (grant_all)

                4'b0001: next_state = S_FIFO1;
                4'b0010: next_state = S_FIFO2; 
                4'b0100: next_state = S_FIFO3; 
                4'b1000: next_state = S_FIFO0; 

                default: next_state = current_state;

            endcase

        end

    end


    // Output logic  
    always @(*) begin
        case (current_state)
            S_FIFO0: begin
                if (!empty0)
                    grant_all = 4'b0001;
                else if (!empty1)
                    grant_all = 4'b0010;
                else if (!empty2)
                    grant_all = 4'b0100;
                else if (!empty3)
                    grant_all = 4'b1000;
                else 
                    grant_all = 0;
            end 

            S_FIFO1: begin
              if (!empty1)
                    grant_all = 4'b0010;
                else if (!empty2)
                    grant_all = 4'b0100;
                else if (!empty3)
                    grant_all = 4'b1000;
                else if (!empty0)
                    grant_all = 4'b0001;
                else 
                    grant_all = 0;
            end

            S_FIFO2: begin
              if (!empty2)
                    grant_all = 4'b0100;
                else if (!empty3)
                    grant_all = 4'b1000;
                else if (!empty0)
                    grant_all = 4'b0001;
                else if (!empty1)
                    grant_all = 4'b0010;
                else 
                    grant_all = 0;
            end 

            S_FIFO3: begin
              if (!empty3)
                    grant_all = 4'b1000;
                else if (!empty0)
                    grant_all = 4'b0001;
                else if (!empty1)
                    grant_all = 4'b0010;
                else if (!empty2)
                    grant_all = 4'b0100;
                else 
                    grant_all = 0;
            end
            default: grant_all = 0;
        endcase
    end

    

endmodule