library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AdcHandler is
    Port (
        CLK : in std_logic;  -- clock for DAC
		COMPARATOR : in std_logic; -- result comparator
		DAC_VALUE : out std_logic_vector(0 to 11); -- current value DAC which is compared to the value which we want to measure
		SAMPLE_HOLD : out std_logic; -- connect to sample and hold switch of ADC
        ADC_RESULT : out std_logic_vector(0 to 11)  -- ADC-result
    );
end AdcHandler;

architecture Behavioral of AdcHandler is
	signal dac_value_internal : std_logic_vector(0 to 11) := (others => '0');  -- Interne Signal für den DAC-Wert
	signal comparator_value : std_logic := '0';
	signal current_step : integer range 0 to 11 := 11;  -- Schrittzähler für den DAC

begin
    process(CLK)
    begin
        if rising_edge(CLK) then
			
			comparator_value <= COMPARATOR;
			
			dac_value_internal(current_step) <= '1';
			
			if current_step < 11 and current_step >= 0 then
				
				if comparator_value = '1' then
					dac_value_internal(current_step+1) <= '1';
				else 
					dac_value_internal(current_step+1) <= '0';
				end if;
			end if;
			
			current_step <= current_step - 1;  
			
			if current_step < 0 then
				ADC_RESULT <= dac_value_internal;
				current_step <= 11;
			end if;
			
			
			
        end if;
    end process;
	
	SAMPLE_HOLD <= '1';  -- Immer geschlossen halten
	
end Behavioral;