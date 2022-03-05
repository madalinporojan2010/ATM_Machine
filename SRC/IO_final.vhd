library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;  

entity legare_IO is
	port(
	-------------------BUTOANE----------------------
	BTN_OK, BTN_INC, BTN_DEC, BTN_NEXT, BTN_PREV: in std_logic;

	
	-------------------SWITCH-URI-------------------
	SWT_EXIT, SWT_ADR0, SWT_ADR1, SWT_OP0, SWT_OP1, SWT_10, SWT_20, SWT_50, SWT_100: in std_logic;	 	
	
	CLOCK:in std_logic;
	RETRAGERE, DEPUNERE, SOLD: in std_logic;							 					
	R_IN0, R_IN1, R_IN2, R_IN3, R_IN4, R_IN5:in std_logic_vector(3 downto 0);
	D_IN0, D_IN1, D_IN2, D_IN3, D_IN4, D_IN5:in std_logic_vector(3 downto 0);
	SOLD0, SOLD1, SOLD2, SOLD3, SOLD4, SOLD5:in std_logic_vector(3 downto 0);
	IO_0, IO_1, IO_2, IO_3, IO_4, IO_5:out std_logic_vector(3 downto 0); 
	VALIDARE:out std_logic;	
	SELECTED: inout std_logic_vector(2 downto 0)
	);
end entity;

architecture comportamentala of legare_IO is 
component mem_IO is
	port(
	NEXT_ONE, PREV_ONE, INC, DEC, LOAD, RESET, CONFIRM:in std_logic;   
	CLK:in std_logic;
	SELECTED:inout std_logic_vector(2 downto 0);
	VALIDARE:out std_logic;			
	DATA0, DATA1, DATA2, DATA3, DATA4, DATA5:in std_logic_vector(3 downto 0);
	A0, A1, A2, A3, A4, A5:out std_logic_vector(3 downto 0)
	);
end component;	

component SUME_PREDEFINITE is
	port(		
	SWT_X:in std_logic_vector(3 downto 0);
	IO_LOAD_ENABLE: out std_logic;
	IO_0, IO_1, IO_2, IO_3, IO_4, IO_5: out std_logic_vector(3 downto 0):="0000"
	);
end component;
signal SWT_X: std_logic_vector(3 downto 0);			
signal IO_LOAD_ENABLE: std_logic;
signal D0, D1, D2, D3, D4, D5: std_logic_vector(3 downto 0);
signal PREDEF0,PREDEF1,PREDEF2,PREDEF3,PREDEF4,PREDEF5: std_logic_vector(3 downto 0);	
signal LOAD0, LOAD1, LOAD2, LOAD3, LOAD4, LOAD5: std_logic_vector(3 downto 0);
signal LOAD: std_logic:='0';
begin
	SWT_X <= SWT_100 & SWT_50 & SWT_20 & SWT_10;
	
	PREDEF: SUME_PREDEFINITE port map(SWT_X=>SWT_X, IO_LOAD_ENABLE=>IO_LOAD_ENABLE, IO_0=>PREDEF0, IO_1=>PREDEF1, IO_2=>PREDEF2, IO_3=>PREDEF3, IO_4=>PREDEF4, IO_5=>PREDEF5);
	DATE_IN: mem_IO port map(CLK=>CLOCK, DATA0=>LOAD0, DATA1=>LOAD1, DATA2=>LOAD2, DATA3=>LOAD3, DATA4=>LOAD4, DATA5=>LOAD5,
	NEXT_ONE=>BTN_NEXT, PREV_ONE=>BTN_PREV, INC=>BTN_INC, DEC=>BTN_DEC, LOAD=>LOAD, RESET=>'0', CONFIRM=>BTN_OK, SELECTED=>SELECTED, VALIDARE=>VALIDARE, 
	A0=>IO_0, A1=>IO_1, A2=>IO_2, A3=>IO_3, A4=>IO_4, A5=>IO_5);
	
	
	process(LOAD, IO_LOAD_ENABLE, DEPUNERE, RETRAGERE, SOLD, LOAD0, LOAD1, LOAD2, LOAD3, LOAD4, LOAD5, PREDEF0, PREDEF1 , PREDEF2, PREDEF3, PREDEF4, PREDEF5,
	D_IN0, D_IN1, D_IN2, D_IN3, D_IN4, D_IN5, R_IN0, R_IN1, R_IN2, R_IN3, R_IN4, R_IN5, SOLD0, SOLD1, SOLD2, SOLD3, SOLD4, SOLD5)
	begin 
		LOAD<='0';
		if(IO_LOAD_ENABLE = '1' and DEPUNERE = '0' and RETRAGERE = '0') then 
			LOAD0 <= PREDEF0;
			LOAD1 <= PREDEF1;
			LOAD2 <= PREDEF2;
			LOAD3 <= PREDEF3;
			LOAD4 <= PREDEF4;
			LOAD5 <= PREDEF5;
			LOAD <= '1';
		elsif(DEPUNERE = '1') then 
			LOAD0 <= D_IN0;
			LOAD1 <= D_IN1;
			LOAD2 <= D_IN2;
			LOAD3 <= D_IN3;
			LOAD4 <= D_IN4;
			LOAD5 <= D_IN5; 
			LOAD <= '1';
		elsif(RETRAGERE = '1') then
			LOAD0 <= R_IN0;
			LOAD1 <= R_IN1;
			LOAD2 <= R_IN2;
			LOAD3 <= R_IN3;
			LOAD4 <= R_IN4;
			LOAD5 <= R_IN5;
			LOAD <= '1';
		elsif(SOLD = '1') then
			LOAD0 <= SOLD0;
			LOAD1 <= SOLD1;
			LOAD2 <= SOLD2;
			LOAD3 <= SOLD3;
			LOAD4 <= SOLD4;
			LOAD5 <= SOLD5;
			LOAD <= '1';
		else
			LOAD0 <= x"0";
			LOAD1 <= x"0";
			LOAD2 <= x"0";
			LOAD3 <= x"0";
			LOAD4 <= x"0";
			LOAD5 <= x"0";
			LOAD <= '0';
		end if;
	end process;
	


end architecture;
