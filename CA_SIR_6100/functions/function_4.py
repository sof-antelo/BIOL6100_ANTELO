#FUNCTION FOUR: MOUSE_TO_CELL
def mouse_to_cell(pos, cellsize):
    """Convert mouse pixel position to grid row, col"""
    x, y = pos
    col = x // cellsize
    row = y // cellsize
    return row, col