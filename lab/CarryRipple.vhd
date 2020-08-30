library ieee;
use ieee.std_logic_1164.all;


entity carry_ripple is
port(a,b:in std_logic_vector(0 to 3);
		s:out std_logic_vector(0 to 3);
		cout:out std_logic;
		cin:in std_logic;
		clk:in std_logic
		);
end entity carry_ripple;

architecture beh of carry_ripple is
signal c0,c1,c2:std_logic;

begin
process(clk,a,b)
begin

s(3)<=(a(3) xor b(3)) xor cin;
c0<=(a(3)and b(3)) or (cin and(a(3) xor b(3)));

s(2)<=(a(2) xor b(2)) xor c0;
c1<=(a(2)and b(2)) or (c0 and(a(2) xor b(2)));

s(1)<=(a(1) xor b(1)) xor c1;
c2<=(a(1)and b(1)) or (c1 and(a(1) xor b(1)));

s(0)<=(a(0) xor b(0)) xor c2;
cout<=(a(0)and b(0)) or (c2 and(a(0) xor b(0)));

end process;

end beh;


library ieee;
use ieee.std_logic_1164.all;

entity test is
end entity test;


architecture tb of test is
signal a,b: std_logic_vector(0 to 3);
signal s: std_logic_vector(0 to 3);
signal cout: std_logic;
signal cin: std_logic;
signal clk: std_logic;

begin
uut:entity work.carry_ripple(beh) port map(a=>a,b=>b,cout=>cout,cin=>cin,s=>s,clk=>clk);

process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;

process
begin
a<="0001";
b<="1010";
cin<='0';
wait for 20ns;

a<="0100";
b<="1100";
wait for 20ns;
a<="0111";
b<="1100";
wait for 20ns;
a<="0100";
b<="0100";
wait for 20ns;
a<="1100";
b<="1111";
wait for 20ns;
end process;
end tb;