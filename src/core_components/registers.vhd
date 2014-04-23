-- About: 
-- Authors: Will Gossard and Will Bierbower
-- Course: CMSC 411
-- Date Due: May, 2014 


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
	port (
		-- Signals
		clk			:	in STD_ULOGIC;
		writeEn		:	in STD_ULOGIC;
		reset		:	in STD_ULOGIC;
		readReg1	:	in STD_ULOGIC_VECTOR(4 DOWNTO 0);
		readReg2	:	in STD_ULOGIC_VECTOR(4 DOWNTO 0);
		writeReg	:	in STD_ULOGIC_VECTOR(4 DOWNTO 0);
		-- Data Outputs
		readData1	:	out STD_ULOGIC_VECTOR(31 DOWNTO 0);
		readData2	:	out STD_ULOGIC(31 DOWNTO 0);
		-- Data Inputs
		writeData	:	in STD_ULOGIC_VECTOR(31 DOWNTO 0));
end entity registers;

architecture behavioral of registers is
begin
	reg: process(readReg1, readReg2, clk)
			variable reg_addr : natural;
		begin
			if writeEn='1' and clk'active and clk='1' then
				reg_addr := to_integer(write_data);
				if reg_addr/=0 then
					reg_mem(reg_addr) := writeData; -- NEED TO CREATE REG_MEM (from utils package)
				end if; 
			end if;
			readData1 <= reg_mem(to_integer(readReg1));
			readData2 <= reg_mem(to_integer(readReg2));
		end process reg;	
end architecture behavioral;




