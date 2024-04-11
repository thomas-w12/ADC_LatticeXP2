library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SegmentDecoder is
    port (
        DOT : in std_logic;
		SEGMENT_VALUE : in std_logic_vector(3 downto 0);
        SEGMENT_BITS : out std_logic_vector(7 downto 0)
    );
end SegmentDecoder;

architecture Behavioral of SegmentDecoder is

begin

	SEGMENT_BITS <=
				"10110111" when ((SEGMENT_VALUE = "0000") and (DOT = '0'))  -- 0
		else	"11110111" when ((SEGMENT_VALUE = "0000") and (DOT = '1'))  -- 0
		else 	"10000100" when ((SEGMENT_VALUE = "0001") and (DOT = '0'))  -- 1
		else 	"11000100" when ((SEGMENT_VALUE = "0001") and (DOT = '1'))  -- 1
		else 	"00101111" when ((SEGMENT_VALUE = "0010") and (DOT = '0'))  -- 2
		else 	"01101111" when ((SEGMENT_VALUE = "0010") and (DOT = '1'))  -- 2
		else 	"10001111" when ((SEGMENT_VALUE = "0011") and (DOT = '0'))  -- 3
		else 	"11001111" when ((SEGMENT_VALUE = "0011") and (DOT = '1'))  -- 3
		else 	"10011100" when ((SEGMENT_VALUE = "0100") and (DOT = '0'))  -- 4
		else 	"11011100" when ((SEGMENT_VALUE = "0100") and (DOT = '1'))  -- 4
		else 	"10011011" when ((SEGMENT_VALUE = "0101") and (DOT = '0'))  -- 5
		else 	"11011011" when ((SEGMENT_VALUE = "0101") and (DOT = '1'))  -- 5
		else 	"10111001" when ((SEGMENT_VALUE = "0110") and (DOT = '0'))  -- 6
		else 	"11111001" when ((SEGMENT_VALUE = "0110") and (DOT = '1'))  -- 6
		else 	"10000110" when ((SEGMENT_VALUE = "0111") and (DOT = '0'))  -- 7
		else 	"11000110" when ((SEGMENT_VALUE = "0111") and (DOT = '1'))  -- 7
		else 	"10111111" when ((SEGMENT_VALUE = "1000") and (DOT = '0'))  -- 8
		else 	"11111111" when ((SEGMENT_VALUE = "1000") and (DOT = '1'))  -- 8
		else 	"10011111" when ((SEGMENT_VALUE = "1001") and (DOT = '0'))  -- 9
		else 	"11011111" when ((SEGMENT_VALUE = "1001") and (DOT = '1'))  -- 9
		else 	"01000000" when (DOT = '1')  -- Blank segment with DOT
		else 	"00000000";  -- Blank segment
			
end Behavioral;