library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SegmentTest is
    port (
        ENABLE : in std_logic;
        SEGMENT_BITS_1 : out std_logic_vector(7 downto 0);
		SEGMENT_BITS_2 : out std_logic_vector(7 downto 0);
		SEGMENT_BITS_3 : out std_logic_vector(7 downto 0);
		SEGMENT_BITS_4 : out std_logic_vector(7 downto 0)
    );
end SegmentTest;

architecture Behavioral of SegmentTest is

begin
    process(ENABLE)
    begin
        if (ENABLE = '1') then
            SEGMENT_BITS_1 <= "00000000";
			SEGMENT_BITS_2 <= "00000000";
			SEGMENT_BITS_3 <= "00000000";
			SEGMENT_BITS_4 <= "00000000";
        else
			SEGMENT_BITS_1 <= "11000100";
			SEGMENT_BITS_2 <= "00101111";
			SEGMENT_BITS_3 <= "10001111";
			SEGMENT_BITS_4 <= "10011100";
		end if;
    end process;
end Behavioral;