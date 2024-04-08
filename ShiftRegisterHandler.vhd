library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;  

Entity ShiftRegisterHandler is
   Port (
	  CLK_781k25 : in std_logic;
	  --7 segement value
	  segment1_stream : in std_logic_vector(7 downto 0) := (others => '0');
      segment2_stream : in std_logic_vector(7 downto 0) := (others => '0');
      segment3_stream : in std_logic_vector(7 downto 0) := (others => '0');
      segment4_stream : in std_logic_vector(7 downto 0) := (others => '0');
	  --7 segment io
	  segment1_data : out std_logic;
	  segment2_data : out std_logic;
	  segment3_data : out std_logic;
	  segment4_data : out std_logic;
	  shift_clk : out std_logic;
	  latch_clk : out std_logic
      );
End ShiftRegisterHandler;

Architecture config1 Of ShiftRegisterHandler Is


signal state : std_logic_vector(2 downto 0) := (others => '0');
signal counter : std_logic_vector(3 downto 0) := (others => '0');
signal internal_segment1_stream: std_logic_vector(7 downto 0) := (others => '0');
signal internal_segment2_stream: std_logic_vector(7 downto 0) := (others => '0');
signal internal_segment3_stream: std_logic_vector(7 downto 0) := (others => '0');
signal internal_segment4_stream: std_logic_vector(7 downto 0) := (others => '0');

Begin

process(CLK_781k25)
	begin
		
			
		if (CLK_781k25'event and CLK_781k25 = '1') then
		
			if (state="000") then
                internal_segment1_stream <= segment1_stream;
                internal_segment2_stream <= segment2_stream;
                internal_segment3_stream <= segment3_stream;
                internal_segment4_stream <= segment4_stream;
				
				
				
				state<= "001";
				latch_clk<= '0'; 
				counter <= "0000";

			elsif (state="001") then
			
				segment1_data <= internal_segment1_stream(0);
				segment2_data <= internal_segment2_stream(0);
				segment3_data <= internal_segment3_stream(0);
				segment4_data <= internal_segment4_stream(0);	
				 
				shift_clk <= '0';

				if (counter = "1000") then
					latch_clk<= '1';
					state <= "000";
				else
					state <= "010";
				end if;
				
			elsif (state="010") then

				internal_segment1_stream <= '0' & internal_segment1_stream(7 downto 1);
				internal_segment2_stream <= '0' & internal_segment2_stream(7 downto 1);
				internal_segment3_stream <= '0' & internal_segment3_stream(7 downto 1);
				internal_segment4_stream <= '0' & internal_segment4_stream(7 downto 1);
				counter <= counter + '1';	
				shift_clk <= '1';					
				state <= "001";

			end if;
			
		end if;
			
	end process;
	
End config1;
-- =============================================================================

