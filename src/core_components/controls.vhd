-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controls is
	port (
		-- Signals
		clk			:	in STD_ULOGIC;
		reset		:	in STD_ULOGIC;
		opcode		:	in STD_ULOGIC_VECTOR(5 DOWNTO 0);
		-- Output Signals
		regDst		:	out STD_ULOGIC; -- Mux to Registers
		regWrite	:	out STD_ULOGIC; -- Registers
		aluSrc		:	out STD_ULOGIC; -- Mux to ALU
		pcSrc		:	out STD_ULOGIC; -- Mux to PC
		memRead		:	out STD_ULOGIC; -- Data Memory
		memWrite	:	out STD_ULOGIC; -- Data Memory
		memToReg	:	out STD_ULOGIC; -- Mux to Registers
		aluOp		:	out STD_ULOGIC_VECTOR(1 DOWNTO 0)); -- ALU Controls
end entity controls;


architecture behavioral of controls is
	
	
	
end architecture behavioral;




