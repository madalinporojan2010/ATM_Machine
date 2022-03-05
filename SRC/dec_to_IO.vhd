 library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dec_to_IO is
	port(
	ZECIMAL:in std_logic_vector(15 downto 0); 
	N5,N4,N3,N2,N1,N0: out std_logic_Vector(3 downto 0)	   
	);
end entity;	

architecture comportamentala of dec_to_IO is	
begin			 
	process(ZECIMAL)	 
	variable cat:natural range 0 to 999999;		 
	begin					  
		cat:=conv_integer(ZECIMAL);
		N3<=conv_std_logic_vector(cat rem 10,N3'length); 
		
		cat:=cat/10;
		N2<=conv_std_logic_vector(cat rem 10,N2'length);  
		
		cat:=cat/10;
		N1<=conv_std_logic_vector(cat rem 10,N1'length);  
		
		cat:=cat/10;
		N0<=conv_std_logic_vector(cat rem 10,N0'length);
	end process;		   
end architecture;