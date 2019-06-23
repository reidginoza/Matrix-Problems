
"""
Skew-symmetric nxn Matrices with entries drawn from {-1, 0, 1}
(n^2-n)/2 degrees of freedom, zeros on the diagonal
Start with an nxn Matrix
Fill in upper triangle with the number from the list, including the diagonal

For a given n, there are 3^((n^2-n)/2) possible matrices
"""

load("Matrix_Support.sage")


def skew_symmetric_from_upper_triangle(n, number_list):
    """
    
    :param n: n is the size of the matrix
    :param number_list: is the list used to generate the matrix
    """
    
    total = (n^2-n)/2
    
    assert len(number_list) == total
    
    m = matrix(n)
    
    # c indexes rows, d indexes columns
    entries_placed = 0
    
    for c in range(n):
        for d in range(n):
            if c < d:
                m[c, d] = number_list[entries_placed]
                m[d, c] = -m[c, d]
                entries_placed += 1
    return m


def list_of_skew_symmetric_matrices(n, elements):
    results = []
    length = (n^2-n)/2
    total = len(elements)^length
    
    for c in range(total):
        number_list = convert_to_sign_matrix_list(c, length, elements)
        m = skew_symmetric_from_upper_triangle(n, number_list)
        results.append(m)
    return results
