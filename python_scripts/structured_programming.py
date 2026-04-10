# Game of Life Interactive Driver
# 20 March 2026
# Sof Antelo

#################################
#FUNCTION ONE: INNIT
def init(dimx, dimy):

    import numpy as np

    cells = np.zeros((dimy, dimx), dtype=int)

    pattern = np.array([
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0],
        [1,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [1,1,0,0,0,0,0,0,0,0,1,0,0,0,1,0,1,1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    ])

    pos = (3,3)

    cells[pos[0]:pos[0]+pattern.shape[0],
          pos[1]:pos[1]+pattern.shape[1]] = pattern

    return cells

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

#################################
#FUNCTION FOUR: MOUSE_TO_CELL
def mouse_to_cell(pos, cellsize):
    """Convert mouse pixel position to grid row, col"""
    x, y = pos
    col = x // cellsize
    row = y // cellsize
    return row, col



##################################
#DRIVER SCRIPT
##################################

# import libraries
import pygame
import numpy as np
import sys

# import functions
from functions.draw import draw
from functions.init import init
from functions.mouse import mouse_to_cell
from functions.update import update_fast


# some global variables to declare 
col_background = (10,10,40)
col_grid = (30,30,60)

# main driver function
def main(dimx, dimy, cellsize):

    pygame.init()
    surface = pygame.display.set_mode((dimx*cellsize, dimy*cellsize))
    pygame.display.set_caption("Game of Life")
    clock = pygame.time.Clock()

    cells = init(dimx, dimy)

    running = False   # simulation running or paused
    step = False      # single-step flag
    done = False      # loop control

    while not done:

        for event in pygame.event.get():

            if event.type == pygame.QUIT:
                done = True

            if event.type == pygame.KEYDOWN:

                if event.key == pygame.K_ESCAPE:
                    done = True           # safe quit

                if event.key == pygame.K_SPACE:
                    running = not running  # toggle pause/run

                if event.key == pygame.K_s:
                    step = True           # single-step one generation

                if event.key == pygame.K_c:
                    cells = np.zeros_like(cells)  # clear grid

            # --- MOUSE EVENTS ---
            if event.type == pygame.MOUSEBUTTONDOWN:
                row, col = mouse_to_cell(event.pos, cellsize)

                if event.button == 1:   # left click → add cell
                    cells[row, col] = 1

                elif event.button == 3: # right click → remove cell
                    cells[row, col] = 0

        # draw background
        surface.fill(col_grid)

        # update grid if running or stepping
        if running or step:
            cells = update_fast(cells)
            step = False  # reset step flag after update

        # draw alive cells
        draw(surface, cells, cellsize)

        # update display and control framerate
        pygame.display.update()
        clock.tick(20)   # ~20 FPS for smooth animation

    # clean exit
    pygame.quit()
    pygame.display.quit()


# run main
if __name__ == "__main__":
    main(100,70,8)