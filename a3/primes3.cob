identification division.
program-id. primes3.
environment division.
input-output section.
file-control.
select INPUT-FILE assign to dynamic infile-name
ORGANIZATION IS LINE SEQUENTIAL.
select OUTPUT-FILE assign to dynamic outfile-name
ORGANIZATION IS LINE SEQUENTIAL.
data division.
file section.
fd OUTPUT-FILE.
01 OUT-LINE PICTURE X(81).
WORKING-STORAGE SECTION.
77  N  PICTURE S9(9).
77  R  PICTURE S9(9) USAGE IS COMPUTATIONAL.
77  I  PICTURE S9(9) USAGE IS COMPUTATIONAL.
77  userChoice PICTURE 99.
77  isFinished PICTURE 99.
77  innerLoopDone PICTURE 99.
77  infile-name PICTURE x(81).
77  outfile-name PICTURE x(81).
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
    move 0 to isFinished.
    display 'Do you want to enter primes(1) or enter file names(2)'.
    ACCEPT userChoice FROM SYSIN.
    if userChoice > 2
        move 1 to isFinished
        display 'Error, enter a valid number'
    end-if.
    if userChoice < 1
        move 1 to isFinished
        display 'Error, enter a valid number'
    end-if.
    if userChoice = 2
        display 'Enter an input file'
        accept infile-name from SYSIN
        display 'Enter an output file'
        accept outfile-name from SYSIN
        OPEN INPUT INPUT-FILE, OUTPUT OUTPUT-FILE
        WRITE OUT-LINE FROM TITLE-LINE AFTER ADVANCING 0 LINES
        WRITE OUT-LINE FROM UNDER-LINE AFTER ADVANCING 1 LINE
    end-if.
    
    perform until isFinished = 1
        if userChoice = 2
            read INPUT-FILE into IN-CARD at end move 1 to isFinished
        else
            display 'Enter a number (0 to exit)'
            accept IN-N from SYSIN
            if IN-N = 0
                move 1 to isFinished
                continue
            end-if
        end-if
        MOVE IN-N TO N
        if N = 0
            exit perform
        end-if
        display N
        if N > 1
            if N < 4
                MOVE IN-N TO OUT-N-3
                if userChoice = 2
                    WRITE OUT-LINE FROM PRIME-LINE AFTER ADVANCING 1 LINE
                else
                    display PRIME-LINE
                end-if
                continue
            else
                move 2 to R
                move 0 to innerLoopDone
                perform until innerLoopDone = 1
                    DIVIDE R INTO N GIVING I
                    MULTIPLY R BY I
                    if I is not equal to N
                        add 1 to R
                        if R < N 
                            continue
                        else
                            move IN-N to OUT-N-3
                            if userChoice = 2
                                WRITE OUT-LINE FROM PRIME-LINE AFTER ADVANCING 1 LINE
                            else
                                display PRIME-LINE
                            end-if
                            move 1 to innerLoopDone
                        end-if
                    else
                        MOVE IN-N TO OUT-N-2
                        if userChoice = 2
                            WRITE OUT-LINE FROM NOT-A-PRIME-LINE AFTER ADVANCING 1 LINE
                        else
                            display NOT-A-PRIME-LINE
                        end-if
                        move 1 to innerLoopDone
                    end-if
                end-perform
                continue
            end-if
        else
            MOVE IN-N TO OUT-N
            if userChoice = 2
                WRITE OUT-LINE FROM ERROR-MESS AFTER ADVANCING 1 LINE
            else
                display ERROR-MESS
            end-if
        end-if
    end-perform.
    if userChoice = 2    
        CLOSE INPUT-FILE, OUTPUT-FILE
    end-if.
    STOP RUN.