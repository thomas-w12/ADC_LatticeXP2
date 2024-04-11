library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    port (
        CLK_50M : in std_logic;
        CLK_25M_BY_2_POW_N : out std_logic_vector(29 downto 0)
    );
end ClockDivider;

architecture Behavioral of ClockDivider is
    signal out_count : std_logic_vector(29 downto 0) := (others => '1');  -- Initialize to all ones
    signal counter : integer := 0;
begin
    process(CLK_50M)
    begin
        if rising_edge(CLK_50M) then
            counter <= counter + 1;
            if counter >= 2 then
                counter <= 0;
                out_count <= out_count - "1"; -- Decrement by 1 because LEDs are active low
            end if;
        end if;
    end process;

    CLK_25M_BY_2_POW_N <= out_count;
end Behavioral;