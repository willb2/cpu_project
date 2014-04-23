-- VHDL code for 4:1 multiplexor

library ieee;
use ieee.std_logic_1164.all;

entity 4to1Mux is
	port(	
		P3: 	in std_logic_vector(2 downto 0);
		P2: 	in std_logic_vector(2 downto 0);
		P1: 	in std_logic_vector(2 downto 0);
		P0: 	in std_logic_vector(2 downto 0);
		S:	in std_logic_vector(1 downto 0);
		O:	out std_logic_vector(2 downto 0)
	);
end 4to1Mux;