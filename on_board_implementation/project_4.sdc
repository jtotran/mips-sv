create_clock -name clock -period 20.000 [get_ports {clk}]
create_generated_clock -name clockdiv -source [get_ports {clk}] -divide_by 62500000 [get_registers {clockdiv:xclockdiv|clkstate}]
create_generated_clock -name modclk -source [get_registers {clockdiv:xclockdiv|clkstate}] -divide_by 1 [get_registers {modclk}]
derive_pll_clocks -create_base_clocks
derive_clock_uncertainty
