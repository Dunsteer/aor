library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity com_vec_test is
end entity com_vec_test;

architecture beh_test of com_vec_test is
COMPONENT comparator_vector
    PORT(
         a,b : in  std_logic_vector(3 downto 0);
         e,l,g: OUT  std_logic
        );
    END COMPONENT;

signal a,b : std_logic_vector(3 downto 0):="0000";
signal l,e,g :  std_logic:='0';
begin


process
begin
a<="0111";  
b<="1010";
wait for 2 ns;
a<="1110";  
b<="1001";
wait for 2 ns;
a<="0100";  
b<="0100";
wait for 2 ns;



end process;

end architecture beh_test;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparator_vector is
port(
		a:in std_logic_vector(3 downto 0);
		b:in std_logic_vector(3 downto 0);
		g,e,l:out std_logic);
end entity comparator_vector;

architecture beh of comparator_vector is
begin
g <= '1' when (a > b)
else '0';
e <= '1' when (a = b)
else '0';
l <= '1' when (a < b)
else '0';
end architecture beh;