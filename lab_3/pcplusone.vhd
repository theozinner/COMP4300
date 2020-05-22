use work.bv_arithmetic.all;
use work.dlx_types.all; 
entity pcplusone is
	generic(prop_delay: Time := 5 ns);
	port (input: in dlx_word; clock: in bit; output: out dlx_word);
end entity pcplusone;

architecture behavior05 of pcplusone is
begin
	pcplusone: process(input, clock) is
	variable t : dlx_word;
	variable error : boolean;
	begin
		if (clock = '1') then
			bv_addu(input, x"00000001", t, error);
			output <= t after prop_delay;
		else
		--placeholder
		end if;
	end process pcplusone;
end architecture behavior05; 


