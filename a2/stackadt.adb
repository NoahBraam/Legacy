with Ada.Text_IO; use Ada.Text_IO;
package body stackADT is
    type list is array(1..300000) of natural;
    type int_stack is
        record
            item : list;
            top : natural := 0;
        end record;
    st : int_stack;

    procedure push(x : in natural) is
    begin
        if st.top = 300000 then
            put_line("stack is full");
        else 
            st.top := st.top + 1;
            st.item(st.top) := x;
        end if;
        
    end push;
    
    procedure pop( x : out natural) is
    begin
        if st.top = 0 then
            put_line("stack is empty");
        else
            x := st.item(st.top);
            st.top := st.top - 1;
        end if;
    end pop;
    function stack_is_empty return Boolean is
    begin
        return st.top = 0;
    end stack_is_empty;

    function stack_top return natural is
    begin
        if st.top = 0 then
            put_line("stack is empty");
            return 0;
        else
            return st.item(st.top);
        end if;
    end stack_top;
    
    procedure reset_stack is
    begin
        st.top := 0;
    end reset_stack;
end stackADT;