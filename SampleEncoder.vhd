library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  
use ieee.numeric_std.all;

Entity SampleEncoder is 
    Port(
        SEGMENT_VALUE_1: out std_logic_vector(3 downto 0);
        SEGMENT_VALUE_2: out std_logic_vector(3 downto 0);
        SEGMENT_VALUE_3: out std_logic_vector(3 downto 0);
        SEGMENT_VALUE_4: out std_logic_vector(3 downto 0);
        ADC_SAMPLE: in std_logic_vector(11 downto 0);
        CLK_47Hz68: in std_logic
    );
end SampleEncoder;

Architecture rtl of SampleEncoder is 
    signal mV_voltage : integer;
    signal volt : integer;
    signal mVolt_100 : integer;
    signal mVolt_10 : integer;
    signal mVolt_1 : integer;

begin

    process(CLK_47Hz68)
	begin
		if (CLK_47Hz68'event and CLK_47Hz68 = '1') then

			--conversion adc input to 7 segment output
			mV_voltage <= to_integer(unsigned(ADC_SAMPLE)*3300/4096);
			volt <= mV_voltage / 1000;
			mVolt_100 <= (mV_voltage - 1000*volt) / 100;
			mVolt_10 <= (mV_voltage - 1000*volt - 100*mVolt_100) / 10;
			mVolt_1 <= (mV_voltage - 1000*volt - 100*mVolt_100 - 10*mVolt_10);
			
			SEGMENT_VALUE_1 <= std_logic_vector(to_unsigned(volt, 4));
			SEGMENT_VALUE_2 <= std_logic_vector(to_unsigned(mVolt_100, 4));
			SEGMENT_VALUE_3 <= std_logic_vector(to_unsigned(mVolt_10, 4));
			SEGMENT_VALUE_4 <= std_logic_vector(to_unsigned(mVolt_1, 4));
			
		end if;
	end process;
end rtl;