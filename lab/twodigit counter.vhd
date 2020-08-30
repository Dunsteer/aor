library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity twodigit is
port( countL,countH:out integer;
		clk,reset:in std_logic);
end entity twodigit;


architecture beh of twodigit is
signal tmpH,tmpL: integer:=0;
begin
process(clk,reset)
begin
if(clk'event and clk='1') then
	if(reset='1') then
		tmpL<=0;
		tmpH<=0;
	elsif(tmpL=9) then
		tmpH<=tmpH+1;
	else
		tmpL<=tmpL+1;
		end if;
end if;
end process;
countL<=tmpL;
countH<=tmpH;
end architecture beh;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity twotest is 
end entity twotest;


architecture test of twotest is
signal reset,clk: std_logic;
signal countL,countH:integer;

begin
dut: entity work.twodigit(beh) port map (clk => clk, reset=>reset, countL => countL,countH=>countH);
 
clock_process :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;



stim_proc: process
begin        
  
     reset <= '1';
    wait for 20 ns;    
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns;   
  reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
end process;
end architecture test;