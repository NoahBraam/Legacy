package stackADT is
    procedure push(x : in natural);
    procedure pop( x : out natural);
    function stack_is_empty return Boolean;
    function stack_top return natural;
    procedure reset_stack;
end stackADT;