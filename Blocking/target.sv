class target extends uvm_component;
    uvm_tlm_b_target_socket #(target, packet) t_socket;

    `uvm_component_utils(target)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t_socket = new("t_socket", this);
    endfunction
    virtual task b_transport(packet tx, uvm_tlm_time delay);
        $display("recieved packet at = %t", delay.get_realtime(1ns)); 

        #10ns; //to understand the concept of delay
        tx.print();
        delay.incr(10ns, 1ns);
        $display("realtime when tx processing complete = %t", delay.get_realtime(1ns)); 
    endtask
endclass