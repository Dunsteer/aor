library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity mux4x1 is
port
(
	ulaz: in std_logic_vector(3 downto 0);
	s0,s1:in std_logic;
	z:out std_logic
);
end entity mux4x1;

architecture beh of mux4x1 is
begin
process(ulaz,s0,s1)
begin
if(s0='0' and s1='0') then
z<=ulaz(0);
elsif(s0='1' and s1='0')then 
z<=ulaz(1);
elsif(s0='0' and s1='1')then
z<=ulaz(2);
else
z<=ulaz(3);
end if;
end process;
end architecture beh;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity mux_test is 
end entity mux_test;

architecture arc of mux_test is
COMPONENT mux4x1
    PORT(
         ulaz : in  std_logic_vector(3 downto 0);
         s0 : IN  std_logic;
         s1 : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
 
   --Inputs
   signal ulaz : std_logic_vector := "0000";
   signal s0 : std_logic := '0';
   signal s1 : std_logic := '0';
 
    --Outputs
   signal z : std_logic;
	
	BEGIN
 
   uut: mux4x1 PORT MAP (
          ulaz => ulaz,
          
          s0 => s0,
          s1 => s1,
          z => z
        );

   stim_proc: process
   begin
    
      wait for 100 ns;  
 
    ulaz<="1010";       
 
    s0 <= '0'; s1 <= '0';
 
      wait for 100 ns;  
 
    s0 <= '1'; s1 <= '0';
 
      wait for 100 ns;  
 
    s0 <= '0'; s1 <= '1';
 
        wait for 100 ns;    
 
    s0 <= '0'; s1 <= '1';   
 
        wait for 100 ns;    
 
    end process;
end architecture arc;