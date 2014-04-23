-- About: MIPS 32-bit ALU
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port (
		-- Signals
		clk		:	in STD_ULOGIC;
		reset	:	in STD_ULOGIC;
		aluOp	:	in STD_ULOGIC_VECTOR(1 DOWNTO 2);
		-- Data Inputs
		data1	:	in STD_ULOGIC_VECTOR(width-1 DOWNTO 0);
		data2	:	in STD_ULOGIC_VECTOR(width-1 DOWNTO 0);
		-- Data Outputs
		result	:	out STD_ULOGIC_VECTOR(width-1 DOWNTO 0);
		zero	:	out STD_ULOGIC
	);
end alu;

architecture alu of alu is
	
	
	begin
		
		proc: process()
		begin
			-- ALU OpCodes
			--
			--
			case aluOp is
				when "0000" =>   -- AND 
					result <= unsigned(data1) AND unsigned(data2);
				when "0001" =>   -- OR
					result <= unsigned(data1) OR unsigned(data2);
				when "0010" =>   -- add
					result <= STD_ULOGIC_VECTOR(unsigned(data1) + unsigned(data2));
				when "0110" =>	-- subtract
					result <= STD_ULOGIC_VECTOR(unsigned(data1) - unsigned(data2));
				when others =>
					result <= ()
			end case;
		end process proc;
	
end alu;




