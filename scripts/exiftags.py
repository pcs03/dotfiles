#!/usr/bin/env python3

import subprocess
import mimetypes
import re
import os
import argparse

"""
This script recursively works through a directory and add tags based on the directory names for each photo/video file.

This script can be sped up by properly applying async operations for writing exif tags
"""

DIRECTORY_DATE_PATTERNS = [
    r"\b\d{4}\b",  # Matches a year (e.g., 2020)
    r"\b\d{4}-\d{2}\b",  # Matches year-month (e.g., 2020-01)
    r"\b\d{4}-\d{1}\b",  # Matches year-month with single digit month (e.g., 2020-1)
    r"\b\d{2}-\d{4}\b",  # Matches month-year (e.g., 01-2020)
    r"\b\d{1}-\d{4}\b",  # Matches single digit month-year (e.g., 1-2020)
    r"\b\d{2}\b",  # Matches just a month (e.g., 01, 02, 12)
    r"\b-\d{4}\b",  # Matches a year with a leading hyphen (e.g., -1980)
    r"\b\d{4}-\d{4}\b",  # Matches year range (e.g., 1995-2001)
]

DATE_REGEX = "(" + ")|(".join(DIRECTORY_DATE_PATTERNS) + ")"


def is_date_directory(dirname: str):
    if re.match(DATE_REGEX, dirname):
        return True
    return False


def format_tag(tag: str):
    return tag.capitalize()


def get_tags_from_path(path: str):
    tags = []
    while True:
        path, dirname = os.path.split(path)
        if dirname == "" or dirname == "/":
            break
        if not is_date_directory(dirname):
            tags.append(format_tag(dirname))
    tags.reverse()
    return tags


def negate_paths(root_path: str, nested_path: str):
    if not nested_path.startswith(root_path):
        raise ValueError(f"Paths don't match: {root_path}, {nested_path}")

    return nested_path[len(root_path) :]


def set_exif_tags(path: str, tags: list[str], allowed_mime_types: list[str] = ["image", "video"]):
    if not os.path.isfile(path):
        raise OSError(f"No such file or directory: {path}")

    mime_type, _ = mimetypes.guess_type(path)

    if not mime_type or not any(mime_type.startswith(t) for t in allowed_mime_types):
        print(f"Skipped (not image/video): {path}")
        return

    tag_arguments = ["-Keywords={}".format(tag) for tag in tags]

    command = [
        "exiftool",
        *tag_arguments,
        "-overwrite_original_in_place",
        path,
    ]

    subprocess.run(command)


def add_tags(input_directory: str):
    for root, dirs, files in os.walk(input_directory):
        relative_path_to_input = negate_paths(input_directory, root)

        tags = get_tags_from_path(relative_path_to_input)

        print()
        print("=======================================================================")
        print(relative_path_to_input)
        print(tags)


        if not tags:
            continue

        for file in files:
            filepath = os.path.join(root, file)
            set_exif_tags(filepath, tags)

        # for file in files:
        #     filepath = os.path.join(root, file)
        #     update_timestamp_for_file(filepath)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Replace creation date with modified date for all videos/images in a directory"
    )
    parser.add_argument("directory", type=str, help="The input directory of photos and videos")
    args = parser.parse_args()

    input_dir = args.directory

    if not os.path.isdir(input_dir):
        raise OSError(f"No such file or directory: {input_dir}")

    print(input_dir)

    add_tags(input_dir)
