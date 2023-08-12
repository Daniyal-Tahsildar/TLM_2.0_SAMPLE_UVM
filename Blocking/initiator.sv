class initiator extends uvm_component;
    uvm_tlm_b_initiator_socket #(packet) i_socket;

    `uvm_component_utils(initiator)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_socket = new("i_socket", this);
    endfunction
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat(3) begin
            packet tx = packet::type_id::create("tx", this);
            uvm_tlm_time delay = new();

            // all declarations should be first, only then do assert methods
            assert(tx.randomize());
            i_socket.b_transport(tx, delay);
            //$display("realtime = %t", delay.get_realtime(1ns)); 
        end
        phase.drop_objection(this);

    endtask
endclass