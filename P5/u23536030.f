C      Instructions to Compile and Run:
C      1. Open your terminal in the folder containing this file.
C      2. Compile using: gfortran -ffixed-form u23536030.f -o u23536030
C      3. Run the executable using: ./u23536030

      PROGRAM stats_measure
      REAL data_arr(5)
      REAL mode_val, mean_val, median_val

C     Call the readData subroutine (passed by reference)
      CALL readData(data_arr)

C     Calculate statistics using subprograms
      mean_val = findMean(data_arr)
      median_val = findMedian(data_arr)
      mode_val = findMode(data_arr)

C     Output results
      PRINT *, 'Mean:  ', mean_val
      PRINT *, 'Median:', median_val
      PRINT *, 'Mode:  ', mode_val

      END PROGRAM stats_measure

C     Subroutine to read data (equivalent to void readData)
      SUBROUTINE readData(arr)
      REAL arr(5)
      INTEGER i
      DO i = 1, 5
        WRITE(*,*) 'Enter value ', i, ':'
        READ(*,*) arr(i)
      END DO
      END SUBROUTINE readData

C     Function to find the Mean
      REAL FUNCTION findMean(arr)
      REAL arr(5)
      REAL total
      INTEGER i
      total = 0.0
      DO i = 1, 5
        total = total + arr(i)
      END DO
      findMean = total / 5.0
      END FUNCTION findMean

C     Function to find the Median (Sorts first)
      REAL FUNCTION findMedian(arr)
      REAL arr(5), temp_arr(5), temp
      INTEGER i, j
C     Copy array to avoid modifying original
      DO i = 1, 5
        temp_arr(i) = arr(i)
      END DO
C     Simple Bubble Sort
      DO i = 1, 4
        DO j = i + 1, 5
          IF (temp_arr(i) > temp_arr(j)) THEN
            temp = temp_arr(i)
            temp_arr(i) = temp_arr(j)
            temp_arr(j) = temp
          END IF
        END DO
      END DO
C     Middle value of 5 elements is at index 3
      findMedian = temp_arr(3)
      END FUNCTION findMedian

C     Function to find the Mode
      REAL FUNCTION findMode(arr)
      REAL arr(5), current_val, mode_candidate
      INTEGER i, j, count, max_count
      max_count = 0
      mode_candidate = arr(1)
      DO i = 1, 5
        count = 0
        current_val = arr(i)
        DO j = 1, 5
          IF (arr(j) == current_val) THEN
            count = count + 1
          END IF
        END DO
        IF (count > max_count) THEN
          max_count = count
          mode_candidate = current_val
        END IF
      END DO
      findMode = mode_candidate
      END FUNCTION findMode
