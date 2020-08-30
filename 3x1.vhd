library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux_test is 
end entity mux_test;

architecture arc of mux_test is
---COMPONENT mux3x1
    --PORT(
       --  a,b,c: in  std_logic;
       --  s0 : IN  std_logic;
       --  s1 : IN  std_logic;
       --  z : OUT  std_logic
       -- );
  --  END COMPONENT;
 
   --ulazi
   signal a,b,c: std_logic:='0';
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
 
    --izlaz
   signal z : std_logic;
	
	BEGIN
 
   uut: Entity work.mux3x1(beh) PORT MAP (
          a=>a,
			 b=>b,
          c=>c,
          s0 => s0,
          s1 => s1,
          z => z
        );

   stim_proc: process
   begin
    
      wait for 1 ns;  
 
    a<='0';       
	 b<='1';
	 c<='1';
    s0 <= '0';
	 s1 <= '0';
 
      wait for 200 ps;  
 
    s0 <= '1'; s1 <= '0';
 
      wait for 200 ps;  
 
    s0 <= '0'; s1 <= '1';
 
        wait for 200 ps;    
 
    s0 <= '1'; s1 <= '1';   
 
        wait for 200 ps;    
 
    end process;
end architecture arc;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity mux3x1 is
port
(
	a,b,c: in std_logic;
	s0,s1:in std_logic;
	z:out std_logic
);
end entity mux3x1;

architecture beh of mux3x1 is
begin
process(a,b,c,s0,s1)
begin
if(s0='0' and s1='0') then
z<=a;
elsif(s0='1' and s1='0')then 
z<=b;
elsif(s0='0' and s1='1')then
z<=c;
else
z<='Z';
end if;
end process;
end architecture beh;