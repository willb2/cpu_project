-- cntr_g.vhdl

library IEEE;
use IEEE.std_logic_1164.all;

entity cntr_g is
  generic(left    : natural := 31;       -- top bit
          prop    : time := 100 ps);     -- delay
  port   (clk     : in  std_logic;
          load    : in  std_logic;
          in_load : in  std_logic_vector (left downto 0);
          output  : out std_logic_vector (left downto 0) );
end entity cntr_g;

architecture behavior of cntr_g is
begin  -- behavior
  cntr: process(clk, load)
          variable counter : std_logic_vector(left downto 0);
          variable carry   : std_logic; -- internal
          variable tcarry  : std_logic; -- internal
        begin
          if load='1' then
            counter := in_load;
            output <= in_load;
          elsif clk'event and clk='1' then    -- rising edge
            carry := '1';
            for i in 0 to left loop
              tcarry  := counter(i) and carry;
              counter(i) := counter(i) xor carry;
              carry := tcarry;
            end loop;
            output <= counter after prop;
          end if;
        end process cntr;
end architecture behavior;  -- of reg_g

