library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comparator is
port(
		a:in std_logic;
		b:in std_logic;
		g,e,l:out std_logic);
end entity comparator;

architecture beh of comparator is
begin
g <= '1' when (a > b)
else '0';
e <= '1' when (a = b)
else '0';
l <= '1' when (a < b)
else '0';
end architecture beh;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity com_test is
end entity com_test;

architecture beh_test of com_test is
COMPONENT comparator
    PORT(
         a,b : in  std_logic;
         e,l,g: OUT  std_logic
        );
    END COMPONENT;

signal a,b : std_logic:='0';
signal l,e,g :  std_logic:='0';
begin


process
begin
a<='0';  
b<='1';
wait for 2 ns;
a<='0';  
b<='0';
wait for 2 ns;
a<='1';  
b<='0';
wait for 2 ns;



end process;

end architecture beh_test;