`timescale 1ns / 1ps

module tb_Network_System;

    reg clk;
    reg rst_n;
    reg Router_Ready;
    reg tb_wr_en;
    reg [23:0] tb_data_in;
    reg tb_port3_ready;

    wire [23:0] tb_port3_data;
    wire tb_port3_valid;
    wire tb_fifo3_full;
    wire tb_fifo3_empty;

    Network_System_Top uut (
        .clk(clk),
        .rst_n(rst_n),
        .Router_Ready(Router_Ready),
        .tb_wr_en(tb_wr_en),
        .tb_data_in(tb_data_in),
        .tb_port3_ready(tb_port3_ready),
        .tb_port3_data(tb_port3_data),
        .tb_port3_valid(tb_port3_valid),
        .tb_fifo3_full(tb_fifo3_full),
        .tb_fifo3_empty(tb_fifo3_empty)
    );

    // 10ns Clock generation (100MHz)
    always #5 clk = ~clk;

    // Task to dispatch a write packet into Port 3 FIFO
    task send_write(input [1:0] dest, input [4:0] addr, input [15:0] data);
        begin
            @(posedge clk);
            while (tb_fifo3_full) @(posedge clk);
            tb_data_in <= {dest, 1'b1, addr, data};
            tb_wr_en   <= 1'b1;
            @(posedge clk);
            tb_wr_en   <= 1'b0;
        end
    endtask

    // Task to dispatch a read request packet into Port 3 FIFO
    task send_read(input [1:0] dest, input [4:0] addr);
        begin
            @(posedge clk);
            while (tb_fifo3_full) @(posedge clk);
            tb_data_in <= {dest, 1'b0, addr, 16'h0000};
            tb_wr_en   <= 1'b1;
            @(posedge clk);
            tb_wr_en   <= 1'b0;
        end
    endtask

    // Task to receive and check response on Port 3
    task wait_read_response(input [4:0] exp_addr, input [15:0] exp_data);
        begin
            while (!tb_port3_valid) @(posedge clk);
            
            if (tb_port3_data[20:16] === exp_addr && tb_port3_data[15:0] === exp_data) begin
                $display("[PASS] TB Read Verification: Addr = 0x%0h | Data = 0x%04h", 
                          tb_port3_data[20:16], tb_port3_data[15:0]);
            end else begin
                $display("[FAIL] TB Read Verification: Expected Addr = 0x%0h, Data = 0x%04h | Got Addr = 0x%0h, Data = 0x%04h",
                          exp_addr, exp_data, tb_port3_data[20:16], tb_port3_data[15:0]);
            end
            @(posedge clk);
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        Router_Ready = 1;
        tb_wr_en = 0;
        tb_data_in = 24'd0;
        tb_port3_ready = 1;

        // Reset Sequence
        #20;
        rst_n = 1;
        #20;

        $display("--- Step 1: Writing data to memories 0, 1, and 2 ---");
        send_write(2'b00, 5'd4,  16'hA1B2); // Node 0, Addr 4
        send_write(2'b01, 5'd10, 16'hC3D4); // Node 1, Addr 10
        send_write(2'b10, 5'd31, 16'hE5F6); // Node 2, Addr 31

        #150; // Allow packets to arbitrate, route, and write into memories

        $display("--- Step 2: Reading back data and checking responses on Port 3 ---");
        send_read(2'b00, 5'd4);
        wait_read_response(5'd4, 16'hA1B2);

        send_read(2'b01, 5'd10);
        wait_read_response(5'd10, 16'hC3D4);

        send_read(2'b10, 5'd31);
        wait_read_response(5'd31, 16'hE5F6);

        #100;
        $display("--- All Operations Finished ---");
        $stop;
    end

endmodule