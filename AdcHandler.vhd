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
	signal dac_value_internal : std_logic_vector(0 to 11) := (others => '0');  -- Interne Signal fï¿½r den DAC-Wert
	-- signal comparator_value : std_logic := '0';
	signal current_step : integer range 0 to 11 := 0;  -- Schrittzï¿½hler fï¿½r den DAC
	type states is (init, run, output);
	signal state: states := init;
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
			
			-- comparator_value <= COMPARATOR;
			
			-- dac_value_internal(current_step) <= '1';
			
			-- current_step <= current_step + 1;  

			-- if (current_step <= 11) and (current_step > 0) then
				
			-- 	if (comparator_value = '1') then
			-- 		dac_value_internal(current_step-1) <= '1';
			-- 	else 
			-- 		dac_value_internal(current_step-1) <= '0';
			-- 	end if;
			-- else 
			-- 	ADC_RESULT <= dac_value_internal;
			-- 	current_step <= 0;
			-- end if;
			
			case state is 
				when init => 
					dac_value_internal(11-current_step) <= '1';
					current_step <= current_step + 1; 
					state <= run;
				when run =>
					dac_value_internal(current_step) <= '1';

					if (COMPARATOR = '0') then
						dac_value_internal(11-current_step-1) <= '0';
					end if;
					
					current_step <= current_step + 1; 
					
					if (current_step >= 11) then
						state <= output;
					else 
						state <= run;
					end if;
				when output => 
					ADC_RESULT <= dac_value_internal;
					current_step <= 0;
					state <= init;
			end case;
			
        end if;
    end process;
	
	DAC_VALUE <= dac_value_internal;
	
	SAMPLE_HOLD <= '1';  -- Immer geschlossen halten
	
	
	
end Behavioral;