class target extends uvm_component;
    uvm_tlm_nb_target_socket #(target, packet) t_socket;

    `uvm_component_utils(target)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t_socket = new("t_socket", this);
    endfunction
    

    virtual function uvm_tlm_sync_e nb_transport_fw( packet tx, ref uvm_tlm_phase_e p, input uvm_tlm_time delay);
        //tx.print();
        case(p)
            BEGIN_REQ: begin
                `uvm_info("TLM2.0", " BEGIN_REQ: ", UVM_NONE )
                p = END_REQ;
            end
            BEGIN_RESP: begin
                `uvm_info("TLM2.0", " BEGIN_RESP: ", UVM_NONE )
                p = END_RESP;
            end
        endcase
        t_socket.nb_transport_bw(tx, p, delay);
        //return (UVM_TLM_ACCEPTED);

    endfunction
endclass