`timescale 1ns/1ps

module tb_fibonacci_circuit;

  // señales
  logic rst_i;
  logic clk_i=0;
  logic start_i;
  logic [4:0] i_i;
  logic ready_o;
  logic done_tick_o;
  logic [19:0] f_o;

  // DUT
  fibonacci_circuit dut (
    .rst_i       (rst_i),
    .clk_i       (clk_i),
    .start_i     (start_i),
    .i_i         (i_i),
    .ready_o     (ready_o),
    .done_tick_o (done_tick_o),
    .f_o         (f_o)
  );

  // -------------------------

// Clock generation
localparam time CLK_PERIOD= 10ns;

always #(CLK_PERIOD/2) clk_i = ~clk_i;


//Monitor for Synopsys

 initial begin
         $display ("=== Iniciando simulacion ===");
         $monitor("t=%0t  clk=%b  rst=%b i_i=%0d start=%b done_tick_o=%b n_reg=%0d f_o=%0d estado =%s",
          $time, clk_i, rst_i, i_i, start_i, done_tick_o, dut.n_reg, f_o, dut.state_reg);
 end


  // -------------------------
  // Estímulos
  // -------------------------
  initial begin
    // valores iniciales
    rst_i   = 1;
    start_i = 0;
    i_i     = 0;

    // reset
    #20;
    rst_i = 0;

    // -------------------------
    // Caso 1: F(0)
    // -------------------------
    @(posedge clk_i);
    i_i = 0;
    start_i = 1;

    @(posedge clk_i);
    start_i = 0;

    @(posedge done_tick_o);
    $display("F(0) = %0d", f_o);

    // -------------------------
    // Caso 2: F(1)
    // -------------------------
    @(posedge clk_i);
    i_i = 1;
    start_i = 1;

    @(posedge clk_i);
    start_i = 0;

    @(posedge done_tick_o);
    $display("F(1) = %0d", f_o);

    // -------------------------
    // Caso 3: F(7)
    // -------------------------
    @(posedge clk_i);
    i_i = 5; 
    start_i = 1;

    @(posedge clk_i);
    start_i = 0;

    @(posedge done_tick_o);
    $display("F(7) = %0d", f_o);

    // fin
    #20;
    $finish;
  end

endmodule
