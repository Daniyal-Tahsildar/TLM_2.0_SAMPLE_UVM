class base_test extends uvm_test;
    base_env env;
    `uvm_component_utils(base_test)

    function new (string name = "", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = base_env::type_id::create("env", this);
    endfunction
endclass