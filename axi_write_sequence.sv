class axi_write_sequence extends uvm_sequence #(axi_write_addr_txn);
  `uvm_object_utils(axi_write_sequence)

  function new(string name = "axi_write_sequence");
    super.new(name);
  endfunction

  virtual task body();
    axi_write_addr_txn aw = axi_write_addr_txn::type_id::create("aw");
    aw.randomize() with { awlen == 3; }; // 4-beat burst
    start_item(aw);
    finish_item(aw);
  endtask
endclass
