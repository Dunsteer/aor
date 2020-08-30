library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nk is
port( ulaz:in std_logic_vector(3 downto 0);
		clk: in std_logic;
		izlaz:out std_logic_vector(3 downto 0));
end entity nk;

architecture beh of nk is
signal tmp: std_logic_vector(3 downto 0);
begin

process (clk)
begin
tmp<=not ulaz;
end process;
izlaz<=tmp;
end architecture beh;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity nktest is 
end entity nktest;


architecture testNK of nktest is
signal clk: std_logic;
signal ulaz:std_logic_vector(3 downto 0);
signal izlaz:std_logic_vector(3 downto 0);

begin
dut: entity work.nk(beh) port map (clk => clk, ulaz=>ulaz,izlaz=>izlaz);
  
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
 ulaz<="1111";
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="0000";
  wait for 20 ns;    
  wait for 20 ns;
 ulaz<="1010";
 wait for 20 ns;    
  wait for 20 ns;
   
end process;
end architecture testNK;