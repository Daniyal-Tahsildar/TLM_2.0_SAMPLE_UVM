class initiator extends uvm_component;
    uvm_tlm_nb_initiator_socket #(initiator, packet, uvm_tlm_phase_e) i_socket; //uvm_tlm_phase_e used for overriding argument
    uvm_tlm_phase_e p;

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
        
        packet tx = packet::type_id::create("tx", this);
        uvm_tlm_time delay = new();

        phase.raise_objection(this);
            // all declarations should be first, only then do assert methods
            repeat(2) begin
                assert(tx.randomize());
                p = BEGIN_SOF;
                i_socket.nb_transport_fw(tx, p, delay);
                wait (p == END_HANDSHK);
            //$display("realtime = %t", delay.get_realtime(1ns)); 
            end
        phase.drop_objection(this);

    endtask

    virtual function uvm_tlm_sync_e nb_transport_bw( packet tx, ref uvm_tlm_phase_e p, input uvm_tlm_time delay);
        //tx.print();
        case(p)
            // UNINITIALIZED_PHASE: begin

            // end
            END_SOF: begin
                `uvm_info("TLM2.0", " END_SOF", UVM_NONE )
                p = BEGIN_TOKEN;
            end
            END_TOKEN: begin
                //p = END_RESP;
                `uvm_info("TLM2.0", " END_TOKEN", UVM_NONE )
              	p = BEGIN_DATA;
                //return (UVM_TLM_COMPLETED); //should not be done here since it means 
                //communication is completed
 
            end
            END_DATA: begin
                `uvm_info("TLM2.0", " END_DATA", UVM_NONE )
              	p = BEGIN_HANDSHK;
                //return (UVM_TLM_COMPLETED);
                
            end
            END_HANDSHK: begin
                //p = END_RESP;
                this.p = p;
                `uvm_info("TLM2.0", " END_HANDSHK", UVM_NONE )
                return (UVM_TLM_COMPLETED);

            end
        endcase
        i_socket.nb_transport_fw(tx, p, delay);
    endfunction
endclass