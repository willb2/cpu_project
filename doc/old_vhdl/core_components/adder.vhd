-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port (
		-- Signals
		clk		:	in STD_ULOGIC;
		reset	:	in STD_ULOGIC;
		-- Data Inputs
		data1	:	in STD_ULOGIC_VECTOR(31 downto 0);
		data2	:	in STD_ULOGIC_VECTOR(31 downto 0);
		-- Data Outputs
		result	:	out STD_ULOGIC_VECTOR(31 downto 0));
end entity adder;


architecture behavioral of adder is
	begin
		adder:process(clk, reset)
		begin
			if reset='1' then
				result <= (others=>'0');
			elsif clk'event and clk='1' then
				output<= data1 + data2;
			end if;
		end process adder
end architecture behavioral;




