SUBROUTINE JCLARK (DS,DL,TL,KERF,V)
!*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
! THIS SUBROUTINE WAS WRITTEN BY J.E.BRICKELL OF THE U.S.FOREST SERVICE
!TO CALCULATE BOARD FOOT VOLUME OF SAWLOGS BY THE INTERNATIONAL RULE.
!VARIABLES IN THE CALLING SEQUENCE ARE:
!      DS   = LOG’S SCALING DIAMETER (INCHES)
!      DL   = DIB AT LOG’S LARGE END (INCHES) (0.0 IF 1/2 INCH TAPER)
!      TL   = TOTAL LOG LENGTH (FEET)
!      KERF >0 IF KERF ASSUMPTION IS 1/4 INCH
!      KERF <0, OR = 0, IF KERF ASSUMPTION IS 1/8 INCH
!      V    = LOG VOLUME RETURNED TO THE CALLING PROGRAM
!*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*
V=0.0
!IF TOTAL LOG LENGTH IS LESS THAN FOUR FEET NO BOARD FOOT VOLUME WILL BE
!COMPUTED.
IF(TL-4.0)10,1,1
!IF THE LOG’S LARGE END DIAMETER IS FURNISHED TO JCLARK A TAPER RATE
!WILL BE COMPUTED. IF DL=0 THE STANDARD ASSUMPTION OF 1/2 INCH PER 4
!FEET OF LOG LENGTH WILL BE USED.
1 IF(DL)3,3,2
2 T=4.0*(DL-DS)/TL
GO TO 4
3 T=0.5
!THE FOLLOWING LOOP (THROUGH STATEMENT 5) FINDS OUT HOW MANY FULL 4
!FOOT SEGMENTS THE LOG CONTAINS.
4 DO 5 I=1,20
IF(TL-FLOAT(4*I))6,5,5
5 CONTINUE
6 L=I-1
SL=FLOAT(4*L)
!THE FOLLOWING STATEMENT MOVES THE SCALING DIAMETER DOWN TO THE END OF
!THE 4 FOOT SEGMENTS AND INCREASES IT ACCORDING TO TAPER.
D=DS+(T/4.0)*(TL-SL)
!THE FOLLOWING LOOP (THROUGH STATEMENT 7) FINDS OUT HOW MANY FULL FEET
!OF LENGTH ARE IN THE SEGMENT LESS THAN 4 FEET LONG.
DO 7 I=1,4
XI=FLOAT(I)
IF(SL-TL+XI)7,7,8
7 CONTINUE
!THE NEXT THREE STATEMENTS CALCULATE LOG VOLUME IN THE 1, 2, OR 3 FOOT
!SEGMENT AT THE SMALL END OF THE LOG.
8 XL=XI-1.0
DEX=DS+(T/4.0)*(TL-SL-XL)
VADD=0.055*XL*DEX*DEX-0.1775*XL*DEX
!THE FOLLOWING LOOP (THROUGH 9) CALCULATES VOLUME IN THE PORTION OF
!THE LOG CONTAINING WHOLE 4 FOOT SEGMENTS.
DO 9 I=1,L
DC=D+T*FLOAT(I-1)
9 V=V+0.22*DC*DC-0.71*DC
V=V+VADD
!IF ‘KERF’ IS GREATER THAN ZERO, INTERNATIONAL 1/8 INCH VOLUME AS
!COMPUTED ABOVE WILL BE CONVERTED TO INTERNATIONAL 1/4 INCH VOLUME.
IF (KERF)10,10,11
10 RETURN
11 V=0.905*V
RETURN
END

subroutine getLOGdata(diameterSmall, diameterLarge, totalLen, KERF)

implicit none

real, intent(out) :: diameterSmall, diameterLarge, totalLen
integer, intent(out) :: KERF

write(*,*) 'enter small diameter, large diameter, total length and KERF'
read(*,*) diameterSmall, diameterLarge, totalLen, KERF

end subroutine getLOGdata


subroutine calcLOGvolume(diameterSmall, diameterLarge, totalLen, volume)

implicit none

real, intent(in) :: diameterSmall, diameterLarge, totalLen
real, intent(out) :: volume
real :: mRadSmall, mRadLarge, mLen
real :: pi = 3.14159265

mRadSmall = (diameterSmall / 39.37) / 2.0

if (diameterLarge == 0.0) then
    mRadLarge = ((diameterSmall + (floor(totalLen / 4.0) * .5)) / 39.37) / 2.0
else
    mRadLarge = (diameterLarge / 39.37) / 2.0
end if
mLen = totalLen / 3.2808

volume = (((pi * mRadLarge * mRadLarge) + (pi * mRadSmall * mRadSmall)) / 2) * mLen

end subroutine calcLOGvolume

PROGRAM logs
character :: c = 'y'
real :: DS, DL, TL, V
integer :: KERF
do
    call getLOGdata(DS, DL, TL, KERF)
    call JCLARK(DS, DL, TL, KERF, V)
    write(*,*) V
    call calcLOGvolume(DS, DL, TL, V)
    write(*,*) 'volume is ', V
    write(*,*) 'do you want to go again?(y/n)'
    read(*,*) c
    if (c == 'n') exit
end do
END
