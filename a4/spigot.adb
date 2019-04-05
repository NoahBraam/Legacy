with ada.Text_IO; use Ada.Text_IO;
with ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure spigot is
    buffer: String (1..100);
    last: Natural;
    n : constant Integer := 1000;
    len : constant Integer := 10*n /3;
    i, j, k, q, x, nines, predigit : Integer;
    subtype int_range is Integer range 1..len;
    type LongArray is array(int_range) of Long_integer;
    a : LongArray;
    outFile: File_Type;
begin
    put("Enter an output file: ");
    get_line(buffer, last);
    Create(outFile, Out_File, buffer);
    i:=0;
    for i in int_range loop
        a(i) := Long_Integer(2);
    end loop;
    nines:=0;
    predigit:=0;
    for j in 1..n loop
        q:=0;
        for i in reverse 1..len loop
            x:= 10*Integer(a(i)) + q*i;
            a(i) := Long_Integer(x mod (2*i-1));
            q := x / (2*i-1);
        end loop;
        a(1) := Long_Integer(q mod 10);
        q := q/10;
        if q = 9 then
            nines:= nines+1;
        elsif q = 10 then
            put(outFile, predigit + 1, width=>1);
            for k in 1..nines loop
                put(outFile, 0, width=>1);
            end loop;
            predigit:= 0;
            nines:= 0;
        else
            put(outFile, predigit, width=>1);
            predigit:=q;
            if nines /= 0 then
                for k in 1..nines loop
                    put(outFile, 9, width=>1);
                end loop;
                nines := 0;
            end if;
        end if;
    end loop;
    put(outFile, predigit, width=>1);
    Close(outFile);
end spigot;
