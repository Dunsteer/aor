LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY andor IS
PORT(a,b,c : IN STD_LOGIC; d: OUT STD_LOGIC);
END ENTITY andor;

ARCHITECTURE akomp OF andor IS
BEGIN
	d<=c OR (a AND b);
END ARCHITECTURE akomp;