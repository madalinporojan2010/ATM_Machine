library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity SUME_PREDEFINITE is
	port(		
	SWT_X:in std_logic_vector(3 downto 0);
	IO_LOAD_ENABLE: out std_logic;
	IO_0, IO_1, IO_2, IO_3, IO_4, IO_5: out std_logic_vector(3 downto 0):="0000"
	);
end entity;


architecture comportamentala of SUME_PREDEFINITE is
begin													   
	IO_LOAD_ENABLE<= SWT_X(0) or SWT_X(1) or SWT_X(2) or SWT_X(3);
	process(SWT_X)
	begin			   	  
		IO_0 <= "0000";
		IO_1 <= "0000";
		IO_2 <= "0000";
		IO_3 <= "0000";	  
		if(SWT_X = "001") then
			IO_1 <= "0001"; 
		elsif(SWT_X = "0010") then
			IO_1 <= "0010";
		elsif(SWT_X = "0100") then
			IO_1 <= "0101";
		elsif(SWT_X = "1000") then
			IO_2 <= "0001";	  
		end if;	
	end process;
end architecture;