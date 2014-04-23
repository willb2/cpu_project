-- reg_g.vhdl

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_g is
  generic(left   : natural := 31;     -- top bit
          prop   : time := 100 ps);     -- delay
  port   (clk    : in  std_logic;
          input  : in  std_logic_vector (left downto 0);
          output : out std_logic_vector (left downto 0) );
end entity reg_g;

architecture behavior of reg_g is
begin  -- behavior
  reg: process(clk)
       begin
         if clk='1' then               -- rising edge
           output <= input after prop;
         end if;
       end process reg;
end architecture behavior;  -- of reg_g
