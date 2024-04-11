library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity top is
	-- Definition of the ports of the hardware FPGA
	port (
		clk : in std_logic;
		button_sw2: in std_logic;
		dip_switch_1: in std_logic;
		dip_switch_2: in std_logic;
		dip_switch_3: in std_logic;
		dip_switch_4: in std_logic;
		led1 : out std_logic;
		led2 : out std_logic;
        led3 : out std_logic;
        led4 : out std_logic;
        led5 : out std_logic;
        led6 : out std_logic;
        led7 : out std_logic;
        led8 : out std_logic;
		data1: out std_logic;
		data2: out std_logic;
		data3: out std_logic;
		data4: out std_logic;
		shift_clk: out std_logic;
		latch_clk: out std_logic
  	) ;
end top; 


architecture arch of top is

    signal clk_divided : std_logic_vector(29 downto 0);  -- Signal to hold the divided clock value
	
	signal SEGMENT_BITS_1 : std_logic_vector(7 downto 0);
	signal SEGMENT_BITS_2 : std_logic_vector(7 downto 0);
	signal SEGMENT_BITS_3 : std_logic_vector(7 downto 0);
	signal SEGMENT_BITS_4 : std_logic_vector(7 downto 0);

	signal SEGMENT_VALUE: std_logic_vector(3 downto 0); -- Signal to hold the 7 segment value in binary
	
	-- Definition of the component "ClockDivider"
	component ClockDivider is
        port (
            CLK_50M : in std_logic;
            CLK_25M_BY_2_POW_N : out std_logic_vector(29 downto 0)
        );
	end component; 
	
	-- Definition of the component "ShiftRegisterHandler"
	component ShiftRegisterHandler is
		port (
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
			--shift register control
			shift_clk : out std_logic;
			latch_clk : out std_logic
		);
	end component; 
	
	-- Definition of the component "SegmentTest"
	component SegmentTest is
        port (
			ENABLE : in std_logic;
			SEGMENT_BITS_1 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_2 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_3 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_4 : out std_logic_vector(7 downto 0)
        );
	end component; 
	
	-- Definition of the component "SegmentDecoder"
	component SegmentDecoder is
        port (
			DOT : in std_logic;
			SEGMENT_VALUE : in std_logic_vector(3 downto 0);
			SEGMENT_BITS : out std_logic_vector(7 downto 0)
        );
	end component; 
		
begin
		
	-- Initialize clock divider component
	ClockDivider1: ClockDivider 
	port map (
        CLK_50M => clk,
        CLK_25M_BY_2_POW_N => clk_divided
	  );
	  
	-- Initialize shift register handler component
	ShiftRegisterHandler1: ShiftRegisterHandler
	port map (
		CLK_781k25 => clk_divided(5),
		segment1_data => data1,
		segment2_data => data2,
		segment3_data => data3,
		segment4_data => data4,
		shift_clk => shift_clk,
		latch_clk => latch_clk,
		segment1_stream => SEGMENT_BITS_1,
		segment2_stream => SEGMENT_BITS_2,
		segment3_stream => SEGMENT_BITS_3,
		segment4_stream => SEGMENT_BITS_4
	);
	
	-- Initialize segment test component
	-- SegmentTest1: SegmentTest
	-- port map (
	-- 	ENABLE => button_sw2,
	-- 	SEGMENT_BITS_1 => SEGMENT_BITS_1,
	-- 	SEGMENT_BITS_2 => SEGMENT_BITS_2,
	-- 	SEGMENT_BITS_3 => SEGMENT_BITS_3,
	-- 	SEGMENT_BITS_4 => SEGMENT_BITS_4
	-- );
	
	-- Initialize segment decoder component
	SegmentDecoder1: SegmentDecoder
	port map (
		DOT => not button_sw2,
		SEGMENT_BITS => SEGMENT_BITS_1,
		SEGMENT_VALUE => SEGMENT_VALUE
	);
		

	-- Assign the divided clock to the LEDs
    process(clk)
    begin
        if rising_edge(clk) then
            led1 <= clk_divided(22);
            led2 <= clk_divided(23);
            led3 <= clk_divided(24);
            led4 <= clk_divided(25);
            led5 <= clk_divided(26);
            led6 <= clk_divided(27);
            led7 <= clk_divided(28);
            led8 <= clk_divided(29);
        end if;

    end process; 

	-- Assign the dip switches to the 7 segment value
	SEGMENT_VALUE(0) <= dip_switch_1;
	SEGMENT_VALUE(1) <= dip_switch_2;
	SEGMENT_VALUE(2) <= dip_switch_3;
	SEGMENT_VALUE(3) <= dip_switch_4;

end architecture;