-- !========================================================
-- ! Noah Braam
-- ! 0960202
-- ! March 1st, 2019
-- ! 
-- ! This program implements a non-recursive version
-- ! of Ackermanns' function. It uses a stack ADT
-- ! in order to succeed this goal.
-- !========================================================

with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Calendar; use Ada.Calendar;
with stackadt; use stackadt;
procedure ackermann is
    ack, m, n: natural;
    startTime, endTime : Time;
    seconds : Duration;    
    procedure calcAckermann(ack: out natural; m,n: in natural) is
        pushType : natural range 1..4;
        tempN, tempM, done: natural;
    begin
    -- Temp variables for the function
    tempN:=n;
    tempM:=m;
        loop
            if tempM = 0 then -- ack = n+1 when m = 0
                ack:=tempN+1;
                loop -- Loop to empty stack 
                    if stack_is_empty then 
                        done:= 1;   -- Stack is empty, done program.
                        exit;
                    else
                        pop(pushType);
                        pop(tempN);
                        pop(tempM);
                        case pushType is  -- Empty stack and do appropriate calculations.
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
                if done = 1 then  -- Function is complete, exit loop
                    exit;
                end if;
            elsif tempN = 0 then  -- When n=0, m = m-1 and n = 1
                push(tempM);
                push(tempN);
                push(2);
                tempM:=tempM-1;
                tempN:=1;
            else                  -- n = n-1
                push(tempM);
                push(tempN);
                push(3);
                tempN:= tempN-1;
            end if;
        end loop;
    end calcAckermann;
begin
    -- get values for m and n
    put("enter a value for m: ");
    get(m);
    put("enter a value for n: ");
    get(n);
    -- start timer
    startTime:= Clock;
    -- calculate Ackermann
    calcAckermann(ack, m, n);
    -- end timer
    endTime:= Clock;
    seconds:= (endTime - startTime);
    put("Ackermann is: ");
    put(ack, width=>1); new_line;
    put_line("Runtime = " & Duration'Image(seconds) & " seconds.");
end ackermann;

