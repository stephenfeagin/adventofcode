from __future__ import annotations
from collections import defaultdict
from dataclasses import dataclass
from typing import DefaultDict, Dict, List, Set, Union
import unittest


@dataclass(frozen=True)
class Point:
    """
    Class for dealing with points in a Cartesian plane. Provides functions for
    calculating Manhattan distances and finding the nearest point based on
    Manhattan distance.
    """

    x: int
    y: int

    def get_distance(self, other: Point) -> int:
        """Calculates the Manhattan distance to another point"""
        x_dist = abs(self.x - other.x)
        y_dist = abs(self.y - other.y)
        return x_dist + y_dist

    def find_nearest_point(self, points: List[Point]) -> Union[Point, None]:
        """
        Returns a Point that is the closest to self, measured by Manhattan
        distance. If two or more points are equally close, return None.
        """
        distances: DefaultDict[int, List[Point]] = defaultdict(list)

        for pt in points:
            dist = self.get_distance(pt)
            distances[dist].append(pt)

        nearest = distances[min(distances.keys())]
        if len(nearest) > 1:
            return None
        else:
            return nearest[0]


def read_input(fname: str) -> List[Point]:
    results: List[Point] = []
    with open(fname, "r") as f:
        for line in f:
            pair = [int(string) for string in line.split(",")]
            results.append(Point(*pair))

    return results


def define_canvas(points: List[Point]) -> Set[Point]:
    """
    Returns the set of all points in a plane bounded by the provided points
    """
    max_x: int = max(pt.x for pt in points)
    min_x: int = min(pt.x for pt in points)
    max_y: int = max(pt.y for pt in points)
    min_y: int = min(pt.y for pt in points)

    return set(
        Point(x, y) for x in range(min_x, max_x + 1) for y in range(min_y, max_y + 1)
    )


def part_1(points: List[Point]) -> int:
    # Get the canvas that we're working with. This helps to eliminate points
    # with non-finite areas
    canvas = define_canvas(points)

    # Make a default dict to keep track of the areas of the points
    pt_areas: DefaultDict[Point, int] = defaultdict(int)

    for pt in canvas:
        nearest = pt.find_nearest_point(points)
        if nearest is not None:
            pt_areas[nearest] += 1
    return max(pt_areas.values())


def part_2(points: List[Point], limit: int) -> int:
    # Again, get the canvas
    canvas = define_canvas(points)

    # Initialize an accumulator variable
    area = 0

    # For each point in canvas acting as an origin, if the sum of the distances
    # to all other points is less than `limit`, add one to `area`
    # This takes advantage of using int(True) == 1
    for origin in canvas:
        area += sum(origin.get_distance(pt) for pt in points) < limit

    return area


if __name__ == "__main__":
    points = read_input("input.txt")
    print("Part 1:", part_1(points))
    print("Part 2:", part_2(points, 10000))
