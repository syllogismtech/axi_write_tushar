class axi_write_resp extends uvm_sequence_item;
  rand bit [3:0] bid;
  rand bit [1:0] bresp;
  bit            bvalid;

  `uvm_object_utils(axi_write_resp)
  function new(string name = "axi_write_resp");
    super.new(name);
  endfunction
endclass
