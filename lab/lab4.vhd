LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Vezba4 IS
PORT(a,b,c : IN STD_LOGIC; d: OUT STD_LOGIC);
END ENTITY Vezba4;

ARCHITECTURE akomp OF Vezba4 IS
BEGIN
	d<=c OR (a XOR b);
END ARCHITECTURE akomp;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY cela IS
GENERIC (n:INTEGER:=4);
PORT(a1,b1,c1:IN STD_LOGIC_VECTOR(n-1 DOWNTO 0); d1:INOUT STD_LOGIC_VECTOR(n-1 DOWNTO 0));
END ENTITY cela;

ARCHITECTURE acela OF cela IS
BEGIN
lab: FOR i IN a1'range GENERATE
jedan:if i=a1'left generate
	prva: ENTITY work.Vezba4(akomp)
		  PORT MAP(a=> a1(n-1), b=>b1(n-1),c=>c1(n-1), d=>d1(n-1));
end generate jedan;
		sredina: ENTITY work.Vezba4(akomp)
		  PORT MAP(a=> a1(i), b=>b1(i),c=>c1(i), d=>d1(i));
dva:if i=a1'right generate
	poslednja: ENTITY work.Vezba4(akomp)
		  PORT MAP(a=> a1(0), b=>b1(0),c=>c1(0), d=>d1(0));
end generate dva;
END GENERATE lab;
END ARCHITECTURE acela;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb IS
GENERIC (nn:INTEGER:=4);
END ENTITY tb;

ARCHITECTURE atb OF tb IS
	SIGNAL sigA, sigB, sigC : STD_LOGIC_VECTOR(nn - 1 DOWNTO 0);
	SIGNAL sigD: STD_LOGIC_VECTOR(nn - 1 DOWNTO 0);
	SIGNAL clk:std_logic:='0';
BEGIN
uut: ENTITY work.cela(acela)
GENERIC MAP
(
	n=>nn
)
PORT MAP
(
	a1=>sigA,
	b1=>sigB,
	c1=>sigC,
	d1=>sigD
);
clk<=not clk after 100 ps;
PROCESS
BEGIN
	sigA<="0000";
	sigC<="0001";
	sigB<="0000";
	wait for 100 ps;
	sigA<="0001";
	sigC<="0011";
	sigB<="0011";
	wait for 100 ps;
END PROCESS ;
END ARCHITECTURE atb;