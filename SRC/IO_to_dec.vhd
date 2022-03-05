library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity IO_to_dec is
	port(
	N0,N1,N2,N3,N4,N5:in std_logic_vector(3 downto 0);
	ZECIMAL:out std_logic_vector(15 downto 0)
	);
end entity;


architecture comportamentala of IO_to_dec is
begin			 
	process(N0,N1,N2,N3,N4,N5)
	variable cu,cz,cs,cm,cum,czm:integer range 0 to 15;
	begin	
		cu:=conv_integer(N0);
		cz:=conv_integer(N1);	  
		cs:=conv_integer(N2);
		cm:=conv_integer(N3);	
		cum:=conv_integer(N4);
		czm:=conv_integer(N5);
		ZECIMAL<=conv_std_logic_vector(cu+cz*10+cs*100+cm*1000+cum*10000+czm*100000,ZECIMAL'length);
	end process;
end architecture;