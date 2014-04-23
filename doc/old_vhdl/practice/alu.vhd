library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
generic (n : integer := 32);

port( 
    a : in std_ulogic_vector(n-1 downto 0);
    b : in std_ulogic_vector(n-1 downto 0);
    op   : in std_ulogic_vector(2 downto 0);
    result : out std_ulogic_vector(n-1 downto 0));
end alu;

architecture alu of alu is
signal notb : std_ulogic_vector(n-1 downto 0);
begin
		-- notb <= 	(not B) when (op(2) = '1') else
		-- 			B when (op(2) = '0') else
		-- 			(others => 'X');
		-- result <= 	(A AND notb) 	when (op(1 downto 0) = "00") else
		-- 		(A OR notb) 	when (op(1 downto 0) = "01") else
		-- 		std_ulogic_vector(unsigned(A) + unsigned(notb)) 	when (op(1 downto 0) = "11") else
		-- 		(others => 'X');
	proc1: process(a,b,op)
	begin
		case op is
			when "000" =>
				result <= std_ulogic_vector(unsigned(A) + unsigned(notb));
			when "001" =>
				result <= std_ulogic_vector(unsigned(A) - unsigned(notb));
			when "010" =>
				result <= (A and B);
			when "011" =>
				result <= (A or B);
			when "100" =>
				result <= (A xor B);
--			when "101" =>
--				result <= (A srl B);

			when others =>
				result <= (others => '0');
		end case;
	end process proc1;
end alu;