library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity MEM_INS is
port(
read_en : in std_logic;
addr : in std_logic_vector(15 downto 0);
clk : in std_logic;
reset: in std_logic;
out_val : out std_logic_vector(15 downto 0)
);
end MEM_INS;
architecture bhav_ins of MEM_INS is
type MemoryArray is array (0 to 8191) of STD_LOGIC_VECTOR(7 downto 0);
    signal memory : MemoryArray;
begin
    mem_ins : process(clk,reset)
    begin

        if clk='1' and clk'event then
		  if reset='1' then
				memory(0) <= "10100000";
				memory(1)<="10000000";  
				memory(2) <= "10100100";
				memory(3)<="00000000";
				memory(4)<="00000100";
				memory(5)<="00011000";
				memory(6)<="10110110";
				memory(7)<="00000001";
				for i in 7 to 255 loop
				memory(i) <= (others => '0');
				end loop;
				elsif read_en = '1' then
					out_val <= memory(to_integer(unsigned(addr))+1)&memory(to_integer(unsigned(addr)));
				end if;
        end if;
		  
    end process;
end bhav_ins;