library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

ENTITY IntToBin IS
PORT(ulaz: IN INTEGER; 
	 clk: IN BIT;
	 izlaz: OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
END ENTITY IntToBin;

-----

ARCHITECTURE A_IntToBin of IntToBin IS
BEGIN
	PROCESS(clk,ulaz)
	VARIABLE tmp: INTEGER;
	VARIABLE i:INTEGER:=0;
	VARIABLE b:INTEGER:=0;
	BEGIN
		IF clk'EVENT AND clk='1' THEN
			tmp:=ulaz;
		FOR i IN 0 TO 4 LOOP
			b:=tmp MOD 2;
			IF b=0 THEN
			izlaz(i)<='0';
			ELSE
			izlaz(i)<='1';
			END IF;
			tmp:= tmp/2;
		END LOOP;
		END IF;
	END PROCESS;
END ARCHITECTURE A_IntToBin;
		
		
		
	

