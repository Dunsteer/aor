library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity clock_div_pow2 is
port(
  clk         : in  std_logic;
  rst         : in  std_logic;
  o_clk_div2    : out std_logic;
  o_clk_div4    : out std_logic;
  o_clk_div8    : out std_logic;
  o_clk_div16   : out std_logic);
end clock_div_pow2;
architecture beh of clock_div_pow2 is
signal clk_divider        : unsigned(3 downto 0);
begin
p_clk_divider: process(rst,clk)
begin
if(clk'event and clk='1') then
  if(rst='1') then
    clk_divider   <= "0000";
  else
    clk_divider   <= clk_divider + 1;
  end if;
  end if;
end process p_clk_divider;
o_clk_div2    <= clk_divider(0);
o_clk_div4    <= clk_divider(1);
o_clk_div8    <= clk_divider(2);
o_clk_div16   <= clk_divider(3);
end beh;

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Tb_clock_divider IS
END Tb_clock_divider;
 
ARCHITECTURE behavior OF Tb_clock_divider IS
 
-- Component Declaration for the Unit Under Test (UUT)
signal clk : std_logic;
signal rst : std_logic;
signal o_clk_div2    : std_logic;
signal o_clk_div4    :  std_logic;
signal o_clk_div8    :  std_logic;
 signal o_clk_div16   :  std_logic;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
uut: ENTITY WORK.clock_div_pow2(beh)
PORT MAP (
clk => clk,
rst => rst,
o_clk_div2=>o_clk_div2,
 o_clk_div4 => o_clk_div4 ,
 o_clk_div8=>o_clk_div8,
 o_clk_div16=>o_clk_div16
);
 
-- Clock process definitions
clk_process :process
begin
clk <= '0';
wait for 10 ns;
clk <= '1';
wait for 10 ns;
end process;
 
-- Stimulus process
stim_proc: process
begin
rst <= '1';
wait for 20 ns;
rst <= '0';
wait for 20 ns;

wait;
end process;
 
END architecture behavior;