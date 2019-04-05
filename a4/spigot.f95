program spigot
    implicit none
    integer :: n = 1000
    integer :: len = 3333
    integer, dimension (1:3333) :: a
    integer :: i, j, k, q, x, nines, predigit

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
            ! write
            do k = 1, nines
                !write
            end do
            predigit = 0
            nines = 0
        else
            !write
            predigit = 1
            if (nines /= 0) then
                do k = 1, nines
                    ! write 9
                end do
                nines = 0
            end if
        end if
    end do
    !write again
end