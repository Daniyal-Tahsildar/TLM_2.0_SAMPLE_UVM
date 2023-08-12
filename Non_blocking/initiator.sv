class initiator extends uvm_component;
    uvm_tlm_nb_initiator_socket #(initiator, packet) i_socket;

    `uvm_component_utils(initiator)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        i_socket = new("i_socket", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        uvm_tlm_sync_e sync;
        uvm_tlm_phase_e p;
        
        packet tx = packet::type_id::create("tx", this);
        uvm_tlm_time delay = new();

        phase.raise_objection(this);
            // all declarations should be first, only then do assert methods
            assert(tx.randomize());
            p = BEGIN_REQ;
            i_socket.nb_transport_fw(tx, p, delay);
            //$display("realtime = %t", delay.get_realtime(1ns)); 
        phase.drop_objection(this);

    endtask

    virtual function uvm_tlm_sync_e nb_transport_bw( packet tx, ref uvm_tlm_phase_e p, input uvm_tlm_time delay);
        //tx.print();
        case(p)
            // UNINITIALIZED_PHASE: begin

            // end
            END_REQ: begin
                `uvm_info("TLM2.0", " END_REQ", UVM_NONE )
                p = BEGIN_RESP;
            end
            END_RESP: begin
                //p = END_RESP;
                `uvm_info("TLM2.0", " END_RESP: Completing communication", UVM_NONE )

                return (UVM_TLM_COMPLETED);

            end
        endcase
        i_socket.nb_transport_fw(tx, p, delay);
    endfunction
endclass