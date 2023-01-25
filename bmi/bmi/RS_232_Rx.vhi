
-- VHDL Instantiation Created from source file RS_232_Rx.vhd -- 17:11:49 01/24/2023
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RS_232_Rx
	PORT(
		Clock : IN std_logic;
		Serial_In : IN std_logic;          
		Data_Out : OUT std_logic_vector(7 downto 0);
		Valid : OUT std_logic
		);
	END COMPONENT;

	Inst_RS_232_Rx: RS_232_Rx PORT MAP(
		Clock => ,
		Data_Out => ,
		Valid => ,
		Serial_In => 
	);


