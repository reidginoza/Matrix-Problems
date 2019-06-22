"""
support functions for matrix problems
"""

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