library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity top is
	-- Definition der hardwaremäßige Ein- und Ausgänge am FPGA
	port (
		clk : in std_logic;
		button1: in std_logic;
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
	
	--Definition der Komponente "clockdivider" (siehe ClockDivider.vhd)
	component ClockDivider is
        port (
            CLK_50M : in std_logic;
            CLK_25M_BY_2_POW_N : out std_logic_vector(29 downto 0)
        );
	end component; 
	
	
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
			shift_clk : out std_logic;
			latch_clk : out std_logic
		);
	end component; 
	
	component SegmentTest is
        port (
			ENABLE : in std_logic;
			SEGMENT_BITS_1 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_2 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_3 : out std_logic_vector(7 downto 0);
			SEGMENT_BITS_4 : out std_logic_vector(7 downto 0)
        );
	end component; 
		
begin
		
	--Instanz der Komponente "Clockdivider" zeugen
	ClockDivider1: ClockDivider 
	port map (
        CLK_50M => clk,
        CLK_25M_BY_2_POW_N => clk_divided
	  );
	  
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
	
	SegmentTest1: SegmentTest
	port map (
		ENABLE => button1,
		SEGMENT_BITS_1 => SEGMENT_BITS_1,
		SEGMENT_BITS_2 => SEGMENT_BITS_2,
		SEGMENT_BITS_3 => SEGMENT_BITS_3,
		SEGMENT_BITS_4 => SEGMENT_BITS_4
	);
		

	--Prozess wird von "clk" getriggert
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

end architecture;