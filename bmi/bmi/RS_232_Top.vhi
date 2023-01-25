
-- VHDL Instantiation Created from source file RS_232_Top.vhd -- 16:26:45 01/24/2023
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RS_232_Top
	PORT(
		Clock : IN std_logic;
		GPIO_Input_Pin : IN std_logic_vector(3 downto 0);
		Rx : IN std_logic;          
		Motors : OUT std_logic_vector(3 downto 0);
		Tx : OUT std_logic;
		LED : OUT std_logic
		);
	END COMPONENT;

	Inst_RS_232_Top: RS_232_Top PORT MAP(
		Clock => ,
		Motors => ,
		GPIO_Input_Pin => ,
		Rx => ,
		Tx => ,
		LED => 
	);


