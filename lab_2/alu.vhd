use work.bv_arithmetic.all;
use work.dlx_types.all; 

entity alu is
	generic(prop_delay: Time := 15 ns);
	port(operand1, operand2: in dlx_word; operation: in alu_operation_code;
	result: out dlx_word; error: out error_code);
end entity alu;

architecture behaviour1 of alu is
begin
	alu: process(operand1,operand2, operation) is

	variable ofbit: boolean;
	variable dzbit: boolean;
	variable tout: dlx_word:= x"00000000";
	variable logic1: bit;
	variable logic2: bit;
	variable logictrue: dlx_word := x"00000001";
	variable logicfalse: dlx_word := x"00000000";
	
	begin
		error <= "0000"; --clear
 		if operation = "0000" then
			bv_addu(operand1, operand2, tout, ofbit);
			if ofbit then 
				error <= "0001";
			end if;
			result <= tout after prop_delay;
		
		
		elsif operation = "0001" then
			bv_subu(operand1, operand2, tout, ofbit);
			if ofbit then 
				error <= "0001";
			end if;
			result <= tout after prop_delay;
		

		elsif operation = "0010" then
			bv_add(operand1, operand2, tout, ofbit);
			if ofbit then 
				error <= "0001";
			end if;
			result <= tout after prop_delay;


		elsif operation = "0011" then
			bv_sub(operand1, operand2, tout, ofbit);
			if ofbit then
				error <= "0001";
			end if;
			result <= tout after prop_delay;


		elsif operation = "0100" then
			bv_mult(operand1, operand2, tout, ofbit);
			if ofbit then 
				error <= "0001";
			end if;
			result <= tout after prop_delay;
		

		elsif operation = "0101" then
			bv_div(operand1, operand2, tout, dzbit, ofbit);
			if dzbit then
				error <= "0010";
			elsif ofbit then
				error <= "0001";
			end if;
			result <= tout after prop_delay;
		

		elsif operation = "0111" then
			for i in 0 to 31 loop
				tout(i) := operand1(i) and operand2(i);
			end loop;
			result <= tout after prop_delay;
		

		

		elsif operation = "1001" then
			for i in 0 to 31 loop
				tout(i) := operand1(i) or operand2(i);
			end loop;
			result <= tout after prop_delay;
		
		
		elsif operation = "1011" then
			for i in 0 to 31 loop
				tout(i) := not operand1(i);
			end loop;
			result <= tout after prop_delay;
		
		
		elsif operation = "1100" then
			for i in 0 to 31 loop
				tout(i) := operand1(i);
			end loop;
			result <= tout after prop_delay;

		elsif operation = "1101" then
			for i in 0 to 31 loop
				tout(i) := not operand2(i);
			end loop;

			result <= tout after prop_delay;
		elsif operation = "1110" then
			result <= logicfalse after prop_delay;
		
		else
			result <= logicfalse after prop_delay;
		end if;

	end process alu; 
end architecture behaviour1;