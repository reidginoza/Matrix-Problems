"""
support functions for matrix problems
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
    
    result = []
    
    # Fill in leading zeroes
    lead = length - digits
    
    for c in range(lead):
        result.append(Integer(elements[0]))
    
    for c in range(digits):
        result.append(Integer(elements[Integer(s[c])]))
    
    return result


def matrix_properties_into_string(m, with_inverse = False, with_eigenvalues = True):
    m_string = "Char Poly    "  + str(m.charpoly()) +"\n"
    m_string = m_string + "Eigenvalues\n"
    if with_eigenvalues:
        for ev in m.eigenvalues():
            m_string = m_string + "  " + str(ev) + "\n"
    m_string = m_string + "Min Poly    " + str(m.minpoly()) + "\n"
    m_string = m_string + "Positive definite    " + str(m.is_positive_definite()) + "\n"
    m_string = m_string + "Unitary    " + str(m.is_unitary()) + "\n"
    m_string = m_string + "Trace    " + str(m.trace()) + "\n"
    m_string = m_string + "Determinant    " + str(m.determinant()) + "\n"
    if with_inverse:
        m_string = m_string + "\nInverse\n" + str(m.inverse()) + "\n"
    m_string = m_string + "\n\n"
    return m_string
    
    
def pretty_code_string(matrix):
    string_output = "["
    rows = matrix.nrows()
    cols = matrix.ncols()
    
    # continue here
    
    string_output += "]"
    return