class axi_master_write_driver extends uvm_driver #(axi_write_req);
  virtual axi_if vif;

  `uvm_component_utils(axi_master_write_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    vif.awvalid <= 0;
    vif.wvalid  <= 0;
    vif.bready  <= 0;

    forever begin
      axi_write_req aw_req;
      seq_item_port.get_next_item(aw_req);

      @(posedge vif.clk);
      vif.awaddr  <= aw_req.awaddr;
      vif.awid    <= aw_req.awid;
      vif.awlen   <= aw_req.awlen;
      vif.awsize  <= aw_req.awsize;
      vif.awburst <= aw_req.awburst;
      vif.awvalid <= 1;

      wait (vif.awready);
      @(posedge vif.clk);
      vif.awvalid <= 0;

      for (int i = 0; i <= aw_req.awlen; i++) begin
        axi_write_data wdata = axi_write_data::type_id::create("wdata");
        assert(wdata.randomize());

        if (i == aw_req.awlen) wdata.wlast = 1;
        else wdata.wlast = 0;

        vif.wdata  <= wdata.wdata;
        vif.wstrb  <= wdata.wstrb;
        vif.wlast  <= wdata.wlast;
        vif.wvalid <= 1;

        wait (vif.wready);
        @(posedge vif.clk);
        vif.wvalid <= 0;
      end

      vif.bready <= 1;
      wait (vif.bvalid);
      @(posedge vif.clk);
      `uvm_info("AXI_MASTER_DRV", $sformatf("Received B response: ID=%0d RESP=%0b", vif.bid, vif.bresp), UVM_MEDIUM)
      vif.bready <= 0;

      seq_item_port.item_done();
    end
  endtask
endclass
