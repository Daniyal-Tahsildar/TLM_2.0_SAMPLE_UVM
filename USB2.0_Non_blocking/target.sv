class target extends uvm_component;
    uvm_tlm_nb_target_socket #(target, packet, uvm_tlm_phase_e) t_socket; //uvm_tlm_phase_e used for overriding argument
    uvm_tlm_phase_e phase_t, p1;
    packet tx;
    uvm_tlm_time delay;
    bit drive_f;
    `uvm_component_utils(target)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t_socket = new("t_socket", this);
    endfunction

     //releastic scenarios implement tasks since functions get over in 0 time
  task run_phase(uvm_phase phase);
    forever begin
        //@(posedge drive_f);
        wait (drive_f == 1);
        drive_f = 0;
        set_next_phase();

        case(phase_t)
            BEGIN_SOF: begin
                drive_sof(tx);
            end

            BEGIN_TOKEN: begin
                drive_token(tx);
            end

            BEGIN_DATA: begin
                drive_data(tx);
            end

            BEGIN_HANDSHK: begin
                drive_hndshk(tx);
            end
        endcase

        t_socket.nb_transport_bw(tx, p1, delay);
    end
endtask


    function void set_next_phase();
        case(phase_t)
            BEGIN_SOF: begin
                `uvm_info("TLM2.0", " BEGIN_SOF", UVM_NONE )
                p1 = END_SOF;
            end
            BEGIN_TOKEN: begin
                //p = END_RESP;
                `uvm_info("TLM2.0", " BEGIN_TOKEN", UVM_NONE )
                p1 = END_TOKEN;

            end
            BEGIN_DATA: begin
                `uvm_info("TLM2.0", " BEGIN_DATA", UVM_NONE )
                p1 = END_DATA;
                
            end
            BEGIN_HANDSHK: begin
                //p = END_RESP;
                `uvm_info("TLM2.0", " BEGIN_HANDSHK", UVM_NONE )
                p1 = END_HANDSHK;

            end
        endcase

    endfunction

    virtual function uvm_tlm_sync_e nb_transport_fw( packet tx, ref uvm_tlm_phase_e p, input uvm_tlm_time delay);
        //tx.print();
      $display("Calling nb_transport_fw");
        phase_t = p;
        drive_f = 1;
        this.tx = tx;
        this.delay = delay;
        
        //return (UVM_TLM_ACCEPTED);
    endfunction

    task drive_sof(packet tx);
        `uvm_info("TLM2.0", " DRIVE_SOF: BEGIN", UVM_NONE )
        #10
        `uvm_info("TLM2.0", " DRIVE_SOF: DONE", UVM_NONE )
    endtask

    task drive_token(packet tx);
        `uvm_info("TLM2.0", " DRIVE_token: BEGIN", UVM_NONE )
        #10
        `uvm_info("TLM2.0", " DRIVE_token: DONE", UVM_NONE )
    endtask

    task drive_data(packet tx);
        `uvm_info("TLM2.0", " DRIVE_data: BEGIN", UVM_NONE )
        #10
        `uvm_info("TLM2.0", " DRIVE_data: DONE", UVM_NONE )
    endtask

    task drive_hndshk(packet tx);
        `uvm_info("TLM2.0", " DRIVE_hndshk: BEGIN", UVM_NONE )
        #10
        `uvm_info("TLM2.0", " DRIVE_hndshk: DONE", UVM_NONE )
    endtask
endclass