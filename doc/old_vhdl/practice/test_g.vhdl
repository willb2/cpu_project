-- test_g.vhdl  test generic entities add_g mux_g reg_g and cntr_g

entity test_g is    -- test bench, generic components tested at 8 bits
end test_g;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;

architecture test of test_g is
  constant prop : time := 50 ps;
  constant left : natural := 7;        -- top bit number
  subtype word is std_logic_vector(left downto 0);
  signal a      : word;
  signal b      : word;
  signal sum    : word;
  signal in0    : word := (0=>'0', 1=>'1', others=>'0');
  signal in1    : word := (0=>'1', 1=>'1', others=>'0');
  signal res    : word;
  signal l_word : word := (0=>'1',others=>'0');
  signal cntr   : word;
  signal inp    : word := (0=>'0', 1=>'1', others=>'0');
  signal outp   : word;
  signal clk    : std_logic := '0';        -- master clock
  signal load   : std_logic := '1';        -- one shot
  signal cin    : std_logic;
  signal cout   : std_logic;
  signal ctl    : std_logic := '0';
begin  -- test
  load <= '0' after 1 ps;        -- one shot
  clk <= not clk after 5 ns;     -- 10 ns period
  add:entity WORK.add_g  generic map(left=>left, prop=>prop)
                         port map(a=>a, b=>b, cin=>cin, sum=>sum, cout=>cout);
  mux:entity WORK.mux_g  generic map(left=>left, prop=>prop)
                         port map(in0=>in0, in1=>in1, ctl=>ctl, result=>res);
  cnt:entity WORK.cntr_g generic map(left=>left, prop=>prop)
                         port map(clk=>clk, load=>load,
                                  in_load=>l_word, output=>cntr);
  reg:entity WORK.reg_g  generic map(left=>left, prop=>prop)
                         port map(clk=>clk, input=>inp, output=>outp);

  run: process  -- drive signals and print output
         variable my_line : STD.textio.line;
         variable lcntr : std_logic_vector(4 downto 0);
         alias swrite is write [line, string, side, width] ;
       begin
         lcntr := "00000";
         -- monitor counter and register
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  cntr=");
           write(my_line, cntr);
           swrite(my_line, "  outp=");
           write(my_line, outp);
           writeline(STD.textio.output, my_line);
           wait for 2 ps;
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  cntr=");
           write(my_line, cntr);
           swrite(my_line, "  outp=");
           write(my_line, outp);
           swrite(my_line, "  res=");
           write(my_line, res);
           writeline(STD.textio.output, my_line);
           wait for 50 ps;
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  cntr=");
           write(my_line, cntr);
           swrite(my_line, "  outp=");
           write(my_line, outp);
           swrite(my_line, "  res=");
           write(my_line, res);
           writeline(STD.textio.output, my_line);
           wait for 5 ns;
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  cntr=");
           write(my_line, cntr);
           swrite(my_line, "  outp=");
           write(my_line, outp);
           swrite(my_line, "  res=");
           write(my_line, res);
           writeline(STD.textio.output, my_line);
           ctl <= '1';
           wait for 10 ns;
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  cntr=");
           write(my_line, cntr);
           swrite(my_line, "  outp=");
           write(my_line, outp);
           swrite(my_line, "  res=");
           write(my_line, res);
           writeline(STD.textio.output, my_line);

         for i in 0 to 15 loop
           a(4 downto 0) <= lcntr after 1 ps;
           a(left downto 5) <= (others=>'0');
           b(4 downto 0) <= lcntr after 1 ps;
           b(left downto 5) <= (others=>'0');
           if i mod 6 = 1 then
             cin <= '1' after 1 ps;
           else
             cin <= '0' after 1 ps;
           end if;
           wait for 60 ps;
           swrite(my_line, "now=");
           write(my_line, now);
           swrite(my_line, "  lcntr=");
           write(my_line, lcntr);
           writeline(STD.textio.output, my_line);
           swrite(my_line, "a=");
           write(my_line, a);
           swrite(my_line, "  b=");
           write(my_line, b);
           swrite(my_line, "  cin=");
           write(my_line, cin);
           writeline(STD.textio.output, my_line);
           swrite(my_line, "sum=");
           write(my_line, sum);
           swrite(my_line, "  cout=");
           write(my_line, cout);
           writeline(STD.textio.output, my_line);
           lcntr := unsigned(lcntr)+unsigned'("00001");
         end loop;  -- i
         wait for 1 sec;
       end process run;
end test; -- of test_g

