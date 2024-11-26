-- UpDownCounter_tb.vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UpDownCounter_tb is
end UpDownCounter_tb;

architecture Behavioral of UpDownCounter_tb is

    -- �]�m�H���Ӽ��� UpDownCounter ����J�P��X
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal up_down : STD_LOGIC := '1'; -- ��l�]�m���W��
    signal count : STD_LOGIC_VECTOR (3 downto 0);

    -- �ޥγQ���Ҳ�
    component UpDownCounter
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            up_down : in STD_LOGIC;
            count : out STD_LOGIC_VECTOR (3 downto 0)
        );
    end component;

begin
    -- ��ҤƳQ���Ҳ�
    uut: UpDownCounter Port map (
        clk=>clk,
        reset=>reset,
        up_down=>up_down,
        count=>count
    );

    -- �����L�{�A�C 10 ns �����@�������A���� 100 MHz ����
    clk_process :process
    begin
        clk<='0';
        wait for 10 ns;
        clk<='1';
        wait for 10 ns;
    end process;

    -- ���չL�{
    stim_proc: process
    begin
        -- ���]�p�ƾ�
        reset<='1';
        wait for 20 ns;
        reset<='0';

        -- ���դW�ƥ\��
        up_down<='1';
        wait for 200 ns; -- ���ݤ@�q�ɶ��[��p���ܤ�

        -- ���դU�ƥ\��
        up_down<='0';
        wait for 100 ns; -- ���ݤ@�q�ɶ��[��p���ܤ�
        -- ��������
        wait;
    end process;

end Behavioral;
