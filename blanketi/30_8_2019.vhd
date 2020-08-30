LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY parnost IS
    GENERIC (n : INTEGER);
    PORT (
        ulaz : IN std_logic_vector(n - 1 DOWNTO 0);
        izlaz : OUT std_logic_vector(n - 1 DOWNTO 0);
    );
END ENTITY parnost;

ARCHITECTURE parnost_arch OF parnost IS
    SIGNAL acc : std_logic := '0';
BEGIN
    PROCESS BEGIN
        obilazak : FOR i IN (n - 2 DOWNTO 0) GENERATE
            acc := acc XOR ulaz(i);
        END GENERATE obilazak;

        izlaz <= ulaz;
        izlaz(n - 1) <= acc;
    END PROCESS;
END ARCHITECTURE parnost_arch;
ENTITY zadatak IS
    PORT (
        a, b : IN std_logic_vector(8 DOWNTO 0);
        izlaz : OUT std_logic_vector(8 DOWNTO 0);
        validnost : OUT std_logic;
    );
END ENTITY zadatak;

ARCHITECTURE zadatak_arch OF zadatak IS
    SIGNAL a_, b_ : std_logic_vector(8 DOWNTO 0);
BEGIN
    amod : ENTITY work.parnost(parnost_arch)
        GENERIC MAP(n => 9)
        PORT MAP(ulaz => a, izlaz => a_);

    bmod : ENTITY work.parnost(parnost_arch)
        GENERIC MAP(n => 9)
        PORT MAP(ulaz => b, izlaz => b_);

    PROCESS BEGIN
        validnost <= a_(8) = a(8) AND b_(8) = b(8);

        a_(8) := '0';
        b_(8) := '0';
        izlaz <= a_ + b_;
    END PROCESS;
END ARCHITECTURE zadatak_arch;

ENTITY tb IS
END ENTITY tb;

ARCHITECTURE tb_arch OF tb IS
    SIGNAL tb_a, tb_b, tb_izlaz : std_logic_vector(8 DOWNTO 0);
    SIGNAL tb_validnost : std_logic;
BEGIN
    test : ENTITY work.zadatak(zadatak_arch)
        PORT MAP(a => tb_a, b => tb_b, izlaz => tb_izlaz, validnost => tb_validnost);
    PROCESS BEGIN
        tb_a <= '001011100';
        tb_b <= '101011110';
        WAIT FOR 60ns;
    END PROCESS;
END ARCHITECTURE tb_arch;