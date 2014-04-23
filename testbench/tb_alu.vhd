LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
USE ieee.numeric_std.ALL;
 
ENTITY tb_alu IS
END tb_alu;
 
ARCHITECTURE behavior OF tb_alu IS 
    signal clk : std_ulogic;
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu
    PORT(
         a : IN  std_ulogic_vector(31 downto 0);
         b : IN  std_ulogic_vector(31 downto 0);
         op : IN  std_ulogic_vector(2 downto 0);
         result : OUT  std_ulogic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_ulogic_vector(31 downto 0) := (others => '0');
   signal b : std_ulogic_vector(31 downto 0) := (others => '0');
   signal op : std_ulogic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_ulogic_vector(31 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu PORT MAP (
          a => a,
          b => b,
          op => op,
          result => result
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      a <= X"FFFFFFFF";
      b <= X"F1F2F300";
      op <= "010";
    wait for 100 ns;

    a <= X"FFFFFFFF";
    b <= X"F0FA0F01";
    op <= "000";
    op <= "100";
    wait for 100 ns;
    op <= "001";
    wait for 100 ns;
    op <= "101";
    wait for 100 ns;
    op <= "010";
    wait for 100 ns;
    op <= "110";
    wait for 100 ns;
    a <= x"000007d0";
    b <= x"00001388";
    wait for 100 ns;
    b <= x"000007d0";
    a <= x"00001388";
    wait for 100 ns;
    op <= "110";

      wait;
   end process;

END;