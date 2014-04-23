-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 
-- Credit: Jon Squire, UMBC, 2013


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use WORK.util_pkg.all;  -- need this library for to_integer() function

entity instr_memory is
	port (
		-- Signals
		--clk			:	in STD_ULOGIC;
		--reset		:	in STD_ULOGIC;
		--memRead		:	in STD_ULOGIC;
		--memWrite	:	in STD_ULOGIC;
		-- Data Inputs
		address		:	in STD_ULOGIC_VECTOR(31 downto 0);
		-- Data Outputs
		instruction	:	out STD_ULOGIC_VECTOR(31 downto 0));
end entity instr_memory;



architecture behavioral of instr_memory is
begin
	instr_mem: process(address)
		subtype word is std_logic(31 downto 0);
		type mem_array is array(natural range <>) of word;
		variable memory: mem_array(0 to 6) :=
			(x"00000001",
			x"00000002",
			x"00000003",
			x"00000004",
			x"00000005",
			x"00000006",
			x"00000007");
		variable word_addr : natural;
		begin
			word_addr := to_integer(addr)/4;
			instruction <= memory(word_addr) after 250 ps;
		end process instr_mem;

end architecture behavioral;




