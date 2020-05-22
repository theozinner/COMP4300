use work.bv_arithmetic.all;
use work.dlx_types.all; 

entity alu is 
	generic (prop_delay : Time in 15 ns);
	port(operand1, operand2: in dlx_word; operation: in alu_operation_code;
	result: out dlx_word; error: out error_code);
end entity alu;

architecture behaviour1 of alu is
begin
	alu : process(operand1,operand2, operation) is

	variable ofbit: boolean;
	variable dzbit: boolean;
	variable tout: dlx_word:= x"00000000";
	
	begin
		if operation = '0000' then
			bv_addu(operand1, operand2,tout, ofbit);
			if ofbit then 
				error <= '0001';
			end if
			result <= tout;
		end if;
		
		if operation = '0001' then
			bv_subu(operand1, operand2, tout, ofbit);
			if ofbit then 
				error <= '0010';
			end if;
			result <= tout;
		end if;

		if operation = '0010' then
			bv_add(operand1, operand2, tout, ofbit);
			if ofbit then 
				if (operand1(31) = '1' and operand2(31) = '1') then
					if tout(31) = '0' then
						error <= '0010';
					end if;
				elsif (operand1(31) = '0' and operand2(31) = '0') then
					if tout(31) = '1' then
						error <= '0001';
					end if;
				end if;
			end if;
			result <= tout;
		end if;

		if operation = '0011' then
			bv_sub(operand1, operand2, tout, ofbit);
			if ofbit then 
				if (operand1(31) = '1' and operand2(31) = '0') then
					if tout(31) = '0' then
						error <= '0010';
					end if;
				elsif (operand1(31) = '0' and operand2(31) = 1') then
					if tout(31) = '1' then
						error <= '0001';
					end if;
				end if;
			end if;
			result <= tout;
		end if;

		if operation = '0100' then
			bv_mult(operand1, operand2, tout, ofbit);
			if ofbit then 
				if (operand1(31) = '1' and operand2(31) = '0') then
					if tout(31) = '0' then
						error <= '0010';
					end if;
				elsif (operand1(31) = '0' and operand2(31) = 1') then
					if tout(31) = '1' then
						error <= '0001';
					end if;
				end if;
			end if;
			result <= tout;
		end if;


	end process aluProcess; 
end architecture behaviour1;