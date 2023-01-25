
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi_master is
    generic
	 (
		constant timing_spi:integer:=1000;--1000ns
		constant period:integer:=10--20ns
	 );
	 Port ( miso 	: in  STD_LOGIC;
           mosi 	: out  STD_LOGIC;
           sck 	: out  STD_LOGIC;
           ss 		: out  STD_LOGIC;
           clk 	: in  STD_LOGIC;
           data_o : out  unsigned (15 downto 0);
           en_o 	: out  STD_LOGIC;
           busy 	: out  STD_LOGIC;
           en_i 	: in  STD_LOGIC;
           data_i : in  unsigned (15 downto 0));
end spi_master;

architecture Behavioral of spi_master is
signal state:integer range 0 to 6;
signal i:integer range 0 to 15;
signal cnt_1us:integer range 0 to (timing_spi/period)-1;
signal sdata:unsigned (15 downto 0);
signal sdata_i:unsigned (15 downto 0);
begin

process(clk)
	begin
	if(rising_edge(clk))then
		cnt_1us<=cnt_1us+1;
		en_o<='0';
		case state is
			when 0=>--idle
				sck<='0';
				--
				busy<='0';
				if(en_i='1')then
					busy<='1';
					sdata<=data_i;
					state<=1;
					cnt_1us<=0;
				end if;
			when 1=>--pre send
				ss<='0';
				if(cnt_1us=((timing_spi/period)-1))then
					cnt_1us<=0;
					state<=2;
				end if;
			when 2=>
				sck<='1';
				sdata_i<=sdata_i(14 downto 0)&MISO;
				cnt_1us<=0;
				state<=3;
			when 3=>
				if(cnt_1us=(((timing_spi/period)/2)-1))then
					cnt_1us<=0;
					state<=4;
				end if;
			when 4=>
				sck<='0';
				sdata<=sdata(14 downto 0)&'0';
				cnt_1us<=0;
				state<=5;
			when 5=>
				if(cnt_1us=(((timing_spi/period)/2)-1))then
					cnt_1us<=0;
					i<=i+1;
					if(i>14)then
										
					ss<='1';

						state<=6;
						i<=0;
					else
						state<=2;
					end if;
				end if;
			when 6=>
				
				data_o<=sdata_i;
				en_o<='1';
				state<=0;
		end case;
	end if;
end process;
MOSI<=sdata(15);
end Behavioral;

