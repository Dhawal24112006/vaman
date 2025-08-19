#!/bin/bash
# Build script for Vaman FPGA digital clock

echo "Building digital clock for Vaman FPGA..."
echo "Cleaning previous builds..."

# Clean previous builds
rm -f *.bin *.json *.log

echo "Compiling using ql_symbiflow..."

# Compile using ql_symbiflow
ql_symbiflow -compile -src . -d ql-eos-s3 -P pu64 -t main -v main.v -p quickfeather.pcf

# Check if build was successful
if [ -f "main.bin" ]; then
    echo "Build successful! main.bin generated."
    echo "To flash to Vaman board, run:"
    echo "sudo python3 tinyfpgab --port /dev/ttyACM0 --appfpga main.bin --mode fpga --reset"
else
    echo "Build failed! Check for errors above."
    exit 1
fi
