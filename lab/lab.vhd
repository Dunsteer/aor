library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity unapred is
    Port ( clk: in std_logic; 
           ce: in std_logic; 
				din: in integer range 0 to 99;
				dout: out integer range 0 to 99);
end unapred;

architecture beh of unapred is
begin
	
process is
	variable counter:integer range 0 to 99:=0;
begin
	wait until clk'event and clk='1';
	if ce='1' then
		if counter=99 then
			counter:=din;
		else
			counter:=counter+1;
		end if;
	else 
		counter:=counter;
	end if;
dout<=counter;
end process;
end beh;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity unapred_test is
end entity unapred_test;

architecture test of unapred_test is
signal ce:std_logic;
signal din:integer range 0 to 99;
signal dout:integer range 0 to 99;
signal clk:std_logic:='0';

begin
 labela:entity work.unapred(beh)
 port map( ce=>ce, din=>din, dout=>dout,clk=>clk);
 
 clk<=not clk after 100ps;
 
 poc:process 
 begin
 ce<='1';
 din<=12;
 wait for 100ps;
 ce<='1';
 din<=12;
 wait for 100ps;
 ce<='1';
 din<=12;
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='1';
 wait for 100ps;
 ce<='0';
 din<=9;
 wait for 100ps;
 ce<='1';
 din<=67;
 wait for 100ps;
  ce<='1';
 
 wait for 100ps;
  ce<='1';

 wait for 100ps;
 
 end process poc;
 end;