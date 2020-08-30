library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity binary_counter is
    Port ( clk: in std_logic;
           reset: in std_logic; 
           counter: out std_logic_vector(3 downto 0) 
     );
end binary_counter;

architecture beh of binary_counter is
signal count:std_logic_vector(3 downto 0);
begin
process(clk,reset)
begin
if(clk'event and clk='1') then
    if(reset='1') then
         count <= "0000";
  else 
   count <= count + "0001"; 
    end if;
 end if;
end process;
 counter <= count;
end architecture beh;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity binary_test is
end entity binary_test;

architecture test of binary_test is

signal reset,clk,up_down: std_logic;
signal counter:std_logic_vector(3 downto 0);

begin
dut: entity work.binary_counter(beh) port map (clk => clk, reset=>reset, counter => counter);
   
clock_process :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;


stim_proc: process
begin        
   -- hold reset state for 100 ns.
     reset <= '1';
    wait for 20 ns;    
    reset <= '0';
  wait for 20 ns;    
   reset <= '0';
  wait for 20 ns; 
   reset <= '0';
  wait for 20 ns; 
end process;
end architecture test;