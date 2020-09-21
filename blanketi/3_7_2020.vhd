LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- XOR

ENTITY kxor IS
    GENERIC (k : INTEGER);
    PORT (
        in_ : IN std_logic_vector(k - 1 DOWNTO 0);
        out_ : OUT std_logic
    );
END ENTITY;
ARCHITECTURE karch OF kxor IS
    PROCESS BEGIN
        out_ <= '0';

        FOR i IN in_'RANGE LOOP
        BEGIN
            out_ <= in_(i)XOR out_;
        END LOOP;
    END PROCESS;
END ARCHITECTURE;

-- END XOR

-- REG

ENTITY preg IS
    GENERIC (n : INTEGER);
    PORT (
        s_ul : IN std_logic;
        clk : IN std_logic;
        reset : IN std_logic;
        s_iz : OUT std_logic;
        p_iz : OUT std_logic_vector(n - 1 DOWNTO 0)
    );
END ENTITY;
ARCHITECTURE areg OF preg IS
    SIGNAL buff : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            buff := (OTHERS => '0');
        ELSIF clk = '1' THEN
            s_iz <= buff(0);

            FOR i IN (0 TO n - 2) LOOP
                buff(i) := buff(i + 1);
            END LOOP;

            buff(n - 1) := s_ul;
            p_iz <= buff;
        END IF;
    END PROCESS;
END ARCHITECTURE;

-- END REG

-- BCD

ENTITY bcd IS
    PORT (
        clk : IN std_logic;
        reset : IN std_logic;
        enable : IN std_logic;
        a : OUT std_logic_vector(7 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE abcd OF bcd IS
    SIGNAL a0 : std_logic_vector(3 DOWNTO 0);
    SIGNAL a1 : std_logic_vector(3 DOWNTO 0);
BEGIN
    PROCESS (clk, reset)
    BEGIN
        IF (reset = '1') THEN
            a0 := (OTHERS => '0');
            a1 := (OTHERS => '0');
        ELSIF clk = '1' AND enable = '1' THEN

            IF (a0 = "1001") AND (a1 /= "1001") THEN
                a0 := "0000";
                a1 := a1 + "0001";
            ELSIF (a0 = "1001") AND (a1 = "1001") THEN
                a0 := "0000";
                a1 := "0000";
            ELSE
                a0 := a0 + "0000";
            END IF;
            a <= std_logic_vector'(a1, a0);
        END IF;
    END PROCESS;
END ARCHITECTURE;

-- END BCD

-- MAIN
ENTITY cela IS
    GENERIC (k, n : INTEGER);
    PORT (
        clk : IN std_logic,
        in_ : IN std_logic,
        rst : IN std_logic,
        cnt : OUT std_logic_vector(8 DOWNTO 0),
        a : OUT std_logic_vector(n/k DOWNTO 0)
    );

END ENTITY;

ARCHITECTURE carch OF cela IS
    SIGNAL buff : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL c : std_logic;
BEGIN
    component_registar : ENTITY work.preg(areg)
        GENERIC MAP(n => n)
        PORT MAP(s_ul => in_, p_iz => buff, s_iz => c, clk => clk, reste => rst);

    component_brojac : ENTITY work.bcd(abcd)
        PORT MAP(clk => clk, reset => rst, enable => c, a => cnt);

    FOR i IN (0 TO n/k - 1) GENERATE
        component_xor : ENTITY work.kxor(karch)
            GENERIC MAP(k => k)
            PORT MAP(in_ => allparts(n - 1 - k * i DOWNTO n - 1 - k * (i + 1)), out_ => a(n/k - i - 1));
    END GENERATE;
END ARCHITECTURE;

-- END MAIN