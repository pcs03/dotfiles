#!/usr/bin/env python3

import mimetypes
import os
import argparse

"""
This script recursively works through a directory and replaces the created property with the updated property for each photo/video file.
"""

def update_timestamp_for_file(filepath: str, allowed_mime_types: list[str] = ["image", "video"]):

    if not os.path.isfile(filepath):
        raise OSError(f"No such file or directory: {filepath}")

    mime_type, _ = mimetypes.guess_type(filepath)

    if not mime_type or not any(mime_type.startswith(t) for t in allowed_mime_types):
        print(f"Skipped (not image/video): {filepath}")
        return

    mod_time = os.path.getmtime(filepath)

    print(filepath)
    print(mod_time)


def update_timestamps(directory: str):
    for root, dirs, files in os.walk(directory):
        for file in files:
            filepath = os.path.join(root, file)
            update_timestamp_for_file(filepath)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Replace creation date with modified date for all videos/images in a directory")
    parser.add_argument("directory", type=str, help="The input directory of photos and videos")
    args = parser.parse_args()

    input_dir = args.directory

    if not os.path.isdir(input_dir):
        raise OSError(f"No such file or directory: {input_dir}")


    update_timestamps(input_dir)

    



