library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_locn is
port(
inst : in std_logic_vector(15 downto 0);
reset : in std_logic;
clk : in std_logic;
output : out std_logic_vector(2 downto 0);
opcode: in std_logic_vector(3 downto 0)

);
end MUX_locn;
architecture bhv_mux_locn of MUX_locn is 
begin
mux_proc_locn: process(reset,clk,opcode,inst)
begin
if reset='0' then
if clk='1' and clk'event then
if opcode = "0000" or opcode = "0010" or opcode = "0011" or opcode = "0100" or opcode = "0101" or opcode = "0110" then
output<=inst(5 downto 3);
elsif opcode = "0001" then
output<=inst(8 downto 6);
elsif opcode(3) = '1' then
output<=inst(11 downto 9);
end if;
end if;
end if;
end process;
end bhv_mux_locn;