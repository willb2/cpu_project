-- mux_g.vhdl

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_g is
  generic(left   : natural := 31;         -- top bit
          prop   : time := 100 ps);       -- delay
     port(in0    : in  std_logic_vector (left downto 0);
          in1    : in  std_logic_vector (left downto 0);
          ctl    : in  std_logic;
          result : out std_logic_vector (left downto 0));
end entity mux_g;

architecture behavior of mux_g is 
begin  -- behavior -- no process needed with concurrent statements
  result <= in1 when ctl='1' or ctl='H' else in0 after prop;
end architecture behavior;  -- of mux_g
