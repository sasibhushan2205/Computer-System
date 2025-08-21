library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_pc is
port(
temp1 : in std_logic_vector(15 downto 0);
ALU_TW : in std_logic_vector(15 downto 0);
T2 : in std_logic_vector(15 downto 0);
T3 : in std_logic_vector(15 downto 0);
reset : in std_logic;
clk : in std_logic;
output : out std_logic_vector(15 downto 0);
opcode: in std_logic_vector(3 downto 0)
);
end MUX_pc;
architecture bhv_mux_pc of MUX_pc is 
begin
mux_proc_pc: process(clk,reset)
begin
if clk='1' and clk'event then
if reset='1' then
output<="0000000000000000";
elsif opcode="1100" and T3="0000000000000001" then
output<=ALU_TW;
elsif opcode="1101" then
output<=ALU_TW;
elsif opcode="1111" then
output<=T2;
else
output<=temp1;
end if;
end if;
end process;
end bhv_mux_pc;