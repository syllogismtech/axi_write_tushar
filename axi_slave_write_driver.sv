class axi_slave_write_driver extends uvm_component;
  virtual axi_if vif;

  `uvm_component_utils(axi_slave_write_driver)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      wait (vif.awvalid && vif.awready);
      @(posedge vif.clk);
      bit [3:0]  awid   = vif.awid;
      bit [7:0]  awlen  = vif.awlen;

      for (int i = 0; i <= awlen; i++) begin
        wait (vif.wvalid && vif.wready);
        @(posedge vif.clk);
        bit [63:0] data = vif.wdata;
        bit [7:0]  strb = vif.wstrb;
        bit       last = vif.wlast;
        `uvm_info("SLAVE_DRV", $sformatf("Received WDATA[%0d]: 0x%0h LAST=%0b", i, data, last), UVM_MEDIUM)

        if (i == awlen) begin
          if (!last) begin
            `uvm_error("SLAVE_DRV", "Expected WLAST=1 on last beat, but got WLAST=0")
          end

          @(posedge vif.clk);
          vif.bid    <= awid;
          vif.bresp  <= 2'b00; // OKAY
          vif.bvalid <= 1;
          wait (vif.bready);
          @(posedge vif.clk);
          vif.bvalid <= 0;
        end
      end
    end
  endtask
endclass
