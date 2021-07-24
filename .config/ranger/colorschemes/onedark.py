from __future__ import (absolute_import, division, print_function)

from ranger.colorschemes.default import Default
from ranger.gui.color import blue, yellow, BRIGHT

class Scheme(Default):
    """(this isn't really onedark, but who's keeping track)"""

    def use(self, ctx):
        fg, bg, attr = super().use(ctx)

        # replace selection highlight with yellow
        if fg == blue + BRIGHT:
            fg = yellow

        return fg, bg, attr
