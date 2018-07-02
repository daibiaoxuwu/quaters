实验5.5 串行密码锁
1 实验目的
(1)学习使用状态机控制电路,在不同状态下完成不同的功能.
(2)进一步掌握时序逻辑电路的基本分析和设计方法.
(3)学会利用软件进行仿真实现对数字电路的逻辑功能进行验证和分析.

2 实验任务
掌握时序逻辑电路的基本设计方法,理解状态机的工作原理,用硬件描述语言实现状态机程序来实现一个简单的应用.

3 实验要求
设计一个4位16进制密码锁,有设置密码和验证密码两种模式.每次设置密码时,按一下复位,然后将开关拨到一个状态并按clk键确定,输入一位;依次输入四位.验证密码时类似输入,输入为预设的密码或管理员密码时,都可以解锁.一旦输入错误,err灯亮起.连续输入三次错误后报警灯亮起,此时无法通过预设的密码解锁,只能通过管理员密码解锁.切换模式时,改变mode输入后,需要按一下rst重置.

4 实验代码
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all; 

ENTITY lock IS
    port (clk,rst: in std_logic;
          code:in std_logic_vector(3 downto 0);--输入密码
          mode:in std_logic_vector(1 downto 0);--模式
          err,unlock:out std_logic;--错误和正确灯
          pointerout:out std_logic_vector(1 downto 0);--显示输入到第几位,方便输入和调试
          lk3:out std_logic--报警灯
          
      );
end lock;

