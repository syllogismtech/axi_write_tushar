class axi_write_test extends uvm_test;
  `uvm_component_utils(axi_write_test)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    axi_write_sequence seq;
    uvm_sequencer #(axi_write_addr_txn) sequencer;
    axi_master_write_driver driver;

    seq = axi_write_sequence::type_id::create("seq");
    sequencer = uvm_sequencer #(axi_write_addr_txn)::type_id::create("sequencer", this);
    driver = axi_master_write_driver::type_id::create("driver", this);
    driver.seq_item_port.connect(sequencer.seq_item_export);
    seq.start(sequencer);
  endtask
endclass
