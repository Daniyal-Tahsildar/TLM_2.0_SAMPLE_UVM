
import uvm_pkg:: *;
`include "uvm_macros.svh" 

`include "packet.sv"
`include "initiator.sv"
`include "target.sv"
`include "base_env.sv"

module top;
    `include "test_lib.sv"

    initial begin
        
        run_test("base_test");
    end
endmodule