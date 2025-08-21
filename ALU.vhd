library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ALU is
port(
input_val1 : in std_logic_vector(15 downto 0);
input_val2 : in std_logic_vector(15 downto 0);
opcode : in std_logic_vector(3 downto 0);
reset : in std_logic;
clk : in std_logic;
out_val : out std_logic_vector(15 downto 0)
);
end ALU;
architecture bhav of ALU is

begin
cpu_process : process (input_val1,input_val2,opcode,reset)
begin
if reset='0' then
if opcode="0000" or opcode="0001" or opcode="1010" or opcode="1011" or opcode="1101" then
out_val <= std_logic_vector(unsigned(input_val1) + unsigned(input_val2));
elsif opcode="0010" then
out_val <= std_logic_vector(unsigned(input_val1) - unsigned(input_val2));

elsif opcode="0011" then 
out_val <= std_logic_vector(resize(unsigned(input_val1(3 downto 0)) * unsigned(input_val2(3 downto 0)),16));

elsif opcode="0100" then 
out_val<=input_val1 and input_val2;
elsif opcode="0101" then 
out_val<=input_val1 or input_val2;
elsif opcode="0110" then 
        for i in 0 to 15 loop
            if input_val1(i) = '1' then
                out_val(i) <= input_val2(i);
            else
                out_val(i) <= '1'; 
            end if;
        end loop;
elsif opcode="1000" then 
out_val<=input_val1(7 downto 0)&'0'&'0'&'0'&'0'&'0'&'0'&'0'&'0';
elsif opcode="1001" then
out_val<='0'&'0'&'0'&'0'&'0'&'0'&'0'&'0'&input_val1(7 downto 0);
elsif opcode ="1100" then 	 
if(input_val1=input_val2) then
out_val<="0000000000000001";
else
out_val<="0000000000000000";
end if;	
end if; 
end if;
end process;
end bhav;