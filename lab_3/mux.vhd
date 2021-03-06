use work.bv_arithmetic.all;
use work.dlx_types.all; 

entity mux_2 is
	generic(prop_delay : Time := 5 ns);
	port (input_1: in dlx_word; input_0: in dlx_word; which: in bit; output: out dlx_word);
end entity mux_2;

architecture behavior03 of mux_2 is
begin
	mux_2: process(input_0, input_1, which)
	begin
		if (which = '0') then
			output <= input_0 after prop_delay;
		else
			output <= input_1 after prop_delay;
		end if;
	end process mux_2;
end architecture behavior03;