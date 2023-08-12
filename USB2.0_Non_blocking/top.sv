
import uvm_pkg:: *;
`include "uvm_macros.svh" 

//overriding definition
typedef enum {
    UNINITIALIZED_PHASE,
    START_SOF,
    END_SOF,
    BEGIN_TOKEN,
    END_TOKEN,
    BEGIN_DATA,
    END_DATA,
    BEGIN_HANDSHK,
    END_HANDSHK // when communication reaches here, it should complete
} uvm_tlm_phase_e;

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