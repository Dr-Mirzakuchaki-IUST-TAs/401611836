
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity Top is
port(
		clock   : in std_logic ;
		uart_Rx : IN std_logic; 
		uart_Tx : OUT std_logic;
		LED     : Buffer std_logic;
		spi_miso: IN std_logic;
		spi_mosi: OUT std_logic;
		spi_sck : OUT std_logic;
		spi_ss : OUT std_logic
		);

end Top;

architecture MBehavioral of Top is

signal 	t_en_o : std_logic;
signal 	t_en_i : std_logic;
signal 	spi_busy : std_logic;
signal 	data_i : unsigned(15 downto 0);
signal 	data_i1 : unsigned(15 downto 0);   
signal 	data_i2 : unsigned(15 downto 0);      
signal 	data_o : unsigned(15 downto 0);
signal	Rx_Valid			   : 	STD_LOGIC					:=	'0';
signal	Send_Comm			:	STD_LOGIC					:=	'0';
signal	Rx_Data				:	unsigned	(7 downto 0)	;
signal	Tx_Data_In			:	unsigned(7 downto 0)	;
signal	delay_seting		:	unsigned(15 downto 0)	:=X"1388";
signal	delay_led    		:	unsigned(27 downto 0)	:=X"0F40240";
signal	delay_read			:	unsigned(15 downto 0)	:=X"186A";
signal	LED_Delay_Counter	:	unsigned	(25 downto 0)	:=	(others=>'0');
signal 	gyro_out_started_flag:std_logic := '0';
signal state:integer range 0 to 10;
signal Read_state:integer range 0 to 5;
signal en1,en2 :std_logic ;

-------------------------------------------------------------------	
COMPONENT spi_master PORT(
		miso 		: IN std_logic;
		clk 		: IN std_logic;
		en_i 		: IN std_logic;
		data_i 	: IN unsigned(15 downto 0);          
		mosi 		: OUT std_logic;
		sck 		: OUT std_logic;
		ss 		: OUT std_logic;
		data_o 	: OUT unsigned(15 downto 0);
		en_o 		: OUT std_logic;
		busy 		: OUT std_logic
		);
	END COMPONENT;

-------------------------------------------------------------------	
	COMPONENT RS_232_Tx
	PORT(
		Clock 		: IN std_logic;
		Data_In		: in  	unsigned	(7 downto 0);
		Send 			: IN std_logic;          
		Busy 			: OUT std_logic;
		Serial_Out 	: OUT std_logic
		);
	END COMPONENT;
-------------------------------------------------------------------

	COMPONENT RS_232_Rx
	PORT(
		Clock 		: IN std_logic;
		Serial_In 	: IN std_logic;          
		Data_Out 	: OUT unsigned(7 downto 0);
		Valid 		: OUT std_logic
		);
	END COMPONENT;
-------------------------------------------------------------------
begin
-------------------------------------------------------------------
	Inst_spi_master: spi_master PORT MAP(
		miso =>spi_miso ,
		mosi =>spi_mosi ,
		sck => spi_sck,
		ss => spi_ss,
		clk => clock,
		data_o => data_o,
		en_o => t_en_o,
		busy => spi_busy,
		en_i => t_en_i,
		data_i => data_i
	);

-------------------------------------------------------------------		
	Inst_RS_232_Tx: RS_232_Tx PORT MAP(
		Clock =>clock ,
		Data_In => Tx_Data_In,
		Send => Send_Comm,
		Busy => open,
		Serial_Out => uart_Tx
	);
-------------------------------------------------------------------
	Inst_RS_232_Rx: RS_232_Rx PORT MAP(
		Clock => clock,
		Data_Out => Rx_Data,
		Valid => open,
		Serial_In => uart_Rx
	);
	
	--LED		<=		LED_Delay_Counter(25);

	
---------------------------------------------------------------------------------------------------	
	
	process(Clock)
	begin
		if rising_edge(Clock) then
		  delay_seting <= delay_seting -1 ;
		  if(delay_seting = 0)then--????? ?????? ?? 800???? ?? ???? ?? ??? ????? ?? 1600???? 
				case read_state is
				when 0 =>
							Send_Comm <=	'0';
							if(spi_busy = '0' and gyro_out_started_flag = '0') then
								data_i 	<=	X"8C00";-- ?????? ???? XH
								 t_en_i	<=	'1';
								gyro_out_started_flag <= '1';
							end if;
							if(t_en_o = '1' and gyro_out_started_flag='1') then
							Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
							 t_en_i	<=	'0';
							Send_Comm	<=	'1';
							end if;
					
							state<= 1;
				when 1 =>
							Send_Comm <=	'0';
							if(spi_busy = '0' and gyro_out_started_flag = '0') then
								data_i 	<=	X"8D00";-- ?????? ???? Xl
								 t_en_i	<=	'1';
								gyro_out_started_flag <= '1';
							end if;
							if(t_en_o = '1' and gyro_out_started_flag='1') then
							Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
							t_en_i	<=	'0';
							Send_Comm	<=	'1';
							end if;
							state<= 2;
				when 2 =>
						Send_Comm <=	'0';
						if(spi_busy = '0' and gyro_out_started_flag = '0') then
							data_i 	<=	X"8E00";-- ?????? ???? YH
							 t_en_i	<=	'1';
							gyro_out_started_flag <= '1';
						end if;
						if(t_en_o = '1' and gyro_out_started_flag='1') then
						Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
						 t_en_i	<=	'0';
						Send_Comm	<=	'1';
						end if;
						state<= 3;
						
				when 3 =>
						Send_Comm <=	'0';
						if(spi_busy = '0' and gyro_out_started_flag = '0') then
							data_i 	<=	X"8F00";-- ?????? ???? YL
							 t_en_i	<=	'1';
							gyro_out_started_flag <= '1';
						end if;
						if(t_en_o = '1' and gyro_out_started_flag='1') then
						Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
						 t_en_i	<=	'0';
						Send_Comm	<=	'1';
						end if;
						state<= 4;		
				
					when 4 =>
						Send_Comm <=	'0';
						if(spi_busy = '0' and gyro_out_started_flag = '0') then
							data_i 	<=	X"9000";-- ?????? ???? ZH
							 t_en_i	<=	'1';
							gyro_out_started_flag <= '1';
						end if;
						if(t_en_o = '1' and gyro_out_started_flag='1') then
						Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
						 t_en_i	<=	'0';
						Send_Comm	<=	'1';
						end if;
						state<=5;
					when 5 =>
						Send_Comm <=	'0';
						if(spi_busy = '0' and gyro_out_started_flag = '0') then
							data_i 	<=	X"9100";-- ?????? ???? ZL
							 t_en_i	<=	'1';
							gyro_out_started_flag <= '1';
						end if;
						if(t_en_o = '1' and gyro_out_started_flag='1') then
						Tx_Data_In 	<=	data_o(15 downto 8);--????? ???? ?? ?????
						 t_en_i	<=	'0';
						Send_Comm	<=	'1';
						end if;
						state<=0;			
				end case;
			
			delay_seting <= X"186A";
		end if ;		
		end if;
	end process;
	
	process(Clock)
	begin
		if rising_edge(Clock) then
			delay_led <= delay_led-1 ;
			if(delay_led = 0)then
				LED <= not(LED);
				delay_led<= X"0F40240";
			end if ;
		end if ;
	end process;

	
end MBehavioral;




