LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registar IS
    GENERIC (n : INTEGER);
    PORT (
        ulaz : IN std_logic_vector(n - 1 DOWNTO 0),
        izlaz : OUT std_logic_vector(n - 1 DOWNTO 0),
        dozvola : IN std_logic
    );

END ENTITY registar;

ARCHITECTURE reg OF registar IS
    SIGNAL reg_out : std_logic_vector (n - 1 DOWNTO 0)
BEGIN
    PROCESS (dozvola) BEGIN
        IF dozvola = '1' THEN
            reg_out <= ulaz;
        END IF;
    END PROCESS;

    izlaz <= reg_out;
END ARCHITECTURE reg;
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY brojac IS
    GENERIC (n : INTEGER);
    PORT (
        smer, clk, dozvola : IN std_logic;
        ulaz : IN std_logic_vector(n - 1 DOWNTO 0);
        izlaz : OUT std_logic_vector(n - 1 DOWNTO 0)
    );
END ENTITY brojac;

ARCHITECTURE broji OF brojac IS
    SIGNAL bout : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    PROCESS (clk) BEGIN
        IF (clk = '1') THEN
            IF (dozvola = '1') THEN
                bout <= ulaz;
            ELSIF (smer = '1') THEN
                bout <= ulaz + '1';
            ELSE
                bout <= ulaz - '1';
            END IF;
        END IF;
    END PROCESS;
    izlaz <= bout;
END ARCHITECTURE broji;

--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY n_komparator IS
    GENERIC (n : INTEGER);
    PORT (
        rulaz, bulaz : IN std_logic_vector(n - 1 DOWNTO 0);
        cout : OUT std_logic
    );
END ENTITY n_komparator;

ARCHITECTURE compare OF n_comparator IS
BEGIN
    PROCESS BEGIN
        FOR i IN rulaz'RANGE LOOP
            cout <= (rulaz(i) = bulaz(i)) AND cout;
        END LOOP;
    END PROCESS;
END ARCHITECTURE compare;
--------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY zadatak IS
    GENERIC (n : INTEGER);
    PORT (
        ulazni : IN std_logic_vector(n - 1 DOWNTO 0);
        smer_brojanja, dozvola_upisa, clock : IN std_logic;
        c_out : OUT std_logic
    );
END ENTITY zadatak;

ARCHITECTURE zad OF zadatak IS
    SIGNAL s_brojac, s_req : std_logic_vector(n - 1 DOWNTO 0);
BEGIN
    component_registar : ENTITY work.registar(reg)
        GENERIC MAP(n => n)
        PORT MAP(ulaz => ulazni, izlaz => s_req, dozvola => dozvola_upisa);

    component_brojac : ENTITY work.brojac(broji)
        GENERIC MAP(n => n)
        PORT MAP(smer => smer_brojanja, clk => clock, dozvola => dozvola_upisa, ulaz => 0, izlaz => s_brojac);

    component_n_komparator : ENTITY work.n_comparator(compare)
        GENERIC MAP(n => n)
        PORT MAP(rulaz => s_brojac, bulaz => s_req, c => c_out);
END ARCHITECTURE zad;

--------------------------------------------------------------------------

-- TB
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY n_bit_counter_tb IS
    GENERIC (n : INTEGER := 4);
END ENTITY n_bit_counter_tb;

ARCHITECTURE n_bit_counter_tb_arch OF n_bit_counter_tb IS
    SIGNAL tb_ulaz : std_logic_vector(n - 1 DOWNTO 0);
    SIGNAL tb_clk : std_logic := '0';
    SIGNAL tb_smer_brojanja : std_logic := '0';
    SIGNAL tb_dozvola_upisa : std_logic := '0';
    SIGNAL tb_c : std_logic := '0';
BEGIN
    eet : ENTITY work.zadatak(zad)
        GENERIC MAP(n => n)
        PORT MAP(
            ulazni => tb_ulaz,
            smer_brojanja => tb_smer_brojanja,
            dozvola_upisa => tb_dozvola_upisa,
            clock => tb_clk,
            c_out => tb_c
        );

    tb_clk <= NOT tb_clk AFTER 100ns;

    poc : PROCESS

    END PROCESS poc;

END ARCHITECTURE n_bit_counter_tb_arch;