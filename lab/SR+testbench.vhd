library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sr_ff is
port(s:in std_logic;
		clk: in std_logic;
		r:in std_logic;
		q: out std_logic);
end entity sr_ff;

architecture behavioral of sr_ff is
begin

process(clk)
variable tmp:std_logic;
begin
if(clk='1' and clk'event) then
if(s='0' and r='0')then
tmp:=tmp;
elsif(s='1' and r='1') then
tmp:='Z';
elsif(s='1' and r='0')then
tmp:='1';
else
tmp:='0';
end  if;
end if;
q<=tmp;
end process;
end architecture behavioral;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity sr_tmp is
end entity sr_tmp;

architecture simSR of sr_tmp is

 component sr_ff is
        port 
        (
            s,r,clk: in std_logic;
            q: out std_logic
        );  
    end component sr_ff;

signal s: std_logic :='0';
signal r: std_logic :='0';
signal clk: std_logic :='0';
signal q: std_logic:='0';
constant half_period:time:=30 ns; 

begin
    port_map:sr_ff port map(clk=>clk,s=>s,r=>r,q=>q);

    process begin
        clk <= not clk after half_period;
    end process;
    process begin
        s<='0';
        r<='0';

        s<='0' after 40 ns;
        r<='1' after 40 ns;

        s<='1' after 80 ns;
        r<='0' after 80 ns;

        s<='1' after 120 ns;
        r<='1' after 120 ns;
    end process;
end architecture simSR;