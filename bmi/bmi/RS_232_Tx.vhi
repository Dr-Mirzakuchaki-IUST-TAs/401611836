
-- VHDL Instantiation Created from source file RS_232_Tx.vhd -- 17:07:37 01/24/2023
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RS_232_Tx
	PORT(
		Clock : IN std_logic;
		Data_In : IN std_logic_vector(7 downto 0);
		Send : IN std_logic;          
		Busy : OUT std_logic;
		Serial_Out : OUT std_logic
		);
	END COMPONENT;

	Inst_RS_232_Tx: RS_232_Tx PORT MAP(
		Clock => ,
		Data_In => ,
		Send => ,
		Busy => ,
		Serial_Out => 
	);


