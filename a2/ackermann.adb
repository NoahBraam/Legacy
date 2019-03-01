with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with stackadt; use stackadt;
procedure ackermann is
    ack, m, n: natural;
    startTime, endTime : Time;
    milliS : Duration;    
    procedure calcAckermann(ack: out natural; m,n: in natural) is
        pushType : natural range 1..4;
        tempN, tempM, done: natural;
    begin
    tempN:=n;
    tempM:=m;
        loop
            if tempM = 0 then
                ack:=tempN+1;
                loop
                    if stack_is_empty then
                        done:= 1;
                        exit;
                    else
                        pop(pushType);
                        pop(tempN);
                        pop(tempM);
                        case pushType is
                            when 1 =>
                                exit;
                            when 2 =>
                                null;
                            when 3 =>
                                push(tempM);
                                push(tempN);
                                push(4);
                                tempM:=tempM-1;
                                tempN:=ack;
                                exit;
                            when 4 => 
                                null;
                        end case;
                    end if;
                end loop;
                if done = 1 then
                    exit;
                end if;
            elsif tempN = 0 then
                push(tempM);
                push(tempN);
                push(2);
                tempM:=tempM-1;
                tempN:=1;
            else
                push(tempM);
                push(tempN);
                push(3);
                tempN:= tempN-1;
            end if;
        end loop;
    end calcAckermann;
begin
    put("enter a value for m: ");
    get(m);
    put("enter a value for n: ");
    get(n);
    startTime:= Clock;
    calcAckermann(ack, m, n);
    endTime:= Clock;
    milliS:= (endTime - startTime) * 1000;
    put("Ackermann is: ");
    put(ack, width=>1); new_line;
    put_line("Runtime = " & Duration'Image(milliS) & " milliseconds.");
end ackermann;

