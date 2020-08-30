LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY up_counter_load IS
  PORT (
    cout : OUT std_logic_vector (7 DOWNTO 0); -- Output of the counter
    data : IN std_logic_vector (7 DOWNTO 0); -- Parallel load for the counter
    load : IN std_logic; -- Parallel load enable
    enable : IN std_logic; -- Enable counting
    clk : IN std_logic; -- Input clock
    reset : IN std_logic -- Input reset
  );
END ENTITY up_counter_load;

ARCHITECTURE beh OF up_counter_load IS
  SIGNAL count : std_logic_vector (7 DOWNTO 0);
BEGIN
  PROCESS (clk, reset) BEGIN
    IF (reset = '1') THEN
      count <= "0000000";
    ELSIF (rising_edge(clk)) THEN
      IF (load = '1') THEN
        count <= data;
      ELSIF (enable = '1') THEN
        count <= count + "0000001";
      END IF;
    END IF;
  END PROCESS;
  cout <= count;
END ARCHITECTURE beh;