
-- VHDL Instantiation Created from source file spi_master.vhd -- 16:38:35 01/24/2023
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT spi_master
	PORT(
		miso : IN std_logic;
		clk : IN std_logic;
		en_i : IN std_logic;
		data_i : IN std_logic_vector(7 downto 0);          
		mosi : OUT std_logic;
		sck : OUT std_logic;
		ss : OUT std_logic;
		data_o : OUT std_logic_vector(7 downto 0);
		en_o : OUT std_logic;
		busy : OUT std_logic
		);
	END COMPONENT;

	Inst_spi_master: spi_master PORT MAP(
		miso => ,
		mosi => ,
		sck => ,
		ss => ,
		clk => ,
		data_o => ,
		en_o => ,
		busy => ,
		en_i => ,
		data_i => 
	);


