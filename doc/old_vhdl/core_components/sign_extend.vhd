-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
	port (
		-- Signals
		--clk			:	in STD_ULOGIC;
		--reset		:	in STD_ULOGIC;
		-- Data Input
		constant16	:	in STD_ULOGIC_VECTOR(31 downto 0);
		-- Data Output
		constant32	:	out STD_ULOGIC_VECTOR(31 downto 0));
end entity sign_extend;

architecture behavioral of sign_extend is

	constant32(15 downto 0) <= constant16;  -- just wiring
	constant32(31 downto 16) <= (others => constant16(15));

	
end architecture behavioral;




