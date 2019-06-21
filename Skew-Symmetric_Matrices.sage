"""
Skew-symmetric nxn Matrices with entries drawn from {-1, 0, 1}
n*(n-1)/2 degrees of freedom, zeros on the diagonal
Start with an nxn Matrix
Fill in upper triangle with the number from the list, including the diagonal

For a given n, there are 3^(n*(n-1)/2) possible matrices
"""

def convert_to_sign_matrix_list(num, length, elements = Set([-1,0,1])):
    # num is the number to convert, is a set or list of entries to use
    # returns a list/vector whose elements are the digits of the number
    
    # verify using Sage's Integer type, instead of Python's int type
    num = Integer(num)
    
    s = num.str(base = len(elements))
    # has 0, 1, ... (base - 1) entries
    # will use as index for entries set/list
    
    # 
    digits = len(s)
    
    number_list = []
    
    # Fill in leading zeroes
    lead = length - digits
    
    for c in range(lead):
        number_list.append(Integer(elements[0]))
    
    for c in range(digits):
        number_list.append(Integer(elements[Integer(s[c])]))
    
    return number_list


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
