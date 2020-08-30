LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY tb IS
GENERIC (nn:INTEGER:=4);
END ENTITY tb;

ARCHITECTURE atb OF tb IS
	SIGNAL sigA, sigB, sigC : STD_LOGIC_VECTOR(nn - 1 DOWNTO 0);
	SIGNAL sigD: STD_LOGIC_VECTOR(nn - 1 DOWNTO 0);
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

stimuli: PROCESS IS 
BEGIN
	sigA<="0000";
	sigC<="0001";
	sigB<="0000";
	wait for 100 ps;
	sigA<="0001";
	sigC<="0011";
	sigB<="0011";
	wait for 100 ps;
END PROCESS stimuli;
END ARCHITECTURE atb;	