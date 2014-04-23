-- add_g.vhdl

library IEEE;
use IEEE.std_logic_1164.all;

entity add_g is
  generic(left : natural := 31;         -- top bit
          prop : time := 100 ps);
    port (a    : in  std_logic_vector (left downto 0);
          b    : in  std_logic_vector (left downto 0);
          cin  : in  std_logic;
          sum  : out std_logic_vector (left downto 0);
          cout : out std_logic);
end entity add_g;

architecture behavior of add_g is
begin  -- behavior
  adder: process
           variable carry : std_logic; -- internal
           variable isum : std_logic_vector(left downto 0);  -- internal
         begin
           carry := cin;
           for i in 0 to left loop
             isum(i) := a(i) xor b(i) xor carry;
             carry  := (a(i) and b(i)) or (a(i) and carry) or (b(i) and carry);
           end loop;
           sum  <= isum;
           cout <= carry;
           wait for prop;   -- signals updated after prop delay
         end process adder;
end architecture behavior;  -- of add_g
