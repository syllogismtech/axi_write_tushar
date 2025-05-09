class axi_write_data_txn extends uvm_sequence_item;
  rand bit [63:0] wdata;
  rand bit [7:0]  wstrb;
  rand bit        wlast;

  `uvm_object_utils(axi_write_data_txn)

  function new(string name = "axi_write_data_txn");
    super.new(name);
  endfunction
endclass
