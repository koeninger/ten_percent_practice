#!/usr/bin/env python

import media
import fresh_tomatoes

toy_story = media.Movie('Toy Story', 'A story of a boy and his toys.', 'http://upload.wikimedia.org/wikipedia/en/1/13/Toy_Story.jpg', 'https://www.youtube.com/watch?v=vwyZH85NQC4')
avatar = media.Movie('Avatar', 'A marine on an alien planet.', 'upload.wikimedia.org/wikipedia/id/b/b0/Avatar-Teaser-Poster.jpg', 'http://www.youtube.com/watch?v=-9ceBgWV8io')

movies = [ toy_story, avatar ]

# avatar.show_trailer()

# print toy_story.storyline
# print avatar.storyline

fresh_tomatoes.open_movies_page(movies)
