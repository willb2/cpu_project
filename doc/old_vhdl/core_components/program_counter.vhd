-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
	port (
		-- Signals
		clk			:	in STD_ULOGIC;
		reset		:	in STD_ULOGIC;
		-- Data Inputs
		addr1		:	in STD_ULOGIC_VECTOR(31 downto 0);
		addr2		:	in STD_ULOGIC_VECTOR(31 downto 0);
		-- Data Ouputs
		instrAddr	:	out STD_ULOGIC_VECTOR(31 downto 0));
end entity program_counter;


architecture behavioral of program_counter is
	
	
end architecture behavioral;




