class base_env extends uvm_env;
    initiator initiator_i;
    target target_i;
    `uvm_component_utils(base_env)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        initiator_i = initiator::type_id::create("initiator_i", this);
        target_i = target::type_id::create("target_i", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        initiator_i.i_socket.connect(target_i.t_socket);
    endfunction
endclass