LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity komp is
port(a,b,cin,clk:in std_logic;
	cout: inout std_logic);
end entity komp;

architecture arh of komp is
begin
process(clk)
begin
if clk'event and clk='1' then
	cout<=(cin xor a)or b;
	end if;
end process;
end architecture;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity vezba4 is
generic(n:integer);
port(a,b:in std_logic_vector(n-1 downto 0);
	cin:in std_logic;
	y:inout std_logic_vector(n-1 downto 0);
	clk:in std_logic
	);
end entity vezba4;

architecture arhi of vezba4 is
begin 
niz: for i in y'range generate 
begin
	prva: if i=y'left generate 
	celija: entity work.komp(arh)
		port map(clk=>clk,a=>a(i),b=>b(i),cin=>cin,cout=>y(i));
	end generate prva;
	ostale: if i/=y'left generate 
	celija: entity work.komp(arh)
		port map(clk=>clk,a=>a(i),b=>b(i),cin=>y(i+1),cout=>y(i));
	end generate ostale;
end generate niz;
end architecture arhi;




LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity vezba4_tb is
generic(n:integer:=4);
end entity vezba4_tb;

architecture test of vezba4_tb is
signal clk:std_logic:='0';
signal cin:std_logic;
signal a:std_logic_vector(n-1 downto 0);
signal b:std_logic_vector(n-1 downto 0);
signal y:std_logic_vector(n-1 downto 0);
begin

uut: entity work.vezba4(arhi)
generic map(n=>4)
port map(clk=>clk,cin=>cin,a=>a,b=>b,y=>y);

clk<=not clk after 50ps;
poc: process
begin
cin<='0';
a<="1010";
b<="0000";
wait for 500ps;
cin<='0';
a<="1010";
b<="1111";
wait for 500ps;
cin<='1';
a<="1010";
b<="0001";
wait for 500ps;
cin<='1';
a<="0000";
b<="0000";
wait for 500ps;
end process poc;
end architecture test;