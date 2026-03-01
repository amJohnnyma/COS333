#!/usr/bin/gawk -f

# cd to dir
#./u23536030.awk input.txt

BEGIN {
    FS = ","
    total_matrix = 0
    max_cols = 0
    num_rows = 0
}

{
    # Update max_cols first so we process all columns in this row
    if (NF > max_cols) {
        max_cols = NF
    }

    num_rows = FNR
    row_sum = 0

    # Process each column up to the widest row seen so far
    for (col = 1; col <= max_cols; col++) {
        val = (col <= NF) ? $col + 0 : 0
        matrix[FNR, col] = val
        row_sum += val
        col_sums[col] += val
        total_matrix += val
    }

    row_sums[FNR] = row_sum
}

END {
    print "========================="
    print "Rectangular matrix totals"
    print "========================="
    print "Input file: " FILENAME

    for (r = 1; r <= num_rows; r++) {
        printf "Total for row %d: %g\n", r, row_sums[r]
    }

    for (c = 1; c <= max_cols; c++) {
        printf "Total for column %d: %g\n", c, col_sums[c]
    }

    printf "Total for entire matrix: %g\n", total_matrix
}