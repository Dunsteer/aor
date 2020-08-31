-- KOMPARATOR

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY komp IS
    PORT (
        a, b : IN std_logic;
        cout : OUT std_logic);
END ENTITY komp;

ARCHITECTURE arh OF komp IS
BEGIN
    PROCESS BEGIN
        cout <= a = b;
    END PROCESS;
END ARCHITECTURE;

-- END KOMPARATOR

-- AND/!OR

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY and_or IS
    GENERIC (n : INTEGER);
    PORT (
        a : IN std_logic_vector(n - 1 DOWNTO 0);
        cout : OUT std_logic;
        and_ : IN std_logic
    );
END ENTITY and_or;

ARCHITECTURE arhi OF and_or IS
BEGIN
    PROCESS BEGIN
        niz : FOR i IN a'RANGE GENERATE
        BEGIN

            IF and_ = '1' THEN
                cout <= a(i) AND cout;
            ELSE
                cout <= a(i) OR cout;
            END IF;

        END GENERATE niz;
    END PROCESS;
END ARCHITECTURE arhi;

-- END AND/!OR

-- N KOMPARATOR

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nkomp IS
    GENERIC (n : INTEGER);
    PORT (
        a, b : IN std_logic_vector(n - 1 DOWNTO 0);
        e : OUT std_logic
    );
END ENTITY nkomp;

ARCHITECTURE arhp OF nkomp IS
    SIGNAL y : std_logic_vector(n - 1 DOWNTO 0)
BEGIN
    kako_god : ENTITY work.and_or(arhi)
        GENERIC MAP(n => n)
        PORT MAP(a => y, cout => e, and_ => '1');

    PROCESS BEGIN
        niz : FOR i IN a'RANGE GENERATE
        BEGIN
            celija : ENTITY work.komp(arh)
                PORT MAP(a => a(i), b => b(i), cout => y(i));
        END GENERATE niz;
    END PROCESS;

END ARCHITECTURE arhp;

-- END N KOMPARATOR

-- PIN KOMPARATOR

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pin_komp IS
    GENERIC (n : INTEGER);
    PORT (
        pin, input_ : IN std_logic_vector(n - 1 DOWNTO 0);
        clk : IN std_logic;
        e : OUT std_logic
    );
END ENTITY pin_komp;

ARCHITECTURE kreativno_ime OF pin_komp IS
BEGIN
    PROCESS (clk) BEGIN
        IF clk = '1'
        BEGIN
            komp : ENTITY work.nkomp(arhp)
                GENERIC MAP(n => n)
                PORT MAP(a => pin, b => input_, e => e);
        END IF;
    END PROCESS;
END ARCHITECTURE kreativno_ime;

-- END PIN KOMPARATOR

-- TB
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY pin_komp_tb IS
    GENERIC (n : INTEGER := 4);
END ENTITY pin_komp_tb;

ARCHITECTURE pin_komp_tb_arh OF pin_komp_tb IS
    SIGNAL clk : std_logic := '0';
    SIGNAL a : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL b : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    eet : ENTITY work.pin_komp(kreativno_ime)
        GENERIC MAP(n => n)
        PORT MAP(pin => a, input_ => b, clk => clk);

    clk <= NOT clk AFTER 50ns;

    poc : PROCESS
        a <= '1100';
        b <= '1010';
        WAIT FOR 60ns;
        a <= '1010';
        b <= '1110';
        WAIT FOR 60ns;
        a <= '1100';
        b <= '1100';
        WAIT FOR 60ns;
        a <= '0100';
        b <= '0100';
        WAIT FOR 60ns;
    END PROCESS poc;
    ;
END ARCHITECTURE pin_komp_tb_arh;
-- END TB