library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity jk_ff is
port(j:in std_logic;
		clk: in std_logic;
		k:in std_logic;
		q: out std_logic);
end entity jk_ff;

architecture behavioral of jk_ff is
begin

process(clk)
variable tmp:std_logic;
begin
if(clk='1' and clk'event) then
if(j='0' and k='0')then
tmp:=tmp;
elsif(j='1' and k='1') then
tmp:=not tmp;
elsif(j='1' and k='0')then
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

entity jk_tmp is
end entity jk_tmp;

architecture simJK of jk_tmp is

 component jk_ff is
        port 
        (
            j,k,clk: in std_logic;
            q: out std_logic
        );  
    end component jk_ff;

signal j: std_logic :='0';
signal k: std_logic :='0';
signal clk: std_logic :='0';
signal q: std_logic:='0';
constant half_period:time:=30 ns; 

begin
    port_map:jk_ff port map(clk=>clk,j=>j,k=>k,q=>q);

    process begin
        clk <= not clk after half_period;
    end process;
    process begin
        j<='0';
        k<='0';

        j<='0' after 40 ns;
        k<='1' after 40 ns;

        j<='1' after 80 ns;
        k<='0' after 80 ns;

        j<='1' after 120 ns;
        k<='1' after 120 ns;
    end process;
end architecture simJK;


