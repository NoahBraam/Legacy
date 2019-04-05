program spigot
    implicit none
    integer :: n = 1000
    integer :: len = 3333
    integer, dimension (1:3333) :: a
    integer :: i, j, k, q, x, nines, predigit

    character(100) :: line

    write(*,'("Enter a file for output: ")')
    read(*,'(A)') line
    open (unit=20,file=line,action="write",status="replace")
    do i = 1, len
        a (i) = 2
    end do
    nines = 0
    predigit = 0

    do j = 1, n
        q = 0
        do i = len, 1, -1
            x = 10*a (i) + q*i
            a(i) = mod(x,2*i -1)
            q = x / (2*i - 1)
        end do
        a (1) = mod(q, 10)
        q = q/10
        if (q == 9) then
            nines = nines+1
        else if (q == 10) then
            write(20, '(A)', advance='no') predigit+1
            do k = 1, nines
                write(20, '(A)', advance='no') 0
            end do
            predigit = 0
            nines = 0
        else
            write(20, '(A)', advance='no') predigit
            predigit = q
            if (nines /= 0) then
                do k = 1, nines
                    write(20, '(A)', advance='no') 9
                end do
                nines = 0
            end if
        end if
    end do
    write(20, '(A)', advance='no') predigit
    close(20)
end