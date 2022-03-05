library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ORGANIGRAMA is
	port(			
		VALIDARE, PIN_CORECT, IESIRE_CONT, OP_1, OP_0, RETRAGERE_POSIBILA, DEPUNERE_POSIBILA:in std_logic:='0';
		STARE_CURENTA:inout std_logic_vector(4 downto 0);	 
		STARE_VIITOARE:inout std_logic_vector(4 downto 0);
		CLK: in std_logic;
		----------------------------------------------
		----------------------------------------------
		ENABLE_ALGORITM_RETRAGERE, ENABLE_ALGORITM_DEPUNERE:out std_logic;
		status_SOLD, status_RETRAGERE, SCHIMBA_PIN, status_DEPUNERE:out std_logic:='0';
		LED_SUCCES:out std_logic:='0';
		LED_RETRAGERE_SUCCES:out std_logic:='0';
		LED_FAIL:out std_logic:='0';
		LED_CHITANTA:out std_logic:='0'
		);
end entity;



architecture comportamentala of ORGANIGRAMA is
signal STARE: std_logic_vector(4 downto 0):="00000";
begin											   
	process	(CLK)
	begin							
		ENABLE_ALGORITM_RETRAGERE<='0';	
		ENABLE_ALGORITM_DEPUNERE<='0';
		status_SOLD<='0';
		status_RETRAGERE<='0';
		SCHIMBA_PIN<='0';
		status_DEPUNERE<='0';
		LED_SUCCES<='0';
		LED_RETRAGERE_SUCCES<='0';
		LED_FAIL<='0';
		LED_CHITANTA <= '0';
		
		if(CLK'event and CLK='1') then
		    STARE_CURENTA <= STARE_VIITOARE;
            if STARE_CURENTA = "0000" then
                if(VALIDARE = '0') then
                    STARE <= "00000";
                else
                    STARE <= "00001";
                end if;			   
                  
                  
            elsif STARE_CURENTA = "00001" then	 
                SCHIMBA_PIN<='0';
                if(PIN_CORECT = '0') then
                    STARE <= "00000";
                else
                    STARE <= "00010";
                end if;			 
                
                
            elsif STARE_CURENTA = "00010" then
                if(IESIRE_CONT = '1') then
                    STARE <= "00000";
                else
                    STARE <= "00011";
                end if;	  
                
                
            elsif STARE_CURENTA = "00011" then
                if(VALIDARE = '0') then
                    STARE <= "00010";
                else 
                    STARE <= "00100";
                end if;	
                
                
            elsif STARE_CURENTA = "00100" then
                if(OP_1 = '0') then
                    STARE <= "00101";
                else
                    STARE <= "00110";
                end if;
                
                
            elsif STARE_CURENTA = "00101" then
                if(OP_0 = '0') then
                    STARE <= "00111";
                else
                    STARE <= "01000";
                end if;	
                
                
            elsif STARE_CURENTA = "00110" then
                if(OP_0 = '0') then
                    STARE <= "01101";
                else				 
                    STARE <= "10001";
                end if;	
                
                
            elsif STARE_CURENTA = "00111" then
                status_SOLD <= '1';
                LED_SUCCES <= '1';
                LED_CHITANTA <= '1';
                if(VALIDARE = '0') then
                    STARE <= "00111";
                else				 
                    STARE <= "00010";
                end if;	
                
                
            elsif STARE_CURENTA = "01000" then
                ENABLE_ALGORITM_RETRAGERE <= '1';
                STARE <= "01001";
            elsif STARE_CURENTA = "01001" then
                if(RETRAGERE_POSIBILA = '0') then
                    STARE <= "01011";
                else
                    STARE <= "01010";
                end if;	  
                
                
            elsif STARE_CURENTA = "01010" then
                status_RETRAGERE <= '1';
                STARE <= "01100";
            elsif STARE_CURENTA = "01011" then
                LED_FAIL <= '1';
                if(VALIDARE = '0') then
                    STARE <= "01011";
                else
                    STARE <= "00010";
                end if;	
                
                
            elsif STARE_CURENTA = "01100" then 
                LED_RETRAGERE_SUCCES <= '1'; 
                LED_CHITANTA <= '1';
                if(VALIDARE = '0') then
                    STARE <= "01100";
                else
                    STARE <= "00010";
                end if;	
                
                
            elsif STARE_CURENTA = "01101" then
                ENABLE_ALGORITM_DEPUNERE <= '1';
                if(DEPUNERE_POSIBILA = '0') then
                    STARE <= "01111";
                else
                    STARE <= "01110";
                end if;	 
                
                
            elsif STARE_CURENTA = "01110" then
                status_DEPUNERE <= '1';
                STARE<="10000";	   
                
                
            elsif STARE_CURENTA = "01111" then
                LED_FAIL <= '1';
                if(VALIDARE = '0') then
                    STARE <= "01111";
                else
                    STARE <= "00010";
                end if;				 
                
                
            elsif STARE_CURENTA = "10000" then
                LED_SUCCES <= '1'; 
                LED_CHITANTA <= '1';
                if(VALIDARE = '0') then
                    STARE <= "10000";
                else
                    STARE <= "00010";
                end if;		   
                
                
            elsif STARE_CURENTA = "10001" then
                SCHIMBA_PIN <= '1';
                STARE <= "10010";	 
                
                
            elsif STARE_CURENTA = "10010" then
                LED_SUCCES <= '1';
                if(VALIDARE = '0') then
                    STARE <= "10010";
                else
                    STARE <= "00010";
                end if;
                
                
            end if;	
           
		    STARE_VIITOARE<=STARE; 
		 end if;
	end process;
end architecture;