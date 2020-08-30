library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity unapred_unazad is
    Port ( clk: in std_logic; 
           reset: in std_logic; 
     up_down: in std_logic; --signal koji definise u kom smeru se broji
           counter: out std_logic_vector(3 downto 0) 
     );
end unapred_unazad;

architecture beh of unapred_unazad is
signal tmp: std_logic_vector(3 downto 0);
begin

process(clk,reset)
begin
if(clk'event and clk='1') then
    if(reset='1') then
         tmp <= "0000";
    elsif(up_down='1') then
         tmp <= tmp - "0001";
  else 
   tmp <= tmp + "0001"; 
    end if;
 end if;
end process;
 counter <= tmp;

end beh;



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counters is
end tb_counters;

architecture test of tb_counters is



signal reset,clk,up_down: std_logic;
signal counter:std_logic_vector(3 downto 0);

begin
dut: entity work.unapred_unazad(beh) port map (clk => clk, reset=>reset, up_down => up_down, counter => counter);
   
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
   up_down <= '0';
    wait for 20 ns;    
    reset <= '0';
  wait for 20 ns;    
  up_down <= '1';
   wait;
end process;
end test;