
-- VHDL Instantiation Created from source file DDS_Serial_Programm.vhd -- 16:33:57 01/24/2023
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT DDS_Serial_Programm
	PORT(
		Clock : IN std_logic;
		DDS_Serial_Data : IN std_logic_vector(63 downto 0);
		DDS_Serial_Address : IN std_logic_vector(7 downto 0);
		DDS_Start_Serial_Transmission : IN std_logic;          
		DDS_IO_Reset : OUT std_logic;
		DDS_SDIO : OUT std_logic;
		DDS_SCLK : OUT std_logic;
		DDS_Serial_Busy : OUT std_logic
		);
	END COMPONENT;

	Inst_DDS_Serial_Programm: DDS_Serial_Programm PORT MAP(
		Clock => ,
		DDS_Serial_Data => ,
		DDS_Serial_Address => ,
		DDS_Start_Serial_Transmission => ,
		DDS_IO_Reset => ,
		DDS_SDIO => ,
		DDS_SCLK => ,
		DDS_Serial_Busy => 
	);


