! ====================================================================
! Noah Braam
! 0960202
! Feb. 1st 2019
! This program allows you to calculate the log volumes of log sizes
! endered by a user.        
! ====================================================================
program logs
    implicit none
    character :: c = 'y'
    real :: DS, DL, TL, V
    integer :: KERF
    do
        call getLOGdata(DS, DL, TL, KERF)
        call calcLOGjclark(DS, DL, TL, KERF, V)
        if (V > 0.0) write(*,'(A, F6.2, A)')' ', V,' board feet'
        call calcLOGvolume(DS, DL, TL, V)
        if (V > 0.0) write(*,'(A, F5.2, A)') ' volume is ',V,'m^3'
        write(*,*) 'do you want to go again?(y/n)'
        read(*,*) c
        if (c == 'n') exit
    end do
end

subroutine calcLOGjclark(diameterSmall, diameterLarge, totalLen, KERF, volume)
!*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
! THIS SUBROUTINE WAS WRITTEN BY J.E.BRICKELL OF THE U.S.FOREST SERVICE
! TO CALCULATE BOARD FOOT VOLUME OF SAWLOGS BY THE INTERNATIONAL RULE.
!
! Subroutine was rewritten by Noah Braam using more modern
! Fortran conventions.
!*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*

    implicit none

    real, intent(in) :: diameterSmall, diameterLarge, totalLen
    integer, intent(in) :: KERF
    real, intent(out) :: volume

    real :: taper, diam, dExtra, extraVol, tempD
    integer :: fullSegments, remainingFeet, i

    volume=0.0

    ! Can't do a length < 4ft
    if (totalLen < 4.0) then
        write(*,*)'Error, log needs to be at least 4ft long'
        return
    end if

    ! Calculate taper rate
    if (diameterLarge <= 0.0) then
        taper = 0.5
    else
        taper = 4.0 * (diameterLarge - diameterSmall) / totalLen
    end if

    ! Find full 4 foot segments and remaining length
    fullSegments = floor(totalLen / 4.0)
    remainingFeet = floor(mod(totalLen, 4.0))

    ! Calculate volume of extra segments of log
    dExtra = diameterSmall + (taper / 4.0) * (totalLen - fullSegments * 4.0 - remainingFeet)
    extraVol = 0.055 * remainingFeet * dExtra ** 2 - 0.1775 * remainingFeet * dExtra

    ! Calculate volume of 4 foot sections
    diam = diameterSmall + (taper/4.0)*(totalLen - (fullSegments * 4.0))
    do i = 0, fullSegments - 1
        tempD = diam + taper*i
        volume = volume + 0.22 * tempD **2 - 0.71 * tempD
    end do

    ! Combine volume of 4ft sections and remaining volume
    volume = volume + extraVol

    ! Change to to 1/4" saw kerf if needed
    if (KERF > 0) volume = 0.905*volume

end subroutine calcLOGjclark


subroutine getLOGdata(diameterSmall, diameterLarge, totalLen, KERF)

    implicit none

    real, intent(out) :: diameterSmall, diameterLarge, totalLen
    integer, intent(out) :: KERF

    ! Reads in user input
    write(*,*) 'enter small diameter (inches)'
    read(*,*) diameterSmall
    write(*,*) 'enter large diameter (0 for 0.5" taper)'
    read(*,*) diameterLarge
    write(*,*) 'enter total length (feet)'
    read(*,*) totalLen
    write(*,*) 'enter KERF'
    read(*,*) KERF


end subroutine getLOGdata


subroutine calcLOGvolume(diameterSmall, diameterLarge, totalLen, volume)

    implicit none

    ! Variable declarations
    real, intent(in) :: diameterSmall, diameterLarge, totalLen
    real, intent(out) :: volume
    real :: mRadSmall, mRadLarge, mLen
    real :: pi = 3.14159265

    ! Radius of small side
    mRadSmall = (diameterSmall / 39.37) / 2.0

    ! Radius of large side
    if (diameterLarge == 0.0) then
        mRadLarge = ((diameterSmall + (floor(totalLen / 4.0) * .5)) / 39.37) / 2.0
    else
        mRadLarge = (diameterLarge / 39.37) / 2.0
    end if

    ! Length in metres
    mLen = totalLen / 3.2808

    ! Volume in m^3
    volume = (((pi * mRadLarge * mRadLarge) + (pi * mRadSmall * mRadSmall)) / 2) * mLen

end subroutine calcLOGvolume
