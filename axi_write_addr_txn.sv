class axi_write_addr_txn extends uvm_sequence_item;
  rand bit [31:0] awaddr;
  rand bit [3:0]  awid;
  rand bit [7:0]  awlen;
  rand bit [2:0]  awsize;
  rand bit [1:0]  awburst;

  `uvm_object_utils(axi_write_addr_txn)

  function new(string name = "axi_write_addr_txn");
    super.new(name);
  endfunction
endclass



