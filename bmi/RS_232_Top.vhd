library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity RS_232_Top is
    Port (
			Clock					: in  	STD_LOGIC;
			Motors  				: out   	unsigned    (3 downto 0);
			GPIO_Input_Pin  	: in    	unsigned    (3 downto 0);
			Rx						: in  	STD_LOGIC;
			Tx						: out  	STD_LOGIC;
			LED					: out		STD_LOGIC);
end RS_232_Top;

architecture Behavioral of RS_232_Top is

	signal	Rx_Valid			:	STD_LOGIC					:=	'0';
	signal	Send_Comm			:	STD_LOGIC					:=	'0';
	signal	Rx_Data				:	unsigned	(7 downto 0)	:=	(others=>'0');
	signal	Tx_Data_In			:	unsigned	(7 downto 0)	:=	(others=>'0');
	signal	LED_Delay_Counter	:	unsigned	(25 downto 0)	:=	(others=>'0');
	
	signal	GPIO_Input_Pin_State	:	unsigned	(7 downto 0)	:=	(others=>'0');
	
	constant	f		:	unsigned	(7 downto 0)	:=	to_unsigned(102,8);
	constant	l		:	unsigned	(7 downto 0)	:=	to_unsigned(108,8);
	constant	b		:	unsigned	(7 downto 0)	:=	to_unsigned(98,8);
	constant	r		:	unsigned	(7 downto 0)	:=	to_unsigned(114,8);
	constant	o		:	unsigned	(7 downto 0)	:=	to_unsigned(111,8);
	
begin

	Inst_RS_232_Tx: entity work.RS_232_Tx
	Port map(
				Clock 		=> Clock,
				Data_In		=> Tx_Data_In,
				Send		=> Send_Comm,
				Busy		=> open,
				Serial_Out	=> Tx
				);
				
				
	Inst_RS_232_Rx: entity work.RS_232_Rx
	Port map(
				Clock 		=> Clock,
				Data_Out	=> Rx_Data,
				Valid		=> Rx_Valid,
				Serial_In	=> Rx
				);			

	LED		<=		LED_Delay_Counter(25);

	process(Clock)
	begin
	
		if rising_edge(Clock) then
                LED_Delay_Counter    <=    LED_Delay_Counter + 1;
                Send_Comm <= '0'; 
				
                
                if(Rx_Valid = '1') then
				
					if(GPIO_Input_Pin(0) = '1') then
						GPIO_Input_Pin_State(0) <= '1';
					else
						GPIO_Input_Pin_State(0) <= '0';
					end if;
					
					if(GPIO_Input_Pin(1) = '1') then
						GPIO_Input_Pin_State(1) <= '1';
					else
						GPIO_Input_Pin_State(1) <= '0';
					end if;
					
					if(GPIO_Input_Pin(2) = '1') then
						GPIO_Input_Pin_State(2) <= '1';
					else
						GPIO_Input_Pin_State(2) <= '0';
					end if;
					
					if(GPIO_Input_Pin(3) = '1') then
						GPIO_Input_Pin_State(3) <= '1';
					else
						GPIO_Input_Pin_State(3) <= '0';
					end if;
					
					Tx_Data_In 	<=	GPIO_Input_Pin_State;
					Send_Comm	<=	'1';
				
				
                    case Rx_Data is
                        when f =>
                            Motors <= "0001";
                            
                        when l =>
                            Motors <= "0010";
                                 
                        when b =>
                            Motors <= "0100";
                           
                        when r =>
                            Motors <= "1000";
                           
                        when o =>
                            Motors <= "0000";
                           
                        when others =>
                            
                    end case;
                                        
                end if;
                
            end if;
	
	end process;

end Behavioral;