`timescale 1ns/1ps

module fibonacci_circuit(
    input logic rst_i,
    input logic clk_i,
    input logic start_i,
    input logic [4:0] i_i,
    output logic ready_o,
    output logic done_tick_o,
    output logic [19:0] f_o
);


import fsm_fino_pkg::*; // import the peckage that we created, where contains the states.
state_e state_reg, state_next; // variables of type state_e of the package

//Signal declarations
logic [19:0] t0_reg, t0_next, t1_reg, t1_next; // t0 _reg and t1_reg are the two last fibonacci numbers, t0 next and t1_next are the next values
logic [4:0] n_reg, n_next; // actual value and next value of n


// First always block: state register
 always_ff @(posedge clk_i or posedge rst_i) begin
     if(rst_i) begin
         state_reg <= IDLE; // initial state
         t0_reg <= 0;
         t1_reg <= 0;
         n_reg  <= 0;
 end else begin
         state_reg <= state_next;
         t0_reg <= t0_next;
         t1_reg <= t1_next;
         n_reg  <= n_next;
 end

 end

// Second always block: next state logic
always_comb begin
state_next = state_reg; // default values
ready_o = 1'b0;
done_tick_o = 1'b0;
t0_next = t0_reg;
t1_next = t1_reg;
n_next  = n_reg;

case(state_reg)
    IDLE: begin
        ready_o = 1'b1;
        if(start_i) begin
            t0_next = 0;
            t1_next = 20'd1;
            n_next  = i_i;
            state_next = OP;
        end
    end

    OP: begin
        if (n_reg == 0) begin
            t1_next = 0;
            state_next = DONE;
        end else if(n_reg == 1) begin
            state_next = DONE;
        end else begin
            t1_next = t1_reg + t0_reg;
            t0_next = t1_reg;
            n_next = n_reg -1;
        end
    end

    DONE : begin
        done_tick_o = 1'b1;
        state_next =IDLE;
    end
    default: state_next = IDLE;
endcase
end

assign f_o = t1_reg;

endmodule: fibonacci_circuit