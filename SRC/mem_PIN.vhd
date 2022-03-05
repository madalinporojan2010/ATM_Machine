library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity mem_PIN is
	port(	 
	CLK:in std_logic;
	WE: in std_logic;
	IN_ADR: in std_logic_vector(1 downto 0);	 
	CS: in std_logic;
	IN_PIN:in std_logic_vector(15 downto 0);
	PIN_CORECT: out std_logic
	);
end entity;


architecture comportamentala of mem_PIN is
type MEMORIE is array(0 to 3) of std_logic_vector(15 downto 0);
signal S: MEMORIE :=("0010000100111101","0010000111111101","0010110100111101","1111000100111101");
begin
	process(CS,CLK)
	begin		
		if(CS='1') then
			if(CLK'event and CLK='1') then
				
				if(WE='1') then  
					if IN_ADR = "00" then S(0)<=IN_PIN;	   	
					elsif IN_ADR = "01" then S(1)<=IN_PIN;
					elsif IN_ADR = "10" then S(2)<=IN_PIN;
					elsif IN_ADR = "11" then S(3)<=IN_PIN;	
					end if;	
				end if;	
				if S(conv_integer(IN_ADR)) = IN_PIN then
					PIN_CORECT<='1';
				else
					PIN_CORECT<='0';
				end if;
			end if;
		end if;
	end process;
	
end architecture;