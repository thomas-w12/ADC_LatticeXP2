library ieee ;
use ieee.std_logic_1164.all ;
use ieee.numeric_std.all ;

entity top is
	-- Definition der hardwaremäßige Ein- und Ausgänge am FPGA
	port (
		clk : in std_logic;
		led1 : out std_logic;
		led2 : out std_logic;
        led3 : out std_logic;
        led4 : out std_logic;
        led5 : out std_logic;
        led6 : out std_logic;
        led7 : out std_logic;
        led8 : out std_logic
  	) ;
end top; 


architecture arch of top is

    signal clk_divided : std_logic_vector(29 downto 0);  -- Signal to hold the divided clock value
	
	--Definition der Komponente "clockdivider" (siehe ClockDivider.vhd)
	component ClockDivider is
        port (
            CLK_50M : in std_logic;
            CLK_25M_BY_2_POW_N : out std_logic_vector(29 downto 0)
        );
	end component; 
		
begin
		
	--Instanz der Komponente "module" erzeugen
	ClockDivider1: ClockDivider 
	port map (
        CLK_50M => clk,
        CLK_25M_BY_2_POW_N => clk_divided
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