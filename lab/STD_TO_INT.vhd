library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity teststdToint is 
end entity teststdToint;


architecture test of teststdToint is
signal clk: std_logic;
signal ulaz:std_logic_vector(3 downto 0);
signal izlaz:integer;

begin
dut: entity work.converter(beh) port map (clk => clk, ulaz=>ulaz,izlaz=>izlaz);
  
clk_labela :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;



stim_labela: process
begin        
  ulaz<="0001";
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="0111"; 
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="0010";
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="0000";
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="0100";
 wait for 20 ns;    
  wait for 20 ns;
   
end process;
end architecture test;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

entity converter is
port (ulaz:in std_logic_vector(3 downto 0);
		clk:in std_logic;
		izlaz:out integer);
end entity converter;

architecture beh of converter is

begin
process(clk,ulaz)
variable tmp:integer:=0;
variable i:integer:=0;
variable b:integer:=1;
begin
if(clk'event and clk='1') then
	for i in 0 to 3 loop
		if ulaz(i)='1' then
		tmp:=tmp+b;
		end if;
		b:=b*2;
	end loop;
end if;
b:=1;
izlaz<=tmp;
tmp:=0;
end process;

end architecture beh;