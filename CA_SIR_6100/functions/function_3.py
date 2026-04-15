#################################
#FUNCTION THREE: UPDATE_FAST
def update_fast(cells):
    """Vectorized Game of Life update"""

    import numpy as np
    
    neighbors = (
        np.roll(np.roll(cells, 1, 0), 1, 1) +
        np.roll(np.roll(cells, 1, 0), 0, 1) +
        np.roll(np.roll(cells, 1, 0), -1, 1) +
        np.roll(np.roll(cells, 0, 0), 1, 1) +
        np.roll(np.roll(cells, 0, 0), -1, 1) +
        np.roll(np.roll(cells, -1, 0), 1, 1) +
        np.roll(np.roll(cells, -1, 0), 0, 1) +
        np.roll(np.roll(cells, -1, 0), -1, 1)
    )

    birth = (neighbors == 3) & (cells == 0)
    survive = ((neighbors == 2) | (neighbors == 3)) & (cells == 1)

    return np.where(birth | survive, 1, 0)