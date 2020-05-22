use work.bv_arithmetic.all; 
use work.dlx_types.all; 



entity simpleRisc_controller is
	port(ir_control: in dlx_word;
	     alu_out_control: in dlx_word; 
	     regfile_out_bus_control: in dlx_word; 
	     alu_error_control: in error_code; 
	     clock_control: in bit; 
	     control_regfile_mux: out bit; 
	     control_mem_addr_mux: out bit;
	     control_pc_mux: out bit; 
	     control_writeback_mux: out bit; 
	     control_op2r_mux: out bit; 
	     control_alu_func: out alu_operation_code; 
	     control_regfile_index: out register_index;
	     control_regfile_readnotwrite: out bit; 
	     control_regfile_clk: out bit;   
	     control_mem_clk: out bit;
	     control_mem_readnotwrite: out bit;  
	     control_ir_clk: out bit;    
             control_pc_clk: out bit; 
	     control_op1r_clk: out bit; 
	     control_op2r_clk: out bit;
	     control_alu_out_reg_clk: out bit 
	     ); 
end simpleRisc_controller; 

architecture behavior of simpleRisc_controller is
begin
	behav: process(clock_control) is 
		type state_type is range 1 to 20; 
		variable state: state_type := 1; 
		variable opcode: opcode_type; 
		variable destination,operand1,operand2 : register_index; 
		variable func_code : alu_operation_code; 
		variable condition: dlx_word; 

	begin
		if clock_control'event and clock_control = '1' then
		
		   case state is
			when 1 => -- fetch the instruction, for all types
				control_mem_readnotwrite <= '1' after 5 ns; 
				control_mem_clk <= '1' after 5 ns; 
				control_mem_addr_mux <= '0' after 5 ns; -- instr addr comes from pc
				control_ir_clk <= '1' after 25 ns; -- latch the instruction into IR;
				state := 2; 
			when 2 => 
				 -- decode the instruction
		  		 opcode := ir_control(31 downto 26);
		   		 operand1 := ir_control(25 downto 21);
		   		 operand2 := ir_control(20 downto 16); 
 				 destination := ir_control(15 downto 11);
		   		 func_code := ir_control(10 downto 7);

				-- figure out which instruction and branch to correct state
	
			 	if opcode = "000000" then -- LOAD
					state := 6; 
				elsif opcode = "000001" then  -- STORE 
					state := 10;
				elsif opcode = "000010" then -- ALU
					state := 3;
				elsif opcode = "000011" or opcode = "000100" or opcode = "000101" then -- jumps
					state := 14;
				else -- error
				end if; 
  
			when 3 =>  -- ALU destination, operand1, operand2
				control_regfile_readnotwrite <= '1' after 15 ns; --get operand1 from regfile
				control_regfile_index <= operand1 after 15 ns;
				control_regfile_clk <= '1' after 15 ns; 
				control_op1r_clk <= '1' after 30 ns; -- put it in op1r
				state := 4;
			when 4 => 
            -- your code goes here in this state, and also states 5 thru 18

				control_regfile_readnotwrite <= '1' after 15 ns; -- get operand2 from regfile
				control_op2r_mux <= '0' after 15 ns; --op2r_mux
				control_regfile_index <= operand2 after 15 ns;
				control_regfile_clk <= '1' after 15 ns; 
				control_op2r_clk <= '1' after 30 ns; -- put it in op2r
				state := 5; 
			when 5 => 
            -- your code goes here
	     			control_alu_func <= func_code after 15 ns; --put in function code for alu
				control_alu_out_reg_clk <= '1' after 15 ns; --output I think 
				control_regfile_mux <= '0' after 30 ns;
				control_writeback_mux <= '0' after 30 ns;
				control_regfile_readnotwrite <= '0' after 30 ns;
				control_regfile_index <= destination after 30 ns;
				control_regfile_clk <= '1' after 30 ns;
				control_pc_mux <= '0' after 15 ns; --pc_mux this first
				control_pc_clk <= '1' after 30 ns; --pc clock increment
				state := 1;
            			
			when 6 =>  -- LD destination,base(operand1)
            			--increment e
				control_pc_mux <= '0' after 15 ns; --pc_mux this first
				control_pc_clk <= '1' after 20 ns; --pc clock increment
				state := 7; 
			when 7 => 
	     			control_mem_readnotwrite <= '1' after 5 ns;
				control_mem_clk <= '1' after 5 ns; --mem clk
				control_mem_addr_mux <= '0' after 5 ns; -- instr addr comes from pc
				control_op2r_mux <= '1' after 20 ns; --op2r_mux
				control_op2r_clk <= '1' after 20 ns; -- put it in op2r
				control_regfile_readnotwrite <= '1' after 5 ns; -- get operand1 from regfile
				control_regfile_index <= operand1 after 5 ns;
				control_regfile_clk <= '1' after 5 ns; 
				control_op1r_clk <= '1' after 20 ns; -- put it in op1r
				state := 8;
			when 8 =>
	     			control_alu_func <= "0000"; --put in function code for unsigned add
				control_alu_out_reg_clk <= '1' after 20 ns;
				state := 9; 
			when 9 =>
				control_mem_readnotwrite <= '1' after 5 ns;
				control_mem_clk <= '1' after 5 ns; --write
				control_mem_addr_mux <= '1' after 5 ns;
				control_regfile_mux <= '1' after 20 ns;
				control_regfile_index <= destination after 5 ns;
				control_regfile_readnotwrite <= '0' after 20 ns; 
				control_regfile_clk <= '1' after 20 ns; --regfile clock 
				control_pc_mux <= '0' after 15 ns; --pc_mux comes first
				control_pc_clk <= '1' after 20 ns; --then pc clock increment
				state := 1; 

			when 10 =>  -- STO  operand1,base[destination]
				control_pc_mux <= '0' after 30 ns; --pc_mux
				control_pc_clk <= '1' after 45 ns; --pc clock increment

				state := 11; 
			when 11 =>
				control_mem_clk <= '1' after 15 ns; --mem clock
				control_mem_addr_mux <= '0' after 15 ns; -- instr addr comes from pc
	     			control_mem_readnotwrite <= '1' after 15 ns;
				control_op2r_mux <= '1' after 15 ns; --op2r_mux
				control_op2r_clk <= '1' after 30 ns; -- put it in op2r
				control_regfile_readnotwrite <= '1' after 15 ns; -- get operand1 from regfile
				control_regfile_index <= destination after 15 ns;
				control_regfile_clk <= '1' after 15 ns; 
				control_op1r_clk <= '1' after 30 ns; -- put it in op1r
				state := 12; 
			when 12 => 
	     			control_alu_func <= "0000" after 45 ns; --put in function code for unsigned add
				control_alu_out_reg_clk <= '1' after 60 ns; --output I think 
				state := 13; 
			when 13 =>
				control_regfile_readnotwrite <= '1' after 45 ns; 
				control_regfile_index <= operand1 after 45 ns;
				control_regfile_clk <= '1' after 45 ns; --mem clock increment
				
				control_mem_addr_mux <= '1' after 60 ns;
				control_writeback_mux <= '1' after 60 ns;
				control_mem_readnotwrite <= '0' after 60 ns; 
				control_regfile_clk <= '1' after 60 ns; --write

				control_pc_mux <= '0' after 45 ns; --pc_mux comes first
				control_pc_clk <= '1' after 60 ns; --then pc clock increment
				state := 1;		
            
			when 14 => -- JMP   JZ op2,base[op1]  JNZ op2,base[op1]
				control_pc_mux <= '0' after 15 ns; --pc_mux this first
				control_pc_clk <= '1' after 30 ns; --pc clock increment
				state := 15; 
			when 15 => 
	     			control_mem_readnotwrite <= '1' after 5 ns;
				control_mem_clk <= '1' after 5 ns; --mem clock
				control_mem_addr_mux <= '0' after 5 ns; -- instr addr comes from pc
				control_op2r_mux <= '1' after 20 ns; --op2r_mux
				control_op2r_clk <= '1' after 20 ns; -- put it in op2r

				control_regfile_readnotwrite <= '1' after 15 ns; -- get operand1 from regfile
				control_regfile_index <= operand1 after 15 ns;
				control_regfile_clk <= '1' after 15 ns; 
				control_op1r_clk <= '1' after 30 ns; -- put it in op1r

				state := 16; 
			when 16 =>
				control_alu_func <= "0000"; --put in function code for unsigned add
				control_alu_out_reg_clk <= '1' after 20 ns; --output I think 
				state := 17;
			when 17 =>
				control_regfile_readnotwrite <= '1' after 45 ns; 
				control_regfile_index <= operand2 after 45 ns;
				control_regfile_clk <= '1' after 45 ns; --mem clock increment
				control_mem_addr_mux <= '1' after 60 ns;
				control_writeback_mux <= '1' after 60 ns;
				control_mem_readnotwrite <= '0' after 60 ns; 
				control_regfile_clk <= '1' after 60 ns; --write



				state := 18;
			when 18 => 
				if opcode = "000100" then
					if (alu_out_control = x"00000000") then
						control_pc_mux <= '1' after 15 ns; --pc_mux this first
						control_pc_clk <= '1' after 30 ns; --pc clock increment
					else
						control_pc_mux <= '0' after 15 ns; --pc_mux this first
						control_pc_clk <= '1' after 30 ns; --pc clock increment
					end if;
				elsif opcode = "000101" then
					if not(alu_out_control = x"00000000") then
						control_pc_mux <= '1' after 15 ns; --pc_mux this first
						control_pc_clk <= '1' after 30 ns; --pc clock increment
					else
						control_pc_mux <= '0' after 15 ns; --pc_mux this first
						control_pc_clk <= '1' after 30 ns; --pc clock increment
					end if;
				else
						control_pc_mux <= '1' after 15 ns; --pc_mux this first
						control_pc_clk <= '1' after 30 ns; --pc clock increment
				end if;


				state := 1;
			when others => null; 
		   end case; 
		elsif clock_control'event and clock_control = '0' then
			-- reset all the register clocks
			control_pc_clk <= '0'; 
			control_ir_clk <= '0'; 
			control_op1r_clk <= '0';
			control_op2r_clk <= '0';
			control_mem_clk <= '0';
			control_regfile_clk <= '0';	
			control_alu_out_reg_clk <= '0'; 		
		end if; 
	end process behav;
end behavior;	
