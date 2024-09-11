#|/usr/bin/env python3

import os
import sys
import subprocess
import argparse
import shutil

def print_green(string: str):
    print(f"\033[32m{string}\033[0m")

def print_yellow(string: str):
    print(f"\033[33m{string}\033[0m")

def print_red(string: str):
    print(f"\033[31m{string}\033[0m")

def get_video_length(filepath: str) -> float:
    """
    Gets the length of an mp4 file using ffmpeg in subprocess.
    Returns -1 if not succesful.
    """

    result = subprocess.run(
        [
            "ffprobe",
            "-v",
            "error",
            "-show_entries",
            "format=duration",
            "-of",
            "default=noprint_wrappers=1:nokey=1",
            filepath,
        ],
        stdout=subprocess.PIPE,
        text=True,
    )

    output = result.stdout.strip()

    try:
        video_len = float(output)
    except ValueError:
        print("Error: cannot convert video length to float")
        return -1

    return video_len

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Perform file operation on mp4's in a dir depending on its length.")
    parser.add_argument("--seconds", type=int, required=True, help="Number of seconds that the mp4 has to be.")
    parser.add_argument("--mode", type=str, required=True, choices=["delete", "move"], help="Operation mode: delete or move")
    parser.add_argument("--target-dir", type=str, help="Target dir in case of move operation.")

    parser.add_argument("source_dir", type=str, help="Directory containing mp4 files.")

    args = parser.parse_args()

    if args.mode == "move" and not args.target_dir:
        print("Error: --target-path is required when mode is move.")
        sys.exit(1)

    if args.mode == "move" and not os.path.isdir(args.target_dir):
        print("Error: target directory is not a valid directory.")

    if not os.path.isdir(args.source_dir):
        print("Error: source directory is not a valid directory.")

    video_dir = args.source_dir

    for file in os.listdir(video_dir):
        filepath = os.path.join(video_dir, file)

        if not filepath.endswith(".mp4"):
            print(f"File '{filepath} is not .mp4. Skipping.")
            continue

        video_len = get_video_length(filepath)

        if video_len == -1:
            print(f"Invalid video_len for '{filepath}. Skipping.")
            continue

        if video_len > args.seconds:
            print_green(f"{video_len} s. Keeping {file}")
            continue

        if args.mode == "move":
            print_yellow(f"{video_len} s. Moving {file}")
            shutil.move(filepath, args.target_dir)

        if args.mode == "delete":
            print_red(f"{video_len} s. Deleting {file}")
            os.remove(filepath)
