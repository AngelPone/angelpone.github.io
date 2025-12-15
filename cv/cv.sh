#!/bin/bash
mkdir -p ./.quarto/cv
quarto inspect > ./.quarto/cv/inspect.json
uv run cv/cv.py
typst compile cv/cv.typ --root ./
