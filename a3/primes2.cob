*> Primes program part 2
*> This program computes if a number is prime or not.
*> Noah Braam
*> 0960202

identification division.
    program-id. primes2.
environment division.
input-output section.
    file-control.
        select INPUT-FILE assign to 'primes.dat'
        ORGANIZATION IS LINE SEQUENTIAL.
        select OUTPUT-FILE assign to 'out.dat'
        ORGANIZATION IS LINE SEQUENTIAL.
data division.
    file section.
        fd OUTPUT-FILE.
        01 OUT-LINE PICTURE X(81).
WORKING-STORAGE SECTION.
77  N  PICTURE S9(9).
77  R  PICTURE S9(9) USAGE IS COMPUTATIONAL.
77  I  PICTURE S9(9) USAGE IS COMPUTATIONAL.
77  isFinished PICTURE 99.
77  innerLoopDone PICTURE 99.
01  IN-CARD.
    02 IN-N   PICTURE 9(9).
    02 FILLER PICTURE X(71).
01  TITLE-LINE.
    02 FILLER PICTURE X(6) VALUE SPACES.
    02 FILLER PICTURE X(20) VALUE 'PRIME NUMBER RESULTS'.
01  UNDER-LINE.
    02 FILLER PICTURE X(32) VALUE
           ' -------------------------------'.
01  NOT-A-PRIME-LINE.
    02 FILLER PICTURE X VALUE SPACE.
    02 OUT-N-2 PICTURE Z(8)9.
    02 FILLER PICTURE X(15) VALUE ' IS NOT A PRIME'.
01  PRIME-LINE.
    02 FILLER PICTURE X VALUE SPACE.
    02 OUT-N-3 PICTURE Z(8)9.
    02 FILLER PICTURE X(11) VALUE ' IS A PRIME'.
01  ERROR-MESS.
    02 FILLER PICTURE X VALUE SPACE.
    02 OUT-N PICTURE Z(8)9.
    02 FILLER PICTURE X(14) VALUE ' ILLEGAL INPUT'.

PROCEDURE DIVISION.
    *> Open and read files.
    OPEN INPUT INPUT-FILE, OUTPUT OUTPUT-FILE.
    WRITE OUT-LINE FROM TITLE-LINE AFTER ADVANCING 0 LINES.
    WRITE OUT-LINE FROM UNDER-LINE AFTER ADVANCING 1 LINE.
    move 0 to isFinished.
    perform until isFinished = 1
        *> Read in the file until EOF
        read INPUT-FILE into IN-CARD 
            at end move 1 to isFinished
            not at end
        MOVE IN-N TO N
        *> Show value of N
        display N
        if N > 1
            if N < 4
                *> Prime number, continue to next number. 
                MOVE IN-N TO OUT-N-3
                WRITE OUT-LINE FROM PRIME-LINE AFTER ADVANCING 1 LINE
                continue
            else
                move 2 to R
                move 0 to innerLoopDone
                perform until innerLoopDone = 1
                    compute I=N/R
                    MULTIPLY R BY I
                    if I is not equal to N
                        compute R = R + 1
                        if R < N
                            *> Not done, keep doing inner loop 
                            continue
                        else
                            *> Prime number, yay!
                            move IN-N to OUT-N-3
                            WRITE OUT-LINE FROM PRIME-LINE AFTER ADVANCING 1 LINE
                            move 1 to innerLoopDone
                        end-if
                    else
                        *> Not a prime number
                        MOVE IN-N TO OUT-N-2
                        WRITE OUT-LINE FROM NOT-A-PRIME-LINE AFTER ADVANCING 1 LINE
                        move 1 to innerLoopDone
                    end-if
                end-perform
                continue
            end-if
        else
            *> Error!
            MOVE IN-N TO OUT-N
            WRITE OUT-LINE FROM ERROR-MESS AFTER ADVANCING 1 LINE
        end-if
    end-perform.
    CLOSE INPUT-FILE, OUTPUT-FILE.
    STOP RUN.