architecture arc of lock is
    signal savecode1:std_logic_vector(3 downto 0);--预设的密码
    signal savecode2:std_logic_vector(3 downto 0);
    signal savecode3:std_logic_vector(3 downto 0);
    signal savecode4:std_logic_vector(3 downto 0);
    signal mastcode1:std_logic_vector(3 downto 0):="0000";--管理员密码
    signal mastcode2:std_logic_vector(3 downto 0):="0000";
    signal mastcode3:std_logic_vector(3 downto 0):="0000";
    signal mastcode4:std_logic_vector(3 downto 0):="0000";
    type states is (st0,in0,in1,in2,in3,ck0,ck1,ck2,ck3);--状态机 st0:初始状态 in0~in3为设置1到4位密码时的状态,ck0到ck3是检验密码1到4位的状态.
    signal state:states;

    signal common,master:std_logic;--当前预设密码,管理员密码是否正确
    signal lkcount:integer range 4 downto 0:=0;--当前预设密码错误次数
    signal lk3c:std_logic:='0';--报警灯信号
    begin
        process (clk,rst)
        begin
            
        if(rst='0') then--重置灯
            unlock<='0';
            err<='0';
            master<='1';
            if(mode="01")  then
                state<=in0;--设置状态
            else
                state<=ck0;
            end if;
                
            if(lk3c='1')then--报警灯亮起,此时输入预设密码无效
                common<='0';
            else
                common<='1';
            end if;
            lkcount<=0;

        elsif(clk'event and clk='1') then
            case state is
                when in0=>
                unlock<='0';
                err<='0';
                savecode1(3 downto 0)<=code;--保存密码
                state<=in1;--设置状态
            when in1=>
                unlock<='0';
                err<='0';
                savecode2(3 downto 0)<=code;
                state<=in2;
            when in2=>
                unlock<='0';
                err<='0';
                savecode3(3 downto 0)<=code;
                state<=in3;
            when in3=>
                unlock<='0';
                err<='0';
                savecode4(3 downto 0)<=code;
                state<=st0;

            when ck0=>--输入密码状态
                if(not (savecode1=code) or common='0') then
                    if(master='0' or not(mastcode1=code)) then--用户密码,管理员密码均错误
                        state<=ck0;
                        unlock<='0';
                        err<='1';
                        if(lkcount=2) then
                            lk3c<='1';--报警
                        else
                            lkcount<=lkcount+1;--错误次数计数器加一
                        end if;
                        master<='1';
                        if(lk3c='1')then--归零后看报警情况
                            common<='0';
                        else
                            common<='1';
                        end if;
                    else--用户密码错误,管理员密码正确
                        state<=ck1;
                        common<='0';
                        unlock<='0';--记录
                        err<='0';
                    end if;
                elsif not(mastcode1=code) then--用户密码正确,管理员密码错误
                    state<=ck1;
                    master<='0';--记录
                    unlock<='0';
                    err<='0';
                else--均正确
                    state<=ck1;
                    unlock<='0';
                    err<='0';
                end if;
            when ck1=>--下面同理
                if(not (savecode2=code) or common='0') then
                    if(master='0' or not(mastcode2=code)) then
                        state<=st0;
                       
                        unlock<='0';
                        err<='1';
                        if(lkcount=2) then
                            lk3c<='1';
                        else
                            lkcount<=lkcount+1;
                        end if;
                        master<='1';
                        if(lk3c='1')then
                            common<='0';
                        else
                            common<='1';
                        end if;
                    else
                        state<=ck2;
                        common<='0';
                        unlock<='0';
                        err<='0';
                    end if;
                elsif not(mastcode2=code) then
                    state<=ck2;
                    master<='0';
                    unlock<='0';
                    err<='0';
                else
                    state<=ck2;
                    unlock<='0';
                    err<='0';
                end if;
            when ck2=>
                if(not (savecode3=code) or common='0') then
                    if(master='0' or not(mastcode3=code)) then
                        state<=st0;
                        unlock<='0';
                        err<='1';
                        if(lkcount=2) then
                            lk3c<='1';
                        else
                            lkcount<=lkcount+1;
                        end if;
                        master<='1';
                        if(lk3c='1')then
                            common<='0';
                        else
                            common<='1';
                        end if;
                    else
                        state<=ck3;
                        common<='0';
                        unlock<='0';
                        err<='0';
                    end if;
                elsif not(mastcode3=code) then
                    state<=ck3;
                    master<='0';
                    unlock<='0';
                    err<='0';
                else
                    state<=ck3;
                    unlock<='0';
                    err<='0';
                end if;
            when ck3=>--最后一位
                if(not (savecode4=code) or common='0') then
                    if(master='0' or not(mastcode4=code)) then--均错误
                        state<=st0;
                        unlock<='0';
                        err<='1';
                        if(lkcount=2) then
                            lk3c<='1';
                        else
                            lkcount<=lkcount+1;
                        end if;

                        master<='1';
                        if(lk3c='1')then
                            common<='0';
                        else
                            common<='1';
                        end if;
                    else--管理员密码正确
                        state<=st0;

                        unlock<='1';--亮灯
                        lkcount<=0;
                        lk3c<='0';--解警报
                        master<='1';
                        err<='0';
                    end if;
                elsif(master='0' or not(mastcode4=code)) then--管理员密码错误,用户密码正确
                    state<=st0;

                    unlock<='1';
                    lkcount<=0;--错误次数计数器归零
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                    err<='0';
                else--都正确
                    state<=st0;
                    unlock<='1';
                    lkcount<=0;--错误次数计数器归零
                    lk3c<='0';--解除警报
                    master<='1';
                    if(lk3c='1')then
                        common<='0';
                    else
                        common<='1';
                    end if;
                    err<='0';
                end if;
            when st0=>--初始状态,什么都不做
                unlock<='0';
                err<='0';
            end case;
        end if;
        if(state=ck0) then
            pointerout<="00";--输出辅助信息
        elsif (state=ck1) then
            pointerout<="01";
        else
            pointerout<="10";
        end if;
    end process;
    lk3<=lk3c;
    end arc;

5 实验小结
这次实验让我们学习了如何使用状态机控制电路,掌握了时序逻辑电路的基本分析和设计方法,并学会利用软件进行仿真实现对数字电路的逻辑功能进行验证和分析.在处理复杂问题时,状态机往往是一个清晰,易写的结构,虽然有时代码量会更多,但是能保证代码的清晰和状态的稳定.

