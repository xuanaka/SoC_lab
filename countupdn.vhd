library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity countupdn is
    Port (
        i_clk      : in  STD_LOGIC;
        i_rst      : in  STD_LOGIC;
        i_counter1 : in  std_logic_vector(3 downto 0);
        i_counter2 : in  std_logic_vector(3 downto 0);
        o_counter1 : out std_logic_vector(3 downto 0);
        o_counter2 : out std_logic_vector(3 downto 0)
    );
end countupdn;

architecture Behavioral of countupdn is
    signal count1  : unsigned(3 downto 0) := (others => '0');
    signal count2  : unsigned(3 downto 0) := (others => '0');
    signal tmp : unsigned(25 downto 0) := (others => '0');
    signal div_clk: std_logic;
begin
    -- Clock divider process
   process (i_clk, i_rst)
    begin
        if i_rst = '1' then
            tmp <= (others => '0');
        elsif rising_edge(i_clk) then
            tmp <= tmp + 1;
        end if;
end process;
    div_clk <= tmp(25);
    

    -- Counter 1 process
    process(div_clk, i_rst)
    begin
        if i_rst = '1' then
            count1 <= (others => '0');
        elsif rising_edge(i_clk) then
            
                if count1 < unsigned(i_counter1) then
                    count1 <= count1 + 1;
                else
                    count1 <= (others => '0');
                end if;
            end if;
        
    end process;

    -- Counter 2 process
    process(div_clk, i_rst)
    begin
        if i_rst = '1' then
            count2 <= (others => '0');
        elsif rising_edge(div_clk)then 
            
                if count2 < unsigned(i_counter2) then
                    count2 <= count2 + 1;
                else
                    count2 <= (others => '0');
                end if;
            end if;
        
    end process;

    -- Output assignments
    o_counter1 <= std_logic_vector(count1);
    o_counter2 <= std_logic_vector(count2);

end Behavioral;
