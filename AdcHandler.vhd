library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity AdcHandler is
    Port (
        CLK : in std_logic;  -- clock for DAC
		COMPARATOR : in std_logic; -- result comparator
		DAC_VALUE : out std_logic_vector(11 downto 0); -- current value DAC which is compared to the value which we want to measure
		SAMPLE_HOLD : out std_logic; -- connect to sample and hold switch of ADC
        ADC_RESULT : out std_logic_vector(11 downto 0)  -- ADC-result
    );
end AdcHandler;

architecture Behavioral of AdcHandler is
	signal dac_value_internal : std_logic_vector(11 downto 0) := (others => '0');  -- internal signal for current DAC value
	signal current_step : integer range 0 to 11 := 0;  -- count steps of conversion
	type states is (init, run, output, reset); -- state machine successive approximation
	signal state: states := init; 
begin
    process(CLK)
    begin
        if rising_edge(CLK) then

			case state is 
				when init => 
					dac_value_internal(11-current_step) <= '1'; -- set highes bit of DAC
					current_step <= current_step + 1; 
					state <= run;
				when run =>
					dac_value_internal(11-current_step) <= '1'; -- set current bit

					if (COMPARATOR = '0') then
						dac_value_internal(11-current_step+1) <= '0'; -- reset last bit if comparator result is low
					end if;
					
					current_step <= current_step + 1; 
					
					if (current_step >= 11) then
						state <= output; -- switch to output ADC value if all steps finished
					else 
						state <= run; -- go to next step if not finished yet
					end if;
				when output => 
					ADC_RESULT <= dac_value_internal; -- current DAC value is result of conversion, output it
					state <= reset; 
				when reset =>
					current_step <= 0;
					dac_value_internal <= (others => '0'); -- reset DAC value
					state <= init;
			end case;
			
        end if;
    end process;
	
	DAC_VALUE <= dac_value_internal; -- connect to I/0
	
	SAMPLE_HOLD <= '1';  -- always closed
	
	
	
end Behavioral;