LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cela IS
GENERIC (n:INTEGER:=4);
PORT(a1,b1,c1:IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); d1:INOUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END ENTITY cela;

ARCHITECTURE acela OF cela IS
BEGIN
	prva: ENTITY work.andor(akomp)
		  PORT MAP(a=> a1(n-1), b=>b1(n-1),c=>c1(n-1), d=>d1(n-1));
	lab: FOR i IN n-2 DOWNTO  1 GENERATE
		sredina: ENTITY work.andor(akomp)
		  PORT MAP(a=> a1(i), b=>b1(i),c=>c1(i), d=>d1(i));
		  END GENERATE lab;
	poslednja: ENTITY work.andor(akomp)
		  PORT MAP(a=> a1(0), b=>b1(0),c=>c1(0), d=>d1(0));
END ARCHITECTURE acela;
		
	