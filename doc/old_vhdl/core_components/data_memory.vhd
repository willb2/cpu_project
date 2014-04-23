-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.util_pkg.all;

entity data_memory is
	port (
		-- Signals
		clk			:	in STD_ULOGIC;
		--reset		:	in STD_ULOGIC;
		memRead		:	in STD_ULOGIC;
		memWrite	:	in STD_ULOGIC;
		-- Data Inputs
		address		:	in STD_ULOGIC_VECTOR(31 DOWNTO 0);
		dataIn		:	in STD_ULOGIC_VECTOR(31 DOWNTO 0);
		-- Data Outputs
		dataOut		:	out STD_ULOGIC_VECTOR(31 DOWNTO 0));
end entity data_memory;


architecture behavioral of data_memory is
begin
	data_mem: process(address, clk)
			variable word_addr : natural;
		begin
			if memWrite='1' and clk='1' then
				word_addr := to_integer(address(13 downto 2));
				memory(word_addr) := dataIn;
				read_data <= dataIn;
			elsif memRead='1' then
				word_addr := to_integer(address(13 downto 2));
				dataOut <= memory(word_addr);
			else
				dataOut <= x"0000000";
			end if;
		end process data_mem;
end architecture behavioral;





