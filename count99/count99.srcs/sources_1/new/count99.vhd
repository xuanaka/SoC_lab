library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Dual4DigitCounter is
    Port (
        clk        : in  STD_LOGIC;                      -- �����T��
        reset      : in  STD_LOGIC;                      -- ���m�T��
        enable1    : in  STD_LOGIC;                      -- �Ĥ@�p�ƾ��ҰʰT��
        enable2    : in  STD_LOGIC;                      -- �ĤG�p�ƾ��ҰʰT��
        up1        : in  STD_LOGIC;                      -- �Ĥ@�p�ƾ���V�A�����[�A�C����
        up2        : in  STD_LOGIC;                      -- �ĤG�p�ƾ���V�A�����[�A�C����
        start1     : in  INTEGER range 0 to 9999;        -- �Ĥ@�p�ƾ��_�l��
        end_val1   : in  INTEGER range 0 to 9999;        -- �Ĥ@�p�ƾ�������
        start2     : in  INTEGER range 0 to 9999;        -- �ĤG�p�ƾ��_�l��
        end_val2   : in  INTEGER range 0 to 9999;        -- �ĤG�p�ƾ�������
        count1     : out INTEGER range 0 to 9999;        -- �Ĥ@�p�ƾ���e��
        count2     : out INTEGER range 0 to 9999         -- �ĤG�p�ƾ���e��
    );
end Dual4DigitCounter;

architecture Behavioral of Dual4DigitCounter is
    signal current_count1 : INTEGER range 0 to 9999; -- �Ĥ@�p�ƾ�������
    signal current_count2 : INTEGER range 0 to 9999; -- �ĤG�p�ƾ�������
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- ���m��ӭp�ƾ����U�۪��_�l��
            current_count1 <= start1;
            current_count2 <= start2;
        elsif rising_edge(clk) then
            -- �Ĥ@�p�ƾ��޿�
            if enable1 = '1' then
                if up1 = '1' then
                    if current_count1 + 1 > end_val1 then
                        current_count1 <= start1; -- �^��_�l��
                    else
                        current_count1 <= current_count1 + 1;
                    end if;
                else
                    if current_count1 - 1 < start1 then
                        current_count1 <= end_val1; -- �^�쵲����
                    else
                        current_count1 <= current_count1 - 1;
                    end if;
                end if;
            end if;

            -- �ĤG�p�ƾ��޿�
            if enable2 = '1' then
                if up2 = '1' then
                    if current_count2 + 1 > end_val2 then
                        current_count2 <= start2; -- �^��_�l��
                    else
                        current_count2 <= current_count2 + 1;
                    end if;
                else
                    if current_count2 - 1 < start2 then
                        current_count2 <= end_val2; -- �^�쵲����
                    else
                        current_count2 <= current_count2 - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

    -- ��X�p�ƭ�
    count1 <= current_count1;
    count2 <= current_count2;
end Behavioral;
