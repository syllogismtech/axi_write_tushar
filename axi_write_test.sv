class axi_write_test extends uvm_test;
  `uvm_component_utils(axi_write_test)

  axi_env env; 

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = axi_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    axi_write_sequence seq;
    phase.raise_objection(this);

    seq = axi_write_sequence::type_id::create("seq");
    seq.start(env.axi_agent.sequencer); 

    phase.drop_objection(this);
  endtask
endclass
