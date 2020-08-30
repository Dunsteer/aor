library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd3 is
port( 	ce,wr: in bit;-- ce=1 dozvoljeno -- wr=1 dozvoljeno
		din: in integer range 0 to 999;
		dout: out integer range 0 to 999;
		clk: in bit
);
end bcd3;

architecture brojac of bcd3 is
begin
	
process is
	variable counter:integer range 0 to 999:=0;
begin
	wait until clk'event and clk='1';
	if ce='1' then
		if counter=999 then
			counter:=0;
		else
			counter:=counter+1;
		end if;
	elsif wr='1' then
		counter:=din;
	end if;
dout<=counter;
end process;
end brojac;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity bcd3_tb is
end;

architecture test of bcd3_tb is
signal ce:bit;
signal wr:bit;
signal din:integer range 0 to 999;
signal dout:integer range 0 to 999;
signal clk:bit:='0';

begin
 dut:entity work.bcd3(brojac)
 port map( wr=>wr,ce=>ce, din=>din, dout=>dout,clk=>clk);
 
 clk<=not clk after 20ps;
 
 poc:process 
 begin
 ce<='1';
 wr<='0';
 din<=125;
 wait for 200ps;
 ce<='0';
 wr<='0';
 din<=125;
 wait for 200ps;
 ce<='0';
 wr<='1';
 din<=125;
 wait for 200ps;
 ce<='1';
 wait for 200ps;
 ce<='0';
 wr<='1';
 din<=998;
 wait for 200ps;
 ce<='1';
 wr<='1';
 din<=777;
 wait for 200ps;
 
 end process poc;
 end;