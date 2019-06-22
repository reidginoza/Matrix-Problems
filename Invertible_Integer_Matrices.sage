"""
nxn Matrices with entries drawn from {-1, 0, 1}
Start with an nxn Matrix
Fill in upper triangle with the number from the list, including the diagonal

Identifying degrees of freedom for a matrix
For an nxn matrix
n diagonal entries, non-diagonal entries: n^2 - n
Need to fill diagonal plus half of non-diagonal entries
n + (n^2-n)/2 = (n^2+n)/2

For a given n, there are 3^((n^2+n)/2) possible matrices
"""

load("Matrix_Printing.sage")

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
    
    result = []
    
    # Fill in leading zeroes
    lead = length - digits
    
    for c in range(lead):
        result.append(Integer(elements[0]))
    
    for c in range(digits):
        result.append(Integer(elements[Integer(s[c])]))
    
    return result



def symmetric_from_upper_triangle(n, number_list):
    # n is the size of the matrix
    # li is the list with the digits of the number that fills the upper triangle including diagonal
    
    #first fill in leading zeros
    total = (n^2+n)/2
    
    assert len(number_list) == total
    
    m = matrix(n)
    
    entries_placed = 0
    
    # c is rows, d is columns
    
    for c in range(n):
        for d in range(n):
            if c < d:
                # if looking at an upper triangular entry
                m[c,d] = number_list[entries_placed]
                m[d,c] = m[c,d]
                entries_placed = entries_placed + 1
            elif c == d:
                # if looking at a diagonal entry
                m[c,d] = number_list[entries_placed]
                entries_placed = entries_placed + 1
    return m

def list_of_symmetric_matrices_specified_elements(n, elements):
    results = []
    length = (n^2+n)/2
    total = len(elements)^length
    
    for c in range(total):
        number_list = convert_to_sign_matrix_list(c, length, elements)
        m = symmetric_from_upper_triangle(n, number_list)
        results.append(m)
    return results



def file_write_inverses(n, elements, file_str_inverse, file_str_not_int_inverse, file_str_singular):
    # Note to self, define a set like this: Set([-1,0,1])
    file_inverse = open(file_str_inverse, "w+")
    file_inverse.write("Invertible Symmetric Matrices of Size " + str(n) + "\n\n")
    
    file_not_int_inverse = open(file_str_not_int_inverse, "w+")
    file_not_int_inverse.write("Symmetric Matrices With Non-Integer Inverse of Size " + str(n) + "\n\n")
    
    file_singular = open(file_str_singular, "w+")
    file_singular.write("Singular Symmetric Matrices of Size " + str(n) + "\n\n")
    
    matrices_list = list_of_symmetric_matrices_specified_elements(n, elements)
    count_invertible = 0
    count_not_int_inverse = 0
    count_singular = 0
    for m in matrices_list:
        if m.is_invertible():
            # HUGE NOTE: This only checks if the matrix is invertible is in ZZ, the integers.
            # Need to make this clear in the code by declaring Matrix Spaces and Rings
            m_string = "Matrix " + str(count_invertible) + "\n" + str(m) + "\n\n"
            m_string = m_string + matrix_properties_into_string(m, with_inverse = True)
            file_inverse.write(m_string)
            
            if count_invertible % 100 == 0:
                file_inverse.flush()
            # Buffer seems to get large for 5by5 case, so coding in the flush
            
            count_invertible = count_invertible + 1
        elif m.determinant() != 0:
            m_string = "Matrix " + str(count_not_int_inverse) + "\n" + str(m) + "\n\n"
            m_string = m_string + matrix_properties_into_string(m, with_inverse = True)
            file_not_int_inverse.write(m_string)
            
            if count_not_int_inverse % 100 == 0:
                file_not_int_inverse.flush()
            # Buffer seems to get large for 5by5 case, so coding in the flush
            
            count_not_int_inverse = count_not_int_inverse + 1
        else:
            m_string = "Matrix " + str(count_singular)+ "\n" + str(m) + "\n\n"
            m_string = m_string + matrix_properties_into_string(m, with_inverse = False)
            file_singular.write(m_string)
            
            if count_singular % 100 == 0:
                file_singular.flush()
            # Buffer seems to get large for 5by5 case, so coding in the flush
            
            count_singular = count_singular + 1
    
    total_matrices = count_invertible + count_not_int_inverse + count_singular
    
    closing = "Number of Invertible Matrices " + str(count_invertible) + "\n"
    closing = closing + "Number of Symmetric Matrices With Non-Integer Inverse " + str(count_not_int_inverse) + "\n"
    closing = closing + "Number of Singular Matrices " + str(count_singular) + "\n"
    closing = closing + "Total " + str(total_matrices) + "\n"
    
    file_inverse.write(closing)
    file_not_int_inverse.write(closing)
    file_singular.write(closing)
    
    file_inverse.close()
    file_not_int_inverse.close()
    file_singular.close()
    return

def make_outputs(n_range = [2..5], elements = Set([-1, 0, 1])):
    """
    generate the 2x2 to 5x5 cases into .txt files
    """
    for n in n_range:
        file_str_inverse = str(n) + "by" + str(n) + "Invertible.txt"
        file_str_not_int_inverse = str(n) + "by" + str(n) + "NotIntInvertible.txt"
        file_str_singular = str(n) + "by" + str(n) + "Singular.txt"
        
        file_write_inverses(n, elements, file_str_inverse, file_str_not_int_inverse, file_str_singular)
    return

def print_inverses(n, elements):
    ## Used for testing
    matrices_list = list_of_symmetric_matrices_specified_elements(n, elements)
    count_invertible = 0
    count_singular = 0
    for m in matrices_list:
        if m.is_invertible():
            print "Matrix:\n"
            print m
            print "\n"
            print "Inverse \n"
            print m.inverse()
            print "\n\n"
            count_invertible = count_invertible + 1
        else:
            print "Matrix:\n"
            print m
            print "\n"
            print "Singular\n\n"
            count_singular = count_singular + 1
    print "Number of Invertible Matrices: "
    print count_invertible
    print "\n"
    print "Number of Singular Matrices: "
    print count_singular
    print "\n"
    return

def save_matrices(n, elements, file_str_inverse, file_str_not_int_inverse, file_str_singular):
    """
    Create three .sage files that will create variables with a list of 
    the respective types:
    integer invertible, non-integer invertible, singular
    """
    # Note to self, define a set like this: Set([-1,0,1])
    file_inverse = open(file_str_inverse, "w+")
    file_inverse.write("integer_invertible_list = []\n")
    
    file_not_int_inverse = open(file_str_not_int_inverse, "w+")
    file_not_int_inverse.write("non_integer_invertible_list = []\n")
    
    file_singular = open(file_str_singular, "w+")
    file_singular.write("singular_list = []\n")
    
    """
    this is where I need to learn how to print the matrices
    in such a way that it will open as a matrix in a sage interpreter
    """
    
    file_inverse.close()
    file_not_int_inverse.close()
    file_singular.close()
    return
