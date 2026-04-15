##################################
#FUNCTION TWO: DRAW
def draw(surface, cells, cellsize):
    import numpy as np
    import pygame

    alive_cells = np.argwhere(cells == 1)

    col_alive = (255,255,215)

    for r, c in alive_cells:
        pygame.draw.rect(surface, col_alive,
                         (c*cellsize, r*cellsize, cellsize-1, cellsize-1))