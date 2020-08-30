library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;


ENTITY TB IS
END ENTITY TB;
---
	
ARCHITECTURE A_TB OF TB IS
SIGNAL ul:INTEGER;
SIGNAL clk1: BIT;
SIGNAL izl:STD_LOGIC_VECTOR(4 DOWNTO 0);
BEGIN
UUT: ENTITY WORK.IntToBin(A_IntToBin)
	PORT MAP
	(
		ulaz=>uL,
		clk=>clk1,
		izlaz=>izl
	);
clk1<=NOT clk1 AFTER 100ps;

stimuli: PROCESS
BEGIN
	ul<=5;
	wait for 500ps;
	ul<=4;
	wait for 500ps;
	ul<=3;
	wait for 500ps;
END PROCESS stimuli;
END ARCHITECTURE A_TB;

