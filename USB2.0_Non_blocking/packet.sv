class packet extends uvm_object;
    rand bit [31:0] sa;
    rand bit [31:0] da;
    rand bit [7:0] len;
    rand bit [15:0] crc;

    `uvm_object_utils_begin(packet)
        `uvm_field_int(sa, UVM_ALL_ON);
        `uvm_field_int(da, UVM_ALL_ON);
        `uvm_field_int(len, UVM_ALL_ON);
        `uvm_field_int(crc, UVM_ALL_ON);
    `uvm_object_utils_end

    function new (string name = "");
        super.new(name);
    endfunction
endclass